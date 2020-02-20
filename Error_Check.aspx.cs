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
using System.IO;

public partial class Error_Check : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
if(!IsPostBack)
{
    LoadErrorCheckGrid();
}
    }
    protected void ErrorCheckView_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LoadErrorCheckGrid();
    }
    protected void ErrorCheckView_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        
    }
    protected void ErrorCheckView_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadErrorCheckGrid();
    }
    protected void ErrorCheckView_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        LoadErrorCheckGrid();
    }
    protected void LoadErrorCheckGrid()
    {

          try
             {

                 SqlCommand cmd = new SqlCommand("SP_Error_Check", con);
                 cmd.CommandType = CommandType.StoredProcedure;
                 cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;               
                 DataSet dsGrid = new DataSet();
                 ErrorCheckView.DataBind();

                 SqlDataAdapter da = new SqlDataAdapter(cmd);

                 da.Fill(dsGrid);
                 if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                 {

                     ErrorCheckView.DataSource = dsGrid.Tables[0];
                     ErrorCheckView.DataBind();

                   

                 }
                 else
                 {
                     ErrorCheckView.DataSource = new String[] { };
                     ErrorCheckView.DataBind();
                 }
             }
             catch
             {


             }
    }
}