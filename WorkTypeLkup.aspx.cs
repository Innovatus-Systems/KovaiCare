using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class WorkTypeLkup : System.Web.UI.Page
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 115 });


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
            DataSet dsLoadProvisionType = sqlobj.ExecuteSP("SP_WorkType", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 }
                );


            if (dsLoadProvisionType.Tables[0].Rows.Count > 0)
            {
                rgProvision.DataSource = dsLoadProvisionType;
                rgProvision.DataBind();
            }
            else
            {
                rgProvision.DataSource = string.Empty;
                rgProvision.DataBind();
            }

            dsLoadProvisionType.Dispose();
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

                sqlobj.ExecuteSP("SP_WorkType",
                  new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
                  new SqlParameter() { ParameterName = "@WorkType", SqlDbType = SqlDbType.NVarChar, Value = txtworktype.Text },
                  new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                  new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                  );

                LoadSiteName();
                ClearSiteName();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Work Type added successfully');", true);

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

                sqlobj.ExecuteSP("SP_WorkType",
                    new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
                  new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() },
                  new SqlParameter() { ParameterName = "@WorkType", SqlDbType = SqlDbType.NVarChar, Value = txtworktype.Text },
                  new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text },
                  new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                  );



                LoadSiteName();
                ClearSiteName();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Work Type updated successfully');", true);

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
            txtworktype.Text = "";
            txtdesc.Text = "";

            btnSave.Visible = true;
            btnUpdate.Visible = false;
        }
        catch (Exception ex)
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


                DataSet dsGetSite = sqlobj.ExecuteSP("SP_WorkType",
                    new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() });


                if (dsGetSite.Tables[0].Rows.Count > 0)
                {
                    txtworktype.Text = dsGetSite.Tables[0].Rows[0]["WorkType"].ToString();
                    txtdesc.Text = dsGetSite.Tables[0].Rows[0]["Description"].ToString();

                    btnSave.Visible = false;
                    btnUpdate.Visible = true;

                }

                dsGetSite.Dispose();

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}