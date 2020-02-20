using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class OutstandingAdding : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadResident();
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 154 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

    private void LoadResident()
    {
        DataSet dsResd = new DataSet();
        try
        {
            dsResd = sqlobj.ExecuteSP("SP_GenDropDownList",
                new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 9 });
            drpName.DataSource = dsResd.Tables[0];
            drpName.DataValueField = "RTRSN";
            drpName.DataTextField = "RName";
            drpName.DataBind();
            RadComboBoxItem item3 = new RadComboBoxItem();
            item3.Text = "--Select Resident--";
            item3.Value = "0";
            item3.Selected = true;
            drpName.Items.Add(item3);
            dsResd.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                if (drpName.SelectedValue == "0" || string.IsNullOrEmpty(txtOpeningbalance.Text))
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Resident and Enter opening balance.');", true);
                    return;
                }
                DataSet ds = sqlobj.ExecuteSP("SP_OUTSTANDING",
                           new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue },
                            new SqlParameter() { ParameterName = "@Amount", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(txtOpeningbalance.Text) }
                         );
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Updated successfully.');", true);
                btnClear_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please enter valid amount (numeric only)');", true);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            drpName.SelectedValue = "0";
            txtOpeningbalance.Text = "";
            lblDetails.Visible = false;
        }
        catch (Exception ex)
        {

        }
    }
    protected void drpName_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            StringBuilder str = new StringBuilder();
            if (drpName.SelectedValue != "0")
            {
                DataSet dsDetails = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() });

                if (dsDetails.Tables[0].Rows.Count > 0)
                {
                    if (dsDetails.Tables[1].Rows.Count > 0)
                    {
                        foreach (DataRow row in dsDetails.Tables[1].Rows)
                        {
                            str.Append("" + row["RTNAME"] + ",");
                        }
                        str.Remove(str.Length - 1, 1);
                    }

                    lblDetails.Visible = true;
                    Session["Account"] = dsDetails.Tables[0].Rows[0]["GLAccount"].ToString();
                    lblDetails.Text = dsDetails.Tables[0].Rows[0]["GLAccount"].ToString() + " - " + str.ToString();
                }
                else
                {
                    lblDetails.Visible = false;
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Resident, And Try Again.');", true);
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
}