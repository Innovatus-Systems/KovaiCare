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

public partial class VehicleMaster : System.Web.UI.Page
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

            rwVehicleType.VisibleOnPageLoad = true;
            rwVehicleType.Visible = false;



            if (!IsPostBack)
            {
                LoadTitle();

                LoadVehicleType();

                LoadVehicleMaster();

                btnUpdate.Visible = false;
                btnSave.Visible = true;
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 122 });


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

    private void LoadVehicleType()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_VehicleType",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });

            ddlVehicleType.Items.Clear();

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                rgVehicleType.DataSource = dsCategory;
                rgVehicleType.DataBind();

                ddlVehicleType.DataSource = dsCategory;
                ddlVehicleType.DataTextField = "Type";
                ddlVehicleType.DataValueField = "RSN";
                ddlVehicleType.DataBind();

            }
            else
            {
                rgVehicleType.DataSource = string.Empty;
                rgVehicleType.DataBind();
            }

            ddlVehicleType.Items.Insert(0, "--Select--");

            dsCategory.Dispose();

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadVehicleMaster()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_VMaster",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                gvVehicleMaster.DataSource = dsCategory;
                gvVehicleMaster.DataBind();
            }
            else
            {
                gvVehicleMaster.DataSource = string.Empty;
                gvVehicleMaster.DataBind();
            }

            dsCategory.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void Clear()
    {
        try
        {
            txtVehicleCode.Text = string.Empty;
            txtVehicleNo.Text = string.Empty;
            ddlVehicleType.SelectedIndex = 0;
            ddlVehicleStatus.SelectedIndex = 0;

            LoadVehicleMaster();

            btnUpdate.Visible = false;
            btnSave.Visible = true;

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


                sqlobj.ExecuteSQLNonQuery("SP_VMaster",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                       new SqlParameter() { ParameterName = "@VechicleCode", SqlDbType = SqlDbType.NVarChar, Value = txtVehicleCode.Text },
                       new SqlParameter() { ParameterName = "@VechicleNo", SqlDbType = SqlDbType.NVarChar, Value = txtVehicleNo.Text },
                       new SqlParameter() { ParameterName = "@VechicleType", SqlDbType = SqlDbType.NVarChar, Value = ddlVehicleType.SelectedValue },
                       new SqlParameter() { ParameterName = "@VStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlVehicleStatus.SelectedValue },
                       new SqlParameter() { ParameterName = "@VRemarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                       );

                Clear();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Vehicle Master details saved');", true);
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


                sqlobj.ExecuteSQLNonQuery("SP_VMaster",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@VechicleCode", SqlDbType = SqlDbType.NVarChar, Value = txtVehicleCode.Text },
                       new SqlParameter() { ParameterName = "@VechicleNo", SqlDbType = SqlDbType.NVarChar, Value = txtVehicleNo.Text },
                       new SqlParameter() { ParameterName = "@VechicleType", SqlDbType = SqlDbType.NVarChar, Value = ddlVehicleType.SelectedValue },
                       new SqlParameter() { ParameterName = "@VStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlVehicleStatus.SelectedValue },
                       new SqlParameter() { ParameterName = "@VRemarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Session["RSN"].ToString() }

                       );

                Clear();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Vehicle Master details Updated');", true);
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx");
    }
    protected void gvVehicleMaster_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
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

                    DataSet dsRes = sqlobj.ExecuteSP("SP_VMaster",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text },
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.BigInt, Value = 4 }
                        );

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {

                        txtVehicleCode.Text = dsRes.Tables[0].Rows[0]["VehicleCode"].ToString();
                        ddlVehicleType.SelectedValue = dsRes.Tables[0].Rows[0]["VehicleType"].ToString();
                        ddlVehicleStatus.SelectedValue = dsRes.Tables[0].Rows[0]["VStatus"].ToString();
                        txtVehicleNo.Text = dsRes.Tables[0].Rows[0]["VehicleNo"].ToString();
                        txtRemarks.Text = dsRes.Tables[0].Rows[0]["VRemarks"].ToString();

                        btnSave.Visible = false;
                        btnUpdate.Visible = true;
                    }

                    dsRes.Dispose();


                }
            }
            else
            {
                LoadVehicleMaster();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvVehicleMaster_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvVehicleMaster.FilterMenu;
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

    private void TypeClear()
    {
        txtType.Text = "";

    }

    protected void btnTypeSave_Click(object sender, EventArgs e)
    {
        try
        {
            sqlobj.ExecuteSQLNonQuery("SP_VehicleType",
                   new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.NVarChar, Value = 1 },
                   new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = txtType.Text },
                   new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                   );



            LoadVehicleType();

            rwVehicleType.Visible = true;

            TypeClear();

            WebMsgBox.Show("Vehicle Type successfully added.");


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnTypeClear_Click(object sender, EventArgs e)
    {
        TypeClear();
    }
    protected void btnShowVehicleType_Click(object sender, EventArgs e)
    {
        try
        {
            rwVehicleType.Visible = true;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}