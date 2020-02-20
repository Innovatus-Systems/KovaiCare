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

public partial class Events : System.Web.UI.Page
{
    public static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    static string strLastEvent;

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }


            string qstring = Request.QueryString["Type"].ToString();


            if (qstring.ToString() == "AddEvent")
            {
                lbtnAdd_Click(sender, null);
                LoadGridOnCmng();
                //lblTitle.Text = "OnComing Events";
                //LoadGrid();
                FromDate.MinDate = DateTime.Today;
                RadDatePicker1.MinDate = DateTime.Today;

                FromDate.SelectedDate = DateTime.Today;
                RadDatePicker1.SelectedDate = DateTime.Today;
            }
            if (qstring.ToString() == "OncomingEvent")
            {
                lbtnoncmng_Click(sender, null);

                FromDate.MinDate = DateTime.Today;
                RadDatePicker1.MinDate = DateTime.Today;

                FromDate.SelectedDate = DateTime.Today;
                RadDatePicker1.SelectedDate = DateTime.Today;
            }
            if (qstring.ToString() == "ViewEventsList")
            {
                lbtnAll_Click(sender, null);

                FromDate.MinDate = DateTime.Today;
                RadDatePicker1.MinDate = DateTime.Today;

                FromDate.SelectedDate = DateTime.Today;
                RadDatePicker1.SelectedDate = DateTime.Today;
            }
            //else
            //{
            //    //lblTitle.Text = "OnComing Events";
            //    //LoadGrid();
            //    FromDate.MinDate = DateTime.Today;
            //    RadDatePicker1.MinDate = DateTime.Today;

            //    FromDate.SelectedDate = DateTime.Today;
            //    RadDatePicker1.SelectedDate = DateTime.Today;
            //}


        }
    }

    [WebMethod]
    [STAThread]
    public static string AddEvents(string From, string Till, string Event, string Desc, string Etype, string smail)
    {
        string flag = "";
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_Events", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 2);
            cmd.Parameters.AddWithValue("@Fromdate", From);
            cmd.Parameters.AddWithValue("@Tilldate", Till);
            cmd.Parameters.AddWithValue("@EventName", Event);
            cmd.Parameters.AddWithValue("@Description", Desc);
            cmd.Parameters.AddWithValue("@EventType", Etype);
            cmd.Parameters.AddWithValue("@Status", "00");
            cmd.Parameters.AddWithValue("@IsSentMail", smail);

            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //EventsMail("New event has been added on  " + Convert.ToDateTime(From).ToString("dd-MMM-yyyy"), Desc,Event);

            DateTime fdate = Convert.ToDateTime(From);
            DateTime tdate = Convert.ToDateTime(Till);

            EventMail(Event.ToString(), Desc.ToString(), fdate, tdate);
            
            flag = "true";


        }
        catch (Exception ex)
        {
            flag = "false";
        }
        return flag;
    }

    //private static void EventMail(string Event, string p1, string p2)
    //{
    //    throw new NotImplementedException();
    //}

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



        LoadTitle(43);
        strLastEvent = "Oncoming";
        //ds.Dispose();
    }

    private void LoadGridOnCmng()
    {
        //DataSet ds = new DataSet();
        //ds = null;
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_Events", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 6);

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds, "temp");
            //gvEvents.DataSource = ds.Tables[0];
            //gvEvents.DataBind();
            radgvEvents.MasterTableView.GetColumn("Status").Display = false;
            radgvEvents.MasterTableView.GetColumn("Remarks").Display = false;
            radgvEvents.DataSource = ds.Tables[0];
            radgvEvents.DataBind();
        }
        catch (Exception ex)
        {

        }



        LoadTitle(43);
        strLastEvent = "Oncoming";
        //ds.Dispose();
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




    [WebMethod]
    public static string GetPopupData(string key)
    {
        StringBuilder sb = new StringBuilder();
        return sb.ToString();
    }

    protected void imgpopup_Click(object sender, ImageClickEventArgs e)
    {
        // this.ModalPopupExtender1.Show();
    }
    protected void lbtnAll_Click(object sender, EventArgs e)
    {
        strLastEvent = "All";
        LoadGridAll();
    }
    public void LoadGridAll()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_Events", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 4);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds, "temp");
            if (ds.Tables[0].Rows.Count > 0)
            {
                //gvEvents.DataSource = ds.Tables[0];
                //gvEvents.DataBind();
              
                radgvEvents.MasterTableView.GetColumn("Status").Display = true;
                radgvEvents.MasterTableView.GetColumn("Remarks").Display = false;
                radgvEvents.DataSource = ds.Tables[0];
                radgvEvents.DataBind();
            }
            else
            {
                //gvEvents.DataSource = null;
                //gvEvents.DataBind();
                radgvEvents.DataSource = null;
                radgvEvents.DataBind();
            }

        }
        catch (Exception ex)
        {

        }

        LoadTitle(44);
    }
    protected void lbtnoncmng_Click(object sender, EventArgs e)
    {
        try
        {
            LoadGridOnCmng();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvEvents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Int64 RSN;
        if (e.CommandName == "UpdateRow")
        {
            RSN = Convert.ToInt64(e.CommandArgument.ToString());
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
                    lblfromdate.MinDate = DateTime.Today;
                    lbltodate.MinDate = DateTime.Today;

                    hbtnRSN.Value = RSN.ToString();
                    string strchkdate = "1900-01-01";
                    if (Convert.ToDateTime(drselect["FromDate"]) > Convert.ToDateTime(strchkdate))
                    {
                        lblfromdate.SelectedDate = Convert.ToDateTime(drselect["FromDate"]);
                        lbltodate.SelectedDate = Convert.ToDateTime(drselect["TillDate"]);
                    }
                    lblevent.Text = drselect["EventName"].ToString();
                    lblevedesc.Text = drselect["Description"].ToString();
                    txtupremarks.Text = drselect["Remarks"].ToString();
                    ddlupstatus.SelectedValue = drselect["Status"].ToString();

                }
            }
            drselect.Close();
            con.Close();
            this.ModalPopupExtender1.Show();
        }
    }
    protected void lbtnAdd_Click(object sender, EventArgs e)
    {
        txtEventName.Focus();
        this.ModalPopupExtender2.Show();
    }

    [WebMethod]
    public static string UpdateEvents(string status, string RSN, string remarks, string Events, string from, string to, string events, string eventsdesc)
    {
        string flag = "";
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_Events", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 3);
            cmd.Parameters.AddWithValue("@RSN", RSN);
            cmd.Parameters.AddWithValue("@Fromdate", from);
            cmd.Parameters.AddWithValue("@Tilldate", to);
            cmd.Parameters.AddWithValue("@EventName", events);
            cmd.Parameters.AddWithValue("@Description", eventsdesc);
            cmd.Parameters.AddWithValue("@Status", status);
            cmd.Parameters.AddWithValue("@Remarks", remarks);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();


            flag = "true";
        }
        catch (Exception ex)
        {
            flag = "false";
        }
        return flag;
    }

    public static void EventMail(string EventName,string Description, DateTime fromeventdate,DateTime toevnetdate)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            string tomail = "";
            string touser ="";
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

                    M.EventsMail(strmcusername, strmcfromname, tomail.ToString(), touser.ToString(), touser.ToString(),EventName.ToString(), Description.ToString(),
                       fromeventdate, strmcusername.ToString(), strmcpassword.ToString(), AdminName, AdminContact, AdminContact, title);
                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvEvents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string test = e.Row.Cells[2].Text.ToString();
            DateTime dt = DateTime.Today;
            string strDate = dt.ToString("dd-MMM-yyyy");
            //e.Row.Cells[3].BackColor = System.Drawing.Color.Red;
            if (Convert.ToDateTime(test) < Convert.ToDateTime(strDate))
            {
                string strStatus = e.Row.Cells[4].Text.ToString();
                if (strStatus == "Scheduled")
                {
                    e.Row.Cells[3].BackColor = System.Drawing.Color.Red;
                }
            }
        }
    }


    public static void SendMail(string Subject, string Body, string EventName)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsMails = new DataSet();
        string mailserver = string.Empty;
        string user = string.Empty;
        string pwd = string.Empty;
        string sentby = string.Empty;
        string strCC ="";
        try
        {                      
            SqlCommand cmd = new SqlCommand(string.Concat("SELECT * FROM cpmailcredentials"), con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet dsCredential = new DataSet();
            da.Fill(dsCredential);
            // Write an informational entry to the event log. 


            MailMessage msg = new MailMessage();

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
            dsMails = sqlobj.ExecuteSP("Get_MailDetails_Events");   
            
            if(dsMails.Tables[0].Rows.Count > 0)
            {

                msg.Subject = EventName.ToString() + " at" + "";
                

                StreamReader reader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("~/EventsMail.html"));
                string readFile = reader.ReadToEnd();
                string myString = "";
                myString = readFile;
                myString = myString.Replace("$$Event$$", EventName);
                myString = myString.Replace("$$Details$$", Body);
                myString = myString.Replace("$$Company$$", dsMails.Tables[1].Rows[0][1].ToString());

                //SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                //MailAddress From = new MailAddress(user, dsMails.Tables[1].Rows[0][0].ToString());
                //MailMessage myMail = new System.Net.Mail.MailMessage();
                //myMail.From = From;
                //myMail.To.Add(dsMails.Tables[1].Rows[0][0].ToString());
               
                foreach (DataRow row in dsMails.Tables[0].Rows)
                {
                    //myMail.CC.Add(row[0].ToString());
                    if(strCC == "")
                    {
                        strCC = row[0].ToString();
                    }
                    else
                    {
                        strCC = strCC + ";" + row[0].ToString();
                    }
                }
                //mySmtpClient.UseDefaultCredentials = false;
                //System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user,pwd);
                //mySmtpClient.Credentials = basicauth;
                //mySmtpClient.EnableSsl = true;
                //myMail.SubjectEncoding = System.Text.Encoding.UTF8;
                //myMail.BodyEncoding = System.Text.Encoding.UTF8;
                //myMail.IsBodyHtml = true;
                //myMail.Subject = Subject;
                //myMail.Body = myString.ToString();
                //mySmtpClient.Send(myMail);

                sqlobj.ExecuteNonQuery("insert into tblCSoftMailOutBox(FromUser,Touser,CC,Subject,Body) values('" + dsMails.Tables[1].Rows[0][0].ToString() + "','" + dsMails.Tables[1].Rows[0][0].ToString() + "','" + strCC + "','" + Subject + "','" + myString.ToString() + "')");
            }            
        }
        catch (SmtpException ex)
        {
           
        }
        catch (Exception ex)
        {
            
        }

    }
    //protected void btnRefresh_Click(object sender, EventArgs e)
    //{
    //    LoadGrid();

    //    this.ModalPopupExtender2.Hide();
    //}

    private void Refresh()
    {
        LoadGrid();

        this.ModalPopupExtender2.Hide();
    }

    protected void gvEvents_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //gvEvents.PageIndex = e.NewPageIndex;
        if (strLastEvent == "OnComing")
        {
            LoadGrid();
        }
        else
        {
            lbtnAll_Click(sender, null);
        }
    }

    protected void radgvEvents_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Int64 RSN;
        if (e.CommandName == "UpdateRow")
        {
            RSN = Convert.ToInt64(e.CommandArgument.ToString());
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
                    lblfromdate.MinDate = Convert.ToDateTime(drselect["FromDate"]);
                    lbltodate.MinDate = Convert.ToDateTime(drselect["FromDate"]);

                    hbtnRSN.Value = RSN.ToString();
                    string strchkdate = "1900-01-01";
                    if (Convert.ToDateTime(drselect["FromDate"]) > Convert.ToDateTime(strchkdate))
                    {
                        lblfromdate.SelectedDate = Convert.ToDateTime(drselect["FromDate"]);
                        lbltodate.SelectedDate = Convert.ToDateTime(drselect["TillDate"]);
                    }
                    lblevent.Text = drselect["EventName"].ToString();
                    lblevedesc.Text = drselect["Description"].ToString();

                    string stvalue = drselect["Status"].ToString();
                    ddlupstatus.SelectedValue = drselect["Status"].ToString();
                }
            }
            drselect.Close();
            con.Close();
            this.ModalPopupExtender1.Show();
        }
        else if (strLastEvent == "OnComing")
        {
            LoadGrid();
        }
        else
        {
            lbtnAll_Click(sender, null);
        }
    }

    protected void rmnuMain_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        if (e.Item.Text == "Add Event")
        {
            lbtnAdd_Click(sender, null);
        }
        else if (e.Item.Text == "OnComing Events")
        {
            lbtnoncmng_Click(sender, null);
        }
        else if (e.Item.Text == "All")
        {
            lbtnAll_Click(sender, null);
        }
    }

    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        if (radgvEvents.Visible == true && radgvEvents.Items.Count > 0)
        {

            radgvEvents.ExportSettings.ExportOnlyData = true;

            if (lnktitle.Text == "Oncoming events")
            {
                radgvEvents.ExportSettings.FileName = "Oncoming events";
                radgvEvents.MasterTableView.Caption = "<span><br>List of Oncoming Events</span>";
            }
            else
            {
                radgvEvents.ExportSettings.FileName = "All events";
                radgvEvents.MasterTableView.Caption = "<span><br>List of All Events</span>";
            }

            radgvEvents.ExportSettings.IgnorePaging = true;
            radgvEvents.ExportSettings.OpenInNewWindow = true;
            radgvEvents.MasterTableView.ExportToExcel();

        }
    }

    protected void radgvEvents_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
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

    protected void FromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        RadDatePicker1.SelectedDate = FromDate.SelectedDate;
    }

    protected void btnAddCancel_Click(object sender, EventArgs e)
    {
        try
        {
            //LoadGrid();
            LoadGridOnCmng();
            this.ModalPopupExtender2.Hide();
            //Response.Redirect("Events.aspx?Type=OncomingEvent");
            //LoadGrid();

            //this.ModalPopupExtender2.Hide();

            //Response.Redirect("Events.aspx?Type=OncomingEvent");

            //LoadGridOnCmng();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void imgwapp_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            DateTime edate = Convert.ToDateTime(RadDatePicker1.SelectedDate);

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
    protected void lnkwhatsapp_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime edate = Convert.ToDateTime(RadDatePicker1.SelectedDate);

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
    protected void imgUwhatapp_Click(object sender, ImageClickEventArgs e)
    {
        DateTime edate = Convert.ToDateTime(lblfromdate.SelectedDate);

        string strinform = lblevent.Text + " " + edate.ToString("dd/MM/yyyy") + " " + lblevedesc.Text + " " + ddlupstatus.SelectedItem.Text;

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
    protected void lnkuwhatsapp_Click(object sender, EventArgs e)
    {
        DateTime edate = Convert.ToDateTime(lblfromdate.SelectedDate);

        string strinform = lblevent.Text + " " + edate.ToString("dd/MM/yyyy") + " " + lblevedesc.Text + " " + ddlupstatus.SelectedItem.Text;

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
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //LoadGrid();
        this.ModalPopupExtender1.Hide();
        //Response.Redirect("Events.aspx?Type=OncomingEvent");

    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
            //DataSet dsEvents = sqlobj.ExecuteSP("Proc_Events",
            //    new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
            //    new SqlParameter() { ParameterName = "@EventType", SqlDbType = SqlDbType.Char, Value = ddlType.SelectedValue == "0" ? null : ddlType.SelectedValue }
            //    );

            //if (dsEvents.Tables[0].Rows.Count > 0)
            //{
            //    radgvEvents.DataSource = dsEvents;
            //    radgvEvents.DataBind();
            //}

            //dsEvents.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    protected void btnAddClear_Click(object sender, EventArgs e)
    {
        ddlEventtype.SelectedIndex = 0;
        FromDate.SelectedDate = DateTime.Now;
        RadDatePicker1.SelectedDate = DateTime.Now;
        txtEventName.Text = string.Empty;
        txtdesc.Text = string.Empty;
        txtEventName.Focus();
    }

    protected void btnUpdateClear_Click(object sender, EventArgs e)
    {
        
        //lblfromdate.SelectedDate = DateTime.Now;
        //lbltodate.SelectedDate = DateTime.Now;
        //lblevent.Text = string.Empty;
        //lblevedesc.Text = string.Empty;
        //txtupremarks.Text = string.Empty;
        //ddlupstatus.SelectedIndex = 0;
        //btnUpdate.Visible = false;

        //LoadGridOnCmng();
        this.ModalPopupExtender2.Hide();
        Response.Redirect("Events.aspx?Type=OncomingEvent");
    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewEvent.aspx");
    }
}