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

public partial class StockTransactionReport : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadTitle();

            LoadProvisionGroup();
            
            LoadTransactionType();

            ReportList.DataSource = string.Empty;
            ReportList.DataBind();

            ReportSummary.DataSource = string.Empty;
            ReportSummary.DataBind();

            DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);

            dtpfordate.SelectedDate = sd;
            dtpuntildate.SelectedDate = DateTime.Now;
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 99 });


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

    private void LoadProvisionGroup()
    {
        try
        {
            DataSet dsLoadProvisionType = sqlobj.ExecuteSP("SP_ProvisionType", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 }
                );

            ddlGroup.Items.Clear();

            if (dsLoadProvisionType.Tables[0].Rows.Count > 0)
            {

                ddlGroup.DataSource = dsLoadProvisionType;
                ddlGroup.DataTextField = "PCode";
                ddlGroup.DataValueField = "PCode";
                ddlGroup.DataBind();

            }

            ddlGroup.Items.Insert(0, "All");

            dsLoadProvisionType.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
  

    private void LoadTransactionType()
    {
        try
        {
            DataSet dsTransType = sqlobj.ExecuteSP("SP_GetStockTransactonType");

            ddlTransactionType.Items.Clear();

            if (dsTransType.Tables[0].Rows.Count >0)
            {
                ddlTransactionType.DataSource = dsTransType;
                ddlTransactionType.DataValueField = "Value";
                ddlTransactionType.DataTextField = "Name";
                ddlTransactionType.DataBind();
            }

            ddlTransactionType.Items.Insert(0, "All");

            dsTransType.Dispose();

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadStockTransactionReport()
    {
        try
        {
            ReportList.DataSource = string.Empty;
            ReportList.DataBind();

            ReportSummary.DataSource = string.Empty;
            ReportSummary.DataBind();

            DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_StockTransactionReport",
                new SqlParameter() { ParameterName = "@StockGroup", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue == "All" ? null : ddlGroup.SelectedValue },
                new SqlParameter() { ParameterName = "@TransType", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlTransactionType.SelectedValue == "All" ? null : ddlTransactionType.SelectedValue },
                new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                );

            if (dsStockTransaction.Tables[0].Rows.Count > 0)
            {
                ReportList.DataSource = dsStockTransaction.Tables[0];
                ReportList.DataBind();
            }

            if (dsStockTransaction.Tables[1].Rows.Count > 0)
            {
                ReportSummary.DataSource = dsStockTransaction.Tables[1];
                ReportSummary.DataBind();
            }

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
            LoadStockTransactionReport();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {

        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_StockTransactionReport",
                   new SqlParameter() { ParameterName = "@StockGroup", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue == "All" ? null : ddlGroup.SelectedValue },
                   new SqlParameter() { ParameterName = "@TransType", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlTransactionType.SelectedValue == "All" ? null : ddlTransactionType.SelectedValue },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                   );


            if (dsStockTransaction.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsStockTransaction.Tables[0];
                dg.DataBind();

                DateTime sdate = dtpfordate.SelectedDate.Value;
                DateTime edate = dtpuntildate.SelectedDate.Value;

                // THE EXCEL FILE.
                string sFileName = "Stock Transaction Report From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
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

                Response.Write("<table><tr><td>Stock Transaction Report </td><td> From:" + sdate.ToString("dd/MM/yyyy") + "</td><td> To:" + edate.ToString("dd/MM/yyyy") + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show("No transaction found for the period from " + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value);
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            LoadStockTransactionReport();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ReportList_Init(object sender, System.EventArgs e)
    {
        GridFilterMenu menu = ReportList.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains"
            || menu.Items[i].Text == "GreaterThanOrEqualTo" || menu.Items[i].Text == "LessThanOrEqualTo")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }

    protected void ReportSummary_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            LoadStockTransactionReport();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void BtnExcelExportSummary_Click(object sender, EventArgs e)
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_StockTransactionReport",
                   new SqlParameter() { ParameterName = "@StockGroup", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue == "All" ? null : ddlGroup.SelectedValue },
                   new SqlParameter() { ParameterName = "@TransType", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlTransactionType.SelectedValue == "All" ? null : ddlTransactionType.SelectedValue },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                   );


            if (dsStockTransaction.Tables[1].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsStockTransaction.Tables[1];
                dg.DataBind();

                DateTime sdate = dtpfordate.SelectedDate.Value;
                DateTime edate = dtpuntildate.SelectedDate.Value;

                // THE EXCEL FILE.
                string sFileName = "Stock Transaction Summary Report From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
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

                Response.Write("<table><tr><td>Stock Transaction Summary Report</td><td> From:" + sdate.ToString("dd/MM/yyyy") + "</td><td> To:" + edate.ToString("dd/MM/yyyy") + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show("No transaction found for the period from " + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}