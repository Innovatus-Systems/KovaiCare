using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class DinerssummRep : System.Web.UI.Page
{
    public static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            DateTime now = DateTime.Now;
            lblDate.Text = now.ToString("dd-MMM-yyyy HH:mm") + " Hrs.";
            radfromdate.SelectedDate = new DateTime(now.Year, now.Month, 1);
            radtilldate.SelectedDate = DateTime.Today;
            LoadReport();
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 26 });


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

    protected void gvDiners_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadReport();
    }
    public void LoadReport()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_DinersSummReport", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", rbtnlist.SelectedValue);
            cmd.Parameters.AddWithValue("@FromDate", radfromdate.SelectedDate);
            cmd.Parameters.AddWithValue("@Tilldate", radtilldate.SelectedDate);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet dsReport = new DataSet();
            dap.Fill(dsReport, "temp");
            if (dsReport.Tables[0].Rows.Count > 0)
            {
                gvDiners.DataSource = dsReport.Tables[0];                
                gvDiners.DataBind();
            }
            else
            {
                gvDiners.DataSource = new string[] { };
                gvDiners.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Convert.ToDateTime(radfromdate.SelectedDate) > Convert.ToDateTime(radtilldate.SelectedDate))
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Please check from and untill date');", true);
            return;
        }
        LoadReport();
    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        if (gvDiners.Visible == true && gvDiners.Items.Count > 0)
        {
            gvDiners.ExportSettings.ExportOnlyData = true;
            gvDiners.ExportSettings.FileName = "DinersSummaryReport";
            gvDiners.MasterTableView.Caption = "Diners Summary Report";
            gvDiners.MasterTableView.Font.Name = "verdana";
            gvDiners.MasterTableView.Font.Size = 12;
            gvDiners.ExportSettings.IgnorePaging = true;
            gvDiners.ExportSettings.OpenInNewWindow = true;
            gvDiners.MasterTableView.ExportToExcel();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('No records to export');", true);
        }
    }
    protected void rmReports_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
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
        else if (e.Item.Text == "Which day what menu")
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
    int rtotal = 0;
    int rdined = 0;
    int ctotal = 0;
    int cdined = 0;
    int gtotal = 0;
    int gdined = 0;
    int ttotal = 0;
    int tdined = 0;
    int htotal = 0;
    int hdined = 0;
    protected void gvDiners_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {        
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            int fieldValue = int.Parse(dataItem["Regular"].Text);
            rtotal += fieldValue;

            int rValue = int.Parse(dataItem["R_Dined"].Text);
            rdined += rValue;
            
          

            int gvalue = int.Parse(dataItem["Guests"].Text);
            gtotal += gvalue;
            int gdinedval = int.Parse(dataItem["G_Dined"].Text);
            gdined += gdinedval;

            int tValue = int.Parse(dataItem["Total"].Text);
            ttotal += tValue;
            int tdinedval = int.Parse(dataItem["T_Dined"].Text);
            tdined += tdinedval;

            int hvalue = int.Parse(dataItem["Hservice"].Text);
            htotal += hvalue;
            int hdinedval = int.Parse(dataItem["HS_Served"].Text);
            hdined += hdinedval;
        }
        if (e.Item is GridFooterItem)
        {
            GridFooterItem footerItem = e.Item as GridFooterItem;
            footerItem["Session"].Text ="Total ";
            footerItem["Regular"].Text = rtotal.ToString();
            footerItem["R_Dined"].Text = rdined.ToString();
            
            footerItem["Guests"].Text = gtotal.ToString();
            footerItem["G_Dined"].Text = gdined.ToString();
            footerItem["Total"].Text = ttotal.ToString();
            footerItem["T_Dined"].Text = tdined.ToString();
            footerItem["Hservice"].Text = htotal.ToString();
            footerItem["HS_Served"].Text = hdined.ToString();
            rtotal = 0;
            rdined = 0;
            ctotal = 0;
            cdined = 0;
            gtotal = 0;
            gdined = 0;
            ttotal = 0;
            tdined = 0;
            htotal = 0;
            hdined = 0;
        }

    }
    protected void gvDiners_PreRender(object sender, EventArgs e)
    {
        for (int rowIndex = gvDiners.Items.Count - 2; rowIndex >= 0; rowIndex--)
        {
            GridDataItem row = gvDiners.Items[rowIndex];
            GridDataItem previousRow = gvDiners.Items[rowIndex + 1];
            if (row["Date"].Text == previousRow["Date"].Text)
            {
                row["Date"].RowSpan = previousRow["Date"].RowSpan < 2 ? 2 : previousRow["Date"].RowSpan + 1;
                previousRow["Date"].Visible = false;
            }
        }
    }
}