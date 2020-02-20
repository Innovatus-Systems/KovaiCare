using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;
using ClsPaymentGatewayDet;

public partial class PaymentHistory : System.Web.UI.Page
{
    static ClsPayDetails payDetails;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {

            try
            {
                payDetails = new ClsPayDetails();
            }
            catch (Exception ex)
            {

            }

            DateTime dt = DateTime.Now;
            TxtFrmDate.Text = dt.AddDays(-(DateTime.Now.Day - 1)).ToString("dd-MMM-yyy ddd");
            TxtToDate.Text = dt.ToString("dd-MMM-yyy ddd");
            LoadHistoryDet();
        }
    }

    protected void BtnHome_Click(object sender, EventArgs e)
    {
        if (Session["HomePage"] != null)
            Response.Redirect(Session["HomePage"].ToString());
    }


    protected void BtnView1_Click(object sender, EventArgs e)
    {
        LoadHistoryDet();
    }
    protected void rdgTxns_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LoadHistoryDet();
    }
    protected void rdgTxns_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadHistoryDet();
    }
    protected void rdgTxns_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadHistoryDet();
    }
    protected void BtnTest2_Click(object sender, EventArgs e)
    {

    }
    protected void LoadHistoryDet()
    {
        try
        {
            //SqlProcs proc = new SqlProcs();
            DataSet ds = new DataSet();
            payDetails.imode = 2;
            payDetails.frmdate = Convert.ToDateTime(TxtFrmDate.Text).ToString("yyyy-MM-dd");
            payDetails.tilldate = Convert.ToDateTime(TxtToDate.Text).AddDays(1).ToString("yyyy-MM-dd");
            ds = payDetails.GetDataAmtTxn();

            /*ds = proc.ExecuteSP("SP_AMTTXNS",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtFrmDate.Text) },
                new SqlParameter() { ParameterName = "@TillDate", SqlDbType = SqlDbType.Date, Value = Convert.ToDateTime(TxtToDate.Text).AddDays(1) }
                );*/
            rdgTxns.DataSource = ds.Tables[0];
            rdgTxns.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void BtnPayDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("PayDetails.aspx");
    }
    protected void BtnHistory_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaymentHistory.aspx");
    }
    protected void BtnStatement_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaymentStatement.aspx");
    }
    protected void BtnPrint_Click(object sender, ImageClickEventArgs e)
    {

        try
        {
            if ((rdgTxns.Visible == true) && (rdgTxns.Items.Count > 0))
            {
                rdgTxns.AllowPaging = true;
                rdgTxns.PagerStyle.Mode = GridPagerMode.NextPrev;
                rdgTxns.PagerStyle.AlwaysVisible = false;
                string FileName, FDet;

                //rdgTxns.ExportSettings.ExportOnlyData = true;
                //rdgTxns.ExportSettings.IgnorePaging = true;


                //Excel Format
                //
                //SqlProcs sqlp = new SqlProcs();
                FDet = " From-" + TxtFrmDate.Text + " To-" + TxtToDate.Text;
                FileName = "Recharge History - " + FDet;

                //rdgTxns.PageSize = rdgTxns.MasterTableView.VirtualItemCount;
                //rdgTxns.ExportSettings.HideStructureColumns = true;
                //rdgTxns.ExportSettings.SuppressColumnDataFormatStrings = true;
                rdgTxns.ExportSettings.ExportOnlyData = true;
                rdgTxns.ExportSettings.FileName = FileName;
                rdgTxns.ExportSettings.IgnorePaging = true;
                rdgTxns.ExportSettings.OpenInNewWindow = true;
                rdgTxns.MasterTableView.AllowPaging = false;
                //rdgTxns.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML;
                foreach (GridFilteringItem filter in rdgTxns.MasterTableView.GetItems(GridItemType.FilteringItem))
                {
                    filter.Visible = false;
                }
                //rdgTxns.MasterTableView.Rebind();
                rdgTxns.MasterTableView.ExportToExcel();
                WebMsgBox.Show("Export to Excel completed.");
                return;
            }
            else
            {
                WebMsgBox.Show("There are no information to Export");
                return;
            }
        }
        catch (Exception ex)
        {

        }

    }
}