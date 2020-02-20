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

public partial class InternalTasksMaster : System.Web.UI.Page
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

                LoadInternalTasks();


                btnSave.Visible = true;
                btnUpdate.Visible = false;


            }
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 127 });


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

    private void LoadInternalTasks()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_InternalTasksMaster",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 }
                );

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                gvInternalTasksMaster.DataSource = dsCategory;
                gvInternalTasksMaster.DataBind();
            }
            else
            {
                gvInternalTasksMaster.DataSource = string.Empty;
                gvInternalTasksMaster.DataBind();
            }

            dsCategory.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void ClearTasks()
    {
        txtTaskCode.Text ="";
        txtTaskTitle.Text = "";
        txtTaskDescription.Text ="";
        ddlTaskFrequency.SelectedIndex=0;
        ddlPriority.SelectedIndex=0;
        ddlTaskStatus.SelectedIndex=0;

        LoadInternalTasks();

        btnSave.Visible=true;
        btnUpdate.Visible=false;



    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {


                sqlobj.ExecuteSQLNonQuery("SP_InternalTasksMaster",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                       new SqlParameter() { ParameterName = "@ITaskCode", SqlDbType = SqlDbType.NVarChar, Value = txtTaskCode.Text },
                       new SqlParameter() { ParameterName = "@ITaskTitle", SqlDbType = SqlDbType.NVarChar, Value = txtTaskTitle.Text },
                       new SqlParameter() { ParameterName = "@ITaskDescription", SqlDbType = SqlDbType.NVarChar, Value = txtTaskDescription.Text },
                       new SqlParameter() { ParameterName = "@ITaskFrequency", SqlDbType = SqlDbType.NVarChar, Value = ddlTaskFrequency.SelectedValue },
                       new SqlParameter() { ParameterName = "@ITaskPriority", SqlDbType = SqlDbType.NVarChar, Value = ddlPriority.SelectedValue },
                       new SqlParameter() { ParameterName = "@ITaskStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlTaskStatus.SelectedValue },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                       );

                ClearTasks();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Internal Task Master details saved');", true);
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


                sqlobj.ExecuteSQLNonQuery("SP_InternalTasksMaster",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@ITaskCode", SqlDbType = SqlDbType.NVarChar, Value = txtTaskCode.Text },
                       new SqlParameter() { ParameterName = "@ITaskTitle", SqlDbType = SqlDbType.NVarChar, Value = txtTaskTitle.Text },
                       new SqlParameter() { ParameterName = "@ITaskDescription", SqlDbType = SqlDbType.NVarChar, Value = txtTaskDescription.Text },
                       new SqlParameter() { ParameterName = "@ITaskFrequency", SqlDbType = SqlDbType.NVarChar, Value = ddlTaskFrequency.SelectedValue },
                       new SqlParameter() { ParameterName = "@ITaskPriority", SqlDbType = SqlDbType.NVarChar, Value = ddlPriority.SelectedValue },
                       new SqlParameter() { ParameterName = "@ITaskStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlTaskStatus.SelectedValue },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                       new SqlParameter() { ParameterName = "@ITRSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() }

                       );

                ClearTasks();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Internal Task Master details updated');", true);
            }



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearTasks();
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx",false);
    }
    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {

    }
    protected void gvInternalTasksMaster_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
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

                    DataSet dsRes = sqlobj.ExecuteSP("SP_InternalTasksMaster",
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 },
                        new SqlParameter() { ParameterName = "@ITRSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text });

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {
                        txtTaskCode.Text = dsRes.Tables[0].Rows[0]["ITaskCode"].ToString();
                        txtTaskTitle.Text = dsRes.Tables[0].Rows[0]["ITaskTitle"].ToString();
                        txtTaskDescription.Text = dsRes.Tables[0].Rows[0]["ITaskDescription"].ToString();
                        ddlTaskFrequency.SelectedValue = dsRes.Tables[0].Rows[0]["ITaskFrequency"].ToString();
                        ddlPriority.SelectedValue = dsRes.Tables[0].Rows[0]["ITaskPriority"].ToString();
                        ddlTaskStatus.SelectedValue = dsRes.Tables[0].Rows[0]["ITaskStatus"].ToString();
                       

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
    protected void gvInternalTasksMaster_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvInternalTasksMaster.FilterMenu;
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