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

public partial class BookingLkup : System.Web.UI.Page
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

            rwFacilityGroup.VisibleOnPageLoad = true;
            rwFacilityGroup.Visible = false;


            if (!IsPostBack)
            {
                LoadTitle();

                LoadBookingLkup();

                LoadFacilityGroup();
                
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 118 });


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

    private void LoadFacilityGroup()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_FacilityGroup",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 });

            ddlBookingType.Items.Clear();

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                rgFacilityGroup.DataSource = dsCategory;
                rgFacilityGroup.DataBind();

                ddlBookingType.DataSource = dsCategory;
                ddlBookingType.DataTextField = "FacilityGroup";
                ddlBookingType.DataValueField = "RSN";
                ddlBookingType.DataBind();

            }
            else
            {
                rgFacilityGroup.DataSource = string.Empty;
                rgFacilityGroup.DataBind();
            }

            ddlBookingType.Items.Insert(0,"--Select--");

            dsCategory.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadBookingLkup()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_BookingLkup",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3});

            if (dsCategory.Tables[0].Rows.Count > 0)
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


                sqlobj.ExecuteSQLNonQuery("SP_BookingLkup",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                       new SqlParameter() { ParameterName = "@BookingType", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingType.SelectedValue},
                       new SqlParameter() { ParameterName = "@BookingFor", SqlDbType = SqlDbType.NVarChar, Value = txtBookingfor.Text},
                       new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                    
                       );

                Clear();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Booking Lookup details saved');", true);
            }



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
            ddlBookingType.SelectedIndex = 0;
            txtBookingfor.Text = "";
            txtRemarks.Text = "";

            LoadBookingLkup();

            btnSave.Visible = true;
            btnUpdate.Visible = false;
           
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {


            sqlobj.ExecuteSQLNonQuery("SP_BookingLkup",
                   new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.NVarChar, Value = 2 },
                   new SqlParameter() { ParameterName = "@BookingType", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingType.SelectedValue },
                   new SqlParameter() { ParameterName = "@BookingFor", SqlDbType = SqlDbType.NVarChar, Value = txtBookingfor.Text },
                   new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                   new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                   new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["RSN"].ToString() }

                   );

            Clear();

            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Booking Lookup details updated');", true);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx", false);
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

                    DataSet dsRes = sqlobj.ExecuteSP("SP_BookingLkup",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text },
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.BigInt, Value = 4 }
                        );

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {
                        ddlBookingType.SelectedValue = dsRes.Tables[0].Rows[0]["BookingType"].ToString();
                        txtBookingfor.Text = dsRes.Tables[0].Rows[0]["BookingFor"].ToString();
                        txtRemarks.Text = dsRes.Tables[0].Rows[0]["Remarks"].ToString();

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
    protected void btnGroupSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(txtFacilityGroup.Text))
            {
                sqlobj.ExecuteSQLNonQuery("SP_FacilityGroup",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.NVarChar, Value = 1 },
                  new SqlParameter() { ParameterName = "@FacilityGroup", SqlDbType = SqlDbType.NVarChar, Value = txtFacilityGroup.Text },
                  new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                  );
                LoadFacilityGroup();
                rwFacilityGroup.Visible = true;
                GroupClear();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Facility Group successfully added.');", true);                
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide Group.');", true);
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnShowFacilityGroup_Click(object sender, EventArgs e)
    {
        try
        {
            rwFacilityGroup.Visible = true;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void GroupClear()
    {
        try
        {
            txtFacilityGroup.Text = "";

            rwFacilityGroup.Visible = true;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnGroupClear_Click(object sender, EventArgs e)
    {
        try
        {
            GroupClear();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}