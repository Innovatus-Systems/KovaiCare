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

public partial class SAlone : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    SqlProcsNew sqlobj = new SqlProcsNew();


    protected void Page_Load(object sender, EventArgs e)
    {
        RWHelpmessageSA.VisibleOnPageLoad = true;
        RWHelpmessageSA.Visible = false;
        if(!IsPostBack)
        {
         
           string Value = Request.QueryString["Value"];
           string Value1 = Request.QueryString["Value1"];

           LoadTitle();

            if(Value == "1")
            {
                LoadStandingAloneGrid();
                PnlLevelW.Visible = true;
                //btnreturnfromlevelW.Visible = false;
                //btnreturnfromlevelCare.Visible = true;
                
            }
            else
            {

            }
            if (Value1 == "2")
            {
                LoadStandingAloneGrid();
                PnlLevelW.Visible = true;
               // btnreturnfromlevelCare.Visible = false;
                //btnreturnfromlevelW.Visible = true;

            }
            else
            {

            }
           
        }
        //LoadStandingAloneGrid();
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 12 });


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
   
  
     #region Grid load function
    protected void LoadStandingAloneGrid()
    {

        SqlCommand cmd = new SqlCommand("SP_General", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 12;
        DataSet dsGrid = new DataSet();
        SAloneListView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            SAloneListView.DataSource = dsGrid.Tables[0];
            SAloneListView.DataBind();

            SAloneListView.AllowPaging = true;

        }
        else
        {
            SAloneListView.DataSource = new String[] { };
            SAloneListView.DataBind();
        }
    }
     #endregion
    protected void SAloneListView_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LoadStandingAloneGrid();
    
    }

    protected void SAloneListView_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadStandingAloneGrid();
     
    }
    protected void SAloneListView_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        LoadStandingAloneGrid();
        
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
    protected void btnreturnfromlevelW_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }
    protected void btnreturnfromlevelCare_Click(object sender, EventArgs e)
    {
        //Response.Redirect("ExitEntry.aspx");
        Response.Redirect("CheckINOUT.aspx");
    }
    //protected void lbtnName_Click(object sender, EventArgs e)
    //{
    //    string CustomerRSN;
    //    LinkButton lnkOpenProjBtn = (LinkButton)sender;
    //    GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
    //    Session["CustRSN"] = row.Cells[5].Text;
    //    CustomerRSN = Session["CustRSN"].ToString();
    //    loadEmgDetGrid();
    //    RW1CEGridView.Visible = true;
    //}
    //public void loadEmgDetGrid()
    //{
    //    SqlCommand cmd = new SqlCommand("SP_General", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 20;
    //    cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = Session["CustRSN"].ToString(); 
    //    DataSet dsGrid = new DataSet();
    //    RadEmgGrid.DataBind();

    //    SqlDataAdapter da = new SqlDataAdapter(cmd);

    //    da.Fill(dsGrid);
    //    if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
    //    {

    //        RadEmgGrid.DataSource = dsGrid.Tables[0];
    //        RadEmgGrid.DataBind();

    //        RadEmgGrid.AllowPaging = true;

    //    }
    //    else
    //    {
    //        RadEmgGrid.DataSource = new String[] { };
    //        RadEmgGrid.DataBind();
    //    }

    //}


    //protected void imghelp_Click(object sender, ImageClickEventArgs e)
    //{

    //}
    protected void btnhelptext_Click(object sender, EventArgs e)
    {
        RWHelpmessageSA.Visible = true;
        RWHelpmessageSA.CssClass = "availability";
    }
    protected void SAloneListView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadStandingAloneGrid(); 
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