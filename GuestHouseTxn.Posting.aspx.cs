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

public partial class GuestHouseTxn_Posting : System.Web.UI.Page
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
            LoadResidentDet();
            LoadTxnDrp();
            lblDisable();
            //LoadGrid();
            gvTransactions.DataSource = string.Empty;
            gvTransactions.DataBind();
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 146 });
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
    private void LoadHelp()
    {
        try
        {

            DataSet dsTxn = sqlobj.ExecuteSP("SP_TxnDropDownList",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@TxnCode", SqlDbType = SqlDbType.NVarChar, Value = drpTxn.SelectedValue.ToString() });
            if (dsTxn.Tables[0].Rows.Count > 0)
            {
                lblhelp.Visible = true;
                lblhelp1.Visible = true;
                lblMsg.Visible = true;
                lblnarration.Visible = true;
                lblstdnarr.Visible = true;
                lblhelp1.Text = dsTxn.Tables[0].Rows[0]["Help"].ToString();
                lblstdnarr.Text = dsTxn.Tables[0].Rows[0]["StdNarration"].ToString();
                string msg = dsTxn.Tables[0].Rows[0]["StdDescription"].ToString();
                string CGST = dsTxn.Tables[0].Rows[0]["CGST"].ToString();
                string SGST = dsTxn.Tables[0].Rows[0]["SGST"].ToString();
                string code = dsTxn.Tables[0].Rows[0]["TxnCode"].ToString();
                string All = msg + " - " + code + "  <br/> ";
                lblMsg.Text = All;
            }


            dsTxn.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadTxnDrp()
    {
        try
        {
            DataSet dsTxn = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 7 });
            if (dsTxn.Tables[0].Rows.Count > 0)
            {
                drpTxn.DataSource = dsTxn.Tables[0];
                drpTxn.DataValueField = "TxnCode";
                drpTxn.DataTextField = "StdDescription";
                drpTxn.DataBind();
            }
            drpTxn.Items.Insert(0, "Please Select");
            dsTxn.Dispose();
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
            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 7 }
                );
            cmbResident.DataSource = dsResident.Tables[0];
            cmbResident.DataValueField = "RSN";
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
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void LoadGrid()
    {
        try
        {

            DataSet dsTransactions = sqlobj.ExecuteSP("SP_TxnDropDownList",

                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 8 },
               new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() }
               );

            if (dsTransactions.Tables[0].Rows.Count > 0)
            {
                gvTransactions.DataSource = dsTransactions.Tables[0];
                gvTransactions.DataBind();
            }
            else
            {
                gvTransactions.DataSource = string.Empty;
                gvTransactions.DataBind();
            }
            dsTransactions.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void drpTxn_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadHelp();
            DataSet dstxnCode = sqlobj.ExecuteSP("SP_TxnDropDownList",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@TxnCode", SqlDbType = SqlDbType.NVarChar, Value = drpTxn.SelectedValue.ToString() });
            if (dstxnCode.Tables[0].Rows.Count > 0)
            {
                lblCgst1.Text = dstxnCode.Tables[0].Rows[0]["CGST"].ToString();
                lblSgst1.Text = dstxnCode.Tables[0].Rows[0]["SGST"].ToString();
                if (!string.IsNullOrEmpty(lblCgst1.Text) && !string.IsNullOrEmpty(lblSgst1.Text))
                {
                    lblCgst1.Visible = true;
                    lblSgst1.Visible = true;
                    LabelCGST1.Visible = true;
                    LabelSGST1.Visible = true;
                }
                else
                {
                    lblCgst1.Visible = false;
                    lblSgst1.Visible = false;
                    LabelCGST1.Visible = false;
                    LabelSGST1.Visible = false;
                }
            }

            dstxnCode.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void lblDisable()
    {
        try
        {
            lblMsg.Visible = false;
            lblhelp.Visible = false;
            lblhelp1.Visible = false;
            lblSGST2.Visible = false;
            lblCGST2.Visible = false;
            LabelCGST.Visible = false;
            LabelSGST.Visible = false;
            lblCgst1.Visible = false;
            lblSgst1.Visible = false;
            LabelCGST1.Visible = false;
            LabelSGST1.Visible = false;
            lblnarration.Visible = false;
            lblstdnarr.Visible = false;
            LabelOutSt2.Visible = false;
            lbloutstd2.Visible = false;
            LabelNewBal.Visible = false;
            lblNewBal.Visible = false;           
            LabelAccNo.Visible = false;
            lblAccNo.Visible = false;
            LabelOutSt.Visible = false;
            lblOtSt.Visible = false;
            lblChkedOt.Visible = false;
            lblCheckedin.Visible = false;
            lblStatus.Visible = false;
            Label1.Visible = false;
            Label2.Visible = false;
            Label5.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void txtCAmount_TextChanged(object sender, EventArgs e)
    {
        try
        {


            if (string.IsNullOrEmpty(txtCAmount.Text))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Script", "Sys.Application.add_load(HideUpdateProgress);", true);
                WebMsgBox.Show("Please Enter valid amount.");
                return;
            }

            if (cmbResident.SelectedValue.ToString() == "0")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Script", "Sys.Application.add_load(HideUpdateProgress);", true);
                WebMsgBox.Show("Please select resident.");
                return;
            }
            LabelNewBal.Visible = true;
            lblNewBal.Visible = true;
            DataSet dsDetails = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 9 },
                   new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                lbloutstd2.Text = dsDetails.Tables[0].Rows[0]["Outstanding"].ToString();
                LabelOutSt2.Visible = true;
                lbloutstd2.Visible = true;
            }
            Double Amount = Convert.ToDouble(txtCAmount.Text);
            Double CGST = 0.00;
            Double SGST = 0.00;
            Double CalCGST = 0.00;
            Double CalSGST = 0.00;

            if (drpTxn.SelectedValue == "DP" || drpTxn.SelectedValue == "DR")
            {
                LabelNewBal.Visible = false;
                lblNewBal.Visible = false;
                LabelOutSt2.Visible = false;
                lbloutstd2.Visible = false;

            }
            if (!string.IsNullOrEmpty(lblCgst1.Text) && !string.IsNullOrEmpty(lblSgst1.Text))
            {
                CGST = Convert.ToDouble(lblCgst1.Text);
                SGST = Convert.ToDouble(lblSgst1.Text);
                CalCGST = (Amount * (CGST / 100));
                CalSGST = (Amount * (SGST / 100));
                lblSGST2.Visible = true;
                lblCGST2.Visible = true;
                LabelCGST.Visible = true;
                LabelSGST.Visible = true;
                lblCGST2.Text = CalCGST.ToString("F");
                lblSGST2.Text = CalSGST.ToString("F");
            }
            else
            {

            }

            lblNewBal.Text = (Convert.ToDouble(lbloutstd2.Text) + (Amount + CalCGST + CalSGST)).ToString("F");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }

    }
    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {

        //LoadGrid();
        rdbResident_CheckedChanged(sender, e);
        rdbResident.Checked = true;
        DataSet dsDetails = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 9 },
                new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() },
                 new SqlParameter() { ParameterName = "@TxnCode", SqlDbType = SqlDbType.NVarChar, Value = drpTxn.SelectedValue.ToString() });
        if (dsDetails.Tables[0].Rows.Count > 0)
        {            
            lblAccNo.Text = dsDetails.Tables[0].Rows[0]["AccountCode"].ToString();
            Session["GLAccount"] = dsDetails.Tables[0].Rows[0]["AccountCode"].ToString();
            lblOtSt.Text = dsDetails.Tables[0].Rows[0]["Outstanding"].ToString();
            lblStatus.Text = dsDetails.Tables[0].Rows[0]["Status"].ToString();
            lblCheckedin.Text = dsDetails.Tables[0].Rows[0]["Arrived"].ToString();
            lblChkedOt.Text = dsDetails.Tables[0].Rows[0]["Checkedout"].ToString();
            LabelAccNo.Visible = true;
            lblAccNo.Visible = true;
            LabelOutSt.Visible = true;
            lblOtSt.Visible = true;
            lblChkedOt.Visible = true;
            lblCheckedin.Visible = true;
            lblStatus.Visible = true;
            Label1.Visible = true;
            Label2.Visible = true;
            Label5.Visible = true;
        }
    }
    protected void rdbResident_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (cmbResident.SelectedValue != "0")
            {
                LoadGrid();
            }
            else
            {
                gvTransactions.DataSource = string.Empty;
                gvTransactions.DataBind();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Guest, And Try Again.');", true);
                return;
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void rdbAll_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet dsTransactions = sqlobj.ExecuteSP("SP_TxnDropDownList",

                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 11 }
               );

            if (dsTransactions.Tables[0].Rows.Count > 0)
            {
                gvTransactions.DataSource = dsTransactions.Tables[0];
                gvTransactions.DataBind();
            }
            else
            {
                gvTransactions.DataSource = string.Empty;
                gvTransactions.DataBind();
            }
            dsTransactions.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnCClear_Click(object sender, EventArgs e)
    {
        txtCAmount.Text = "";
        txtRemarks.Text = "";
        //LoadTxnDrp();
        //LoadResidentDet();      
        rdbResident.Checked = true;
        lblDisable();
        gvTransactions.DataSource = string.Empty;
        gvTransactions.DataBind();
        drpTxn.SelectedIndex = 0;

        cmbResident.SelectedValue = "0";
    }
    protected void btnTransSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (drpTxn.SelectedValue == "0")
            {
                WebMsgBox.Show("Please Select Transaction.");
                return;
            }
            if (cmbResident.SelectedValue == "0")
            {
                WebMsgBox.Show("Please Select Resident.");
                return;
            }
            if (string.IsNullOrEmpty(txtCAmount.Text) || txtCAmount.Text == "0")
            {
                WebMsgBox.Show("Please Enter Valid Amount.");
                return;
            }
            if (string.IsNullOrEmpty(txtRemarks.Text))
            {
                WebMsgBox.Show("Please Enter Remarks.");
                return;
            }
            DateTime bdate = DateTime.Now;

            string strday = bdate.ToString("dd");
            string strmonth = bdate.ToString("MM");
            string stryear = bdate.ToString("yyyy");
            string strhour = bdate.ToString("HH");
            string strmin = bdate.ToString("mm");
            string strsec = bdate.ToString("ss");

            string strBillNo = stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();

            //if (!string.IsNullOrEmpty(txtCAmount.Text) || txtCAmount.Text == "0" && !string.IsNullOrEmpty(txtCAmount.Text) || txtCAmount.Text == "0" && txtRemarks.Text != "")
            //{SP_InsertGuestUNBILLEDTxnPosting

            if (drpTxn.SelectedValue == "GC" || drpTxn.SelectedValue == "GP")
            {
                DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertGuestTxnPosting",
                                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = 0000 },
                                       new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = drpTxn.SelectedValue.ToString() },
                                       new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "G" },
                                       new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
                                       new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                                       new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                       new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "G" },
                                       new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() },
                                       new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                       new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = lblAccNo.Text.ToString() },
                    new SqlParameter() { ParameterName = "@CGST", SqlDbType = SqlDbType.Decimal, Value = lblCGST2.Text.ToString() },
                    new SqlParameter() { ParameterName = "@SGST", SqlDbType = SqlDbType.Decimal, Value = lblSGST2.Text.ToString() }
                                         );
            }
            else
            {

                DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertGuestUNBILLEDTxnPosting",
                                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue.ToString() },
                                      new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = drpTxn.SelectedValue.ToString() },
                                      new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "G" },
                                      new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
                                      new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                                      new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                      new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                      new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "G" },
                                      new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() },
                                      new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                      new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = lblAccNo.Text.ToString() },
                                    new SqlParameter() { ParameterName = "@CGST", SqlDbType = SqlDbType.Decimal, Value = lblCGST2.Text.ToString() },
                                    new SqlParameter() { ParameterName = "@SGST", SqlDbType = SqlDbType.Decimal, Value = lblSGST2.Text.ToString() }
                                        );
            }
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transaction amount posted successfully');", true);
            btnCClear_Click(sender, e);
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
}