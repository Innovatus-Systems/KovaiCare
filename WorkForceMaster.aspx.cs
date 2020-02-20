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

public partial class WorkForceMaster : System.Web.UI.Page
{

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {
                LoadTitle();

                LoadDepartmentsAll();
                LoadCategory();
                LoadWorkForce();
                
                dtpBirthday.MaxDate = DateTime.Today;
                dtpWedding.MaxDate = DateTime.Today;

                dtpExitDate.Visible = false;
                lblexitdate.Visible = false;


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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 39 });


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

    private void LoadWorkForce()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_LoadWorkForce");

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                gvWorkForce.DataSource = dsCategory;
                gvWorkForce.DataBind();
            }
            else
            {
                gvWorkForce.DataSource = string.Empty;
                gvWorkForce.DataBind();
            }

            dsCategory.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadCategory()
    {
        try
        {

            DataSet dsCategory = sqlobj.ExecuteSP("SP_GetCategory", 
                new SqlParameter() { ParameterName = "@DeptCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDepartment.SelectedValue });

            ddlCategory.Items.Clear();

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
    private void ClearWorkForce()
    {
        txtPersonName.Text = "";
        ddlGender.SelectedIndex = 0;
        ddlCategory.SelectedIndex = 0;
        dtpJoindate.SelectedDate = null;
        ddlStatus.SelectedIndex = 0;
        ddlType.SelectedIndex = 0;
       
        txtdesc.Text = "";

        LoadWorkForce();

        dtpExitDate.Visible = false;
        lblexitdate.Visible = false;

        btnSave.Visible = true;
        btnUpdate.Visible = false;


    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {

                sqlobj.ExecuteSQLNonQuery("SP_InserttblWorforceMaster",
                       new SqlParameter() { ParameterName = "@PersonName", SqlDbType = SqlDbType.NVarChar, Value = txtPersonName.Text  },
                       new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = ddlGender.SelectedValue },
                       new SqlParameter() { ParameterName = "@TaskCategory", SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.SelectedValue },
                       new SqlParameter() { ParameterName = "@JoinDate", SqlDbType = SqlDbType.DateTime, Value = dtpJoindate.SelectedDate },
                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue },
                       new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue },
                       new SqlParameter() { ParameterName = "@Wedding", SqlDbType = SqlDbType.DateTime, Value = dtpWedding.SelectedDate == null ? null : dtpWedding.SelectedDate },
                       new SqlParameter() { ParameterName = "@Birthday", SqlDbType = SqlDbType.DateTime, Value = dtpBirthday.SelectedDate == null ? null : dtpBirthday.SelectedDate },
                       new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

                ClearWorkForce();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('House keeping work force details saved');", true);
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

                sqlobj.ExecuteSQLNonQuery("SP_UpdatetblWorforceMaster",
                       new SqlParameter() { ParameterName = "@PersonName", SqlDbType = SqlDbType.NVarChar, Value = txtPersonName.Text },
                       new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = ddlGender.SelectedValue },
                       new SqlParameter() { ParameterName = "@TaskCategory", SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.SelectedValue },
                       new SqlParameter() { ParameterName = "@JoinDate", SqlDbType = SqlDbType.DateTime, Value = dtpJoindate.SelectedDate },
                       new SqlParameter() { ParameterName = "@ExitDate", SqlDbType = SqlDbType.DateTime, Value = dtpExitDate.SelectedDate },
                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue },
                       new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue },
                       new SqlParameter() { ParameterName = "@Wedding", SqlDbType = SqlDbType.DateTime, Value = dtpWedding.SelectedDate == null ? null : dtpWedding.SelectedDate },
                       new SqlParameter() { ParameterName = "@Birthday", SqlDbType = SqlDbType.DateTime, Value = dtpBirthday.SelectedDate == null ? null : dtpBirthday.SelectedDate },
                       new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["RSN"].ToString() }
                       );

                ClearWorkForce();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('House keeping work force details updated');", true);
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
            ClearWorkForce();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx",false);
    }
    protected void gvWorkForce_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
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

                        DataSet dsRes = sqlobj.ExecuteSP("SP_GetWorkForce",
                            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text });

                        if (dsRes.Tables[0].Rows.Count > 0)
                        {
                            txtPersonName.Text = dsRes.Tables[0].Rows[0]["PersonName"].ToString();
                            txtdesc.Text = dsRes.Tables[0].Rows[0]["Description"].ToString();
                            ddlGender.SelectedValue = dsRes.Tables[0].Rows[0]["Gender"].ToString();

                            ddlDepartment.SelectedValue = dsRes.Tables[0].Rows[0]["code"].ToString();

                            LoadCategory();

                            ddlCategory.SelectedValue = dsRes.Tables[0].Rows[0]["TaskCategory"].ToString();
                            dtpJoindate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["JoinDate"].ToString());


                            if (dsRes.Tables[0].Rows[0]["Wedding"].ToString() != "")
                            {
                                dtpWedding.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["Wedding"].ToString());
                            }
                            if (dsRes.Tables[0].Rows[0]["Birthday"].ToString() != "")
                            {
                                dtpBirthday.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["Birthday"].ToString());
                            }

                            //if (dsRes.Tables[0].Rows[0]["ExitDate"].ToString() != "")
                            //{
                            //    dtpExitDate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["ExitDate"].ToString());
                            //}
                            
                            ddlStatus.SelectedValue = dsRes.Tables[0].Rows[0]["Status"].ToString();
                            ddlType.SelectedValue = dsRes.Tables[0].Rows[0]["Type"].ToString();

                            

                            btnSave.Visible = false;
                            btnUpdate.Visible = true;
                        }

                        dsRes.Dispose();

                    }
                }
                else
                {
                    LoadWorkForce();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message);
            }
        }
        catch(Exception ex)
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

            ddlDepartment.Items.Insert(0, "--Select--");

            dsDept.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadCategory();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(btnUpdate.Visible == true)
        {
            if (ddlStatus.SelectedValue == "InActive")
            {
                dtpExitDate.Visible = true;
                lblexitdate.Visible = true;
            }
            else
            {
                dtpExitDate.Visible = false;
                lblexitdate.Visible = false;
            }
        }

        else
        {
            dtpExitDate.Visible = false;
            lblexitdate.Visible = false;
        }
    }
}