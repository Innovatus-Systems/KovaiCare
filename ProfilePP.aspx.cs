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



public partial class ProfilePP : System.Web.UI.Page
{

    SqlProcsNew sqlobj = new SqlProcsNew();


    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
        scriptManager.RegisterPostBackControl(BtnnExcelExport);
        if (!IsPostBack)
        {
            LoadTitle();
            LoadEEGrid();
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 16 });


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

    protected void LoadEEGrid()
    {
        try
        {
            //int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());

            Int16 IMode;
            if (ddlAttribGroup.SelectedValue.ToString() == "0")
            {
                IMode = 1;
            }
            else
            {
                IMode = 2;
            }

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_AttributeDet",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = IMode },
                new SqlParameter() { ParameterName = "@Group", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAttribGroup.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@RName", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "A" });
            rdgAttribute.DataSource = dsGroup.Tables[0];
            rdgAttribute.DataBind();
            dsGroup.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void ddlAttribGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadEEGrid();
    }

    protected void btnExpProject_Click(object sender, EventArgs e)
    {

        if ((rdgAttribute.Visible == true) && (rdgAttribute.Items.Count > 0))
        {
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;

            dsDT = proc.ExecuteSP("GetServerDateTime");
            string CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");
            string FileName = "Additional_Particulars_" + CDate;

            rdgAttribute.ExportSettings.ExportOnlyData = true;
            rdgAttribute.ExportSettings.FileName = FileName;
            rdgAttribute.ExportSettings.IgnorePaging = true;
            rdgAttribute.ExportSettings.OpenInNewWindow = true;
            rdgAttribute.MasterTableView.ExportToExcel();

        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }
    protected void btnreturnfromlevelJ_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }
    protected void rdgAttribute_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadEEGrid();
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
