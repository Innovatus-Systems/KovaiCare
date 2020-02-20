using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;

public partial class GuestChkInOut : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    string TransType;
    string TransNarraction;
    string TransCategory;

    string strrsn = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            rwPosting.VisibleOnPageLoad = true;
            rwPosting.Visible = false;
            rwTransactions.VisibleOnPageLoad = true;
            rwTransactions.Visible = false;
            rwPayment.VisibleOnPageLoad = true;
            rwPayment.Visible = false;
            if (!IsPostBack)
            {
                LoadTitle();
                LoadGuestBookingDetails();
                LoadFacilityGroup();
                LoadResidentDet();
                ddlBookingFor.Items.Insert(0, "--Select--");
                //dtpfromdate.MinDate = DateTime.Now.AddDays(1);
                //dtptilldate.MinDate = DateTime.Now.AddDays(1);
                btnSave.Visible = false;
                btnUpdate.Visible = false;
                lblcresident.Visible = false;
                cmbResident.Visible = false;
                ddlAmountType.SelectedIndex = 1;
                LoadCashType();
                LoadPaymentGroup();
                dtpCDate.SelectedDate = DateTime.Now;
                lblstatus.Visible = false;
                ddlStatus.Visible = false;
                if (Session["GBRSN"] != null)
                {
                    LoadBookingDetails(Convert.ToInt64( Session["GBRSN"].ToString()));
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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

    private void LoadFacilityGroup()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_FacilityGroup",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 });

            ddlBookingType.Items.Clear();

            if (dsCategory.Tables[0].Rows.Count > 0)
            {


                ddlBookingType.DataSource = dsCategory;
                ddlBookingType.DataTextField = "FacilityGroup";
                ddlBookingType.DataValueField = "RSN";
                ddlBookingType.DataBind();

            }


            ddlBookingType.Items.Insert(0, "--Select--");

            dsCategory.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadPaymentGroup()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_FacilityGroup",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });         

            if (dsCategory.Tables[0].Rows.Count > 0)
            {

                ddlPayMode.DataSource = dsCategory;
                ddlPayMode.DataTextField = "Txncode";
                ddlPayMode.DataValueField = "ContraAC";
                ddlPayMode.DataBind();
            }
            ddlPayMode.Items.Insert(0, "--Select--");
            dsCategory.Dispose();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 138 });


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

    protected void ddlBookingType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadBookingFor();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void Clear()
    {
        try
        {
            ddlBookingType.SelectedIndex = 0;
            ddlBookingFor.SelectedIndex = 0;
            dtpfromdate.SelectedDate = null;
            dtptilldate.SelectedDate = null;
            dtpfromTime.SelectedTime = null;
            dtptoTime.SelectedTime = null;
            //dtpActualFromDate.SelectedDate = null;
            //dtpActualTillDate.SelectedDate = null;
            cmbResident.SelectedValue = "0";
            cmbResident.Visible = false;
            lblcresident.Visible = false;

            txtName.Text = "";
            txtAddress.Text = "";
            txtEmailID.Text = "";
            txtMobileNo.Text = "";
            txtRemarks.Text = "";
            //txtAmount.Text = "";
            //txtDiningAmount.Text = "";
            //txtOtherAmount.Text = "";
            //txttaxamount.Text = "";
            //txttotalAmount.Text = "";
            //ddlStatus.SelectedIndex = 0;

            LoadGuestBookingDetails();

            btnSave.Visible = false;
            btnUpdate.Visible = false;

            Session["GBRSN"] = null;

            //dtpActualFromDate.Visible = false;
            //dtpActualTillDate.Visible = false;

            //lblactualfromdate.Visible = false;
            //lblactualtilldate.Visible = false;

            //lblcActualcheckintime.Visible = false;
            //lblcActualcheckouttime.Visible = false;

            //dtpAfromtime.Visible = false;
            //dtpAToTime.Visible = false;

            //lblcamount.Visible = false;
            //txtAmount.Visible = false;


            //lblstatus.Visible = false;
            //ddlStatus.Visible = false;


            //lblcamount.Visible = false;
            //txtAmount.Visible = false;

            //lblcotheramount.Visible = false;
            //txtOtherAmount.Visible = false;
            //lblctaxamount.Visible = false;
            //txttaxamount.Visible = false;
            //lblctaxamount.Visible = false;
            //lblTotalamount.Visible = false;
            //txttotalAmount.Visible = false;
            //lblcDiningamount.Visible = false;
            //txtDiningAmount.Visible = false;
            //lbltaxpercentage.Visible = false;
            //txtSGSTAmouont.Visible = false;
            //lblsgstamount.Visible = false;
            //lblsgstpercentage.Visible = false;



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadGuestBookingDetails()
    {
        try
        {

            DataSet dsGuestBookingDetails = sqlobj.ExecuteSP("SP_GuestBooking",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 9 }
                );


            if (dsGuestBookingDetails.Tables[0].Rows.Count > 0)
            {
                gvGuestBooking.DataSource = dsGuestBookingDetails;
                gvGuestBooking.DataBind();

                lnkcount.Text = "Count:" + dsGuestBookingDetails.Tables[0].Rows.Count;
            }
            else
            {
                gvGuestBooking.DataSource = string.Empty;
                gvGuestBooking.DataBind();

                lnkcount.Text = "Count:0";
            }


            dsGuestBookingDetails.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {



                string status = "";


                sqlobj.ExecuteSQLNonQuery("SP_GuestBooking",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@BookingType", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingType.SelectedValue },
                       new SqlParameter() { ParameterName = "@BookingFor", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingFor.SelectedValue },
                       new SqlParameter() { ParameterName = "@Purpose", SqlDbType = SqlDbType.NVarChar, Value = ddlPurpose.SelectedValue },
                       new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
                       new SqlParameter() { ParameterName = "@Address", SqlDbType = SqlDbType.NVarChar, Value = txtAddress.Text },
                       new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = txtMobileNo.Text },
                       new SqlParameter() { ParameterName = "@EmailId", SqlDbType = SqlDbType.NVarChar, Value = txtEmailID.Text },
                    //new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = dtpfromdate.SelectedDate == null ? null : dtpfromdate.SelectedDate },
                    //new SqlParameter() { ParameterName = "@TillDate", SqlDbType = SqlDbType.DateTime, Value = dtptilldate.SelectedDate == null ? null : dtptilldate.SelectedDate },
                    new SqlParameter() { ParameterName = "@ActualFromDate", SqlDbType = SqlDbType.DateTime, Value = dtpfromdate.SelectedDate == null ? null : dtpfromdate.SelectedDate },
                    new SqlParameter() { ParameterName = "@ActualTillDate", SqlDbType = SqlDbType.DateTime, Value = dtptilldate.SelectedDate == null ? null : dtptilldate.SelectedDate },
                    //new SqlParameter() { ParameterName = "@CheckInTime", SqlDbType = SqlDbType.Time, Value = dtpfromTime.SelectedTime == null ? null : dtpfromTime.SelectedTime },
                    //new SqlParameter() { ParameterName = "@CheckOutTime", SqlDbType = SqlDbType.Time, Value = dtptoTime.SelectedTime == null ? null : dtptoTime.SelectedTime },
                    new SqlParameter() { ParameterName = "@ActualCheckInTime", SqlDbType = SqlDbType.Time, Value = dtpfromTime.SelectedTime == null ? null : dtpfromTime.SelectedTime },
                    new SqlParameter() { ParameterName = "@ActualCheckOutTime", SqlDbType = SqlDbType.Time, Value = dtptoTime.SelectedTime == null ? null : dtptoTime.SelectedTime },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "30" },
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() },
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue == "0" ? null : cmbResident.SelectedValue },
                        new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text }
                    //new SqlParameter() { ParameterName = "@Amount", SqlDbType = SqlDbType.Decimal, Value = txtAmount.Text == "" ? "0" : txtAmount.Text },
                    //new SqlParameter() { ParameterName = "@DiningAmount", SqlDbType = SqlDbType.Decimal, Value = txtDiningAmount.Text == "" ? "0" : txtDiningAmount.Text },
                    //new SqlParameter() { ParameterName = "@OtherAmount", SqlDbType = SqlDbType.Decimal, Value = txtOtherAmount.Text == "" ? "0" : txtOtherAmount.Text },
                    //new SqlParameter() { ParameterName = "@TaxAmount", SqlDbType = SqlDbType.Decimal, Value = txttaxamount.Text == "" ? "0" : txttaxamount.Text }

                       );

                Clear();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Booking details saved');", true);
            }



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


               
                //if (ddlStatus.SelectedValue == "20")
                //{

                    string strAccountno = "";


                    DataSet dsAccountNo = sqlobj.ExecuteSP("SP_GuestHouseAccountMaster",
                                          new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = hbtnRSN.Value },
                                          new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 });

                    if (dsAccountNo.Tables[0].Rows.Count > 0)
                    {
                        strAccountno = dsAccountNo.Tables[0].Rows[0]["Accountcode"].ToString();
                    }

                    if (strAccountno.ToString() == "")
                    {

                        sqlobj.ExecuteSQLNonQuery("SP_GuestHouseAccountMaster",
                                  new SqlParameter() { ParameterName = "@AccountName", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
                                  new SqlParameter() { ParameterName = "@AccountGroup", SqlDbType = SqlDbType.NVarChar, Value = "2-Liability" },
                                  new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "H" },
                                  new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = "Guest House AccountCode" },
                                  new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                  new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value =Convert.ToDecimal(hbtnRSN.Value) },
                                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 }
                                  );
                    }
               // }


                string status = "";


                sqlobj.ExecuteSQLNonQuery("SP_GuestBooking",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@BookingType", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingType.SelectedValue },
                       new SqlParameter() { ParameterName = "@BookingFor", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingFor.SelectedValue },
                       new SqlParameter() { ParameterName = "@Purpose", SqlDbType = SqlDbType.NVarChar, Value = ddlPurpose.SelectedValue },
                       new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
                       new SqlParameter() { ParameterName = "@Address", SqlDbType = SqlDbType.NVarChar, Value = txtAddress.Text },
                       new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = txtMobileNo.Text },
                       new SqlParameter() { ParameterName = "@EmailId", SqlDbType = SqlDbType.NVarChar, Value = txtEmailID.Text },
                       //new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = dtpfromdate.SelectedDate == null ? null : dtpfromdate.SelectedDate },
                       //new SqlParameter() { ParameterName = "@TillDate", SqlDbType = SqlDbType.DateTime, Value = dtptilldate.SelectedDate == null ? null : dtptilldate.SelectedDate },
                    new SqlParameter() { ParameterName = "@ActualFromDate", SqlDbType = SqlDbType.DateTime, Value = dtpfromdate.SelectedDate == null ? null : dtpfromdate.SelectedDate },
                    new SqlParameter() { ParameterName = "@ActualTillDate", SqlDbType = SqlDbType.DateTime, Value = dtptilldate.SelectedDate == null ? null : dtptilldate.SelectedDate },
                       //new SqlParameter() { ParameterName = "@CheckInTime", SqlDbType = SqlDbType.Time, Value = dtpfromTime.SelectedTime == null ? null : dtpfromTime.SelectedTime },
                       //new SqlParameter() { ParameterName = "@CheckOutTime", SqlDbType = SqlDbType.Time, Value = dtptoTime.SelectedTime == null ? null : dtptoTime.SelectedTime },
                    new SqlParameter() { ParameterName = "@ActualCheckInTime", SqlDbType = SqlDbType.Time, Value = dtpfromTime.SelectedTime == null ? null : dtpfromTime.SelectedTime },
                    new SqlParameter() { ParameterName = "@ActualCheckOutTime", SqlDbType = SqlDbType.Time, Value = dtptoTime.SelectedTime == null ? null : dtptoTime.SelectedTime },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value ="20" },
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() },
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue == "0" ? null : cmbResident.SelectedValue },
                        new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text }
                    //new SqlParameter() { ParameterName = "@Amount", SqlDbType = SqlDbType.Decimal, Value = txtAmount.Text == "" ? "0" : txtAmount.Text },
                    //new SqlParameter() { ParameterName = "@DiningAmount", SqlDbType = SqlDbType.Decimal, Value = txtDiningAmount.Text == "" ? "0" : txtDiningAmount.Text },
                    //new SqlParameter() { ParameterName = "@OtherAmount", SqlDbType = SqlDbType.Decimal, Value = txtOtherAmount.Text == "" ? "0" : txtOtherAmount.Text },
                    //new SqlParameter() { ParameterName = "@TaxAmount", SqlDbType = SqlDbType.Decimal, Value = txttaxamount.Text == "" ? "0" : txttaxamount.Text }

                       );



                //if (ddlStatus.SelectedValue == "30")
                //{

                //    if (ddlPurpose.SelectedValue == "Official")
                //    {


                //        sqlobj.ExecuteSQLNonQuery("SP_GHAutoDebit",
                //                  new SqlParameter() { ParameterName = "@BookingAmount", SqlDbType = SqlDbType.Decimal, Value = txtAmount.Text },
                //                  new SqlParameter() { ParameterName = "@DiningAmount", SqlDbType = SqlDbType.Decimal, Value = txtDiningAmount.Text },
                //                  new SqlParameter() { ParameterName = "@OtherAmount", SqlDbType = SqlDbType.Decimal, Value = txtOtherAmount.Text },
                //                  new SqlParameter() { ParameterName = "@TaxAmount", SqlDbType = SqlDbType.Decimal, Value = txttaxamount.Text },
                //                  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = hbtnRSN.Value },
                //                  new SqlParameter() { ParameterName = "@RVillaNo", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingFor.SelectedItem.Text },
                //                  new SqlParameter() { ParameterName = "@RStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedItem.Text }
                //                  );

                //    }
                //    else if (ddlPurpose.SelectedValue=="Resident")
                //    {

                //        sqlobj.ExecuteSQLNonQuery("SP_GHAutoDebitResident",
                //                  new SqlParameter() { ParameterName = "@BookingAmount", SqlDbType = SqlDbType.Decimal, Value = txtAmount.Text },
                //                  new SqlParameter() { ParameterName = "@DiningAmount", SqlDbType = SqlDbType.Decimal, Value = txtDiningAmount.Text },
                //                  new SqlParameter() { ParameterName = "@OtherAmount", SqlDbType = SqlDbType.Decimal, Value = txtOtherAmount.Text },
                //                  new SqlParameter() { ParameterName = "@TaxAmount", SqlDbType = SqlDbType.Decimal, Value = txttaxamount.Text },
                //                  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue },
                //                  new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = hbtnRSN.Value }

                //                  );
                //    }
                //}

                Clear();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Checked In Successfully');", true);
            }



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            Clear();

            //LoadGuestBookingDetails();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx");
    }

    private void LoadBookingDetails(Int64 rsn)
    {
        try
        {

            Session["RSN"] = Session["GBRSN"].ToString();

            hbtnRSN.Value = Session["RSN"].ToString();


                       DataSet dsRes = sqlobj.ExecuteSP("SP_GuestBooking",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["GBRSN"].ToString() },
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.BigInt, Value = 4 }
                        );

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {

                        ddlBookingType.SelectedValue = dsRes.Tables[0].Rows[0]["BookingType"].ToString();

                        LoadBookingFor();

                        ddlBookingFor.SelectedValue = dsRes.Tables[0].Rows[0]["BookingFor"].ToString();


                        string sfromdate = dsRes.Tables[0].Rows[0]["FromDate"].ToString();
                        string stodate = dsRes.Tables[0].Rows[0]["TillDate"].ToString();
                        string safromdate = dsRes.Tables[0].Rows[0]["ActualFromDate"].ToString();
                        string satodate = dsRes.Tables[0].Rows[0]["ActualTillDate"].ToString();

                        //if (sfromdate != "")
                        //{
                        //    dtpfromdate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["FromDate"].ToString());
                        //}

                        //if (stodate != "")
                        //{
                        //    dtptilldate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["TillDate"].ToString());
                        //}

                        dtpfromdate.SelectedDate = DateTime.Now;


                        txtName.Text = dsRes.Tables[0].Rows[0]["Name"].ToString();
                        txtAddress.Text = dsRes.Tables[0].Rows[0]["Address"].ToString();
                        txtMobileNo.Text = dsRes.Tables[0].Rows[0]["MobileNo"].ToString();
                        txtEmailID.Text = dsRes.Tables[0].Rows[0]["EmailID"].ToString();
                        ddlPurpose.SelectedValue = dsRes.Tables[0].Rows[0]["Purpose"].ToString();


                        if (ddlPurpose.SelectedValue == "Resident")
                        {
                            loadResident();

                            cmbResident.SelectedValue = dsRes.Tables[0].Rows[0]["RTRSN"].ToString();
                        }

                        txtRemarks.Text = dsRes.Tables[0].Rows[0]["Remarks"].ToString();


                        //ddlStatus.SelectedValue = dsRes.Tables[0].Rows[0]["Status"].ToString();

                        ddlStatus.SelectedValue = "20";


                        lblstatus.Visible = false;
                        ddlStatus.Visible = false;

                        string fromtime = dsRes.Tables[0].Rows[0]["CheckInTime"].ToString();
                        string totime = dsRes.Tables[0].Rows[0]["CheckOutTime"].ToString();
                        string afromtime = dsRes.Tables[0].Rows[0]["ACheckInTime"].ToString();
                        string atotime = dsRes.Tables[0].Rows[0]["ACheckOutTime"].ToString();

                        if (fromtime != "")
                        {

                            dtpfromTime.SelectedDate = DateTime.Parse(dsRes.Tables[0].Rows[0]["CheckInTime"].ToString());
                        }
                        else
                        {
                            dtpfromTime.SelectedDate = null;
                        }


                        if (totime != "")
                        {
                            dtptoTime.SelectedDate = DateTime.Parse(dsRes.Tables[0].Rows[0]["CheckOutTime"].ToString());
                        }
                        else
                        {
                            dtptoTime.SelectedDate = null;

                        }
                        

                        btnSave.Visible = false;
                        btnUpdate.Visible = true;

                        Session["GBRSN"] = null;

                        }

                       dsRes.Dispose();


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvGuestBooking_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "CheckOut")
            {
                hbtnRSN.Value = e.CommandArgument.ToString();
                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    LinkButton lnkRSN = (LinkButton)e.Item.FindControl("lnkRSN");

                    Session["RSN"] = lnkRSN.Text;

                    DataSet dsRes = sqlobj.ExecuteSP("SP_GuestBooking",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text },
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.BigInt, Value = 4 }
                        );

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {

                        ddlBookingType.SelectedValue = dsRes.Tables[0].Rows[0]["BookingType"].ToString();

                        LoadBookingFor();

                        ddlBookingFor.SelectedValue = dsRes.Tables[0].Rows[0]["BookingFor"].ToString();


                        //string sfromdate = dsRes.Tables[0].Rows[0]["FromDate"].ToString();
                        //string stodate = dsRes.Tables[0].Rows[0]["TillDate"].ToString();
                        string safromdate = dsRes.Tables[0].Rows[0]["ActualFromDate"].ToString();
                        string satodate = dsRes.Tables[0].Rows[0]["ActualTillDate"].ToString();

                        if (safromdate != "")
                        {
                            dtpfromdate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["ActualFromDate"].ToString());
                        }

                        if (satodate != "")
                        {
                            dtptilldate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["ActualTillDate"].ToString());
                        }

                        dtptilldate.SelectedDate = Convert.ToDateTime(DateTime.Now.Date);
                        //if (safromdate != "")
                        //{
                        //    dtpActualFromDate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["ActualFromDate"].ToString());
                        //}

                        //if (satodate != "")
                        //{
                        //    dtpActualTillDate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["ActualTillDate"].ToString());
                        //}


                       

                        txtName.Text = dsRes.Tables[0].Rows[0]["Name"].ToString();
                        txtAddress.Text = dsRes.Tables[0].Rows[0]["Address"].ToString();
                        txtMobileNo.Text = dsRes.Tables[0].Rows[0]["MobileNo"].ToString();
                        txtEmailID.Text = dsRes.Tables[0].Rows[0]["EmailID"].ToString();
                        //ddlPurpose.SelectedValue = dsRes.Tables[0].Rows[0]["Purpose"].ToString();


                        if (ddlPurpose.SelectedValue == "Resident")
                        {
                            loadResident();

                            cmbResident.SelectedValue = dsRes.Tables[0].Rows[0]["RTRSN"].ToString();
                        }


                        ddlStatus.SelectedValue = dsRes.Tables[0].Rows[0]["Status"].ToString();


                        lblstatus.Visible = false;
                        ddlStatus.Visible = false;

                        string fromtime = dsRes.Tables[0].Rows[0]["CheckInTime"].ToString();
                        string totime = dsRes.Tables[0].Rows[0]["CheckOutTime"].ToString();
                        string afromtime = dsRes.Tables[0].Rows[0]["ACheckInTime"].ToString();
                        string atotime = dsRes.Tables[0].Rows[0]["ACheckOutTime"].ToString();

                        if (fromtime != "" || afromtime!="")
                        {

                            dtpfromTime.SelectedDate = DateTime.Parse(dsRes.Tables[0].Rows[0]["ACheckInTime"].ToString());
                        }
                        else
                        {
                            dtpfromTime.SelectedDate = null;
                        }


                        if (totime != "")
                        {
                            dtptoTime.SelectedDate = DateTime.Parse(dsRes.Tables[0].Rows[0]["CheckOutTime"].ToString());
                        }
                        else
                        {
                            dtptoTime.SelectedDate = null;
                        }

                        //if (afromtime != "")
                        //{

                        //    dtpAfromtime.SelectedDate = DateTime.Parse(dsRes.Tables[0].Rows[0]["ACheckInTime"].ToString());
                        //}
                        //else
                        //{
                        //    dtpAfromtime.SelectedDate = null;
                        //}


                        //if (atotime != "")
                        //{
                        //    dtpAToTime.SelectedDate = DateTime.Parse(dsRes.Tables[0].Rows[0]["ACheckOutTime"].ToString());
                        //}
                        //else
                        //{
                        //    dtpAToTime.SelectedDate = null;
                        //}


                        //txtAmount.Text = dsRes.Tables[0].Rows[0]["BookingAmount"].ToString();
                        //txtDiningAmount.Text = dsRes.Tables[0].Rows[0]["DiningAmount"].ToString();
                        //txtOtherAmount.Text = dsRes.Tables[0].Rows[0]["OtherAmount"].ToString();
                        //txttaxamount.Text = dsRes.Tables[0].Rows[0]["TaxAmount"].ToString();

                        // string strbillno = dsRes.Tables[0].Rows[0]["BillNo"].ToString();


                        //if (strbillno.ToString() != "")
                        //{
                        //    txtAmount.Enabled = false;
                        //    txtDiningAmount.Enabled = false;
                        //    txtOtherAmount.Enabled = false;
                        //    txttaxamount.Enabled = false;
                        //    txtSGSTAmouont.Enabled = false;

                        //}

                        //else
                        //{
                        //    txtAmount.Enabled = true;
                        //    txtDiningAmount.Enabled = true;
                        //    txtOtherAmount.Enabled = true;
                        //    txttaxamount.Enabled = true;
                        //    txtSGSTAmouont.Enabled = true;

                        //}



                        //ddlStatus.SelectedValue = dsRes.Tables[0].Rows[0]["Status"].ToString();

                        //if (ddlStatus.SelectedValue == "20" || ddlStatus.SelectedValue == "30")
                        //{
                        //    lblcamount.Visible = true;
                        //    txtAmount.Visible = true;
                        //    lblcotheramount.Visible = true;
                        //    txtOtherAmount.Visible = true;
                        //    lblctaxamount.Visible = true;
                        //    txttaxamount.Visible = true;
                        //    lblctaxamount.Visible = true;
                        //    lblTotalamount.Visible = true;
                        //    txttotalAmount.Visible = true;
                        //    lblcDiningamount.Visible = true;
                        //    txtDiningAmount.Visible = true;
                        //    lbltaxpercentage.Visible = true;
                        //    txtSGSTAmouont.Visible = true;
                        //    lblsgstamount.Visible = true;
                        //    lblsgstpercentage.Visible = true;
                        //}



                        btnSave.Visible = true;
                        btnUpdate.Visible = false;

                        //dtpActualFromDate.Visible = true;
                        //dtpActualTillDate.Visible = true;

                        //lblactualfromdate.Visible = true;
                        //lblactualtilldate.Visible = true;


                        //lblcActualcheckintime.Visible = true;
                        //lblcActualcheckouttime.Visible = true;

                        //dtpAfromtime.Visible = true;
                        //dtpAToTime.Visible = true;


                        //lblcamount.Visible = true;
                        //txtAmount.Visible = true;


                        //lblstatus.Visible = true;
                        //ddlStatus.Visible = true;
                    }

                    dsRes.Dispose();


                }
            }
           
           
            else
            {
                LoadGuestBookingDetails();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadBookingFor()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_BookingLkup",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
                new SqlParameter() { ParameterName = "@BookingType", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingType.SelectedValue }
                );

            ddlBookingFor.Items.Clear();

            if (dsCategory.Tables[0].Rows.Count > 0)
            {

                ddlBookingFor.DataSource = dsCategory;
                ddlBookingFor.DataTextField = "BookingFor";
                ddlBookingFor.DataValueField = "RSN";
                ddlBookingFor.DataBind();

            }

            ddlBookingFor.Items.Insert(0, "--Select--");


            dsCategory.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvGuestBooking_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvGuestBooking.FilterMenu;
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
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx");
    }
    protected void gvGuestBooking_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = e.Item as GridDataItem;

                LinkButton lnkcheckout = (LinkButton)dataItem.FindControl("lnkCheckOut");
                LinkButton lnkStatus = (LinkButton)dataItem.FindControl("lnkStatus");

                String strStatus =lnkStatus.Text;

                if (strStatus == "Checked Out")
                {
                    lnkcheckout.Visible = false;
                }


            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {



        DataSet dsStatement = sqlobj.ExecuteSP("SP_GuestBooking",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 }
                );

        DateTime sdate = DateTime.Now;


        if (dsStatement.Tables[0].Rows.Count > 0)
        {

            DataGrid dg = new DataGrid();

            dg.DataSource = dsStatement.Tables[0];
            dg.DataBind();




            // THE EXCEL FILE.
            string sFileName = "Facility Booking details as on " + sdate.ToString("dd/MM/yyyy") + ".xls";
            sFileName = sFileName.Replace("/", "");

            // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
            Response.ContentType = "application/vnd.ms-excel";
            EnableViewState = false;

            System.IO.StringWriter objSW = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

            dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
            dg.RenderControl(objHTW);


            Response.Write("<table><tr><td>Facility Booking details as on</td><td>:" + sdate.ToString("dd/MM/yyyy") + "</td></tr></table>");


            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
            Response.Write(objSW.ToString());


            Response.End();
            dg = null;


        }
        else
        {
            WebMsgBox.Show("Facility Booking details as on" + sdate.ToString("dd/MM/yyyy") + " does not exist");
        }
    }
    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsRes = sqlobj.ExecuteSP("SP_GuestBooking",
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue },
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.BigInt, Value = 6 }
                       );

            if (dsRes.Tables[0].Rows.Count > 0)
            {
                txtName.Text = dsRes.Tables[0].Rows[0]["rtName"].ToString();
                txtAddress.Text = dsRes.Tables[0].Rows[0]["Address"].ToString();
                txtMobileNo.Text = dsRes.Tables[0].Rows[0]["Contactcellno"].ToString();
                txtEmailID.Text = dsRes.Tables[0].Rows[0]["contactmail"].ToString();
            }
            else
            {
                txtName.Text = "";
                txtAddress.Text = "";
                txtMobileNo.Text = "";
                txtEmailID.Text = "";

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void loadResident()
    {
        string strpurpose = ddlPurpose.SelectedValue;

        if (strpurpose == "Resident")
        {
            lblcresident.Visible = true;
            cmbResident.Visible = true;
        }
        else
        {
            lblcresident.Visible = false;
            cmbResident.Visible = false;
        }
    }

    protected void ddlPurpose_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
            loadResident();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }


    }
    protected void ddlBookingFor_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadDetailsBookingFor();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadDetailsBookingFor()
    {
        try
        {

            DataSet dsGuestBookingDetails = sqlobj.ExecuteSP("SP_GuestBooking",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 7 },
                new SqlParameter() { ParameterName = "@BookingFor", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingFor.SelectedItem.Text }
                );


            if (dsGuestBookingDetails.Tables[0].Rows.Count > 0)
            {
                gvGuestBooking.DataSource = dsGuestBookingDetails;
                gvGuestBooking.DataBind();

                lnkcount.Text = "Count:" + dsGuestBookingDetails.Tables[0].Rows.Count;
            }
            else
            {
                gvGuestBooking.DataSource = string.Empty;
                gvGuestBooking.DataBind();

                lnkcount.Text = "Count:0";
            }


            dsGuestBookingDetails.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlRStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlRStatus.SelectedValue == "00" || ddlRStatus.SelectedValue == "30")
        //{

        //    lblcrfromdate.Visible = true;
        //    lblcrtilldate.Visible = true;

        //    dtpcrfromdate.Visible = true;
        //    dtpcrtilldate.Visible = true;

        //    dtpcrfromdate.SelectedDate = DateTime.Today;
        //    dtpcrtilldate.SelectedDate = DateTime.Today;
        //}

        //else
        //{
        //    lblcrfromdate.Visible = false;
        //    lblcrtilldate.Visible = false;

        //    dtpcrfromdate.Visible = false;
        //    dtpcrtilldate.Visible = false;
        //}

    }
    protected void BtnShow_Click(object sender, EventArgs e)
    {
        try
        {

            DataSet dsGuestBookingDetails = sqlobj.ExecuteSP("SP_GuestBookingReport");


            //new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlRStatus.SelectedValue },
            //new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = dtpcrfromdate.SelectedDate },
            //new SqlParameter() { ParameterName = "@TillDate", SqlDbType = SqlDbType.DateTime, Value = dtpcrtilldate.SelectedDate }


            if (dsGuestBookingDetails.Tables[0].Rows.Count > 0)
            {
                gvGuestBooking.DataSource = dsGuestBookingDetails;
                gvGuestBooking.DataBind();

                lnkcount.Text = "Count:" + dsGuestBookingDetails.Tables[0].Rows.Count;
            }
            else
            {
                gvGuestBooking.DataSource = string.Empty;
                gvGuestBooking.DataBind();

                lnkcount.Text = "Count:0";
            }


            dsGuestBookingDetails.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    
    protected void btnPosting_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("GuestHouseTxn.Posting.aspx");

            //int count = 0;

            //string strrsn ="";
            //string straccountcode ="";
            //string strname = "";
            //string strmobileno = "";

            //foreach (GridDataItem item in gvGuestBooking.MasterTableView.Items)
            //{
            //    if (item.Selected)
            //    {
   

            //        count = count + 1;

            //        LinkButton lnkrsn = (LinkButton)item.FindControl("lnkRSN");
            //        LinkButton lnkAccountCode = (LinkButton)item.FindControl("Lnkbtnview");

            //        Session["RTRSN"] =  lnkrsn.Text ;
            //        straccountcode = lnkAccountCode.Text;
            //        strname = item["Name"].Text;
            //        strmobileno = item["MobileNo"].Text;

            //        Session["AccountCode"] = lnkAccountCode.Text;

            //    }
            //}


            //if (count > 0)
            //{

            //    lblGuestName.Text = "Name:" + strname.ToString();
            //    lblAccountNo.Text = "AccountCode:" + straccountcode.ToString();
            //    lblMobileNo.Text = "MobileNo:" + strmobileno.ToString();


            //    ShowBalance();

            //    rwPosting.Visible = true;
            //}

            //else
            //{
            //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select one guest house check in details.');", true);
            //}


        }
        catch(Exception ex)
        {
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please try agin later.');", true);
        }
    }


    protected void btnTransSave_Click(object sender, EventArgs e)
    {
        try
        {


            string strBStatus = "";


            if (CnfResult.Value == "true")
            {
                
                    string strrsnfilter = "";
                    string custname = "";
                    string doorno = "";


                    //strrsnfilter = cmbGeneral.SelectedItem.Text;

                   // string[] custrsn = strrsnfilter.Split(',');

                   // custname = custrsn[0].ToString();

                  //  doorno = custrsn[1].ToString();





                    if (ddlAmountType.SelectedValue == "1")
                    {
                        TransType = "CR";

                        TransNarraction = txtCNarration.Text;

                       // RadWindowManager1.RadConfirm("Do you want print the Receipt for " + custname + " Door No : " + doorno + " ? ", "confirmCallbackFn", 400, 200, null, "Confirm");

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
                                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RTRSN"].ToString() },
                                 new SqlParameter() { ParameterName = "@TransType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
                                 new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtCAmount.Text },
                                 new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = Session["AccountCode"].ToString() },
                                  new SqlParameter() { ParameterName = "@Narration", SqlDbType = SqlDbType.NVarChar, Value = txtCNarration.Text }
                                 );

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);


                    ClearTransScr();

                    rwPosting.Visible = false;



            }



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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
                        CLAmount = CAmount - (damount);
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

                rwPosting.Visible = true;
                

            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message);
            }
        }
    }

    protected void ShowBalance()
    {
        String CBAmount;
       
            lbldeposit.Text = string.Empty;
            lblNewBalance.Text = string.Empty;


            lbldeposit.Visible = true;


                Session["AccountType"] = "H";
                Session["iMode"] = 4;


           if (Session["AccountCode"] != null && Session["iMode"] != null)
           {


                DataSet dsdeposit = sqlobj.ExecuteSP("SP_GetDeposit",
                       new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = Session["iMode"].ToString() },
                       new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = Session["AccountCode"].ToString() });


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
        //}
    }


    protected void ShowPBalance()
    {
        String CBAmount;

        lblPDeposit.Text = string.Empty;
        lblpNewBalance.Text = string.Empty;


        lblPDeposit.Visible = true;


        Session["AccountType"] = "H";
        Session["iMode"] = 4;


        if (Session["AccountCode"] != null && Session["iMode"] != null)
        {


            DataSet dsdeposit = sqlobj.ExecuteSP("SP_GetDeposit",
                   new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = Session["iMode"].ToString() },
                   new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = Session["AccountCode"].ToString() });


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


                lblPDeposit.Text = "Account No: " + dsdeposit.Tables[0].Rows[0]["AccountNo"].ToString() + " || Current Balance: " + CBAmount;
            }
            else
            {
                lblPDeposit.Text = "Account No:" + " Current Balance:";
            }

            dsdeposit.Dispose();

        }
        //}
    }

    protected void ddlsavetime_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlsavetime.SelectedItem.ToString() != "")
        //{
        //    string strAppend = ddlsavetime.SelectedItem.ToString();
        //    txtCNarration.Text = txtCNarration.Text + " " + strAppend + " ";
        //}
    }

    protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        ShowBalance();

        rwPosting.Visible = true;

    }

    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        ShowBalance();

        rwPosting.Visible = true;

    }

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

        rwPosting.Visible = true;
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

    protected void btnTransExit_Click(object sender, EventArgs e)
    {
        rwPosting.Visible = false;
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

       // cmbResident.SelectedValue = "0";
       // cmbGeneral.SelectedValue = "0";


        //rdoLedger.SelectedValue = "1";

        //cmbGeneral.Visible = false;
       // cmbResident.Visible = true;
       // cmbGGenearl.Visible = false;

       // LoadGeneralLedger();

      //  Label59.Text = "For which Resident Account?Search by";


        //lblgroup.Visible = false;
        //lblcgroup.Visible = false;

        //lbldeposit.Visible = false;
        lblNewBalance.Visible = false;

        dtpCDate.SelectedDate = DateTime.Now;

        ddlAmountType.SelectedIndex = 1;

       // LoadCashType();

        //gvTransactions.DataSource = string.Empty;
        //gvTransactions.DataBind();

        //lblresidentname.Text = string.Empty;
        //lblDoorno.Text = string.Empty;
        //lblAccountNo.Text = string.Empty;

        //lbldeposit.Text = "";



    }

    protected void btnSaveTime_Click(object sender, EventArgs e)
    {
        //rwSaveTime.Visible = true;
    }

    protected void btnCClear_Click(object sender, EventArgs e)
    {
        ClearTransScr();
    }


    protected void Lnkbtnview_Click(object sender, EventArgs e)
    {
       
        LinkButton lnkAccountCode = (LinkButton)sender;

        Session["AccountCode"] = lnkAccountCode.Text;

        GridDataItem row = (GridDataItem)lnkAccountCode.NamingContainer;
        
        string strAccountName = row.Cells[7].Text;

        DataSet dsStatement = sqlobj.ExecuteSP("SP_GuestHouseAccountLedgerTransactions",
                   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@AccountCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = lnkAccountCode.Text });


        lblAccountCode.Text = "Account Code:" + lnkAccountCode.Text;
        lblAccountName.Text = "Account Name:" + strAccountName.ToString();
      


        if (dsStatement.Tables[0].Rows.Count > 0)
        {
            rgGeneralTransactions.DataSource = dsStatement;
            rgGeneralTransactions.DataBind();
        }

        else
        {
            rgGeneralTransactions.DataSource = string.Empty;
            rgGeneralTransactions.DataBind();
        }

        dsStatement.Dispose();

        rwTransactions.Visible = true;
    }

    protected void btnTransactionClose_Click(object sender, EventArgs e)
    {
        rwTransactions.Visible = false;
    }
    protected void btnPayment_Click(object sender, EventArgs e)
    {
        try
        {
            int count = 0;

            string strrsn = "";
            string straccountcode = "";
            string strname = "";
            string strmobileno = "";

            foreach (GridDataItem item in gvGuestBooking.MasterTableView.Items)
            {
                if (item.Selected)
                {


                    count = count + 1;

                    LinkButton lnkrsn = (LinkButton)item.FindControl("lnkRSN");
                    LinkButton lnkAccountCode = (LinkButton)item.FindControl("Lnkbtnview");

                    Session["RTRSN"] = lnkrsn.Text;
                    straccountcode = lnkAccountCode.Text;
                    strname = item["Name"].Text;
                    strmobileno = item["MobileNo"].Text;

                    Session["AccountCode"] = lnkAccountCode.Text;

                }
            }


            if (count > 0)
            {

                lblpName.Text = "Name:" + strname.ToString();
                lblpAccountCode.Text = "AccountCode:" + straccountcode.ToString();
                lblpMobileNo.Text = "MobileNo:" + strmobileno.ToString();


                ShowPBalance();

                rwPayment.Visible = true;
            }

            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select one guest house check in details.');", true);
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    
    protected void btnPSave_Click(object sender, EventArgs e)
    {
        try
        {


            string strBStatus = "";


            if (CnfResult.Value == "true")
            {

                string strrsnfilter = "";
                string custname = "";
                string doorno = "";


               
                    TransType = "CR";

                    TransNarraction = txtPNarration.Text;

                    // RadWindowManager1.RadConfirm("Do you want print the Receipt for " + custname + " Door No : " + doorno + " ? ", "confirmCallbackFn", 400, 200, null, "Confirm");


                sqlobj.ExecuteSQLNonQuery("SP_GHTransaction",
                             new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RTRSN"].ToString() },
                             new SqlParameter() { ParameterName = "@TransType", SqlDbType = SqlDbType.NVarChar, Value = TransType },
                             new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtPAmount.Text },
                             new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = Session["AccountCode"].ToString() },
                              new SqlParameter() { ParameterName = "@Narration", SqlDbType = SqlDbType.NVarChar, Value = txtPNarration.Text }
                             );

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Payment details saved successfully');", true);


                ClearTransScr();

                rwPayment.Visible = false;

            }



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
   
    protected void btnPExit_Click(object sender, EventArgs e)
    {
        try
        {
            rwPayment.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlPPaymode_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            rwPayment.Visible = true;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void txtPAmount_TextChanged(object sender, EventArgs e)
    {
        Decimal CLAmount;
        ShowPBalance();
        {
            try
            {
                String NBAmount;

                lblpNewBalance.Visible = true;
                decimal damount = Convert.ToDecimal(txtPAmount.Text);
                decimal CAmount = Convert.ToDecimal(Session["BalAmount"]);

             
               
                    if (CAmount > 0)
                    {
                        CLAmount = CAmount - (damount);
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

                    lblpNewBalance.Text = "New Balance: " + NBAmount;
              

                //LoadTotalAmounttowords(damount);

                rwPayment.Visible = true;


            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message);
            }
        }
    }

    protected void BtnAlacarte_Click(object sender, EventArgs e)
    {
        try
        {
            Session["GuestTxn"] = "Y";
            Response.Redirect("ALaCartBilling.aspx");
        }
        catch (Exception ex)
        {

            WebMsgBox.Show(ex.Message); 
        }
    }
}