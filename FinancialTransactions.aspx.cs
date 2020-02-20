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

public partial class FinancialTransactions : System.Web.UI.Page
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
            ReportList.DataSource = string.Empty;
            ReportList.DataBind();
            //DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            //dtpfordate.SelectedDate = sd;
            //dtpuntildate.SelectedDate = DateTime.Now;
            lbltotdebitcredit.Text = "";
            LoadDate();
            LoadResidentDet();
            LoadAccountNo();
            PopulateProductName();
           
            //LoadGrid1();
        }
    }
    protected void LoadDate()
    {
        try
        {

            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GETBILLINGDATE");
            dtpfordate.SelectedDate = Convert.ToDateTime(dsResident.Tables[0].Rows[0]["FROM"].ToString());
            dtpuntildate.SelectedDate = Convert.ToDateTime(dsResident.Tables[0].Rows[0]["TILL"].ToString());
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
            item2.Text = "--All--";
            item2.Value = "0";
            item2.Selected = true;
            cmbResident.Items.Add(item2);

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
                //ddlAccountNumber.Items.Add(new ListItem("G1000000", "1"));
                //ddlAccountNumber.Items.Add(new ListItem("D1000000", "2"));
                ddlAccountNumber.Enabled = false;
                //ddlAccountNumber.Items.Add("G1000000");
                //ddlAccountNumber.Items.Add("D1000000");
            }
            else
            {
                DataSet dsResident = new DataSet();

                dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
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
                    
            if (cmbResident.SelectedValue != "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_SOAGeneralTransactions",
                   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@AccountCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue.ToString() }
                  );                     
            }


            if (dsStatement.Tables[1].Rows.Count > 0)
            {
                //lblDebitCnt.Text = dsStatement.Tables[1].Rows[0]["DR"].ToString();
            }
            else
            {
                //lblDebitCnt.Text = "-";
            }
            if (dsStatement.Tables[2].Rows.Count > 0)
            {
                //lblCreditcnt.Text = dsStatement.Tables[2].Rows[0]["CR"].ToString();
            }
            else
            {
                //lblCreditcnt.Text = "-";
            }
            if (dsStatement.Tables[3].Rows.Count > 0)
            {
                lblCategory.Text = dsStatement.Tables[3].Rows[0]["AccountGroup"].ToString();
                lblSubGrp1.Text = dsStatement.Tables[3].Rows[0]["SubGroup1"].ToString();
            }
            else
            {
                lblCategory.Text = "-";
                //lblSubGrp1.Text = "-";               
            }
            if (dsStatement.Tables[4].Rows.Count > 0)
            {
                lblLatTxnDt.Text = dsStatement.Tables[4].Rows[0]["LastTxn"].ToString();
            }

            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                lblCloBal.Text = "0.00";
                lblLatTxnDt.Text = "-";
            }
            if (dsStatement.Tables[5].Rows.Count > 0)
            {

                lblOpBal.Text = dsStatement.Tables[5].Rows[0]["OpBal"].ToString();
            }
            else
            {
                lblOpBal.Text = "0.00";
            }
            if (dsStatement.Tables[6].Rows.Count > 0)
            {
                lblCloBal.Text = dsStatement.Tables[6].Rows[0]["Closing"].ToString();
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                lblCloBal.Text = "0.00";
            }

            dsStatement.Dispose();
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
            ReportList.Visible = false;
            ReportList.DataSource = string.Empty;
            ReportList.DataBind();
            if (cmbResident.SelectedValue == "0")
            {
                ddlAccountNumber.Items.Clear();
                ddlAccountNumber.Items.Add(new ListItem("All", "0"));
                //ddlAccountNumber.Items.Add("G1000000");
                //ddlAccountNumber.Items.Add("D1000000");
                ddlAccountNumber.Enabled = false;
            }
            else
            {
                DataSet dsResident = new DataSet();
                DataSet ds = new DataSet();

                dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                     new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });
                ddlAccountNumber.DataSource = dsResident.Tables[0];
                ddlAccountNumber.DataValueField = "AccountNo";
                ddlAccountNumber.DataTextField = "AccountNo";
                ddlAccountNumber.DataBind();
                ddlAccountNumber.Enabled = true;
                //ddlAccountNumber.Items.Add(new ListItem("All", "0"));
                //ds = sqlobj.ExecuteSP("SP_SOAGeneralTransactions",
                //   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                //       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                //       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },                      
                //   new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue.ToString() });
                //if (ds.Tables[0].Rows.Count > 0)
                //{
                //    lblCloBal.Text = ds.Tables[0].Rows[0]["Closing"].ToString();
                //    lblOpBal.Text = ds.Tables[0].Rows[0]["Closing"].ToString();
                //}
                //else
                //{
                //    lblCloBal.Text = "0.00";
                //}
                LoadOtherDet();
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                 
            }

            chkTxnCode.ClearSelection();
            lblDR.Text = "-";
            lblCR.Text = "-";

            

            lblLCount.Visible = false;
            lblLDR.Visible = false;
            lblDR.Visible = false;
            lblLCR.Visible = false;
            lblCR.Visible = false;

            //lblLDrTot.Visible = false;
            //lblDrTot.Visible = false;
            //lblLCrTot.Visible = false;
            //lblCrTot.Visible = false;

        }
        catch (Exception ex)
        {

        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 47 });


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
            ReportList.Visible = true;
            string STR = cmbResident.SelectedValue;
            DataSet dsStatement = new DataSet();

            string TxnCode = string.Empty;
            int CCnt = 0;

            for (int i = 0; i < chkTxnCode.Items.Count; i++)
            {
                if (chkTxnCode.Items[i].Selected)
                {
                    

                    TxnCode += chkTxnCode.Items[i].Value + ",";
                    CCnt++;
                }
            }

            if (CCnt > 0)
            {
                TxnCode = TxnCode.Remove(TxnCode.Length - 1);
                //TxnCode = "'" + TxnCode + "'";
            }




            if (cmbResident.SelectedValue == "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" },
                   new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt },
                   new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode });

            }
            else if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "1")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
                   new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt },
                   new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode });
            }
            else if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "2")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
                   new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt },
                   new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode });
            }
            else if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue == "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 4 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
                   new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt },
                   new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode });
            }
            else if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue != "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 5 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
                   new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt },
                   new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode });
            }

            if (dsStatement.Tables[0].Rows.Count > 0)
            {
                LoadOtherDet();
                ReportList.DataSource = dsStatement;
                ReportList.DataBind();
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No record for your selected date range.');", true);
            }

            lblDR.Text = dsStatement.Tables[1].Rows[0]["DR"].ToString();
            lblCR.Text = dsStatement.Tables[2].Rows[0]["CR"].ToString();

            //lblDrTot.Text = dsStatement.Tables[1].Rows[0]["DRTot"].ToString();
            //lblCrTot.Text = dsStatement.Tables[2].Rows[0]["CRTot"].ToString();




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
            //if (cmbResident.SelectedValue == "0")
            //{
            //    ReportList.DataSource = string.Empty;
            //    ReportList.DataBind();
            //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Resident, And Try Again.');", true);
            //    return;
            //}

            lblLCount.Visible = true;
            lblLDR.Visible = true;
            lblDR.Visible = true;
            lblLCR.Visible = true;
            lblCR.Visible = true;

            //lblLDrTot.Visible = true;
            //lblDrTot.Visible = true;
            //lblLCrTot.Visible = true;
            //lblCrTot.Visible = true;

            LoadGrid1();
            LoadBG();
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

        string TxnCode2 = string.Empty;
        int CCnt2 = 0;

        for (int i = 0; i < chkTxnCode.Items.Count; i++)
        {
            if (chkTxnCode.Items[i].Selected)
            {


                TxnCode2 += chkTxnCode.Items[i].Value + ",";
                CCnt2++;
            }
        }

        if (CCnt2 > 0)
        {
            TxnCode2 = TxnCode2.Remove(TxnCode2.Length - 1);
            //TxnCode = "'" + TxnCode + "'";
        }




        if (cmbResident.SelectedValue == "0")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" },
               new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt2 },
               new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode2 });

        }
        else if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "1")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
               new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt2 },
               new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode2 });
        }
        else if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "2")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 3 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
               new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt2 },
               new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode2 });
        }
        else if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue == "0")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 4 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
               new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt2 },
               new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode2 });
        }
        else if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue != "0")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetFinancialTransactions",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 5 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue },
               new SqlParameter() { ParameterName = "@TxnCnt", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CCnt2 },
               new SqlParameter() { ParameterName = "@TxnCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = TxnCode2 });
        }


        if (dsStatementRPT.Tables[0].Rows.Count > 0)
        {

            DataGrid dg = new DataGrid();

            dg.DataSource = dsStatementRPT.Tables[0];
            dg.DataBind();

            DateTime sdate = dtpfordate.SelectedDate.Value;
            DateTime edate = dtpuntildate.SelectedDate.Value;

            // THE EXCEL FILE.
            string sFileName = "Financial Transaction Ledger From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
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


            Response.Write("<table><tr><td>Financial Transaction Ledger</td><td> From :" + sdate.ToString("dd/MM/yyyy") + "</td><td> To :" + edate.ToString("dd/MM/yyyy") + "</td></tr></table>");

            //+ "</td><td>" + lbltotoutstanding.Text + " " + lbltotdebitcredit.Text + "</td></tr></table>");


            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
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


    public void PopulateProductName()
    {
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["CovaiSoft"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select  TP.TxnCode,Max(TP.StdDescription) +' ('+TP.TxnCode+')' as Description From tbltransactions TR left join tblTxnPostingRules TP on TP.TxnCode = TR.BGroup Group by TP.TxnCode order by max(StdDescription)";
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        ListItem item = new ListItem();
                        item.Text = sdr["Description"].ToString();
                        item.Value = sdr["TxnCode"].ToString();
                        //item.Selected = Convert.ToBoolean(sdr["IsSelected"]);
                        chkTxnCode.Items.Add(item);
                    }
                }

                conn.Close();
            }
            
        }
        
    }

    protected void checkboxcheckedchange(object sender, EventArgs e)
    {
        CheckBox c = (CheckBox)sender;
        if (c.Checked == true)
            c.ForeColor = Color.Blue;
        else
            c.ForeColor = Color.Black;
    }

    protected void LoadBG()
    {
        for (int i = 0; i < chkTxnCode.Items.Count; i++)
        {
            if (chkTxnCode.Items[i].Selected)
            {
                chkTxnCode.Items[i].Attributes.Add("style", "color: Orange;");
            }
            else
            {
                chkTxnCode.Items[i].Attributes.Add("style", "color: Black;");
            }
        }

    }

    protected void chkTxnCode_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadBG();


    }


    //int total;
    //private void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    //{
    //    if (e.Item is GridDataItem)
    //    {
    //        GridDataItem dataItem = e.Item as GridDataItem;
    //        int fieldValue = int.Parse(dataItem["DR"].Text);
    //        total += fieldValue;
    //    }
    //    if (e.Item is GridFooterItem)
    //    {
    //        GridFooterItem footerItem = e.Item as GridFooterItem;
    //        footerItem["DR"].Text = "total: " + total.ToString();
    //    }
    //}

    //Decimal total1;
    //Decimal total2;
    //protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    //{

    //    if (e.Item is GridDataItem)
    //    {
    //        GridDataItem dataItem = e.Item as GridDataItem;

    //        if (dataItem["CR"].Text == null || dataItem["CR"].Text == "")
    //            total1 += 0;
    //        else
    //            total1 += Convert.ToDecimal(dataItem["CR"].Text);

    //        if (dataItem["DR"].Text == null || dataItem["DR"].Text == "")
    //            total2 += 0;
    //        else
    //            total2 += Convert.ToDecimal(dataItem["DR"].Text);


    //    }
    //    else if (e.Item is GridFooterItem)
    //    {
    //        GridFooterItem footerItem = e.Item as GridFooterItem;
    //        footerItem["CR"].Text = total1.ToString();
    //        footerItem["DR"].Text = total2.ToString();

    //    }


        //if (e.Item is GridDataItem)
        //{
        //    GridDataItem dataItem = e.Item as GridDataItem;
        //    float fieldValue = float.Parse(dataItem["CR"].Text);
        //    total += fieldValue;
        //}
        //if (e.Item is GridFooterItem)
        //{
        //    GridFooterItem footerItem = e.Item as GridFooterItem;
        //    footerItem["CR"].Text = "total: " + total.ToString();
        //}
    //}
}