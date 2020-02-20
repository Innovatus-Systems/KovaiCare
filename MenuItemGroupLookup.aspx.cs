using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;

public partial class MenuItemGroupLookup : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadTitle();
                LoadUserGrid();

                btnUpdate.Visible = false;
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 83 });


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
    public void LoadUserGrid()
    {
        try
        {

            DataSet dsUsers = sqlobj.ExecuteSP("SP_LoadGroup");


            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                gvGroup.DataSource = dsUsers;
                gvGroup.DataBind();
            }
            else
            {
                gvGroup.DataSource = string.Empty;
                gvGroup.DataBind();
            }

            dsUsers.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void Clear()
    {
        txtDescription.Text = "";
        txtGroup.Text = "";
        btnUpdate.Visible = false;
        btnSave.Visible = true;
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {


                DataSet dsUsers = sqlobj.ExecuteSP("SP_InsertGroup",
                 new SqlParameter() { ParameterName = "@GroupName", SqlDbType = SqlDbType.NVarChar, Value = txtGroup.Text },
                 new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtDescription.Text }
                 );

                dsUsers.Dispose();

                LoadUserGrid();
                Clear();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Group Name lookup added successfully');", true);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {


                DataSet dsUsers = sqlobj.ExecuteSP("SP_UpdateGroup",
                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["GroupRSN"].ToString() },
                 new SqlParameter() { ParameterName = "@GroupName", SqlDbType = SqlDbType.NVarChar, Value = txtGroup.Text },
                 new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtDescription.Text }
                 );

                dsUsers.Dispose();

                LoadUserGrid();
                Clear();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Group Name lookup updated successfully');", true);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            Clear();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/Dashboard.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvGroup_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "UpdateRow")
            {
                Session["GroupRSN"] = e.CommandArgument.ToString();

                DataSet dsUsers = sqlobj.ExecuteSP("SP_GetGroup",
                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["GroupRSN"].ToString() }

                 );


                if (dsUsers.Tables[0].Rows.Count > 0)
                {
                    txtGroup.Text = dsUsers.Tables[0].Rows[0]["GroupName"].ToString();
                    txtDescription.Text = dsUsers.Tables[0].Rows[0]["Description"].ToString();

                    btnSave.Visible = false;
                    btnUpdate.Visible = true;
                }


                dsUsers.Dispose();

            }
               
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvGroup_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvGroup.FilterMenu;
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
}