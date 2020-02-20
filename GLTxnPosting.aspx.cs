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


public partial class GLTxnPosting : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    public DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (IsPostBack && ViewState["dt"] == null)
        {
            ViewState["Count"] = 0;
            dt = new DataTable();
            dt.Columns.Add(new DataColumn("RSN", typeof(Int32)));
            dt.Columns.Add(new DataColumn("AccountCode", typeof(string)));
            dt.Columns.Add(new DataColumn("Title", typeof(string)));
            dt.Columns.Add(new DataColumn("DrCr", typeof(string)));
            dt.Columns.Add(new DataColumn("Narration", typeof(string)));
            dt.Columns.Add(new DataColumn("AmountDr", typeof(decimal)));
            dt.Columns.Add(new DataColumn("AmountCr", typeof(decimal)));
            glTransactions.DataSource = string.Empty;
            glTransactions.DataBind();
        }
        else
        {
            dt = (DataTable)ViewState["dt"];

        }
        if (!IsPostBack)
        {
            String now = DateTime.Now.ToString("dd-MMM-yyyy");
            lbldate.Text = now;
            lblTDebit.Text = "0.00";
            lblTCebit.Text = "0.00";
            LoadGLAccoutCode();
            LoadTitle();
            glTransactions.DataSource = string.Empty;
            glTransactions.DataBind();
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 144 });
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
    protected void LoadGLAccoutCode()
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_GeneralTransactions",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });
            drpAccCode.DataSource = dsResident.Tables[0];
            drpAccCode.DataValueField = "AccountsMRSN";
            drpAccCode.DataTextField = "AccountName";
            drpAccCode.DataBind();
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            drpAccCode.Items.Add(item2);
            dsResident.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void lblDelete_Click(object sender, EventArgs e)
    {
        try
        {


            LinkButton lkBtn = (LinkButton)sender;
            GridDataItem grditm = (GridDataItem)lkBtn.NamingContainer;
            string RSN = grditm.Cells[3].Text.ToString();
            for (int i = 1; i <= dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["RSN"].ToString() == RSN)
                {
                    string drcr = dt.Rows[i]["DrCr"].ToString();
                    if (drcr == "DR")
                    {
                        string AmountDr = dt.Rows[i]["AmountDr"].ToString();
                        lblTDebit.Text = (Convert.ToDecimal(lblTDebit.Text) - Convert.ToDecimal(AmountDr.ToString())).ToString();
                    }
                    if (drcr == "CR")
                    {
                        string AmountCr = dt.Rows[i]["AmountCr"].ToString();
                        lblTCebit.Text = (Convert.ToDecimal(lblTCebit.Text) - Convert.ToDecimal(AmountCr.ToString())).ToString();
                    }
                    dt.Rows[i].Delete();
                    dt.AcceptChanges();
                }
            }
            glTransactions.DataSource = dt;
            glTransactions.DataBind();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            drpAccCode.SelectedValue = "0";
            lbldescription.Visible = false;
            lblDes.Visible = false;
            drpDRCR.SelectedValue = "0";
            txtCAmount.Text = "";
            txtRemarks.Text = "";
            lblTDebit.Text = "0.00";
            lblTCebit.Text = "0.00";

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void  btnPost_Click(object sender, EventArgs e)
    {
        try
        {
            if (dt.Rows.Count == 0)
            {
                WebMsgBox.Show("Please post some transaction and try again.");
                return;
            }
            if (Convert.ToDecimal(lblTCebit.Text) == Convert.ToDecimal(lblTDebit.Text))
            {
                string Count = Convert.ToString(dt.Rows.Count);

                DateTime bdate = DateTime.Now;
                string strday = bdate.ToString("dd");
                string strmonth = bdate.ToString("MM");
                string stryear = bdate.ToString("yyyy");
                string strhour = bdate.ToString("HH");
                string strmin = bdate.ToString("mm");
                string strsec = bdate.ToString("ss");
                string strBillNo = stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        string billwtCnt = strBillNo + "_" + Count + (i + 1);
                        string Accountcode = dt.Rows[i]["AccountCode"].ToString();
                        string Title = dt.Rows[i]["Title"].ToString();
                        string DRCR = dt.Rows[i]["DrCr"].ToString();
                        string narration = dt.Rows[i]["Narration"].ToString();
                        decimal Amount = 0;
                        if (DRCR == "DR")
                        {
                            Amount = Convert.ToDecimal(dt.Rows[i]["AmountDr"].ToString());
                        }
                        if (DRCR == "CR")
                        {
                            Amount = Convert.ToDecimal(dt.Rows[i]["AmountCr"].ToString());
                        }

                        DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertGLTxnPosting",
                                                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = 9999 },
                                                 new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "GL" },
                                                 new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "G" },
                                                 new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = Amount },
                                                 new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = narration },
                                                 new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = billwtCnt.ToString() },
                                                 new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                                 new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "G" },
                                                 new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() },
                                                 new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                                 new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = Accountcode },
                                                  new SqlParameter() { ParameterName = "@DRCR", SqlDbType = SqlDbType.NVarChar, Value = DRCR });
                    }
                    WebMsgBox.Show("Transactions posted successfully and Ref. Number is : " + strBillNo);
                }
                else
                {
                    WebMsgBox.Show("Please post some transaction and try again.");
                    return;
                }
            }
            else
            {
                WebMsgBox.Show("Please Check Total debit and Total credit amount.It should be same.");
                return;
            }
            btnClear_Click(sender, e);
            glTransactions.DataSource = string.Empty;
            glTransactions.DataBind();
            dt.Clear();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }

    protected void drpAccCode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsDetails = sqlobj.ExecuteSP("SP_GLTxnPosting", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = drpAccCode.SelectedValue.ToString() });
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                lblDes.Visible = false;
                lbldescription.Visible = true;
                lbldescription.Text = dsDetails.Tables[0].Rows[0]["AccountName"].ToString();
                lblAccountcode.Text = dsDetails.Tables[0].Rows[0]["AccountCode"].ToString();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {


            if (drpAccCode.SelectedValue == "0")
            {
                WebMsgBox.Show("Please Select Account.");
                return;
            }
            if (string.IsNullOrEmpty(txtCAmount.Text) || txtCAmount.Text == "0")
            {
                WebMsgBox.Show("Please Enter Valid Amount");
                return;
            }
            if (string.IsNullOrEmpty(txtRemarks.Text))
            {
                WebMsgBox.Show("Please Enter Narration");
                return;
            }
            if (drpDRCR.SelectedValue == "0")
            {
                WebMsgBox.Show("Please Select Debit / Credit.");
                return;
            }
            DateTime fdate = DateTime.Now;
            DataRow dr = dt.NewRow();
            ViewState["Count"] = Convert.ToInt32(ViewState["Count"]) + 1;
            int rowcount = Convert.ToInt32(ViewState["Count"]);
            dr["RSN"] = rowcount;
            dr["AccountCode"] = lblAccountcode.Text.ToString();
            dr["Title"] = lbldescription.Text.ToString();
            dr["DrCr"] = drpDRCR.SelectedValue.ToString();
            dr["Narration"] = txtRemarks.Text;
            if (drpDRCR.SelectedValue == "DR")
            {
                lblTDebit.Text = (Convert.ToDecimal(lblTDebit.Text) + Convert.ToDecimal(txtCAmount.Text)).ToString("F");
                dr["AmountDr"] = Convert.ToDecimal(txtCAmount.Text).ToString("F");
            }
            if (drpDRCR.SelectedValue == "CR")
            {
                lblTCebit.Text = (Convert.ToDecimal(lblTCebit.Text) + Convert.ToDecimal(txtCAmount.Text)).ToString("F");
                dr["AmountCr"] = Convert.ToDecimal(txtCAmount.Text).ToString("F");
            }
            dt.Rows.Add(dr);
            ViewState["dt"] = dt;
            glTransactions.DataSource = dt;
            glTransactions.DataBind();
            drpAccCode.SelectedValue = "0";
            lbldescription.Visible = false;
            lblDes.Visible = false;
            drpDRCR.SelectedValue = "0";
            txtCAmount.Text = "";
            txtRemarks.Text = "";
            WebMsgBox.Show("Transaction saved in grid, Don't forget to post the transaction.");

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
}