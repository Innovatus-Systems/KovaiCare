using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using Telerik.Web.UI;

public partial class AlacarteBookingList : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadTitle();
                
                DateTime now = DateTime.Now;
                radfromdate.SelectedDate = new DateTime(now.Year, now.Month, 1);
               
                radtilldate.SelectedDate = DateTime.Today;
                LoadSession();
                LoadDefault();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 52 });


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

            DataSet dsFetchSE = sqlobj.ExecuteSP("SP_FetchDropDown",
                     new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 });
            ddlSession.DataSource = dsFetchSE.Tables[0];
            ddlSession.DataValueField = "SCode";
            ddlSession.DataTextField = "SName";
            ddlSession.DataBind();

            ddlSession.Items.Insert(0, "All");
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadDefault()
    {
        try
        {

            DataSet dsResident = sqlobj.ExecuteSP("SP_AlacarteBookingList",
                new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = radfromdate.SelectedDate },
                new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = radtilldate.SelectedDate },
                new SqlParameter() { ParameterName = "@SessionCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue == "All" ? null : ddlSession.SelectedValue }
                );

            gvBookingameal.DataSource = dsResident;
            gvBookingameal.DataBind();

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        if (gvBookingameal.Visible == true && gvBookingameal.Items.Count > 0)
        {
            gvBookingameal.MasterTableView.Caption = "A la carte Booking List";
            gvBookingameal.ExportSettings.ExportOnlyData = true;
            gvBookingameal.ExportSettings.FileName = "A la carte Booking List_" + DateTime.Now.ToString("dd/MM/yyyy");
            gvBookingameal.MasterTableView.Font.Name = "verdana";
            gvBookingameal.ExportSettings.IgnorePaging = true;
            gvBookingameal.ExportSettings.OpenInNewWindow = true;
            gvBookingameal.MasterTableView.ExportToExcel();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('No records to export');", true);
        }
    }
    protected void gvBookingameal_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            LoadDefault();
        }
        catch(Exception ex)
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
        else if (e.Item.Text == "Which Menu which day")
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
        else if (e.Item.Text == "A la Carte Booking List")
        {
            Response.Redirect("AlacarteBookingList.aspx");
        }
        else if (e.Item.Text == "A la Carte Booking Summary")
        {
            Response.Redirect("AlacarteBookingSummary.aspx");
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            LoadDefault();

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvBookingameal_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvBookingameal.FilterMenu;
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