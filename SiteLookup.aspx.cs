using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class SiteLookup : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadTitle();
            LoadSiteName();


            btnSave.Visible = true;
            btnUpdate.Visible = false;
        }

    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 82 });


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

    private void LoadSiteName()
    {
        try
        {
            DataSet dsLoadSite = sqlobj.ExecuteSP("SP_LoadSitelkup");


            if (dsLoadSite.Tables[0].Rows.Count > 0)
            {
                rgSite.DataSource = dsLoadSite;
                rgSite.DataBind();
            }
            else
            {
                rgSite.DataSource = string.Empty;
                rgSite.DataBind();
            }

            dsLoadSite.Dispose();
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

                sqlobj.ExecuteSP("SP_InsertSitelkup",
                  new SqlParameter() { ParameterName = "@SiteName", SqlDbType = SqlDbType.NVarChar, Value = txtSiteName.Text },
                  new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                  new SqlParameter() { ParameterName = "@IsVilla", SqlDbType = SqlDbType.NVarChar, Value = ddlVilla.SelectedValue },
                  new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                  );



                LoadSiteName();
                ClearSiteName();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('SiteName added successfully');", true);

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
            if (CnfResult.Value == "true")
            {

                sqlobj.ExecuteSP("SP_UpdateSitelkup",
                  new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() }, 
                  new SqlParameter() { ParameterName = "@SiteName", SqlDbType = SqlDbType.NVarChar, Value = txtSiteName.Text },
                  new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                  new SqlParameter() { ParameterName = "@IsVilla", SqlDbType = SqlDbType.NVarChar, Value = ddlVilla.SelectedValue },
                  new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                  );



                LoadSiteName();
                ClearSiteName();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('SiteName updated successfully');", true);

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
            ClearSiteName();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void ClearSiteName()
    {
        try
        {
            txtSiteName.Text = "";
            txtdesc.Text = "";
            ddlVilla.SelectedIndex = 0;

            btnSave.Visible = true;
            btnUpdate.Visible = false;
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
            Response.Redirect("Dashboard.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgSite_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "UpdateRow")
            {
                Session["RSN"] = e.CommandArgument.ToString();


                DataSet dsGetSite = sqlobj.ExecuteSP("SP_GetSitelkup", new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() });


                if (dsGetSite.Tables[0].Rows.Count > 0)
                {
                    txtSiteName.Text = dsGetSite.Tables[0].Rows[0]["SiteName"].ToString();
                    txtdesc.Text = dsGetSite.Tables[0].Rows[0]["Description"].ToString();
                    ddlVilla.SelectedValue = dsGetSite.Tables[0].Rows[0]["IsVilla"].ToString();

                    btnSave.Visible = false;
                    btnUpdate.Visible = true;

                }

                dsGetSite.Dispose();

            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}