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

public partial class NewCalendar : System.Web.UI.Page
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


                //FileUpload fileUpload = new FileUpload();
                //fileUpload = FileUpd;

                LoadTitle(89);
                LoadGrid();

                //FromDate.MinDate = DateTime.Today;
                //TillDate.MinDate = DateTime.Today;

                FromDate.SelectedDate = DateTime.Today;
                //TillDate.SelectedDate = DateTime.Today;

                btnUpdate.Visible = false;
                btnAddEvent.Visible = true;

                
            }
        }
        catch (Exception ex)
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

    protected void btnAddClear_Click(object sender, EventArgs e)
    {
        clear();
    }

    private void clear()
    {

        FromDate.SelectedDate = DateTime.Now;
        //TillDate.SelectedDate = DateTime.Now;
        txtEventName.Text = string.Empty;
        txtdesc.Text = string.Empty;
        
        txtEventName.Focus();

        btnUpdate.Visible = false;
        btnAddEvent.Visible = true;

        
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
            cmd.Parameters.AddWithValue("@i", 8);

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
        if (radgvEvents.Visible == true && radgvEvents.Items.Count > 0)
        {

         
           radgvEvents.ExportSettings.FileName = "Calendar";
           radgvEvents.MasterTableView.Caption = "<span><br>List of Calendars</span>";
          

            radgvEvents.ExportSettings.IgnorePaging = true;
            radgvEvents.ExportSettings.OpenInNewWindow = true;
            radgvEvents.MasterTableView.ExportToExcel();

        }
    }

    protected void lnkwhatsapp_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime edate = Convert.ToDateTime(FromDate.SelectedDate);

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


                string filename = string.Empty;

                String File = "";



                //if (FileUpd.HasFile)
                //{

                //    if (FileUpd.PostedFile.FileName.Length > 0)
                //    {

                //        filename = Path.GetFileName(FileUpd.PostedFile.FileName);

                //        FileUpd.SaveAs(Server.MapPath(@"~//EventImages/") + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename);

                //        File = (@"~//EventImages/") + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename;

                //    }
                //    else
                //    {
                //        File = "";
                //    }

                //}



                sqlobj.ExecuteNonQuery("Proc_Events", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
                           new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate.Value },
                           new SqlParameter() { ParameterName = "@Tilldate", SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate.Value },
                           new SqlParameter() { ParameterName = "@EventName", SqlDbType = SqlDbType.NVarChar, Value = txtEventName.Text },
                           new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                           new SqlParameter() { ParameterName = "@EventType", SqlDbType = SqlDbType.NVarChar, Value = "C" },
                           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "00" },
                           new SqlParameter() { ParameterName = "@IsSentMail", SqlDbType = SqlDbType.NVarChar, Value ="false"},
                           new SqlParameter() { ParameterName = "@Images", SqlDbType = SqlDbType.NVarChar, Value = "" }
                           );

                DateTime fdate = Convert.ToDateTime(FromDate.SelectedDate.Value);
                DateTime tdate = Convert.ToDateTime(FromDate.SelectedDate.Value);

                EventMail(txtEventName.Text, txtdesc.Text, fdate, tdate);

                LoadGrid();

                clear();

                WebMsgBox.Show("Calendar added.");
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
        //TillDate.SelectedDate = FromDate.SelectedDate;
    }
    protected void imgwapp_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            DateTime edate = Convert.ToDateTime(FromDate.SelectedDate);

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

            SqlCommand cmd = new SqlCommand("Proc_Events", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 5);
            cmd.Parameters.AddWithValue("@RSN", RSN);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            SqlDataReader drselect = cmd.ExecuteReader();



            if (drselect.HasRows)
            {
                while (drselect.Read())
                {


                    string strchkdate = "1900-01-01";
                    if (Convert.ToDateTime(drselect["FromDate"]) > Convert.ToDateTime(strchkdate))
                    {
                        FromDate.SelectedDate = Convert.ToDateTime(drselect["FromDate"]);
                        //TillDate.SelectedDate = Convert.ToDateTime(drselect["TillDate"]);
                    }
                    txtEventName.Text = drselect["EventName"].ToString();
                    txtdesc.Text = drselect["Description"].ToString();

                    //TxtImge.Text = drselect["Image"].ToString();

                    btnUpdate.Visible = true;
                    btnAddEvent.Visible = false;

                    
                }
            }
            drselect.Close();
            con.Close();

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




                //string filename = Path.GetFileName(FileUpd.FileName);

                String File;

                //string strfile = "";
                //if (!FileUpd.HasFile)
                //{
                //    File = TxtImge.Text;

                //}
                //else
                //{
                //    strfile = DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename;

                //    File = (@"~//EventImages/") + strfile.ToString();
                //}

                //FileUpd.SaveAs(Server.MapPath(@"~//EventImages/") + strfile.ToString());


                string rsn = Session["RSN"].ToString();

                sqlobj.ExecuteNonQuery("Proc_Events", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 },
                              new SqlParameter() { ParameterName = "@Fromdate", SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate.Value },
                              new SqlParameter() { ParameterName = "@Tilldate", SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate.Value },
                              new SqlParameter() { ParameterName = "@EventName", SqlDbType = SqlDbType.NVarChar, Value = txtEventName.Text },
                              new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                              new SqlParameter() { ParameterName = "@EventType", SqlDbType = SqlDbType.NVarChar, Value = "C" },
                              new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "00" },
                              new SqlParameter() { ParameterName = "@IsSentMail", SqlDbType = SqlDbType.NVarChar, Value = "false" },
                              new SqlParameter() { ParameterName = "@Images", SqlDbType = SqlDbType.NVarChar, Value = ""},
                              new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = "" },
                              new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["RSN"].ToString() }
                              );

                LoadGrid();
                clear();


                WebMsgBox.Show("Calendar details updated successfully");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnviewall_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddCalendar.aspx?Type=ViewEventsList");
    }
}