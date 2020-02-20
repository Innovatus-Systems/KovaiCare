using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Drawing;
using Telerik.Web.UI;
using System.IO;
using System.Text;

public partial class DinersNotes : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    string Name = string.Empty;
    string AccountCode = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dtDate.SelectedDate = DateTime.Now;
            dtDate.MinDate = DateTime.Now;
            rdtFrom.SelectedDate = DateTime.Now;
            rdtTill.SelectedDate = DateTime.Now.AddDays(7);
            rdtTill.MinDate = Convert.ToDateTime(rdtFrom.SelectedDate);
            rdtFrom.MaxDate = Convert.ToDateTime(rdtTill.SelectedDate);
            rgDinNts.DataSource = string.Empty;
            rgDinNts.DataBind();
            LoadTitle();
            LoadSession();
            LoadNotesType();
            LoadData();            
            LoadDNotesFilter();
            Clear();
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 148 });


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
    private void LoadData()
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_DinersNotes",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 }
                    );
            if (ds.Tables[0].Rows.Count > 0)
            {

                rgDinNts.DataSource = ds.Tables[0];
                rgDinNts.DataBind();
            }
            else
            {
                rgDinNts.DataSource = string.Empty;
                rgDinNts.DataBind();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadSession()
    {
        DataSet dsFetchSE = new DataSet();
        try
        {
            dsFetchSE = sqlobj.ExecuteSP("SP_GetSessionforDining",
                new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
            drpSession.DataSource = dsFetchSE.Tables[0];
            drpSession.DataValueField = "SessionCode";
            drpSession.DataTextField = "SessionName";
            drpSession.DataBind();
            drpSession.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));
            drpSession.Items.Insert(1, new System.Web.UI.WebControls.ListItem("All", "99"));
            dsFetchSE.Dispose();

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            if (drpForWhom.SelectedValue == "R")
            {
                lblDN.Visible = true;
                txtAccCd.Visible = true;
                txtName.Visible = true;
                DataSet dsDetails = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });
                txtName.Text = dsDetails.Tables[0].Rows[0]["RtName"].ToString();
                txtAccCd.Text = dsDetails.Tables[0].Rows[0]["GLAccount"].ToString();
                lblDN.Text = " - ";
                Name = dsDetails.Tables[0].Rows[0]["RtName"].ToString();
                AccountCode = dsDetails.Tables[0].Rows[0]["GLAccount"].ToString();

            }
            if (drpForWhom.SelectedValue == "G")
            {
                lblDN.Visible = true;
                txtAccCd.Visible = true;
                txtName.Visible = true;
                DataSet dsDetails = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 11 },
                  new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });
                txtName.Text = dsDetails.Tables[1].Rows[0]["Name"].ToString();
                txtAccCd.Text = dsDetails.Tables[1].Rows[0]["AccountCode"].ToString();
                lblDN.Text = " - ";
                Name = dsDetails.Tables[0].Rows[1]["Name"].ToString();
                AccountCode = dsDetails.Tables[1].Rows[0]["AccountCode"].ToString();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void LoadDNotesFilter()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = sqlobj.ExecuteSP("SP_DinersNotes",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 }
                );
            drpDTypeFilter.DataSource = ds.Tables[0];
            drpDTypeFilter.DataValueField = "DNCODE";
            drpDTypeFilter.DataTextField = "DNDESC";
            drpDTypeFilter.DataBind();
            drpDTypeFilter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
            ds.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void LoadNotesType()
    {
        try
        {
            DataSet ds = new DataSet();
            ds = sqlobj.ExecuteSP("SP_DinersNotes",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 }
                );

            drpNotesType.DataSource = ds.Tables[0];
            drpNotesType.DataValueField = "DNCODE";
            drpNotesType.DataTextField = "DNDESC";
            drpNotesType.DataBind();
            drpNotesType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));
            ds.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void LoadResidentDet()
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 }
                );
            cmbResident.DataSource = dsResident.Tables[0];
            cmbResident.DataValueField = "RTRSN";
            cmbResident.DataTextField = "RName";
            cmbResident.DataBind();
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbResident.Items.Add(item2);
            dsResident.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void LoadGuestHouseDet()
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 7 }
                );
            cmbResident.DataSource = dsResident.Tables[0];
            cmbResident.DataValueField = "AccountCode";
            cmbResident.DataTextField = "GName";
            cmbResident.DataBind();
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbResident.Items.Add(item2);
            dsResident.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }


    protected void drpForWhom_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (drpForWhom.SelectedValue == "R")
            {
                cmbResident.EmptyMessage = "Type Resident Name/Door Number to Search";
                cmbResident.Visible = true;
                lblName.Visible = true;
                lblStName.Visible = false;
                txtStName.Visible = false;
                LoadResidentDet();
            }
            if (drpForWhom.SelectedValue == "G")
            {
                cmbResident.EmptyMessage = "Type Guest Name To Search";
                cmbResident.Visible = true;
                lblName.Visible = true;
                lblStName.Visible = false;
                txtStName.Visible = false;
                LoadGuestHouseDet();
            }
            if (drpForWhom.SelectedValue == "S" || drpForWhom.SelectedValue == "O")
            {
                lblName.Visible = false;
                cmbResident.Visible = false;
                lblStName.Visible = true;
                txtStName.Visible = true;
                txtStName.Width = 220;
            }
            if (drpForWhom.SelectedValue == "0")
            {
                lblName.Visible = false;
                cmbResident.Visible = false;
                lblStName.Visible = false;
                txtStName.Visible = false;
                //txtStName.Width = 220;

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkEdit = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdit.NamingContainer;
            string RSN = row.Cells[11].Text;
            Session["RSN"] = RSN.ToString();
            string ForWhom = row.Cells[7].Text;
            btnSave.Visible = false;
            btnUpdate.Visible = true;
            DataSet ds = sqlobj.ExecuteSP("SP_DinersNotes",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 5 },
                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(RSN) }
                );
            dtDate.SelectedDate = DateTime.Parse(ds.Tables[1].Rows[0]["Date"].ToString());
            drpSession.SelectedValue = ds.Tables[1].Rows[0]["Session"].ToString();
            drpNotesType.SelectedValue = ds.Tables[1].Rows[0]["DNCode"].ToString();
            drpForWhom.SelectedValue = ds.Tables[1].Rows[0]["ForWhom"].ToString();
            if (drpForWhom.SelectedValue == "R")
            {
                LoadResidentDet();
                cmbResident.SelectedValue = ds.Tables[1].Rows[0]["RTRSN"].ToString();
            }
            if (drpForWhom.SelectedValue == "G")
            {
                LoadGuestHouseDet();
                cmbResident.SelectedValue = ds.Tables[1].Rows[0]["GHG_ID"].ToString();
            }
            txtName.Text = ds.Tables[1].Rows[0]["DN_NAME"].ToString();
            txtAccCd.Text = ds.Tables[1].Rows[0]["GHG_ID"].ToString();
            txtSplNotes.Text = ds.Tables[1].Rows[0]["DNNOTES"].ToString();
            txtStName.Text = ds.Tables[1].Rows[0]["DN_NAME"].ToString();
            if (drpForWhom.SelectedValue == "R" || drpForWhom.SelectedValue == "G")
            {
                cmbResident.Visible = true;
                txtName.Visible = true;
                txtAccCd.Visible = true;
                txtStName.Visible = false;
                lblStName.Visible = false;
            }
            if (drpForWhom.SelectedValue == "S" || drpForWhom.SelectedValue == "O")
            {
                cmbResident.Visible = false;
                txtName.Visible = false;
                txtAccCd.Visible = false;
                txtStName.Visible = true;
                lblStName.Visible = true;
            }

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (drpSession.SelectedValue == "0" || drpForWhom.SelectedValue == "0" || drpNotesType.SelectedValue == "0")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide all mandatory fields');", true);
                return;
            }
            if (drpForWhom.SelectedValue == "R" || drpForWhom.SelectedValue == "G")
            {
                if (cmbResident.SelectedValue == "0")
                {
                    cmbResident.Focus();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide all mandatory fields');", true);
                    return;
                }
            }
            if (drpForWhom.SelectedValue == "S" || drpForWhom.SelectedValue == "O")
            {
                if (string.IsNullOrEmpty(txtStName.Text))
                {
                    txtStName.Focus();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide all mandatory fields');", true);
                    return;
                }
            }
            if (string.IsNullOrEmpty(txtSplNotes.Text))
            {
                txtSplNotes.Focus();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide all mandatory fields');", true);
                return;
            }

            if (drpForWhom.SelectedValue == "R")
            {
                sqlobj.ExecuteSQLNonQuery("SP_DinersNotes",
                          new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                          new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                          new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = drpSession.SelectedValue },
                          new SqlParameter() { ParameterName = "@ForWhom", SqlDbType = SqlDbType.NVarChar, Value = drpForWhom.SelectedValue },
                          new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                          new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
                          new SqlParameter() { ParameterName = "@AccCd", SqlDbType = SqlDbType.NVarChar, Value = txtAccCd.Text },
                          new SqlParameter() { ParameterName = "@DNotesTy", SqlDbType = SqlDbType.NVarChar, Value = drpNotesType.SelectedValue },
                          new SqlParameter() { ParameterName = "@SplNotes", SqlDbType = SqlDbType.NVarChar, Value = txtSplNotes.Text },
                          new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                          new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Session["RSN"]) }
                          );
            }
            else
            {
                sqlobj.ExecuteSQLNonQuery("SP_DinersNotes",
                           new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                           new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                           new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = drpSession.SelectedValue },
                           new SqlParameter() { ParameterName = "@ForWhom", SqlDbType = SqlDbType.NVarChar, Value = drpForWhom.SelectedValue },
                           new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
                           new SqlParameter() { ParameterName = "@AccCd", SqlDbType = SqlDbType.NVarChar, Value = txtAccCd.Text },
                           new SqlParameter() { ParameterName = "@DNotesTy", SqlDbType = SqlDbType.NVarChar, Value = drpNotesType.SelectedValue },
                           new SqlParameter() { ParameterName = "@SplNotes", SqlDbType = SqlDbType.NVarChar, Value = txtSplNotes.Text },
                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Session["RSN"]) }
                           );
            }
            LoadData();
            Clear();
            Session["RSN"] = string.Empty;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Updated Successfully');", true);
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
            if (drpSession.SelectedValue == "0" || drpForWhom.SelectedValue == "0" || drpNotesType.SelectedValue == "0")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide all mandatory fields');", true);
                return;
            }
            if (drpForWhom.SelectedValue == "R" || drpForWhom.SelectedValue == "G")
            {
                if (cmbResident.SelectedValue == "0")
                {
                    cmbResident.Focus();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide all mandatory fields');", true);
                    return;
                }
            }
            if (drpForWhom.SelectedValue == "S" || drpForWhom.SelectedValue == "O")
            {
                if (string.IsNullOrEmpty(txtStName.Text))
                {
                    txtStName.Focus();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide all mandatory fields');", true);
                    return;
                }
            }
            if (string.IsNullOrEmpty(txtSplNotes.Text))
            {
                txtSplNotes.Focus();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide all mandatory fields');", true);
                return;
            }

            if (drpForWhom.SelectedValue == "R")
            {
                sqlobj.ExecuteSQLNonQuery("SP_DinersNotes",
                          new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                          new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                          new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = drpSession.SelectedValue },
                          new SqlParameter() { ParameterName = "@ForWhom", SqlDbType = SqlDbType.NVarChar, Value = drpForWhom.SelectedValue },
                          new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                          new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
                          new SqlParameter() { ParameterName = "@AccCd", SqlDbType = SqlDbType.NVarChar, Value = txtAccCd.Text },
                          new SqlParameter() { ParameterName = "@DNotesTy", SqlDbType = SqlDbType.NVarChar, Value = drpNotesType.SelectedValue },
                          new SqlParameter() { ParameterName = "@SplNotes", SqlDbType = SqlDbType.NVarChar, Value = txtSplNotes.Text },
                          new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                          );
            }
            else
            {
                sqlobj.ExecuteSQLNonQuery("SP_DinersNotes",
                           new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                           new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                           new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = drpSession.SelectedValue },
                           new SqlParameter() { ParameterName = "@ForWhom", SqlDbType = SqlDbType.NVarChar, Value = drpForWhom.SelectedValue },
                           new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
                           new SqlParameter() { ParameterName = "@AccCd", SqlDbType = SqlDbType.NVarChar, Value = txtAccCd.Text },
                           new SqlParameter() { ParameterName = "@DNotesTy", SqlDbType = SqlDbType.NVarChar, Value = drpNotesType.SelectedValue },
                           new SqlParameter() { ParameterName = "@SplNotes", SqlDbType = SqlDbType.NVarChar, Value = txtSplNotes.Text },
                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                           );
            }
            LoadData();
            Clear();

            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Saved Successfully');", true);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
    }
    protected void Clear()
    {
        try
        {
            dtDate.SelectedDate = DateTime.Now;
            drpSession.SelectedValue = "0";
            drpNotesType.SelectedValue = "0";
            drpForWhom.SelectedValue = "0";
            cmbResident.Visible = false;
            lblDN.Visible = false;
            lblName.Visible = false;
            lblStName.Visible = false;
            txtAccCd.Visible = false;
            txtName.Visible = false;
            txtStName.Visible = false;
            txtSplNotes.Text = "";
            btnSave.Visible = true;
            btnUpdate.Visible = false;
            rdtFrom.SelectedDate = DateTime.Now;
            rdtTill.SelectedDate = DateTime.Now.AddDays(7);
            rdtTill.MinDate = Convert.ToDateTime(rdtFrom.SelectedDate);
            rdtFrom.MaxDate = Convert.ToDateTime(rdtTill.SelectedDate);
            LoadData();
            drpDTypeFilter.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void imgbtnAdditemDetails_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "win",
    "<script language='javascript'> var iMyWidth;var iMyHeight;  window.open('DNotesTypeLkupAdd.aspx','NewWin','status=no,height=300,width=500 ,resizable=No,left=200,top=100,screenX=100,screenY=200,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no,   NewWin.focus()')</script>", false);
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            if (drpDTypeFilter.SelectedValue == "0")
            {
                ds = sqlobj.ExecuteSP("SP_DinersNotes",
                         new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 7 },
                          new SqlParameter() { ParameterName = "@From", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
                           new SqlParameter() { ParameterName = "@To", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate }
                         );
            }
            else
            {
                ds = sqlobj.ExecuteSP("SP_DinersNotes",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 8 },
                     new SqlParameter() { ParameterName = "@From", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
                      new SqlParameter() { ParameterName = "@To", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate },
                       new SqlParameter() { ParameterName = "@Filter", SqlDbType = SqlDbType.NVarChar, Value = drpDTypeFilter.SelectedValue }
                    );
            }
            if (ds.Tables[0].Rows.Count > 0)
            {

                rgDinNts.DataSource = ds.Tables[0];
                rgDinNts.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No Data,Please select more date range');", true);
                rgDinNts.DataSource = string.Empty;
                rgDinNts.DataBind();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void rdtFrom_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        rdtTill.MinDate = Convert.ToDateTime(rdtFrom.SelectedDate);
    }
    protected void rdtTill_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        rdtFrom.MaxDate = Convert.ToDateTime(rdtTill.SelectedDate);
    }
    protected void drpDTypeFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            if (drpDTypeFilter.SelectedValue != "0")
            {
                ds = sqlobj.ExecuteSP("SP_DinersNotes",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 8 },
                     new SqlParameter() { ParameterName = "@From", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
                      new SqlParameter() { ParameterName = "@To", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate },
                       new SqlParameter() { ParameterName = "@Filter", SqlDbType = SqlDbType.NVarChar, Value = drpDTypeFilter.SelectedValue }
                    );
            }
            else
            {
                ds = sqlobj.ExecuteSP("SP_DinersNotes",
                     new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 7 },
                      new SqlParameter() { ParameterName = "@From", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
                       new SqlParameter() { ParameterName = "@To", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate }
                     );
            }
            if (ds.Tables[0].Rows.Count > 0)
            {

                rgDinNts.DataSource = ds.Tables[0];
                rgDinNts.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No Data,Please select more date range or Please try with some other Filter options.');", true);
                rgDinNts.DataSource = string.Empty;
                rgDinNts.DataBind();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
}