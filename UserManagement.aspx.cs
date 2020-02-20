using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using Telerik.Web.UI;

public partial class UserManagement : System.Web.UI.Page
{
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            LoadTitle();
            LoadDepartment();
            LoadUserGrid();
            btnSave.Visible = true;
            btnUpdate.Visible = false;
            btnReset.Visible = false;
            txtpwd.Attributes["type"] = "password";
            lblError.Visible = false;
            txtName.Focus();
        }
        //string password = txtpwd.Text;
        //txtpwd.Attributes.Add("Value", password);
    }

    private void LoadDepartment()
    {
        try
        {
            DataSet dsDept = sqlobj.ExecuteSP("Proc_LoadServiceConfig",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 5 });

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

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 64 });


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
           
            DataSet dsUsers = sqlobj.ExecuteSP("SP_InserttblUserManagement",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2});
            
            if(dsUsers.Tables[0].Rows.Count > 0)
            {
                gvUsers.DataSource = dsUsers;
                gvUsers.DataBind();
            }
            else
            {
                gvUsers.DataSource = null;
                gvUsers.DataBind();
            }
        }
        catch (Exception ex)
        {           
        }
    }
    protected void gvtblUserManagement_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void gvtblUserManagement_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    [WebMethod]
    public static string AddNewUsers(string Name,string desig,string Landline,string Mobile,string Addr1,string Addr2,string Email,string Status,string Profile,string Kitchen,string Reports,string Accounts,string Settings,string Care,string Tasks,string Uevents,string Pwd,string UserID)
   // public static string AddNewUsers(string Name, string desig, string Landline, string Mobile, string Addr1, string Addr2)
    {
        string flag = "";
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            sqlobj.ExecuteSP("SP_InserttblUserManagement",
             new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
             new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = Name },
             new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = desig },
             new SqlParameter() { ParameterName = "@LandlineNo", SqlDbType = SqlDbType.NVarChar, Value = Landline },
             new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = Mobile },
             new SqlParameter() { ParameterName = "@Address1", SqlDbType = SqlDbType.NVarChar, Value = Addr1 },
             new SqlParameter() { ParameterName = "@Address2", SqlDbType = SqlDbType.NVarChar, Value = Addr2 },
             new SqlParameter() { ParameterName = "@EmailID", SqlDbType = SqlDbType.NVarChar, Value = Email },
             new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.Int, Value = Status },
             new SqlParameter() { ParameterName = "@Profile", SqlDbType = SqlDbType.NVarChar, Value = Profile },
             new SqlParameter() { ParameterName = "@Kitchen", SqlDbType = SqlDbType.NVarChar, Value = Kitchen },
             new SqlParameter() { ParameterName = "@ReportsAndCharts", SqlDbType = SqlDbType.NVarChar, Value = Reports },
             new SqlParameter() { ParameterName = "@Accounts", SqlDbType = SqlDbType.NVarChar, Value = Accounts },
             new SqlParameter() { ParameterName = "@Settings", SqlDbType = SqlDbType.NVarChar, Value = Settings },
             new SqlParameter() { ParameterName = "@Care", SqlDbType = SqlDbType.NVarChar, Value = Care },
             new SqlParameter() { ParameterName = "@Tasks", SqlDbType = SqlDbType.NVarChar, Value = Tasks },
             new SqlParameter() { ParameterName = "@UEvents", SqlDbType = SqlDbType.NVarChar, Value = Uevents },
             new SqlParameter() { ParameterName = "@Pwd", SqlDbType = SqlDbType.NVarChar, Value = Pwd },
             new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = UserID }
             );

            flag = "true";
           // clear();
           // ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('User details added successfully');", true);
        }
        catch (Exception ex)
        {
            flag = "false";
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Error');", true);
        }
        return flag;
    }   
  
    [WebMethod]
    public static void Refresh()
    {

    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }
    protected void gvUsers_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
       
        if(e.CommandName == "UpdateRow")
        {
            Int16 RSN = Convert.ToInt16(e.CommandArgument.ToString());
            ViewState["RSN"] = RSN;

            DataSet dsUsers = sqlobj.ExecuteSP("SP_InserttblUserManagement",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 },
              new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = RSN }
              );

            
            if(dsUsers.Tables[0].Rows.Count > 0)
            {
                htbnRSN.Value = RSN.ToString();
                txtName.Text = dsUsers.Tables[0].Rows[0]["Name"].ToString();
                txtDesig.Text = dsUsers.Tables[0].Rows[0]["Designation"].ToString();
                txtLandline.Text = dsUsers.Tables[0].Rows[0]["LandlineNo"].ToString();
                txtMobno.Text = dsUsers.Tables[0].Rows[0]["MobileNo"].ToString();
                txtAddr1.Text = dsUsers.Tables[0].Rows[0]["Address1"].ToString();
                txtAddr2.Text = dsUsers.Tables[0].Rows[0]["Address2"].ToString();
                txtEmailid.Text = dsUsers.Tables[0].Rows[0]["EmailID"].ToString();
                ddlSTatus.SelectedValue = dsUsers.Tables[0].Rows[0]["Status"].ToString();

                if (dsUsers.Tables[0].Rows[0]["DeptCode"].ToString() != "")
                {

                    ddlDepartment.SelectedValue = dsUsers.Tables[0].Rows[0]["DeptCode"].ToString();
                }

                txtUserID.Text = dsUsers.Tables[0].Rows[0]["UserID"].ToString();
                txtpwd.Text = dsUsers.Tables[0].Rows[0]["Password"].ToString();
                hbtnpwd.Value = dsUsers.Tables[0].Rows[0]["Password"].ToString();
               // txtpwd.Attributes["value"] = dsUsers.Tables[0].Rows[0]["Password"].ToString();

                btnSave.Visible = false;
                btnUpdate.Visible = true;
                btnReset.Visible = true;
            }
        }
        else
        {            
            LoadUserGrid();
        }
    }
    public void Clear()
    {
        txtUserID.Text = string.Empty;
        txtpwd.Text = string.Empty;
        txtName.Text = string.Empty;
        txtMobno.Text = string.Empty;
        txtLandline.Text = string.Empty;
        txtEmailid.Text = string.Empty;
        txtDesig.Text = string.Empty;
        txtAddr2.Text = string.Empty;
        txtAddr1.Text = string.Empty;
        ddlDepartment.SelectedIndex = 0;
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
           
          sqlobj.ExecuteSP("SP_InserttblUserManagement",
           new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 },
           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = htbnRSN.Value },
           new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
           new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = txtDesig.Text },
           new SqlParameter() { ParameterName = "@LandlineNo", SqlDbType = SqlDbType.NVarChar, Value = txtLandline.Text },
           new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = txtMobno.Text },
           new SqlParameter() { ParameterName = "@Address1", SqlDbType = SqlDbType.NVarChar, Value = txtAddr1.Text },
           new SqlParameter() { ParameterName = "@Address2", SqlDbType = SqlDbType.NVarChar, Value = txtAddr2.Text },
           new SqlParameter() { ParameterName = "@EmailID", SqlDbType = SqlDbType.NVarChar, Value = txtEmailid.Text },
           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.Int, Value = ddlSTatus.SelectedValue.ToString() },
           new SqlParameter() { ParameterName = "@DeptCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDepartment.SelectedValue },
           new SqlParameter() { ParameterName = "@Pwd", SqlDbType = SqlDbType.NVarChar, Value = txtpwd.Text != "" ? txtpwd.Text : null  },
           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text }
           );
            
            
            LoadUserGrid();
            Clear();
            btnUpdate.Visible = false;
            btnReset.Visible = false;
            btnSave.Visible = true;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('User profile updated.');", true);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
     {
        try
        {            
          
          sqlobj.ExecuteSP("SP_InserttblUserManagement",
          new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
          new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
          new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = txtDesig.Text },
          new SqlParameter() { ParameterName = "@LandlineNo", SqlDbType = SqlDbType.NVarChar, Value = txtLandline.Text },
          new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = txtMobno.Text },
          new SqlParameter() { ParameterName = "@Address1", SqlDbType = SqlDbType.NVarChar, Value = txtAddr1.Text },
          new SqlParameter() { ParameterName = "@Address2", SqlDbType = SqlDbType.NVarChar, Value = txtAddr2.Text },
          new SqlParameter() { ParameterName = "@EmailID", SqlDbType = SqlDbType.NVarChar, Value = txtEmailid.Text },
          new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.Int, Value = ddlSTatus.SelectedValue.ToString() },
          new SqlParameter() { ParameterName = "@DeptCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDepartment.SelectedValue },
          new SqlParameter() { ParameterName = "@Pwd", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text.ToLower() },
          new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text }
          );


         
            LoadUserGrid();
            Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('New user created with default password.');", true);


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        LoadUserGrid();
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
        btnSave.Visible = true;
        btnUpdate.Visible = false;
        btnReset.Visible = false;
    }
    protected void txtUserID_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if(txtUserID.Text.ToLower() == "admin")
            {
                txtUserID.Text = string.Empty;
                lblError.Visible = true;
                lblError.Text = "UserID already reserved";
               // ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('UserID already reserved.');", true);
                return;
            }

          
            DataSet ds = sqlobj.ExecuteSP("porc_ChekUserID",
                new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text.ToLower() }
            );

            
            
            if(ds.Tables[0].Rows.Count > 0)
            {
                Int16 sts = Convert.ToInt16(ds.Tables[0].Rows[0][0].ToString());
                if(sts == 1)
                {
                    txtUserID.Text = string.Empty;
                    lblError.Visible = true;
                    lblError.Text = "UserID already exists";
                    //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('UserID already exists.');", true);
                }  
                else
                {
                    lblError.Visible = false;
                }
            }

        }
        catch (Exception ex)
        {           
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        try
        {
            

       sqlobj.ExecuteSP("SP_InserttblUserManagement",
       new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 },
       new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(ViewState["RSN"]) },
       new SqlParameter() { ParameterName = "@Designation", SqlDbType = SqlDbType.NVarChar, Value = txtDesig.Text },
       new SqlParameter() { ParameterName = "@LandlineNo", SqlDbType = SqlDbType.NVarChar, Value = txtLandline.Text },
       new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = txtMobno.Text },
       new SqlParameter() { ParameterName = "@Address1", SqlDbType = SqlDbType.NVarChar, Value = txtAddr1.Text },
       new SqlParameter() { ParameterName = "@Address2", SqlDbType = SqlDbType.NVarChar, Value = txtAddr2.Text },
       new SqlParameter() { ParameterName = "@EmailID", SqlDbType = SqlDbType.NVarChar, Value = txtEmailid.Text },
       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.Int, Value = ddlSTatus.SelectedValue.ToString() },
       new SqlParameter() { ParameterName = "@DeptCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDepartment.SelectedValue },
       new SqlParameter() { ParameterName = "@Pwd", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text },
       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = txtUserID.Text }
       );

        
            LoadUserGrid();
            Clear();
            btnUpdate.Visible = false;
            btnReset.Visible = false;
            btnSave.Visible = true;

            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Your password is reset successfully.Can change your password in first login.');", true);
        }
        catch(Exception ex)
        {

        }
    }
    protected void RMSettings_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
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
    protected void gvUsers_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvUsers.FilterMenu;
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