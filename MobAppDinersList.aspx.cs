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

public partial class MobAppDinersList : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    public DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            //dtpfordate.SelectedDate = sd;
            dtpfordate.SelectedDate = DateTime.Now;
            dtpuntildate.SelectedDate = DateTime.Now;

            LoadGrid();
        }
    }

    protected void LoadGrid()
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsGrid = new DataSet();

        dsGrid = proc.ExecuteSP("SP_GetMobAppDinersList",
            new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
            new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
            new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate });

        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            ReportList.DataSource = dsGrid.Tables[0];
            ReportList.DataBind();
        }
        else
        {
            ReportList.DataSource = new String[] { };
            ReportList.DataBind();
        }

    }

    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid();
    }

    protected void lnkRemove_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            try
            {
                LinkButton lkBtn = (LinkButton)sender;
                GridDataItem grditm = (GridDataItem)lkBtn.NamingContainer;
                string RSN = grditm.Cells[3].Text.ToString();

                sqlobj.ExecuteSQLNonQuery("SP_GetMobAppDinersList",
                        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = RSN });

                WebMsgBox.Show("Removed successfully.");
                LoadGrid();
                


            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
            }
        }
    }

    protected void BtnShow_Click(object sender, EventArgs e)
    {
        LoadGrid();
    }

    protected void ReportList_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {


        if (e.Item is GridDataItem)
        {
            GridDataItem griditem = e.Item as GridDataItem;

            if (griditem["Posted"].Text.Equals("Yes"))
            {

                LinkButton lnk = (LinkButton)griditem.FindControl("lnkRemove");
                lnk.Enabled = false;
                lnk.Visible = false;
                lnk.ForeColor = System.Drawing.Color.LightGray;
            }

             

        }

    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Confirmation.aspx");
    }
}