using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using Telerik.Web.UI;

public partial class FinancialTransactionSummary : System.Web.UI.Page
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

                lbltotdebitcredit.Text = "";

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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 48 });


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

    protected void LoadGrid1()
    {

        try
        {

            DataSet dsStatement = sqlobj.ExecuteSP("SP_GetFinancialTransactionSummary ",

                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                   );

            if (dsStatement.Tables[0].Rows.Count > 0)
            {
                ReportList.DataSource = dsStatement;
                ReportList.DataBind();
            }

            dsStatement.Dispose();


            DataSet dsdatewise = sqlobj.ExecuteSP("[SP_GetDatewiseDebitCreditTotal]",
                 new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                  new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                );

            if (dsdatewise.Tables[0].Rows.Count > 0)
            {
                decimal totdebit = Convert.ToDecimal(dsdatewise.Tables[0].Rows[0]["TotalDebit"].ToString());
                decimal totcredit = Convert.ToDecimal(dsdatewise.Tables[0].Rows[0]["TotalCredit"].ToString());

                lbltotdebitcredit.Text = "Total Debit:" + totdebit.ToString("0.00") + "  Total Credit:" + totcredit.ToString("0.00");
            }

            dsdatewise.Dispose();


            DataSet dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetFTDebitCreditTotal]");

            if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
            {
                decimal totdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["TotalDebit"].ToString());
                decimal totcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["TotalCredit"].ToString());

                lbltotoutstanding.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm") + " Total Current Outstanding as of now :" + (totdebit - totcredit).ToString("0.00");
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


        DataSet dsStatement = sqlobj.ExecuteSP("SP_GetFinancialTransactionSummary",

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
            string sFileName = "Financial Transaction summary From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
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


            Response.Write("<table><tr><td>Financial Transaction summary</td><td> From:" + sdate.ToString("dd/MM/yyyy") + "</td><td> To:" + edate.ToString("dd/MM/yyyy") + "</td><td>" + lbltotoutstanding.Text + " " + lbltotdebitcredit.Text + "</td></tr></table>");


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
}