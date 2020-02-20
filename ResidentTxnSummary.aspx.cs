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
public partial class ResidentTxnSummary : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    string SelBillPeriod;

    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
        scriptManager.RegisterPostBackControl(BtnnExcelExport);
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;

        if (Session["SelBillPeriod"] != null)
        {
            SelBillPeriod = Session["SelBillPeriod"].ToString();
            Session["SelBillPeriod"] = string.Empty;
        }
        else
        {
            SelBillPeriod = string.Empty;
        }


        if (!IsPostBack)
        {

            LoadTitle();
            
            string Value = Request.QueryString["RSVal"];
            if (Value == "1")
            {
                btnRetBillRec.Visible = true;
            }
            else if (Value == "2")
            {
                btnRetReport.Visible = true;
            }
        }
        LoadGrid();
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 51 });


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

    protected void LoadGrid()
    {
        try
        {
            int iModeVal;
            string SBP;
            if (lnkShowDet.Text == "Less <<<")
            {
                iModeVal = 1;
            }
            else
            {
                iModeVal = 2;
            }

            if (SelBillPeriod != String.Empty && SelBillPeriod != " " && SelBillPeriod != null)
            {
                SBP = SelBillPeriod;
            }
            else
            {
                SBP = "ALL";
            }

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_FetchResTxnSummary",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = iModeVal },
                new SqlParameter() { ParameterName = "@SBP", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = SBP });
            rdgTxnSummary.DataSource = dsGroup.Tables[0];
            rdgTxnSummary.DataBind();
            dsGroup.Dispose();
            //lblCurrBillPeriod.Text = "(Current - " + dsGroup.Tables[1].Rows[0]["CurrentPeriod"].ToString() + ",";
            //lblBilledPeriod.Text = "Last Billed - " + dsGroup.Tables[2].Rows[0]["BilledPeriod"].ToString() + ")";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void btnExpProject_Click(object sender, EventArgs e)
    {

        if ((rdgTxnSummary.Visible == true) && (rdgTxnSummary.Items.Count > 0))
        {
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;

            dsDT = proc.ExecuteSP("GetServerDateTime");
            string CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");
            string FileName = "Billing History per Resident page_" + CDate;

            rdgTxnSummary.ExportSettings.ExportOnlyData = true;
            rdgTxnSummary.ExportSettings.FileName = FileName;
            rdgTxnSummary.ExportSettings.IgnorePaging = true;
            rdgTxnSummary.ExportSettings.OpenInNewWindow = true;
            rdgTxnSummary.MasterTableView.ExportToExcel();
        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }

    protected void rdgTxnSummary_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridFilteringItem)
        {
            GridFilteringItem filterItem = (GridFilteringItem)e.Item;
            //filterItem["Name"].HorizontalAlign = HorizontalAlign.Left;
            //filterItem["BillPeriod"].HorizontalAlign = HorizontalAlign.Left;
            filterItem["BPAmount"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["LastMonthCO"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["TotOutstand"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["AmtRecd"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["Outstanding"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["RecDate"].HorizontalAlign = HorizontalAlign.Center;

        }
    }

    protected void lnkShowDet_Click(object sender, EventArgs e)
    {
        if (lnkShowDet.Text == "Less <<<")
        {
            lnkShowDet.Text = "More >>>";
        }
        else if (lnkShowDet.Text == "More >>>")
        {
            lnkShowDet.Text = "Less <<<";
        }
        LoadGrid();

    }

    protected void lbtnName_Click(object sender, EventArgs e)
    {
        String CustomerRSN;
        DataSet DS = new DataSet();
        SqlProcsNew proc = new SqlProcsNew();

        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        
        Session["CustRSN"] = row.Cells[3].Text;
        CustomerRSN = Session["CustRSN"].ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "win",
        "<script language='javascript'> var iMyWidth;var iMyHeight;  window.open('ResidentView.aspx?=" + CustomerRSN + "','NewWin','status=no,height=1000,width=1300 ,resizable=No,left=200,top=100,screenX=100,screenY=200,toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,   NewWin.focus()')</script>", false);
 

        //DS = proc.ExecuteSP("SP_ChkResTxnSummary",
        //new SqlParameter() { ParameterName = "@BPRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(BPRSN) });

        //if (DS.Tables[0].Rows.Count > 0)
        //{
        //    Session["SelBillPeriod"] = row.Cells[3].Text;
        //    Response.Redirect("ResidentTxnSummary.aspx");
        //}
        //else
        //{
        //    WebMsgBox.Show("No records found");
        //}
    }

    protected void lbBillPeriod_Click(object sender,EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsGroup = null;
        
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        String BPRSN = row.Cells[3].Text;
        hdnSRTRSN.Value = BPRSN;
       
        dsGroup = sqlobj.ExecuteSP("SP_TransSummaryCM",
            new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(BPRSN) });
        if (dsGroup.Tables[0].Rows.Count > 0)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Function", "NavigateDir();", true);
        }
        else 
        {
            WebMsgBox.Show("No records found for the selected period");
        }
    }

   
    protected void btnRetBillRec_Click(object sender, EventArgs e)
    {
        Response.Redirect("TransactionLevelInd.aspx");
    }
    protected void btnRetReport_Click(object sender, EventArgs e)
    {
        Response.Redirect("DailyFoodBillReport.aspx");
    }

    protected void rdgTxnSummary_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid();
    }
    protected void rdgTxnSummary_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rdgTxnSummary.FilterMenu;
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
}