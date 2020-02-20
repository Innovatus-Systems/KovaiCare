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

public partial class DiningHealthCheck : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadBilling();
            LoadDiningDet();
            LoadGrid();

        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 125 });


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

    public void LoadBilling()
    {
        try
        {
            DataSet dsBilling = new DataSet();
            dsBilling = sqlobj.ExecuteSP("Proc_LoadBilling");
            if (dsBilling.Tables[0].Rows.Count > 0)
            {
                ddlBilling.DataSource = dsBilling.Tables[0];
                ddlBilling.DataTextField = "BPName";
                ddlBilling.DataValueField = "RSN";
                ddlBilling.DataBind();
            }           
        }
        catch (Exception ex)
        {
        }
    }

    protected void LoadGrid()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_DiningHealthCheck",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@BillPeriod", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(ddlBilling.SelectedValue) },
                new SqlParameter() { ParameterName = "@Type", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Convert.ToDecimal(ddlType.SelectedValue) });
            
            ReportList.DataSource = dsGroup.Tables[0];
            ReportList.DataBind();
            dsGroup.Dispose();

            txtHSTot.Text = "Confirmation Pending (" + dsGroup.Tables[1].Rows[0]["TotCnt"].ToString() + ")";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }

    }

    protected void LoadDiningDet()
    {
        try
        {   

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsCSEdit = null;
            dsCSEdit = sqlobj.ExecuteSP("SP_DiningHealthCheck",
                 new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2},
                 new SqlParameter() { ParameterName = "@BillPeriod", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(ddlBilling.SelectedValue) });


            //ddlAssignedBy.SelectedValue = dsCSEdit.Tables[0].Rows[0]["AssignedBy"].ToString();
            txtResTot.Text  = dsCSEdit.Tables[0].Rows[0]["ResTot"].ToString();
            txtDinTot.Text = dsCSEdit.Tables[0].Rows[0]["DinTot"].ToString();
            txtRDTot.Text = dsCSEdit.Tables[0].Rows[0]["RDTot"].ToString();
            txtCDTot.Text = dsCSEdit.Tables[0].Rows[0]["CDTot"].ToString();
            

        }
        catch (Exception qr)
        {
            throw qr;
        }
    }

    protected void chkRegularBAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridDataItem item in ReportList.MasterTableView.Items)
        {
            CheckBox chkbx = (CheckBox)item["All"].FindControl("ChkRegularBConfirm");
            chkbx.Checked = !chkbx.Checked;
        }
    }

    protected void chkCasualBAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridDataItem item in ReportList.MasterTableView.Items)
        {
            CheckBox chkbx = (CheckBox)item["All"].FindControl("ChkCasualBConfirm");
            chkbx.Checked = !chkbx.Checked;
        }
    }

    protected void chkGuestBAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridDataItem item in ReportList.MasterTableView.Items)
        {
            CheckBox chkbx = (CheckBox)item["All"].FindControl("ChkGuestBConfirm");
            chkbx.Checked = !chkbx.Checked;
        }
    }

    protected void chkHServiceBAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridDataItem item in ReportList.MasterTableView.Items)
        {
            CheckBox chkbx = (CheckBox)item["All"].FindControl("ChkHServiceBConfirm");
            chkbx.Checked = !chkbx.Checked;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                int ChkSel=0;
                foreach (GridItem rw in ReportList.Items)
                {
                    int RTRSN = Convert.ToInt32(rw.Cells[2].Text);

                    CheckBox Check = (CheckBox)rw.FindControl("ChkRegularBConfirm");
                    CheckBox Check2 = (CheckBox)rw.FindControl("ChkRegularBConfirm");
                    CheckBox Check3 = (CheckBox)rw.FindControl("ChkGuestBConfirm");
                    CheckBox Check4 = (CheckBox)rw.FindControl("ChkHServiceBConfirm");

                    //if (Check.Checked == true || Check2.Checked == true || Check3.Checked == true || Check4.Checked == true)

                    if (Check.Checked == true && ddlType.SelectedValue == "2")
                    {
                        sqlobj.ExecuteSQLNonQuery("[SP_DiningHealthCheck]",
                                new SqlParameter() { ParameterName = "@iMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                                new SqlParameter() { ParameterName = "@SActuals", SqlDbType = SqlDbType.NVarChar, Value = "RB" },
                                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = RTRSN });
                        ChkSel = 1;
                    }

                   
                    if (Check2.Checked == true && ddlType.SelectedValue == "3")
                    {
                        sqlobj.ExecuteSQLNonQuery("[SP_DiningHealthCheck]",
                                new SqlParameter() { ParameterName = "@iMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                                new SqlParameter() { ParameterName = "@SActuals", SqlDbType = SqlDbType.NVarChar, Value = "CB" },
                                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = RTRSN });
                        ChkSel = 1;
                    }

                    
                    if (Check3.Checked == true)
                    {
                        sqlobj.ExecuteSQLNonQuery("[SP_DiningHealthCheck]",
                                new SqlParameter() { ParameterName = "@iMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                                new SqlParameter() { ParameterName = "@SActuals", SqlDbType = SqlDbType.NVarChar, Value = "GB" },
                                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = RTRSN });
                        ChkSel = 1;
                    }

                   
                    if (Check4.Checked == true)
                    {
                        sqlobj.ExecuteSQLNonQuery("[SP_DiningHealthCheck]",
                                new SqlParameter() { ParameterName = "@iMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                                new SqlParameter() { ParameterName = "@SActuals", SqlDbType = SqlDbType.NVarChar, Value = "SB" },
                                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = RTRSN });
                        ChkSel = 1;
                    }

                }

                if (ChkSel == 0)
                {
                    WebMsgBox.Show("Please select the pending details");
                }
                else
                {
                    WebMsgBox.Show("Updated successfully");
                }
                
                LoadGrid();

            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadGrid();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlBilling_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadDiningDet();
            LoadGrid();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


}