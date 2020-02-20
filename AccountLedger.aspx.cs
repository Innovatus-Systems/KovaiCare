using System;
using System.Collections.Generic;
using System.Linq;
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
using System.Text;

public partial class AccountLedger : System.Web.UI.Page
{
   
    SqlProcsNew sqlobj = new SqlProcsNew();    
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        rwTransactions.VisibleOnPageLoad = true;
        rwTransactions.Visible = false;
        rdMEB.VisibleOnPageLoad = true;
        rdMEB.Visible = false;
        DataTable dt = new DataTable();
        if (!IsPostBack)
        {
            LoadTitle();
            dsDT = proc.ExecuteSP("GetServerDateTime");
            ReportList.DataSource = string.Empty;
            ReportList.DataBind();
            DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            LoadBilling();
            LoadTrailBalance();
            ReportList.Visible = false;
            BtnnExcelExport.Visible = false;
        }
    }


    public void LoadBilling()
    {
        try
        {
            DataSet dsBilling = new DataSet();
            dsBilling = sqlobj.ExecuteSP("Proc_LoadBilling");
            if (dsBilling.Tables[0].Rows.Count > 0)
            {
                ddlBilling.DataSource = dsBilling.Tables[0];
                ddlBilling.DataTextField = "BPName";
                ddlBilling.DataValueField = "RSN";
                ddlBilling.DataBind();
            }

            dsBilling.Dispose();

            ddlBilling.SelectedItem.Text = Session["CurrentBillingPeriod"].ToString();

        }
        catch (Exception ex)
        {
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 134 });


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
    private void LoadTrailBalance()
    {
        DataTable dtNew = new DataTable();
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_SOAGeneralTransactions",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });

            DataTable dt = dsCategory.Tables[0];
            DataRow[] drFilterRows = dt.Select();
            if (drFilterRows.Any())
            {
                dtNew = drFilterRows.CopyToDataTable();
                dtNew.DefaultView.Sort = "SortID";
                if (dtNew.Rows.Count > 0)
                {

                    rdAllTrial.DataSource = dtNew;
                    rdAllTrial.DataBind();
                }
                else
                {
                    rdAllTrial.DataSource = string.Empty;
                    rdAllTrial.DataBind();
                }
                dsCategory.Dispose();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    protected void LoadResidentLedger()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_AccountMaster",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 13 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                ReportList.DataSource = dsCategory.Tables[0];
                ReportList.DataBind();
                lblCount.Text = "Count :" + dsCategory.Tables[0].Rows.Count.ToString();
                Session["ExportExcel"] = null;
                Session["ExportExcel"] = dsCategory.Tables[0];
                BtnnExcelExport.Visible = true;
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                BtnnExcelExport.Visible = false;
            }
            dsCategory.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void LoadResidentDepLedger()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_AccountMaster",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 15 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                ReportList.DataSource = dsCategory.Tables[0];
                ReportList.DataBind();
                lblCount.Text = "Count :" + dsCategory.Tables[0].Rows.Count.ToString();
                Session["ExportExcel"] = null;
                Session["ExportExcel"] = dsCategory.Tables[0];
                BtnnExcelExport.Visible = true;
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                BtnnExcelExport.Visible = false;
            }
            dsCategory.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadGuestLedger()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_AccountMaster",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 14 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                ReportList.DataSource = dsCategory.Tables[0];
                ReportList.DataBind();
                lblCount.Text = "Count :" + dsCategory.Tables[0].Rows.Count.ToString();
                Session["ExportExcel"] = null;
                Session["ExportExcel"] = dsCategory.Tables[0];
                BtnnExcelExport.Visible = true;
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                BtnnExcelExport.Visible = false;
            }
            dsCategory.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadAccountLedger()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_AccountMaster",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                ReportList.DataSource = dsCategory.Tables[0];
                ReportList.DataBind();
                lblCount.Text = "Count :" + dsCategory.Tables[0].Rows.Count.ToString();
                Session["ExportExcel"] = null;
                Session["ExportExcel"] = dsCategory.Tables[0];
                BtnnExcelExport.Visible = true;
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
            }
            dsCategory.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsStatementRPT = new DataSet();
            DataSet dsCategory = sqlobj.ExecuteSP("SP_AccountMaster",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 10 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                DataGrid dg = new DataGrid();
                dg.DataSource = dsCategory.Tables[0];
                dg.DataBind();
                string sFileName = "Account Ledger.xls";
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


                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                //WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value + " statement does not exist");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (lbltile.Text == "General Ledger")
        { 
        LoadAccountLedger();
        }
        if (lbltile.Text == "Resident Ledger")
        {
            LoadResidentLedger();           
        }
        if (lbltile.Text  == "Guest House Ledger")
        {
            LoadGuestLedger();
        }
        if (lbltile.Text == "Res. Deposit Ledger")
        {
            LoadResidentDepLedger();
        }
    }
    //protected void btnTransactionClose_Click(object sender, EventArgs e)
    //{
    //    rwTransactions.Visible = false;
    //}
    protected void Lnkbtnview_Click(object sender, EventArgs e)
    {

        DataSet dsBillingPeriod = sqlobj.ExecuteSP("SP_AccountMaster",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 8 },
                    new SqlParameter() { ParameterName = "@CurrentBillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() }
                    );


        DateTime fdate = Convert.ToDateTime(dsBillingPeriod.Tables[0].Rows[0]["BPFrom"].ToString());

        DateTime tdate = Convert.ToDateTime(dsBillingPeriod.Tables[0].Rows[0]["BPTill"].ToString());

        LinkButton lnkAccountCode = (LinkButton)sender;

        Session["AccountCode"] = lnkAccountCode.Text;

        GridDataItem row = (GridDataItem)lnkAccountCode.NamingContainer;
        string strAccountType = row.Cells[2].Text;
        string strAccountName = row.Cells[10].Text;

        DataSet dsStatement = sqlobj.ExecuteSP("SP_AccountLedgerTransactions",
                   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = fdate.ToString("yyyy-MM-dd") },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = tdate.ToString("yyyy-MM-dd") },
                   new SqlParameter() { ParameterName = "@AccountCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = lnkAccountCode.Text });


        lblAccountCode.Text = "Account Code:" + lnkAccountCode.Text;
        lblAccountName.Text = "Account Name:" + strAccountName.ToString();
        // lblAccountType.Text = "Account Type:" + strAccountType.ToString();


        lblFrom.Text = "From:" + fdate.ToString("dd/MM/yyyy");
        lblTill.Text = "Till:" + tdate.ToString("dd/MM/yyy");

        if (dsStatement.Tables[0].Rows.Count > 0)
        {
            rgGeneralTransactions.DataSource = dsStatement;
            rgGeneralTransactions.DataBind();
        }

        else
        {
            rgGeneralTransactions.DataSource = string.Empty;
            rgGeneralTransactions.DataBind();
        }

        dsStatement.Dispose();

        rwTransactions.Visible = true;
    }
    protected void ddlBilling_SelectedIndexChanged(object sender, EventArgs e)
    {

        DataSet dsBillingPeriod = sqlobj.ExecuteSP("SP_AccountMaster",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 8 },
                 new SqlParameter() { ParameterName = "@CurrentBillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = ddlBilling.SelectedItem.Text }
                 );


        DateTime fdate = Convert.ToDateTime(dsBillingPeriod.Tables[0].Rows[0]["BPFrom"].ToString());

        DateTime tdate = Convert.ToDateTime(dsBillingPeriod.Tables[0].Rows[0]["BPTill"].ToString());

        DataSet dsStatement = sqlobj.ExecuteSP("SP_AccountLedgerTransactions",
                 new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = fdate.ToString("yyyy-MM-dd") },
                 new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = tdate.ToString("yyyy-MM-dd") },
                 new SqlParameter() { ParameterName = "@AccountCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Session["AccountCode"].ToString() });

        if (dsStatement.Tables[0].Rows.Count > 0)
        {
            rgGeneralTransactions.DataSource = dsStatement;
            rgGeneralTransactions.DataBind();
        }

        else
        {
            rgGeneralTransactions.DataSource = string.Empty;
            rgGeneralTransactions.DataBind();
        }



        dsStatement.Dispose();


        lblFrom.Text = "From:" + fdate.ToString("dd/MM/yyyy");
        lblTill.Text = "Till:" + tdate.ToString("dd/MM/yyy");

        rwTransactions.Visible = true;


    }
    protected void ReportList_Init(object sender, System.EventArgs e)
    {
        GridFilterMenu menu = ReportList.FilterMenu;
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
    protected void lnkAccName_Click(object sender, System.EventArgs e)
    {
        LinkButton lnkAccName = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkAccName.NamingContainer;
        string strAccountType = row.Cells[2].Text;
        string strAccountCode = row.Cells[9].Text;
        string strAccountName = row.Cells[4].Text;

        DataSet dsStatement = sqlobj.ExecuteSP("SP_AccountLedgerTransactions",
                   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
                   new SqlParameter() { ParameterName = "@AccountCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = strAccountCode });

        if (dsStatement.Tables[0].Rows.Count > 0)
        {
            rgMEB.DataSource = dsStatement.Tables[0];
            rgMEB.DataBind();
        }
        else
        {
            rgMEB.DataSource = string.Empty;
            rgMEB.DataBind();
        }
        if (dsStatement.Tables[1].Rows.Count > 0)
        {
            lblAccount.Text = dsStatement.Tables[1].Rows[0]["Account"].ToString();
            lblcategory.Text = dsStatement.Tables[1].Rows[0]["Category"].ToString();
            lblSubGrp.Text = dsStatement.Tables[1].Rows[0]["SubGroup1"].ToString();
        }
        dsStatement.Dispose();
        rdMEB.Visible = true;
    }

    protected void lnkTitle_Click(object sender, System.EventArgs e)
    {
        LinkButton lnkTitle = (LinkButton)sender;
        lbltile.Text = lnkTitle.Text;
        Session["LkText"] = lnkTitle.Text;
        if (lnkTitle.Text == "General Ledger")
        {
            ReportList.Visible = true;
            lbltile.Visible = true;           
            LoadAccountLedger();
        }
        else if (lnkTitle.Text == "Resident Ledger")
        {
            ReportList.Visible = true;
            lbltile.Visible = true;
            LoadResidentLedger();
        }
        else if (lnkTitle.Text == "Guest House Ledger")
        {
            ReportList.Visible = true;
            lbltile.Visible = true;
            LoadGuestLedger();
        }
        else if (lnkTitle.Text == "Res. Deposit Ledger")
        {
            ReportList.Visible = true;
            lbltile.Visible = true;
            LoadResidentDepLedger();
        }
    }
    protected void Button1_Click(object sender, System.EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsStatementRPT = new DataSet();
            //if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue != "0")
            //{
            //    dsStatementRPT = Session["Exportexcel"];
            //}
            if (Session["ExportExcel"] != null)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = Session["ExportExcel"];
                dg.DataBind();              
                // THE EXCEL FILE.
                string date = DateTime.Now.ToString("dd-MM-yyyy-hh-mm");
                string dateasof = DateTime.Now.ToString("dd-MMM-yyyy hh:mm");
                dateasof = dateasof + " Hrs";
                string sFileName = date;
                sFileName = sFileName.Replace("-", "");
                sFileName = "Statement of Account - " + lbltile.Text+" " + sFileName;

                // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment; filename=" + sFileName + ".xls");
                Response.ContentType = "application/vnd.ms-excel";
                EnableViewState = false;

                System.IO.StringWriter objSW = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

                dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
                dg.RenderControl(objHTW);


                Response.Write("<table style='font-weight:bold;font-size:16px;font-family:Verdana;'><tr><td>Statement of Account -</td><td>"+lbltile.Text.ToString()+"</td><td> as of  :" + dateasof + "</td></tr><tr><td></td></tr></table>");
                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:soild 1px #999; } " +
                    "TD { border:soild 1px #D5D5D5; text-align:center } </style>");
                Response.Write("<table><tr><td>");
                Response.Write(objSW.ToString());
                Response.Write("</td></tr></table>");
                Response.End();
                dg = null;
            }
            else
            {
                WebMsgBox.Show(" Cannot Export , Try again later.");
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.ToString() + "');", true);
        }
    }
}