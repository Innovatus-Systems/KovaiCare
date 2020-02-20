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

public partial class OwnersAway : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        rwSpecialReport.VisibleOnPageLoad = true;
        rwSpecialReport.Visible = false;


        if(!IsPostBack)
        {
            LoadTitle();
            LoadOwnerAwayGrid();
            PnlLevelOA.Visible = true;
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 13 });


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
    protected void btnreturnfromlevelOA_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
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
    #region Grid load function for LevelV(OwnerAway)
    protected void LoadOwnerAwayGrid()
    {

        SqlCommand cmd = new SqlCommand("SP_General", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 11;
        DataSet OAGrid = new DataSet();
        OwnerAwayGridView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(OAGrid);
        if (OAGrid != null && OAGrid.Tables.Count > 0 && OAGrid.Tables[0].Rows.Count > 0)
        {

            OwnerAwayGridView.DataSource = OAGrid.Tables[0];
            OwnerAwayGridView.DataBind();

            OwnerAwayGridView.AllowPaging = true;

        }
        else
        {
            OwnerAwayGridView.DataSource = new String[] { };
            OwnerAwayGridView.DataBind();
        }
    }

    #endregion
    protected void lbtnName_Click(object sender, EventArgs e)
    {
        
        
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();

        DataSet dsSpecialReport = sqlobj.ExecuteSP("SP_ResidentSpecialReport",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = CustomerRSN.ToString() });
        
        if (dsSpecialReport.Tables[0].Rows.Count>0)
        {
            rgSpecialReport.DataSource=dsSpecialReport;
            rgSpecialReport.DataBind();

            rwSpecialReport.Visible = true;
        }
        else
        {
            rgSpecialReport.DataSource = string.Empty;
            rwSpecialReport.DataBind();


            rwSpecialReport.Visible = false;
        }

        dsSpecialReport.Dispose();




        //Response.Redirect("TransactionLevel.aspx");
    }
    protected void OwnerAwayGridView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

    }
    protected void OwnerAwayGridView_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                if ( item["SDescription"].Text.Equals("Owner Resident Dependent") || item["SDescription"].Text.Equals("Owner Away Dependent") 
                   )
                {

                    LinkButton lnk = (LinkButton)item.FindControl("lbtnName");
                    lnk.Enabled = false;
                    lnk.ForeColor = System.Drawing.Color.Gray;
                }
                else
                {

                }
            }
            catch (GridException ex) { }

        }
    }
    protected void OwnerAwayGridView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadOwnerAwayGrid();
    }
    protected void OwnerAwayGridView_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadOwnerAwayGrid();
    }
    protected void OwnerAwayGridView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadOwnerAwayGrid();
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