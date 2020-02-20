using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Telerik.Web.UI;

public partial class MenuItemPerday : System.Web.UI.Page
{
    public static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    static string strLastEvent;
    SqlProcsNew sqlobj = new SqlProcsNew();

    public static DateTime CurrentDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            LoadTitle();
            CurrentDate = DateTime.Today;
            Session["Date"] = CurrentDate.ToString();
            LoadReport(Convert.ToDateTime(Session["Date"]));
           
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 29 });


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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
       
    }

    private void LoadReport(DateTime currendate)
    {
        DataSet dsItems = new DataSet();
        try
        {
            lblDate.Text = currendate.ToString("dd-MMM-yyyy");
            lblDayName.Text = currendate.ToString("dddd");

            dsItems = sqlobj.ExecuteSP("Proc_GetItems",
                new SqlParameter { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = currendate.ToString() });
            if (dsItems.Tables[0].Rows.Count > 0)
            {
                gvItems.DataSource = dsItems.Tables[0];
                gvItems.DataBind();
            }
            else
            {
                gvItems.DataSource = new string[] { };
                gvItems.DataBind();
            }

            if (dsItems.Tables[1].Rows.Count > 0)
            {
                gvEvents.DataSource = dsItems.Tables[1];
                gvEvents.DataBind();
            }
            else
            {
                gvEvents.DataSource = new string[] { };
                gvEvents.DataBind();
            }

            dsItems.Dispose();


        }
        catch (Exception ex)
        {

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
    protected void gvItems_PreRender(object sender, EventArgs e)
    {
        for (int rowIndex = gvItems.Items.Count - 2; rowIndex >= 0; rowIndex--)
        {
            GridDataItem row = gvItems.Items[rowIndex];
            GridDataItem previousRow = gvItems.Items[rowIndex + 1];
            Label lnkstest = (Label)row.FindControl("lnkdoorno");
            Label plnkstest = (Label)previousRow.FindControl("lnkdoorno");
            if (lnkstest.Text == plnkstest.Text)
            {
                plnkstest.Visible = false;
            }
            else
            {
                plnkstest.Visible = true;
            }          
        }
    } 
    protected void gvItems_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {       
        btnSubmit_Click(sender, null);        
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        try
        {
            CurrentDate = Convert.ToDateTime(Session["Date"]);

            Session["Date"] = CurrentDate.AddDays(1);


            LoadReport(Convert.ToDateTime(Session["Date"]));
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        try
        {
            CurrentDate = Convert.ToDateTime(Session["Date"]);

            Session["Date"] = CurrentDate.AddDays(-1);

            LoadReport(Convert.ToDateTime(Session["Date"]));
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnEstimate_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("MenuItemReport.aspx");
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvItems_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvItems.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains")
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