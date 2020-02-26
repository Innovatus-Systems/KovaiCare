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


public partial class ALaCartBilling : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    public DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        rwDinCount.VisibleOnPageLoad = true;
        rwDinCount.Visible = false;
        if (IsPostBack && ViewState["dt"] == null)
        {
            dt = new DataTable();
            dt.Columns.Add(new DataColumn("ItemCode", typeof(string)));
            dt.Columns.Add(new DataColumn("ItemName", typeof(string)));
            dt.Columns.Add(new DataColumn("Rate", typeof(decimal)));
            dt.Columns.Add(new DataColumn("Persons", typeof(Int32)));
            dt.Columns.Add(new DataColumn("Qty", typeof(Int32)));
            dt.Columns.Add(new DataColumn("Unit", typeof(string)));
            dt.Columns.Add(new DataColumn("AmounttoPay", typeof(decimal)));
            dt.Columns.Add(new DataColumn("Amount", typeof(decimal)));
            dt.Columns.Add(new DataColumn("CGST", typeof(decimal)));
            dt.Columns.Add(new DataColumn("SGST", typeof(decimal)));
            dt.Columns.Add(new DataColumn("From", typeof(string)));
            dt.Columns.Add(new DataColumn("To", typeof(string)));
            // dt.Columns.Add(new DataColumn("SessionCode", typeof(string)));
            // dt.Columns.Add(new DataColumn("Session", typeof(string)));

            rgBookingameal.DataSource = string.Empty;
            rgBookingameal.DataBind();
        }
        else
        {
            dt = (DataTable)ViewState["dt"];
        }
        if (!IsPostBack)
        {
            try
            {
                if (Session["GuestTxn"] != null && Session["GuestTxn"].ToString().Equals("Y"))
                {
                    ChkGR.SelectedValue = "G";
                    Session["GuestTxn"] = "N";
                    ChkGR.Items[0].Enabled = false;
                    chkAll.Visible = false;
                }
            }
            catch (Exception ex)
            {


            }
            dtpfordate.SelectedDate = DateTime.Now;
            LoadResidentDet();
            LoadMenus();
            LoadTitle();
            lblnm.Visible = false;
            //LabelName.Visible = true;
            //LabelDrNo.Visible = true;
            lblSpace.Visible = false;
            lblDrNo.Visible = false;
            LabelAccNo.Visible = false;
            lblAccNo.Visible = false;
            LabelOutSt.Visible = false;
            lblOtSt.Visible = false;
            LoadHelp();
        }

    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 141 });
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
    private void LoadMenus()
    {
        try
        {
            DataSet dsmenuitem = new DataSet();
            if (chkTCM.Checked == true)
            {
                dsmenuitem = sqlobj.ExecuteSP("SP_FetchItem",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });
            }
            else
            {
                dsmenuitem = sqlobj.ExecuteSP("SP_FetchItem",
                 new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 });
            }

            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {
                ddlItemName.DataSource = dsmenuitem.Tables[0];
                ddlItemName.DataValueField = "ItemCode";
                ddlItemName.DataTextField = "ItemName";
                ddlItemName.DataBind();
                ddlItemName.Dispose();
                ddlItemName.Items.Insert(0, "--Select--");
            }
            else
            {
                ddlItemName.Items.Insert(0, "--Select--");
            }
            dsmenuitem.Dispose();
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
            if (ChkGR.SelectedValue == "R")
            {
                chkAll.Visible = true;
                if (!chkAll.Checked)
                {
                    dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 }
                    );
                }
                else
                {
                    dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 15 }
                    );
                }
            }
            else
            {
                chkAll.Visible = false;
                dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 14 }
                    );
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
    protected void LoadMenuItems()
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsMenu = null;
            dsMenu = sqlobj.ExecuteSP("SP_MenuItems");

            if (dsMenu.Tables[0].Rows.Count > 0)
            {
                //rgMenuItem.DataSource = dsMenu.Tables[0];
                //rgMenuItem.DataBind();
            }
            else
            {
                //rgMenuItem.DataSource = string.Empty;
                //rgMenuItem.DataBind();
            }

            dsMenu.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnMenuItems_Click(object sender, EventArgs e)
    {
        try
        {
            LoadMenuItems();
            //rwMenuItems.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlBMQuantiry_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(txtBMRate.Text))
            {
                WebMsgBox.Show("Please Enter Rate Of The Selected Product");
                return;
            }
            Double Amount = 0.00;
            Double CGST = 0.00;
            Double SGST = 0.00;
            Double CalCGST = 0.00;
            Double CalSGST = 0.00;
            string CGST1 = "";
            string SGST1 = "";

            //if (txtBMRate.Text != "" && ddlBMQuantiry.SelectedValue.ToString() != "0")
            if (txtBMRate.Text != "" && txtBMQuantity.Text.ToString() != "0" && txtBMQuantity.Text != "")
            {
                //decimal iatop = Convert.ToDecimal(txtBMRate.Text) * Convert.ToInt32(ddlBMQuantiry.SelectedValue) * Convert.ToInt32(txtNoOfPersons.Text);
                //decimal iatop = Convert.ToDecimal(txtBMRate.Text) * Convert.ToInt32(ddlBMQuantiry.SelectedValue) ;
                decimal iatop = Convert.ToDecimal(txtBMRate.Text) * Convert.ToInt32(txtBMQuantity.Text);

                //txtBMAmounttopay.Text = iatop.ToString();

                //Int32 itotqty = Convert.ToInt32(ddlBMQuantiry.SelectedValue) * Convert.ToInt32(txtNoOfPersons.Text);
                //Int32 itotqty = Convert.ToInt32(ddlBMQuantiry.SelectedValue) ;
                Int32 itotqty = Convert.ToInt32(txtBMQuantity.Text);

                txtBMTotQty.Text = itotqty.ToString();
                btnPreparetobill.Visible = true;
                //btnpaynow.Visible = true;

                DataSet dstxnCode = sqlobj.ExecuteSP("SP_TxnDropDownList",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@TxnCode", SqlDbType = SqlDbType.NVarChar, Value = "AC" });
                if (dstxnCode.Tables[0].Rows.Count > 0)
                {
                    lblAmount.Visible = true;
                    lblAmount1.Visible = true;
                    lblCGST.Visible = true;
                    lblCGST1.Visible = true;
                    lblSGST.Visible = true;
                    lblSGST1.Visible = true;
                    CGST1 = dstxnCode.Tables[0].Rows[0]["CGST"].ToString();
                    SGST1 = dstxnCode.Tables[0].Rows[0]["SGST"].ToString();
                    lblAmount1.Text = iatop.ToString();
                    //lblAmount1.Text = iatop.ToString();
                    Amount = Convert.ToDouble(lblAmount1.Text);
                    CGST = Convert.ToDouble(CGST1.ToString());
                    SGST = Convert.ToDouble(SGST1.ToString());

                    if (dstxnCode.Tables[0].Rows[0]["IorE"].ToString() == "E")
                    {
                        lblAmount1.Text = iatop.ToString();
                        CalCGST = (Amount * (CGST / 100));
                        CalSGST = (Amount * (SGST / 100));
                        lblCGST1.Text = CalCGST.ToString("F");
                        lblSGST1.Text = CalSGST.ToString("F");
                        txtBMAmounttopay.Text = (Amount + CalCGST + CalSGST).ToString("F");
                    }
                    else
                    {
                        double ttlCGST = 100 + CGST;
                        double ttlSGST = 100 + SGST;
                        double gstC = (Amount - (((Amount) * 100) / ttlCGST));
                        double gsts = (Amount - (((Amount) * 100) / ttlSGST));
                        //CalCGST = (Amount * (CGST / 100));
                        //CalSGST = (Amount * (SGST / 100));
                        lblAmount1.Text = (Amount - gstC - gsts).ToString("F");
                        decimal adj1 = (Convert.ToDecimal((Convert.ToDouble(lblAmount1.Text) + gstC + gsts).ToString("F")));
                        decimal adj2 = adj1 - Convert.ToDecimal(Amount);
                        decimal adj3 = 0;
                        if (iatop >= Convert.ToDecimal(adj1))
                        {
                            adj3 = Convert.ToDecimal(lblAmount1.Text);
                        }
                        else
                        {
                            adj3 = Convert.ToDecimal(lblAmount1.Text) + adj2;
                        }
                        lblAmount1.Text = (adj3).ToString("F");
                        lblCGST1.Text = gstC.ToString("F");
                        lblSGST1.Text = gsts.ToString("F");
                        txtBMAmounttopay.Text = (Amount).ToString("F");
                    }

                }
                dstxnCode.Dispose();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnClearAll_Click(object sender, EventArgs e)
    {
        try
        {
            lblnm.Visible = false;
            //LabelName.Visible = true;
            //LabelDrNo.Visible = true;
            lblSpace.Visible = false;
            lblDrNo.Visible = false;
            LabelAccNo.Visible = false;
            lblAccNo.Visible = false;
            LabelOutSt.Visible = false;
            lblOtSt.Visible = false;
            lblAmount.Visible = false;
            lblAmount1.Visible = false;
            lblCGST.Visible = false;
            lblCGST1.Visible = false;
            lblSGST.Visible = false;
            lblSGST1.Visible = false;
            lblMsg.Visible = false;
            lblhelp.Visible = false;
            lblhelp1.Visible = false;
            dtpfordate.SelectedDate = DateTime.Now;
            cmbResident.SelectedValue = "0";
            //txtNoOfPersons.Text = "0";
            //txtContains.Text = "";
            txtBMAmounttopay.Text = "";
            //ddlBMQuantiry.SelectedValue = "0";
            txtBMQuantity.Text = "0";
            txtBMRate.Text = "";
            txtBMTotQty.Text = "";
            // DdlUhid.Enabled = true;
            btnPreparetobill.Visible = false;
            rgBookingameal.DataSource = string.Empty;
            rgBookingameal.DataBind();
            cmbResident.Enabled = true;
            dt.Rows.Clear();
            ViewState["dt"] = null;
            /// btnpaynow.Visible = false;
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
            lblhelp.Visible = true;
            lblhelp1.Visible = true;
            lblMsg.Visible = true;
            DataSet dsTxn = sqlobj.ExecuteSP("SP_TxnDropDownList",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@TxnCode", SqlDbType = SqlDbType.NVarChar, Value = "AC" });
            if (dsTxn.Tables[0].Rows.Count > 0)
            {
                lblhelp1.Text = dsTxn.Tables[0].Rows[0]["Help"].ToString();
                string msg = dsTxn.Tables[0].Rows[0]["StdDescription"].ToString();
                string CGST = dsTxn.Tables[0].Rows[0]["CGST"].ToString();
                string SGST = dsTxn.Tables[0].Rows[0]["SGST"].ToString();
                string code = dsTxn.Tables[0].Rows[0]["TxnCode"].ToString();
                string All = msg + " - " + code + "  <br/> " + "CGST %:- " + CGST + "  - " + "SGST %:- " + SGST;
                lblMsg.Text = All;
            }


            dsTxn.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (cmbResident.SelectedValue == "0" || ddlItemName.SelectedIndex == 0)
            {
                WebMsgBox.Show("Please select Resident");
                return;
            }
            if (string.IsNullOrEmpty(txtBMAmounttopay.Text) || string.IsNullOrEmpty(txtBMRate.Text) || string.IsNullOrEmpty(txtBMTotQty.Text))
            {
                WebMsgBox.Show("Please make sure all the fields are filled.");
                return;
            }

            string struntildate = "";
            DateTime fdate = Convert.ToDateTime(dtpfordate.SelectedDate);
            DataRow dr = dt.NewRow();
            dr["ItemCode"] = ddlItemName.SelectedValue;
            dr["ItemName"] = ddlItemName.SelectedItem.Text;
            dr["Rate"] = Convert.ToDecimal(txtBMRate.Text);
            dr["Persons"] = Convert.ToInt32(txtBMTotQty.Text);
            dr["Unit"] = "Nos.";
            //dr["Qty"] = Convert.ToInt32(ddlBMQuantiry.SelectedValue) ;
            dr["Qty"] = Convert.ToInt32(txtBMTotQty.Text);
            dr["Unit"] = lblunit.Text;
            dr["AmounttoPay"] = Convert.ToDecimal(txtBMAmounttopay.Text);
            dr["From"] = fdate.ToString("dd/MM/yyyy");
            dr["To"] = fdate.ToString("dd/MM/yyyy");
            dr["Amount"] = Convert.ToDecimal(lblAmount1.Text);
            dr["CGST"] = Convert.ToDecimal(lblCGST1.Text);
            dr["SGST"] = Convert.ToDecimal(lblSGST1.Text);
            dt.Rows.Add(dr);
            ViewState["dt"] = dt;
            rgBookingameal.DataSource = dt;
            rgBookingameal.DataBind();
            //txtNoOfPersons.Text = "0";
            ddlItemName.SelectedIndex = 0;
            //ddlBMQuantiry.SelectedValue = "0";
            txtBMAmounttopay.Text = "0";
            lblnm.Visible = false;
            //LabelName.Visible = true;
            //LabelDrNo.Visible = true;
            lblSpace.Visible = false;
            lblDrNo.Visible = false;
            LabelAccNo.Visible = false;
            lblAccNo.Visible = false;
            LabelOutSt.Visible = false;
            lblOtSt.Visible = false;
            lblAmount.Visible = false;
            lblAmount1.Visible = false;
            lblCGST.Visible = false;
            lblCGST1.Visible = false;
            lblSGST.Visible = false;
            lblSGST1.Visible = false;
            if (chkPastDate.Checked == false)
            { dtpfordate.SelectedDate = DateTime.Now; }

            btnPreparetobill.Visible = true;
            txtBMAmounttopay.Text = "";
            txtBMRate.Text = "";
           // cmbResident.Enabled = false;
            //Added by Bala on 19.02.2020
            txtBMRate.Text = string.Empty;
            txtBMQuantity.Text = string.Empty;

            WebMsgBox.Show("Don't forget to click save button, After finished selection.");

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnPreparetobill_Click(object sender, EventArgs e)
    {
        try
        {
            string strBStatus = "";
            DateTime cdate = DateTime.Now;
            if (dt.Rows.Count > 0)
            {

                DateTime bdate = DateTime.Now;

                string strday = bdate.ToString("dd");
                string strmonth = bdate.ToString("MM");
                string stryear = bdate.ToString("yyyy");
                string strhour = bdate.ToString("HH");
                string strmin = bdate.ToString("mm");
                string strsec = bdate.ToString("ss");

                string strBillNo = stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();

                decimal TotalAmount = 0;
                decimal CGSTAmount = 0;
                decimal SGSTAmount = 0;

                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    Int64 iRTRSN = Convert.ToInt64(cmbResident.SelectedValue);
                    string strItemCode = dt.Rows[i]["ItemCode"].ToString();
                    decimal dRate = Convert.ToDecimal(dt.Rows[i]["Rate"].ToString());
                    Int32 ipersons = Convert.ToInt32(dt.Rows[i]["Persons"].ToString());
                    Int32 iQty = Convert.ToInt32(dt.Rows[i]["Qty"].ToString());
                    decimal damounttopay = Convert.ToDecimal(dt.Rows[i]["AmounttoPay"].ToString());
                    decimal damount = Convert.ToDecimal(dt.Rows[i]["Amount"].ToString());
                    decimal CGST = Convert.ToDecimal(dt.Rows[i]["CGST"].ToString());
                    decimal SGST = Convert.ToDecimal(dt.Rows[i]["SGST"].ToString());
                    // string strSessionCode = dt.Rows[i]["SessionCode"].ToString();

                    TotalAmount = TotalAmount + damount;
                    CGSTAmount = CGSTAmount + CGST;
                    SGSTAmount = SGSTAmount + SGST;

                    DateTime sdate = DateTime.ParseExact(dt.Rows[i]["From"].ToString(), "dd/MM/yyyy", null);
                    DateTime edate = DateTime.ParseExact(dt.Rows[i]["To"].ToString(), "dd/MM/yyyy", null);

                    // Insert Booking a meal


                    sqlobj.ExecuteNonQuery("SP_InsertBookingameal",
                        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = sdate },
                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = iRTRSN.ToString() },
                        new SqlParameter() { ParameterName = "@DiningRSN", SqlDbType = SqlDbType.BigInt, Value = null },
                        new SqlParameter() { ParameterName = "@MenuItemCode", SqlDbType = SqlDbType.NVarChar, Value = strItemCode.ToString() },
                        new SqlParameter() { ParameterName = "@Rate", SqlDbType = SqlDbType.Decimal, Value = dRate },
                        new SqlParameter() { ParameterName = "@Persons", SqlDbType = SqlDbType.Int, Value = ipersons },
                        new SqlParameter() { ParameterName = "@Qty", SqlDbType = SqlDbType.Int, Value = iQty },
                        new SqlParameter() { ParameterName = "@Amounttopay", SqlDbType = SqlDbType.Decimal, Value = damounttopay },
                        new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() }

                        );

                }
                string Check = "No";
                if (chkPastDate.Checked == true)
                {
                    Check = "True";
                }

                if (TotalAmount != 0)
                {
                    DateTime dtm = DateTime.Parse(dtpfordate.SelectedDate.ToString());
                    DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertDiningTxnPosting",
                         new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue.ToString() },
                         new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "AC" },
                         new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = ChkGR.SelectedValue },
                         new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = TotalAmount },
                         new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = "" },
                         new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                         new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                         new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = ChkGR.SelectedValue },
                         new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() },
                         new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                         new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = lblAccNo.Text.ToString() },
                         new SqlParameter() { ParameterName = "@CGST", SqlDbType = SqlDbType.Decimal, Value = CGSTAmount },
                         new SqlParameter() { ParameterName = "@SGST", SqlDbType = SqlDbType.Decimal, Value = SGSTAmount },
                         new SqlParameter() { ParameterName = "@Check", SqlDbType = SqlDbType.NVarChar, Value = Check },
                         new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtm }
                           );
                }
                dtpfordate.SelectedDate = null;
                chkPastDate.Checked = false;
                //txtNoOfPersons.Text="0";
                txtBMAmounttopay.Text = "";
                //ddlBMQuantiry.SelectedValue = "0";
                txtBMQuantity.Text = "0";
                txtBMRate.Text = "";
                txtBMTotQty.Text = "";

                rgBookingameal.DataSource = string.Empty;
                rgBookingameal.DataBind();

                //txtNoOfPersons.Enabled = true;

                //DdlUhid.Entries.Clear();

                cmbResident.SelectedValue = "0";
                btnClearAll_Click(sender, e);
                dt.Rows.Clear();
                ViewState["dt"] = null;
                cmbResident.Enabled = true;
                //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Credit transaction updated');", true);

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Total Bill Amount debited and will appear in the outstanding bills.');", true);

                //WebMsgBox.Show("Bill prepared");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('There is nothing to bill!');", true);
                // WebMsgBox.Show("There is nothing to bill!");
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        DataSet dsDetails;
        if (cmbResident.SelectedIndex != -1)
        {
            if (ChkGR.SelectedValue == "R")
            {
                dsDetails = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });
                if (dsDetails.Tables[0].Rows.Count > 0)
                {
                    lblnm.Text = dsDetails.Tables[0].Rows[0]["RtName"].ToString();
                    lblDrNo.Text = dsDetails.Tables[0].Rows[0]["RTVillaNo"].ToString();
                    lblAccNo.Text = dsDetails.Tables[0].Rows[0]["GLAccount"].ToString();
                    lblOtSt.Text = dsDetails.Tables[0].Rows[0]["Outstanding"].ToString();
                    lblnm.Visible = true;
                    //LabelName.Visible = true;
                    //LabelDrNo.Visible = true;
                    lblSpace.Visible = true;
                    lblDrNo.Visible = true;
                    LabelAccNo.Visible = true;
                    lblAccNo.Visible = true;
                    LabelOutSt.Visible = true;
                    lblOtSt.Visible = true;
                }
            }
            else
            {
                dsDetails = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 9 },
                    new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() },
                     new SqlParameter() { ParameterName = "@TxnCode", SqlDbType = SqlDbType.NVarChar, Value = "" });
                if (dsDetails.Tables[0].Rows.Count > 0)
                {
                    lblnm.Text = dsDetails.Tables[0].Rows[0]["Name"].ToString();
                    lblDrNo.Text = dsDetails.Tables[0].Rows[0]["BookingFor"].ToString();
                    lblAccNo.Text = dsDetails.Tables[0].Rows[0]["AccountCode"].ToString();
                    lblOtSt.Text = dsDetails.Tables[0].Rows[0]["Outstanding"].ToString();
                    lblnm.Visible = true;
                    //LabelName.Visible = true;
                    //LabelDrNo.Visible = true;
                    lblSpace.Visible = true;
                    lblDrNo.Visible = true;
                    LabelAccNo.Visible = true;
                    lblAccNo.Visible = true;
                    LabelOutSt.Visible = true;
                    lblOtSt.Visible = true;
                }
            }

        }
        else
        {
            rwDinCount.Visible = false;
            WebMsgBox.Show("Please select the Resident");

            return;
        }

    }

    protected void lnkDinCount_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet dsdate = sqlobj.ExecuteSP("CC_ALACARTECOUNT",
               new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
            if (dsdate.Tables[0].Rows.Count > 0)
            {
                rdFrom.SelectedDate = DateTime.Parse(dsdate.Tables[0].Rows[0]["bpfrom"].ToString());
                rdTill.SelectedDate = DateTime.Parse(dsdate.Tables[0].Rows[0]["bptill"].ToString());
            }
            else
            {
                rdFrom.SelectedDate = DateTime.Now;
                rdTill.SelectedDate = DateTime.Now;
            }
            //if (rdFrom.SelectedDate > rdTill.SelectedDate)
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Oops! From date is greater then Till date');", true);
            //    return;
            //}
            rwDinCount.Visible = true;
            LoaddrpItem();
            LoadCount();

        }
        catch (Exception ex)
        {

        }
    }

    protected void rgCount_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadCount();
    }

    protected void rgCount_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgCount.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains" || menu.Items[i].Text == "GreaterThan" || menu.Items[i].Text == "LessThan")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }

    protected void LoadCount()
    {
        try
        {
            DataSet dsDetails = sqlobj.ExecuteSP("CC_ALACARTECOUNT",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@FROMDATE", SqlDbType = SqlDbType.DateTime, Value = rdFrom.SelectedDate },
                 new SqlParameter() { ParameterName = "@TILLDATE", SqlDbType = SqlDbType.DateTime, Value = rdTill.SelectedDate },
                new SqlParameter() { ParameterName = "@ITEM", SqlDbType = SqlDbType.NVarChar, Value = drpItem.SelectedValue.ToString() });
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                rgCount.DataSource = dsDetails.Tables[0];
                rgCount.DataBind();
                LoaddrpItem();
            }
            else
            {
                rgCount.DataSource = String.Empty;
                rgCount.DataBind();
            }

            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                lblQty.Text = "Total Qty - " + dsDetails.Tables[2].Rows[0]["Qty"].ToString();
            }
            else
            {
                lblQty.Text = "Total Qty - 0.";
            }

            dsDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void LoaddrpItem()
    {
        try
        {
            DataSet dsDetails = sqlobj.ExecuteSP("CC_ALACARTECOUNT",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@FROMDATE", SqlDbType = SqlDbType.DateTime, Value = rdFrom.SelectedDate },
                 new SqlParameter() { ParameterName = "@TILLDATE", SqlDbType = SqlDbType.DateTime, Value = rdTill.SelectedDate },
                  new SqlParameter() { ParameterName = "@ITEM", SqlDbType = SqlDbType.NVarChar, Value = "All" });
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                drpItem.DataSource = dsDetails.Tables[1];
                drpItem.DataValueField = "ItemName";
                drpItem.DataTextField = "ItemName";
                drpItem.DataBind();
            }
            drpItem.Items.Insert(0, new ListItem("All", "All"));
            dsDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        rwDinCount.Visible = true;
        LoadCount();
    }


    protected void ChkGR_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadResidentDet();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void chkAll_CheckedChanged(object sender, EventArgs e)
    {
        LoadResidentDet();
    }



    protected void chkTCM_CheckedChanged(object sender, EventArgs e)
    {
        LoadMenus();
    }

    protected void ddlItemName_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}