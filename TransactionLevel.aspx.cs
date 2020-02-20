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

//using iTextSharp.text;
//using iTextSharp.text.html.simpleparser;
//using iTextSharp.text.pdf;


using System.IO;

using System.Globalization;

public partial class TransactionLevel : System.Web.UI.Page
{
    decimal dlastOutStanding;
    DateTime dlastCreditDate;
    DateTime dlastDebitDate;


    SqlProcsNew sqlobj = new SqlProcsNew();
    static string UserID;
    static string CustomerRSN;
    string TransType;
    string TransNarraction;


    int CNT = 0;
    int i;
    int TaskCnt;
    string BID;

    protected void Page_Load(object sender, EventArgs e)
    {


        DataSet dsDT = null;
        if (!IsPostBack)
        {
            LoadBillingCode();            
            BindGeneralInfrm();
            loadCustDetails();
            LoadBillingPeriod();
            lblSelCustName.Visible = true;
            

            dsDT = sqlobj.ExecuteSP("GetServerDateTime");

            dtpCDate.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);


        }

        LoadMoreInfo();
        BindStatAccount();
        BindPastBills();
        BindBilledTrans();
        LoadLstFiveTrans();
        

        rwMoreInfo.VisibleOnPageLoad = true;
        rwMoreInfo.Visible = false;
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
            rdgLFTrans.DataSource = dsLFTrans.Tables[0];
            rdgLFTrans.DataBind();
            rdgLFTrans.Dispose();
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
            if (txtvalue.Text == string.Empty)
            {
                IVal = 0;
            }
            else
            {
                IVal = Convert.ToDecimal(txtvalue.Text);
            }

            sqlobj.ExecuteNonQuery("SP_InsertDiary2",
                                          new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Session["ResidentRSN"])},
                                          new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = txtdescription.Text },
                                          new SqlParameter() { ParameterName = "@MoreInfoAction", SqlDbType = SqlDbType.NVarChar, Value = txttext.Text },
                                          new SqlParameter() { ParameterName = "@MoreInfoValue", SqlDbType = SqlDbType.Decimal, Value = IVal });
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

            sqlobj.ExecuteNonQuery("SP_UpdateDiary",
                                            new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = txtdescription.Text },
                                            new SqlParameter() { ParameterName = "@MoreInfoAction", SqlDbType = SqlDbType.NVarChar, Value = txttext.Text },
                                            new SqlParameter() { ParameterName = "@MoreInfoValue", SqlDbType = SqlDbType.Decimal, Value = txtvalue.Text },
                //new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
           new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = RSN });



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
        {
            try
            {
                decimal damount = Convert.ToDecimal(txtCAmount.Text);
                LoadTotalAmounttowords(damount);
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
        if (CnfResult.Value == "true")
        {

            if (Session["ResidentRSN"] != "")
           
            {
                int RSN = Convert.ToInt32(Session["ResidentRSN"]);

                if (TxtRTRSN.Text != string.Empty &&
                    txtCAmount.Text != string.Empty && txtCAmount.Text != "0" && txtCNarration.Text != "" && txtCNarration.Text != string.Empty)
                {
                    if (ddlAmountType.SelectedValue == "1")
                    {
                        TransType = "CR";

                        TransNarraction = txtCNarration.Text;
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

                    sqlobj.ExecuteSP("SP_InsertTransaction",
                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
                        new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = ddllBCode.SelectedValue },
                        new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlBStatus.SelectedValue },
                        new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = txtRate.Text },
                        new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = txtCount.Text },                        
                        new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
                        new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = dtpCDate.SelectedDate },
                        new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
                        new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction });
                    
                   
                    if (ddlAmountType.SelectedValue == "3" || ddlAmountType.SelectedValue == "4")
                    {
                        sqlobj.ExecuteNonQuery("sp_inserttransactiondiary",
                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
                        new SqlParameter() { ParameterName = "@MoreInfoResponse", SqlDbType = SqlDbType.NVarChar, Value = ddlAmountType.SelectedItem.Text },
                        new SqlParameter() { ParameterName = "@MoreInfoAction", SqlDbType = SqlDbType.NVarChar, Value = TransNarraction },
                        new SqlParameter() { ParameterName = "@MoreInfoValue", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text });                       
                    }

                    decimal dlastdebit = 0;
                    decimal dlastcredit = 0;
                    
                    DataSet dsgetdebitcredittoal = null;
                    dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = RSN });

                    if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
                    {
                        dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
                        dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
                        dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());                     
                    }

                    sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
                        new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
                        new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
                        new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
                        new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = TransType },
                        new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
                        new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });

                    LoadMoreInfo();
                    BindStatAccount();


                    WebMsgBox.Show("Transactions details saved successfully");
                    ClearTransScr();
                   
                }
                else
                {
                    WebMsgBox.Show("Please enter mandatory field(s)");                   
                }
            }
            else
            {

            }
        }
        else
        {

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

            if (dsACDet.Tables[2].Rows[0]["BPFrom"].ToString() != "" && dsACDet.Tables[2].Rows[0]["BPFrom"].ToString() != string.Empty && dsACDet.Tables[2].Rows[0]["BPTill"].ToString() != "" && dsACDet.Tables[2].Rows[0]["BPTill"].ToString() != string.Empty)
            {
                lblBillFrom.Text = dsACDet.Tables[2].Rows[0]["BPFrom"].ToString();
                lblBillTo.Text = dsACDet.Tables[2].Rows[0]["BPTill"].ToString();
            }
            if (dsACDet.Tables[3].Rows[0]["BPFrom"].ToString() != "" && dsACDet.Tables[3].Rows[0]["BPFrom"].ToString() != string.Empty && dsACDet.Tables[3].Rows[0]["BPTill"].ToString() != "" && dsACDet.Tables[3].Rows[0]["BPTill"].ToString() != string.Empty)
            {
                lblLBillFrom.Text = dsACDet.Tables[3].Rows[0]["BPFrom"].ToString();
                lblLBillTo.Text = dsACDet.Tables[3].Rows[0]["BPTill"].ToString();
            }
            if (dsACDet.Tables[4].Rows[0]["OS"].ToString() != "" && dsACDet.Tables[4].Rows[0]["OS"].ToString() != string.Empty)
            {
                Decimal OutStand = Convert.ToDecimal(dsACDet.Tables[4].Rows[0]["OS"].ToString());
                if (OutStand > 0)
                {
                    lblUBillAmt.Text = dsACDet.Tables[4].Rows[0]["OS"].ToString()+" DR";
                }
                else if (OutStand < 0)
                {
                    lblUBillAmt.Text = Math.Abs(Convert.ToDecimal(dsACDet.Tables[4].Rows[0]["OS"].ToString())) + " CR";
                }
                
            }

            if (dsACDet.Tables[1].Rows[0]["OutStanding"].ToString() != "" && dsACDet.Tables[1].Rows[0]["OutStanding"].ToString() != string.Empty)
            {
                double TotAmt = Convert.ToDouble(dsACDet.Tables[1].Rows[0]["OutStanding"].ToString());
                //lblTotal.Text = TotAmt.ToString("C", CultureInfo.CreateSpecificCulture("en-IN")) + dsACDet.Tables[1].Rows[0]["OSD"].ToString();
            }
            if (dsACDet.Tables[1].Rows[0]["SumDR"].ToString() != "" && dsACDet.Tables[1].Rows[0]["SumDR"].ToString() != string.Empty)
            {
                double TotAmt = Convert.ToDouble(dsACDet.Tables[1].Rows[0]["SumDR"].ToString());
                //lblDebit.Text = TotAmt.ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
            }
            if (dsACDet.Tables[1].Rows[0]["SumCR"].ToString() != "" && dsACDet.Tables[1].Rows[0]["SumCR"].ToString() != string.Empty)
            {
                double TotAmt = Convert.ToDouble(dsACDet.Tables[1].Rows[0]["SumCR"].ToString());
                //lblCredit.Text = TotAmt.ToString("C", CultureInfo.CreateSpecificCulture("en-IN"));
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
                lblSelCustName.Text = " Villa Number : " + dsProfile.Tables[0].Rows[0]["RTVILLANO"].ToString() + " || Status :  " + dsProfile.Tables[0].Rows[0]["RStatus"].ToString() + " || Name : " + dsProfile.Tables[0].Rows[0]["Name"].ToString();
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
                txtdescription.Text = dsmoreinfo.Tables[0].Rows[0]["Response"].ToString();
                txttext.Text = dsmoreinfo.Tables[0].Rows[0]["moreinfotext"].ToString();
                txtvalue.Text = dsmoreinfo.Tables[0].Rows[0]["moreinfovalue"].ToString();
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

    #region Load Billing Code drop down
    protected void LoadBillingCode()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistBCode = new DataSet();

            ddlistBCode = sqlobj.ExecuteSP("SP_FetchBillingCodeDropDown",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 });
            ddllBCode.DataSource = ddlistBCode.Tables[0];
            ddllBCode.DataValueField = "BCode";
            ddllBCode.DataTextField = "BCodeDescription";
            ddllBCode.DataBind();
            ddllBCode.Dispose();
            ddllBCode.Items.Insert(0, new ListItem("--General--", "GENERAL"));

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    #endregion
    protected void ddllBCode_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    //Rangan

    protected void ddlAmountType_Changed(object sender, EventArgs e)
    {
        if (ddlAmountType.SelectedValue == "2" || ddlAmountType.SelectedValue == "4")
        {
            DataSet DS = new DataSet();


            DS = sqlobj.ExecuteSP("Sp_FetchBillCodeDet",

            new SqlParameter() { ParameterName = "@BCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddllBCode.SelectedValue });

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
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = RSN });
            rdgBilledTrans.DataSource = dsBTrans.Tables[0];
            rdgBilledTrans.DataBind();
            dsBTrans.Dispose();            
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
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
            FileName = "BT_" + Session["VName"].ToString() + "_" + CDate ;

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
            FileName = "UBT_" + Session["VName"].ToString() + "_" + CDate ;

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
        }
        catch (Exception ex)
        { 
        
        }
    
    }

    protected void btnPMBSave_Click(object sender, EventArgs e)
    {
        try
        {
            decimal RRSN = Convert.ToDecimal(Session["ResidentRSN"]);
            if (CnfResult.Value == "true")
            {
                sqlobj.ExecuteNonQuery("SP_InsertPreMonthBill",
                    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = RRSN },
                    new SqlParameter() { ParameterName = "@BillPeriod", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingPeriod.SelectedItem.ToString() },
                    new SqlParameter() { ParameterName = "@AmtReceivedNow", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(txtAmtReceivedNow.Text) });
            }         
           
            WebMsgBox.Show("Billing amount saved");            
            txtAmtReceivedNow.Text = string.Empty;
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
}

