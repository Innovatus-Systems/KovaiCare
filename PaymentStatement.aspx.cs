using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using ClsPaymentGatewayDet;

public partial class PaymentStatement : System.Web.UI.Page
{
    static ClsPayDetails payDetails;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                payDetails = new ClsPayDetails();
            }
            catch (Exception ex)
            {
            
            }

            LoadMonth();
            LoadStmt();
        }

    }
    protected void LoadMonth()
    {
        try
        {
            //SqlProcs proc = new SqlProcs();
            ddlmonth.Items.Clear();
            DataSet ds = new DataSet();
            ds = payDetails.GetServerTime();
            //proc.ExecuteSP("GetServerDateTime");
            DateTime now = Convert.ToDateTime(ds.Tables[0].Rows[0][0]);
            for (int i = -11; i <= 0; i++)
            {
                DateTime date = now.AddMonths(i);
                ddlmonth.Items.Add(
                    new System.Web.UI.WebControls.ListItem(date.ToString("MMM yyyy"), date.ToString("yyyy-MM-dd")));
            }
            ddlmonth.DataBind();
            ddlmonth.Items.Insert(0, "Please Select");
            ddlmonth.SelectedIndex = (ddlmonth.Items.Count - 1);
        }
        catch (Exception ex)
        {

        }
    }
    protected void LoadStmt()
    {
        try
        {
            DateTime frmdate, tilldate, tempdate;
            tempdate = Convert.ToDateTime(ddlmonth.SelectedValue);
            frmdate = tempdate.AddDays(1 - tempdate.Day);
            tilldate = frmdate.AddMonths(1);

            //SqlProcs proc = new SqlProcs();
            DataSet ds = new DataSet();
            payDetails.imode = 3;
            payDetails.frmdate = frmdate.ToString("yyyy-MM-dd");
            payDetails.tilldate = tilldate.ToString("yyyy-MM-dd");
            ds = payDetails.GetDataAmtTxn();

          

            rdgTxns.DataSource = ds.Tables[0];
            rdgTxns.DataBind();
            if(ds.Tables[1].Rows.Count>0)
            {
                if (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[1].Rows[0]["OPENBAL"])))
                    LblOldBalance.Text = Math.Round(Convert.ToDouble(ds.Tables[1].Rows[0]["OPENBAL"])).ToString();
                else
                    LblOldBalance.Text = "0";
                LblTotAmt.Text = Math.Round(Convert.ToDouble(ds.Tables[1].Rows[0]["AMOUNT"])).ToString();
                LblServiceTax.Text = Math.Round(Convert.ToDouble(ds.Tables[1].Rows[0]["SERVICETAX"])).ToString();
                LblSBCess.Text = Math.Round(Convert.ToDouble(ds.Tables[1].Rows[0]["SBCESS"])).ToString();
                LblFinalAmt.Text = Math.Round(Convert.ToDouble(ds.Tables[1].Rows[0]["FINALAMOUNT"])).ToString();
                LblDebitAmt.Text = Math.Round(Convert.ToDouble(ds.Tables[1].Rows[0]["DEBITED"])).ToString();
                if (!string.IsNullOrEmpty(Convert.ToString(ds.Tables[1].Rows[0]["CLOSEBAL"])))
                    LblNewBalance.Text = Math.Round(Convert.ToDouble(ds.Tables[1].Rows[0]["CLOSEBAL"])).ToString();
                else
                    LblNewBalance.Text = "0";
            }
            if(ds.Tables[2].Rows.Count>0)
            {
                LblInvoiceTo.Text = ds.Tables[2].Rows[0]["InvoiceTo"].ToString();
                LblBillingAddress.Text = ds.Tables[2].Rows[0]["BillingAddress"].ToString();
            }
            LblBillHead.Text = "Recharge Details - " + Convert.ToDateTime(ddlmonth.Text).ToString("MMM yyyy");
            LblAmountHead.Text = "Amount and Tax Breakup - " + Convert.ToDateTime(ddlmonth.Text).ToString("MMM yyyy");
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

    protected void BtnHome_Click(object sender, EventArgs e)
    {
        if(Session["HomePage"]!=null)
            Response.Redirect(Session["HomePage"].ToString());
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
                rdgTxns.AllowSorting = false;
                rdgTxns.AllowPaging = false;
                rdgTxns.PagerStyle.AlwaysVisible = false;
                rdgTxns.PagerStyle.Mode = GridPagerMode.NextPrev;
                string FileName, FDet;
                //SqlProcs sqlp = new SqlProcs();

                FDet = ddlmonth.SelectedValue;
                FileName = "Recharge Statement - " + ddlmonth.SelectedValue.ToString();
                rdgTxns.ExportSettings.ExportOnlyData = true;
                rdgTxns.ExportSettings.FileName = FileName;
                rdgTxns.ExportSettings.IgnorePaging = true;
                rdgTxns.ExportSettings.OpenInNewWindow = true;
                rdgTxns.AllowPaging = false;
                foreach (GridFilteringItem filter in rdgTxns.MasterTableView.GetItems(GridItemType.FilteringItem))
                {
                    filter.Visible = false;
                }
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
    protected void rdgTxns_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LoadStmt();
    }
    protected void rdgTxns_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadStmt();
    }
    protected void rdgTxns_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadStmt();
    }
    protected void BtnTest2_Click(object sender, EventArgs e)
    {

    }
    protected void ddlmonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlmonth.SelectedIndex > 0)
        {
            LoadStmt();
        }

    }
    protected void rdgTxns_GridExporting(object sender, GridExportingArgs e)
    {
        if (e.ExportType == ExportType.Excel)
        {
            string css = "<style> td {text-align:center}</style>";
            e.ExportOutput = e.ExportOutput.Replace("</head>", css + "</head>");

        }
    }
}