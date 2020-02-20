using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Telerik.Web.UI;

public partial class MenuItemReport : System.Web.UI.Page
{
    public static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            rgDinBkng.DataSource = string.Empty;
            rgDinBkng.DataBind();
            DateTime now = DateTime.Now;
            dtpmenuforday.SelectedDate = DateTime.Now;
            //LoadGrid();
            LoadSession();
            SixDates();
            rgRMEstimate.DataSource = string.Empty;
            rgRMEstimate.DataBind();
            rgItemEstimate.DataSource = string.Empty;
            rgItemEstimate.DataBind();
        }
    }
    private void LoadData()
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_DiningBooking",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                     new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate },
                     new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = ddlDinersSession.SelectedValue }
                    );
            if (ds.Tables[0].Rows.Count > 0)
            {
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
            }
            else
            {
                rgDinBkng.DataSource = string.Empty;
                rgDinBkng.DataBind();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 27 });


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

    private void LoadSession()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchSE = new DataSet();
            dsFetchSE = sqlobj.ExecuteSP("SP_DinersSessionFilter",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value });
            ddlDinersSession.DataSource = dsFetchSE.Tables[0];
            ddlDinersSession.DataValueField = "SCode";
            ddlDinersSession.DataTextField = "SName";
            ddlDinersSession.DataBind();
            ddlDinersSession.Items.Insert(0, new ListItem("--Select--", "0"));
            dsFetchSE.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        if (rgRMEstimate.Visible == true && rgRMEstimate.Items.Count > 0)
        {
            rgRMEstimate.ExportSettings.ExportOnlyData = true;
            rgRMEstimate.ExportSettings.FileName = "Provisions Estimate on " + dtpmenuforday.SelectedDate.Value.ToString("dd-MMM-yyyy");
            rgRMEstimate.MasterTableView.Caption = "Provisions Estimate on " + dtpmenuforday.SelectedDate.Value.ToString("dd-MMM-yyyy");
            rgRMEstimate.MasterTableView.Font.Name = "verdana";
            rgRMEstimate.ExportSettings.IgnorePaging = true;
            rgRMEstimate.ExportSettings.OpenInNewWindow = true;
            rgRMEstimate.MasterTableView.ExportToExcel();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('No records to export');", true);
        }
    }

    protected void dtpmenuforday_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            rgDinBkng.DataSource = string.Empty;
            rgDinBkng.DataBind();
            rgItemEstimate.DataSource = string.Empty;
            rgItemEstimate.DataBind();
            rgRMEstimate.DataSource = string.Empty;
            rgRMEstimate.DataBind();
            LoadSession();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

    private void SixDates()
    {
        try
        {
            DateTime currentdate = DateTime.Now;

            List<DateTime> listdates = Pastsixdates(currentdate);


            for (int i = 0; i < listdates.Count; i++)
            {
                DateTime dates = Convert.ToDateTime(listdates[i].ToString());
            }
            DateTime cdate = DateTime.Now;

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

    public List<DateTime> Pastsixdates(DateTime currentdate)
    {
        List<DateTime> psixdays = new List<DateTime>();

        int i = 0;
        int k = 6;
        while (i <= 5)
        {
            DateTime dates = currentdate.AddDays(-(k - i));
            psixdays.Add(dates);
            i = i + 1;
        }
        int j = 0;
        DateTime futuredate = DateTime.Now;
        psixdays.Add(futuredate);
        while (j <= 6)
        {
            futuredate = futuredate.AddDays(1);
            psixdays.Add(futuredate);
            j = j + 1;
        }
        return psixdays;
    }

    protected void ImgBtn_Click(object sender, ImageClickEventArgs e)
    {

        try
        {
            ImageButton lkBtn = (ImageButton)sender;
            GridDataItem grditm = (GridDataItem)lkBtn.NamingContainer;
            DateTime dMenudate = Convert.ToDateTime(grditm.Cells[4].Text.ToString());
            string strSessionCode = grditm.Cells[5].Text.ToString();
            string strItemName = grditm.Cells[9].Text.ToString();
            DataSet dsItemEstimate = sqlobj.ExecuteSP("SP_GetItemEstimate",
                new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = dMenudate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = strSessionCode.ToString() },
                new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItemName.ToString() }
               );
            if (dsItemEstimate.Tables[0].Rows.Count > 0)
            {
                rgItemEstimate.DataSource = dsItemEstimate;
                rgItemEstimate.DataBind();
            }
            else
            {
                rgItemEstimate.DataSource = string.Empty;
                rgItemEstimate.DataBind();
            }
            dsItemEstimate.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ImgItemBtn_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ImageButton lkBtn = (ImageButton)sender;
            GridDataItem grditm = (GridDataItem)lkBtn.NamingContainer;
            DateTime dMenudate = Convert.ToDateTime(grditm.Cells[4].Text.ToString());
            string strSessionCode = grditm.Cells[5].Text.ToString();
            string strItemName = grditm.Cells[9].Text.ToString();
            DataSet dsRMEstimate = sqlobj.ExecuteSP("SP_GetRawMaterialEstimate",
               new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate },
               new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = strSessionCode.ToString() },
               new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItemName.ToString() }
               );

            if (dsRMEstimate.Tables[0].Rows.Count > 0)
            {
                rgRMEstimate.DataSource = dsRMEstimate;
                rgRMEstimate.DataBind();
            }
            else
            {
                rgRMEstimate.DataSource = string.Empty;
                rgRMEstimate.DataBind();
            }
            dsRMEstimate.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    //private void LoadGrid()
    //{
    //    DataSet Dssession = sqlobj.ExecuteSP("SP_getsession",
    //            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value });
    //            int scode = Convert.ToInt32(Dssession.Tables[0].Rows[0]["Scode"].ToString());       
    //}
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            LoadData();
            DataSet dsItemEstimate = sqlobj.ExecuteSP("SP_GetItemEstimate",
              new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate },
              new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }
             );
            if (dsItemEstimate.Tables[0].Rows.Count > 0)
            {
                rgItemEstimate.DataSource = dsItemEstimate.Tables[0];
                rgItemEstimate.DataBind();
            }
            else
            {
                rgItemEstimate.DataSource = string.Empty;
                rgItemEstimate.DataBind();
            }
            dsItemEstimate.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }

    }
}