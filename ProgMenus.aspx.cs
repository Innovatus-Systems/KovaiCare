using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;

public partial class ProgMenus : System.Web.UI.Page
{

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {
                LoadTitle();
                LoadGroup();
                LoadDepartment();
                LoadMenus();

                lblcGroup.Visible = false;
                ddlGroup.Visible = false;

                lblctGroup.Visible = false;
                txtGroup.Visible = false;

                lblcTitle.Visible = false;
                txtTitle.Visible = false;

                btnSave.Visible = true;
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 73 });


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

    private void LoadGroup()
    {
        try
        {
            DataSet dsmenus = sqlobj.ExecuteSP("SP_ProgMenus",
                  new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 4 });

            if (dsmenus.Tables[0].Rows.Count > 0)
            {
                ddlGroup.DataSource = dsmenus;
                ddlGroup.DataTextField = "Title";
                ddlGroup.DataValueField = "MenuId";
                ddlGroup.DataBind();
            }

            ddlGroup.Items.Insert(0, "--Select--");

            dsmenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadDepartment()
    {
        try
        {
            DataSet dsDept = sqlobj.ExecuteSP("SP_LoadDeptForMenus");

            ddlDepartment.Items.Clear();

            if (dsDept.Tables[0].Rows.Count > 0)
            {

                ddlDepartment.DataSource = dsDept.Tables[0];
                ddlDepartment.DataTextField = "DeptName";
                ddlDepartment.DataValueField = "Code";
                ddlDepartment.DataBind();
            }

            ddlDepartment.Items.Insert(0, "--Select--");

            dsDept.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadMenus()
    {
        try
        {
          DataSet dsmenus =   sqlobj.ExecuteSP("SP_ProgMenus",
                new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 1 });

            if(dsmenus.Tables[0].Rows.Count>0)
            {
                gvMenu.DataSource = dsmenus;
                gvMenu.DataBind();
            }
            else
            {
                gvMenu.DataSource = string.Empty;
                gvMenu.DataBind();
            }

            dsmenus.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 5 },
                    new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue == "0" ? txtGroup.Text : txtTitle.Text },
                    new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                    new SqlParameter() { ParameterName = "@Department", SqlDbType = SqlDbType.NVarChar, Value = txtDepartment.Text },
                    new SqlParameter() { ParameterName = "@GroupID", SqlDbType = SqlDbType.BigInt, Value = ddlType.SelectedValue == "0" ? "0" : ddlGroup.SelectedValue },
                    new SqlParameter() { ParameterName = "@IsVisible", SqlDbType = SqlDbType.BigInt, Value = ddlVisibility.SelectedValue }
                    );

                btnClear_Click(null, null);

                LoadGroup();

                WebMsgBox.Show("New menu added successfully.");

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

              

                sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 2 },
                    new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue == "0" ? txtGroup.Text : txtTitle.Text },
                    new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                    new SqlParameter() { ParameterName = "@Department", SqlDbType = SqlDbType.NVarChar, Value = txtDepartment.Text },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.BigInt, Value = Session["MenuID"].ToString() },
                     new SqlParameter() { ParameterName = "@GroupID", SqlDbType = SqlDbType.BigInt, Value = ddlType.SelectedValue == "0" ? "0" : ddlGroup.SelectedValue },
                    new SqlParameter() { ParameterName = "@IsVisible", SqlDbType = SqlDbType.BigInt, Value = ddlVisibility.SelectedValue }
                    );
                
                 btnClear_Click(null, null);

                 LoadGroup();

                WebMsgBox.Show("Menu details updated successfully.");
               
                }
               



          
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            txtdesc.Text = "";
            txtTitle.Text = "";
            txtDepartment.Text = "";
            ddlDepartment.SelectedIndex = 0;

            btnSave.Visible = true;
            btnUpdate.Visible = false;

            ddlGroup.SelectedIndex = 0;

            ddlVisibility.SelectedIndex = 0;

            lblcGroup.Visible = false;
            ddlGroup.Visible = false;

            lblctGroup.Visible = false;
            txtGroup.Visible = false;

            lblcTitle.Visible = false;
            txtTitle.Visible = false;

            ddlType.SelectedIndex = 0;

           

            LoadMenus();

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Dashboard.aspx",false);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvMenu_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {

                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count >0)
                {

                    lblcGroup.Visible = true;
                    ddlGroup.Visible = true;

                    lblctGroup.Visible = false;
                    txtGroup.Visible = false;

                    lblcTitle.Visible = true;
                    txtTitle.Visible = true;

                    ddlType.SelectedValue = "1";


                    txtTitle.Text = dsMenus.Tables[0].Rows[0]["Title"].ToString();
                    txtdesc.Text = dsMenus.Tables[0].Rows[0]["Description"].ToString();
                    ddlGroup.SelectedValue = dsMenus.Tables[0].Rows[0]["ParentMenuID"].ToString();
                    ddlVisibility.SelectedValue = dsMenus.Tables[0].Rows[0]["IsVisible"].ToString();
                    txtDepartment.Text = dsMenus.Tables[0].Rows[0]["Department"].ToString();

                    btnSave.Visible = false;
                    btnUpdate.Visible = true;
                }

                dsMenus.Dispose();


            }
        }
        else
        {
            LoadMenus();
        }
    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string sdep = "";

            if (txtDepartment.Text == "")
            {
              sdep = ddlDepartment.SelectedValue.ToString();
              txtDepartment.Text = sdep.ToString();

            }
            else
            {

                sdep = txtDepartment.Text;

                sdep = txtDepartment.Text + "," + ddlDepartment.SelectedValue;

                txtDepartment.Text = sdep.ToString();
                
            }

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
           if (ddlType.SelectedValue == "0")
           {
               lblctGroup.Visible = true;
               txtGroup.Visible = true;
               lblcGroup.Visible = false;
               ddlGroup.Visible = false;
               lblcTitle.Visible = false;
               txtTitle.Visible = false;
           }
           else if (ddlType.SelectedValue == "1")
           {
               lblctGroup.Visible = false;
               txtGroup.Visible = false;
               lblcGroup.Visible = true;
               ddlGroup.Visible = true;
               lblcTitle.Visible = true;
               txtTitle.Visible = true;
           }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvMenu_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvMenu.FilterMenu;
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