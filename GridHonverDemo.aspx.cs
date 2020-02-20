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

public partial class GridHonverDemo : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadStandingAloneGrid();
        }

    }

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
    protected void SAloneListView_ItemDataBound(object sender, GridItemEventArgs e)
    {

    }
}