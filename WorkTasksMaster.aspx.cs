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

public partial class WorkTasksMaster : System.Web.UI.Page
{

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }


            if (!IsPostBack)
            {
                LoadTitle();

                LoadCategory();
                LoadDepartmentsAll();
                //LoadSiteName();
                LoadWorkTasks();
                LoadWorkType();

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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 38 });


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

    private void LoadWorkType()
    {
        try
        {
            DataSet dsLoadProvisionType = sqlobj.ExecuteSP("SP_WorkType", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 });

            ddlType.Items.Clear();

            if (dsLoadProvisionType.Tables[0].Rows.Count > 0)
            {
                ddlType.DataSource = dsLoadProvisionType;
                ddlType.DataValueField = "WorkType";
                ddlType.DataTextField = "WorkType";
                ddlType.DataBind();

            }

            ddlType.Items.Insert(0, "--Select--");

            dsLoadProvisionType.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    //private void LoadSiteName()
    //{
    //    DataSet dsLoadSite = sqlobj.ExecuteSP("SP_LoadSitelkup");

    //    ddlSite.Items.Clear();

    //    if (dsLoadSite.Tables[0].Rows.Count > 0)
    //    {
    //        ddlSite.DataSource = dsLoadSite;
    //        ddlSite.DataTextField = "SiteName";
    //        ddlSite.DataValueField = "SiteName";
    //        ddlSite.DataBind();
    //    }

    //    ddlSite.Items.Insert(0, "--Select--");

    //    dsLoadSite.Dispose();
    //}

    public void ExportExcel(RadGrid radGrid)
    {
        //if (radGrid == null)
        //    throw new ArgumentNullException("radGrid");
     //   Page.IsExporting = true;

        //Export settings
        radGrid.ExportSettings.HideStructureColumns = true;
        radGrid.ExportSettings.SuppressColumnDataFormatStrings = false;
        radGrid.ExportSettings.ExportOnlyData = true;
        radGrid.ExportSettings.IgnorePaging = true;


        //Excel Format
        radGrid.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML;

        radGrid.MasterTableView.Caption = "Tasks Master List";

        radGrid.MasterTableView.ExportToExcel();
    }

    private void LoadWorkTasks()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_LoadTasksMaster");

            if (dsCategory.Tables[0].Rows.Count>0)
            {
                gvWorkTasks.DataSource = dsCategory;
                gvWorkTasks.DataBind();
            }
            else
            {
                gvWorkTasks.DataSource = string.Empty;
                gvWorkTasks.DataBind();
            }

            dsCategory.Dispose();

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadCategory()
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
            ddlCategory.Items.Insert(0, "--Select--");


            dsCategory.Dispose();
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

               
                    sqlobj.ExecuteSQLNonQuery("SP_InserttblTasksMaster",
                           new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = txtTitle.Text },
                           new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                           new SqlParameter() { ParameterName = "@TaskCategory", SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.SelectedValue },
                           new SqlParameter() { ParameterName = "@UsualTime", SqlDbType = SqlDbType.BigInt, Value = txtUsualTimeMins.Text },
                           new SqlParameter() { ParameterName = "@Site", SqlDbType = SqlDbType.NVarChar, Value = "" },
                           new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlPriority.SelectedValue },
                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                           new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.VarChar, Value = ddlType.SelectedValue }
                           );

                    ClearTasks();

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('House keeping Task details saved');", true);
                }
               
            

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            try
            {
                if (CnfResult.Value == "true")
                {

               
                    sqlobj.ExecuteSQLNonQuery("SP_UpdatetblTasksMaster",
                           new SqlParameter() { ParameterName = "@Title", SqlDbType = SqlDbType.NVarChar, Value = txtTitle.Text },
                           new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                           new SqlParameter() { ParameterName = "@TaskCategory", SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.SelectedValue },
                           new SqlParameter() { ParameterName = "@UsualTime", SqlDbType = SqlDbType.BigInt, Value = txtUsualTimeMins.Text },
                           new SqlParameter() { ParameterName = "@Site", SqlDbType = SqlDbType.NVarChar, Value = ""},
                           new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlPriority.SelectedValue },
                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() },
                           new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.VarChar, Value = ddlType.SelectedValue }
                           );

                    ClearTasks();

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('House keeping Task details updated');", true);
                }
                

            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void ClearTasks()
    {
        txtTitle.Text = "";
        txtdesc.Text = "";
        txtUsualTimeMins.Text = "";
        ddlCategory.SelectedIndex = 0;
        ddlPriority.SelectedIndex = 0;
        //ddlSite.SelectedIndex = 0;
        ddlType.SelectedIndex = 0; 
        ddlDepartment.SelectedIndex = 0;


        LoadWorkTasks();
        //LoadSiteName();

        btnSave.Visible = true;
        btnUpdate.Visible = false;
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            ClearTasks();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvWorkTasks_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "UpdateRow")
            {
                hbtnRSN.Value = e.CommandArgument.ToString();
                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    LinkButton lnkRSN = (LinkButton)e.Item.FindControl("lnkRSN");

                    Session["RSN"] = lnkRSN.Text;

                    DataSet dsRes = sqlobj.ExecuteSP("SP_GetWorksTasks",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text });

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {
                        txtTitle.Text = dsRes.Tables[0].Rows[0]["Title"].ToString();
                        txtdesc.Text = dsRes.Tables[0].Rows[0]["Description"].ToString();
                        ddlCategory.SelectedValue = dsRes.Tables[0].Rows[0]["TaskCategory"].ToString();
                        ddlPriority.SelectedValue = dsRes.Tables[0].Rows[0]["Priority"].ToString();
                        ddlType.SelectedValue = dsRes.Tables[0].Rows[0]["Type"].ToString();
                        //ddlSite.SelectedValue = dsRes.Tables[0].Rows[0]["Site"].ToString();
                        txtUsualTimeMins.Text =  dsRes.Tables[0].Rows[0]["UsualTime"].ToString();
                        ddlDepartment.SelectedItem.Text = dsRes.Tables[0].Rows[0]["DeptName"].ToString();

                        btnSave.Visible = false;
                        btnUpdate.Visible = true;
                    }

                    dsRes.Dispose();

                   
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx",false);
    }
    protected void btnClear_Click1(object sender, EventArgs e)
    {

    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            LoadDepartments();


        }
        catch (Exception ex)
        {
        }
    }

    public void LoadDepartments()
    {

        try
        {

            DataSet dsDept = sqlobj.ExecuteSP("Proc_LoadServiceConfig",
          new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 },
          new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.SelectedValue }
          );

            if (dsDept.Tables[0].Rows.Count > 0)
            {

                ddlDepartment.SelectedValue = dsDept.Tables[0].Rows[0]["DeptCode"].ToString();

            }


            ddlDepartment.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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

                ddlDepartment.DataSource = dsDept.Tables[0];
                ddlDepartment.DataTextField = "DeptName";
                ddlDepartment.DataValueField = "Code";
                ddlDepartment.DataBind();
            }

            ddlDepartment.Items.Insert(0, "-");

            dsDept.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        gvWorkTasks.ExportSettings.ExportOnlyData = true;
        gvWorkTasks.ExportSettings.FileName = "Tasks Master List";
        gvWorkTasks.ExportSettings.IgnorePaging = true;
        gvWorkTasks.ExportSettings.OpenInNewWindow = true;
        gvWorkTasks.MasterTableView.ExportToExcel();
    }
    protected void gvWorkTasks_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvWorkTasks.FilterMenu;
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