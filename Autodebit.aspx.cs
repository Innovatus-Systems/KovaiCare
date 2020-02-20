using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Net.Mail;
using System.Data.SqlClient;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Configuration;
using System.Text;
using Telerik.Web.UI;
using System.Reflection;

public partial class Autodebit : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        rwEditAutoDebits.VisibleOnPageLoad = true;
        rwEditAutoDebits.Visible = false;
        if (!IsPostBack)
        {
            LoadTitle();
            LoadResidentDet();
            Status();
            LoadAutoDebits();
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 131 });
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

    protected void LoadResidentDet()
    {
        try
        {
            DataSet dsResident = new DataSet();
            if (!chkAll.Checked)
            {
                dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                  new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = 1 });
            }
            else
            {
                dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 9 },
                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = 1 });
            }
            
            
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
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void Status()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistStatus = new DataSet();
            ddlistStatus = sqlobj.ExecuteSP("SP_FetchStatusDropDown",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
            ddlStatus.DataSource = ddlistStatus.Tables[0];
            ddlStatus.DataValueField = "SCode";
            ddlStatus.DataTextField = "SDescription";
            ddlStatus.DataBind();
            ddlStatus.Dispose();
            ddlStatus.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    private void LoadAutoDebits()
    {
        try
        {
            DataSet dsAutodebits = new DataSet();
            if (chkstatus.Checked == true)
            {
                 dsAutodebits = sqlobj.ExecuteSP("SP_GetResidentAutoDebits",
                  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue == "0" || cmbResident.SelectedValue == "" ? null : cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 }
                  );
            }
            else
            {
                 dsAutodebits = sqlobj.ExecuteSP("SP_GetResidentAutoDebits",
                  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue == "0" || cmbResident.SelectedValue == "" ? null : cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 }
                  );
            }
            if (dsAutodebits.Tables[0].Rows.Count > 0)
            {
                rgAutoDebits.DataSource = dsAutodebits;
                rgAutoDebits.DataBind();
            }
            else
            {
                rgAutoDebits.DataSource = string.Empty;
                rgAutoDebits.DataBind();
            }
            dsAutodebits.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnGO_Click(object sender, EventArgs e)
    {
        LoadAutoDebits();
    }

    protected void rgAutoDebits_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "win",
           "<script language='javascript'> var iMyWidth;var iMyHeight;  window.open('PostMMTEdit.aspx?NO=" + Session["RSN"] + "','NewWin','status=no,height=300,width=500 ,resizable=No,left=200,top=100,screenX=250,screenY=250,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no,   NewWin.focus()')</script>", false);
                }
            }
            else
            {
                LoadAutoDebits();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void UpdatePanel_Unload(object sender, EventArgs e)
    {
        MethodInfo methodInfo = typeof(ScriptManager).GetMethods(BindingFlags.NonPublic | BindingFlags.Instance)
            .Where(i => i.Name.Equals("System.Web.UI.IScriptManagerInternal.RegisterUpdatePanel")).First();
        methodInfo.Invoke(ScriptManager.GetCurrent(Page),
            new object[] { sender as UpdatePanel });
    }

    private void ClearUpdate()
    {
        try
        {
            lblDoorNo.Text = "";
            lblName.Text = "";
            lblaccountno.Text = "";
            lbldob.Text = "";

            ddlStatus.SelectedIndex = 0;
            txtMCharge.Text = "";
            txtkoc.Text = "";
            ddlDType.SelectedIndex = 0;
            //ddlwaiver.SelectedIndex = 0;

            //dtpstartdate.SelectedDate = null;

            //dtpenddate.SelectedDate = null;

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
                sqlobj.ExecuteNonQuery("SP_UpdateAutoDebitDetails",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = hbtnRSN.Value },
                new SqlParameter() { ParameterName = "@MMC", SqlDbType = SqlDbType.Decimal, Value = txtMCharge.Text },
                new SqlParameter() { ParameterName = "@KOC", SqlDbType = SqlDbType.Decimal, Value = txtkoc.Text },
                new SqlParameter() { ParameterName = "@DType", SqlDbType = SqlDbType.NVarChar, Value =ddlDType.SelectedValue.ToString() },
                //new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.DateTime, Value = dtpstartdate.SelectedDate == null ? null : dtpstartdate.SelectedDate },
                //new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.DateTime, Value = dtpenddate.SelectedDate == null ? null : dtpenddate.SelectedDate },
                new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue }
                );
                LoadAutoDebits();
                ClearUpdate();
                WebMsgBox.Show("Resident auto debit details successfully updated.");
                rwEditAutoDebits.Visible = false;
               
                // ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Resident auto debit details successfully updated.');", true);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            rwEditAutoDebits.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgAutoDebits_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgAutoDebits.FilterMenu;
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


    protected void chkstatus_CheckedChanged(object sender, EventArgs e)
    {
        DataSet dsAutodebits = new DataSet();
        if (chkstatus.Checked == true)
        {
            dsAutodebits = sqlobj.ExecuteSP("SP_GetResidentAutoDebits",
             new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue == "0" || cmbResident.SelectedValue == "" ? null : cmbResident.SelectedValue },
              new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 }
             );
        }
        else
        {
            dsAutodebits = sqlobj.ExecuteSP("SP_GetResidentAutoDebits",
             new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue == "0" || cmbResident.SelectedValue == "" ? null : cmbResident.SelectedValue },
              new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 }
             );
        }
        if (dsAutodebits.Tables[0].Rows.Count > 0)
        {
            rgAutoDebits.DataSource = dsAutodebits;
            rgAutoDebits.DataBind();
        }
        else
        {
            rgAutoDebits.DataSource = string.Empty;
            rgAutoDebits.DataBind();
        }
        dsAutodebits.Dispose();
    }
    protected void chkAll_CheckedChanged(object sender, EventArgs e)
    {
        LoadResidentDet();
    }
}