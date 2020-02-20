using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using Telerik.Web.UI;

public partial class DeptLkup : System.Web.UI.Page
{
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    SqlProcsNew sqlobj = new SqlProcsNew();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadUserGrid();
            btnUpdate.Visible = false;          
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 68 });


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
            SqlCommand cmd = new SqlCommand("Proc_Department_lkup", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 3);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet dsUsers = new DataSet();
            dap.Fill(dsUsers, "temp");
            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                gvDept.DataSource = dsUsers;
                gvDept.DataBind();
            }
            else
            {
                gvDept.DataSource = new string[] {};
                gvDept.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void RMSettings_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Admin")
        {
            Response.Redirect("Admin.aspx");
        }
        if (e.Item.Text == "Profile ++ LookUp")
        {
            Response.Redirect("AttribLkUpAdd.aspx");
        }
        if (e.Item.Text == "Item Master")
        {
            Response.Redirect("ItemMaster.aspx");
        }
        if (e.Item.Text == "User Management")
        {
            Response.Redirect("~/UserManagement.aspx");
        }
        if (e.Item.Text == "Villa Master")
        {
            Response.Redirect("~/VillaMaster.aspx");
        }
        if (e.Item.Text == "Task List Lookup")
        {
            Response.Redirect("~/TaskLkup.aspx");
        }
        if (e.Item.Text == "Assets")
        {
            Response.Redirect("~/Assets.aspx");
        }
        if (e.Item.Text == "Department Lookup")
        {
            Response.Redirect("~/DeptLkup.aspx");
        }
        if (e.Item.Text == "Service Configuration Lookup")
        {
            Response.Redirect("~/ServiceConfigLkup.aspx");
        }
        if (e.Item.Text == "Service Configuration")
        {
            Response.Redirect("~/ServiceConfig.aspx");
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_Department_lkup", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 1);
            cmd.Parameters.AddWithValue("@Code", txtcode.Text);
            cmd.Parameters.AddWithValue("@DeptName", txtdeptname.Text);
            cmd.Parameters.AddWithValue("@Details", txtdesc.Text);
            cmd.Parameters.AddWithValue("@MobileNo", txtcno.Text);  
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            LoadUserGrid();
            Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Department added successfully');", true);
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {        
            SqlCommand cmd = new SqlCommand("Proc_Department_lkup", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 2);
            cmd.Parameters.AddWithValue("@RSN", hbtnRSN.Value);
            cmd.Parameters.AddWithValue("@Code", txtcode.Text);
            cmd.Parameters.AddWithValue("@DeptName", txtdeptname.Text);
            cmd.Parameters.AddWithValue("@Details", txtdesc.Text);
            cmd.Parameters.AddWithValue("@MobileNo", txtcno.Text);  
            if(con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Clear();
            LoadUserGrid();
            btnSave.Visible = true;           
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Deprtment details updated successfully');", true);
        }
        catch (Exception ex)
        {
            
            throw;
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
        btnSave.Visible = true;       
        btnUpdate.Visible = false;
    }
    public void Clear()
    {
        txtdesc.Text = string.Empty;
        txtcode.Text = string.Empty;
        txtdeptname.Text = string.Empty;
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }
    protected void gvDept_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();
            if (e.Item is GridDataItem)
            {
                GridDataItem ditem = (GridDataItem)e.Item;
                txtcode.Text = ditem["Code"].Text;
                txtdeptname.Text = ditem["DeptName"].Text;
                txtdesc.Text = ditem["Details"].Text.ToString();
                txtcno.Text = ditem["MobileNo"].Text.ToString();
                btnSave.Visible = false;                
                btnUpdate.Visible = true;
            }
        }
        else
        {
            LoadUserGrid();
        }
    }
    protected void gvDept_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvDept.FilterMenu;
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