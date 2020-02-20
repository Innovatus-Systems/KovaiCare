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

public partial class Residentdtls : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadGrid();
        }
    }


    protected void LoadGrid()
    {

        SqlCommand cmd = new SqlCommand("SP_DispView", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        DataSet dsGrid = new DataSet();
        rdgResidentview.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            rdgResidentview.DataSource = dsGrid.Tables[0];
            rdgResidentview.DataBind();

            rdgResidentview.AllowPaging = true;

        }
        else
        {
            rdgResidentview.DataSource = new String[] { };
            rdgResidentview.DataBind();
        }


        


    }
    protected void lbtnName_Click(object sender, EventArgs e)
    {

        //string CustID;
        //LinkButton lnkOpenProjBtn = (LinkButton)sender;
        //GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        //Session["CustomerRSN"] = row.Cells[0].Text;
        //CustID = Session["CustomerRSN"].ToString();

        ////Response.Redirect("CustomerLSView.aspx?CustID=" + CustomerRSN);
        //Response.Redirect(".aspx?CustID=" + CustID);

        ////Response.Redirect("");

    }







    //protected void LoadGrid()
    //{
    //    SqlCommand cmd = new SqlCommand("SP_DispView", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
    //    DataSet dsGrid = new DataSet();
    //    rdgResidentview.DataBind();

    //    SqlDataAdapter da = new SqlDataAdapter(cmd);

    //    da.Fill(dsGrid);
    //    if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
    //    {
    //        rdgResidentview.DataSource = dsGrid.Tables[0];
    //        rdgResidentview.DataBind();

    //        rdgResidentview.AllowPaging = true;
    //    }
    //    else
    //    {
    //        rdgResidentview.DataSource = new String[] { };
    //        rdgResidentview.DataBind();
    //    }
    //}

    protected void rdgListView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadGrid();
    }
    protected void rdgListView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadGrid();
    }
    protected void rdgListView_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadGrid();
    }
}