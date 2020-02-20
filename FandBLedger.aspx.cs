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
public partial class FandBLedger : System.Web.UI.Page
{
   
        SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        if (!IsPostBack)
        {
            LoadTitle();
            CheckPermission();
            dsDT = proc.ExecuteSP("GetServerDateTime");
            // LoadBillingPeriod();
            //ddlBillingPeriod.SelectedValue = Session["CurrentBillingPeriod"].ToString();
            ReportList.Visible = false;
            ReportListAll.Visible = false;
            ReportList.DataSource = string.Empty;
            ReportList.DataBind();
            DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            dtpfordate.SelectedDate = sd;
            dtpuntildate.SelectedDate = DateTime.Now;
            lbltotdebitcredit.Text = "";
            LoadResidentDet();
            LoadSessionFilter();
            LoadAccountNo();
            LoadDate();
           
            //LoadGrid1();
        }
    }

    protected void LoadSessionFilter()
    {
        try
        {

            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 12 });
            drpSessionfilters.DataSource = dsResident;
            drpSessionfilters.DataValueField = "Code";
            drpSessionfilters.DataTextField = "Name";
            drpSessionfilters.DataBind();
            drpSessionfilters.Items.Insert(0, (new ListItem("All", "0")));  

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
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
            item2.Text = "All";
            item2.Value = "0";
            item2.Selected = true;
            cmbResident.Items.Add(item2);

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void LoadDate()
    {
        try
        {

            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GETBILLINGDATE");
            dtpfordate.SelectedDate =Convert.ToDateTime(dsResident.Tables[0].Rows[0]["FROM"].ToString());
            dtpuntildate.SelectedDate= Convert.ToDateTime(dsResident.Tables[0].Rows[0]["TILL"].ToString());
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadAccountNo()
    {
        try
        {
            if (cmbResident.SelectedValue == "0")
            {
                ddlAccountNumber.Items.Clear();
                ddlAccountNumber.Items.Add(new ListItem("All", "0"));             

            }
            else
            {
                DataSet dsResident = new DataSet();

                dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 11 },
                     new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });
                ddlAccountNumber.DataSource = dsResident.Tables[0];
                ddlAccountNumber.DataValueField = "AccountNo";
                ddlAccountNumber.DataTextField = "AccountNo";
                ddlAccountNumber.DataBind();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }


    protected void LoadOtherDet()
    {

        try
        {
            string STR = cmbResident.SelectedValue;
            DataSet dsStatement = new DataSet();
            lblDebitCnt.Visible = false;
            lblCreditcnt.Visible = false;
            lblTCt.Visible = false;
            lblLatTxnDt.Visible = false;
            lblTDt.Visible = false;
            lblTCt.Visible = false;
            Label5.Visible = false;
            Label6.Visible = false;
            Label8.Visible = false;
            Label10.Visible = false;
            Label11.Visible = false;
            if (cmbResident.SelectedValue != "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_SOAGeneralTransactions",
                   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 5 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@AccountCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue.ToString() }
                   );

               
               
                if (dsStatement.Tables[1].Rows.Count > 0)
            {
                //lblDebitCnt.Text = dsStatement.Tables[1].Rows[0]["DR"].ToString();
            }
            else
            {
                lblDebitCnt.Text = "-";
            }
            if (dsStatement.Tables[2].Rows.Count > 0)
            {
                lblCreditcnt.Text = dsStatement.Tables[2].Rows[0]["CR"].ToString();
            }
            else
            {
                lblCreditcnt.Text = "-";
            }
            //if (dsStatement.Tables[3].Rows.Count > 0)
            //{
            //    lblCategory.Text = dsStatement.Tables[3].Rows[0]["AccountGroup"].ToString();
            //    lblSubGrp1.Text = dsStatement.Tables[3].Rows[0]["SubGroup1"].ToString();               
            //}
            //else
            //{
            //    lblCategory.Text = "-";
            //    lblSubGrp1.Text = "-";               
            //}
            if (dsStatement.Tables[3].Rows.Count > 0)
            {
                lblLatTxnDt.Text = dsStatement.Tables[3].Rows[0]["LastTxn"].ToString();                
            }

            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();

                lblTCt.Text = "0.00";
                lblLatTxnDt.Text = "-";
            }
            if (dsStatement.Tables[4].Rows.Count > 0)
            {

                lblTDt.Text = dsStatement.Tables[4].Rows[0]["DR"].ToString();
            }
            else
            {
                lblTDt.Text = "0.00";
            }
            if (dsStatement.Tables[5].Rows.Count > 0)
            {

                lblTCt.Text = dsStatement.Tables[5].Rows[0]["CR"].ToString();
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                lblTCt.Text = "0.00";
            }
                Label6.Visible = true;
                Label8.Visible = true;
                Label10.Visible = true;
                lblDebitCnt.Visible = true;
                lblLatTxnDt.Visible = true;
                lblTDt.Visible = true;
                
                dsStatement.Dispose();
        }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            lblname.Text = cmbResident.SelectedItem.Text;
            ReportList.Visible = false;
            ReportList.DataSource = string.Empty;
            ReportList.DataBind();
            ReportListAll.Visible = false;
            ReportListAll.DataSource = string.Empty;
            ReportListAll.DataBind();
            if (cmbResident.SelectedValue == "0")
            {
                ddlAccountNumber.Items.Clear();
                ddlAccountNumber.Items.Add(new ListItem("All", "0"));
                //ddlAccountNumber.Items.Add("G1000000");
                //ddlAccountNumber.Items.Add("D1000000");
            }
            else
            {
                DataSet dsResident = new DataSet();
                DataSet ds = new DataSet();

                dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 11 },
                     new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });
                ddlAccountNumber.DataSource = dsResident.Tables[0];
                ddlAccountNumber.DataValueField = "AccountNo";
                ddlAccountNumber.DataTextField = "AccountNo";
                ddlAccountNumber.DataBind();
                LoadOtherDet();
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
            }

        }
        catch (Exception ex)
        {

        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 155 });


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

    //protected void LoadBillingPeriod()
    //{
    //    try
    //    {

    //        DataSet ddlistBCode = new DataSet();

    //        ddlistBCode = sqlobj.ExecuteSP("SP_FetchBillingCodeDropDown",
    //             new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 });
    //        ddlBillingPeriod.DataSource = ddlistBCode.Tables[0];
    //        ddlBillingPeriod.DataValueField = "BPName";
    //        ddlBillingPeriod.DataTextField = "BPName";
    //        ddlBillingPeriod.DataBind();

    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }
    //}

    private void CheckPermission()
    {
        try
        {

            if (Session["UserID"] != null)
            {

                Permission p = new Permission();

                string result = p.GetPermission(Session["UserID"].ToString(), "ReportsandCharts");
                string result2 = p.GetPermission(Session["UserID"].ToString(), "ReportsandCharts");

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



    protected void LoadGrid1()
    {
        try
        {
            drpSessionfilters.SelectedValue = "0";
            string STR = cmbResident.SelectedValue;
            DataSet dsStatement = new DataSet();
            if (chkstatus.Checked == true)
            {

                if (cmbResident.SelectedValue == "0")
                {
                    dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                       new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 3 },
                       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                       new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                       new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" });

                }
                else if (cmbResident.SelectedValue != "0")
                {
                    dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                       new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 4 },
                       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                       new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                       new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
                }
            }
            if (chkstatus.Checked == false)
            {
                if (cmbResident.SelectedValue == "0")
                {
                    dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                       new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                       new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                       new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" });

                }
                else if (cmbResident.SelectedValue != "0")
                {
                    dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                       new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                       new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                       new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
                }
            }
            
            if (dsStatement.Tables[0].Rows.Count>0)
            {
                LoadOtherDet();
                ReportList.DataSource = dsStatement;
                ReportList.DataBind();
                ReportListAll.DataSource = dsStatement;
                ReportListAll.DataBind();
                lblDebitCnt.Text =Convert.ToString(dsStatement.Tables[0].Rows.Count);               
            }
            else
            {
                lblDebitCnt.Visible = false;
                lblCreditcnt.Visible = false;
                lblTCt.Visible = false;
                lblLatTxnDt.Visible = false;
                lblTDt.Visible = false;
                lblTCt.Visible = false;
                Label5.Visible = false;
                Label6.Visible = false;
                Label8.Visible = false;
                Label10.Visible = false;
                Label11.Visible = false;

                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                ReportListAll.DataSource = string.Empty; 
                ReportListAll.DataBind();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No record for your selected date range.');", true);
            }

           

            //if (dsStatement.Tables[0].Rows.Count > 0)
            //{

            //    ReportList.DataSource = dsStatement;
            //    ReportList.DataBind();
            //}

            dsStatement.Dispose();


            DataSet dsdatewise = sqlobj.ExecuteSP("[SP_GetDatewiseDebitCreditTotal]",
                 new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                 new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate });

            if (dsdatewise.Tables[0].Rows.Count > 0)
            {
                decimal totdebit = Convert.ToDecimal(dsdatewise.Tables[0].Rows[0]["TotalDebit"].ToString());
                decimal totcredit = Convert.ToDecimal(dsdatewise.Tables[0].Rows[0]["TotalCredit"].ToString());

                decimal FOutstading = totdebit - totcredit;
                String SFOutstading;

                if (FOutstading < 0)
                {
                    SFOutstading = Convert.ToString(FOutstading * -1) + " CR";
                }
                else
                {
                    SFOutstading = Convert.ToString(FOutstading);
                }


                lbltotdebitcredit.Text = "Total Debit:" + totdebit.ToString("0.00") + "  Total Credit:" + totcredit.ToString("0.00");
                lbltotoutstanding.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm") + " Total Current Outstanding as of now :" + SFOutstading;
            }

            dsdatewise.Dispose();


            DataSet dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetFTDebitCreditTotal]");

            if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
            {
                decimal totdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["TotalDebit"].ToString());
                decimal totcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["TotalCredit"].ToString());

                //lbltotoutstanding.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm") + " Total Current Outstanding as of now :" + (totdebit - totcredit).ToString("0.00");
            }
            else
            {
                lbltotdebitcredit.Text = "";
            }


            dsgetdebitcredittoal.Dispose();




        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }


    protected void BtnShow_Click(object sender, EventArgs e)
    {

        try
        {       
            if(cmbResident.SelectedValue=="0")
            {
                ReportListAll.Visible = true;
                ReportList.Visible = false;
              
            }
            else
            {
                ReportListAll.Visible = false;
                ReportList.Visible = true;
               
            }
            LoadGrid1();
        }
        catch (Exception ex)
        {

            WebMsgBox.Show(ex.ToString());

        }

    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {

        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsStatementRPT = new DataSet();
        DataSet dsStatement = new DataSet();
        if (chkstatus.Checked == true)
        {

            if (cmbResident.SelectedValue == "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" });

            }
            else if (cmbResident.SelectedValue != "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 4 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
            }
        }
        if (chkstatus.Checked == false)
        {
            if (cmbResident.SelectedValue == "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" });

            }
            else if (cmbResident.SelectedValue != "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
            }
        }
        if (dsStatement.Tables[0].Rows.Count>0)
        { 
        DataGrid dg = new DataGrid();

            dg.DataSource = dsStatement.Tables[0];
            dg.DataBind();
           
            DateTime sdate = dtpfordate.SelectedDate.Value;
            DateTime edate = dtpuntildate.SelectedDate.Value;

            // THE EXCEL FILE.
            string sFileName = "Unbilled Financial Transaction Ledger From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
            sFileName = sFileName.Replace("/", "");

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


            Response.Write("<table><tr><td> Unbilled Financial Transaction Ledger</td><td> From :" + sdate.ToString("dd/MM/yyyy") + "</td><td> To :" + edate.ToString("dd/MM/yyyy") + "</td></tr></table>");

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
            WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value + " statement does not exist");
        }

    }


    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid1();
    }

    protected void RMKPlanner_ItemClick(object sender, RadMenuEventArgs e)
    {


        if (e.Item.Text == "Financial Transactions")
        {
            Response.Redirect("DailyFoodBillReport.aspx");
        }

        else if (e.Item.Text == "Monthly Statement")
        {
            Response.Redirect("MailBilling.aspx");
        }
        else if (e.Item.Text == "Billing Summary View")
        {
            Response.Redirect("MonthlyBilling.aspx?MBVal=" + 2);
        }
        else if (e.Item.Text == "Billing History Per Resident")
        {
            Response.Redirect("ResidentTxnSummary.aspx?RSVal=" + 2);
        }
        else if (e.Item.Text == "Diners Summary")
        {
            Response.Redirect("DinerssummRep.aspx");
        }
        else if (e.Item.Text == "Which Menu which day")
        {
            Response.Redirect("MenuItemReport.aspx");
        }
        else if (e.Item.Text == "Ingredients Report")
        {
            Response.Redirect("IngredientsRep.aspx");
        }
        else if (e.Item.Text == "Menu for the day")
        {
            Response.Redirect("MenuItemPerday.aspx");
        }
    }

    protected void chkstatus_CheckedChanged(object sender, EventArgs e)
    {
        DataSet dsStatement = new DataSet();
        if (chkstatus.Checked==true)
        {
            
            if (cmbResident.SelectedValue == "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" });

            }
            else if (cmbResident.SelectedValue != "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 4 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
            }
        }
        if (chkstatus.Checked == false)
        {
            if (cmbResident.SelectedValue == "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" });

            }
            else if (cmbResident.SelectedValue != "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
            }
        }
        if (dsStatement.Tables[0].Rows.Count > 0)
        {
            LoadOtherDet();
            ReportList.DataSource = dsStatement;
            ReportList.DataBind();
            ReportListAll.DataSource = dsStatement;
            ReportListAll.DataBind();
            lblDebitCnt.Text = Convert.ToString(dsStatement.Tables[0].Rows.Count);
        }
        else
        {
            lblDebitCnt.Visible = false;
            lblCreditcnt.Visible = false;
            lblTCt.Visible = false;
            lblLatTxnDt.Visible = false;
            lblTDt.Visible = false;
            lblTCt.Visible = false;
            Label5.Visible = false;
            Label6.Visible = false;
            Label8.Visible = false;
            Label10.Visible = false;
            Label11.Visible = false;
            ReportList.DataSource = string.Empty;
            ReportList.DataBind();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No record for your selected date range.');", true);
        }



        //if (dsStatement.Tables[0].Rows.Count > 0)
        //{

        //    ReportList.DataSource = dsStatement;
        //    ReportList.DataBind();
        //}

        dsStatement.Dispose();
    }

    protected void ReportList_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = ReportList.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains" || menu.Items[i].Text == "EqualTo" || menu.Items[i].Text == "GreaterThan" || menu.Items[i].Text == "LessThan")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }

    protected void ReportListAll_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid1();
    }

    protected void ReportListAll_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = ReportListAll.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains" || menu.Items[i].Text == "EqualTo" || menu.Items[i].Text == "GreaterThan" || menu.Items[i].Text == "LessThan")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }

    protected void drpSessionfilters_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            
            DataSet dsStatement = new DataSet();
            if(drpSessionfilters.SelectedValue=="0")
            {
                BtnShow_Click(sender, e);
            }
            else { 
            if (chkstatus.Checked == true)
            {

                if (cmbResident.SelectedValue == "0")
                {
                    dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTxnsFilter",
                       new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 3 },
                       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                       new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                       new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" },
                       new SqlParameter() { ParameterName = "@Session", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = drpSessionfilters.SelectedValue }
                       );

                }
                else if (cmbResident.SelectedValue != "0")
                {
                    dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTxnsFilter",
                       new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 4 },
                       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                       new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                       new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
                        new SqlParameter() { ParameterName = "@Session", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = drpSessionfilters.SelectedValue });
                }
            }
            if (chkstatus.Checked == false)
            {
                if (cmbResident.SelectedValue == "0")
                {
                    dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTxnsFilter",
                       new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                       new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                       new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" },
                        new SqlParameter() { ParameterName = "@Session", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = drpSessionfilters.SelectedValue });

                }
                else if (cmbResident.SelectedValue != "0")
                {
                    dsStatement = sqlobj.ExecuteSP("SP_GetUnbilledTxnsFilter",
                       new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                       new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                       new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
                        new SqlParameter() { ParameterName = "@Session", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = drpSessionfilters.SelectedValue });
                }
            }
            if (dsStatement.Tables[0].Rows.Count > 0)
            {
                if(cmbResident.SelectedValue == "0") { ReportListAll.DataSource = dsStatement.Tables[0];ReportListAll.DataBind(); }
                else { ReportList.DataSource = dsStatement.Tables[0]; ReportList.DataBind(); }
            }
            else
            {
                if (cmbResident.SelectedValue == "0") { ReportListAll.DataSource = string.Empty; ReportListAll.DataBind(); }
                else { ReportList.DataSource = string.Empty; ReportList.DataBind(); }
            }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('"+ex.Message.ToString()+"');", true);
        }
    }
}