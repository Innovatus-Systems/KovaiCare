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

public partial class EventSumaryReport : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadTitle();
                LoadReport();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 120 });


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


    public void LoadReport()
    {
        try
        {
            DataSet dsReport = sqlobj.ExecuteSP("SP_EventReport",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = ddlType.SelectedValue } ); 

            if (dsReport.Tables[0].Rows.Count > 0)
            {
                gvEventSummary.DataSource = dsReport.Tables[0];
                gvEventSummary.DataBind();
            }
            else
            {
                gvEventSummary.DataSource = new string[] { };
                gvEventSummary.DataBind();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvEventSummary_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadReport();
    }
    protected void gvEventSummary_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvEventSummary.FilterMenu;
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

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadReport();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}