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

public partial class ServicePosting : System.Web.UI.Page
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
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        DateTime dstart = new DateTime();
        if (!IsPostBack)
        {
            LoadServiceType();
            LoadResidentDet();
            dsDT = proc.ExecuteSP("GetServerDateTime");
            DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
            DateTime now2 = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
            // LoadTasksCount();
            //LoadGrid();
            loadData();
            LoadHelp();
            radDateComp.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString());
            txtCompTime.Text = DateTime.Now.ToString("hh:mm");
        }
    }
    private void LoadHelp()
    {
        try
        {
            lblhelp.Visible = true;
            lblhelp1.Visible = true;
            lblMsg.Visible = true;
            DataSet dsTxn = sqlobj.ExecuteSP("SP_TxnDropDownList",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@TxnCode", SqlDbType = SqlDbType.NVarChar, Value = "SC" });
            if (dsTxn.Tables[0].Rows.Count > 0)
            {
                lblhelp1.Text = dsTxn.Tables[0].Rows[0]["Help"].ToString();
                string msg = dsTxn.Tables[0].Rows[0]["StdDescription"].ToString();
                string CGST = dsTxn.Tables[0].Rows[0]["CGST"].ToString();
                string SGST = dsTxn.Tables[0].Rows[0]["SGST"].ToString();
                string code = dsTxn.Tables[0].Rows[0]["TxnCode"].ToString();
                string All = msg + " - " + code + "  <br/> " + "CGST %:- " + CGST + "  - " + "SGST %:- " + SGST;
                lblMsg.Text = All;
            }
            dsTxn.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void loadData()
    {
        try
        {
            Int32 RSN = Convert.ToInt32(Request.QueryString["rsn"].ToString());
            DataSet dsCSEdit = sqlobj.ExecuteSP("Proc_NewTasks",
               new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 },
               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN });
            if (dsCSEdit.Tables[0].Rows.Count > 0)
            {
                cmbResident.SelectedValue = dsCSEdit.Tables[0].Rows[0]["RTRSN"].ToString();
                //LoadResidentProfile();
                txtTask.Text = dsCSEdit.Tables[0].Rows[0]["Task"].ToString();
                ddlStatus.SelectedValue = dsCSEdit.Tables[0].Rows[0]["TaskStatus"].ToString();
                LoadServiceType();
                ddlSerType.SelectedValue = dsCSEdit.Tables[0].Rows[0]["SerTypeRSN"].ToString();
                //LoadStandardText();
                txtMDate.Enabled = false;
                txtMTime.Enabled = false;
               
                if (dsCSEdit.Tables[0].Rows[0]["taskdate"].ToString() != "")
                {
                    txtMDate.SelectedDate = Convert.ToDateTime(dsCSEdit.Tables[0].Rows[0]["taskdate"].ToString());
                }
                else
                {
                    txtMDate.SelectedDate = null;
                }

                txtMTime.Text = dsCSEdit.Tables[0].Rows[0]["TaskTime"].ToString();
                if (dsCSEdit.Tables[0].Rows[0]["Urgency"].ToString() != "")
                {
                    // ddlUrgency.SelectedValue = dsCSEdit.Tables[0].Rows[0]["Urgency"].ToString();
                }

                if (dsCSEdit.Tables[0].Rows[0]["TargetDate"].ToString() != "")
                {
                    dtpTargetDt.SelectedDate = Convert.ToDateTime(dsCSEdit.Tables[0].Rows[0]["TargetDate"].ToString());
                }
                else
                {
                    dtpTargetDt.SelectedDate = null;
                }
                txtStatusRemarks.Text = dsCSEdit.Tables[0].Rows[0]["StatusRemarks"].ToString();
                Session["AccCode"] = dsCSEdit.Tables[0].Rows[0]["GLAccount"].ToString();
                ddlStatus.Visible = true;
                lbltasksts.Visible = true;               
                txtStatusRemarks.Visible = true;                        
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlSerType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //LoadStandardText();
    }

    protected void txtNetAmount_TextChanged(object sender, EventArgs e)
    {
        string strtaxc = "";
        string strsgst = "";
        DataSet dsTaxc = sqlobj.ExecuteSP("SP_GetGST",
            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 }
            );

        if (dsTaxc.Tables[0].Rows.Count > 0)
        {
            strtaxc = dsTaxc.Tables[0].Rows[0]["CGST_PCNT"].ToString();
            Session["CGST"] = strtaxc.ToString();
            strsgst = dsTaxc.Tables[0].Rows[0]["SGST_PCNT"].ToString();
            Session["SGST"] = strsgst.ToString();
        }
        decimal CGSTPER = 0;
        decimal SGSTPER = 0;
        if (strtaxc.ToString() != "")
        {
            CGSTPER = Convert.ToDecimal(Session["CGST"].ToString());
        }
        if (strsgst.ToString() != "")
        {
            SGSTPER = Convert.ToDecimal(Session["SGST"].ToString());
        }

        if (txtNetAmount.Text != "")
        {
            lbltaxamount.Visible = true;
            lblCGST.Visible = true;
            lbltaxpercentage.Visible = true;
            lblsgstamount.Visible = true;
            lblSGST.Visible = true;
            lblsgstpercentage.Visible = true;
            lblnet.Visible = true;
            lblNetAmount.Visible = true;
            lblAccount.Visible = true;
            lblAccountcd.Visible = true;
            lblAccountcd.Text = Session["AccCode"].ToString();
            decimal cgstamount = CGSTPER * (Convert.ToDecimal(txtNetAmount.Text) / 100);
            decimal sgstamount = SGSTPER * (Convert.ToDecimal(txtNetAmount.Text) / 100);
            decimal grossamount = Convert.ToDecimal(txtNetAmount.Text) + Convert.ToDecimal(cgstamount.ToString("0.00")) + Convert.ToDecimal(sgstamount.ToString("0.00"));
            lblNetAmount.Text = grossamount.ToString("0.00");
            Session["CGST"] = cgstamount.ToString("0.00");
            lblCGST.Text = cgstamount.ToString("0.00");
            Session["SGST"] = sgstamount.ToString("0.00");
            lblSGST.Text = sgstamount.ToString("0.00");
            txtStatusRemarks.Text = txtStatusRemarks.Text + "- Rs." + lblNetAmount.Text;
        }
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
        catch (Exception ex)
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
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
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

    protected void btnDone_Click(object sender, EventArgs e)
    {
        //ddlStatus.SelectedValue = "Done";
        lblGrossamount.Visible = true;
        btnSave.Visible = true;
        btnDone.Visible = false;
        btnUpdate.Visible = false;
        txtNetAmount.Visible = true;
        ddlStatus.Visible = false;
        lbltasksts.Visible = false;

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
          if (string.IsNullOrEmpty(txtNetAmount.Text))
            {
                WebMsgBox.Show("Please enter valid amount.");
                txtNetAmount.Focus();
                return;
            }              
            else
            {
                SqlProcsNew obj = new SqlProcsNew();
                DateTime bdate = DateTime.Now;
                string strday = bdate.ToString("dd");
                string strmonth = bdate.ToString("MM");
                string stryear = bdate.ToString("yyyy");
                string strhour = bdate.ToString("HH");
                string strmin = bdate.ToString("mm");
                string strsec = bdate.ToString("ss");
                string strBillNo = stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();
                string narration = ddlSerType.SelectedItem.ToString() + "-" +txtStatusRemarks.Text;
                DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertUNBILLEDTxnPosting",
                                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue.ToString() },
                                   new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "SC" },
                                   new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                   new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtNetAmount.Text },
                                   new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = narration },
                                   new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                   new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                   new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                   //new SqlParameter() { ParameterName = "@TXRefNo", SqlDbType = SqlDbType.NVarChar, Value = Session["TaskRSN"].ToString() },
                                   new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() },
                                   new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                   new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = Session["AccCode"].ToString() },
                                   new SqlParameter() { ParameterName = "@CGST", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Session["CGST"].ToString()) },
                                   new SqlParameter() { ParameterName = "@SGST", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Session["SGST"].ToString()) }
                                     );



                sqlobj.ExecuteNonQuery("Proc_NewTasks",
                   new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 },
                   new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt16(Session["TaskRSN"].ToString()) },
                   new SqlParameter() { ParameterName = "@Task", SqlDbType = SqlDbType.VarChar, Value = txtTask.Text },
                    //new SqlParameter() { ParameterName = "@Urgency", SqlDbType = SqlDbType.VarChar, Value = ddlUrgency.SelectedValue.ToString() },
                   new SqlParameter() { ParameterName = "@TaskStatus", SqlDbType = SqlDbType.VarChar, Value = "Done" },
                   new SqlParameter() { ParameterName = "@StatusDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Today },
                   new SqlParameter() { ParameterName = "@M_By", SqlDbType = SqlDbType.VarChar, Value = Session["UserID"].ToString() == null ? null : "Admin" },
                   new SqlParameter() { ParameterName = "@StatusRemarks", SqlDbType = SqlDbType.VarChar, Value = txtStatusRemarks.Text.ToString() == null ? null : txtStatusRemarks.Text },
                   new SqlParameter() { ParameterName = "@Targetdate", SqlDbType = SqlDbType.DateTime, Value = dtpTargetDt.SelectedDate },
                   new SqlParameter() { ParameterName = "@CompDate", SqlDbType = SqlDbType.DateTime, Value = radDateComp.SelectedDate },
                   new SqlParameter() { ParameterName = "@CompTime", SqlDbType = SqlDbType.NVarChar, Value = txtCompTime.Text },
                   new SqlParameter() { ParameterName = "@AmtCharged", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(lblNetAmount.Text) }
                   );
               
                WebMsgBox.Show("Service Details and Payment Amount Saved Successfully");
            }
          
            Session["CGST"] = null;
            Session["SGST"] = null;
            Session["AccCode"] = null;
            Redirect();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("TaskList.aspx?Value1=2&Value2=-");
    }
    protected void Redirect()
    {
        try
        {
            Response.Redirect("TaskList.aspx?Value1=2&Value2=-");
        }
        catch (Exception ex)
        {
            //WebMsgBox.Show(ex.ToString());
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            //if(ddlStatus.SelectedValue=="Done")
            //{
            //    txtStatusRemarks.Text = txtStatusRemarks.Text.ToString() + "- Rs.0.00";
            //}                
                SqlProcsNew obj = new SqlProcsNew();
                sqlobj.ExecuteNonQuery("Proc_NewTasks",
                   new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
                   new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt16(Session["TaskRSN"].ToString()) },
                   new SqlParameter() { ParameterName = "@Task", SqlDbType = SqlDbType.VarChar, Value = txtTask.Text },
                    //new SqlParameter() { ParameterName = "@Urgency", SqlDbType = SqlDbType.VarChar, Value = ddlUrgency.SelectedValue.ToString() },
                   new SqlParameter() { ParameterName = "@TaskStatus", SqlDbType = SqlDbType.VarChar, Value = ddlStatus.SelectedValue.ToString() },
                   new SqlParameter() { ParameterName = "@StatusDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Today },
                   new SqlParameter() { ParameterName = "@M_By", SqlDbType = SqlDbType.VarChar, Value = Session["UserID"].ToString() == null ? null : "Admin" },
                   new SqlParameter() { ParameterName = "@StatusRemarks", SqlDbType = SqlDbType.VarChar, Value = txtStatusRemarks.Text.ToString() == null ? null : txtStatusRemarks.Text },
                   new SqlParameter() { ParameterName = "@Targetdate", SqlDbType = SqlDbType.DateTime, Value = dtpTargetDt.SelectedDate },
                    new SqlParameter() { ParameterName = "@CompDate", SqlDbType = SqlDbType.DateTime, Value = radDateComp.SelectedDate },
                   new SqlParameter() { ParameterName = "@CompTime", SqlDbType = SqlDbType.NVarChar, Value = txtCompTime.Text == "" ? "00:00" : txtCompTime.Text },
                    new SqlParameter() { ParameterName = "@AmtCharged", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal("0.00") }
                   );
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Service Details Updated Successfully');", true);                
                Redirect();
            
           
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('"+ ex.Message.ToString()+"');", true);
        }

    }
}