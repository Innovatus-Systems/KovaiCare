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
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.IO;

public partial class PreviousTenants : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            LoadTitle();
            LoadGridLevelT();
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 15 });


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
    protected void btnreturnfromlevelT_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }
    #region Grid load function for Level T
    protected void LoadGridLevelT()
    {

        SqlCommand cmd = new SqlCommand("SP_General", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 6;
        DataSet dsGrid = new DataSet();
        PTListView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            PTListView.DataSource = dsGrid.Tables[0];
            PTListView.DataBind();

            PTListView.AllowPaging = true;

        }
        else
        {
            PTListView.DataSource = new String[] { };
            PTListView.DataBind();
        }





    }

    #endregion
    protected void PTListView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGridLevelT();
    }
    protected void PTListView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

    }
    protected void PTListView_ItemDataBound(object sender, GridItemEventArgs e)
    {

    }
    protected void PTListView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {

    }
    protected void PTListView_SortCommand(object sender, GridSortCommandEventArgs e)
    {

    }
    protected void Lnkbtnview_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["CustRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["CustRSN"].ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "win",
     "<script language='javascript'> var iMyWidth;var iMyHeight;  window.open('ResidentView.aspx?=" + CustomerRSN + "','NewWin','status=no,height=1000,width=1300 ,resizable=No,left=200,top=100,screenX=100,screenY=200,toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,   NewWin.focus()')</script>", false);
    }
    protected void Lnkbtnedit_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();
        Response.Redirect("ResEditt.aspx");
    }
    protected void LnkbtnAddOn_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();
        Response.Redirect("AttributesAdd.aspx");
    }
    protected void lbtnName_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();
        Response.Redirect("TransactionLevel.aspx");
    }

    protected void RMResident_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Information Board")
        {
            Response.Redirect("Information_Board.aspx");
        }
        if (e.Item.Text == "Vacant")
        {
            Response.Redirect("Vacants.aspx");
        }
        if (e.Item.Text == "Staff & Others")
        {
            Response.Redirect("StaffandOthers.aspx");
        }
        if (e.Item.Text == "Owners Away")
        {
            Response.Redirect("OwnersAway.aspx");
        }
        if (e.Item.Text == "Previous Tenants")
        {
            Response.Redirect("PreviousTenants.aspx");
        }
        if (e.Item.Text == "Living Alone")
        {
            Response.Redirect("SAlone.aspx?Value1=" + 2);
        }
        if (e.Item.Text == "Profile ++")
        {
            Response.Redirect("ProfilePP.aspx");
        }
        if (e.Item.Text == "Residents")
        {
            Response.Redirect("ResidentAdd.aspx");
        }

    }
}