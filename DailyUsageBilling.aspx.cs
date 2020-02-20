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

public partial class DailyUsageBilling : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {

                LoadTitle();

                ReportList.DataSource = string.Empty;
                ReportList.DataBind();

                DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);


                dtpfordate.SelectedDate = sd;
                dtpuntildate.SelectedDate = DateTime.Now;
            }

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 72 });


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

    private void LoadUsageBilling()
    {
        try
        {

            DataSet dsStatement = sqlobj.ExecuteSP("SP_DailyUsageBilling ",

                 new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                 new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                 );

            if (dsStatement.Tables[0].Rows.Count >0)
            {
                ReportList.DataSource = dsStatement;
                ReportList.DataBind();
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
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
            LoadUsageBilling();

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


            DataSet dsStatement = sqlobj.ExecuteSP("SP_DailyUsageBilling",

                  new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                  new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                  );


            if (dsStatement.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsStatement.Tables[0];
                dg.DataBind();

                DateTime sdate = dtpfordate.SelectedDate.Value;
                DateTime edate = dtpuntildate.SelectedDate.Value;

                // THE EXCEL FILE.
                string sFileName = "Daily Usage Billing From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
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


                Response.Write("<table><tr><td>Daily Usage Billing</td><td> From:" + sdate.ToString("dd/MM/yyyy") + "</td><td> To:" + edate.ToString("dd/MM/yyyy") + "</td><td>" + lbltotoutstanding.Text + " " + lbltotdebitcredit.Text + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value + " daily usage billing does not exist");
            }
        }
        catch(Exception ex)
        {
            //WebMsgBox.Show(ex.Message);
        }
    }
    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            LoadUsageBilling();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}