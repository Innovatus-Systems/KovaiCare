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

public partial class MonthlyBilling : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
        scriptManager.RegisterPostBackControl(BtnnExcelExport);
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        if (!IsPostBack)
        {
           // LoadTitle();
      

            
            string Value = Request.QueryString["MBVal"];
            if (Value == "1")
            {
                LoadTitle(31);

                btnRetBillRec.Visible = true;
            }
            else if (Value == "2")
            {
                LoadTitle(50);

                btnRetReport.Visible = true;
            }
           
        }
        LoadGrid();
    }


    private void LoadTitle(int id)
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = id.ToString() });


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
            if (lnkShowDet.Text == "Less <<<")
            {
                iModeVal = 1;
            }
            else
            {
                iModeVal = 2;
            }
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_FetchBillingPeriods",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = iModeVal });
            rdgMonthBill.DataSource = dsGroup.Tables[0];
            rdgMonthBill.DataBind();
            dsGroup.Dispose();

            //lblCurrBillPeriod.Text = "(Current - " + dsGroup.Tables[1].Rows[0]["CurrentPeriod"].ToString() + ",";
            //lblBilledPeriod.Text = "Last Billed - " + dsGroup.Tables[2].Rows[0]["BilledPeriod"].ToString() + ")";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }


    }

    protected void btnGenMonthlyBill_Click(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsMonBill = null;
            dsMonBill = sqlobj.ExecuteSP("SP_InsertInBillingPeriods");
            dsMonBill.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }

    }
    protected void btnExpProject_Click(object sender, EventArgs e)
    {

        if ((rdgMonthBill.Visible == true) && (rdgMonthBill.Items.Count > 0))
        {
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;

            dsDT = proc.ExecuteSP("GetServerDateTime");
            string CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");
            string FileName = "BillingSummary_" + CDate;

            
            rdgMonthBill.ExportSettings.ExportOnlyData = true;
            rdgMonthBill.ExportSettings.FileName = FileName;
            rdgMonthBill.ExportSettings.IgnorePaging = true;
            rdgMonthBill.ExportSettings.OpenInNewWindow = true;
            rdgMonthBill.MasterTableView.ExportToExcel();

        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }

    protected void rdgMonthBill_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridFilteringItem)
        {
            GridFilteringItem filterItem = (GridFilteringItem)e.Item;
            //filterItem["BPName"].HorizontalAlign = HorizontalAlign.Left;
            //filterItem["BPFromDT"].HorizontalAlign = HorizontalAlign.Center;
            //filterItem["BPTill"].HorizontalAlign = HorizontalAlign.Center;
            //filterItem["BPSpecialMsg"].HorizontalAlign = HorizontalAlign.Left;
            filterItem["BStatus"].HorizontalAlign = HorizontalAlign.Left;
            filterItem["BDate"].HorizontalAlign = HorizontalAlign.Center;
            filterItem["NoPeopleBilled"].HorizontalAlign = HorizontalAlign.Center;
            filterItem["AmountCarriedOver"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["BAmount"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["AmountReceived"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["LastDate"].HorizontalAlign = HorizontalAlign.Center;
            filterItem["Balance"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["Outstanding"].HorizontalAlign = HorizontalAlign.Right;

        }
    }

    protected void lnkShowDet_Click(object sender, EventArgs e)
    {
        if (lnkShowDet.Text == "Less <<<")
        {
            lnkShowDet.Text = "More >>>";
            lnkShowDet.ToolTip = "Click to view 'Yet to Open' period also";
        }
        else if (lnkShowDet.Text == "More >>>")
        {
            lnkShowDet.Text = "Less <<<";
            lnkShowDet.ToolTip = "Click to view 'Open','Billed' and 'Closed' periods";
        }       
        LoadGrid();
    
    }

    protected void lnkbtnHelp_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Function", "NavigateDir();", true);
    
    }

    protected void rdgCSEdit_Click(object sender, EventArgs e)
    {



        try
        {

            LinkButton lkBtn = (LinkButton)sender;
            GridDataItem grditm = (GridDataItem)lkBtn.NamingContainer;

            string RSN = grditm.Cells[3].Text.ToString();
            Session["TaskRSN"] = RSN;



            //SqlProcsNew sqlobj = new SqlProcsNew();
            //DataSet dsCSEdit = null;
            //dsCSEdit = sqlobj.ExecuteSP("SP_FetchTaskDet",
            //    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(RSN) });

            ////ddlAssignedBy.SelectedValue = dsCSEdit.Tables[0].Rows[0]["AssignedBy"].ToString();
            //ddlAssignedTo.SelectedValue = dsCSEdit.Tables[0].Rows[0]["AssignedTo"].ToString();
            //txtMobile.Text = dsCSEdit.Tables[0].Rows[0]["Mobile"].ToString();
            //txtEmail.Text = dsCSEdit.Tables[0].Rows[0]["Email"].ToString();
            //txtTask.Text = dsCSEdit.Tables[0].Rows[0]["Task"].ToString();
            //ddlStatus.SelectedValue = dsCSEdit.Tables[0].Rows[0]["Status"].ToString();
            //dtpStatusDt.SelectedDate = Convert.ToDateTime(dsCSEdit.Tables[0].Rows[0]["StatusDt"].ToString());
            //ddlUrgency.SelectedValue = dsCSEdit.Tables[0].Rows[0]["Urgency"].ToString();
            //dtpTargetDt.SelectedDate = Convert.ToDateTime(dsCSEdit.Tables[0].Rows[0]["TargetDate"].ToString());
            //txtStatusRemarks.Text = dsCSEdit.Tables[0].Rows[0]["StatusRemarks"].ToString();

        }
        catch (Exception qr)
        {
            throw qr;
        }
    }

    protected void lbtnName_Click(object sender, EventArgs e)
    {
        DataSet DS = new DataSet();
        SqlProcsNew proc = new SqlProcsNew();

        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;       
        String BPRSN = row.Cells[2].Text;  

        DS = proc.ExecuteSP("SP_ChkResTxnSummary",
        new SqlParameter() { ParameterName = "@BPRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(BPRSN) });

        if (DS.Tables[0].Rows.Count > 0)
        {
            Session["SelBillPeriod"] = row.Cells[3].Text;
            Response.Redirect("ResidentTxnSummary.aspx");
        }
        else
        {
            WebMsgBox.Show("No records found for the selected period");        
        }
    }

    protected void lbtnMessage_Click(object sender, EventArgs e)
    {
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        String BPRSN = row.Cells[2].Text;
        String BPRSN1 = row.Cells[3].Text;
        String BPRSN2 = row.Cells[4].Text;
        String BPRSN3 = row.Cells[5].Text;
        String BPRSN4 = row.Cells[6].Text;
        hdnRSNMsg.Value = BPRSN;
        
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Function", "NavigateDir2();", true);
    }
    protected void btnRetBillRec_Click(object sender, EventArgs e)
    {
        Response.Redirect("TransactionLevelInd.aspx");
    }
    protected void btnRetReport_Click(object sender, EventArgs e)
    {
        Response.Redirect("DailyFoodBillReport.aspx");
    }
    protected void rdgMonthBill_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid();
    }
}