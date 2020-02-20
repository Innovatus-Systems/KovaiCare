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

public partial class Default2 : System.Web.UI.Page
{
    public static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);


    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if(!IsPostBack)
        {
            LoadTitle();

            DateTime now = DateTime.Now;
            radfromdate.SelectedDate = new DateTime(now.Year, now.Month, 1);
            //radfromdate.SelectedDate = DateTime.Today;
            radtilldate.SelectedDate = DateTime.Today;
            LoadProvisionGroup();
            LoadRMCode();
            LoadReport();

        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 28 });


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


            if (dsLoadProvisionType.Tables[0].Rows.Count > 0)
            {

                ddlGroup.DataSource = dsLoadProvisionType;
                ddlGroup.DataTextField = "PCode";
                ddlGroup.DataValueField = "PCode";
                ddlGroup.DataBind();

            }

            ddlGroup.Items.Insert(0, "All");

            dsLoadProvisionType.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    public void LoadRMCode()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Load_RMCode", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet dsUsers = new DataSet();
            dap.Fill(dsUsers, "temp");
            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                ddlName.DataSource = dsUsers.Tables[0];
                ddlName.DataTextField = "RMName";
                ddlName.DataValueField = "RMCode";
                ddlName.DataBind();
            }
            ddlName.Items.Insert(0, "All");
        }
        catch (Exception ex)
        {
        }
    }
    protected void gvIngredients_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadReport();
    }
    public void LoadReport()
    {
        try
        {
            DataSet dsReport = sqlobj.ExecuteSP("IngredientsReport",
                 new SqlParameter() { ParameterName = "@RMCode", SqlDbType = SqlDbType.NVarChar, Value = ddlName.SelectedValue.ToString() == "All" ? null : ddlName.SelectedValue },
                 new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue.ToString() == "All" ? null : ddlGroup.SelectedValue },
               new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = radfromdate.SelectedDate },
               new SqlParameter() { ParameterName = "@Tilldate", SqlDbType = SqlDbType.DateTime, Value = radtilldate.SelectedDate }
               ); ;
            
            if (dsReport.Tables[0].Rows.Count > 0)
            {
                gvIngredients.DataSource = dsReport.Tables[0];
                gvIngredients.DataBind();
            }
            else
            {
                gvIngredients.DataSource = new string[] { };
                gvIngredients.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        if (gvIngredients.Visible == true && gvIngredients.Items.Count > 0)
        {

            DataSet dsIngredientReport = sqlobj.ExecuteSP("IngredientsReport",
                new SqlParameter() { ParameterName = "@RMCode", SqlDbType = SqlDbType.NVarChar, Value = ddlName.SelectedValue.ToString() == "All" ? null : ddlName.SelectedValue },
                new SqlParameter() { ParameterName = "@Group", SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue.ToString() == "All" ? null : ddlGroup.SelectedValue },
              new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value =  radfromdate.SelectedDate},
              new SqlParameter() { ParameterName = "@Tilldate", SqlDbType = SqlDbType.DateTime, Value =  radtilldate.SelectedDate}
              );

            if (dsIngredientReport.Tables[0].Rows.Count > 0)
            {
                DataTable dt = dsIngredientReport.Tables[0];

                DateTime fdate = Convert.ToDateTime(radfromdate.SelectedDate);
                DateTime tdate = Convert.ToDateTime(radtilldate.SelectedDate);


                string filename = "Ingredients Report on_ " + DateTime.Today.ToString("dd-MM-yyyy") + ".xls";
                System.IO.StringWriter tw = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
                //hw.Write("<table style='width:100%'><tr><td colspan='10'>PSVR1- Working Sheet for physical stock verification</td></tr>");
                //hw.Write("<tr><td colspan='10'>Use this as a working sheet to post stock transactions.</td></tr>");
                hw.Write("<table style='width:100%'><tr><td colspan='10'>Ingredient Report From " + fdate.ToString("dd-MM-yyyy") + " To " + tdate.ToString("dd-MM-yyyy") + "&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;Printed On:" + DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") + "</td></tr></table>");

                DataGrid dgGrid = new DataGrid();
                dgGrid.DataSource = dt;
                dgGrid.DataBind();
                dgGrid.RenderControl(hw);

                Response.ContentType = "application/vnd.ms-excel";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
                Response.Write(tw.ToString());
                Response.End();

            }

            dsIngredientReport.Dispose();

            //gvIngredients.ExportSettings.ExportOnlyData = true;
            //gvIngredients.ExportSettings.FileName = "IngredientsReport";
            //gvIngredients.MasterTableView.Caption = "Ingredients Report";
            //gvIngredients.MasterTableView.Font.Name = "verdana";
            //gvIngredients.ExportSettings.IgnorePaging = true;
            //gvIngredients.ExportSettings.OpenInNewWindow = true;
            //gvIngredients.MasterTableView.ExportToExcel();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('No records to export');", true);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Convert.ToDateTime(radfromdate.SelectedDate) > Convert.ToDateTime(radtilldate.SelectedDate))
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Please check from and till date');", true);
            return;
        }
        LoadReport();
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
    }
    protected void gvIngredients_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvIngredients.FilterMenu;
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