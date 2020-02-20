using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Drawing;
using Telerik.Web.UI;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.IO;
using System.Data.OleDb;
using System.Text;
using System.Reflection;
using System.Net.Mail;

public partial class _Default : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    DataTable dtExcel = new DataTable();

    static string QryString;

    SqlProcsNew sqlobj = new SqlProcsNew();


    protected void Page_Load(object sender, EventArgs e)
    {

        rwPopup.VisibleOnPageLoad = true;
        rwPopup.Visible = false;

        rwImportExcel.VisibleOnPageLoad = true;
        rwImportExcel.Visible = false;

        rwAddDependent.VisibleOnPageLoad = true;
        rwAddDependent.Visible = false;

        if (!IsPostBack)
        {

            Page.Form.Attributes.Add("enctype", "multipart/form-data");

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }


            CheckPermission();

            LoadTitle();

            lnkAddnewCustomer.Visible = true;
            lnkAddnewCustomer.Text = "+ Add a New Profile";
            lnkAddnewCustomer.ToolTip = "Click here to add a new profile.";
            string VALUE = Request.QueryString["id"];
            string VALUE1 = Request.QueryString["id1"];
            string VALUE2 = Request.QueryString["id2"];


            FromDate.DbSelectedDate = DateTime.Now;
            FromDate.MaxDate = DateTime.Now;

            dtpDependentdob.DbSelectedDate = DateTime.Now;
            dtpDependentdob.MaxDate = DateTime.Now;

            Status();
            Gender();
            //SMSAlert();
            //EmailAlert();
            Occupants();

            dtExcel = null;
            if (Request.QueryString["HRName"] != null)
            {
                QryString = Request.QueryString["HRName"].ToString();
                LoadGrid2();
            }
            else
            {
                LoadGrid();
            }

            PnlLevelS.Visible = true;
            lnkAddnewCustomer.Visible = true;
            DateTime Bday = Convert.ToDateTime(("01 / 01 / 1900").ToString());
            //DateTime EndDay = Convert.ToDateTime(("01 / 01 / 2020").ToString());
            // FromDate.MinDate = Bday;
            //FromDate.MaxDate = EndDay;




            //RWStatusCount.VisibleOnPageLoad = true;
            //RWStatusCount.Visible = false;


            LoadVillaNo(1);

        }
        // LoadOwnerAwayGrid();
        // LoadGridLevelP();

    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 11 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void CheckPermission()
    {
        try
        {

            if (Session["UserID"] != null)
            {
                Permission p = new Permission();

                string result = p.GetPermission(Session["UserID"].ToString(), "Profile");
                string result2 = p.GetPermission(Session["UserID"].ToString(), "Profile");

                result = result.Trim();
                result2 = result.Trim();

                if ((result.ToString() == "Y"))
                {

                    Session["UserPermission"] = result.ToString();
                    //Response.Redirect("ResidentAdd.aspx");
                }
                else
                {
                    Response.Redirect("Homemenu.aspx");
                    WebMsgBox.Show("You have not permission to view resident module");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void btnSave_Click1(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                SqlProcsNew sqlobj = new SqlProcsNew();
                string filename = string.Empty;
                String File = "";
                if (FileUpd.HasFile)
                {

                    if (FileUpd.PostedFile.FileName.Length > 0)
                    {
                        filename = Path.GetFileName(FileUpd.PostedFile.FileName);
                        FileUpd.SaveAs(Server.MapPath(@"~//Uploads/") + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename);
                        File = (@"~//Uploads/") + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename;
                    }
                    else
                    {
                        File = "";
                    }
                }
                sqlobj.ExecuteSP("SP_InsertResidentDtls",
                                     new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = ddlTitle.SelectedValue },
                                     new SqlParameter() { ParameterName = "@RTName", SqlDbType = SqlDbType.NVarChar, Value = RTName.Text },
                                     new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = ddlgender.SelectedValue.ToString() },
                                     new SqlParameter() { ParameterName = "@Marital", SqlDbType = SqlDbType.NVarChar, Value = ddlMarital.SelectedValue.ToString() },
                                     new SqlParameter() { ParameterName = "@RTVILLANO", SqlDbType = SqlDbType.NVarChar, Value = ddlvillano.SelectedValue },
                                     new SqlParameter() { ParameterName = "@RTSTATUS", SqlDbType = SqlDbType.NVarChar, Value = ddlstatus.SelectedValue.ToString() },
                                     new SqlParameter() { ParameterName = "@RTAddress1", SqlDbType = SqlDbType.NVarChar, Value = RTAddress1.Text },
                                     new SqlParameter() { ParameterName = "@RTAddress2", SqlDbType = SqlDbType.NVarChar, Value = RTAddress2.Text },
                                     new SqlParameter() { ParameterName = "@CityName", SqlDbType = SqlDbType.NVarChar, Value = CityName.Text },
                                     new SqlParameter() { ParameterName = "@Pincode", SqlDbType = SqlDbType.NVarChar, Value = Pincode.Text },
                                     new SqlParameter() { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = Country.Text },
                                     new SqlParameter() { ParameterName = "@Contactno", SqlDbType = SqlDbType.NVarChar, Value = Contactno.Text },
                                     new SqlParameter() { ParameterName = "@Contactcellno", SqlDbType = SqlDbType.NVarChar, Value = Contactcellno.Text },
                                     new SqlParameter() { ParameterName = "@Contactmail", SqlDbType = SqlDbType.NVarChar, Value = Contactmail.Text },
                                     new SqlParameter() { ParameterName = "@AlternateEMAILID", SqlDbType = SqlDbType.NVarChar, Value = AlternateEMAILID.Text },
                                     new SqlParameter() { ParameterName = "@DOB", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = FromDate.SelectedDate },
                                     new SqlParameter() { ParameterName = "@BloodGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlBloodgroup.SelectedValue.ToString() },
                                     new SqlParameter() { ParameterName = "@SMSAlert", SqlDbType = SqlDbType.NVarChar, Value = "y" },
                                     new SqlParameter() { ParameterName = "@EMAILAlert", SqlDbType = SqlDbType.NVarChar, Value = "y" },
                                     new SqlParameter() { ParameterName = "@Occupants", SqlDbType = SqlDbType.Decimal, Value = ddloccupants.SelectedValue.ToString() },
                                     new SqlParameter() { ParameterName = "@DiningAD", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(txtDiningAutoDebit.Text == "" ? null : txtDiningAutoDebit.Text) },
                                     new SqlParameter() { ParameterName = "@DiningADFlag", SqlDbType = SqlDbType.NVarChar, Value = ddlDAutoDebit.SelectedValue },
                                     new SqlParameter() { ParameterName = "@ServiceAD", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(txtServiceAutoDebit.Text == "" ? null : txtServiceAutoDebit.Text) },
                                     new SqlParameter() { ParameterName = "@ServiceADFlag", SqlDbType = SqlDbType.NVarChar, Value = ddlSAutoDebit.SelectedValue },
                                     new SqlParameter() { ParameterName = "@WatsApp", SqlDbType = SqlDbType.NVarChar, Value = WatsApp.Text },
                                     new SqlParameter() { ParameterName = "@Facebook", SqlDbType = SqlDbType.NVarChar, Value = Facebook.Text },
                                     new SqlParameter() { ParameterName = "@Skype", SqlDbType = SqlDbType.NVarChar, Value = Skype.Text },
                                     new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = Remarks.Text },
                                     new SqlParameter() { ParameterName = "@Legalwill", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                      new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                     new SqlParameter() { ParameterName = "@Images", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = File },
                                     new SqlParameter() { ParameterName = "@ImagePath", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "" },
                                     new SqlParameter() { ParameterName = "@FBilling", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                                      new SqlParameter() { ParameterName = "@OffDOB", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = RdOffDOB.SelectedDate },
                                       new SqlParameter() { ParameterName = "@OffMobNo", SqlDbType = SqlDbType.NVarChar, Value = txtOffMobNo.Text },
                                     new SqlParameter() { ParameterName = "@OffEmailID", SqlDbType = SqlDbType.NVarChar, Value = txtOffEmailId.Text }
                                     );
                SendMail();
                ClearScr();
                LoadGrid();                
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Resident detail saved successfully,Please Check Your E-Mail to do further details.');", true);
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('DoorNo Status has been changed to Occupied! , If you want to change the status please change.');", true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void SendMail()
    {      
        try
        {
            System.Web.HttpResponse Response = System.Web.HttpContext.Current.Response;
            string mailserver = string.Empty;
            string user = string.Empty;
            string pwd = string.Empty;
            string sentby = string.Empty;

            SqlCommand cmd = new SqlCommand(string.Concat("SELECT * FROM cpmailcredentials"), con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet dsCredential = new DataSet();
            da.Fill(dsCredential);
            // Write an informational entry to the event log.  

            if (dsCredential != null && dsCredential.Tables.Count > 0)
            {
                foreach (DataRow row in dsCredential.Tables[0].Rows)
                {
                    mailserver = row["mailserver"].ToString();
                    user = row["username"].ToString();
                    pwd = row["password"].ToString();
                    sentby = row["sentbyuser"].ToString();
                }
            }
            SqlCommand com = new SqlCommand(string.Concat("select FromID,communityName from tbladmin"), con);
            SqlDataAdapter dat = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            dat.Fill(ds);
            // Write an informational entry to the event log.  
            string ID = "";
            string ComName = "";
            if (ds != null && ds.Tables.Count > 0)
            {
                ID = ds.Tables[0].Rows[0]["FromID"].ToString();
                ComName = ds.Tables[0].Rows[0]["communityName"].ToString();
            }
            SqlCommand com1 = new SqlCommand(string.Concat("select RTRSN,GLAccount,GlDepositAccount from tblResident where RTNAME='" + RTName.Text + "' and RTVillano='" + ddlvillano.SelectedValue + "'"), con);
            SqlDataAdapter dat1 = new SqlDataAdapter(com1);
            DataSet ds1 = new DataSet();
            dat1.Fill(ds1);
            // Write an informational entry to the event log.  
            string GLAcc = "";
            string DepAc="";
            string RSN = "";
            if (ds1 != null && ds1.Tables.Count > 0)
            {
                GLAcc = ds1.Tables[0].Rows[0]["GLAccount"].ToString();
                DepAc = ds1.Tables[0].Rows[0]["GlDepositAccount"].ToString();
                RSN = ds1.Tables[0].Rows[0]["RTRSN"].ToString();
            }

            SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
            MailAddress From = new MailAddress(user, "info@innovatussystems.com");
            MailMessage myMail = new System.Net.Mail.MailMessage();
            myMail.From = From;
            myMail.To.Add(ID);
            //myMail.CC.Add("covaiproprarch@gmail.com");
            mySmtpClient.UseDefaultCredentials = false;
            System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
            mySmtpClient.Credentials = basicauth;
            mySmtpClient.EnableSsl = false;
            mySmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            //mySmtpClient.Timeout = 200000;
            myMail.SubjectEncoding = System.Text.Encoding.UTF8;
            myMail.BodyEncoding = System.Text.Encoding.UTF8;

            //return;

            StringBuilder sbBody = new StringBuilder();
            sbBody.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;font-size:14px;'>");
            sbBody.Append("<tr><td><b> Dear Sir/Madam ,</b></td></tr>");
            sbBody.Append("<tr><td>Let us welcome new resident <b>"+ RTName.Text+"</b>");
            sbBody.Append("</td></tr>");
            //sbBody.Append("<tr><td>Name :<b>"+ RTName.Text+"</b>");
            //sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td>Door No. :<b>" + ddlvillano.SelectedValue + "</b></td></tr>");
            sbBody.Append("<tr><td>Status :<b>" + ddlstatus.Text.ToString() + "</b></td></tr>");
            sbBody.Append("<tr><td>GL Account for transactions :<b>"+GLAcc+ "</b>");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td>GL Account for Deposits :<b>" + DepAc + "</b>");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td>Important special attribute codes(Profile ++ codes), for you to fill them up.Please set <b>DININGAT</b> Code.</td></tr>");          
            sbBody.Append("<tr><td>You may also have to post financial transactions for the resident (Deposits, Initial credits etc.)</td></tr>");
            sbBody.Append("<tr><td>Remember to fill any missing information to take full advantage of ORIS.</td></tr>");          
            sbBody.Append("<tr><td>Resident Unique ID : <b>"+RSN+"</b>");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td> Auto generated message from ORIS");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td><b>" + ComName + "</b></td></tr>");
            sbBody.Append("<tr><td></td></tr>");           
            sbBody.Append("</table>"); 
            myMail.IsBodyHtml = true;
            myMail.Subject = "Resident profile added for " + RTName.Text;
            myMail.Body = sbBody.ToString();
            mySmtpClient.Send(myMail);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
            return;
        }
    }
    private void LoadVillaNo(Int32 iMode)
    {
        try
        {
            DataSet dsvillano = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();

            dsvillano = proc.ExecuteSP("SP_GetVillaNo",
                 new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = iMode });

            if (dsvillano.Tables[0].Rows.Count > 0)
            {
                ddlvillano.DataSource = dsvillano.Tables[0];
                ddlvillano.DataTextField = "status";
                ddlvillano.DataValueField = "DoorNo";
                ddlvillano.DataBind();
            }

            ddlvillano.Items.Insert(0, "--Select--");

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }




    #region Grid view PageIndexChanged,PageSizeChanged and SortCommand for three grids

    protected void rdgListView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        if (Request.QueryString["HRName"] != null)
        {
            LoadGrid2();
        }
        else
            LoadGrid();
        //LoadGridLevelT();
        //LoadGridLevelU();
    }
    protected void rdgListView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        if (Request.QueryString["HRName"] != null)
        {
            LoadGrid2();
        }
        else
            LoadGrid();
        //LoadGridLevelT();
        //LoadGridLevelU();
    }
    protected void rdgListView_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        if (Request.QueryString["HRName"] != null)
        {
            LoadGrid2();
        }
        else
            LoadGrid();
        //LoadGridLevelT();
        //LoadGridLevelU();
    }


    protected void LoadGrid()
    {
        Session["GridStatus"] = "RS";

        SqlCommand cmd = new SqlCommand("SP_General", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 2;
        DataSet dsGrid = new DataSet();
        rcntgrdView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {            

            dtExcel = dsGrid.Tables[0];
            rcntgrdView.DataSource = dsGrid.Tables[0];
            rcntgrdView.DataBind();

            //rcntgrdView.AllowPaging = true;

            lnkcount.Text = "Count:" + dsGrid.Tables[0].Rows.Count;

        }
        else
        {
            rcntgrdView.DataSource = new String[] { };
            rcntgrdView.DataBind();

            lnkcount.Text = "Count:0";
        }


        SqlCommand Cmdd = new SqlCommand("SP_General", con);
        Cmdd.CommandType = CommandType.StoredProcedure;
        Cmdd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 10;
        DataSet dsBday = new DataSet();
        SqlDataAdapter DATR = new SqlDataAdapter(Cmdd);


        DATR.Fill(dsBday);

        for (int i = 0; i < dsBday.Tables[0].Rows.Count; i++)
        {
            string Bday1 = dsBday.Tables[0].Rows[i]["RTRSN"].ToString();


            foreach (GridItem rw
                   in rcntgrdView.Items)
            {
                string strRTRSN = rw.Cells[5].Text;

                if (strRTRSN == Bday1)
                {
                    rw.Cells[17].ForeColor = System.Drawing.Color.Green;
                }

            }


            //for (int j = 0; j < rcntgrdView.rows ; j++)
            //{
            //    string Bday2 = dsGrid.Tables[0].Rows[j]["RTRSN"].ToString();
            //    string DOB = dsGrid.Tables[0].Rows[j]["DOB"].ToString();
            //    if (Bday1 == Bday2)
            //    {
            //        WebMsgBox.Show("hello test");
            //    }


            //}



            //foreach (GridItem rw in rcntgrdView.Items)
            //{

            //    try
            //    {
            //        if (dsBday != null && dsBday.Tables.Count > 0 && dsBday.Tables[0].Rows.Count > 0 && Bday1 == Bday2)
            //        {

            //        }
            //    }
            //    catch
            //    {

            //    }
            //}
        }





    }


    protected void LoadGridOtherStatus()
    {
        Session["GridStatus"] = "OS";

        SqlCommand cmd = new SqlCommand("SP_General", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 33;
        DataSet dsGrid = new DataSet();
        rcntgrdView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            dtExcel = dsGrid.Tables[0];
            rcntgrdView.DataSource = dsGrid.Tables[0];
            rcntgrdView.DataBind();

            //rcntgrdView.AllowPaging = true;

            lnkcount.Text = "Count:" + dsGrid.Tables[0].Rows.Count;

        }
        else
        {
            rcntgrdView.DataSource = new String[] { };
            rcntgrdView.DataBind();

            lnkcount.Text = "Count:0";
        }


        SqlCommand Cmdd = new SqlCommand("SP_General", con);
        Cmdd.CommandType = CommandType.StoredProcedure;
        Cmdd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 10;
        DataSet dsBday = new DataSet();
        SqlDataAdapter DATR = new SqlDataAdapter(Cmdd);


        DATR.Fill(dsBday);

        for (int i = 0; i < dsBday.Tables[0].Rows.Count; i++)
        {
            string Bday1 = dsBday.Tables[0].Rows[i]["RTRSN"].ToString();


            foreach (GridItem rw
                   in rcntgrdView.Items)
            {
                string strRTRSN = rw.Cells[5].Text;

                if (strRTRSN == Bday1)
                {
                    rw.Cells[17].ForeColor = System.Drawing.Color.Green;
                }

            }


            //for (int j = 0; j < rcntgrdView.rows ; j++)
            //{
            //    string Bday2 = dsGrid.Tables[0].Rows[j]["RTRSN"].ToString();
            //    string DOB = dsGrid.Tables[0].Rows[j]["DOB"].ToString();
            //    if (Bday1 == Bday2)
            //    {
            //        WebMsgBox.Show("hello test");
            //    }


            //}



            //foreach (GridItem rw in rcntgrdView.Items)
            //{

            //    try
            //    {
            //        if (dsBday != null && dsBday.Tables.Count > 0 && dsBday.Tables[0].Rows.Count > 0 && Bday1 == Bday2)
            //        {

            //        }
            //    }
            //    catch
            //    {

            //    }
            //}
        }





    }



    #region Export to excel
    protected void ExcelExport(DataTable dt)
    {
        try
        {
            SqlProcsNew sqlp = new SqlProcsNew();
            DataSet dsH = new DataSet();
            DataSet dsFetch = new DataSet();
            //+ Session["Userid"].ToString() 
            string StoredProcedure = "";
            string TemplateFile = "";
            int LineNumber = 0;
            int ColCount = 0;

            dsH = sqlp.ExecuteSP("SP_DispReportDetails",
                new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 },
                new SqlParameter() { ParameterName = "@Report", SqlDbType = SqlDbType.BigInt, Direction = ParameterDirection.Input, Value = 01 });

            StoredProcedure = Convert.ToString(dsH.Tables[0].Rows[0]["StoredProcedure"]);
            TemplateFile = Convert.ToString(dsH.Tables[0].Rows[0]["TemplateFile"]);
            LineNumber = Convert.ToInt16(dsH.Tables[0].Rows[0]["LineNumber"]);
            ColCount = Convert.ToInt16(dsH.Tables[2].Rows[0]["ColCount"]);

            String FileName = TemplateFile + "_" + "_" + DateTime.Now.Day + DateTime.Now.Month + DateTime.Now.Year + "_" + DateTime.Now.Hour + DateTime.Now.Minute + DateTime.Now.Second + ".xls";

            dsFetch = sqlp.ExecuteSP("SP_FetchParam",
            new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 1 });
            string templateFilePath = Server.MapPath(@dsFetch.Tables[0].Rows[0]["paramvalue"] + TemplateFile + ".xltx");

            dsFetch = sqlp.ExecuteSP("SP_FetchParam",
            new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Direction = ParameterDirection.Input, Value = 2 });
            String newFilePath = Server.MapPath(@dsFetch.Tables[0].Rows[0]["paramvalue"] + FileName);

            FileInfo newFile = new FileInfo(newFilePath);
            FileInfo template = new FileInfo(templateFilePath);
            using (ExcelPackage xlPackage = new ExcelPackage(newFile, template))
            {
                foreach (ExcelWorksheet aworksheet in xlPackage.Workbook.Worksheets)
                {
                    aworksheet.Cell(1, 1).Value = aworksheet.Cell(1, 1).Value;
                }
                ExcelWorksheet worksheet = xlPackage.Workbook.Worksheets[1];
                int startrow = LineNumber;
                int row = 0;
                int col = 0;
                for (int j = 0; j < ColCount; j++)
                {
                    col++;
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        row = startrow + i;
                        ExcelCell cell = worksheet.Cell(row, col);
                        cell.Value = dt.Rows[i][j].ToString();
                        //xlPackage.Save();
                    }
                }
                for (int iCol = 1; iCol <= ColCount; iCol++)
                {
                    ExcelCell cell = worksheet.Cell(startrow - 2, iCol);
                    for (int iRow = startrow; iRow <= row; iRow++)
                    {
                        worksheet.Cell(iRow, iCol).StyleID = cell.StyleID;
                    }
                }
                xlPackage.Save();
            }
            string attachment = "attachment; filename=" + FileName;
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", attachment);
            HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
            HttpContext.Current.Response.TransmitFile(newFilePath);
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
        }
        catch (Exception ex)
        {
            SqlProcsNew sqlpd = new SqlProcsNew();
            DataSet dsd = new DataSet();

            dsd = sqlpd.ExecuteSP("insert_debug",
               new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.NVarChar, Direction = ParameterDirection.Input, Value = ex.Message.ToString() });
            if (dsd != null)
            {
            }
            //ShowMessage(ex.ToString(), "PRISM");
        }

    }

    #endregion

    #region Load grid for Excel Export(LoadGrid1)
    protected void LoadGrid1()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SP_General", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 5;
            DataSet dsGrid = new DataSet();
            //rcntgrdView.DataBind();

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(dsGrid);

            DateTime sdate = DateTime.Now;


            if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsGrid.Tables[0];
                dg.DataBind();


                // THE EXCEL FILE.
                string sFileName = "Resident List  (Full Rpt) on " + sdate.ToString("dd/MM/yyyy") + ".xls";
                sFileName = sFileName.Replace("/", "");



                // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
                Response.ContentType = "application/vnd.ms-excel";
                EnableViewState = false;

                System.IO.StringWriter objSW = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

                dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
                dg.RenderControl(objHTW);


                //"," + strdesc.ToString() +


                DateTime dates = DateTime.Now;

                string times = DateTime.Now.ToString("hh:mm:ss tt");

                Response.Write("<table><tr><td>Resident List  (Short Rpt) on " + sdate.ToString("dd/MM/yyyy") + "</td><td> Printed on:" + DateTime.Today.ToString("dd/MM/yyyy") + "-" + times.ToString() + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;



                // old excel to export
                //if (!string.IsNullOrEmpty(QryString))
                //{
                //    DataSet oDsResults = dsGrid.Clone();
                //    string strQuery = "RTName like '%" + QryString + "%'";
                //    DataRow[] drFilterRows = dsGrid.Tables[0].Select(strQuery);
                //    foreach (DataRow dr in drFilterRows)
                //        oDsResults.Tables[0].ImportRow(dr);
                //    if (drFilterRows.Length > 0)
                //    {
                //        oDsResults.AcceptChanges();
                //        ExcelExport(oDsResults.Tables[0]);
                //    }
                //}
                //else
                //{
                //    ExcelExport(dsGrid.Tables[0]);
                //}


                //WebMsgBox.Show("Excel Export completed Successfuly");
            }
            else
            {
                WebMsgBox.Show("No records found!");
            }
        }
        catch (Exception ex)
        {
            //ShowMessage(ex.Message, "PRISM");
        }



    }
    #endregion

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }

    #region Gender dropdown
    protected void Gender()
    {
        DataTable dt = new DataTable();
        dt.Clear();
        dt.Columns.Add("Code");
        dt.Columns.Add("Text");
        DataRow drow = dt.NewRow();
        drow["Code"] = "Male";
        drow["Text"] = "Male";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "Female";
        drow["Text"] = "Female";
        dt.Rows.Add(drow);

        ddlgender.DataSource = dt;
        ddlgender.DataTextField = dt.Columns["Text"].ToString();
        ddlgender.DataValueField = dt.Columns["Code"].ToString();
        ddlgender.DataBind();
    }
    #endregion

    #region Status dropdown
    protected void Status()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistStatus = new DataSet();

            ddlistStatus = sqlobj.ExecuteSP("SP_FetchStatusDropDown",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 });
            ddlstatus.DataSource = ddlistStatus.Tables[0];
            ddlstatus.DataValueField = "SCode";
            ddlstatus.DataTextField = "SDescription";
            ddlstatus.DataBind();
            ddlstatus.Dispose();
            ddlstatus.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    #endregion

    #region SMS alert Dropdown
    //protected void SMSAlert()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Clear();
    //    dt.Columns.Add("Code");
    //    dt.Columns.Add("Text");
    //    DataRow drow = dt.NewRow();
    //    drow["Code"] = "y";
    //    drow["Text"] = "Yes";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "N";
    //    drow["Text"] = "No";
    //    dt.Rows.Add(drow);
    //    ddlsmsalt.DataSource = dt;
    //    ddlsmsalt.DataTextField = dt.Columns["Text"].ToString();
    //    ddlsmsalt.DataValueField = dt.Columns["Code"].ToString();
    //    ddlsmsalt.DataBind();
    //}
    #endregion
    #region Email alert dropdown

    //protected void EmailAlert()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Clear();
    //    dt.Columns.Add("Code");
    //    dt.Columns.Add("Text");
    //    DataRow drow = dt.NewRow();
    //    drow["Code"] = "y";
    //    drow["Text"] = "Yes";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "N";
    //    drow["Text"] = "No";
    //    dt.Rows.Add(drow);
    //    ddlemailalt.DataSource = dt;
    //    ddlemailalt.DataTextField = dt.Columns["Text"].ToString();
    //    ddlemailalt.DataValueField = dt.Columns["Code"].ToString();
    //    ddlemailalt.DataBind();
    //}
    #endregion
    #region Occupants Dropdown

    protected void Occupants()
    {
        DataTable dt = new DataTable();
        dt.Clear();
        dt.Columns.Add("Code");
        dt.Columns.Add("Text");
        DataRow drow = dt.NewRow();
        drow["Code"] = "0";
        drow["Text"] = "0";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "1";
        drow["Text"] = "1";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "2";
        drow["Text"] = "2";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "3";
        drow["Text"] = "3";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "4";
        drow["Text"] = "4";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "5";
        drow["Text"] = "5";
        dt.Rows.Add(drow);
        ddloccupants.DataSource = dt;
        ddloccupants.DataTextField = dt.Columns["Text"].ToString();
        ddloccupants.DataValueField = dt.Columns["Code"].ToString();
        ddloccupants.DataBind();
    }
    #endregion

    #region Clear Screen

    protected void ClearScr()
    {
        Gender();
        Status();
        // SMSAlert();
        // EmailAlert();
        Occupants();

        RTName.Text = string.Empty;
        ddlvillano.SelectedIndex = 0;
        ddlMarital.SelectedIndex = 0;
        ddlBloodgroup.SelectedIndex = 0;
        FromDate.SelectedDate = null;
        RTAddress1.Text = string.Empty;
        RTAddress2.Text = string.Empty;
        CityName.Text = string.Empty;
        Pincode.Text = string.Empty;
        Country.Text = string.Empty;
        Contactno.Text = string.Empty;
        Contactcellno.Text = string.Empty;
        Contactmail.Text = string.Empty;
        AlternateEMAILID.Text = string.Empty;

        txtDiningAutoDebit.Text = "0";
        txtServiceAutoDebit.Text = "0";

        WatsApp.Text = string.Empty;
        Facebook.Text = string.Empty;
        Skype.Text = string.Empty;
        Remarks.Text = string.Empty;
        //txtlegalwill.Text = string.Empty;
        chkSameDetails.Checked = false;
        txtOffEmailId.Text = string.Empty;
        txtOffMobNo.Text = string.Empty;
        RdOffDOB.SelectedDate = null;

        ddlvillano.Focus();
    }
    #endregion

    #region Title dropdown
    //protected void RTitle()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Clear();
    //    dt.Columns.Add("Code");
    //    dt.Columns.Add("Text");
    //    DataRow drow = dt.NewRow();
    //    drow["Code"] = "CA";
    //    drow["Text"] = "CA";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "Dr";
    //    drow["Text"] = "Dr";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "Mr";
    //    drow["Text"] = "Mr";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "Ms";
    //    drow["Text"] = "Ms";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "Mrs";
    //    drow["Text"] = "Mrs";
    //    dt.Rows.Add(drow);
    //    //drow = dt.NewRow();
    //    //drow["Code"] = "Tenant";
    //    //drow["Text"] = "Tenant";
    //    //dt.Rows.Add(drow);



    //    ddlTitle.DataSource = dt;
    //    ddlTitle.DataTextField = dt.Columns["Text"].ToString();
    //    ddlTitle.DataValueField = dt.Columns["Code"].ToString();
    //    ddlTitle.DataBind();
    //}

    #endregion

    #region Cmb_DataBound
    protected void Cmb_DataBound(object sender, EventArgs e)
    {
        var combo = (DropDownList)sender;
        //combo.Items.Insert(0, "-- Select --");
    }
    #endregion




    #region Button Excel Export Click event
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {
            //Comment by Prakash 26-08-2015
            LoadGrid1();

            //DataTable dtTest = (DataTable)ViewState["Excel"];
            //ExcelExport(dtTest);
            //dtTest = null;
        }

        catch
        {

            WebMsgBox.Show("There is some problem in Export to excel.Try again! ");
        }
    }
    #endregion



    protected void BtnLevelS_Click(object sender, EventArgs e)
    {
        LoadGrid();
        PnlLevelS.Visible = true;

        lnkAddnewCustomer.Visible = true;
    }

    protected void Lnkbtnview_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["CustRSN"] = row.Cells[6].Text;
        CustomerRSN = Session["CustRSN"].ToString();
        //  ScriptManager.RegisterStartupScript(this, this.GetType(), "win",
        //"<script language='javascript'> var iMyWidth;var iMyHeight;  window.open('ResidentView.aspx?=" + CustomerRSN + "','NewWin','status=no,height=1000,width=1300 ,resizable=No,left=200,top=100,screenX=100,screenY=200,toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,   NewWin.focus()')</script>", false);

        //Response.Redirect("ResidentEdit.aspx?=" + CustomerRSN);
        Session["ResidentRSN"] = row.Cells[6].Text;
        Response.Redirect("ResidentView.aspx?=" + CustomerRSN);
    }
    protected void Lnkbtnedit_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[6].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();
        Response.Redirect("ResEditt.aspx");

    }
    protected void LnkbtnAddOn_Click(object sender, EventArgs e)
    {
        //string CustomerRSN;
        //LinkButton lnkOpenProjBtn = (LinkButton)sender;
        //GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        //Session["ResidentRSN"] = row.Cells[6].Text;
        //CustomerRSN = Session["ResidentRSN"].ToString();
        //Response.Redirect("AttributesAdd.aspx");

        //Session["ResidentRSN"] = Session["DRTRSN"].ToString();

        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[6].Text;
        Session["PrevPageName"] = "ResidentAdd.aspx";
        Response.Redirect("AttributesAdd.aspx");

    }
    protected void lbtnName_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[6].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();
        Response.Redirect("TransactionLevel.aspx");
    }
    protected void lnkAddnewCustomer_Click(object sender, EventArgs e)
    {
        if (lnkAddnewCustomer.Text == "+ Add a New Profile")
        {
            Tbladdcust.Visible = true;

            lnkAddnewCustomer.ToolTip = "Click here to Close.";

            txtDiningAutoDebit.Text = "0";
            txtServiceAutoDebit.Text = "0";

            lnkAddnewCustomer.Text = "Close";
            btnOtherStatus.Visible = false;
            btnOSClear.Visible = false;

            PnlLevelS.Visible = false;
        }
        else
            if (lnkAddnewCustomer.Text == "Close")
            {
                Tbladdcust.Visible = false;

                lnkAddnewCustomer.Text = "+ Add a New Profile";
                lnkAddnewCustomer.ToolTip = "Click here to add a new profile.";

                PnlLevelS.Visible = true;


            }
    }

    protected void LoadStatusCount()
    {

        DataSet dsSection = new DataSet();
        SqlProcsNew proc = new SqlProcsNew();

        dsSection = proc.ExecuteSP("SP_FetchLevelRDtls", new SqlParameter()
        {
            ParameterName = "@IMODE",
            Direction = ParameterDirection.Input,
            SqlDbType = SqlDbType.Int,
            Value = 1
        });

    }



    protected void rcntgrdView_ItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                if (item["RTSTATUS"].Text.Equals("ORD") || item["RTSTATUS"].Text.Equals("OAD") ||
                   item["RTSTATUS"].Text.Equals("TD") || item["RTSTATUS"].Text.Equals("TDA"))
                {

                    //LinkButton lnk = (LinkButton)item.FindControl("lbtnVillaNo");
                    //lnk.Enabled = false;
                    //lnk.ForeColor = System.Drawing.Color.Gray;
                }
                else
                {

                }


                //if (item["VillaStatus"].Text.Equals("Vacant") || item["VillaStatus"].Text.Equals("Blocked"))
                //{
                //    LinkButton lnkview = (LinkButton)item.FindControl("Lnkbtnview");
                //    LinkButton lnkedit = (LinkButton)item.FindControl("Lnkbtnedit");
                //    LinkButton lnkadd = (LinkButton)item.FindControl("LnkbtnAddOn");


                //    lnkview.Enabled = false;
                //    lnkedit.Enabled = false;
                //    lnkadd.Enabled = false;

                //    lnkview.Visible = false;
                //    lnkedit.Visible = false;
                //    lnkadd.Visible = false;
                //}


                if (item["RTSTATUS"].Text.Equals("OR") || item["RTSTATUS"].Text.Equals("RS") || item["RTSTATUS"].Text.Equals("T") || item["RTSTATUS"].Text.Equals("TS")
                    || item["RTSTATUS"].Text.Equals("OA") || item["RTSTATUS"].Text.Equals("TA") || item["RTSTATUS"].Text.Equals("PT") || item["RTSTATUS"].Text.Equals("PO"))
                {
                    LinkButton lnkdependent = (LinkButton)item.FindControl("Lnkbtndependant");
                    lnkdependent.Visible = true;

                }
                else
                {
                    LinkButton lnkdependent = (LinkButton)item.FindControl("Lnkbtndependant");
                    lnkdependent.Visible = false;
                }

                int countps = Convert.ToInt32(item["PendingSREQ"].Text);
                decimal dos = Convert.ToDecimal(item["Outstand"].Text);

                if (dos > 0)
                {
                    //item.BackColor = Color.Yellow;

                    item["Outstand"].BackColor = Color.Yellow;

                }

                if (countps > 0)
                {
                    item["PendingSREQ"].BackColor = Color.Yellow;
                }


            }
            catch (GridException ex) { }

        }
    }




    #region Item data bound for Level U Grid


    protected void rdgListView2_ItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {  // this next line gives the error
                if (item["RTSTATUS"].Text.Equals("Vacant"))
                {

                    LinkButton lnk = (LinkButton)item.FindControl("lbtnName");
                    lnk.Enabled = false;
                    lnk.ForeColor = System.Drawing.Color.Gray;
                    //item["Reject"].Controls[0].Visible = false;
                }
                else
                {
                    //item["ExpandColumn"].Controls[0].Visible = false;
                }
            }
            catch (GridException ex) { }
        }
    }
    #endregion


    #region Item data bound for Level T Grid
    protected void rdgListView1_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {  // this next line gives the error
                if (item["RTSTATUS"].Text.Equals("Previous Tenant") || item["RTSTATUS"].Text.Equals("Previous Tenant Dependant"))
                {

                    LinkButton lnk = (LinkButton)item.FindControl("lbtnName");
                    lnk.Enabled = false;
                    lnk.ForeColor = System.Drawing.Color.Gray;
                    //item["Reject"].Controls[0].Visible = false;
                }
                else
                {
                    //item["ExpandColumn"].Controls[0].Visible = false;
                }
            }
            catch (GridException ex) { }
        }
    }

    #endregion


    #region Item data bound for VillaCount  Grid
    protected void VillaCountListView_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            //Get the instance of the right type
            GridDataItem dataBoundItem = e.Item as GridDataItem;

            //Check the formatting condition
            if (int.Parse(dataBoundItem["CheckedOutCount"].Text) > 0)
            {
                dataBoundItem["CheckedOutCount"].ForeColor = Color.Red;
                dataBoundItem["CheckedOutCount"].Font.Bold = true;
                //Customize more...
            }
        }
    }
    #endregion

    #region Item data bound for Level P Grid

    protected void AllGridView_ItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                //if (item["SDescription"].Text.Equals("Owner Resident Dependent") || item["SDescription"].Text.Equals("Owner Away Dependent") ||
                //   item["SDescription"].Text.Equals("Tenant Dependant") || item["SDescription"].Text.Equals("Tenant Dependant Away") || item["SDescription"].Text.Equals("Vacant"))
                    if (item["RTSTATUS"].Text.Equals("ORD") || item["RTSTATUS"].Text.Equals("OAD") ||
                   item["RTSTATUS"].Text.Equals("TD") || item["RTSTATUS"].Text.Equals("TDA"))
                    {

                    LinkButton lnk = (LinkButton)item.FindControl("lbtnName");
                    lnk.Enabled = false;
                    lnk.ForeColor = System.Drawing.Color.Gray;

                }
                else
                {

                }
            }
            catch (GridException ex) { }
        }
    }

    #endregion




    //protected void lbtnMobileNo_Click(object sender, EventArgs e)
    //{
    //    string CustomerRSN;
    //    LinkButton lnkOpenProjBtn = (LinkButton)sender;
    //    GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
    //    Session["ResidentRSN"] = row.Cells[5].Text;
    //    CustomerRSN = Session["ResidentRSN"].ToString();
    //    Response.Redirect("BillPosting.aspx");
    //}
    protected void rcntgrdView_ItemCommand(object sender, GridCommandEventArgs e)
    {

        if (Request.QueryString["HRName"] != null)
        {
            LoadGrid2();
        }
        else
        {

            if (Session["GridStatus"].ToString() == "RS")
            {

                LoadGrid();
            }
            else if (Session["GridStatus"].ToString() == "OS")
            {
                LoadGridOtherStatus();
            }

            // lnkcount.Text = rcntgrdView.MasterTableView.Items.Count.ToString();
        }

        if (e.CommandArgument == "LoadPopUp")
        {
            Session["DRTRSN"] = e.CommandName.ToString();

            LoadsubMenus();

            // rwPopup.Visible = true;
        }
        if (e.CommandArgument == "Profile")
        {
            Session["DRTRSN"] = e.CommandName.ToString();

            rwPopup.Visible = true;
        }


    }

    protected void RMResident_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Information Board")
        {
            Response.Redirect("Information_Board.aspx");
        }
        if (e.Item.Text == "Vacant")
        {
            Response.Redirect("Vacants.aspx");
        }
        if (e.Item.Text == "Staff & Others")
        {
            Response.Redirect("StaffandOthers.aspx");
        }
        if (e.Item.Text == "Owners Away")
        {
            Response.Redirect("OwnersAway.aspx");
        }
        if (e.Item.Text == "Previous Tenants")
        {
            Response.Redirect("PreviousTenants.aspx");
        }
        if (e.Item.Text == "Living Alone")
        {
            Response.Redirect("SAlone.aspx?Value1=" + 2);
        }
        if (e.Item.Text == "Profile ++")
        {
            Response.Redirect("ProfilePP.aspx");
        }

    }

    protected void LoadGrid2()
    {

        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsGroup = null;
        dsGroup = sqlobj.ExecuteSP("SP_FetchLevelSByName",
            new SqlParameter() { ParameterName = "@RName", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Request.QueryString["HRName"].ToString() });
        rcntgrdView.DataSource = dsGroup.Tables[0];
        dtExcel = dsGroup.Tables[0];
        ViewState["Excel"] = dtExcel;
        rcntgrdView.DataBind();
        dsGroup.Dispose();


        //SqlCommand cmd = new SqlCommand("SP_FetchLevelSByName", con);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@RName", SqlDbType.NVarChar).Value = Request.QueryString["RName"].ToString();
        //DataSet dsGrid = new DataSet();
        //rcntgrdView.DataBind();

        //SqlDataAdapter da = new SqlDataAdapter(cmd);

        //da.Fill(dsGrid);
        //if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        //{

        //    rcntgrdView.DataSource = dsGrid.Tables[0];
        //    rcntgrdView.DataBind();

        //    rcntgrdView.AllowPaging = true;

        //}
        //else
        //{
        //    rcntgrdView.DataSource = new String[] { };
        //    rcntgrdView.DataBind();
        //}


        SqlCommand Cmdd = new SqlCommand("SP_General", con);
        Cmdd.CommandType = CommandType.StoredProcedure;
        Cmdd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 10;
        DataSet dsBday = new DataSet();
        SqlDataAdapter DATR = new SqlDataAdapter(Cmdd);


        DATR.Fill(dsBday);

        for (int i = 0; i < dsBday.Tables[0].Rows.Count; i++)
        {
            string Bday1 = dsBday.Tables[0].Rows[i]["RTRSN"].ToString();


            foreach (GridItem rw
                   in rcntgrdView.Items)
            {
                string strRTRSN = rw.Cells[5].Text;

                if (strRTRSN == Bday1)
                {
                    rw.Cells[17].ForeColor = System.Drawing.Color.Green;
                }

            }

        }

    }
    protected void btnhelptext_Click(object sender, EventArgs e)
    {
        //RWHelpmessageLevelS.Visible = true;
        //RWHelpmessageLevelS.CssClass = "availability";
    }
    protected void lbtnVillaNo_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();
        //Response.Redirect("TransactionLevel.aspx");
    }

    protected void lbtnRTName_Click(object sender, EventArgs e)
    {

        // Response.Redirect("TransactionLevelInd.aspx");
    }
    protected void lnkAddnewTenent_Click(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnImport_Click(object sender, EventArgs e)
    {
        rwImportExcel.Visible = true;
    }
    protected void UpdatePanel_Unload(object sender, EventArgs e)
    {
        MethodInfo methodInfo = typeof(ScriptManager).GetMethods(BindingFlags.NonPublic | BindingFlags.Instance)
            .Where(i => i.Name.Equals("System.Web.UI.IScriptManagerInternal.RegisterUpdatePanel")).First();
        methodInfo.Invoke(ScriptManager.GetCurrent(Page),
            new object[] { sender as UpdatePanel });
    }
    protected void btnexcelimport_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsVilla = new DataSet();
        StringBuilder sb = new StringBuilder();

        string connstring = "";
        int i = 0;
        int rows = 0;
        int excelrow = 0;
        int error = 0;
        //return;
        try
        {
            if (!fuExcel.HasFile)
            {
                WebMsgBox.Show("Please select excel file to import");
                rwImportExcel.Visible = true;
                return;
            }
            string strfiletype = Path.GetExtension(fuExcel.FileName).ToLower();
            string strPath = string.Concat(Server.MapPath("~/Excel/" + fuExcel.FileName));
            FileInfo filepath = new FileInfo(strPath);
            //filepath.Delete();
            fuExcel.PostedFile.SaveAs(strPath);

            if (strfiletype == ".xls")
            {
                connstring = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + strPath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (strfiletype == ".xlsx")
            {
                connstring = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + strPath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }
            else
            {
                WebMsgBox.Show("Please upload valid excel file");
                rwImportExcel.Visible = true;
                return;
            }
            string strValidate = "select * from [Sheet1$]";
            OleDbConnection con = new OleDbConnection(connstring);

            // -- Door No upload end

            if (con.State == ConnectionState.Closed)
            {
                con.Open();
                OleDbCommand cmd = new OleDbCommand(strValidate, con);
                OleDbDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        excelrow += 1;
                        if (excelrow > 1)
                        {
                            string strDoorNo = dr[0].ToString();
                            string strTitle = dr[1].ToString();
                            string strName = dr[2].ToString();
                            string strAdd1 = dr[3].ToString();
                            string strAdd2 = dr[4].ToString();
                            string strCity = dr[5].ToString();
                            string strCountry = dr[6].ToString();
                            string strmobile = dr[7].ToString();
                            string email = dr[8].ToString();


                            if (dr[0].ToString() != "" && dr[1].ToString() != "" && dr[2].ToString() != "" && dr[3].ToString() != ""
                                && dr[4].ToString() != "" && dr[5].ToString() != "" && dr[6].ToString() != "" && dr[7].ToString() != ""
                                && dr[8].ToString() != "")
                            {
                                rows += 1;
                                dsVilla = sqlobj.ExecuteSP("CheckVillaNo",
                                    new SqlParameter { ParameterName = "@DoorNo", SqlDbType = SqlDbType.VarChar, Value = dr[0].ToString() });
                                if (dsVilla.Tables[0].Rows.Count > 0)
                                {
                                    string stsVilla = dsVilla.Tables[0].Rows[0][0].ToString();
                                    if (stsVilla == "0")
                                    {
                                        sb.Append(dr[0].ToString());
                                        sb.Append(" ");
                                        error += 1;
                                    }
                                }
                            }
                            else
                            {
                                WebMsgBox.Show("Please enter all the fields and then upload.");
                                return;
                            }
                        }
                    }
                }
                dr.Close();
                if (error > 0)
                {
                    WebMsgBox.Show("Total No of Residents :" + rows + " " + " Errors found in Door No :" + sb.ToString());
                    return;
                }

                // -- Door No upload end

                rows = 0;
                excelrow = 0;
                i = 0;
                string strdate;

                if (con.State == ConnectionState.Closed)
                {
                    con.Open();
                    OleDbCommand cmdinsert = new OleDbCommand(strValidate, con);
                    OleDbDataReader drinsert = cmdinsert.ExecuteReader();
                    if (drinsert.HasRows)
                    {
                        while (drinsert.Read())
                        {
                            excelrow += 1;
                            if (excelrow > 1)
                            {
                                //string strTest = drinsert[0].ToString();

                                // -- Door No upload start

                                if (drinsert[0].ToString() != "" && drinsert[1].ToString() != "" && drinsert[2].ToString() != "" && drinsert[3].ToString() != ""
                                    && drinsert[4].ToString() != "" && drinsert[5].ToString() != "" && drinsert[6].ToString() != "" && drinsert[7].ToString() != ""
                                    && drinsert[8].ToString() != "")

                                // -- Door No upload end

                                //if (drinsert[0].ToString() != "" && drinsert[9].ToString() != "" && drinsert[10].ToString() != "" && drinsert[11].ToString() != ""
                                //   && drinsert[12].ToString() != "" && drinsert[13].ToString() != "" && drinsert[14].ToString() != "" && drinsert[15].ToString() != ""
                                //   && drinsert[16].ToString() != ""  && drinsert[17].ToString() != "" && drinsert[18].ToString() != "" && drinsert[19].ToString() != ""
                                //    && drinsert[20].ToString() != "" && drinsert[21].ToString() != "" && drinsert[22].ToString() != "" && drinsert[23].ToString() != "")
                                {
                                    //Int16 day = Convert.ToInt16(drinsert[11].ToString());
                                    //Int16 month = Convert.ToInt16(drinsert[12].ToString());
                                    //Int16 year = Convert.ToInt16(drinsert[13].ToString());
                                    //if((day > 1 && day <= 31) && (month > 1 && month <= 12))
                                    //{
                                    //    strdate = day.ToString() + "/" + month.ToString() + "/" + year.ToString();
                                    //}
                                    //else
                                    //{
                                    //    WebMsgBox.Show("Please enter valid date of birth in villa no :"+ drinsert[0].ToString());
                                    //    return;
                                    //}                                    
                                    rows += 1;
                                    // -- Door No upload start

                                    sqlobj.ExecuteNonQuery("InsertResident_Excel",
                                            new SqlParameter { ParameterName = "@RTVilla", SqlDbType = SqlDbType.NVarChar, Value = drinsert[0].ToString() },
                                            new SqlParameter { ParameterName = "@RTTitle", SqlDbType = SqlDbType.NVarChar, Value = drinsert[1].ToString() },
                                            new SqlParameter { ParameterName = "@RTName", SqlDbType = SqlDbType.NVarChar, Value = drinsert[2].ToString() },
                                            new SqlParameter { ParameterName = "@RTAddrs1", SqlDbType = SqlDbType.NVarChar, Value = drinsert[3].ToString() },
                                            new SqlParameter { ParameterName = "@RTAddrs2", SqlDbType = SqlDbType.NVarChar, Value = drinsert[4].ToString() },
                                            new SqlParameter { ParameterName = "@City", SqlDbType = SqlDbType.NVarChar, Value = drinsert[5].ToString() },
                                            new SqlParameter { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = drinsert[6].ToString() == null ? "India" : drinsert[6].ToString() },
                                            new SqlParameter { ParameterName = "@ContactMobile", SqlDbType = SqlDbType.NVarChar, Value = drinsert[7].ToString() },
                                            new SqlParameter { ParameterName = "@EmailID", SqlDbType = SqlDbType.NVarChar, Value = drinsert[8].ToString() }

                                           );

                                    // -- Door No upload end

                                    //string srtrsn = drinsert[0].ToString();
                                    //string sdiabetis = drinsert[9].ToString();


                                    //sqlobj.ExecuteNonQuery("SP_Updatehwatch",
                                    //    new SqlParameter { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = drinsert[0].ToString() },
                                    //      new SqlParameter { ParameterName = "@DIABETIC", SqlDbType = SqlDbType.NVarChar, Value = sdiabetis.ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@CARDIAC", SqlDbType = SqlDbType.NVarChar, Value = drinsert[10].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@HYPOTNSN", SqlDbType = SqlDbType.NVarChar, Value = drinsert[11].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@HYPRTNSN", SqlDbType = SqlDbType.NVarChar, Value = drinsert[12].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@PRKNSNS", SqlDbType = SqlDbType.NVarChar, Value = drinsert[14].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@CANCER", SqlDbType = SqlDbType.NVarChar, Value = drinsert[16].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@ACIDPPTC", SqlDbType = SqlDbType.NVarChar, Value = drinsert[17].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@DEPRSION", SqlDbType = SqlDbType.NVarChar, Value = drinsert[18].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@DEMENTIA", SqlDbType = SqlDbType.NVarChar, Value = drinsert[19].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@FILARIA", SqlDbType = SqlDbType.NVarChar, Value = drinsert[20].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@EPILEPSY", SqlDbType = SqlDbType.NVarChar, Value = drinsert[22].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@ARTHRITS", SqlDbType = SqlDbType.NVarChar, Value = drinsert[21].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@HTHYROID", SqlDbType = SqlDbType.NVarChar, Value = drinsert[13].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@SKNDISES", SqlDbType = SqlDbType.NVarChar, Value = drinsert[15].ToString() == "No" ? null : "Y" },
                                    //      new SqlParameter { ParameterName = "@LUNGDSES", SqlDbType = SqlDbType.NVarChar, Value = drinsert[23].ToString() == "No" ? null : "Y" }
                                    //     );
                                    i += 1;
                                }
                            }
                        }
                    }

                    drinsert.Close();
                    WebMsgBox.Show("Total No of Residents :" + rows + " " + " Total No of Records inserted :" + i);
                    rwImportExcel.Visible = true;
                    //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Total No of Records :'"+ rows +"'\n' Total Number of Records inserted '"+i+"');", true);
                    //OleDbDataAdapter dap = new OleDbDataAdapter(cmd);
                    //DataSet ds = new DataSet();
                    //dap.Fill(ds, "temp");
                    //if(ds.Tables[0].Rows.Count > 0)
                    //{
                    //    rows = ds.Tables[0].Rows.Count;
                    //    for (int j = 0; j <= rows; i++)
                    //    {
                    //        if(ds.Tables[0].Rows[i][0].ToString() != "" && ds.Tables[0].Rows[i]["Gender"].ToString() != "" && ds.Tables[0].Rows[i]["Marital_Status"].ToString() != ""
                    //            && ds.Tables[0].Rows[i]["VillaNo"].ToString() != "" && ds.Tables[0].Rows[i]["Status"].ToString() != "" && ds.Tables[0].Rows[i]["Address1"].ToString() != ""
                    //            && ds.Tables[0].Rows[i]["Occupants"].ToString() != "")
                    //        {
                    //            //sqlobj.ExecuteNonQuery("InsertResident_Excel",
                    //            //  new SqlParameter { ParameterName = "", SqlDbType = SqlDbType.NVarChar, Value = ds.Tables[0].Rows[i]["Name"].ToString() });
                    //            i += 1;
                    //        }
                    //    }
                    //}    

                }
            }
        }

        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }
    }
    protected void lbtnResdownload_Click(object sender, EventArgs e)
    {
        string fileName;
        try
        {
            Response.ContentType = "application/vnd.ms-excel";
            fileName = Server.MapPath("~\\SampleExcel\\Residents.xls");
            Response.AppendHeader("Content-Disposition", "attachment; filename=Residents.xls");
            Response.TransmitFile(fileName);
            Response.End();
        }
        catch (Exception ex)
        {
        }
        rwImportExcel.Visible = true;
    }
    protected void chkShowAll_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkShowAll.Checked == true)
            {
                LoadVillaNo(2);
            }
            else
            {
                LoadVillaNo(1);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlvillano_SelectedIndexChanged(object sender, EventArgs e)
    {

        SqlProcsNew sqlobj = new SqlProcsNew();

        DataSet dsgetdoornostatus = sqlobj.ExecuteSP("SP_GetDoorNoStatus",
                 new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = ddlvillano.SelectedValue });


        if (dsgetdoornostatus.Tables[0].Rows.Count > 0)
        {
            string mode = dsgetdoornostatus.Tables[0].Rows[0]["doorstatus"].ToString();

            DataSet dsgetdropdownstatus = sqlobj.ExecuteSP("SP_GetDependentStatus",
              new SqlParameter() { ParameterName = "@mcode", SqlDbType = SqlDbType.NVarChar, Value = mode });


            if (dsgetdropdownstatus.Tables[0].Rows.Count > 0)
            {

                ddlstatus.DataSource = dsgetdropdownstatus.Tables[0];
                ddlstatus.DataValueField = "SCode";
                ddlstatus.DataTextField = "SDescription";
                ddlstatus.DataBind();
                ddlstatus.Dispose();

            }


            ddlstatus.Items.Insert(0, new ListItem("--Select--", "0"));

            dsgetdropdownstatus.Dispose();

        }
        else
        {
            DataSet dsgetdropdownstatus = sqlobj.ExecuteSP("SP_GetResidentStatus");

            if (dsgetdropdownstatus.Tables[0].Rows.Count > 0)
            {

                ddlstatus.DataSource = dsgetdropdownstatus.Tables[0];
                ddlstatus.DataValueField = "SCode";
                ddlstatus.DataTextField = "SDescription";
                ddlstatus.DataBind();
                ddlstatus.Dispose();

            }


            ddlstatus.Items.Insert(0, new ListItem("--Select--", "0"));

            dsgetdropdownstatus.Dispose();
        }

        dsgetdoornostatus.Dispose();

    }
    protected void Lnkbtndependant_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)(sender);
        string strrtrsn = btn.CommandArgument;

        DataSet dsSection = sqlobj.ExecuteSP("SP_ResidentEditLink", new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = strrtrsn.ToString() });

        //DataSet dsSection = sqlobj.ExecuteSP("SP_ResidentEditLink", new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Session["DRTRSN"].ToString() });

        if (dsSection.Tables[0].Rows.Count > 0)
        {
            lblName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
            lblDoorNo.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
            lblResidentStatus.Text = dsSection.Tables[0].Rows[0]["sDescription"].ToString();

            Session["RAdd1"] = dsSection.Tables[0].Rows[0]["RTAddress1"].ToString();
            Session["RAdd2"] = dsSection.Tables[0].Rows[0]["RTAddress2"].ToString();
            Session["RCity"] = dsSection.Tables[0].Rows[0]["CityName"].ToString();
            Session["RPinCode"] = dsSection.Tables[0].Rows[0]["Pincode"].ToString();
            Session["RCountry"] = dsSection.Tables[0].Rows[0]["Country"].ToString();
            Session["GLDepAcc"] = dsSection.Tables[0].Rows[0]["GLDepositAccount"].ToString();
            Session["GLAcc"] = dsSection.Tables[0].Rows[0]["GLAccount"].ToString();

            string rstatus = dsSection.Tables[0].Rows[0]["RTStatus"].ToString();


            if (rstatus.ToString() == "OR" || rstatus.ToString() == "T" || rstatus.ToString() == "RS" || rstatus.ToString() == "OA" || rstatus.ToString() == "TA" || rstatus.ToString() == "PT" || rstatus.ToString() == "PO")
            {
                LoadDependentStaus(dsSection.Tables[0].Rows[0]["RTStatus"].ToString());

                lblRName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                lblRDoorNo.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                lblRStatus.Text = dsSection.Tables[0].Rows[0]["sDescription"].ToString();
                lblRMobileNo.Text = dsSection.Tables[0].Rows[0]["Contactcellno"].ToString();
                lblREmailID.Text = dsSection.Tables[0].Rows[0]["Contactmail"].ToString();

                rwAddDependent.Visible = true;
            }
            else
            {
                lblRName.Text = "";
                lblRDoorNo.Text = "";
                lblRStatus.Text = "";
                lblRMobileNo.Text = "";
                lblREmailID.Text = "";

                rwAddDependent.Visible = false;
            }
        }

        dsSection.Dispose();


        //AddDependent();
        //try
        //{

        //    LinkButton btn = (LinkButton)(sender);
        //    string strrtrsn = btn.CommandArgument;

        //   DataSet dsSection = sqlobj.ExecuteSP("SP_ResidentEditLink", new SqlParameter(){ ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = strrtrsn.ToString() });

        //    if (dsSection.Tables[0].Rows.Count >0)
        //    {
        //        lblName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
        //        lblDoorNo.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
        //        lblResidentStatus.Text = dsSection.Tables[0].Rows[0]["sDescription"].ToString();

        //        Session["RAdd1"] = dsSection.Tables[0].Rows[0]["RTAddress1"].ToString();
        //        Session["RAdd2"] = dsSection.Tables[0].Rows[0]["RTAddress2"].ToString();
        //        Session["RCity"] = dsSection.Tables[0].Rows[0]["CityName"].ToString();
        //        Session["RPinCode"] = dsSection.Tables[0].Rows[0]["Pincode"].ToString();
        //        Session["RCountry"] = dsSection.Tables[0].Rows[0]["Country"].ToString();

        //        LoadDependentStaus( dsSection.Tables[0].Rows[0]["RTStatus"].ToString());


        //        rwAddDependent.Visible = true;
        //    }

        //    dsSection.Dispose();


        //}
        //catch(Exception ex)
        //{
        //    WebMsgBox.Show(ex.Message);
        //}
    }

    private void LoadDependentStaus(string ResidentStatus)
    {
        try
        {


            DataSet dsResidentDependentStatus = sqlobj.ExecuteSP("SP_GetResidentDependentStatus", new SqlParameter()
            {
                ParameterName = "@SCode",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = ResidentStatus.ToString()
            });


            ddlDependentStatus.Items.Clear();

            if (dsResidentDependentStatus.Tables[0].Rows.Count > 0)
            {
                ddlDependentStatus.DataSource = dsResidentDependentStatus.Tables[0];
                ddlDependentStatus.DataValueField = "SCode";
                ddlDependentStatus.DataTextField = "SDescription";
                ddlDependentStatus.DataBind();
            }

            ddlDependentStatus.Items.Insert(0, "--Select--");


            dsResidentDependentStatus.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btndependentSave_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {


                string strAdd1 = Session["RAdd1"].ToString();
                string strAdd2 = Session["RAdd1"].ToString();
                string strcity = Session["RCity"].ToString();
                string strpincode = Session["RPinCode"].ToString();
                string strcountry = Session["RCountry"].ToString();

                sqlobj.ExecuteSP("SP_InsertResidentDtls",
                                          new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = ddldependenttitle.SelectedValue },
                                          new SqlParameter() { ParameterName = "@RTName", SqlDbType = SqlDbType.NVarChar, Value = txtDependentName.Text },
                                          new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = ddlDependentGender.SelectedValue },
                                          new SqlParameter() { ParameterName = "@Marital", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@RTVILLANO", SqlDbType = SqlDbType.NVarChar, Value = lblDoorNo.Text },
                                          new SqlParameter() { ParameterName = "@RTSTATUS", SqlDbType = SqlDbType.NVarChar, Value = ddlDependentStatus.SelectedValue },
                                          new SqlParameter() { ParameterName = "@RTAddress1", SqlDbType = SqlDbType.NVarChar, Value = Session["RAdd1"].ToString() },
                                          new SqlParameter() { ParameterName = "@RTAddress2", SqlDbType = SqlDbType.NVarChar, Value = Session["RAdd2"].ToString() },
                                          new SqlParameter() { ParameterName = "@CityName", SqlDbType = SqlDbType.NVarChar, Value = Session["RCity"].ToString() },
                                          new SqlParameter() { ParameterName = "@Pincode", SqlDbType = SqlDbType.NVarChar, Value = Session["RPinCode"].ToString() },
                                          new SqlParameter() { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = Session["RCountry"].ToString() },
                                          new SqlParameter() { ParameterName = "@Contactno", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@Contactcellno", SqlDbType = SqlDbType.NVarChar, Value = txtDependentMobileNo.Text },
                                          new SqlParameter() { ParameterName = "@Contactmail", SqlDbType = SqlDbType.NVarChar, Value = txtDependentEmailID.Text },
                                          new SqlParameter() { ParameterName = "@AlternateEMAILID", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                          new SqlParameter() { ParameterName = "@DOB", SqlDbType = SqlDbType.DateTime, Value = dtpDependentdob.SelectedDate },
                                          new SqlParameter() { ParameterName = "@BloodGroup", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@SMSAlert", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@EMAILAlert", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@Occupants", SqlDbType = SqlDbType.Decimal, Value = null },
                                          new SqlParameter() { ParameterName = "@DiningAD", SqlDbType = SqlDbType.Decimal, Value = "0.00" },
                                          new SqlParameter() { ParameterName = "@ServiceAD", SqlDbType = SqlDbType.Decimal, Value = "0.00" },
                                          new SqlParameter() { ParameterName = "@WatsApp", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@Facebook", SqlDbType = SqlDbType.NVarChar, Value = Facebook.Text },
                                          new SqlParameter() { ParameterName = "@Skype", SqlDbType = SqlDbType.NVarChar, Value = null },
                                          new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = null },
                                           new SqlParameter() { ParameterName = "@GLDepAcc", SqlDbType = SqlDbType.NVarChar, Value = Session["GLDepAcc"].ToString() },
                                          new SqlParameter() { ParameterName = "@GLAcc", SqlDbType = SqlDbType.NVarChar, Value = Session["GLAcc"].ToString() },
                                           new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },                                          
                                         new SqlParameter() { ParameterName = "@Images", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "" },
                                         new SqlParameter() { ParameterName = "@ImagePath", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NULL" },
                                         new SqlParameter() { ParameterName = "@FBilling", SqlDbType = SqlDbType.NVarChar, Value = "N" });

                ClearDependent();


                WebMsgBox.Show("New Dependent Successfully added");

            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void ClearDependent()
    {
        txtDependentName.Text = "";
        ddlDependentStatus.SelectedIndex = 0;
        ddlDependentGender.SelectedIndex = 0;
        txtDependentMobileNo.Text = "";
        txtDependentEmailID.Text = "";
        dtpDependentdob.SelectedDate = null;

        //rwAddDependent.VisibleOnPageLoad = true;
        rwAddDependent.Visible = false;

        LoadGrid();
    }

    protected void btndependentClear_Click(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btndependentExit_Click(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    #endregion
    protected void ddlItems_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlItems.SelectedValue == "Dining Booking")
            {
                Response.Redirect("DiningBookingNew.aspx");
            }
            else if (ddlItems.SelectedValue == "Dining Confirm")
            {
                Response.Redirect("DiningConfirmation.aspx");
            }
            else if (ddlItems.SelectedValue == "A la Carte Billing")
            {
                Response.Redirect("FoodMenu.aspx?MenuName=Booking A la carte menu");
            }
            else if (ddlItems.SelectedValue == "Service Request")
            {
                Response.Redirect("TaskList.aspx?Value1=3&Value2=" + Session["DRTRSN"].ToString());
            }
            else if (ddlItems.SelectedValue == "Payments")
            {
                Response.Redirect("FoodMenu.aspx?MenuName=Accept Payment");
            }
            else if (ddlItems.SelectedValue == "Profile++")
            {
                Session["ResidentRSN"] = Session["DRTRSN"].ToString();
                Session["PrevPageName"] = "ResidentAdd.aspx";
                Response.Redirect("AttributesAdd.aspx");

            }
            else if (ddlItems.SelectedValue == "Snapshot")
            {
                Response.Redirect("SnapShot.aspx");
            }
            else if (ddlItems.SelectedValue == "Add Dependents")
            {

                AddDependent();


            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadsubMenus()
    {
        try
        {
            DataSet dsSection = sqlobj.ExecuteSP("SP_ResidentEditLink", new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Session["DRTRSN"].ToString() });

            if (dsSection.Tables[0].Rows.Count > 0)
            {


                Session["RAdd1"] = dsSection.Tables[0].Rows[0]["RTAddress1"].ToString();
                Session["RAdd2"] = dsSection.Tables[0].Rows[0]["RTAddress2"].ToString();
                Session["RCity"] = dsSection.Tables[0].Rows[0]["CityName"].ToString();
                Session["RPinCode"] = dsSection.Tables[0].Rows[0]["Pincode"].ToString();
                Session["RCountry"] = dsSection.Tables[0].Rows[0]["Country"].ToString();

                string rstatus = dsSection.Tables[0].Rows[0]["RTStatus"].ToString();


                if (rstatus.ToString() == "OR" || rstatus.ToString() == "T" || rstatus.ToString() == "RS")
                {
                    LoadDependentStaus(dsSection.Tables[0].Rows[0]["RTStatus"].ToString());

                    lblRName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                    lblRDoorNo.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                    lblRStatus.Text = dsSection.Tables[0].Rows[0]["sDescription"].ToString();
                    lblRMobileNo.Text = dsSection.Tables[0].Rows[0]["Contactcellno"].ToString();
                    lblREmailID.Text = dsSection.Tables[0].Rows[0]["Contactmail"].ToString();

                    rwPopup.Visible = true;
                }
                else
                {
                    lblRName.Text = "";
                    lblRDoorNo.Text = "";
                    lblRStatus.Text = "";
                    lblRMobileNo.Text = "";
                    lblREmailID.Text = "";

                    rwPopup.Visible = false;
                }
            }

            dsSection.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void AddDependent()
    {

        DataSet dsSection = sqlobj.ExecuteSP("SP_ResidentEditLink", new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Session["DRTRSN"].ToString() });

        if (dsSection.Tables[0].Rows.Count > 0)
        {
            lblName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
            lblDoorNo.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
            lblResidentStatus.Text = dsSection.Tables[0].Rows[0]["sDescription"].ToString();

            Session["RAdd1"] = dsSection.Tables[0].Rows[0]["RTAddress1"].ToString();
            Session["RAdd2"] = dsSection.Tables[0].Rows[0]["RTAddress2"].ToString();
            Session["RCity"] = dsSection.Tables[0].Rows[0]["CityName"].ToString();
            Session["RPinCode"] = dsSection.Tables[0].Rows[0]["Pincode"].ToString();
            Session["RCountry"] = dsSection.Tables[0].Rows[0]["Country"].ToString();

            string rstatus = dsSection.Tables[0].Rows[0]["RTStatus"].ToString();


            if (rstatus.ToString() == "OR" || rstatus.ToString() == "T" || rstatus.ToString() == "RS")
            {
                LoadDependentStaus(dsSection.Tables[0].Rows[0]["RTStatus"].ToString());

                lblRName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                lblRDoorNo.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                lblRStatus.Text = dsSection.Tables[0].Rows[0]["sDescription"].ToString();
                lblRMobileNo.Text = dsSection.Tables[0].Rows[0]["Contactcellno"].ToString();
                lblREmailID.Text = dsSection.Tables[0].Rows[0]["Contactmail"].ToString();

                rwAddDependent.Visible = true;
            }
            else
            {
                lblRName.Text = "";
                lblRDoorNo.Text = "";
                lblRStatus.Text = "";
                lblRMobileNo.Text = "";
                lblREmailID.Text = "";

                rwAddDependent.Visible = false;
            }
        }

        dsSection.Dispose();
    }


    protected void textBox1_TextChanged(object sender, EventArgs e)
    {
        if (System.Text.RegularExpressions.Regex.IsMatch(Contactno.Text, "[^0-9]"))
        {
            WebMsgBox.Show("Please enter only numbers.");
            Contactno.Text.Remove(Contactno.Text.Length - 1);
        }
    }

    protected void rcntgrdView_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rcntgrdView.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
    protected void rcntgrdView_ItemCreated(object sender, GridItemEventArgs e)
    {
        //GridItemType item = e.Item.ItemType;

        //if (rcntgrdView.Items.Count > 0)
        //{
        //    if (e.Item is GridPagerItem)
        //    {
        //        GridPagerItem pager = (GridPagerItem)e.Item;
        //        lnkcount.Text = "Count:" +  ;

        //    }
        //}
        //else
        //{
        //   lnkcount.Text = "Count:0";
        //}  
    }
    protected void rcntgrdView_ItemEvent(object sender, GridItemEventArgs e)
    {
        if (e.EventInfo is GridInitializePagerItem)
        {
            Int32 totalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;

            lnkcount.Text = "Count:" + totalItemCount.ToString();
        }
    }
    protected void btnReportList_Click(object sender, EventArgs e)
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsStockTransaction = sqlobj.ExecuteSP("Sp_ReportList");

            DateTime sdate = DateTime.Now;

            if (dsStockTransaction.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();
                dsStockTransaction.Tables[0].Columns.Remove("rtrsn");
                dsStockTransaction.Tables[0].Columns["rtStatus"].ColumnName = "Status";
                dg.DataSource = dsStockTransaction.Tables[0];
                dg.DataBind();




                // THE EXCEL FILE.
                string sFileName = "Resident List (Short Rpt) on " + sdate.ToString("dd/MM/yyyy") + ".xls";
                sFileName = sFileName.Replace("/", "");



                // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
                Response.ContentType = "application/vnd.ms-excel";
                EnableViewState = false;

                System.IO.StringWriter objSW = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

                dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
                dg.RenderControl(objHTW);


                //"," + strdesc.ToString() +


                DateTime dates = DateTime.Now;

                string times = DateTime.Now.ToString("hh:mm:ss tt");

                Response.Write("<table><tr><td>Resident List (Short Rpt) on " + sdate.ToString("dd/MM/yyyy") + "</td><td> Printed on:" + DateTime.Today.ToString("dd/MM/yyyy") + "-" + times.ToString() + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show(" From" + sdate.ToString("dd/MM/yyyy") + " Resident List does not exist");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnOtherStatus_Click(object sender, EventArgs e)
    {
        try
        {
            LoadGridOtherStatus();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnOSClear_Click(object sender, EventArgs e)
    {
        try
        {
            LoadGrid();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void chkSameDetails_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if(chkSameDetails.Checked==true)
            {
                txtOffEmailId.Text = Contactmail.Text;
                txtOffMobNo.Text = Contactcellno.Text;
                RdOffDOB.SelectedDate = FromDate.SelectedDate;
            }
            else
            {
                txtOffEmailId.Text = "";
                txtOffMobNo.Text = "";
                RdOffDOB.SelectedDate = null;
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    protected void btnClearFilter_Click(object sender, EventArgs e)
    {
        foreach (GridColumn column in rcntgrdView.MasterTableView.OwnerGrid.Columns)
        {
            column.CurrentFilterFunction = GridKnownFunction.NoFilter;
            column.CurrentFilterValue = string.Empty;
        }
        rcntgrdView.MasterTableView.FilterExpression = string.Empty;
        LoadGrid();
    }
}