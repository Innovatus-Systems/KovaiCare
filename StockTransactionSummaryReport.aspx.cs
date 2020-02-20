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

public partial class StockTransactionSummaryReport : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {

        rwItemDetails.VisibleOnPageLoad=true;
        rwItemDetails.Visible=false;

        rwLatestTransaction.VisibleOnPageLoad = true;
        rwLatestTransaction.Visible = false;

        if (!IsPostBack)
        {
            
            LoadTitle();

            LoadProvisionGroup();

            dtpfordate.MaxDate = DateTime.Today;

            dtpfordate.SelectedDate = DateTime.Today;

            LoadStockSummaryReport();

            LoadGroupwiseTotal();
           
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 129 });


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

            ddlGroup.Items.Insert(4, "All");

            dsLoadProvisionType.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadStockSummaryReport()
    {
        try
        {
            DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_StockDailySummary",
                new SqlParameter() { ParameterName = "@Group", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue == "All" ? null : ddlGroup.SelectedValue },
                
                new SqlParameter() { ParameterName = "@Date", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate }
                );

            if (dsStockTransaction.Tables[0].Rows.Count > 0)
            {
                ReportList.DataSource = dsStockTransaction;
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

    private void LoadGroupwiseTotal()
    {
        try
        {
            DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_GroupwiseClosingvalue");

            DataTable dsChartData = new DataTable();
            StringBuilder strScript = new StringBuilder();
            lbltitledate.Text= DateTime.Now.ToString("dd-MMM-yyyy");
           
            dsChartData = dsStockTransaction.Tables[0];

                strScript.Append(@"<script type='text/javascript'>  
                    google.load('visualization', '1', {packages: ['corechart']});</script>  
  
                    <script type='text/javascript'>  
                    function drawVisualization() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['Resident Type',  'Count'],");

                foreach (DataRow row in dsChartData.Rows)
                {
                    strScript.Append("['" + row["StockGroup"] + "'," + row["ClosingValue"] + "],");
                }
                strScript.Remove(strScript.Length - 1, 1);
                strScript.Append("]);");

                strScript.Append("var options = { vAxis: {title: 'Count'}, hAxis: {title: 'Resident Type'},is3D:true,chartArea: {width: 370, height: 400} };");
                strScript.Append(" var chart = new google.visualization.PieChart(document.getElementById('chart_div'));  chart.draw(data, options); } google.setOnLoadCallback(drawVisualization);");
                strScript.Append(" </script>");

                ltrscr.Text = strScript.ToString();


            if (dsStockTransaction.Tables[0].Rows.Count > 0)
            {
                rgGroupwiseTotal.DataSource = dsStockTransaction;
                rgGroupwiseTotal.DataBind();
            }
            else
            {
                rgGroupwiseTotal.DataSource = string.Empty;
                rgGroupwiseTotal.DataBind();
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
            LoadStockSummaryReport();
            LoadGroupwiseTotal();
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

            DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_StockDailySummary",
                new SqlParameter() { ParameterName = "@Group", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue == "All" ? null : ddlGroup.SelectedValue },
                new SqlParameter() { ParameterName = "@Date", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate }
                );


            if (dsStockTransaction.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsStockTransaction.Tables[0];
                dg.DataBind();

                DateTime sdate = dtpfordate.SelectedDate.Value;
              

                // THE EXCEL FILE.
                string sFileName = "Stock summary report as of " + sdate.ToString("dd/MM/yyyy") + ".xls";
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


                DateTime dates = DateTime.Now;

                string times = DateTime.Now.ToString("hh:mm:ss tt");

                Response.Write("<table><tr><td>Stock Summary Report as of " + sdate.ToString("dd/MM/yyyy") + "</td><td> Printed on:" + DateTime.Today.ToString("dd/MM/yyyy") + "-" + times.ToString() + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " stock summary does not exist");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ReportList_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {

            if (e.CommandName == "ViewDetails")
            {
                string strrmcode = e.CommandArgument.ToString();

                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    LinkButton lnkitemcode = (LinkButton)e.Item.FindControl("lnkItemName");


                    DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_CheckReorderLevel",
                  new SqlParameter() { ParameterName = "@RMCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = strrmcode.ToString() }

                  );

                    if (dsStockTransaction.Tables[0].Rows.Count > 0)
                    {
                        lblitemcode.Text = dsStockTransaction.Tables[0].Rows[0]["RMCode"].ToString();
                        lblitemname.Text = dsStockTransaction.Tables[0].Rows[0]["RMName"].ToString();
                        lblGroup.Text = dsStockTransaction.Tables[0].Rows[0]["StockGroup"].ToString();
                        lblCategory.Text = dsStockTransaction.Tables[0].Rows[0]["Category"].ToString();
                        lblreorderlevel.Text = dsStockTransaction.Tables[0].Rows[0]["Reorderlevel"].ToString();
                        lblsupplier.Text = dsStockTransaction.Tables[0].Rows[0]["Supplier"].ToString();
                        lblRemarks.Text = dsStockTransaction.Tables[0].Rows[0]["Remarks"].ToString();
                        //Response.Redirect("TaskList.aspx?Value1=3");
                        string itemcode = lblitemcode.Text;
                        string date = dtpfordate.SelectedDate.Value.ToString("ddMM");
                        //Response.Redirect("VegCheckList.aspx?itemcode=IT121");
                        //Response.Redirect("ResidentView.aspx?=" + CustomerRSN + "&DashboardMsg=" + dashboard);
                        Response.Redirect("VegCheckList.aspx?itemcode=" + itemcode + "&date=" + date + "", false);
                        rwItemDetails.Visible = true;
                    }
                }
            }

            else if (e.CommandName == "Receipt")
            {
                  string strrmcode = e.CommandArgument.ToString();

                  if (e.Item is GridDataItem)
                  {
                      GridDataItem ditem = (GridDataItem)e.Item;

                      LoadLatestTransacation(strrmcode.ToString(), "02");

                  }
            }

            else if (e.CommandName == "Issue")
            {
                string strrmcode = e.CommandArgument.ToString();

                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    LoadLatestTransacation(strrmcode.ToString(), "01");

                }
            }
           
            else if (e.CommandName == "Return")
            {
                string strrmcode = e.CommandArgument.ToString();

                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    LoadLatestTransacation(strrmcode.ToString(), "03");

                }
            }

            else if (e.CommandName == "Adjustmentplus")
            {
                string strrmcode = e.CommandArgument.ToString();

                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    LoadLatestTransacation(strrmcode.ToString(), "04");

                }
            }
            else if (e.CommandName == "Adjustmentminus")
            {
                string strrmcode = e.CommandArgument.ToString();

                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    LoadLatestTransacation(strrmcode.ToString(), "05");

                }
            }
            
            else
            {
                LoadStockSummaryReport();
                LoadGroupwiseTotal();
            }


            
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadLatestTransacation(string rmcode,string transtype)
    {
        try
        {
            DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_GetLatestStockTransactions",
                  new SqlParameter() { ParameterName = "@RMCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = rmcode.ToString() },
                  new SqlParameter() { ParameterName = "@TransactionCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = transtype.ToString() }
                  );

                 if (dsStockTransaction.Tables[0].Rows.Count > 0)
                 {
                     lblLItemCode.Text = dsStockTransaction.Tables[0].Rows[0]["RMCode"].ToString();
                     lblLItemName.Text = dsStockTransaction.Tables[0].Rows[0]["RMName"].ToString();
                     lblLQty.Text = dsStockTransaction.Tables[0].Rows[0]["TotalQty"].ToString();
                     lblLDate.Text = dsStockTransaction.Tables[0].Rows[0]["Date"].ToString();
                     lblLTransactionType.Text = dsStockTransaction.Tables[0].Rows[0]["Type"].ToString();

                     rwLatestTransaction.Visible = true;
                 }

            dsStockTransaction.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    
    protected void ReportList_Init(object sender, EventArgs e)
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
    protected void ReportList_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {
                 GridDataItem dataItem = e.Item as GridDataItem;
                 LinkButton lnkclosingbalance = (LinkButton)e.Item.FindControl("lnkClosingBalanceval");
                 LinkButton lnkrmcode = (LinkButton)e.Item.FindControl("lnkrmcode");
                 LinkButton lnkitemname = (LinkButton)e.Item.FindControl("lnkItemName");
                 decimal ClsoingBal = Convert.ToDecimal(lnkclosingbalance.Text);
                 string itemcode = lnkrmcode.Text;                
                 LinkButton lnkitemopnbalqty = (LinkButton)e.Item.FindControl("lnkOpeningBalance");
                 LinkButton lnkitemclsebalqty = (LinkButton)e.Item.FindControl("lnkClosingBalance");
                 LinkButton valueRS = (LinkButton)e.Item.FindControl("lnkClosingBalanceval");
                 valueRS.ForeColor = System.Drawing.Color.DarkBlue;

                if(chkshowall.Checked==false)
                {
                    if (lnkitemopnbalqty.Text == "0.00" && lnkitemclsebalqty.Text == "0.00" && chkshowall.Checked == false)
                    {
                        e.Item.Display = false;
                    }
                }         

                 SqlProcsNew sqlobj = new SqlProcsNew();

                 DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_CheckReorderLevel",
                     new SqlParameter() { ParameterName = "@RMCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value =  itemcode.ToString()  }
                     
                     );

                if (dsStockTransaction.Tables[0].Rows.Count >0)
                {

                    decimal closingstock = Convert.ToDecimal(dsStockTransaction.Tables[0].Rows[0]["ClosingStock"].ToString());
                    decimal reorderlevel = Convert.ToDecimal(dsStockTransaction.Tables[0].Rows[0]["reorderlevel"].ToString());



                    if (closingstock <= reorderlevel)
                    {
                        //dataItem["ItemName"].ForeColor = System.Drawing.Color.Red;

                        lnkitemname.ForeColor = System.Drawing.Color.Red;
                    }

                }

                dsStockTransaction.Dispose();


                //if (strStatus == "Done")
                //{
                //    dataItem["Status"].ForeColor = System.Drawing.Color.Green;
                //}


            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
protected void btnClose_Click(object sender, System.EventArgs e)
{
    rwItemDetails.Visible=false;
}

protected void btnLClose_Click(object sender, System.EventArgs e)
{
    rwLatestTransaction.Visible = false;
}
//protected void chkshowall_CheckedChanged(object sender, System.EventArgs e)
//{
   
//        Response.Redirect("StockTransactionSummaryReport.aspx");
   
//}

}