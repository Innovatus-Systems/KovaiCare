using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.IO;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Globalization;
using System.Net;

public partial class TransactionLevelInd : System.Web.UI.Page
{
    decimal dlastOutStanding;
    DateTime dlastCreditDate;
    DateTime dlastDebitDate;


    SqlProcsNew sqlobj = new SqlProcsNew();
    static string UserID;
    static string CustomerRSN;
    string TransType;
    string TransNarraction;
    string TransCategory;


    int CNT = 0;
    int i;
    int TaskCnt;
    string BID;

    string xmlstc;
    StreamWriter streamWriter;

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;


        rwHelp.VisibleOnPageLoad = true;
        rwHelp.Visible = false;


        rwSaveTime.VisibleOnPageLoad = true;
        rwSaveTime.Visible = false;

        if (!IsPostBack)
        {


            LoadTitle();

            CheckPermission();

            //dsDT = proc.ExecuteSP("GetServerDateTime");           

            dsDT = proc.ExecuteSP("GetServerDateTime");

           

            DateTime dFirstDayOfThisMonth = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]).AddDays(-(DateTime.Today.Day - 1));
            var yr = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]).Year;
            var mth = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]).Month;

            DateTime firstDay = new DateTime(yr, mth, 1);
            DateTime lastDay = firstDay.AddMonths(1).AddDays(-1);

            DateTime PMfirstDay = new DateTime(yr, mth, 1).AddMonths(-1);
            DateTime PMlastDay = new DateTime(yr, mth, 1).AddDays(-1);


            ddlAmountType.SelectedIndex = 1;

            LoadCashType();


            //BTFromDate.SelectedDate = PMfirstDay;
            //BTToDate.SelectedDate = PMlastDay;

            //YBFromDate.SelectedDate = firstDay;
            //YBToDate.SelectedDate = lastDay;

            LoadVillaNo();
            
            //Session["ResidentRSN"] = Convert.ToInt32(ddlVillaNo.SelectedValue.ToString());


            BindGeneralInfrm();
            //loadCustDetails();
            LoadBillingPeriod();
            LoadBPeriod();
            //lblSelCustName.Visible = true;

            dsDT = sqlobj.ExecuteSP("GetServerDateTime");

            GetCurrentBillingPeriod();


            dtpCDate.SelectedDate = DateTime.Now;

            LoadResidentDet();

            LoadGeneralLedger();

            LoadGGeneralLedger();

           


            rdoLedger.SelectedValue = "1";

            cmbResident.Visible = true;
            cmbGeneral.Visible= false;
            cmbGGenearl.Visible = false;

            //dtpCDate.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);

            LoadBPeriodCmt();

            LoadSaveTime();


            //lblgroup.Visible = false;
            //lblcgroup.Visible = false;

            //lblcPayMode.Visible = true;
            //lblpaymode.Visible = true;


            // EnableTransactions(Convert.ToInt16(ddlAmountType.SelectedValue));

            gvTransactions.DataSource = string.Empty;
            gvTransactions.DataBind();

            lblresidentname.Text = string.Empty;
            lblDoorno.Text = string.Empty;
            lblAccountNo.Text = string.Empty;

        }

        LoadMoreInfo();
        BindStatAccount();
        //BindPastBills();
        BindBilledTrans();
        LoadLstFiveTrans();

        LoadCurrentBillingPeriod();

        //lbldeposit.Visible = false;

        rwMoreInfo.VisibleOnPageLoad = true;
        rwMoreInfo.Visible = false;
    }

    protected void LoadResidentDet()
    {
        try
        {

            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = 1 });
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

    protected void LoadGeneralLedger()
    {
        try
        {
            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3});
            cmbGeneral.DataSource = dsResident.Tables[0];
            cmbGeneral.DataValueField = "AccountsMRSN";
            cmbGeneral.DataTextField = "RName";
            cmbGeneral.DataBind();

            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbGeneral.Items.Add(item2);

            dsResident.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    protected void LoadGGeneralLedger()
    {
        try
        {
            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 5 });
            cmbGGenearl.DataSource = dsResident.Tables[0];
            cmbGGenearl.DataValueField = "AccountsMRSN";
            cmbGGenearl.DataTextField = "RName";
            cmbGGenearl.DataBind();

            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbGGenearl.Items.Add(item2);

            dsResident.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    private void GetCurrentBillingPeriod()
    {
        try
        {
            DataSet dsCBP = null;
            dsCBP = sqlobj.ExecuteSP("SP_GetCurrentBillingPeriod" );
            
        if (dsCBP.Tables[0].Rows.Count >0)
        {
            dtpCDate.MinDate = Convert.ToDateTime(dsCBP.Tables[0].Rows[0]["bpfrom"].ToString());
            dtpCDate.MaxDate = DateTime.Now;
        }

       
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadCurrentBillingPeriod()
    {
        try
        {

            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_FetchBillingPeriods",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });

            //lblcurrentBillingMonth.Text = "Current billing month is " + dsGroup.Tables[1].Rows[0]["CurrentPeriod"].ToString();

            //lblBillGenerationDate.Text = "Month end billing job is due on " + dsGroup.Tables[4].Rows[0]["LastDateBillGeneraion"].ToString();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }


    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 30 });


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

    protected void EnableTransactions(Int16 i)
    {
        try
        {
            if (i == 1)
            {

                btnTransSave.Visible = false;
                //btnTransPayLater.Visible = false;
                //btnTransCredit.Visible = true;
                //btnTransPostCrAdjust.Visible = false;
                //btnTransPostDrAdust.Visible = false;

            }
            else if (i == 2)
            {

                btnTransSave.Visible = true;
                //btnTransPayLater.Visible = true;
                //btnTransCredit.Visible = false;
                //btnTransPostCrAdjust.Visible = false;
                //btnTransPostDrAdust.Visible = false;

            }
            else if (i == 3)
            {

                btnTransSave.Visible = false;
                //btnTransPayLater.Visible = false;
                //btnTransCredit.Visible = false;
                //btnTransPostCrAdjust.Visible = true;
                //btnTransPostDrAdust.Visible = false;

            }
            else if (i == 4)
            {
                btnTransSave.Visible = false;
                //btnTransPayLater.Visible = false;
                //btnTransCredit.Visible = false;
                //btnTransPostCrAdjust.Visible = false;
                //btnTransPostDrAdust.Visible = true;
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void CheckPermission()
    {
        try
        {

            if (Session["UserID"] != null)
            {

                Permission p = new Permission();

                string result = p.GetPermission(Session["UserID"].ToString(), "Accounts");
                string result2 = p.GetPermission(Session["UserID"].ToString(), "Accounts");

                result = result.Trim();
                result2 = result.Trim();

                if ((result.ToString() == "Y"))
                {

                    Session["UserPermission"] = result.ToString();
                    //Response.Redirect("ResidentAdd.aspx");
                }
                else
                {
                    Response.Redirect("Homemenu.aspx");
                    WebMsgBox.Show("You have not permission to view resident module");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadVillaNo()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistVilla = new DataSet();

            ddlistVilla = sqlobj.ExecuteSP("SP_FecthVillaNO1",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 });
            //ddlVillaNo.DataSource = ddlistVilla.Tables[0];
            //ddlVillaNo.DataValueField = "RSN";
            //ddlVillaNo.DataTextField = "VillaText";
            //ddlVillaNo.DataBind();
            //ddlVillaNo.Dispose();
            //ddlVillaNo.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadLstFiveTrans()
    {
        try
        {
            int RSN = Convert.ToInt32(Session["ResidentRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsLFTrans = null;
            dsLFTrans = sqlobj.ExecuteSP("SP_FetchLFTransaction",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = RSN });
            //rdgLFTrans.DataSource = dsLFTrans.Tables[0];
            //rdgLFTrans.DataBind();
            //rdgLFTrans.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }

    }

    protected void btnExpProject_Click(object sender, EventArgs e)
    {

    }

    protected void gvMoreinfo_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {

    }

    protected void gvMoreinfo_Sorting(object sender, GridViewSortEventArgs e)
    {


    }

    public void loadCustDetails()
    {
        if (Session["ResidentRSN"] != "")
        {
            try
            {
                int RSN = Convert.ToInt32(Session["ResidentRSN"]);

                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsSection = proc.ExecuteSP("SP_ResidentEdit", new SqlParameter()
                {
                    ParameterName = "@RTRSN",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = RSN
                });


                TxtRTRSN.Text = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();
                //TxtRTName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                //TxtRTVILLANO.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                //TxtRTSTATUS.Text = dsSection.Tables[0].Rows[0]["RTSTATUS"].ToString();

            }
            catch (Exception ex)
            {
                WebMsgBox.Show("There are some error in Occupant loading process.Try again!");
            }
        }
        else
        {
            WebMsgBox.Show("There are some error in Occupant loading process.Try again!");
        }
    }

    protected void btnMISave_Click(object sender, EventArgs e)
    {

        try
        {
            //if (CnfResult.Value == "true")

            //SQLProcs sqlobj = new SQLProcs();
            Decimal IVal;
            //if (txtvalue.Text == string.Empty)
            //{
            //    IVal = 0;
            //}
            //else
            //{
            //    IVal = Convert.ToDecimal(txtvalue.Text);
            //}

            //sqlobj.ExecuteNonQuery("SP_InsertDiary2",
            //                              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Session["ResidentRSN"]) },
            //                              new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = txtdescription.Text },
            //                              new SqlParameter() { ParameterName = "@MoreInfoAction", SqlDbType = SqlDbType.NVarChar, Value = txttext.Text },
            //                              new SqlParameter() { ParameterName = "@MoreInfoValue", SqlDbType = SqlDbType.Decimal, Value = IVal });

            sqlobj.ExecuteNonQuery("SP_InsertDiary2",
                                          new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Session["ResidentRSN"]) },
                                           new SqlParameter() { ParameterName = "@Entry", SqlDbType = SqlDbType.NVarChar, Value = txtvalue.Text },
                                          new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = txtdescription.Text });


            //new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }



            moreinfoclear();

            LoadMoreInfo();

            rwMoreInfo.Visible = true;

            WebMsgBox.Show("Information Saved");


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnMIUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            //if (CnfResult.Value == "true")
            //{
            int RSN = Convert.ToInt32(Session["ResidentRSN"]);

            // sqlobj.ExecuteNonQuery("SP_UpdateDiary",
            //                                 new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = txtdescription.Text },
            //                                 new SqlParameter() { ParameterName = "@MoreInfoAction", SqlDbType = SqlDbType.NVarChar, Value = txttext.Text },
            //                                 new SqlParameter() { ParameterName = "@MoreInfoValue", SqlDbType = SqlDbType.Decimal, Value = txtvalue.Text },
            //     //new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
            //new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

            sqlobj.ExecuteNonQuery("SP_UpdateDiary",
                                            new SqlParameter() { ParameterName = "@Entry", SqlDbType = SqlDbType.NVarChar, Value = txtvalue.Text },
                                            new SqlParameter() { ParameterName = "@Response", SqlDbType = SqlDbType.NVarChar, Value = txtdescription.Text },
           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = txtDRSN.Text });


            moreinfoclear();

            LoadMoreInfo();

            rwMoreInfo.Visible = true;

            WebMsgBox.Show("Information Updated");



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    protected void moreinfoclear()
    {
        txtdescription.Text = "";
        txtvalue.Text = "";
        txttext.Text = "";

        btnMISave.Visible = true;
        btnMIUpdate.Visible = false;
    }

    protected void btnMIClear_Click(object sender, EventArgs e)
    {
        txttext.Text = string.Empty;
        txtvalue.Text = string.Empty;
        txtdescription.Text = string.Empty;
        rwMoreInfo.Visible = true;
    }

    protected void btnMIExit_Click(object sender, EventArgs e)
    {
        rwMoreInfo.Visible = false;
    }

    protected void btnRegistrationSave_Click(object sender, EventArgs e)
    {

    }

    protected void btnRegistrationClear_Click(object sender, EventArgs e)
    {

    }

    protected void txtRegistrationAmount_TextChanged(object sender, EventArgs e)
    {

        try
        {
            decimal damount = Convert.ToDecimal(txtRegistrationAmount.Text);

            LoadRegistrationTotalAmounttowords(damount);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadRegistrationTotalAmounttowords(decimal amount)
    {
        DataSet DS = new DataSet();

        SqlProcsNew proc = new SqlProcsNew();
        DS = proc.ExecuteSP("getAmountinwords",
        new SqlParameter() { ParameterName = "@Amount", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Float, Value = amount }
        );

        if (DS.Tables[0].Rows.Count > 0)
        {
            lblramountinwords.Text = DS.Tables[0].Rows[0]["AmountInWords"].ToString();
        }
    }

    protected void txtCAmount_TextChanged(object sender, EventArgs e)
    {
        Decimal CLAmount;
        ShowBalance();
        {
            try
            {
                String NBAmount;

                lblNewBalance.Visible = true;
                decimal damount = Convert.ToDecimal(txtCAmount.Text);
                decimal CAmount = Convert.ToDecimal(Session["BalAmount"]);

                 if (ddlAmountType.SelectedValue == "2" || ddlAmountType.SelectedValue == "3")
               
                {
                    if (CAmount > 0)
                    {
                        CLAmount = CAmount + damount;
                    }
                    else
                    {
                        CLAmount = CAmount + damount;
                    }

                    if (CLAmount > 0)
                    {
                        NBAmount = Convert.ToString(CLAmount);
                    }
                    else
                    {
                        NBAmount = Convert.ToString((CLAmount) * -1) + " CR";
                    }

                    lblNewBalance.Text = "New Balance: " + NBAmount;
                }
                 else if (ddlAmountType.SelectedValue == "1" || ddlAmountType.SelectedValue == "4")
                {
                    if (CAmount > 0)
                    {
                        CLAmount = CAmount - (damount );
                    }
                    else
                    {
                        CLAmount = CAmount + (damount * -1);
                    }

                    if (CLAmount > 0)
                    {
                        NBAmount = Convert.ToString(CLAmount);
                    }
                    else
                    {
                        NBAmount = Convert.ToString((CLAmount) * -1) + " CR";
                    }

                    lblNewBalance.Text = "New Balance: " + NBAmount;
                }



                //LoadTotalAmounttowords(damount);
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message);
            }
        }
    }

    protected void LoadTotalAmounttowords(decimal amount)
    {
        DataSet DS = new DataSet();

        SqlProcsNew proc = new SqlProcsNew();
        DS = proc.ExecuteSP("getAmountinwords",
        new SqlParameter() { ParameterName = "@Amount", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Float, Value = amount }
        );

        if (DS.Tables[0].Rows.Count > 0)
        {
            lbltamounttowords.Text = DS.Tables[0].Rows[0]["AmountInWords"].ToString();

        }
    }

    protected void btnTransSave_Click(object sender, EventArgs e)
    {
        try
        {


            string strBStatus = "";

            // -- Important


            //DataSet dsStatus = sqlobj.ExecuteSP("SP_CheckBillingStatus",
            //       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpCDate.SelectedDate });

            //if (dsStatus.Tables[0].Rows.Count > 0)
            //{

            //    //strBStatus = dsStatus.Tables[0].Rows[0]["BStatus"].ToString();

            //}
            //else
            //{
            //    WebMsgBox.Show("Please wait for month end billing");
            //    return;
            //}

            // -- Important

            if (CnfResult.Value == "true")
            {


                if (rdoLedger.SelectedValue == "1" || rdoLedger.SelectedValue == "3")
                {

                    string strrsnfilter = "";
                    string custname = "";
                    string doorno = "";

                    if (rdoLedger.SelectedValue == "1")
                    {


                        strrsnfilter = cmbResident.SelectedItem.Text;

                        string[] custrsn = strrsnfilter.Split(',');

                        custname = custrsn[0].ToString();

                        doorno = custrsn[1].ToString();



                        Session["RTRSN"] = cmbResident.SelectedValue;
                        Session["AccountType"] = "R";
                    }
                    else if (rdoLedger.SelectedValue == "3")
                    {
                        Session["RTRSN"] = cmbGGenearl.SelectedValue;
                        Session["AccountType"] = "G";
                    }



                    if (txtCAmount.Text != string.Empty && txtCNarration.Text != "" && txtCNarration.Text != string.Empty)
                    {
                        if (txtCAmount.Text != "0")
                        {




                            if (ddlPayMode.SelectedValue == "DEPOSIT")
                            {
                                TransType = "CR";

                                DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertTransactionDetailsTxn",
                                     new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                                     new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "DEPOSIT" },
                                     new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "CASH" },
                                     new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                     new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlBStatus.SelectedValue },
                                     new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = txtRate.Text },
                                     new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = txtCount.Text },
                                     new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
                                     new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = dtpCDate.SelectedDate },
                                     new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
                                     new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = txtCNarration.Text },
                                     new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = null },
                                     new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                     new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = Session["AccountType"].ToString() },
                                     new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() });


                                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Deposit amount updated successfully');", true);


                                ClearTransScr();


                            }
                            else if (ddlPayMode.SelectedValue != "DEPOSIT")
                            {

                                if (ddlAmountType.SelectedValue == "1")
                                {
                                    TransType = "CR";

                                    TransNarraction = txtCNarration.Text;


                                    if (rdoLedger.SelectedValue == "1")
                                    {

                                        RadWindowManager1.RadConfirm("Do you want print the Receipt for " + custname + " Door No : " + doorno + " ? ", "confirmCallbackFn", 400, 200, null, "Confirm");
                                    }

                                }
                                else if (ddlAmountType.SelectedValue == "2")
                                {
                                    TransType = "DR";
                                    TransNarraction = txtCNarration.Text;
                                }
                                else if (ddlAmountType.SelectedValue == "3")
                                {
                                    TransType = "RC";
                                    TransNarraction = "Credit Reversal" + txtCNarration.Text;
                                }
                                else if (ddlAmountType.SelectedValue == "4")
                                {
                                    TransType = "RD";
                                    TransNarraction = "Debit Reversal" + txtCNarration.Text;
                                }


                                string strGroup = "";


                                if (ddlAmountType.SelectedValue == "2")
                                {
                                    strGroup = ddlGroup.SelectedValue;
                                }
                                else
                                {
                                    strGroup = "CASH";
                                }

                                string strPaymode = "";

                                if (ddlAmountType.SelectedValue == "1")
                                {
                                    strPaymode = ddlPayMode.SelectedValue;
                                }
                                else
                                {
                                    strPaymode = "";
                                }


                                DateTime bdate = DateTime.Now;

                                string strday = bdate.ToString("dd");
                                string strmonth = bdate.ToString("MM");
                                string stryear = bdate.ToString("yyyy");
                                string strhour = bdate.ToString("HH");
                                string strmin = bdate.ToString("mm");
                                string strsec = bdate.ToString("ss");

                                string strBillNo = "G" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();

                                DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertTransactionDetailsTxn",
                                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                                      new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = strPaymode.ToString() },
                                      new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = strGroup.ToString() },
                                      new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                      new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlBStatus.SelectedValue },
                                      new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = txtRate.Text },
                                      new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = txtCount.Text },
                                      new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
                                      new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = dtpCDate.SelectedDate },
                                      new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
                                      new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
                                      new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                      new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                      new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = Session["AccountType"].ToString() },
                                      new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() });


                                if (TransType == "CR" && rdoLedger.SelectedValue == "1" )
                                {
                                    if (dsRSN.Tables[0].Rows.Count > 0)
                                    {
                                        Session["ReceiptRSN"] = dsRSN.Tables[1].Rows[0]["ReceiptNo"].ToString();
                                    }
                                    LoadMoreInfo();
                                    BindStatAccount();

                                    //CreditNote("Mani", "26/05/2016", "002", "250.00", "012");
                                }


                                dsRSN.Dispose();


                                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);

                                // WebMsgBox.Show("Transactions details saved successfully");
                                ClearTransScr();
                            }
                        }

                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('TAmount should be greater than zero');", true);
                            //WebMsgBox.Show("Amount should be greater than zero");
                        }

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please enter mandatory field(s)');", true);

                        // WebMsgBox.Show("Please enter mandatory field(s)");
                    }


                }
                else if (rdoLedger.SelectedValue=="2")
                {



                    string strrsnfilter = "";
                    string custname = "";
                    string doorno = "";


                    strrsnfilter = cmbGeneral.SelectedItem.Text;

                    string[] custrsn = strrsnfilter.Split(',');

                    custname = custrsn[0].ToString();

                    doorno = custrsn[1].ToString();





                    if (ddlAmountType.SelectedValue == "1")
                    {
                        TransType = "CR";

                        TransNarraction = txtCNarration.Text;

                        RadWindowManager1.RadConfirm("Do you want print the Receipt for " + custname + " Door No : " + doorno + " ? ", "confirmCallbackFn", 400, 200, null, "Confirm");

                    }
                    else if (ddlAmountType.SelectedValue == "2")
                    {
                        TransType = "DR";
                        TransNarraction = txtCNarration.Text;
                    }
                    else if (ddlAmountType.SelectedValue == "3")
                    {
                        TransType = "RC";
                        TransNarraction = "Credit Reversal" + txtCNarration.Text;
                    }
                    else if (ddlAmountType.SelectedValue == "4")
                    {
                        TransType = "RD";
                        TransNarraction = "Debit Reversal" + txtCNarration.Text;
                    }


                    string strGroup = "";


                    if (ddlAmountType.SelectedValue == "2")
                    {
                        strGroup = ddlGroup.SelectedValue;
                    }
                    else
                    {
                        strGroup = "CASH";
                    }

                    string strPaymode = "";

                    if (ddlAmountType.SelectedValue == "1")
                    {
                        strPaymode = ddlPayMode.SelectedValue;
                    }
                    else
                    {
                        strPaymode = "";
                    }





                    sqlobj.ExecuteSQLNonQuery("SP_GHTransaction",
                                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = doorno.ToString() },
                                 new SqlParameter() { ParameterName = "@TransType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
                                 new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text }
                                 );



                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);


                    ClearTransScr();


                }
               
                }
            
                

            

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }



    }


    private void CreditNote(string custName, string InvDate, string InvNo, string InvAmt, string SalesOrderNo)
    {
        try
        {
            xmlstc = "<ENVELOPE>" + "\r\n";
            xmlstc = xmlstc + "<HEADER>" + "\r\n";
            xmlstc = xmlstc + "<TALLYREQUEST>Import Data</TALLYREQUEST>" + "\r\n";
            xmlstc = xmlstc + "</HEADER>" + "\r\n";
            xmlstc = xmlstc + "<BODY>" + "\r\n";
            xmlstc = xmlstc + "<IMPORTDATA>" + "\r\n";
            xmlstc = xmlstc + "<REQUESTDESC>" + "\r\n";
            xmlstc = xmlstc + "<REPORTNAME>All Masters</REPORTNAME>" + "\r\n";
            xmlstc = xmlstc + "<STATICVARIABLES>" + "\r\n";
            xmlstc = xmlstc + "<SVCURRENTCOMPANY>VRP & CO</SVCURRENTCOMPANY>" + "\r\n";
            xmlstc = xmlstc + "</STATICVARIABLES>" + "\r\n";
            xmlstc = xmlstc + "</REQUESTDESC>" + "\r\n";
            xmlstc = xmlstc + "<REQUESTDATA>" + "\r\n";
            xmlstc = xmlstc + "<TALLYMESSAGE xmlns:UDF=" + "\"" + "TallyUDF" + "\" >" + "\r\n";
            xmlstc = xmlstc + "<VOUCHER VCHTYPE=" + "\"" + "Sales" + "\" ACTION=" + "\"" + "Create" + "\" >" + "\r\n";
            xmlstc = xmlstc + "<DATE>" + InvDate + "</DATE>" + "\r\n";
            xmlstc = xmlstc + "<VOUCHERTYPENAME>Credit Note</VOUCHERTYPENAME>" + "\r\n";
            xmlstc = xmlstc + "<VOUCHERNUMBER>" + InvNo + "</VOUCHERNUMBER>" + "\r\n";
            xmlstc = xmlstc + "<REFERENCE>Ref</REFERENCE>" + "\r\n";
            xmlstc = xmlstc + "<PARTYLEDGERNAME>" + custName + "</PARTYLEDGERNAME>" + "\r\n";
            xmlstc = xmlstc + "<EFFECTIVEDATE>" + InvDate + "</EFFECTIVEDATE>" + "\r\n";
            xmlstc = xmlstc + "<ISINVOICE>Yes</ISINVOICE>" + "\r\n";
            xmlstc = xmlstc + "<INVOICEORDERLIST.LIST>" + "\r\n";
            xmlstc = xmlstc + "<BASICORDERDATE>" + InvDate + "</BASICORDERDATE>" + "\r\n";
            xmlstc = xmlstc + "<BASICPURCHASEORDERNO>" + SalesOrderNo + "</BASICPURCHASEORDERNO>" + "\r\n";
            xmlstc = xmlstc + "</INVOICEORDERLIST.LIST>" + "\r\n";
            xmlstc = xmlstc + "<ALLLEDGERENTRIES.LIST>" + "\r\n";
            xmlstc = xmlstc + "<LEDGERNAME>" + custName + "</LEDGERNAME>" + "\r\n";
            xmlstc = xmlstc + "<GSTCLASS/>" + "\r\n";
            xmlstc = xmlstc + "<ISDEEMEDPOSITIVE>No</ISDEEMEDPOSITIVE>" + "\r\n";
            xmlstc = xmlstc + "<LEDGERFROMITEM>No</LEDGERFROMITEM>" + "\r\n";
            xmlstc = xmlstc + "<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>" + "\r\n";
            xmlstc = xmlstc + "<ISPARTYLEDGER>Yes</ISPARTYLEDGER>" + "\r\n";
            xmlstc = xmlstc + "<AMOUNT>" + InvAmt + "</AMOUNT>" + "\r\n";
            xmlstc = xmlstc + "<BILLALLOCATIONS.LIST>" + "\r\n";
            xmlstc = xmlstc + "<NAME>" + InvNo + "</NAME>" + "\r\n";
            xmlstc = xmlstc + "<BILLCREDITPERIOD>30 Days</BILLCREDITPERIOD>" + "\r\n";
            xmlstc = xmlstc + "<BILLTYPE>New Ref</BILLTYPE>" + "\r\n";
            xmlstc = xmlstc + "<AMOUNT>" + InvAmt + "</AMOUNT>" + "\r\n";
            xmlstc = xmlstc + "</BILLALLOCATIONS.LIST>" + "\r\n";
            xmlstc = xmlstc + "</ALLLEDGERENTRIES.LIST>" + "\r\n";
            xmlstc = xmlstc + "<ALLLEDGERENTRIES.LIST>" + "\r\n";
            xmlstc = xmlstc + "<LEDGERNAME>" + custName + "</LEDGERNAME>" + "\r\n";            // Main Ledger name
            //xmlstc = xmlstc + "<LEDGERNAME>" + custName + "</LEDGERNAME>" + "\r\n";
            xmlstc = xmlstc + "<ISDEEMEDPOSITIVE>Yes</ISDEEMEDPOSITIVE>" + "\r\n";
            xmlstc = xmlstc + "<LEDGERFROMITEM>No</LEDGERFROMITEM>" + "\r\n";
            xmlstc = xmlstc + "<REMOVEZEROENTRIES>No</REMOVEZEROENTRIES>" + "\r\n";
            xmlstc = xmlstc + "<ISPARTYLEDGER>No</ISPARTYLEDGER>" + "\r\n";
            xmlstc = xmlstc + "<AMOUNT>-" + InvAmt + "</AMOUNT>" + "\r\n";
            xmlstc = xmlstc + "</ALLLEDGERENTRIES.LIST>" + "\r\n";
            xmlstc = xmlstc + "</VOUCHER>" + "\r\n";
            xmlstc = xmlstc + "</TALLYMESSAGE>" + "\r\n";
            xmlstc = xmlstc + "</REQUESTDATA>" + "\r\n";
            xmlstc = xmlstc + "</IMPORTDATA>" + "\r\n";
            xmlstc = xmlstc + "</BODY>" + "\r\n";
            xmlstc = xmlstc + "</ENVELOPE>" + "\r\n";

            HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create("http://192.168.0.106:9000");
            httpWebRequest.Method = "POST";
            httpWebRequest.ContentLength = xmlstc.Length;
            httpWebRequest.ContentType = "application/x-www-form-urlencoded";
            streamWriter = new StreamWriter(httpWebRequest.GetRequestStream());
            streamWriter.Write(xmlstc);

            streamWriter.Close();
            //AddcountCrdNt++;

            string result;
            HttpWebResponse objResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            using (StreamReader sr = new StreamReader(objResponse.GetResponseStream()))
            {
                result = sr.ReadToEnd();

                sr.Close();
            }
            WebMsgBox.Show(result);

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void BindStatAccount()
    {
        try
        {
            int RSN = Convert.ToInt32(Session["ResidentRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsACDet = null;
            dsACDet = sqlobj.ExecuteSP("SP_FetchStatOfAcc",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = RSN });
            rdgStatOfAcc.DataSource = dsACDet.Tables[0];
            rdgStatOfAcc.DataBind();
            dsACDet.Dispose();

            //lblTotal.Text = dsACDet.Tables[1].Rows[0]["OutStanding"].ToString();
            //lblDebit.Text = dsACDet.Tables[1].Rows[0]["SumDR"].ToString();
            //lblCredit.Text = dsACDet.Tables[1].Rows[0]["SumCR"].ToString();
            //lblTotalDebit.Text = dsACDet.Tables[1].Rows[0]["SumDR"].ToString();
            //lblTotalCredit.Text = dsACDet.Tables[1].Rows[0]["SumCR"].ToString();
            //lblTotalPayable.Text = dsACDet.Tables[1].Rows[0]["OutStanding"].ToString();

            //if (dsACDet.Tables[2].Rows[0]["BPFrom"].ToString() != "" && dsACDet.Tables[2].Rows[0]["BPFrom"].ToString() != string.Empty && dsACDet.Tables[2].Rows[0]["BPTill"].ToString() != "" && dsACDet.Tables[2].Rows[0]["BPTill"].ToString() != string.Empty)
            //{
            //    lblBillFrom.Text = dsACDet.Tables[2].Rows[0]["BPFrom"].ToString();
            //    lblBillTo.Text = dsACDet.Tables[2].Rows[0]["BPTill"].ToString();
            //}
            //if (dsACDet.Tables[3].Rows[0]["BPFrom"].ToString() != "" && dsACDet.Tables[3].Rows[0]["BPFrom"].ToString() != string.Empty && dsACDet.Tables[3].Rows[0]["BPTill"].ToString() != "" && dsACDet.Tables[3].Rows[0]["BPTill"].ToString() != string.Empty)
            //{
            //    lblLBillFrom.Text = dsACDet.Tables[3].Rows[0]["BPFrom"].ToString();
            //    lblLBillTo.Text = dsACDet.Tables[3].Rows[0]["BPTill"].ToString();
            //}
            //if (dsACDet.Tables[4].Rows[0]["OS"].ToString() != "" && dsACDet.Tables[4].Rows[0]["OS"].ToString() != string.Empty)
            //{
            //    Decimal OutStand = Convert.ToDecimal(dsACDet.Tables[4].Rows[0]["OS"].ToString());
            //    if (OutStand > 0)
            //    {
            //        lblUBillAmt.Text = dsACDet.Tables[4].Rows[0]["OS"].ToString() + " DR";
            //    }
            //    else if (OutStand < 0)
            //    {
            //        lblUBillAmt.Text = Math.Abs(Convert.ToDecimal(dsACDet.Tables[4].Rows[0]["OS"].ToString())) + " CR";
            //    }

            //}

            //if (dsACDet.Tables[1].Rows[0]["OutStanding"].ToString() != "" && dsACDet.Tables[1].Rows[0]["OutStanding"].ToString() != string.Empty)
            //{
            //    double TotAmt = Convert.ToDouble(dsACDet.Tables[1].Rows[0]["OutStanding"].ToString());
            //    //lblTotal.Text = TotAmt.ToString("C", CultureInfo.CreateSpecificCulture("en-IN")) + dsACDet.Tables[1].Rows[0]["OSD"].ToString();
            //}
            //if (dsACDet.Tables[1].Rows[0]["SumDR"].ToString() != "" && dsACDet.Tables[1].Rows[0]["SumDR"].ToString() != string.Empty)
            //{
            //    double TotAmt = Convert.ToDouble(dsACDet.Tables[1].Rows[0]["SumDR"].ToString());
            //    //lblDebit.Text = TotAmt.ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
            //}
            //if (dsACDet.Tables[1].Rows[0]["SumCR"].ToString() != "" && dsACDet.Tables[1].Rows[0]["SumCR"].ToString() != string.Empty)
            //{
            //    double TotAmt = Convert.ToDouble(dsACDet.Tables[1].Rows[0]["SumCR"].ToString());
            //    //lblCredit.Text = TotAmt.ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
            //}


            if (dsACDet.Tables[5].Rows[0]["OutStanding"].ToString() != "" && dsACDet.Tables[5].Rows[0]["OutStanding"].ToString() != string.Empty)
            {
                double TotAmt2 = Convert.ToDouble(dsACDet.Tables[5].Rows[0]["OutStanding"].ToString());
                lblTotal2.Text = TotAmt2.ToString("C", CultureInfo.CreateSpecificCulture("en-IN")) + dsACDet.Tables[5].Rows[0]["OSD"].ToString();
            }
            if (dsACDet.Tables[5].Rows[0]["SumDR"].ToString() != "" && dsACDet.Tables[5].Rows[0]["SumDR"].ToString() != string.Empty)
            {
                double TotAmt2 = Convert.ToDouble(dsACDet.Tables[5].Rows[0]["SumDR"].ToString());
                lblDebit2.Text = TotAmt2.ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
            }

            if (dsACDet.Tables[5].Rows[0]["SumCR"].ToString() != "" && dsACDet.Tables[5].Rows[0]["SumCR"].ToString() != string.Empty)
            {
                double TotAmt2 = Convert.ToDouble(dsACDet.Tables[5].Rows[0]["SumCR"].ToString());
                lblCredit2.Text = TotAmt2.ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
            }
        }
        catch (Exception ex)
        {
            //WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void ClearTransScr()
    {

        //TxtRTSTATUS.Text = string.Empty;
        //TxtRTVILLANO.Text = string.Empty;
        //TxtRTName.Text = string.Empty;

        txtCAmount.Text = string.Empty;
        dtpCDate.SelectedDate = DateTime.Now.Date;
        txtCNarration.Text = string.Empty;
        lbltamounttowords.Text = string.Empty;
        txtCAmount.Focus();
        //DdlUhid.Entries.Clear();
        ddlAmountType.SelectedIndex = 0;

        cmbResident.SelectedValue = "0";
        cmbGeneral.SelectedValue = "0";


        rdoLedger.SelectedValue = "1";

        cmbGeneral.Visible = false;
        cmbResident.Visible = true;
        cmbGGenearl.Visible = false;

        LoadGeneralLedger();

        Label59.Text = "For which Resident Account?Search by";


        lblgroup.Visible = false;
        lblcgroup.Visible = false;

        lbldeposit.Visible = false;
        lblNewBalance.Visible = false;

        dtpCDate.SelectedDate = DateTime.Now;

        ddlAmountType.SelectedIndex = 1;

        LoadCashType();

        gvTransactions.DataSource = string.Empty;
        gvTransactions.DataBind();

        lblresidentname.Text = string.Empty;
        lblDoorno.Text = string.Empty;
        lblAccountNo.Text = string.Empty;

        lbldeposit.Text = "";



    }

    protected void BindGeneralInfrm()
    {
        int RSN = Convert.ToInt32(Session["ResidentRSN"]);
        try
        {
            DataSet dsProfile = new DataSet();
            DataSet dsKTSection = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            dsProfile = proc.ExecuteSP("[SP_FetchVSNDet]", new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = RSN });
            //string TotAmount2;

            if (dsProfile.Tables[0].Rows.Count > 0)
            {
                Session["VName"] = dsProfile.Tables[0].Rows[0]["Name"].ToString();
                //lblSelCustName.Text = " Villa Number : " + dsProfile.Tables[0].Rows[0]["RTVILLANO"].ToString() + " || Status :  " + dsProfile.Tables[0].Rows[0]["RStatus"].ToString() + " || Name : " + dsProfile.Tables[0].Rows[0]["Name"].ToString();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadMoreInfo()
    {
        int RSN = Convert.ToInt32(Session["ResidentRSN"]);
        DataSet dsMoreInfo = sqlobj.ExecuteSP("SP_Loadmoreinfo",
            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

        if (dsMoreInfo.Tables[0].Rows.Count > 0)
        {
            gvMoreinfo.DataSource = dsMoreInfo;
            gvMoreinfo.DataBind();
        }
        else
        {
            gvMoreinfo.DataSource = null;
            gvMoreinfo.DataBind();

        }

        dsMoreInfo.Dispose();
    }

    protected void btnCClear_Click(object sender, EventArgs e)
    {
        ClearTransScr();
    }

    protected void imgbtnAddWorkDetails_Click1(object sender, ImageClickEventArgs e)
    {
        try
        {
            txttext.Enabled = true;
            txtvalue.Enabled = true;

            txttext.Text = "";
            txtvalue.Text = "0";
            txtdescription.Text = "";

            btnMIUpdate.Visible = false;
            btnMISave.Visible = true;
            rwMoreInfo.Visible = true;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvMoreinfo_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "MoreInfoEdit")
        {
            int index = Convert.ToInt32(e.CommandArgument);

            LinkButton lnkbtn = (LinkButton)e.CommandSource;
            GridViewRow myrow = (GridViewRow)lnkbtn.Parent.Parent;
            GridView mygrid = (GridView)sender;

            string strProspectRSN = mygrid.DataKeys[myrow.RowIndex].Value.ToString();

            int RSN = Convert.ToInt32(Session["ResidentRSN"]);

            //DataSet dsmoreinfo = sqlobj.ExecuteSP("SP_Getdiarydetails",
            //   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

            //Add by Prakash
            DataSet dsmoreinfo = sqlobj.ExecuteSP("SP_Getdiarydetails",
               new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = strProspectRSN });

            if (dsmoreinfo.Tables[0].Rows.Count > 0)
            {
                txttext.Text = dsmoreinfo.Tables[0].Rows[0]["CreatedOn"].ToString();
                txtvalue.Text = dsmoreinfo.Tables[0].Rows[0]["moreinfotext"].ToString();
                txtdescription.Text = dsmoreinfo.Tables[0].Rows[0]["moreinfoDesc"].ToString();
                txtDRSN.Text = strProspectRSN;






                txttext.Enabled = false;
                txtvalue.Enabled = false;

                rwMoreInfo.Visible = true;

                btnMIUpdate.Visible = true;
                btnMISave.Visible = false;

            }

        }
    }

    protected void imgbtnAddWorkDetails_Click2(object sender, ImageClickEventArgs e)
    {
        try
        {
            txttext.Enabled = true;
            txtvalue.Enabled = true;

            btnMIUpdate.Visible = false;
            rwMoreInfo.Visible = true;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlBStatus_SelectedIndexChanged(object sender, EventArgs e)
    {

    }



    protected void LoadBPeriod()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsBP = new DataSet();

            dsBP = sqlobj.ExecuteSP("SP_FetchBPeriod",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 });
            ddlBPeriod.DataSource = dsBP.Tables[0];
            ddlBPeriod.DataValueField = "RSN";
            ddlBPeriod.DataTextField = "BPName";
            ddlBPeriod.DataBind();
            ddlBPeriod.Dispose();
            //ddlBPeriod.Items.Insert(12, new ListItem("--All--", 12));

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }


    private void LoadCashType()
    {

        if (ddlAmountType.SelectedValue == "2")
        {
            lblcgroup.Visible = true;
            lblgroup.Visible = true;
        }
        else
        {
            lblcgroup.Visible = false;
            lblgroup.Visible = false;
        }

        if (ddlAmountType.SelectedValue == "1")
        {
            lblpaymode.Visible = true;
            lblcPayMode.Visible = true;

        }
        else
        {
            lblpaymode.Visible = false;
            lblcPayMode.Visible = false;
        }


        if (ddlAmountType.SelectedValue == "2" || ddlAmountType.SelectedValue == "4")
        {
            DataSet DS = new DataSet();


            DS = sqlobj.ExecuteSP("Sp_FetchBillCodeDet",

            new SqlParameter() { ParameterName = "@BCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "" });

            if (DS.Tables[0].Rows.Count > 0)
            {
                string Amount = DS.Tables[0].Rows[0]["BCodeRate"].ToString();


                EnableFields(Amount);
            }
            else
            {
                DisableFields();
            }

        }
        else
        {
            DisableFields();
        }

        ShowBalance();
    }


    //Rangan

    protected void ddlAmountType_Changed(object sender, EventArgs e)
    {

        // EnableTransactions(Convert.ToInt16(ddlAmountType.SelectedValue));


        if (ddlAmountType.SelectedValue == "2")
        {
            lblcgroup.Visible = true;
            lblgroup.Visible = true;
        }
        else
        {
            lblcgroup.Visible = false;
            lblgroup.Visible = false;
        }

        if (ddlAmountType.SelectedValue == "1")
        {
            lblpaymode.Visible = true;
            lblcPayMode.Visible = true;

        }
        else
        {
            lblpaymode.Visible = false;
            lblcPayMode.Visible = false;
        }


        if (ddlAmountType.SelectedValue == "2" || ddlAmountType.SelectedValue == "4")
        {
            DataSet DS = new DataSet();


            DS = sqlobj.ExecuteSP("Sp_FetchBillCodeDet",

            new SqlParameter() { ParameterName = "@BCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "" });

            if (DS.Tables[0].Rows.Count > 0)
            {
                string Amount = DS.Tables[0].Rows[0]["BCodeRate"].ToString();


                EnableFields(Amount);
            }
            else
            {
                DisableFields();
            }

        }
        else
        {
            DisableFields();
        }

        ShowBalance();
    }

    protected void EnableFields(string Amt)
    {
        lblCount.Visible = true;
        lblSCount.Visible = true;
        txtCount.Visible = true;

        lblRate.Visible = true;
        lblSRate.Visible = true;
        txtRate.Visible = true;

        txtRate.Text = string.Empty;
        txtCount.Text = string.Empty;
        txtCAmount.Text = string.Empty;


        txtRate.Text = Amt;
        txtCAmount.Enabled = false;
        txtCount.Focus();
    }

    protected void DisableFields()
    {
        lblCount.Visible = false;
        lblSCount.Visible = false;
        txtCount.Visible = false;

        lblRate.Visible = false;
        lblSRate.Visible = false;
        txtRate.Visible = false;

        txtRate.Text = "0";
        txtCount.Text = "0";
        txtCAmount.Text = string.Empty;

        txtCAmount.Enabled = true;
        txtCAmount.Focus();
    }

    protected void txtCount_Changed(object sender, EventArgs e)
    {
        decimal CRate, CCount, CAmount;
        CRate = Convert.ToDecimal(txtRate.Text);
        CCount = Convert.ToDecimal(txtCount.Text);
        CAmount = CRate * CCount;
        txtCAmount.Text = Convert.ToString(CAmount);
        txtCNarration.Focus();
    }

    protected void BindPastBills()
    {
        try
        {
            int RSN = Convert.ToInt32(Session["ResidentRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsACDet = null;
            dsACDet = sqlobj.ExecuteSP("SP_FetchPastBills",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = RSN });
            rdgPastBills.DataSource = dsACDet.Tables[0];
            rdgPastBills.DataBind();
            dsACDet.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void BindBilledTrans()
    {
        try
        {
            int RSN = Convert.ToInt32(Session["ResidentRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsBTrans = null;
            dsBTrans = sqlobj.ExecuteSP("SP_FetchBilledTrans",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = RSN },
                new SqlParameter() { ParameterName = "@BPRSN", SqlDbType = SqlDbType.Decimal, Value = ddlBPeriod.SelectedValue });
            //new SqlParameter() { ParameterName = "@FromDt", SqlDbType = SqlDbType.DateTime, Value = BTFromDate.SelectedDate },
            //new SqlParameter() { ParameterName = "@TillDt", SqlDbType = SqlDbType.DateTime, Value = BTToDate.SelectedDate });
            rdgBilledTrans.DataSource = dsBTrans.Tables[0];
            rdgBilledTrans.DataBind();
            dsBTrans.Dispose();


            if (dsBTrans.Tables[1].Rows[0]["OutStanding"].ToString() != "" && dsBTrans.Tables[1].Rows[0]["OutStanding"].ToString() != string.Empty)
            {
                double TotAmt = Convert.ToDouble(dsBTrans.Tables[1].Rows[0]["OutStanding"].ToString());
                lblTotal.Text = TotAmt.ToString("C", CultureInfo.CreateSpecificCulture("en-IN")) + dsBTrans.Tables[1].Rows[0]["OSD"].ToString();
            }
            if (dsBTrans.Tables[1].Rows[0]["SumDR"].ToString() != "" && dsBTrans.Tables[1].Rows[0]["SumDR"].ToString() != string.Empty)
            {
                double TotAmt = Convert.ToDouble(dsBTrans.Tables[1].Rows[0]["SumDR"].ToString());
                lblDebit.Text = TotAmt.ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
            }

            if (dsBTrans.Tables[1].Rows[0]["SumCR"].ToString() != "" && dsBTrans.Tables[1].Rows[0]["SumCR"].ToString() != string.Empty)
            {
                double TotAmt = Convert.ToDouble(dsBTrans.Tables[1].Rows[0]["SumCR"].ToString());
                lblCredit.Text = TotAmt.ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }


    }

    protected void ddlBPeriod_Changed(object sender, EventArgs e)
    {
        LoadBPeriodCmt();

    }

    protected void LoadBPeriodCmt()
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsGBP = null;

        dsGBP = proc.ExecuteSP("GetBillingPeriod",
             new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = ddlBPeriod.SelectedValue });
        string BPStatus = dsGBP.Tables[0].Rows[0]["BStatus"].ToString();

        if (BPStatus == "10")
        {
            lblBPeriod.Text = "Yet to be billed";
        }
        else if (BPStatus == "30")
        {
            lblBPeriod.Text = "Look for payments for this period,in the next period.";
        }
        else
        {
            lblBPeriod.Text = "";
        }

    }

    protected void btnExpBT_Click(object sender, EventArgs e)
    {
        if ((rdgBilledTrans.Visible == true) && (rdgBilledTrans.Items.Count > 0))
        {

            string FileName, CDate;
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;
            Response.ClearContent();
            Response.Charset = "";
            dsDT = proc.ExecuteSP("GetServerDateTime");
            CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");
            FileName = "BT_" + Session["VName"].ToString() + "_" + CDate;

            rdgBilledTrans.ExportSettings.ExportOnlyData = true;
            rdgBilledTrans.ExportSettings.FileName = FileName;
            rdgBilledTrans.ExportSettings.IgnorePaging = true;
            rdgBilledTrans.ExportSettings.OpenInNewWindow = true;
            rdgBilledTrans.MasterTableView.ExportToExcel();
        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }

    protected void btnExpUBT_Click(object sender, EventArgs e)
    {
        if ((rdgStatOfAcc.Visible == true) && (rdgStatOfAcc.Items.Count > 0))
        {

            string FileName, CDate;
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;
            Response.ClearContent();
            Response.Charset = "";
            dsDT = proc.ExecuteSP("GetServerDateTime");
            CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");
            FileName = "UBT_" + Session["VName"].ToString() + "_" + CDate;

            rdgStatOfAcc.ExportSettings.ExportOnlyData = true;
            rdgStatOfAcc.ExportSettings.FileName = FileName;
            rdgStatOfAcc.ExportSettings.IgnorePaging = true;
            rdgStatOfAcc.ExportSettings.OpenInNewWindow = true;
            rdgStatOfAcc.MasterTableView.ExportToExcel();
        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }

    //int total;
    //protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    //{
    //    if (e.Item is GridDataItem)
    //    {
    //        GridDataItem dataItem = e.Item as GridDataItem;
    //        int fieldValue = int.Parse(dataItem["TXAMOUNTDR"].Text);
    //        total += fieldValue;
    //    }
    //    if (e.Item is GridFooterItem)
    //    {
    //        GridFooterItem footerItem = e.Item as GridFooterItem;
    //        footerItem["TXAMOUNTDR"].Text = "total: " + total.ToString();
    //    }
    //}

    //-------------------------------------------------------------***---------------------------

    protected void LoadBillingPeriod()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistBCode = new DataSet();

            ddlistBCode = sqlobj.ExecuteSP("SP_FetchBillingCodeDropDown",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 });
            ddlBillingPeriod.DataSource = ddlistBCode.Tables[0];
            ddlBillingPeriod.DataValueField = "RSN";
            ddlBillingPeriod.DataTextField = "BPName";
            ddlBillingPeriod.DataBind();

            FetchPreBillPeriodDet();

            txtAmtReceivedNow.Focus();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void FetchPreBillPeriodDet()
    {
        try
        {
            decimal RRSN = Convert.ToDecimal(Session["ResidentRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsBPDet = null;
            dsBPDet = sqlobj.ExecuteSP("SP_FetchPreBillPeriodDet",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = RRSN },
                new SqlParameter() { ParameterName = "@BillPeriod", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingPeriod.SelectedItem.ToString() });

            if (dsBPDet.Tables[0].Rows.Count > 0)
            {
                txtAmtBilled.Text = dsBPDet.Tables[0].Rows[0]["AmtBilled"].ToString();
                txtAmtReceived.Text = dsBPDet.Tables[0].Rows[0]["AmtReceived"].ToString();
                txtAmtDue.Text = dsBPDet.Tables[0].Rows[0]["AmtOutstanding"].ToString();

            }
            else
            {
                txtAmtBilled.Text = string.Empty;
                txtAmtReceived.Text = string.Empty;
                txtAmtDue.Text = string.Empty;

            }
        }
        catch (Exception ex)
        {

        }

    }

    protected void UpdateBulkDebit(object sender, EventArgs e)
    {
        if (Convert.ToDecimal(txtAmtReceivedNow.Text) > 0)
        {
            Int32 totaldebitsselected = 0;
            decimal dtotaldebitamt = 0;
            decimal ddebitamt = 0;
            string sname = "";
            string getname = "";
            Int32 totalcustomers = 0;

            BulkDebitConfirmationMsgBox.RadConfirm(" Amount Due : " + totalcustomers + " <br/> Amount Received Now:" + totaldebitsselected + "<br/> Total Debit Amount:", "confirmCallbackFn", 300, 200, null, "Monthly Bill Payment");
            BindStatAccount();
        }



    }

    protected void btnPMBSave_Click(object sender, EventArgs e)
    {
        try
        {
            decimal RRSN = Convert.ToDecimal(Session["ResidentRSN"]);

            if (CnfResult.Value == "true")
            {
                if (txtAmtReceivedNow.Text != string.Empty || txtAmtReceivedNow.Text != "")
                {
                    if (Convert.ToDecimal(txtAmtReceivedNow.Text) > 0)
                    {
                        sqlobj.ExecuteNonQuery("SP_InsertPreMonthBill",
                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = RRSN },
                        new SqlParameter() { ParameterName = "@BillPeriod", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingPeriod.SelectedItem.ToString() },
                        new SqlParameter() { ParameterName = "@AmtReceivedNow", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(txtAmtReceivedNow.Text) });

                        WebMsgBox.Show("Billing amount saved");
                        txtAmtReceivedNow.Text = string.Empty;
                    }
                    else
                    {
                        WebMsgBox.Show("Received amount should be greater than zero");
                        txtAmtReceived.Text = string.Empty;
                        txtAmtReceived.Focus();
                    }
                }
                else
                {
                    WebMsgBox.Show("Enter Received amount, received amount should not be empty.");
                }


            }



            FetchPreBillPeriodDet();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    protected void btnPMBClear_Click(object sender, EventArgs e)
    {
        ClearScr();

    }

    protected void ClearScr()
    {
        txtAmtBilled.Text = string.Empty;
        txtAmtReceived.Text = string.Empty;
        txtAmtDue.Text = string.Empty;
        txtAmtReceivedNow.Text = string.Empty;

    }

    protected void ddlVillaNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        //LoadVillaNo();
        //Session["ResidentRSN"] = Convert.ToInt32(ddlVillaNo.SelectedValue.ToString());

        BindGeneralInfrm();
        loadCustDetails();
        LoadBillingPeriod();
        //lblSelCustName.Visible = true;

        LoadMoreInfo();
        BindStatAccount();
        BindPastBills();
        BindBilledTrans();
        LoadLstFiveTrans();
        FetchPreBillPeriodDet();
    }

    protected void rmTransLevel_ItemClick(object sender, RadMenuEventArgs e)
    {
        RadTab T1, T2, T3, T4, T5, T6, T7;
        T1 = RadTabStrip2.Tabs.FindTabByText("Post Debits & Credits");
        T2 = RadTabStrip2.Tabs.FindTabByText("Billed Transactions");
        T3 = RadTabStrip2.Tabs.FindTabByText("Yet to be billed");
        T4 = RadTabStrip2.Tabs.FindTabByText("Past Bills");
        T5 = RadTabStrip2.Tabs.FindTabByText("Diary");
        T6 = RadTabStrip2.Tabs.FindTabByText("Monthly Bill Payment");
        T7 = RadTabStrip2.Tabs.FindTabByText("Group Billing");

        if (e.Item.Text == "Post Debits & Credits")
        {
            //T1.Visible = true;
            //T2.Visible = false;
            //T3.Visible = false;
            //T4.Visible = false;
            //T5.Visible = false;
            //T6.Visible = false;            

            //T1.PageView.Selected = true;
        }

        else if (e.Item.Text == "Transactions")
        {
            //T1.Visible = false;
            //T2.Visible = true;
            //T3.Visible = false;
            //T4.Visible = false;
            //T5.Visible = false;
            //T6.Visible = false;            

            //T2.PageView.Selected = true;
        }
        else if (e.Item.Text == "Unbilled Transactions")
        {
            //T1.Visible = false;
            //T2.Visible = false;
            //T3.Visible = true;
            //T4.Visible = false;
            //T5.Visible = false;
            //T6.Visible = false;            

            //T3.PageView.Selected = true;
        }
        else if (e.Item.Text == "Past Bills")
        {
            //T1.Visible = false;
            //T2.Visible = false;
            //T3.Visible = false;
            //T4.Visible = true;
            //T5.Visible = false;
            //T6.Visible = false;          

            //T4.PageView.Selected = true;
        }
        else if (e.Item.Text == "Diary")
        {
            //T1.Visible = false;
            //T2.Visible = false;
            //T3.Visible = false;
            //T4.Visible = false;
            //T5.Visible = true;
            //T6.Visible = false;

            //T5.PageView.Selected = true;
        }
        else if (e.Item.Text == "Monthly Bill Payment")
        {
            //T1.Visible = false;
            //T2.Visible = false;
            //T3.Visible = false;
            //T4.Visible = false;
            //T5.Visible = false;
            //T6.Visible = true;


            //T6.PageView.Selected = true;
        }

        else if (e.Item.Text == "Summary")
        {
            Response.Redirect("MonthlyBilling.aspx?MBVal=" + 1);
        }
        else if (e.Item.Text == "Billing History Per Resident")
        {
            Response.Redirect("ResidentTxnSummary.aspx?RSVal=" + 1);
        }
        else if (e.Item.Text == "Group Billing")
        {
            Response.Redirect("FoodBillPosting.aspx");
        }


    }

    protected void btnHelp_Click(object sender, EventArgs e)
    {
        try
        {

            DataSet DS = sqlobj.ExecuteSP("Sp_FetchBillCodeDet",

            new SqlParameter() { ParameterName = "@BCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "" });

            if (DS.Tables[0].Rows.Count > 0)
            {


                lbldescription.Text = DS.Tables[0].Rows[0]["BCodeHelp"].ToString();


            }
            else
            {
                lbldescription.Text = "";
            }

            DS.Dispose();

            rwHelp.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    //protected void btnTransPayLater_Click(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        if (CnfResult.Value == "true")
    //        {


    //            //string bcodeandcat = ddllBCode.SelectedValue;

    //            //string[] strget = bcodeandcat.Split(',');

    //            //string bcode = strget[0].ToString();
    //            //string bcat = strget[1].ToString();

    //            string strrsnfilter = DdlUhid.Text;

    //            string[] custrsn = strrsnfilter.Split(',');

    //            strrsnfilter = custrsn[3].ToString();

    //            custrsn = strrsnfilter.Split(';');

    //            Int32 RSN = Convert.ToInt32(custrsn[0].ToString());





    //            if (txtCAmount.Text != string.Empty && txtCNarration.Text != "" && txtCNarration.Text != string.Empty)
    //            {
    //                if (txtCAmount.Text != "0")
    //                {

    //                    // Transaction Type

    //                    if (ddlAmountType.SelectedValue == "1")
    //                    {
    //                        TransType = "CR";

    //                        TransNarraction = txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "2")
    //                    {
    //                        TransType = "DR";
    //                        TransNarraction = txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "3")
    //                    {
    //                        TransType = "RC";
    //                        TransNarraction = "Credit Reversal" + txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "4")
    //                    {
    //                        TransType = "RD";
    //                        TransNarraction = "Debit Reversal" + txtCNarration.Text;
    //                    }




    //                    DateTime bdate = DateTime.Now;

    //                    string strday = bdate.ToString("dd");
    //                    string strmonth = bdate.ToString("MM");
    //                    string stryear = bdate.ToString("yyyy");
    //                    string strhour = bdate.ToString("HH");
    //                    string strmin = bdate.ToString("mm");
    //                    string strsec = bdate.ToString("ss");

    //                    string strBillNo = "G" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();

    //                    sqlobj.ExecuteSP("SP_InsertTransaction",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "CASH" },
    //                        new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "CASH" },
    //                        new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = TransCategory.ToString() },
    //                        new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlBStatus.SelectedValue },
    //                        new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = txtRate.Text },
    //                        new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = txtCount.Text },
    //                        new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
    //                        new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = dtpCDate.SelectedDate },
    //                        new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
    //                        new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
    //                        new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
    //                        new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
    //                        new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() }
    //                                  );


    //                    if (ddlAmountType.SelectedValue == "3" || ddlAmountType.SelectedValue == "4")
    //                    {
    //                        sqlobj.ExecuteNonQuery("sp_inserttransactiondiary",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = ddlAmountType.SelectedItem.Text },
    //                        new SqlParameter() { ParameterName = "@MoreInfoAction", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
    //                        new SqlParameter() { ParameterName = "@MoreInfoValue", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text });
    //                    }

    //                    decimal dlastdebit = 0;
    //                    decimal dlastcredit = 0;

    //                    DataSet dsgetdebitcredittoal = null;
    //                    dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

    //                    if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
    //                    {
    //                        dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
    //                        dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
    //                        dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());
    //                    }

    //                    sqlobj.ExecuteNonQuery("SP_UpdateClosingBalance",
    //                     new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
    //                     new SqlParameter() { ParameterName = "@Closing", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding });

    //                    sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
    //                        new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
    //                        new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
    //                        new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = TransType },
    //                        new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
    //                        new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });

    //                    LoadMoreInfo();
    //                    BindStatAccount();

    //                    ClearTransScr();

    //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);
    //                }
    //                else
    //                {
    //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Amount should be greater than zero');", true);
    //                }

    //            }
    //            else
    //            {
    //                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please enter mandatory field(s)');", true);

    //            }

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);

    //    }
    //}
    //protected void btnTransCredit_Click(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        if (CnfResult.Value == "true")
    //        {

    //            // string bcodeandcat = ddllBCode.SelectedValue;

    //            //string[] strget = bcodeandcat.Split(',');

    //            //string bcode = strget[0].ToString();
    //            //string bcat = strget[1].ToString();

    //            string strrsnfilter = DdlUhid.Text;

    //            string[] custrsn = strrsnfilter.Split(',');

    //            strrsnfilter = custrsn[3].ToString();

    //            custrsn = strrsnfilter.Split(';');

    //            Int32 RSN = Convert.ToInt32(custrsn[0].ToString());



    //            if (txtCAmount.Text != string.Empty && txtCNarration.Text != "" && txtCNarration.Text != string.Empty)
    //            {
    //                if (txtCAmount.Text != "0")
    //                {

    //                    // Transaction Type

    //                    if (ddlAmountType.SelectedValue == "1")
    //                    {
    //                        TransType = "CR";

    //                        TransNarraction = txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "2")
    //                    {
    //                        TransType = "DR";
    //                        TransNarraction = txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "3")
    //                    {
    //                        TransType = "RC";
    //                        TransNarraction = "Credit Reversal" + txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "4")
    //                    {
    //                        TransType = "RD";
    //                        TransNarraction = "Debit Reversal" + txtCNarration.Text;
    //                    }




    //                    DateTime bdate = DateTime.Now;

    //                    string strday = bdate.ToString("dd");
    //                    string strmonth = bdate.ToString("MM");
    //                    string stryear = bdate.ToString("yyyy");
    //                    string strhour = bdate.ToString("HH");
    //                    string strmin = bdate.ToString("mm");
    //                    string strsec = bdate.ToString("ss");

    //                    string strBillNo = "G" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();

    //                    sqlobj.ExecuteSP("SP_InsertTransaction",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "" },
    //                        new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "" },
    //                        new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = TransCategory.ToString() },
    //                        new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlBStatus.SelectedValue },
    //                        new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = txtRate.Text },
    //                        new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = txtCount.Text },
    //                        new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
    //                        new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = dtpCDate.SelectedDate },
    //                        new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
    //                        new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
    //                        new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
    //                        new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
    //                        new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() }
    //                                  );


    //                    if (ddlAmountType.SelectedValue == "3" || ddlAmountType.SelectedValue == "4")
    //                    {
    //                        sqlobj.ExecuteNonQuery("sp_inserttransactiondiary",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = ddlAmountType.SelectedItem.Text },
    //                        new SqlParameter() { ParameterName = "@MoreInfoAction", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
    //                        new SqlParameter() { ParameterName = "@MoreInfoValue", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text });
    //                    }

    //                    decimal dlastdebit = 0;
    //                    decimal dlastcredit = 0;

    //                    DataSet dsgetdebitcredittoal = null;
    //                    dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

    //                    if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
    //                    {
    //                        dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
    //                        dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
    //                        dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());
    //                    }

    //                    sqlobj.ExecuteNonQuery("SP_UpdateClosingBalance",
    //                     new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
    //                     new SqlParameter() { ParameterName = "@Closing", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding });

    //                    sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
    //                        new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
    //                        new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
    //                        new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = TransType },
    //                        new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
    //                        new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });

    //                    LoadMoreInfo();
    //                    BindStatAccount();

    //                    ClearTransScr();

    //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);
    //                }
    //                else
    //                {
    //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Amount should be greater than zero');", true);
    //                }

    //            }
    //            else
    //            {
    //                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please enter mandatory field(s)');", true);

    //            }

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);

    //    }
    //}


    //protected void btnTransPostCrAdjust_Click(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        if (CnfResult.Value == "true")
    //        {

    //            //string bcodeandcat = ddllBCode.SelectedValue;

    //            //string[] strget = bcodeandcat.Split(',');

    //            //string bcode = strget[0].ToString();
    //            //string bcat = strget[1].ToString();

    //            string strrsnfilter = DdlUhid.Text;

    //            string[] custrsn = strrsnfilter.Split(',');

    //            strrsnfilter = custrsn[3].ToString();

    //            custrsn = strrsnfilter.Split(';');

    //            Int32 RSN = Convert.ToInt32(custrsn[0].ToString());



    //            if (txtCAmount.Text != string.Empty && txtCNarration.Text != "" && txtCNarration.Text != string.Empty)
    //            {
    //                if (txtCAmount.Text != "0")
    //                {

    //                    // Transaction Type

    //                    if (ddlAmountType.SelectedValue == "1")
    //                    {
    //                        TransType = "CR";

    //                        TransNarraction = txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "2")
    //                    {
    //                        TransType = "DR";
    //                        TransNarraction = txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "3")
    //                    {
    //                        TransType = "RC";
    //                        TransNarraction = "Credit Reversal" + txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "4")
    //                    {
    //                        TransType = "RD";
    //                        TransNarraction = "Debit Reversal" + txtCNarration.Text;
    //                    }





    //                    DateTime bdate = DateTime.Now;

    //                    string strday = bdate.ToString("dd");
    //                    string strmonth = bdate.ToString("MM");
    //                    string stryear = bdate.ToString("yyyy");
    //                    string strhour = bdate.ToString("HH");
    //                    string strmin = bdate.ToString("mm");
    //                    string strsec = bdate.ToString("ss");

    //                    string strBillNo = "G" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();

    //                    sqlobj.ExecuteSP("SP_InsertTransaction",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "" },
    //                        new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "" },
    //                        new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = TransCategory.ToString() },
    //                        new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlBStatus.SelectedValue },
    //                        new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = txtRate.Text },
    //                        new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = txtCount.Text },
    //                        new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
    //                        new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = dtpCDate.SelectedDate },
    //                        new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
    //                        new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
    //                        new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
    //                        new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
    //                        new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() }
    //                                  );


    //                    if (ddlAmountType.SelectedValue == "3" || ddlAmountType.SelectedValue == "4")
    //                    {
    //                        sqlobj.ExecuteNonQuery("sp_inserttransactiondiary",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = ddlAmountType.SelectedItem.Text },
    //                        new SqlParameter() { ParameterName = "@MoreInfoAction", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
    //                        new SqlParameter() { ParameterName = "@MoreInfoValue", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text });
    //                    }

    //                    decimal dlastdebit = 0;
    //                    decimal dlastcredit = 0;

    //                    DataSet dsgetdebitcredittoal = null;
    //                    dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

    //                    if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
    //                    {
    //                        dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
    //                        dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
    //                        dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());
    //                    }

    //                    sqlobj.ExecuteNonQuery("SP_UpdateClosingBalance",
    //                     new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
    //                     new SqlParameter() { ParameterName = "@Closing", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding });

    //                    sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
    //                        new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
    //                        new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
    //                        new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = TransType },
    //                        new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
    //                        new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });

    //                    LoadMoreInfo();
    //                    BindStatAccount();

    //                    ClearTransScr();

    //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);
    //                }
    //                else
    //                {
    //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Amount should be greater than zero');", true);
    //                }

    //            }
    //            else
    //            {
    //                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please enter mandatory field(s)');", true);

    //            }

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);

    //    }
    //}
    //protected void btnTransPostDrAdust_Click(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        if (CnfResult.Value == "true")
    //        {

    //            // string bcodeandcat = ddllBCode.SelectedValue;

    //            //string[] strget = bcodeandcat.Split(',');

    //            //string bcode = strget[0].ToString();
    //            //string bcat = strget[1].ToString();

    //           // string strrsnfilter = DdlUhid.Text;

    //            string[] custrsn = strrsnfilter.Split(',');

    //            strrsnfilter = custrsn[3].ToString();

    //            custrsn = strrsnfilter.Split(';');

    //            Int32 RSN = Convert.ToInt32(custrsn[0].ToString());



    //            if (txtCAmount.Text != string.Empty && txtCNarration.Text != "" && txtCNarration.Text != string.Empty)
    //            {
    //                if (txtCAmount.Text != "0")
    //                {

    //                    // Transaction Type

    //                    if (ddlAmountType.SelectedValue == "1")
    //                    {
    //                        TransType = "CR";

    //                        TransNarraction = txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "2")
    //                    {
    //                        TransType = "DR";
    //                        TransNarraction = txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "3")
    //                    {
    //                        TransType = "RC";
    //                        TransNarraction = "Credit Reversal" + txtCNarration.Text;
    //                    }
    //                    else if (ddlAmountType.SelectedValue == "4")
    //                    {
    //                        TransType = "RD";
    //                        TransNarraction = "Debit Reversal" + txtCNarration.Text;
    //                    }


    //                    // Transaction Category




    //                    DateTime bdate = DateTime.Now;

    //                    string strday = bdate.ToString("dd");
    //                    string strmonth = bdate.ToString("MM");
    //                    string stryear = bdate.ToString("yyyy");
    //                    string strhour = bdate.ToString("HH");
    //                    string strmin = bdate.ToString("mm");
    //                    string strsec = bdate.ToString("ss");

    //                    string strBillNo = "G" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();

    //                    DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertTransaction",
    //                          new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                          new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "" },
    //                          new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "" },
    //                          new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = TransCategory.ToString() },
    //                          new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlBStatus.SelectedValue },
    //                          new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = txtRate.Text },
    //                          new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = txtCount.Text },
    //                          new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
    //                          new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = dtpCDate.SelectedDate },
    //                          new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
    //                          new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
    //                          new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
    //                          new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
    //                          new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() }
    //                                    );




    //                    if (ddlAmountType.SelectedValue == "3" || ddlAmountType.SelectedValue == "4")
    //                    {
    //                        sqlobj.ExecuteNonQuery("sp_inserttransactiondiary",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = ddlAmountType.SelectedItem.Text },
    //                        new SqlParameter() { ParameterName = "@MoreInfoAction", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
    //                        new SqlParameter() { ParameterName = "@MoreInfoValue", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text });
    //                    }

    //                    decimal dlastdebit = 0;
    //                    decimal dlastcredit = 0;

    //                    DataSet dsgetdebitcredittoal = null;
    //                    dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

    //                    if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
    //                    {
    //                        dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
    //                        dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
    //                        dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());
    //                    }

    //                    sqlobj.ExecuteNonQuery("SP_UpdateClosingBalance",
    //                     new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
    //                     new SqlParameter() { ParameterName = "@Closing", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding });

    //                    sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
    //                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
    //                        new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
    //                        new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
    //                        new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
    //                        new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = TransType },
    //                        new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
    //                        new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });

    //                    LoadMoreInfo();
    //                    BindStatAccount();

    //                    ClearTransScr();

    //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);
    //                }
    //                else
    //                {
    //                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Amount should be greater than zero');", true);
    //                }

    //            }
    //            else
    //            {
    //                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please enter mandatory field(s)');", true);

    //            }

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);

    //    }
    //}
    protected void btnTransExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("HomeMenu.aspx");
    }



    protected void HiddenButton_Click(object sender, EventArgs e)
    {
        try
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "NavigatePopup1()", true);



            //     DataSet dsReceipt= sqlobj.ExecuteSP("SP_GetReceiptNo",
            //     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Session["ReceiptRSN"].ToString() });

            //     if (dsReceipt.Tables[0].Rows.Count > 0)
            //     {


            //         string strName = dsReceipt.Tables[0].Rows[0]["Name"].ToString();
            //         string strDoorNo = dsReceipt.Tables[0].Rows[0]["DoorNo"].ToString();
            //         string strReceiptNo = dsReceipt.Tables[0].Rows[0]["ReceiptNo"].ToString();
            //         DateTime dReceiptDate = Convert.ToDateTime(dsReceipt.Tables[0].Rows[0]["TXDATE"].ToString());
            //         string strNarration = dsReceipt.Tables[0].Rows[0]["TXDESC"].ToString();
            //         string strPayMode = dsReceipt.Tables[0].Rows[0]["BCode"].ToString();
            //         string strAmount = dsReceipt.Tables[0].Rows[0]["TXAMOUNT"].ToString();
            //         string strcname = dsReceipt.Tables[1].Rows[0]["CommunityName"].ToString();
            //         string strphone = dsReceipt.Tables[1].Rows[0]["FromMobileNo"].ToString();
            //         string stremail = dsReceipt.Tables[1].Rows[0]["FromID"].ToString();
            //         string stramtinwords = dsReceipt.Tables[0].Rows[0]["AmtInWords"].ToString();


            //         using (StringWriter sw = new StringWriter())
            //         {
            //             using (HtmlTextWriter hw = new HtmlTextWriter(sw))
            //             {
            //                 StringBuilder sb = new StringBuilder();

            //                 //Generate Invoice (Bill) Header.

            //                 sb.Append("<table width='100%' align=center cellspacing='0' cellpadding='2'>");
            //                 sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>");
            //                 sb.Append(strcname);
            //                 sb.Append("</b></td></tr>");
            //                 sb.Append("<tr><td align='center' colspan='2'>Mobile:");
            //                 sb.Append(strphone);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td align='center' colspan='2'>Email:");
            //                 sb.Append(stremail);
            //                 sb.Append("<tr><td align='center' colspan = '2'><b>Cash Receipt</b>");
            //                 sb.Append("</td></tr>");
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td><b>Receipt No: </b>");
            //                 sb.Append(strReceiptNo);
            //                 sb.Append("</td><td align = 'right'><b>Date: </b>");
            //                 sb.Append(dReceiptDate.ToString("dd/MM/yyyy"));
            //                 sb.Append("</td></tr>");
            //                 sb.Append("</table>");
            //                 sb.Append("<br />");


            //                 sb.Append("<table width='100%' cellspacing='0' cellpadding='2' border='1'>");
            //                 sb.Append("<tr><td ><b>Received From:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strName);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td ><b>Door No:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strDoorNo);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td ><b>Amount:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strAmount);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td ><b>Payment Mode:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strPayMode);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td ><b>Remarks:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strNarration);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("</table>");
            //                 sb.Append("<br/>");

            //                 sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
            //                 sb.Append("<tr><td align='left' ><b>Amt in words : </b><u>");
            //                 sb.Append(stramtinwords);    
            //                 sb.Append("</u></td></tr>");
            //                 sb.Append("</table>");
            //                 sb.Append("<br/>");
            //                 sb.Append("<br/>");

            //                 sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
            //                 sb.Append("<tr><td align='right' ><b>Signed By</b></td></tr>");
            //                 sb.Append("</table>");
            //                 sb.Append("<br/>");
            //                 sb.Append("<br />");
            //                 sb.Append("<br />");





            //                 sb.Append("<table width='100%' align=center cellspacing='0' cellpadding='2'>");
            //                 sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>");
            //                 sb.Append(strcname);
            //                 sb.Append("</b></td></tr>");
            //                 sb.Append("<tr><td align='center' colspan='2'>Mobile:");
            //                 sb.Append(strphone);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td align='center' colspan='2'>Email:");
            //                 sb.Append(stremail);
            //                 sb.Append("<tr><td align='center' colspan = '2'><b>Cash Receipt</b>");
            //                 sb.Append("</td></tr>");
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td><b>Receipt No: </b>");
            //                 sb.Append(strReceiptNo);
            //                 sb.Append("</td><td align = 'right'><b>Date: </b>");
            //                 sb.Append(dReceiptDate.ToString("dd/MM/yyyy"));
            //                 sb.Append("</td></tr>");
            //                 sb.Append("</table>");
            //                 sb.Append("<br />");


            //                 sb.Append("<table width='100%' cellspacing='0' cellpadding='2' border='1'>");
            //                 sb.Append("<tr><td ><b>Received From:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strName);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td ><b>Door No:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strDoorNo);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td ><b>Amount:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strAmount);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td ><b>Payment Mode:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strPayMode);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("<tr><td ><b>Remarks:</b></td>");
            //                 sb.Append("<td>");
            //                 sb.Append(strNarration);
            //                 sb.Append("</td></tr>");
            //                 sb.Append("</table>");
            //                 sb.Append("<br/>");

            //                 sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
            //                 sb.Append("<tr><td align='left' ><b>Amt in words : </b><u>");
            //                 sb.Append(stramtinwords);
            //                 sb.Append("</u></td></tr>");
            //                 sb.Append("</table>");
            //                 sb.Append("<br/>");
            //                 sb.Append("<br/>");

            //                 sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
            //                 sb.Append("<tr><td align='right' ><b>Signed By</b></td></tr>");
            //                 sb.Append("</table>");
            //                 sb.Append("<br/>");


            //                 ////Generate Invoice (Bill) Items Grid.
            //                 //sb.Append("<table border = '1'>");
            //                 //sb.Append("<tr>");
            //                 //foreach (DataColumn column in dt.Columns)
            //                 //{
            //                 //    sb.Append("<th style = 'background-color: #D20B0C;color:#ffffff'>");
            //                 //    sb.Append(column.ColumnName);
            //                 //    sb.Append("</th>");
            //                 //}
            //                 //sb.Append("</tr>");
            //                 //foreach (DataRow row in dt.Rows)
            //                 //{
            //                 //    sb.Append("<tr>");
            //                 //    foreach (DataColumn column in dt.Columns)
            //                 //    {
            //                 //        sb.Append("<td>");
            //                 //        sb.Append(row[column]);
            //                 //        sb.Append("</td>");
            //                 //    }
            //                 //    sb.Append("</tr>");
            //                 //}
            //                 //sb.Append("<tr><td align = 'right' colspan = '");
            //                 //sb.Append(dt.Columns.Count - 1);
            //                 //sb.Append("'>Total</td>");
            //                 //sb.Append("<td>");
            //                 //sb.Append(dt.Compute("sum(Total)", ""));
            //                 //sb.Append("</td>");
            //                 //sb.Append("</tr></table>");

            //                 //Export HTML String as PDF.
            //                 StringReader sr = new StringReader(sb.ToString());
            //                 Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
            //                 HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            //                 PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            //                 pdfDoc.Open();
            //                 htmlparser.Parse(sr);
            //                 pdfDoc.Close();
            //                 Response.ContentType = "application/pdf";
            //                 Response.AddHeader("content-disposition", "attachment;filename=Receipt_" + strReceiptNo.ToString() + ".pdf");
            //                 Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //                 Response.Write(pdfDoc);
            //                 Response.End();
            //             }
            //         }


            //         //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);

            //         //// WebMsgBox.Show("Transactions details saved successfully");
            //         //ClearTransScr();
            //     }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        ShowBalance();

    }

    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        ShowBalance();

    }

    protected void ShowBalance()
    {
        String CBAmount;
        if (ddlPayMode.SelectedValue == "DEPOSIT")
        {
            lbldeposit.Visible = true;


            //string strrsnfilter = DdlUhid.Text;

            //string[] custrsn = strrsnfilter.Split(',');

            //strrsnfilter = custrsn[3].ToString();

            //string custname = custrsn[2].ToString();

            //string doorno = custrsn[1].ToString();

            //custrsn = strrsnfilter.Split(';');

            //Int32 RSN = Convert.ToInt32(custrsn[0].ToString());


            DataSet dsdeposit = sqlobj.ExecuteSP("SP_GetDeposit",
                   new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = cmbResident.SelectedValue });


            if (dsdeposit.Tables[0].Rows.Count > 0)
            {
                Session["BalAmount"] = dsdeposit.Tables[0].Rows[0]["Amount"].ToString();


                if (Convert.ToDecimal(dsdeposit.Tables[0].Rows[0]["Amount"].ToString()) >= 0)
                {
                    CBAmount = dsdeposit.Tables[0].Rows[0]["Amount"].ToString();
                }
                else
                {
                    CBAmount = Convert.ToString(Convert.ToDecimal(dsdeposit.Tables[0].Rows[0]["Amount"]) * -1) + " CR";
                }


                lbldeposit.Text = "Account No: " + dsdeposit.Tables[0].Rows[0]["AccountNo"].ToString() + " || Current Balance: " + CBAmount;
            }
            else
            {
                lbldeposit.Text = "Deposit Account No:" + " Current Balance:";
            }

            dsdeposit.Dispose();


        }
        else
        {
            lbldeposit.Text = string.Empty;
            lblNewBalance.Text = string.Empty;


            lbldeposit.Visible = true;


            //string strrsnfilter = DdlUhid.Text;

            //string[] custrsn = strrsnfilter.Split(',');

            //strrsnfilter = custrsn[3].ToString();

            //string custname = custrsn[2].ToString();

            //string doorno = custrsn[1].ToString();

            //custrsn = strrsnfilter.Split(';');

            //Int32 RSN = Convert.ToInt32(custrsn[0].ToString());


            if (rdoLedger.SelectedValue == "1")
            {
                Session["RTRSN"] = cmbResident.SelectedValue;
                Session["AccountType"] = "R";
                Session["iMode"] = 2;
            }
            else if (rdoLedger.SelectedValue == "3")
            {
                Session["RTRSN"] = cmbGGenearl.SelectedValue;
                Session["AccountType"] = "G";
                Session["iMode"] = 3;
            }
            else if (rdoLedger.SelectedValue == "2")
            {
                Session["RTRSN"] = cmbGeneral.SelectedValue;
                Session["AccountType"] = "H";
                Session["iMode"] = 3;
            }




            if (Session["RTRSN"] != null && Session["iMode"] != null)
            {


                DataSet dsdeposit = sqlobj.ExecuteSP("SP_GetDeposit",
                       new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = Session["iMode"].ToString() },
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() });


                if (dsdeposit.Tables[0].Rows.Count > 0)
                {
                    Session["BalAmount"] = dsdeposit.Tables[0].Rows[0]["Amount"].ToString();



                    if (Convert.ToDecimal(dsdeposit.Tables[0].Rows[0]["Amount"].ToString()) >= 0)
                    {
                        CBAmount = dsdeposit.Tables[0].Rows[0]["Amount"].ToString();
                    }
                    else
                    {
                        CBAmount = Convert.ToString(Convert.ToDecimal(dsdeposit.Tables[0].Rows[0]["Amount"]) * -1) + " CR";
                    }


                    lbldeposit.Text = "Account No: " + dsdeposit.Tables[0].Rows[0]["AccountNo"].ToString() + " || Current Balance: " + CBAmount;
                }
                else
                {
                    lbldeposit.Text = "Account No:" + " Current Balance:";
                }

                dsdeposit.Dispose();

            }
        }

    }

    protected void btnSaveTime_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = true;
    }

    protected void ddlsavetime_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsavetime.SelectedItem.ToString() != "")
        {
            string strAppend = ddlsavetime.SelectedItem.ToString();
            txtCNarration.Text = txtCNarration.Text + " " + strAppend + " ";
        }
    }

    protected void btnSTSave_Click(object sender, EventArgs e)
    {
        try
        {
            sqlobj.ExecuteSQLNonQuery("SP_InsertSaveTimeEntry",
                                           new SqlParameter() { ParameterName = "@SaveTimeEntry", SqlDbType = SqlDbType.NVarChar, Value = txtInfo.Text },
                                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = null }
                                           );

            LoadSaveTime();
            STClear();
            WebMsgBox.Show("Your details are saved");
            rwSaveTime.Visible = true;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSTClear_Click(object sender, EventArgs e)
    {
        STClear();
        rwSaveTime.Visible = true;
    }
    protected void gvSaveTime_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);

                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                string st = mygrid.Rows[index].Cells[1].Text;

                if (txtCNarration.Text != "")
                {
                    txtCNarration.Text = txtCNarration.Text + " " + st.ToString();
                }
                else
                {
                    txtCNarration.Text = txtCNarration.Text + st.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    //protected void btnSaveTime_Click(object sender, EventArgs e)
    //{
    //    rwSaveTime.Visible = true;
    //}

    protected void btnSTClose_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = false;
    }

    private void STClear()
    {
        txtInfo.Text = "";
        //txtstremarks.Text = "";
    }

    protected void LoadSaveTime()
    {
        DataSet dsSaveTime = new DataSet();
        dsSaveTime = sqlobj.ExecuteSP("SP_GetSaveTimeEntry");

        if (dsSaveTime.Tables[0].Rows.Count != 0)
        {
            gvSaveTime.DataSource = dsSaveTime;
            gvSaveTime.DataBind();

            ddlsavetime.DataSource = dsSaveTime;
            ddlsavetime.DataTextField = "Savetimeentry";
            ddlsavetime.DataValueField = "Savetimeentry";
            ddlsavetime.DataBind();
        }

        ddlsavetime.Items.Insert(0, "");


        //ddlTrackon.SelectedIndex = 4;
        dsSaveTime.Dispose();
    }

    protected void rdoLedger_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (rdoLedger.SelectedValue  == "1" )
            {
                cmbResident.Visible = true;
                cmbGeneral.Visible = false;
                cmbGGenearl.Visible = false;

                Label59.Text = "For which Resident Account?Search by";
            }
            else if (rdoLedger.SelectedValue == "2")
            {
                cmbResident.Visible = false;
                cmbGeneral.Visible = true;
                cmbGGenearl.Visible = false;

                Label59.Text = "For which Guest house Ledger Account?Search by";
            }

            else if (rdoLedger.SelectedValue == "3")
            {
                cmbResident.Visible = false;
                cmbGeneral.Visible = false;
                cmbGGenearl.Visible = true;

                Label59.Text = "For which General Ledger Account?Search by";
            }

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {


            string strrsnfilter = cmbResident.SelectedItem.Text;

            string[] custrsn = strrsnfilter.Split(',');

            string custname = custrsn[0].ToString();

            string doorno = custrsn[1].ToString();


            lblresidentname.Text = custname.ToString();
            lblDoorno.Text = doorno.ToString();


            DataSet dsdeposit = sqlobj.ExecuteSP("SP_GetDeposit",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = cmbResident.SelectedValue });

           if (dsdeposit.Tables[0].Rows.Count >0)
           {
               lblAccountNo.Text = dsdeposit.Tables[0].Rows[0]["AccountNo"].ToString();
           }

           dsdeposit.Dispose();
            

            DataSet dsTransactions = sqlobj.ExecuteSP("SP_LatestTransactions",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = lblAccountNo.Text }
                );

            if (dsTransactions.Tables[0].Rows.Count != 0)
            {
                gvTransactions.DataSource = dsTransactions;
                gvTransactions.DataBind();


            }

            else
            {
                gvTransactions.DataSource = string.Empty;
                gvTransactions.DataBind();
            }


            dsTransactions.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void cmbGeneral_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {


            string strrsnfilter = cmbGeneral.SelectedItem.Text;

            string[] custrsn = strrsnfilter.Split(',');

            string custname = custrsn[0].ToString();

            //string doorno = custrsn[1].ToString();


            lblresidentname.Text = custname.ToString();
           // lblDoorno.Text = doorno.ToString();

            DataSet dsdeposit = sqlobj.ExecuteSP("SP_GetDeposit",
              new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = cmbGeneral.SelectedValue });

            if (dsdeposit.Tables[0].Rows.Count > 0)
            {
                lblAccountNo.Text = dsdeposit.Tables[0].Rows[0]["AccountNo"].ToString();
            }


            DataSet dsTransactions = sqlobj.ExecuteSP("SP_LatestTransactions",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbGeneral.SelectedValue },
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 },
                new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = lblAccountNo.Text }
                );

            if (dsTransactions.Tables[0].Rows.Count != 0)
            {
                gvTransactions.DataSource = dsTransactions;
                gvTransactions.DataBind();


            }

            else
            {
                gvTransactions.DataSource = string.Empty;
                gvTransactions.DataBind();
            }


            dsTransactions.Dispose();

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void cmbGGenearl_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {


            string strrsnfilter = cmbGGenearl.SelectedItem.Text;

            string[] custrsn = strrsnfilter.Split(',');

            string custname = custrsn[0].ToString();

            //string doorno = custrsn[1].ToString();


            lblresidentname.Text = custname.ToString();
            // lblDoorno.Text = doorno.ToString();

            DataSet dsdeposit = sqlobj.ExecuteSP("SP_GetDeposit",
              new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = cmbGGenearl.SelectedValue });

            if (dsdeposit.Tables[0].Rows.Count > 0)
            {
                lblAccountNo.Text = dsdeposit.Tables[0].Rows[0]["AccountNo"].ToString();
            }


            DataSet dsTransactions = sqlobj.ExecuteSP("SP_LatestTransactions",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbGGenearl.SelectedValue },
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = lblAccountNo.Text }
                );

            if (dsTransactions.Tables[0].Rows.Count > 0)
            {
                gvTransactions.DataSource = dsTransactions;
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
            WebMsgBox.Show(ex.Message);
        }

    }
}