using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Configuration;

public partial class ServiceConfigLkup : System.Web.UI.Page
{
    //static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);


    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadUserGrid();
            LoadDepartments();
            btnUpdate.Visible = false;
            txtcode.Enabled = true;
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 69 });


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

    public void LoadDepartments()
    {
      
        try
        {
            DataSet dap = sqlobj.ExecuteSP("Proc_Departments");

            if (dap.Tables[0].Rows.Count > 0)
            {
                ddldeptname.DataSource = dap.Tables[0];
                ddldeptname.DataTextField = "DeptName";
                ddldeptname.DataValueField = "Code";
                ddldeptname.DataBind();
            }


          dap.Dispose();

     
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

            DataSet dsUsers = sqlobj.ExecuteSP("Proc_ServiceConfig",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 });
           

            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                gvService.DataSource = dsUsers;
                gvService.DataBind();
            }
            else
            {
                gvService.DataSource = new string[] {};
                gvService.DataBind();
            }

            dsUsers.Dispose();
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

            if (CnfResult.Value == "true")
            {


                DataSet dsUsers = sqlobj.ExecuteSP("Proc_ServiceConfig",
                 new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@Code", SqlDbType = SqlDbType.Char, Value = txtcode.Text },
                 new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = txtServiceCat.Text },
                 new SqlParameter() { ParameterName = "@DeptCode", SqlDbType = SqlDbType.NVarChar, Value = ddldeptname.SelectedValue.ToString() },
                 new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text }
                 );

                dsUsers.Dispose();

                LoadUserGrid();
                Clear();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Service configuration lookup added successfully');", true);
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {

                DataSet dsUsers = sqlobj.ExecuteSP("Proc_ServiceConfig",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = hbtnRSN.Value },
                new SqlParameter() { ParameterName = "@Code", SqlDbType = SqlDbType.Char, Value = txtcode.Text },
                new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = txtServiceCat.Text },
                new SqlParameter() { ParameterName = "@DeptCode", SqlDbType = SqlDbType.NVarChar, Value = ddldeptname.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text }
                );


                LoadUserGrid();
                Clear();
                txtcode.Enabled = true;
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Service configuration lookup updated successfully');", true);
            }
        }
        catch (Exception ex)
        {

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
       
        txtServiceCat.Text = string.Empty;
        txtcode.Text = string.Empty;
        txtcode.Enabled = true;
        ddldeptname.SelectedIndex = 0;

        //ddldeptname.Items.Insert(0, "Please Select");
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }
   
    protected void gvService_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();
            if (e.Item is GridDataItem)
            {
                GridDataItem ditem = (GridDataItem)e.Item;
                txtcode.Text = ditem["Code"].Text;
                txtServiceCat.Text = ditem["Category"].Text;
               
                ddldeptname.SelectedItem.Text = ditem["DeptName"].Text;
                //txtdesc.Text = ditem["Description"].Text.ToString();
                if (ditem["Description"].Text.ToString() != "&nbsp;")
                {
                    txtdesc.Text = Convert.ToString(ditem["Description"].Text.ToString());
                }
                else
                {
                    txtdesc.Text = "";
                }
                txtcode.Enabled = false;
                btnSave.Visible = false;                
                btnUpdate.Visible = true;
            }
        }
        else
        {
            LoadUserGrid();
        }
    }
    protected void gvService_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvService.FilterMenu;
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