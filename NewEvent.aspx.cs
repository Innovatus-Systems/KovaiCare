using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Web.Services;
using System.Web.Script.Services;
using System.Configuration;
using System.Net.Mail;
using System.IO;
using Telerik.Web.UI;
using System.Threading;
using System.Windows.Forms;
using System.Net;
using System.Reflection;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using System.Globalization;
using System.Drawing;
using OfficeOpenXml;
using System.Data.OleDb;
using System.Linq;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;



public partial class NewEvent : System.Web.UI.Page
{
    public static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    static string strLastEvent;

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {

                FileUpload fileUpload = new FileUpload();
                fileUpload = FileUpd;

                LoadTitle(42);
                LoadGrid();

                //FromDate.MinDate = DateTime.Today;
                //TillDate.MinDate = DateTime.Today;

                FromDate.SelectedDate = DateTime.Today;
                TillDate.SelectedDate = DateTime.Today;

                btnUpdate.Visible = false;
                btnAddEvent.Visible = true;

                lblcstatus.Visible = false;
                ddlupstatus.Visible = false;

                TotalResident();

                LoadAssignedTo();



                ddlAssignedTo.SelectedIndex = 0;
                ddlAttending.SelectedIndex = 1;
                ddlAttended.SelectedIndex = 1;


                rwEventRating.VisibleOnPageLoad = true;
                rwEventRating.Visible = false;

                rgresidents.DataSource = string.Empty;
                rgresidents.DataBind();
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    private void TotalResident()
    {
        try
        {

             DataSet dsTResidents = sqlobj.ExecuteSP("SP_GetTotalResidents");

            if (dsTResidents.Tables[0].Rows.Count >0)
            {
                chkIsSentMail.Text = "Inform all " + dsTResidents.Tables[0].Rows[0]["Total"].ToString() + " residents via email.";

                lnkwhatsapp.Text = " Inform all " + dsTResidents.Tables[0].Rows[0]["Total"].ToString() + " residents via WhatsApp";
            }


            dsTResidents.Dispose();

            

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle(int id)
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = id.ToString() });


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

    protected void LoadAssignedTo()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchAT = new DataSet();

            dsFetchAT = sqlobj.ExecuteSP("SP_FecthVillaNO",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
            ddlAssignedTo.DataSource = dsFetchAT.Tables[0];
            ddlAssignedTo.DataValueField = "RSN";
            ddlAssignedTo.DataTextField = "Name";
            ddlAssignedTo.DataBind();
            ddlAssignedTo.Dispose();
            ddlAssignedTo.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void btnAddClear_Click(object sender, EventArgs e)
    {
        clear();
    }

    private void clear()
    {
      
        FromDate.SelectedDate = DateTime.Now;
        TillDate.SelectedDate = DateTime.Now;
        txtEventName.Text = string.Empty;
        txtdesc.Text = string.Empty;
        TxtImge.Text = "";
        txtEventName.Focus();
        dtpFromTime.SelectedTime = null;
        btnUpdate.Visible = false;
        btnAddEvent.Visible = true;

        lblcstatus.Visible = false;
        ddlupstatus.Visible = false;
    }

    public static void EventMail(string EventName, string Description, DateTime fromeventdate, DateTime toevnetdate)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            string tomail = "";
            string touser = "";
            string title = "";
            string AdminName = "";
            string AdminContact = "";


            DataSet dsAdmin = new DataSet();
            dsAdmin = sqlobj.ExecuteSP("GetAdminDetails");
            if (dsAdmin != null && dsAdmin.Tables[0].Rows.Count > 0)
            {
                AdminName = dsAdmin.Tables[0].Rows[0]["CommunityName"].ToString();
                AdminContact = dsAdmin.Tables[0].Rows[0]["FromMobileNo"].ToString();
            }

            DataSet dsemail = sqlobj.ExecuteSP("SP_GetResidentMail");

            if (dsemail.Tables[0].Rows.Count > 0)
            {
                tomail = dsemail.Tables[0].Rows[0]["Contactmail"].ToString();
                touser = dsemail.Tables[0].Rows[0]["RTName"].ToString();
                title = dsemail.Tables[0].Rows[0]["RTTitle"].ToString();

                dsemail.Dispose();

                if (tomail.ToString() != "")
                {
                    string strmcusername = "";
                    string strmcpassword = "";
                    string strmcfromname = "";

                    DataSet dsmc = sqlobj.ExecuteSP("SP_GetMailCredential");


                    if (dsmc.Tables[0].Rows.Count > 0)
                    {
                        strmcusername = dsmc.Tables[0].Rows[0]["username"].ToString();
                        strmcpassword = dsmc.Tables[0].Rows[0]["password"].ToString();
                        strmcfromname = dsmc.Tables[0].Rows[0]["sentbyuser"].ToString();
                    }

                    dsmc.Dispose();

                    MailClass M = new MailClass();

                    M.EventsMail(strmcusername, strmcfromname, tomail.ToString(), touser.ToString(), touser.ToString(), EventName.ToString(), Description.ToString(),
                       fromeventdate, strmcusername.ToString(), strmcpassword.ToString(), AdminName, AdminContact, AdminContact, title);
                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadGrid()
    {
        //DataSet ds = new DataSet();
        //ds = null;
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_Events", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 1);

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds, "temp");
            //gvEvents.DataSource = ds.Tables[0];
            //gvEvents.DataBind();
            radgvEvents.MasterTableView.GetColumn("Remarks").Display = false;
            radgvEvents.DataSource = ds.Tables[0];
            radgvEvents.DataBind();
        }
        catch (Exception ex)
        {

        }



       // LoadTitle(43);
       // strLastEvent = "Oncoming";
        //ds.Dispose();
    }

    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {

        DataSet dsStatement = sqlobj.ExecuteSP("Proc_Events",
                  new SqlParameter() { ParameterName = "@i", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 12 });

        if (dsStatement.Tables[0].Rows.Count > 0)
        {
            System.Web.UI.WebControls.DataGrid dg = new System.Web.UI.WebControls.DataGrid();

            dg.DataSource = dsStatement.Tables[0];
            dg.DataBind();

            DateTime dt = DateTime.Now;
            // THE EXCEL FILE.
            string sFileName = "Events_"+ dt + ".xls";
            //sFileName = sFileName.Replace("/", "");

            // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
            Response.ContentType = "application/vnd.ms-excel";
            EnableViewState = false;

            System.IO.StringWriter objSW = new System.IO.StringWriter(); 
            System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

            dg.HeaderStyle.Font.Bold = true;
            dg.HeaderStyle.BackColor = Color.GreenYellow; // SET EXCEL HEADERS AS BOLD.
            dg.RenderControl(objHTW);


            Response.Write("<table><tr><td>Upcoming Events List</td></tr></table>");

            //+ "</td><td>" + lbltotoutstanding.Text + " " + lbltotdebitcredit.Text + "</td></tr></table>");


            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:Solid 1px #999; } " +
                "TD { border:Solid 1px #D5D5D5; text-align:center } </style>");
            Response.Write(objSW.ToString());


            Response.End();
            dg = null;


        }
        else
        {
            WebMsgBox.Show("No Events.");
        }
    }

    protected void lnkwhatsapp_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime edate = Convert.ToDateTime(TillDate.SelectedDate);

            string strinform = txtEventName.Text + " " + edate.ToString("dd/MM/yyyy") + " " + txtdesc.Text;

            if (System.Windows.Forms.Clipboard.GetDataObject() != null)
            {
                Clipboard.Clear();
            }



            Thread thread = new Thread(() => Clipboard.SetText(strinform));
            thread.SetApartmentState(ApartmentState.STA); //Set the thread to STA
            thread.Start();
            thread.Join();

            Page.ClientScript.RegisterStartupScript(
            this.GetType(), "OpenWindow", "window.open('https://web.whatsapp.com/','_newtab');", true);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnAddEvent_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {
                if (dtpFromTime.SelectedTime.ToString() == "")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Time');", true);
                    return;                    
                }
                string filename = string.Empty;
                String File = "";
                if (FileUpd.HasFile)
                {
                    if (FileUpd.PostedFile.FileName.Length > 0)
                    {
                        filename = Path.GetFileName(FileUpd.PostedFile.FileName);
                        FileUpd.SaveAs(Server.MapPath(@"~//EventImages/") + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename);
                        File = (@"~//EventImages/") + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename;
                    }
                    else
                    {
                        File = "";
                    }
                }
                sqlobj.ExecuteNonQuery("Proc_Events", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
                           new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate.Value },
                           new SqlParameter() { ParameterName = "@Tilldate", SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate.Value },
                            new SqlParameter() { ParameterName = "@FromTime", SqlDbType = SqlDbType.NVarChar, Value = dtpFromTime.SelectedTime.ToString() },
                           new SqlParameter() { ParameterName = "@EventName", SqlDbType = SqlDbType.NVarChar, Value = txtEventName.Text },
                           new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                           new SqlParameter() { ParameterName = "@EventType", SqlDbType = SqlDbType.NVarChar, Value = "E" },
                           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "00" },
                           new SqlParameter() { ParameterName = "@IsSentMail", SqlDbType = SqlDbType.NVarChar, Value = chkIsSentMail.Checked.ToString() },
                           new SqlParameter() { ParameterName = "@Images", SqlDbType = SqlDbType.NVarChar, Value = File }
                           );
                DateTime fdate = Convert.ToDateTime(FromDate.SelectedDate.Value);
                DateTime tdate = Convert.ToDateTime(FromDate.SelectedDate.Value);
                if (chkIsSentMail.Checked==true)
                { 
                EventMail(txtEventName.Text, txtdesc.Text, fdate, tdate);
                }
                LoadGrid();
                clear();
                WebMsgBox.Show("Event added.");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnAddCancel_Click(object sender, EventArgs e)
    {
        //clear();

        Response.Redirect("Dashboard.aspx");
    }
    protected void FromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        TillDate.SelectedDate = FromDate.SelectedDate;
    }
    protected void imgwapp_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            DateTime edate = Convert.ToDateTime(TillDate.SelectedDate);

            string strinform = txtEventName.Text + " " + edate.ToString("dd/MM/yyyy") + " " + txtdesc.Text;


            if (System.Windows.Forms.Clipboard.GetDataObject() != null)
            {
                Clipboard.Clear();
            }

            Thread thread = new Thread(() => Clipboard.SetText(strinform));
            thread.SetApartmentState(ApartmentState.STA); //Set the thread to STA
            thread.Start();
            thread.Join();

            Page.ClientScript.RegisterStartupScript(
            this.GetType(), "OpenWindow", "window.open('https://web.whatsapp.com/','_newtab');", true);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void radgvEvents_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridFilteringItem)
        {
            GridFilteringItem filterItem = (GridFilteringItem)e.Item;
            filterItem["TillDate"].HorizontalAlign = HorizontalAlign.Center;

        }
        if (e.Item is GridDataItem)
        {
            GridDataItem griditem = e.Item as GridDataItem;
            TableCell cell = griditem["TillDate"];
            string sts = griditem["Status"].Text.ToString();
            DateTime value = Convert.ToDateTime(griditem["TillDate"].Text.ToString());
            if (value < DateTime.Today && sts == "Scheduled")
            {
                cell.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
    protected void radgvEvents_ItemCommand(object sender, GridCommandEventArgs e)
    {
        Int64 RSN;        
        if (e.CommandName == "UpdateRow")
        {
            RSN = Convert.ToInt64(e.CommandArgument.ToString());
            Session["RSN"] = RSN.ToString();       
           DataSet dsEventConfirmation = sqlobj.ExecuteSP("Proc_Events", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 5 },
                          new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = RSN });                       
            if (dsEventConfirmation.Tables[0].Rows.Count > 0)
            {
                    string strchkdate = "1900-01-01";
                    if (Convert.ToDateTime(dsEventConfirmation.Tables[0].Rows[0]["FromDate"].ToString()) > Convert.ToDateTime(strchkdate))
                    {
                        FromDate.SelectedDate = Convert.ToDateTime(dsEventConfirmation.Tables[0].Rows[0]["FromDate"].ToString());
                        TillDate.SelectedDate = Convert.ToDateTime(dsEventConfirmation.Tables[0].Rows[0]["TillDate"].ToString());
                    }
                    if(dsEventConfirmation.Tables[0].Rows[0]["Time"].ToString()==""|| dsEventConfirmation.Tables[0].Rows[0]["Time"].ToString()==null)
                    {
                    dtpFromTime.SelectedDate = null;
                    }
                    else
                    {
                    dtpFromTime.SelectedDate = DateTime.Parse(dsEventConfirmation.Tables[0].Rows[0]["Time"].ToString());
                    }
                txtEventName.Text = dsEventConfirmation.Tables[0].Rows[0]["EventName"].ToString();
                    txtdesc.Text = dsEventConfirmation.Tables[0].Rows[0]["Description"].ToString();
                    TxtImge.Text = dsEventConfirmation.Tables[0].Rows[0]["Image"].ToString();
                    string stvalue = dsEventConfirmation.Tables[0].Rows[0]["Status"].ToString();                    
                    ddlupstatus.SelectedValue = dsEventConfirmation.Tables[0].Rows[0]["Status"].ToString();
                    btnUpdate.Visible = true;
                    btnAddEvent.Visible = false;
                    lblcstatus.Visible = true;
                    ddlupstatus.Visible = true;
                }          

             dsEventConfirmation.Dispose();          
           
        }
        else if (e.CommandName == "Events")
        {

            RSN = Convert.ToInt64(e.CommandArgument.ToString());
            Session["RSN"] = RSN.ToString();
            DataSet dsEventConfirmation = sqlobj.ExecuteSP("Proc_Events", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 5 },
                          new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = RSN });
            if (dsEventConfirmation.Tables[0].Rows.Count > 0)
            {
                lblEventName.Text = dsEventConfirmation.Tables[0].Rows[0]["EventName"].ToString();
                lblEventDate.Text = dsEventConfirmation.Tables[0].Rows[0]["FromDate"].ToString();
            }
            if (dsEventConfirmation.Tables[1].Rows.Count > 0)
            {
                lblTotalResident.Text = "(" + dsEventConfirmation.Tables[1].Rows[0]["NoofResidnts"].ToString() + ")";
            }
            if (dsEventConfirmation.Tables[2].Rows.Count > 0)
            {
                lblTotalAttending.Text = "(" + dsEventConfirmation.Tables[2].Rows[0]["Attending"].ToString() + ")";
            }
            if (dsEventConfirmation.Tables[3].Rows.Count > 0)
            {
                lblTotalAttended.Text = "(" + dsEventConfirmation.Tables[3].Rows[0]["Attended"].ToString() + ")";
            }
            dsEventConfirmation.Dispose();
            rwEventRating.Visible = true;
        }
        else if (e.CommandName=="Image")
        {
            //string jsFunc = "OpenModelPopup(" + e.CommandArgument.ToString() + ")";
            //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "myJsFn", jsFunc, true);
            string imagename = "280616090653_city.jpg";
            ScriptManager.RegisterStartupScript(this, this.Page.GetType(), "updatePanel1Script", "javascript:OpenModelPopup(" + imagename.ToString() + ")", true);
        }
        else 
        {
            LoadGrid();
        }        
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                if (dtpFromTime.SelectedTime.ToString() == "")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Time');", true);
                    return;
                }
                DateTime cdate = DateTime.Today;
                DateTime tdate = Convert.ToDateTime(TillDate.SelectedDate);
                string strstatus = ddlupstatus.SelectedValue;               
                string filename = Path.GetFileName(FileUpd.FileName);
                String File;
                string strfile="";
                if (!FileUpd.HasFile)
                {
                    File = TxtImge.Text;
                }
                else
                {
                    strfile = DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename;                    
                    File = (@"~//EventImages/") + strfile.ToString();
                    FileUpd.SaveAs(Server.MapPath(@"~//EventImages/") + strfile.ToString());
                }           
                string rsn = Session["RSN"].ToString();
                sqlobj.ExecuteNonQuery("Proc_Events", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3},
                              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate.Value },
                              new SqlParameter() { ParameterName = "@Tilldate", SqlDbType = SqlDbType.DateTime, Value = TillDate.SelectedDate.Value },
                               new SqlParameter() { ParameterName = "@FromTime", SqlDbType = SqlDbType.NVarChar, Value = dtpFromTime.SelectedTime.ToString() },
                              new SqlParameter() { ParameterName = "@EventName", SqlDbType = SqlDbType.NVarChar, Value = txtEventName.Text },
                              new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                              new SqlParameter() { ParameterName = "@EventType", SqlDbType = SqlDbType.NVarChar, Value = "E" },
                              new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlupstatus.SelectedValue },
                              new SqlParameter() { ParameterName = "@IsSentMail", SqlDbType = SqlDbType.NVarChar, Value = chkIsSentMail.Checked.ToString() },
                              new SqlParameter() { ParameterName = "@Images", SqlDbType = SqlDbType.NVarChar, Value = File },
                              new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = "" },
                              new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["RSN"].ToString() }
                              );

                LoadGrid();
                clear();
                WebMsgBox.Show("Event details updated successfully");
            }
        }
        catch(Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString()+ "');", true);           
        }
    }
    protected void btnviewall_Click(object sender, EventArgs e)
    {
        try
        {
            btnRestrict.Visible = true;
            btnviewall.Visible = false;
            SqlCommand cmd = new SqlCommand("Proc_Events", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 10);

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds, "temp");
            //gvEvents.DataSource = ds.Tables[0];
            //gvEvents.DataBind();
            radgvEvents.MasterTableView.GetColumn("Remarks").Display = false;
            radgvEvents.DataSource = ds.Tables[0];
            radgvEvents.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    protected void UpdatePanel_Unload(object sender, EventArgs e)
    {
        MethodInfo methodInfo = typeof(ScriptManager).GetMethods(BindingFlags.NonPublic | BindingFlags.Instance)
            .Where(i => i.Name.Equals("System.Web.UI.IScriptManagerInternal.RegisterUpdatePanel")).First();
        methodInfo.Invoke(ScriptManager.GetCurrent(Page),
            new object[] { sender as UpdatePanel });
    }
    protected void btnEventRatingUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                sqlobj.ExecuteNonQuery("sp_InsertEventRating", new SqlParameter() { ParameterName = "@EventID", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() },
                                  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = ddlAssignedTo.SelectedValue },
                                  new SqlParameter() { ParameterName = "@Attending", SqlDbType = SqlDbType.Char, Value = ddlAttending.SelectedValue },
                                  new SqlParameter() { ParameterName = "@Attended", SqlDbType = SqlDbType.Char, Value = ddlAttended.SelectedValue },
                                  new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

                LoadGrid();

                ddlAssignedTo.SelectedIndex = 0;
                ddlAttending.SelectedIndex = 1;
                ddlAttended.SelectedIndex = 1;
                //lblEventName.Text = "";
                //lblEventDate.Text = "";
                lblmsg.Text = "";

                rgresidents.DataSource = string.Empty;
                rgresidents.DataBind();

                WebMsgBox.Show("Events confirmation successfully updated");
            }
        
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void ddlAssignedTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

          DataSet  dsrdetails = sqlobj.ExecuteSP("SP_GetResidentDependent", 
              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = ddlAssignedTo.SelectedValue },
               new SqlParameter() { ParameterName = "@EventID", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() }
              );


            if (dsrdetails.Tables[0].Rows.Count >0)
            {
                rgresidents.DataSource = dsrdetails.Tables[0];
                rgresidents.DataBind();
            }
            else
            {
                rgresidents.DataSource = string.Empty;
                rgresidents.DataBind();
            }


            if (dsrdetails.Tables[1].Rows.Count >0)
            {
                ddlAttending.SelectedValue = dsrdetails.Tables[1].Rows[0]["Attending"].ToString();
                ddlAttended.SelectedValue = dsrdetails.Tables[1].Rows[0]["Attended"].ToString(); 
            }

            if (ddlAttending.SelectedValue == "N" && ddlAttended.SelectedValue == "N" )
            {
                lblmsg.Text = "Yet to Confirm";
            }
            else if (ddlAttending.SelectedValue == "Y" && ddlAttended.SelectedValue == "N")
            {
                lblmsg.Text = "Yet to Update";
            }
            else if(ddlAttending.SelectedValue == "N" && ddlAttended.SelectedValue == "Y")
            {
                lblmsg.Text  ="Yet to Update";
            }
            else if (ddlAttending.SelectedValue == "N" && ddlAttended.SelectedValue == "Y")
            {
                lblmsg.Text = "";
            }

            dsrdetails.Dispose();


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnEventRatingClose_Click(object sender, EventArgs e)
    {
        ddlAssignedTo.SelectedIndex = 0;
        ddlAttending.SelectedIndex = 1;
        ddlAttended.SelectedIndex = 1;
        lblEventName.Text = "";
        lblEventDate.Text = "";
        lblmsg.Text = "";

        rwEventRating.Visible = false;
    }
    protected void radgvEvents_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = radgvEvents.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains"
                )
            
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
    protected void btnRestrict_Click(object sender, EventArgs e)
    {
        btnRestrict.Visible = false;
        btnviewall.Visible = true;
        LoadGrid();
    }
}