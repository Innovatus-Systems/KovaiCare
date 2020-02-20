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
using System.IO;
using System.Net;
using System.Text;

public partial class TaskList : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    static string strDate;
    static string strTime;
    static string strCount;
    static string strRate;
    static string strPriority;
    static string strAutoDebit;
    static string strDSMS;
    static string strMSMS;
    static string strRSMS;
    decimal dlastOutStanding;

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {

            ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
            //scriptManager.RegisterAsyncPostBackControl(this.btnUpdate);
            scriptManager.RegisterPostBackControl(BtnnExcelExport);

            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;
            DateTime dstart = new DateTime();

            string qstring = Request.QueryString[0].ToString();
            string qstring1 = Request.QueryString[1].ToString();
            int len = qstring1.Length;
            if (qstring1.Length != 1)
            {
                if (len == 16)
                {
                    dstart = DateTime.ParseExact(qstring1, "MM/dd/yyyy HH:mm", CultureInfo.InvariantCulture);
                }
                else
                {
                    dstart = DateTime.ParseExact(qstring1, "MM-dd-yyyy HH:mm:ss", CultureInfo.InvariantCulture);
                }
            }
            else
            {
                dstart = DateTime.Now;
            }

            rwSpecialReport.VisibleOnPageLoad = true;
            rwSpecialReport.Visible = false;

            rwHelp.VisibleOnPageLoad = true;
            rwHelp.Visible = false;

            rwDebitAmount.VisibleOnPageLoad = true;
            rwDebitAmount.Visible = false;

            if (!IsPostBack)
            {
                //LoadServiceCategory();
                //LoadCategoryLkup();

                LoadServiceType();

                LoadResidentDet();

               

                if (qstring == "1")
                {
                    pnlSecond.Visible = true;
                    pnlThird.Visible = false;
                    ddlStatus.Enabled = false;
                   // lbltitle.Visible = true;
                    dtpStatusDt.Enabled = false;
                    dtpStatusDt.SelectedDate = dstart;
                    dtpTargetDt.SelectedDate = dstart;
                    btncalendarimg2.Visible = false;
                    btncalendarimg.Visible = false;

                    lblcSendsms.Visible = false;
                    txtSendsms.Visible = false;
                    btnSendsms.Visible = false;
                }
                else if (qstring == "2")
                {

                    LoadTitle(36);
                    pnlSecond.Visible = false;
                    pnlThird.Visible = true;
                    ddlStatus.Enabled = true;
                    //lbltitle.Visible = false;
                    BtnnExcelExport.Visible = true;

                    //LoadCategoryLkup(); 
                }
                else if (qstring == "3")
                {
                    LoadTitle(35);

                    pnlSecond.Visible = true;
                    pnlThird.Visible = false;
                    ddlStatus.Enabled = false;
                   // lbltitle.Visible = true;
                    dtpStatusDt.Enabled = false;
                    dtpStatusDt.SelectedDate = dstart;
                    dtpTargetDt.SelectedDate = dstart;
                    btncalendarimg2.Visible = false;
                    btncalendarimg.Visible = false;

                    ddlStatus.Visible = false;
                    lbltasksts.Visible = false;
                    txtStatusRemarks.Visible = false;
                    Label11.Visible = false;

                    lblnetamount.Visible = false;
                    txtNetAmount.Visible = false;
                    lbltaxamount.Visible = false;
                    txtTaxAmount.Visible = false;
                    lblgrossamount.Visible = false;
                    txtGrossAmount.Visible = false;

                    lblcSendsms.Visible = false;
                    txtSendsms.Visible = false;
                    btnSendsms.Visible = false;

                }
                dsDT = proc.ExecuteSP("GetServerDateTime");
                DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
                DateTime now2 = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
                // txtMobile.Enabled = false;
                //txtEmail.Enabled = false;

               
                
                LoadTasksCount();
                LoadTaskDDL();

                //lbltaskcount.Visible = false;

            }
            if (ddlSStatus.SelectedItem.Value != "Close") 
            {
                LoadGrid();
                 ddlStatus.Visible = false;
            //    lblnetamount.Visible = false;
            //    txtNetAmount.Visible = false;
            //    lbltaxamount.Visible = false;
            //    txtTaxAmount.Visible = false;
            //    lblgrossamount.Visible = false;
            //    txtGrossAmount.Visible = false;
            //    lbltasksts.Visible = false;
            //    txtStatusRemarks.Visible = false;
            //    Label11.Visible = false;
            }
            else
            {
                
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void LoadResidentDet()
    {
        try
        {

            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 9},
                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = 1 });
            cmbResident.DataSource = dsResident.Tables[0];
            cmbResident.DataValueField = "RTRSN";
            cmbResident.DataTextField = "RName";
            cmbResident.DataBind();

            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbResident.Items.Add(item2);

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
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

    protected void lbShowTLAdd_Click(object sender, EventArgs e)
    {
        pnlSecond.Visible = true;
        ClearTaskDet();
    }

    private void LoadServiceType()
    {
        try
        {

            DataSet dsServiceType = sqlobj.ExecuteSP("Proc_LoadServiceConfig", new SqlParameter { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 }); 

            if (dsServiceType.Tables[0].Rows.Count > 0)
            {
                ddlSerType.DataSource = dsServiceType.Tables[0];
                ddlSerType.DataValueField = "RSN";
                ddlSerType.DataTextField = "ServiceType";
                ddlSerType.DataBind();       
            }

            ddlSerType.Items.Insert(0, new ListItem("--Select--", "0"));

           
            
        }
        
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    
    protected void btnClose_Click(object sender, EventArgs e)
    {
        ClearTaskDet();
        pnlSecond.Visible = false;
        pnlThird.Visible = true;
        BtnnExcelExport.Visible = true;
    }


    protected void LoadTasksCount()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchCount = new DataSet();

            dsFetchCount = sqlobj.ExecuteSP("SP_General",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 18 });

            lbldispopentasks.Text = dsFetchCount.Tables[0].Rows[0]["TaskCnt"].ToString();
            lbldispoverdue.Text = dsFetchCount.Tables[1].Rows[0]["OverDueTaskCnt"].ToString();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }

    }

    private void LoadResidentProfile()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchAT = new DataSet();

            lblcprofile.Text = "Profile";

            dsFetchAT = sqlobj.ExecuteSP("SP_FecthAssignTo",
                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });

            lblMobileNo.Text = "Mobile No:" + dsFetchAT.Tables[0].Rows[0]["Mobile"].ToString();
            lblEmailID.Text = "EmailID:" + dsFetchAT.Tables[0].Rows[0]["Email"].ToString();
            Session["RMobileNo"] = dsFetchAT.Tables[0].Rows[0]["Mobile"].ToString();

            dsFetchAT.Dispose();

            DataSet dsFetchStatus = sqlobj.ExecuteSP("SP_GetStatus",
                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });

            if (dsFetchStatus.Tables[0].Rows.Count > 0)
            {
                lblstatus.Text = "Status:" + dsFetchStatus.Tables[0].Rows[0]["SDescription"].ToString();

                lblstatus.Text = lblstatus.Text + " - " + "Villa No:" + dsFetchStatus.Tables[0].Rows[0]["RTVILLANO"].ToString();
            }

            dsFetchStatus.Dispose();

            DataSet dsFetchTasks = sqlobj.ExecuteSP("SP_GetCount",
                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });


            if (dsFetchTasks.Tables[0].Rows.Count > 0)
            {

                if (dsFetchTasks.Tables[0].Rows[0]["count"].ToString() != "0")
                {
                    // lbltaskcount.Visible = true;
                    // lbltaskcount.Text = "Tasks scheduled for the resident:" + dsFetchTasks.Tables[0].Rows[0]["count"].ToString();
                }
                else
                {
                    //  lbltaskcount.Visible = false;
                }
            }

            dsFetchTasks.Dispose();


            GetResidentTasks();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            //if (ddlTask.SelectedValue != "0" && txtTask.Text != "" && ddlAssignedTo.SelectedValue != "0")
            //{
            DateTime Format = Convert.ToDateTime(dtpStatusDt.SelectedDate);
            DateTime now = DateTime.Now;
            int hours = now.Hour;
            int min = now.Minute;
            int sec = now.Second;
            DateTime final = Format.AddHours(hours).AddMinutes(min).AddSeconds(sec);
            
          
            try
            {

               


                sqlobj.ExecuteNonQuery("Proc_NewTasks",
                   new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@SerTypeRSN", SqlDbType = SqlDbType.BigInt, Value = ddlSerType.SelectedValue },
                   new SqlParameter() { ParameterName = "@Task", SqlDbType = SqlDbType.VarChar, Value = txtTask.Text },
                   new SqlParameter() { ParameterName = "@TaskDate", SqlDbType = SqlDbType.Date, Value = txtMDate.SelectedDate == null ? null : txtMDate.SelectedDate },
                   new SqlParameter() { ParameterName = "@TaskTime", SqlDbType = SqlDbType.VarChar, Value = txtMTime.Text == "" ? "00:00" : txtMTime.Text },
                   new SqlParameter() { ParameterName = "@TaskCount", SqlDbType = SqlDbType.Int, Value = txtMCount.Text.ToString() == "" ? 0 : Convert.ToInt32(txtMCount.Text) },
                   new SqlParameter() { ParameterName = "@Urgency", SqlDbType = SqlDbType.VarChar, Value = ddlUrgency.SelectedValue.ToString() },
                   new SqlParameter() { ParameterName = "@TaskStatus", SqlDbType = SqlDbType.VarChar, Value = "Open" },
                   new SqlParameter() { ParameterName = "@StatusDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Today },
                   new SqlParameter() { ParameterName = "@C_By", SqlDbType = SqlDbType.VarChar, Value = Session["UserID"].ToString() == null ? null : "Admin" },
                   new SqlParameter() { ParameterName = "@StatusRemarks", SqlDbType = SqlDbType.VarChar, Value = txtStatusRemarks.Text.ToString() == null ? null : txtStatusRemarks.Text },
                   new SqlParameter() { ParameterName = "@Targetdate", SqlDbType = SqlDbType.DateTime, Value = dtpTargetDt.SelectedDate }
                   );

                ClearTaskDet();

                WebMsgBox.Show("Service Request details saved");
               
                pnlSecond.Visible = false;
                pnlThird.Visible = true;
                BtnnExcelExport.Visible = true;
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());
            }
            //}
            //else
            //{
            //    WebMsgBox.Show("Kindly select Requested By/ your Need / Enter a Description.");
            //}
        }

    }

    //public  void SentSMS()
    //{
    //    string constring = @"data source=111.118.188.128\SQLEXPRESS;initial catalog=CovaiSoft;persist security info=True;user id=cpc;password=C0vaipr0p";

    //    SqlConnection con = new SqlConnection(constring);

    //    SqlCommand cmd = new SqlCommand(string.Concat("SELECT * FROM SendSMS where status='NotSent'"), con);

    //    SqlDataAdapter da = new SqlDataAdapter(cmd);
    //    DataSet dsCredential = new DataSet();

    //    da.Fill(dsCredential);

    //    if (dsCredential.Tables[0].Rows.Count > 0)
    //    {


    //        for (int i = 0; i < dsCredential.Tables[0].Rows.Count; i++)
    //        {

    //            string strMobileNo = dsCredential.Tables[0].Rows[i]["MobileNo"].ToString();
    //            string strSmsText = dsCredential.Tables[0].Rows[i]["smstext"].ToString();


    //            string strUrl = "http://sms.innovatussystems.com/api/sendmsg.php?user=innsys&pass=India123&sender=ORISTS&phone=" + strMobileNo + "&text=" + strSmsText + "&priority=ndnd&stype=normal";
    //            // Create a request object  
    //            WebRequest request = HttpWebRequest.Create(strUrl);
    //            // Get the response back  
    //            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
    //            Stream s = (Stream)response.GetResponseStream();
    //            StreamReader readStream = new StreamReader(s);
    //            string dataString = readStream.ReadToEnd();
    //            response.Close();
    //            s.Close();
    //            readStream.Close();

    //            con.Open();
    //            cmd = new SqlCommand(string.Concat("update sendsms set status='Sent' WHERE RSN=" + dsCredential.Tables[0].Rows[i]["RSN"].ToString()), con);
    //            cmd.ExecuteNonQuery();
    //            con.Close();

    //        }

    //        //return (response.ToString());

    //    }



    //}



    //public String SentSMS(String MobileNumber, String SmsText)
    //{

    //    string strUrl = "http://sms.innovatussystems.com/api/sendmsg.php?user=innsys&pass=India123&sender=ORISTS&phone=" + MobileNumber + "&text=" + SmsText + "&priority=ndnd&stype=normal";
    //    // Create a request object  
    //    WebRequest request = HttpWebRequest.Create(strUrl);
    //    // Get the response back  
    //    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
    //    Stream s = (Stream)response.GetResponseStream();
    //    StreamReader readStream = new StreamReader(s);
    //    string dataString = readStream.ReadToEnd();
    //    response.Close();
    //    s.Close();
    //    readStream.Close();

    //    return (response.ToString());

    //}

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {



            string strrsnfilter = "";
            string custname = "";
            string doorno = "";


            string strBStatus = "";

            DateTime cdate = DateTime.Now;



            DataSet dsStatus = sqlobj.ExecuteSP("SP_CheckBillingStatus",
                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = cdate.ToString() });

            if (dsStatus.Tables[0].Rows.Count > 0)
            {

                //strBStatus = dsStatus.Tables[0].Rows[0]["BStatus"].ToString();

            }
            else
            {
                //WebMsgBox.Show("Please wait for month end billing");
                //return;
            }



            DateTime Format = Convert.ToDateTime(dtpStatusDt.SelectedDate);
            DateTime now = DateTime.Now;
            int hours = now.Hour;
            int min = now.Minute;
            int sec = now.Second;
            DateTime final = Format.AddHours(hours).AddMinutes(min).AddSeconds(sec);
            try
            {

                string strCategory = "";
                string strDoorNo = "";
                string strTasks = "";
                string strTaskStatus = "";
                string strsmstext = "";
                string strStatusRemarks = "";
                string strName = "";





                // Get Task Category

                SqlProcsNew obj = new SqlProcsNew();

                sqlobj.ExecuteNonQuery("Proc_NewTasks",
                   new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
                   new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt16(Session["TaskRSN"].ToString()) },
                   new SqlParameter() { ParameterName = "@Task", SqlDbType = SqlDbType.VarChar, Value = txtTask.Text },
                   new SqlParameter() { ParameterName = "@Urgency", SqlDbType = SqlDbType.VarChar, Value = ddlUrgency.SelectedValue.ToString() },
                   new SqlParameter() { ParameterName = "@TaskStatus", SqlDbType = SqlDbType.VarChar, Value = ddlStatus.SelectedValue.ToString() },
                   new SqlParameter() { ParameterName = "@StatusDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Today },
                   new SqlParameter() { ParameterName = "@M_By", SqlDbType = SqlDbType.VarChar, Value = Session["UserID"].ToString() == null ? null : "Admin" },
                   new SqlParameter() { ParameterName = "@StatusRemarks", SqlDbType = SqlDbType.VarChar, Value = txtStatusRemarks.Text.ToString() == null ? null : txtStatusRemarks.Text },
                   new SqlParameter() { ParameterName = "@Targetdate", SqlDbType = SqlDbType.DateTime, Value = dtpTargetDt.SelectedDate }
                   );


                Session["RTRSN"] = cmbResident.SelectedValue;

                // Fetch Service Rate Start

               strTaskStatus = ddlStatus.SelectedValue.ToString();


                 if (strTaskStatus == "Done")
                 {

                     if (txtNetAmount.Text !="")
                     {


                            decimal dnetamount = Convert.ToDecimal(txtNetAmount.Text);


                            if (dnetamount > 0)
                            {

                                


                                // -- Strart Post Debit Transaction for net amount


                                DateTime bdate = DateTime.Now;

                                string strday = bdate.ToString("dd");
                                string strmonth = bdate.ToString("MM");
                                string stryear = bdate.ToString("yyyy");
                                string strhour = bdate.ToString("HH");
                                string strmin = bdate.ToString("mm");
                                string strsec = bdate.ToString("ss");

                                string strBillNo = "S" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();


                                sqlobj.ExecuteSP("SP_InsertTransactionDetailsTxn",
                                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                                 new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "SERVICE" },
                                 new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "SERVICE" },
                                 new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "s" },
                                 new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = "UnBilled" },
                                 new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = dnetamount.ToString() },
                                 new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                                 new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = dnetamount.ToString() },
                                 new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                 new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                                 new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = txtTask.Text },
                                 new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                 new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                 new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                 new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() });


                                // -- End Post Debit Transaction for net amount

                                // -- Start Post Debit Transaction for cgst amount


                                if (txtTaxAmount.Text != "")
                                {
                                    decimal dtaxamount = Convert.ToDecimal(txtTaxAmount.Text);
 

                                 if (dtaxamount > 0)
                                 {


                                 sqlobj.ExecuteSP("SP_InsertTransactionDetailsTxn",
                                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                                 new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "OCGST" },
                                 new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "SERVICE" },
                                 new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "s" },
                                 new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = "UnBilled" },
                                 new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = dtaxamount.ToString() },
                                 new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                                 new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = dtaxamount.ToString()},
                                 new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                 new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                                 new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = "CGST " + Session["CGST"].ToString() + "%" },
                                 new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                 new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                 new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                 new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() });
                                    
                                 }
                                
                                }


                                // -- End Post Debit Transaction for cgst amount


                                // -- Start Post Debit Transaction for sgst amount


                                if (txtSGSTAmouont.Text != "")
                                {
                                    decimal dsgstamount = Convert.ToDecimal(txtSGSTAmouont.Text);


                                    if (dsgstamount > 0)
                                    {

                                        sqlobj.ExecuteSP("SP_InsertTransactionDetailsTxn",
                                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                                        new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "OSGST" },
                                        new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "SERVICE" },
                                        new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "s" },
                                        new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = "UnBilled" },
                                        new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = dsgstamount.ToString() },
                                        new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                                        new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = dsgstamount.ToString() },
                                        new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                        new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                                        new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = "SGST " + Session["SGST"].ToString() + "%" },
                                        new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                        new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                        new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                        new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() });

                                    }

                                }


                                // -- End Post Debit Transaction for cgst amount


                            }
            
                        }
                         

                 }


                // Fetch Service Rate end

                 ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Service details updated');", true);

                 LoadTasksCount();
                 ClearTaskDet();

                 pnlSecond.Visible = false;
                 pnlThird.Visible = true;

                 btnSave.Visible = true;
                 btnUpdate.Visible = false;

                LoadTitle(36);

                 //WebMsgBox.Show("Task details updated");

                 lblcSendsms.Visible = false;
                 txtSendsms.Visible = false;


               

            }
            catch (Exception ex)
            {

                WebMsgBox.Show(ex.ToString());
            }
        }

    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearTaskDet();
    }
    protected void LoadGrid()
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_FetchTaskList",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@Status", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlSStatus.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate },
                new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = ToDate.SelectedDate });
            rdgTaskList.DataSource = dsGroup.Tables[0];
            rdgTaskList.DataBind();
            dsGroup.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }


    }

    protected void rdgCSEdit_Click(object sender, EventArgs e)
    {

        try
        {
        
        pnlSecond.Visible = true;
        btnSave.Visible = false;
        btnUpdate.Visible = true;

        //ddlAssignedBy.Enabled = false;
     
        rgServiceList.Visible = false;
        lblcservicelist.Visible = false;

     
       
        ddlUrgency.Enabled = false;
        dtpTargetDt.Enabled = true; ;
        ddlStatus.Enabled = true;

        ddlSerType.Enabled = false;
        txtTask.Enabled = false;
        txtMCount.Enabled = false;
        dtpTargetDt.Enabled = false;
        ddlstdtext.Enabled = false;

            LinkButton lkBtn = (LinkButton)sender;
            GridDataItem grditm = (GridDataItem)lkBtn.NamingContainer;

            string RSN = grditm.Cells[3].Text.ToString();
            Session["TaskRSN"] = RSN;           
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsCSEdit = null;
            Response.Redirect("ServicePosting.aspx?rsn=" + Session["TaskRSN"]);
           

            //dsCSEdit = sqlobj.ExecuteSP("Proc_NewTasks",
            //   new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 },
            //   new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN });


            //if (dsCSEdit.Tables[0].Rows.Count > 0)
            //{

            //    cmbResident.SelectedValue = dsCSEdit.Tables[0].Rows[0]["RTRSN"].ToString();


            //    Session["CGST"] = dsCSEdit.Tables[0].Rows[0]["CGST"].ToString();

            //    Session["SGST"] = dsCSEdit.Tables[0].Rows[0]["SGST"].ToString();

            //    lbltaxpercentage.Text = "CGST " + Session["CGST"] + "%";

            //    lblsgstpercentage.Text = "SGST " + Session["SGST"] + "%";


            //    LoadResidentProfile();

            //    txtTask.Text = dsCSEdit.Tables[0].Rows[0]["Task"].ToString();
            //    ddlStatus.SelectedValue = dsCSEdit.Tables[0].Rows[0]["TaskStatus"].ToString();


            //    LoadServiceType();

            //    //ddlSerCategory.SelectedValue = dsCSEdit.Tables[0].Rows[0]["SerCategory"].ToString();
            //    //LoadCategory();


            //    ddlSerType.SelectedValue = dsCSEdit.Tables[0].Rows[0]["SerTypeRSN"].ToString();




            //    LoadServiceTypeDetails();
            //    LoadStandardText();
            //    CheckMandatory();

            //    dtpStatusDt.SelectedDate = Convert.ToDateTime(dsCSEdit.Tables[0].Rows[0]["StatusDate"].ToString());

            //    txtMTime.Text = dsCSEdit.Tables[0].Rows[0]["TaskTime"].ToString();

            //    txtMCount.Text = dsCSEdit.Tables[0].Rows[0]["TaskCount"].ToString();

            //    //DateTime curdate = DateTime.Today;
            //    //DateTime statusdate = Convert.ToDateTime(dtpStatusDt.SelectedDate);


            //    //if (cu)


            //    if (dsCSEdit.Tables[0].Rows[0]["Urgency"].ToString() != "")
            //    {
            //        ddlUrgency.SelectedValue = dsCSEdit.Tables[0].Rows[0]["Urgency"].ToString();
            //    }

            //    if (dsCSEdit.Tables[0].Rows[0]["TargetDate"].ToString() != "")
            //    {
            //        dtpTargetDt.SelectedDate = Convert.ToDateTime(dsCSEdit.Tables[0].Rows[0]["TargetDate"].ToString());
            //    }
            //    else
            //    {
            //        dtpTargetDt.SelectedDate = DateTime.Today;
            //    }

            //    ddlStatus.Visible = true;
            //    lbltasksts.Visible = true;
            //    ddlStatus.SelectedValue = "Done";
            //    txtStatusRemarks.Visible = true;
            //    Label11.Visible = true;


            //    lblnetamount.Visible = true;
            //    txtNetAmount.Visible = true;
            //    lbltaxamount.Visible = true;
            //    lblsgstamount.Visible = true;
            //    txtTaxAmount.Visible = true;
            //    lblgrossamount.Visible = true;
            //    txtGrossAmount.Visible = true;

            //    lblcSendsms.Visible = true;
            //    txtSendsms.Visible = true;
            //    btnSendsms.Visible = true;


            //    lnktitle.Text  = "Update service status";
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ClearTaskDet()
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        dsDT = proc.ExecuteSP("GetServerDateTime");
        DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
        dtpStatusDt.SelectedDate = now;
        dtpTargetDt.SelectedDate = now;
        LoadGrid();
        //LoadAssignedBY();
        //LoadAssignedTo();//
        //txtMobile.Text = String.Empty;
        //txtEmail.Text = String.Empty;
        txtTask.Text = String.Empty;
        lblstatus.Text = String.Empty;
        //lbltaskcount.Text = String.Empty;
        txtStatusRemarks.Text = String.Empty;
        ddlTask.SelectedValue = "0";
        //ddlAssignedBy.Enabled = true;
        //ddlAssignedTo.Enabled = true;
       // txtMobile.Enabled = true;
       // txtEmail.Enabled = true;
        ddlUrgency.Enabled = true;
        dtpTargetDt.Enabled = true;
        cmbResident.SelectedValue = "0";
        btnSave.Visible = true;
        btnUpdate.Visible = false;
        //ddlAssignedBy.Focus();
        //ddlSerCategory.Items.Clear();
        //ddlSerType.Items.Clear();
        ddlstdtext.Items.Clear();
        txtTask.Text = string.Empty;
        txtMCount.Text = string.Empty;
        //txtMDate.Visible = false;
        txtMTime.Text = string.Empty;
        //lblMCount.Visible = false;
        //lblMDate.Visible = false;
        //lblMtime.Visible = false;
        Session["ServiceRSN"] = string.Empty;        
    }

    protected void rmTask_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Add a New Service")
        {
            pnlSecond.Visible = true;
            pnlThird.Visible = false;
            ddlSerType.Enabled = true;
            txtTask.Enabled = true;
            txtMCount.Enabled = true;
            dtpTargetDt.Enabled = true;
            ddlstdtext.Enabled = true;
            btnSave.Visible = true;
            btnUpdate.Visible = false;
            ddlStatus.Enabled = false;
            BtnnExcelExport.Visible = false;
            // lbltitle.Visible = true;
            lblcSendsms.Visible = false;
            txtSendsms.Visible = false;
            btnSendsms.Visible = false;
        }
        else if (e.Item.Text == "View Service List")
        {
            pnlSecond.Visible = false;
            pnlThird.Visible = true;
            ddlStatus.Enabled = true;
            BtnnExcelExport.Visible = true;
           // lbltitle.Visible = false;
        }

        else if (e.Item.Text == "Diary Link")
        {
            Response.Redirect("TransactionLevelInd.aspx");
        }
    }

    protected void btnExpProject_Click(object sender, EventArgs e)
    {

        if ((rdgTaskList.Visible == true) && (rdgTaskList.Items.Count > 0))
        {
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;
            dsDT = proc.ExecuteSP("GetServerDateTime");
            string CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");
            string FileName = "";
            string status = ddlSStatus.SelectedValue; 
            if (status.ToString()=="Open") 
            {
                FileName = "OpenServices_" + CDate;
                rdgTaskList.MasterTableView.Caption = "<span><br/>List of Open Services</span>";
            }
            else if (status.ToString()=="Overdue")
            {
                FileName = "OverdueServices_" + CDate;
                rdgTaskList.MasterTableView.Caption = "<span><br/>List of Overdue Services</span>";
            }        
            else if (status.ToString() == "Done")
            {
                FileName = "CompletedServices_" + CDate;
                rdgTaskList.MasterTableView.Caption = "<span><br/>List of Completed Services</span>";
            }
            else if (status.ToString() == "All")
            {
                FileName = "AllServices_" + CDate;
                rdgTaskList.MasterTableView.Caption = "<span><br/>List of All Services.</span>";
            }
            else if (status.ToString() == "Cncld")
            {
                FileName = "CancelledServices_" + CDate;
                rdgTaskList.MasterTableView.Caption = "<span><br/>List of Cancelled Services</span>";
            }

            rdgTaskList.ExportSettings.ExportOnlyData = true;
            rdgTaskList.ExportSettings.FileName = FileName;
            rdgTaskList.ExportSettings.IgnorePaging = true;
            rdgTaskList.ExportSettings.OpenInNewWindow = true;
            rdgTaskList.MasterTableView.ExportToExcel();
        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }

    //protected void ToDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    //{
    //    try
    //    {

    //        SqlProcsNew sqlobj = new SqlProcsNew();
    //        DataSet dsGroup = null;
    //        dsGroup = sqlobj.ExecuteSP("SP_FetchTaskList",
    //            new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
    //            new SqlParameter() { ParameterName = "@Status", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "CAL" },
    //            new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate },
    //            new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = ToDate.SelectedDate });
    //        rdgTaskList.DataSource = dsGroup.Tables[0];
    //        rdgTaskList.DataBind();
    //        dsGroup.Dispose();
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }

    //}
    //protected void FromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    //{
    //    try
    //    {

    //        SqlProcsNew sqlobj = new SqlProcsNew();
    //        DataSet dsGroup = null;
    //        dsGroup = sqlobj.ExecuteSP("SP_FetchTaskList",
    //            new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
    //            new SqlParameter() { ParameterName = "@Status", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "CAL" },
    //            new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate },
    //            new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = ToDate.SelectedDate });
    //        rdgTaskList.DataSource = dsGroup.Tables[0];
    //        rdgTaskList.DataBind();
    //        dsGroup.Dispose();
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }

    //}
    protected void rmHelp_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Help")
        {
            rwHelp.Visible = true;
        }
    }
    protected void rdgTaskList_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //Is it a GridDataItem
        if (e.Item is GridDataItem)
        {
            //Get the instance of the right type            
            GridDataItem dataBoundItem = e.Item as GridDataItem;
            //Check the formatting condition
            if (dataBoundItem["AssignedTo"].Text != "")
            {
               // dataBoundItem["AssignedTo"].ToolTip = dataBoundItem["AssignedTo"].Text.ToString() + "\n" +
              // dataBoundItem["Mobile"].Text.ToString() + "\n" + dataBoundItem["Dependant"].Text.ToString() + "\n" + dataBoundItem["DMobile"].Text.ToString();
                //Customize more...
            }
            if (dataBoundItem["Need"].Text != "")
            {
                //dataBoundItem["Need"].ToolTip = "Dept:" + dataBoundItem["deptname"].Text.ToString() + "\n" + "Rate:" + dataBoundItem["Rate"].Text.ToString() + "\n" +
                //        "DSMS:" + dataBoundItem["DSMS"].Text.ToString() + "\n" + "RSMS:" + dataBoundItem["RSMS"].Text.ToString() + "\n" + "MSMS:" + dataBoundItem["MSMS"].Text.ToString();
                                                
            }
            if(dataBoundItem["Need"].Text == "Complaint")
            {
                dataBoundItem["Need"].ForeColor = System.Drawing.Color.Red;
            }
            DateTime cdate= DateTime.Now ;
            DateTime tdate = Convert.ToDateTime(dataBoundItem["TargetDate"].Text);
            cdate = Convert.ToDateTime(cdate.ToShortDateString());
            tdate = Convert.ToDateTime(tdate.ToShortDateString());
            if (tdate < cdate)
            {
                dataBoundItem["TargetDate"].ForeColor = System.Drawing.Color.Red;
            }          
        }
    }
    

    public void LoadTaskDDL()
    {
        try
        {
            SqlProcsNew obj = new SqlProcsNew();
            DataSet ds = new DataSet();
            ds = obj.ExecuteSP("SP_GetTask",
                new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 1 });
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                ddlTask.DataSource = ds.Tables[0];
                ddlTask.DataTextField = "Task";
                ddlTask.DataValueField = "RSN";
                ddlTask.DataBind();
                ddlTask.Dispose();
                ddlTask.Items.Insert(0, new ListItem("Please Select", "0"));
            }
        }
        catch
        {

        }
    }
    protected void ddlSStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(ddlSStatus.SelectedValue.ToString() =="Done" || ddlSStatus.SelectedValue.ToString() == "All")
        {
            LblFromDate.Visible = true;
            FromDate.Visible = true;
            LblToDate.Visible = true;
            ToDate.Visible = true;
            if (ddlSStatus.SelectedValue.ToString() == "All")
            {
                DataSet ds = sqlobj.ExecuteSP("CC_GETBILLINGMONTH");
                FromDate.SelectedDate =DateTime.Parse(ds.Tables[0].Rows[0]["bpfrom"].ToString());
                ToDate.SelectedDate = DateTime.Parse(ds.Tables[0].Rows[0]["bptill"].ToString());
            }
            else {
                FromDate.SelectedDate = DateTime.Today;
                ToDate.SelectedDate = DateTime.Today;
            }
            btnCompsearch.Visible = true;
        }
        else
        {
            LblFromDate.Visible = false;
            FromDate.Visible = false;
            LblToDate.Visible = false;
            ToDate.Visible = false;
            btnCompsearch.Visible = false;
        }
        LoadGrid();
    }
    //protected void ddlTask_SelectedIndexChangednew(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        txtTask.Text = string.Empty;
           
    //        if (ddlTask.SelectedValue != "0")
    //        {
    //            SqlProcsNew obj = new SqlProcsNew();
    //            DataSet ds = new DataSet();
    //            ds = obj.ExecuteSP("SP_GetTask",
    //                new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 2 },
    //                new SqlParameter() { ParameterName = "@Task", SqlDbType = SqlDbType.NVarChar, Value = ddlTask.SelectedItem.Value });

    //            if (ds != null && ds.Tables[0].Rows.Count > 0)
    //            {
    //                txtTask.Text = ds.Tables[0].Rows[0]["Description"].ToString();

    //            }
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.ToString());
    //    }
    //}
    protected void btncalendarimg2_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("DayCalendar.aspx");
    }
    protected void ddlTask_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            txtTask.Text = string.Empty;
            if (ddlTask.SelectedValue != "0")
            {
                SqlProcsNew obj = new SqlProcsNew();
                DataSet ds = new DataSet();
                DataSet dscategory = new DataSet();
                string strCategory = "";
                DropDownList drplist = (DropDownList) sender;
                string selectval = drplist.SelectedItem.Text ;             
                ds = obj.ExecuteSP("SP_GetTask",
                    new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 2 },
                    new SqlParameter() { ParameterName = "@Task", SqlDbType = SqlDbType.NVarChar, Value = ddlTask.SelectedItem.Text   });
                if (ds != null && ds.Tables[0].Rows.Count > 0)
                {
                    txtTask.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void ddlSerCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadCategory();     
    }
    public void LoadCategory()
    {
        DataSet dsType = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_LoadServiceConfig", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 2);
            //cmd.Parameters.AddWithValue("@Category", ddlSerCategory.SelectedItem.ToString());
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsType, "temp");
            if (dsType.Tables[0].Rows.Count > 0)
            {
                ddlSerType.DataSource = dsType.Tables[0];
                ddlSerType.DataTextField = "Ctype";
                ddlSerType.DataValueField = "Ctype";
                ddlSerType.DataBind();
                LoadDepartments();
                LoadStandardText();
                CheckMandatory();
                LoadPriority();
            }
        }
        catch (Exception ex)
        {
        }
    }
    public void LoadDepartments()
    {
        DataSet dsDept = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_LoadServiceConfig", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 3);
            //cmd.Parameters.AddWithValue("@Category", ddlSerCategory.SelectedItem.ToString());
            cmd.Parameters.AddWithValue("@Ctype", ddlSerType.SelectedItem.ToString());
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsDept, "temp");
            if (dsDept.Tables[0].Rows.Count > 0)
            {
                //ddldept.DataSource = dsDept.Tables[0];
                //ddldept.DataTextField = "DeptName";
                //ddldept.DataValueField = "DeptCode";
                //ddldept.DataBind();
                txtTask.Text = dsDept.Tables[0].Rows[0]["Description"].ToString();
            }
        }
        catch (Exception ex)
        {
        }
    }
    //public void LoadCategoryLkup()
    //{
    //    DataSet dsDept = new DataSet();
    //    try
    //    {
    //        SqlCommand cmd = new SqlCommand("Proc_LoadDept", con);
    //        cmd.CommandType = CommandType.StoredProcedure;          
    //        SqlDataAdapter dap = new SqlDataAdapter(cmd);
    //        dap.Fill(dsDept, "temp");
    //        if (dsDept.Tables[0].Rows.Count > 0)
    //        {
    //            ddlCategory.DataSource = dsDept.Tables[0];
    //            ddlCategory.DataTextField = "Category";
    //            ddlCategory.DataValueField = "Code";
    //            ddlCategory.DataBind();               
    //        }
    //        ddlCategory.Items.Insert(0, "All");
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    public void LoadPriority()
    {
        DataSet dsDept = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_LoadServiceConfig", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 4);
            //cmd.Parameters.AddWithValue("@Category", ddlSerCategory.SelectedValue.ToString());
            //cmd.Parameters.AddWithValue("@Ctype", ddlSerType.SelectedItem.ToString());
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsDept, "temp");
            if (dsDept.Tables[0].Rows.Count > 0)
            {
               // lblPriority.Visible = true;
                //lblPriorityMsg.Text = dsDept.Tables[0].Rows[0]["Priority"].ToString();
            }
        }
        catch (Exception ex)
        {
        }
    }


    protected void ddlSerType_SelectedIndexChanged(object sender, EventArgs e)
    {      
        LoadServiceTypeDetails(); 
        LoadStandardText();
        CheckMandatory();       
    }

    
    private void LoadServiceTypeDetails()
    {
        try
        {
            DataSet dsServiceTypeDetails = sqlobj.ExecuteSP("SP_GetServiceTypeDetails", new SqlParameter { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = ddlSerType.SelectedValue });

            if (dsServiceTypeDetails.Tables[0].Rows.Count > 0)
            {
                
                lblcservice.Text = "Service";
                lblCategory.Text = "Category:" + dsServiceTypeDetails.Tables[0].Rows[0]["Category"].ToString();
                lblDepartment.Text = "Depatment:" + dsServiceTypeDetails.Tables[0].Rows[0]["deptname"].ToString();
                lbldescription.Text = "Description:" + dsServiceTypeDetails.Tables[0].Rows[0]["Description"].ToString();
                lblRate.Text = "Rate:" + dsServiceTypeDetails.Tables[0].Rows[0]["Rate"].ToString();
                txtNetAmount.Text = dsServiceTypeDetails.Tables[0].Rows[0]["Rate"].ToString();
                if (Session["CGST"] != null && Session["SGST"] != null)
                {
                    string strcgst = Session["CGST"].ToString();
                    string strsgst = Session["SGST"].ToString();
                    decimal servicetaxper = 0;
                    decimal sgsttaxper = 0;
                    if (strcgst.ToString() != "")
                    {
                        servicetaxper = Convert.ToDecimal(Session["CGST"].ToString());
                    }
                    if (strsgst.ToString() != "")
                    {
                        sgsttaxper = Convert.ToDecimal(Session["SGST"].ToString());
                    }
                    if (txtNetAmount.Text != "")
                    {
                        decimal taxamount = servicetaxper * (Convert.ToDecimal(txtNetAmount.Text) / 100);
                        decimal sgstamount = sgsttaxper * (Convert.ToDecimal(txtNetAmount.Text) / 100);
                        decimal grossamount = Convert.ToDecimal(txtNetAmount.Text) + Convert.ToDecimal(taxamount.ToString("0.00")) + Convert.ToDecimal(sgstamount.ToString("0.00"));
                        txtTaxAmount.Text = taxamount.ToString("0.00");
                        txtSGSTAmouont.Text = sgstamount.ToString("0.00");
                        txtGrossAmount.Text = grossamount.ToString("0.00");
                    }
                }
                else
                {
                    txtGrossAmount.Text = txtNetAmount.Text;
                }
            }
            else
            {
                lblCategory.Text = "";
                lblDepartment.Text = "";
                lblcservice.Text = "";
                lblcprofile.Text = ""; 
               
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadStandardText()
    {
        
        try
        {
            DataSet dsStdText = sqlobj.ExecuteSP("Proc_LoadStandardText", new SqlParameter { ParameterName = "@SerTypeRSN", SqlDbType = SqlDbType.BigInt, Value=ddlSerType.SelectedValue });

            if (dsStdText.Tables[0].Rows.Count > 0)
            {
                ddlstdtext.DataSource = dsStdText.Tables[0];
                ddlstdtext.DataTextField = "StdText1";
                ddlstdtext.DataValueField = "StdText1";
                ddlstdtext.DataBind();
            }
            else
            {
                ddlstdtext.Items.Clear();
            }

            ddlstdtext.Items.Insert(0,"--Select--");

            dsStdText.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void GetResidentTasks()
    {
        try
        {
            DataSet dsExistingTasks = sqlobj.ExecuteSP("SP_GetResientTasks",
                new SqlParameter { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue});
            if (dsExistingTasks.Tables[0].Rows.Count >0)
            {
                rgServiceList.DataSource = dsExistingTasks.Tables[0];
                rgServiceList.DataBind();
            }
            else
            {
                rgServiceList.DataSource = string.Empty;
                rgServiceList.DataBind();
            }
            dsExistingTasks.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void CheckMandatory()
    {       
        try
        {
            DataSet dsDept = sqlobj.ExecuteSP("Proc_CheckMandatory", 
                new SqlParameter { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = ddlSerType.SelectedValue });
            if (dsDept.Tables[0].Rows.Count > 0)
            {
                strDate = dsDept.Tables[0].Rows[0]["DateYorN"].ToString();
                strTime = dsDept.Tables[0].Rows[0]["TimeYorN"].ToString();
                strCount = dsDept.Tables[0].Rows[0]["CountYorN"].ToString();             
                if(strDate == "Y")
                {
                    lblMDate.Enabled = true;
                    txtMDate.Enabled = true;
                }
                else
                {
                    lblMDate.Enabled = false;
                    txtMDate.Enabled = false;
                }
                if (strTime == "Y")
                {
                    lblMtime.Enabled = true;
                    txtMTime.Enabled = true;
                }
                else
                {
                    lblMtime.Enabled = false;
                    txtMTime.Enabled = false;
                }
                if (strCount == "Y")
                {
                    lblMCount.Enabled = true;
                    txtMCount.Enabled = true;
                }
                else
                {
                    lblMCount.Enabled = false;
                    txtMCount.Enabled = false;
                }               
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void ibtnAddtext_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if(ddlstdtext.SelectedItem.ToString() != "")
            {
                string strAppend = ddlstdtext.SelectedItem.ToString();
                txtTask.Text = txtTask.Text + " "+ strAppend;
            }
        }
        catch (Exception ex)
        {           
        }
    }
    protected void ddlstdtext_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlstdtext.SelectedItem.ToString() != "")
        {
            string strAppend = ddlstdtext.SelectedItem.ToString();
            txtTask.Text = txtTask.Text + " " + strAppend + " ";
        }
    }
    //protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if(ddlCategory.SelectedItem.ToString() == "All")
    //        {
    //            LoadGrid_Categorywise(2);
    //        }
    //        else
    //        {
    //            LoadGrid_Categorywise(1);
    //        }

    //    }
    //    catch (Exception ex)
    //    {            
    //    }
    //}
    //protected void LoadGrid_Categorywise(int i)
    //{
    //    try
    //    {
    //        SqlProcsNew sqlobj = new SqlProcsNew();
    //        DataSet dsGroup = null;
    //        dsGroup = sqlobj.ExecuteSP("Proc_LoadCategorywise",
    //            new SqlParameter() { ParameterName = "@i", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = i },
    //            new SqlParameter() { ParameterName = "@category", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.SelectedValue.ToString() });
    //        rdgTaskList.DataSource = dsGroup.Tables[0];
    //        rdgTaskList.DataBind();
    //        dsGroup.Dispose();
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }


    //}
    protected void btnCompsearch_Click(object sender, EventArgs e)
    {
        LoadGrid();
    }
    protected void ddlCategory_SelectedIndexChanged1(object sender, EventArgs e)
    {

    }
   
    protected void btnSendsms_Click(object sender, EventArgs e)
    {
        try
        {

           string strsms =  "Ref:" +  Session["TaskRSN"].ToString() +  txtSendsms.Text;

            //SentSMS(Session["RMobileNo"].ToString(),strsms.ToString());

            WebMsgBox.Show("Your sms has been sent to resident");
        } 
        catch(Exception ex)
        {

        }
    }
    protected void HiddenButton_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime bdate = DateTime.Now;
            string strday = bdate.ToString("dd");
            string strmonth = bdate.ToString("MM");
            string stryear = bdate.ToString("yyyy");
            string strhour = bdate.ToString("HH");
            string strmin = bdate.ToString("mm");
            string strsec = bdate.ToString("ss");
            string strBillNo = "S" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();
            sqlobj.ExecuteSP("SP_InsertTransaction",
                           new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                           new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "SERVICE" },
                           new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "SERVICE" },
                           new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "s" },
                           new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = "UnBilled" },
                           new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = Session["ServiceRate"].ToString() },
                           new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                           new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = Session["ServiceRate"].ToString() },
                           new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                           new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                           new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = txtTask.Text },
                           new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                           new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() });
            decimal dlastdebit = 0;
            decimal dlastcredit = 0;
            DataSet dsgetdebitcredittoal = null;
            dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = Session["RTRSN"].ToString() });
            if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
            {
                dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
                dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
                dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());
            }
            sqlobj.ExecuteNonQuery("SP_UpdateClosingBalance",
                           new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                           new SqlParameter() { ParameterName = "@Closing", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding });
            sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
                new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
                new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
                new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
                new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Debit transaction updated');", true);         
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkAddnewservicetype_Click(object sender, EventArgs e)
    {
        Response.Redirect("ServiceConfig.aspx", false);
    } 
    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            LoadResidentProfile();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgServiceList_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgServiceList.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains" || menu.Items[i].Text == "GreaterThanOrEqualTo" || menu.Items[i].Text == "LessThanOrEqualTo")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
    protected void rdgTaskList_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rdgTaskList.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains" || menu.Items[i].Text == "GreaterThanOrEqualTo" || menu.Items[i].Text == "LessThanOrEqualTo")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
    protected void txtNetAmount_TextChanged(object sender, EventArgs e)
    {
        if (Session["CGST"] != null && Session["SGST"] != null)
                {
                    string strcgst = Session["CGST"].ToString();
                    string strsgst = Session["SGST"].ToString();
                    decimal servicetaxper = 0;
                    decimal sgsttaxper = 0;
                    if (strcgst.ToString() != "")
                    {
                        servicetaxper = Convert.ToDecimal(Session["CGST"].ToString());
                    }
                    if (strsgst.ToString() != "")
                    {
                        sgsttaxper = Convert.ToDecimal(Session["SGST"].ToString());
                    }
                    if (txtNetAmount.Text != "")
                    {
                        decimal taxamount = servicetaxper * (Convert.ToDecimal(txtNetAmount.Text) / 100);
                        decimal sgstamount = sgsttaxper * (Convert.ToDecimal(txtNetAmount.Text) / 100);
                        decimal grossamount = Convert.ToDecimal(txtNetAmount.Text) + Convert.ToDecimal(taxamount.ToString("0.00")) + Convert.ToDecimal(sgstamount.ToString("0.00"));
                        txtTaxAmount.Text = taxamount.ToString("0.00");
                        txtSGSTAmouont.Text = sgstamount.ToString("0.00");
                        txtGrossAmount.Text = grossamount.ToString("0.00");
                    }
                }
                else
                {
                    txtGrossAmount.Text = txtNetAmount.Text;
                }            
            
    }
}