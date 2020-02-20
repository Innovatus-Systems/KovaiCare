using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using Telerik.Web.UI;

public partial class ServiceConfig : System.Web.UI.Page
{
    // SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);


    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadServiceCategory();
            LoadUserGrid();
            LoadDepartmentsAll();
            // txtlastusedate.SelectedDate = DateTime.Today;
            btnUpdate.Visible = false;
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 70 });


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
        if (e.Item.Text == "Service Categories")
        {
            Response.Redirect("~/ServiceConfigLkup.aspx");
        }
        if (e.Item.Text == "Service Types")
        {
            Response.Redirect("~/ServiceConfig.aspx");
        }
    }
    public void LoadUserGrid()
    {
        try
        {

            DataSet dap = sqlobj.ExecuteSP("Proc_GetServiceConfig",
                 new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 });


            if (dap.Tables[0].Rows.Count > 0)
            {
                gvServiceConfig.DataSource = dap;
                gvServiceConfig.DataBind();
            }
            else
            {
                gvServiceConfig.DataSource = new string[] { };
                gvServiceConfig.DataBind();
            }

            dap.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    public void LoadServiceCategory()
    {

        try
        {

            DataSet dsCategory = sqlobj.ExecuteSP("Proc_LoadServiceConfig",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 });

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                ddlCategory.DataSource = dsCategory.Tables[0];
                ddlCategory.DataTextField = "Category";
                ddlCategory.DataValueField = "Code";
                ddlCategory.DataBind();
            }
            ddlCategory.Items.Insert(0, "Please Select");


            dsCategory.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataSet dsType = new DataSet();
        try
        {

            LoadDepartments();


        }
        catch (Exception ex)
        {
        }
    }
    public void LoadDepartmentsAll()
    {

        try
        {

            DataSet dsDept = sqlobj.ExecuteSP("Proc_LoadServiceConfig",
           new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 5 });

            if (dsDept.Tables[0].Rows.Count > 0)
            {

                ddldeptcode.DataSource = dsDept.Tables[0];
                ddldeptcode.DataTextField = "DeptName";
                ddldeptcode.DataValueField = "Code";
                ddldeptcode.DataBind();
            }

            ddldeptcode.Items.Insert(0, "-");

            dsDept.Dispose();

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
            if (ddlCategory.SelectedValue != "Please Select")
            {
                DataSet dsDept = sqlobj.ExecuteSP("Proc_LoadServiceConfig",
                    new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.SelectedValue });
                if (dsDept.Tables[0].Rows.Count > 0)
                {
                    ddldeptcode.SelectedValue = dsDept.Tables[0].Rows[0]["DeptCode"].ToString();
                }
                ddldeptcode.Enabled = true;
                ddldeptcode.Dispose();
            }
            else
            {
                ddldeptcode.SelectedValue = "-";
                ddldeptcode.Enabled = false;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadDepartments();
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
            if (ddlCategory.SelectedValue == "Please Select")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Please select category');", true);
                return;
            }

            sqlobj.ExecuteSP("Proc_ServiceConfig_Insert",
            new SqlParameter() { ParameterName = "@SCategory", SqlDbType = SqlDbType.VarChar, Value = ddlCategory.SelectedValue },
            new SqlParameter() { ParameterName = "@SType", SqlDbType = SqlDbType.VarChar, Value = txtserType.Text },
            new SqlParameter() { ParameterName = "@DeptCode", SqlDbType = SqlDbType.Char, Value = ddldeptcode.SelectedValue },
            new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
            new SqlParameter() { ParameterName = "@Rate", SqlDbType = SqlDbType.NVarChar, Value = txtRate.Text },
            new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.Char, Value = ddlPriority.SelectedValue },
            new SqlParameter() { ParameterName = "@Occurrence", SqlDbType = SqlDbType.NVarChar, Value = txtoccurrence.Text },
            new SqlParameter() { ParameterName = "@Lastusedate", SqlDbType = SqlDbType.DateTime, Value = txtlastusedate.SelectedDate },
            new SqlParameter() { ParameterName = "@Lastuseby", SqlDbType = SqlDbType.NVarChar, Value = txtlastuseby.Text },
            new SqlParameter() { ParameterName = "@RegnMsg", SqlDbType = SqlDbType.NVarChar, Value = txtRegnmsg.Text },
            new SqlParameter() { ParameterName = "@CompletionMsg", SqlDbType = SqlDbType.NVarChar, Value = txtcompmsg.Text },
            new SqlParameter() { ParameterName = "@DateYorN", SqlDbType = SqlDbType.Char, Value = ddlDate.SelectedValue },
            new SqlParameter() { ParameterName = "@TimeYorN", SqlDbType = SqlDbType.Char, Value = ddlTime.SelectedValue },
            new SqlParameter() { ParameterName = "@CountYorN", SqlDbType = SqlDbType.Char, Value = ddlCount.SelectedValue },
            new SqlParameter() { ParameterName = "@stdtext1", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext1.Text },
            new SqlParameter() { ParameterName = "@stdtext2", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext2.Text },
            new SqlParameter() { ParameterName = "@stdtext3", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext3.Text },
            new SqlParameter() { ParameterName = "@stdtext4", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext4.Text },
            new SqlParameter() { ParameterName = "@stdtext5", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext5.Text },
            new SqlParameter() { ParameterName = "@stdtext6", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext6.Text },
            new SqlParameter() { ParameterName = "@MSMS", SqlDbType = SqlDbType.Char, Value = ddlmsms.SelectedValue },
            new SqlParameter() { ParameterName = "@RSMS", SqlDbType = SqlDbType.Char, Value = ddlrsms.SelectedValue },
            new SqlParameter() { ParameterName = "@DSMS", SqlDbType = SqlDbType.Char, Value = ddldsms.SelectedValue },
            new SqlParameter() { ParameterName = "@AutoDebit", SqlDbType = SqlDbType.Char, Value = ddlautodebit.SelectedValue },
            new SqlParameter() { ParameterName = "@Tax", SqlDbType = SqlDbType.Decimal, Value = ddlTax.SelectedValue }
            );


            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Service configuration details saved successfully');", true);
            clear();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    public void clear()
    {

        LoadUserGrid();

        txtcompmsg.Text = string.Empty;
        txtdesc.Text = string.Empty;
        txtlastuseby.Text = string.Empty;
        txtlastusedate.SelectedDate = DateTime.Today;
        txtoccurrence.Text = string.Empty;
        ddlTax.SelectedIndex = 0;
        txtRate.Text = string.Empty;
        txtRegnmsg.Text = string.Empty;
        txtstdtext1.Text = string.Empty;
        txtstdtext2.Text = string.Empty;
        txtstdtext3.Text = string.Empty;
        txtstdtext4.Text = string.Empty;
        txtstdtext5.Text = string.Empty;
        txtstdtext6.Text = string.Empty;
        ddlCategory.SelectedValue = "Please Select";
        txtserType.Text = "";
        ddldeptcode.SelectedIndex = 0;
        btnUpdate.Visible = false;
        btnSave.Visible = true;
        //LoadDepartmentsAll();

        ddldeptcode.Enabled = true;
        ddlCategory.Enabled = true;
        txtserType.Enabled = true;
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        clear();
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }
    protected void gvServiceConfig_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

        try
        {

            if (e.CommandName == "UpdateRow")
            {
                Int16 RSN = Convert.ToInt16(e.CommandArgument.ToString());
                htbnRSN.Value = e.CommandArgument.ToString();


                DataSet dsUsers = sqlobj.ExecuteSP("Proc_GetServiceConfig",
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.VarChar, Value = 2 },
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.VarChar, Value = RSN });


                if (dsUsers.Tables[0].Rows.Count > 0)
                {
                    ddlCategory.SelectedValue = dsUsers.Tables[0].Rows[0]["ServiceCategory"].ToString();
                    if (dsUsers.Tables[0].Rows[0]["ServiceType"].ToString() != "")
                    {
                        txtserType.Text = dsUsers.Tables[0].Rows[0]["ServiceType"].ToString();
                        ddldeptcode.SelectedValue = dsUsers.Tables[0].Rows[0]["DeptCode"].ToString();
                    }
                    txtdesc.Text = dsUsers.Tables[0].Rows[0]["Description"].ToString();
                    ddlTax.SelectedValue = dsUsers.Tables[0].Rows[0]["Tax"].ToString();
                    txtRate.Text = dsUsers.Tables[0].Rows[0]["Rate"].ToString();
                    ddlPriority.SelectedValue = dsUsers.Tables[0].Rows[0]["Priority"].ToString();
                    txtoccurrence.Text = dsUsers.Tables[0].Rows[0]["Occurrence"].ToString();
                    if (dsUsers.Tables[0].Rows[0]["Lastusedate"].ToString() != "")
                    {
                        txtlastusedate.SelectedDate = Convert.ToDateTime(dsUsers.Tables[0].Rows[0]["Lastusedate"]);
                    }

                    txtlastuseby.Text = dsUsers.Tables[0].Rows[0]["LastuseBy"].ToString();
                    txtRegnmsg.Text = dsUsers.Tables[0].Rows[0]["RegnMsg"].ToString();
                    txtcompmsg.Text = dsUsers.Tables[0].Rows[0]["CompletionMsg"].ToString();
                    ddlDate.SelectedValue = dsUsers.Tables[0].Rows[0]["DateYorN"].ToString();
                    ddlTime.SelectedValue = dsUsers.Tables[0].Rows[0]["TimeYorN"].ToString();
                    ddlCount.SelectedValue = dsUsers.Tables[0].Rows[0]["CountYorN"].ToString();

                    txtstdtext1.Text = dsUsers.Tables[0].Rows[0]["StdText1"].ToString();
                    txtstdtext2.Text = dsUsers.Tables[0].Rows[0]["StdText2"].ToString();
                    txtstdtext3.Text = dsUsers.Tables[0].Rows[0]["StdText3"].ToString();
                    txtstdtext4.Text = dsUsers.Tables[0].Rows[0]["StdText4"].ToString();
                    txtstdtext5.Text = dsUsers.Tables[0].Rows[0]["StdText5"].ToString();
                    txtstdtext6.Text = dsUsers.Tables[0].Rows[0]["StdText6"].ToString();

                    ddlmsms.SelectedValue = dsUsers.Tables[0].Rows[0]["MSMS"].ToString();
                    ddlrsms.SelectedValue = dsUsers.Tables[0].Rows[0]["RSMS"].ToString();
                    ddldsms.SelectedValue = dsUsers.Tables[0].Rows[0]["DSMS"].ToString();
                    ddlautodebit.SelectedValue = dsUsers.Tables[0].Rows[0]["AutoDebit"].ToString();

                    ddldeptcode.Enabled = false;
                    ddlCategory.Enabled = false;
                    txtserType.Enabled = false;

                    btnUpdate.Visible = true;
                    btnSave.Visible = false;
                }

                dsUsers.Dispose();
            }
            else
            {
                LoadUserGrid();
            }

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('" + ex.Message + "');", true);
        }



    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {


            sqlobj.ExecuteSP("Proc_ServiceConfig_Update",
           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = htbnRSN.Value },
           new SqlParameter() { ParameterName = "@SCategory", SqlDbType = SqlDbType.VarChar, Value = ddlCategory.SelectedValue },
           new SqlParameter() { ParameterName = "@SType", SqlDbType = SqlDbType.VarChar, Value = txtserType.Text },
           new SqlParameter() { ParameterName = "@DeptCode", SqlDbType = SqlDbType.Char, Value = ddldeptcode.SelectedValue },
           new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
           new SqlParameter() { ParameterName = "@Rate", SqlDbType = SqlDbType.NVarChar, Value = txtRate.Text },
           new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.Char, Value = ddlPriority.SelectedValue },
           new SqlParameter() { ParameterName = "@Occurrence", SqlDbType = SqlDbType.NVarChar, Value = txtoccurrence.Text },
           new SqlParameter() { ParameterName = "@Lastusedate", SqlDbType = SqlDbType.DateTime, Value = txtlastusedate.SelectedDate },
           new SqlParameter() { ParameterName = "@Lastuseby", SqlDbType = SqlDbType.NVarChar, Value = txtlastuseby.Text },
           new SqlParameter() { ParameterName = "@RegnMsg", SqlDbType = SqlDbType.NVarChar, Value = txtRegnmsg.Text },
           new SqlParameter() { ParameterName = "@CompletionMsg", SqlDbType = SqlDbType.NVarChar, Value = txtcompmsg.Text },
           new SqlParameter() { ParameterName = "@DateYorN", SqlDbType = SqlDbType.Char, Value = ddlDate.SelectedValue },
           new SqlParameter() { ParameterName = "@TimeYorN", SqlDbType = SqlDbType.Char, Value = ddlTime.SelectedValue },
           new SqlParameter() { ParameterName = "@CountYorN", SqlDbType = SqlDbType.Char, Value = ddlCount.SelectedValue },
           new SqlParameter() { ParameterName = "@stdtext1", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext1.Text },
           new SqlParameter() { ParameterName = "@stdtext2", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext2.Text },
           new SqlParameter() { ParameterName = "@stdtext3", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext3.Text },
           new SqlParameter() { ParameterName = "@stdtext4", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext4.Text },
           new SqlParameter() { ParameterName = "@stdtext5", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext5.Text },
           new SqlParameter() { ParameterName = "@stdtext6", SqlDbType = SqlDbType.NVarChar, Value = txtstdtext6.Text },
           new SqlParameter() { ParameterName = "@MSMS", SqlDbType = SqlDbType.Char, Value = ddlmsms.SelectedValue },
           new SqlParameter() { ParameterName = "@RSMS", SqlDbType = SqlDbType.Char, Value = ddlrsms.SelectedValue },
           new SqlParameter() { ParameterName = "@DSMS", SqlDbType = SqlDbType.Char, Value = ddldsms.SelectedValue },
           new SqlParameter() { ParameterName = "@AutoDebit", SqlDbType = SqlDbType.Char, Value = ddlautodebit.SelectedValue },
           new SqlParameter() { ParameterName = "@Tax", SqlDbType = SqlDbType.Decimal, Value = ddlTax.SelectedValue }
           );

            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Service configuration details updated successfully');", true);
            clear();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void gvServiceConfig_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvServiceConfig.FilterMenu;
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