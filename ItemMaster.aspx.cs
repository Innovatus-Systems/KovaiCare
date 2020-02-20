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

public partial class ItemMaster : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUOM();
            LoadCategory();
        }
        LoadGrid();
    }

    protected void LoadUOM()
    {
        try
        {
            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Code");
            dt.Columns.Add("Text");
            DataRow drow = dt.NewRow();

            drow["Code"] = "Nos";
            drow["Text"] = "Nos";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Grms";
            drow["Text"] = "Grms";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Ml";
            drow["Text"] = "Ml";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "None";
            drow["Text"] = "None";
            dt.Rows.Add(drow);


            ddlUOM.DataSource = dt;
            ddlUOM.DataTextField = dt.Columns["Text"].ToString();
            ddlUOM.DataValueField = dt.Columns["Code"].ToString();
            ddlUOM.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadCategory()
    {
        try
        {
            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Code");
            dt.Columns.Add("Text");
            DataRow drow = dt.NewRow();

            drow["Code"] = "Normal";
            drow["Text"] = "Normal";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Diabetic";
            drow["Text"] = "Diabetic";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Special";
            drow["Text"] = "Special";
            dt.Rows.Add(drow);


            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = dt.Columns["Text"].ToString();
            ddlCategory.DataValueField = dt.Columns["Code"].ToString();
            ddlCategory.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadGrid()
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsMenu = null;
            dsMenu = sqlobj.ExecuteSP("SP_FetchItem",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });
            rdgItemList.DataSource = dsMenu.Tables[0];
            rdgItemList.DataBind();
            dsMenu.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void btnSaveItem_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            try
            {       

                sqlobj.ExecuteSP("SP_InsertItem",
                    new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = ItemCode.Text.ToString() },
                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = ItemName.Text.ToString() },
                    new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = ddlUOM.SelectedValue.ToString() },                    
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.Text.ToString() },                   
                    new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });


                WebMsgBox.Show("New item added");
                LoadGrid();
                Clear();

            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());
            }
        }
    }
    protected void btnreturnfromlevelISettings_Click(object sender, EventArgs e)
    {
        Response.Redirect("Admin.aspx");
    }

    private void Clear()
    {
        ItemCode.Text = "";
        ItemName.Text = "";
        ddlUOM.SelectedIndex = 0;
        ddlCategory.SelectedIndex = 0;
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
    }
}