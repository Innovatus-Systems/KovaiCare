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

public partial class TaskLkup : System.Web.UI.Page
{
   // static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);


    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadUserGrid();
            btnUpdate.Visible = false;
            //btnDelete.Visible = false;            
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 66 });


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
            

           DataSet dsUsers = sqlobj.ExecuteSP("Proc_TaskLkup",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.NVarChar, Value = 4 });



            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                gvTaskLkup.DataSource = dsUsers;
                gvTaskLkup.DataBind();
            }
            else
            {
                gvTaskLkup.DataSource = null;
                gvTaskLkup.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet dsUsers = sqlobj.ExecuteSP("Proc_TaskLkup",
             new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
             new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.Char, Value = ddlCategory.SelectedValue },
             new SqlParameter() { ParameterName = "@TaskTitle", SqlDbType = SqlDbType.NVarChar, Value = txtTaskTitle.Text},
             new SqlParameter() { ParameterName = "@Message", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text }
             );

            LoadUserGrid();
            Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Tasks lookup details added successfully');", true);
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
          

            DataSet dsUsers = sqlobj.ExecuteSP("Proc_TaskLkup",
             new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
             new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value },
             new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.Char, Value = ddlCategory.SelectedValue },
             new SqlParameter() { ParameterName = "@TaskTitle", SqlDbType = SqlDbType.NVarChar, Value = txtTaskTitle.Text },
             new SqlParameter() { ParameterName = "@Message", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text }
             );

           
           
            Clear();
            LoadUserGrid();
            btnSave.Visible = true;
            //btnDelete.Visible = false;
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Tasks lookup details updated successfully');", true);
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            //SqlCommand cmd = new SqlCommand("Proc_TaskLkup", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@i", 3);
            //cmd.Parameters.AddWithValue("@RSN", hbtnRSN.Value);
            //if (con.State.Equals(ConnectionState.Open))
            //{
            //    con.Close();
            //}
            //con.Open();
            //cmd.ExecuteNonQuery();
            //con.Close();
            Clear();
            LoadUserGrid();
            btnSave.Visible = true;
            //btnDelete.Visible = false;
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Tasks lookup details deleted successfully');", true);
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
        btnSave.Visible = true;
        //btnDelete.Visible = false;
        btnUpdate.Visible = false;
    }
    public void Clear()
    {
        txtdesc.Text = string.Empty;
        txtTaskTitle.Text = string.Empty;
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }
    protected void gvTaskLkup_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();
            if (e.Item is GridDataItem)
            {
                GridDataItem ditem = (GridDataItem)e.Item;
                ddlCategory.SelectedValue = ditem["Category"].Text.ToString();
                txtTaskTitle.Text = ditem["TaskTittle"].Text.ToString();
                txtdesc.Text = ditem["Message"].Text.ToString();              

                btnSave.Visible = false;
                //btnDelete.Visible = true;
                btnUpdate.Visible = true;
            }
        }
        else
        {
            LoadUserGrid();
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
    }
}