using System;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Telerik.Web.UI;


public partial class DeleteUnbilledTxn : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    StringBuilder SB1 = new StringBuilder();
    StringBuilder SB = new StringBuilder();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            LoadResidentDet();
            LoadTitle();
            LoadDropDown();
            lblnm.Visible = false;
            lblSpace.Visible = false;
            lblDrNo.Visible = false;
            LabelAccNo.Visible = false;
            lblAccNo.Visible = false;
            rgAdHoc.DataSource = string.Empty;
            rgAdHoc.DataBind();            
        }
    }
    protected void LoadResidentDet()
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_AdHocInvoice",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 }
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
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadDropDown()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_AdHocInvoice", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                drpService.DataSource = dsTitle.Tables[0];
                drpService.DataTextField = "STDTEXT";
                drpService.DataValueField = "TXNCODE";
                drpService.DataBind();
                drpService.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Please Select", "0"));
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void CheckCheckBox()
    {
        try
        {
            //chkShow_CheckedChanged(sender, e);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 161 });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void cmbResident_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsDetails = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                lblnm.Text = dsDetails.Tables[0].Rows[0]["RtName"].ToString();
                lblDrNo.Text = dsDetails.Tables[0].Rows[0]["RTVillaNo"].ToString();
                lblAccNo.Text = dsDetails.Tables[0].Rows[0]["GLAccount"].ToString();
                lblnm.Visible = true;
                //LabelName.Visible = true;
                //LabelDrNo.Visible = true;
                lblSpace.Visible = true;
                lblDrNo.Visible = true;
                LabelAccNo.Visible = true;
                lblAccNo.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            string sb = string.Empty;
            int count = 0;
            if (cmbResident.SelectedValue == "0" || cmbResident.SelectedValue == "" || drpService.SelectedValue == "0" || drpService.SelectedValue == "")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please select Resident and TXN. Type.');", true);
                return;
            }
            foreach (GridDataItem item in rgAdHoc.MasterTableView.Items)
            {
                if (item.Selected)
                {
                    count = count + 1;
                }
            }
            if (count > 0)
            {
                foreach (GridDataItem rw in rgAdHoc.MasterTableView.Items)
                {
                    if (rw.Selected)
                    {
                        string Ref = Convert.ToString(rw.GetDataKeyValue("Ref").ToString());
                        SB.Clear();
                        SB.Append(Ref);
                        SB.Remove(SB.Length - 3, 3);
                        sb = " BillNo Like '" + SB + "%'" + " or ";
                        SB1.Append(sb);

                    }
                }
                SB1.Remove(SB1.Length - 3, 3);

                DataSet dsTitle = sqlobj.ExecuteSP("SP_DELETEUNBILLEDTXN",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() },
                 new SqlParameter() { ParameterName = "@Where", SqlDbType = SqlDbType.NVarChar, Value = SB1.ToString()},
                 new SqlParameter() { ParameterName = "@C_BY", SqlDbType = SqlDbType.NVarChar, Value = (Session["UserID"].ToString())},
                new SqlParameter() { ParameterName = "@TXCODE", SqlDbType = SqlDbType.NVarChar, Value = drpService.SelectedValue.ToString() }  );

                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Txn(s). Deleted Successfully');", true);
                LoadGrid();

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

    protected void chkShow_CheckedChanged(object sender, EventArgs e)
    {
        if (cmbResident.SelectedValue == "0")
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please select Resident');", true);
            chkShow.Checked = false;
            return;
        }
        if (chkShow.Checked == true)
        {
            btnDelete.Visible = false;
            btnSearch.Visible = false;
            LoadArci();
        }
        if (chkShow.Checked == false)
        {
            btnDelete.Visible = true;
            btnSearch.Visible = true;
            LoadGrid();
        }
    }
    private void LoadArci()
    {

        try
        {
            if (cmbResident.SelectedValue == "0")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please select Resident');", true);
                return;
            }
            DataSet dsTitle = sqlobj.ExecuteSP("SP_DELETEUNBILLEDTXN",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                rgAdHoc.DataSource = dsTitle.Tables[0];
                rgAdHoc.DataBind();
            }
            else
            {
                rgAdHoc.DataSource = string.Empty;
                rgAdHoc.DataBind();
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There is no Billed transaction(s).');", true);
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadGrid()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_DELETEUNBILLEDTXN",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() },
                //new SqlParameter() { ParameterName = "@Where", SqlDbType = SqlDbType.NVarChar, Value = SB1.ToString()},
                new SqlParameter() { ParameterName = "@TXCODE", SqlDbType = SqlDbType.NVarChar, Value = drpService.SelectedValue.ToString() });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                rgAdHoc.DataSource = dsTitle.Tables[0];
                rgAdHoc.DataBind();
            }
            else
            {
                rgAdHoc.DataSource = string.Empty;
                rgAdHoc.DataBind();
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There is no Unbilled transaction(s).');", true);
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void rgAdHoc_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {

    }

    protected void rgAdHoc_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid();
    }

    protected void rgAdHoc_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgAdHoc.FilterMenu;
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

    protected void drpService_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        
        try
        {
            if (cmbResident.SelectedValue == "0" || cmbResident.SelectedValue == "" || drpService.SelectedValue == "0" || drpService.SelectedValue == "")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please select Resident and Invoice Type.');", true);
                return;
            }
            cmbResident.Enabled = false;
            drpService.Enabled = false;
            LoadGrid();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
  
}

    protected void btnClear_Click(object sender, EventArgs e)
    {
        clear();
    }
    protected void clear()
    {
        try
        {
            cmbResident.Enabled = true;
            drpService.Enabled = true;
            chkShow.Checked = false;
            cmbResident.SelectedValue = "0";
            drpService.SelectedValue = "0";
            lblnm.Visible = false;
            lblSpace.Visible = false;
            lblDrNo.Visible = false;
            LabelAccNo.Visible = false;
            lblAccNo.Visible = false;
            rgAdHoc.DataSource = string.Empty;
            rgAdHoc.DataBind();
            btnSearch.Visible = true;
            btnDelete.Visible = true;
                 
        }
        catch (Exception ex)
        {

        }
    }
}