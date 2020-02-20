using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Drawing;

public partial class VehicleMovement : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadTitle();
                LoadDate();
                LoadVehicleType();
                LoadTax();
                LoadVehicleMovement();

                dtpStartDate.MaxDate = DateTime.Today;
                dtpEndDate.MaxDate = DateTime.Today;
                lblcresident.Visible = false;
                lblnetamount.Visible = false;
                txtNetAmount.Visible = false;
                lbltaxamount.Visible = false;
                txtTaxAmount.Visible = false;
                lbltaxpercentage.Visible = false;
                lblsgstamount.Visible = false;
                txtSGSTAmouont.Visible = false;
                lblsgstpercentage.Visible = false;
                lblgrossamount.Visible = false;
                txtGrossAmount.Visible = false;
                lblbwarning.Visible = false;
                btnSave.Visible = true;
                btnUpdate.Visible = false;
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 123 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lbltitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lbltitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadVehicleType()
    {
        try
        {

            DataSet dsCategory = sqlobj.ExecuteSP("SP_VMaster",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 }
                );
            ddlType.Items.Clear();
            if (dsCategory.Tables[0].Rows.Count > 0)
            {

                ddlType.DataSource = dsCategory;
                ddlType.DataTextField = "VehicleCode";
                ddlType.DataValueField = "VehicleCode";
                ddlType.DataBind();

                ddlVehicleName.DataSource = dsCategory;
                ddlVehicleName.DataTextField = "VehicleCode";
                ddlVehicleName.DataValueField = "VehicleCode";
                ddlVehicleName.DataBind();

            }


            ddlType.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlVehicleName.Items.Insert(0, new ListItem("All", "0"));

            dsCategory.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadGeneralLedger()
    {
        try
        {
            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 });
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
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    private void LoadTax()
    {
        DataSet dsTaxc = sqlobj.ExecuteSP("SP_GetGST",
            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 }
            );

        string CGSTtaxc = "";
        string SGSTtaxc = "";

        if (dsTaxc.Tables[0].Rows.Count > 0)
        {
            CGSTtaxc = dsTaxc.Tables[0].Rows[0]["CGST_PCNT"].ToString();
            Session["CGST"] = CGSTtaxc.ToString();
            lbltaxpercentage.Text = "CGST " + Session["CGST"] + "%";
            SGSTtaxc = dsTaxc.Tables[0].Rows[0]["SGST_PCNT"].ToString();
            Session["SGST"] = SGSTtaxc.ToString();
            lblsgstpercentage.Text = "SGST " + Session["SGST"] + "%";
        }
    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadVehicleMaster();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadVehicleMaster()
    {
        try
        {
            ddlVehicle.Items.Clear();
            if (ddlType.SelectedValue != "0")
            {
                DataSet dsCategory = sqlobj.ExecuteSP("SP_VMovement",
                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
                    new SqlParameter() { ParameterName = "@VehicleCode", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue }
                    );
                if (dsCategory.Tables[0].Rows.Count > 0)
                {
                    ddlVehicle.DataSource = dsCategory;
                    ddlVehicle.DataTextField = "VehicleName";
                    ddlVehicle.DataValueField = "VehicleCode";
                    ddlVehicle.DataBind();
                    ddlVehicle.SelectedIndex = 0;
                    lbllendkm.Text = "Latest EndKM:" + dsCategory.Tables[0].Rows[0]["EndKM"].ToString();
                    txtStartKM.Text = "";
                    //txtStartKM.Text = dsCategory.Tables[0].Rows[0]["EndKm"].ToString();
                    ViewState["VehicleNo"] = dsCategory.Tables[0].Rows[0]["VehicleNo"].ToString();
                    ViewState["VehicleName"]= dsCategory.Tables[0].Rows[0]["VehicleCode"].ToString();

                }
                else
                {
                    lbllendkm.Text = "";
                }
                dsCategory.Dispose();
            }
            ddlVehicle.Items.Insert(0, "-");
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
    protected void LoadGuestDet()
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 7 }
                );

            cmbGeneral.DataSource = dsResident.Tables[0];
            cmbGeneral.DataValueField = "RSN";
            cmbGeneral.DataTextField = "GName";
            cmbGeneral.DataBind();
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbGeneral.Items.Add(item2);
            dsResident.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + ");", true);
        }
    }
    protected void LoadFuelDet()
    {
        try
        {
            string vehiclename = ViewState["VehicleName"].ToString();
            string VehicleNo = ViewState["VehicleNo"].ToString();
            DataSet dsEndKM = sqlobj.ExecuteSP("SP_VMovement",
               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 9 },
               new SqlParameter() { ParameterName = "@VehicleCode", SqlDbType = SqlDbType.NVarChar, Value = vehiclename });
            if(dsEndKM.Tables[0].Rows.Count>0)
            {
                txtStartKM.Text = dsEndKM.Tables[0].Rows[0]["EndKm"].ToString();
                dtpStartDate.SelectedDate = Convert.ToDateTime(dsEndKM.Tables[0].Rows[0]["StartDate"].ToString());
                dtpfromTime.SelectedDate = Convert.ToDateTime(dsEndKM.Tables[0].Rows[0]["StartTime"].ToString());
                lbllendkm.Text = "Latest Fuel Filled KM:" + txtStartKM.Text+ " On " + dsEndKM.Tables[0].Rows[0]["LatestDate"].ToString(); ;
                txtStartKM.Enabled = false;
                dtpStartDate.Enabled = false;
                dtpfromTime.Enabled = false;
            }
            else
            {
                //txtStartKM.Text = dsEndKM.Tables[0].Rows[0]["EndKm"].ToString();
                
                txtStartKM.Text = "";
                lbllendkm.Text = "Latest Fuel Filled KM::" + txtStartKM.Text;
                dtpStartDate.SelectedDate = null;
                dtpfromTime.SelectedDate = null;
                txtStartKM.Enabled = true;
                dtpStartDate.Enabled = true;
                dtpfromTime.Enabled = true;
            }
               

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + ");", true);
        }
    }
    private void LoadVehicleMovement()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_VMovement",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 },
                new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
              new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate }
                );

            if (dsCategory.Tables[0].Rows.Count > 0)
            {

                rgVMovement.DataSource = dsCategory;
                rgVMovement.DataBind();

                lnkcount.Text = "Count:" + dsCategory.Tables[0].Rows.Count;

            }

            else
            {
                rgVMovement.DataSource = string.Empty;
                rgVMovement.DataBind();


                lnkcount.Text = "Count:0";
            }


            dsCategory.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_GetAccountcode",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                      new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });
            Session["AccCode"] = ds.Tables[0].Rows[0]["GLAccount"].ToString();

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
            ddlType.SelectedIndex = 0;
            ddlVehicle.SelectedIndex = 0;
            ddlPurpose.SelectedIndex = 0;
            cmbResident.SelectedValue = "0";
            cmbGeneral.SelectedValue = "0";
            dtpStartDate.SelectedDate = null;
            dtpfromTime.SelectedTime = null;
            txtUpdateRemarks.Text = "";
            txtGrossAmount.Enabled = false;
            txtStartKM.Text = "";
            txtStartKM.Enabled = true;
            dtpEndDate.SelectedDate = null;
            dtptoTime.SelectedTime = null;          
            dtpStartDate.Enabled = true;
            dtpfromTime.Enabled = true;
            txtEndKM.Text = "";
            lbllendkm.Text = "";
            txtRunningKM.Text = "";
            txtUsedby.Text = "";

            lblcresident.Visible = false;
            cmbResident.Visible = false;
            cmbGeneral.Visible = false;

            lblwarning.Text = "";
            lblbwarning.Visible = false;


            lblnetamount.Visible = false;
            txtNetAmount.Visible = false;
            lbltaxamount.Visible = false;
            txtTaxAmount.Visible = false;
            lbltaxpercentage.Visible = false;
            lblgrossamount.Visible = false;
            txtGrossAmount.Visible = false;
            lblsgstamount.Visible = false;
            txtSGSTAmouont.Visible = false;
            lblsgstpercentage.Visible = false;

            LoadVehicleMovement();

            btnSave.Visible = true;
            btnUpdate.Visible = false;

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



                string custname = "";

                string doorno = "";


                sqlobj.ExecuteSQLNonQuery("SP_VMovement",
                      new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                      new SqlParameter() { ParameterName = "@VehicleCode", SqlDbType = SqlDbType.NVarChar, Value = ddlVehicle.SelectedValue },
                      new SqlParameter() { ParameterName = "@Purpose", SqlDbType = SqlDbType.NVarChar, Value = ddlPurpose.SelectedValue },
                      new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.DateTime, Value = dtpStartDate.SelectedDate == null ? null : dtpStartDate.SelectedDate },
                      new SqlParameter() { ParameterName = "@StartTime", SqlDbType = SqlDbType.Time, Value = dtpfromTime.SelectedTime == null ? null : dtpfromTime.SelectedTime },
                      new SqlParameter() { ParameterName = "@StartKM", SqlDbType = SqlDbType.BigInt, Value = txtStartKM.Text == "" ? "0" : txtStartKM.Text },
                      new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.DateTime, Value = dtpEndDate.SelectedDate == null ? null : dtpEndDate.SelectedDate },
                      new SqlParameter() { ParameterName = "@EndTime", SqlDbType = SqlDbType.Time, Value = dtptoTime.SelectedTime == null ? null : dtptoTime.SelectedTime },
                      new SqlParameter() { ParameterName = "@EndKM", SqlDbType = SqlDbType.BigInt, Value = txtEndKM.Text == "" ? "0" : txtEndKM.Text },
                      new SqlParameter() { ParameterName = "@RunKM", SqlDbType = SqlDbType.BigInt, Value = txtRunningKM.Text == "" ? "0" : txtRunningKM.Text },
                      new SqlParameter() { ParameterName = "@UsedBy", SqlDbType = SqlDbType.NVarChar, Value = txtUsedby.Text },
                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = ddlPurpose.SelectedValue == "Resident" ? cmbResident.SelectedValue : ddlPurpose.SelectedValue == "GuestHouse" ? null : cmbGeneral.SelectedValue },
                      new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                      new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtUpdateRemarks.Text }

                      );

                Clear();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Vehicle Movement details saved');", true);
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
                if (dtptoTime.SelectedTime == null || dtpfromTime.SelectedTime == null)
                {
                    WebMsgBox.Show("Please Select On / Return Time.");
                    return;
                }
                if (string.IsNullOrEmpty(txtGrossAmount.Text) || string.IsNullOrEmpty(txtNetAmount.Text) || string.IsNullOrEmpty(txtStartKM.Text) || string.IsNullOrEmpty(txtEndKM.Text) || string.IsNullOrEmpty(txtRunningKM.Text) || string.IsNullOrEmpty(txtTaxAmount.Text) || string.IsNullOrEmpty(txtSGSTAmouont.Text))
                {
                    WebMsgBox.Show("Please Enter Valid Data To All Fields");
                    return;
                }

                decimal CGSTAmount = Convert.ToDecimal(txtTaxAmount.Text);
                decimal SGSTAmount = Convert.ToDecimal(txtSGSTAmouont.Text);
                decimal skm = 0;
                decimal ekm = 0;

                if (txtStartKM.Text != "" && txtEndKM.Text != "")
                {

                    skm = Convert.ToDecimal(txtStartKM.Text);
                    ekm = Convert.ToDecimal(txtEndKM.Text);

                    if (ekm < skm)
                    {
                        WebMsgBox.Show("Please check your end kilometer is less than the starting killometer");
                        return;
                    }

                }

                sqlobj.ExecuteSQLNonQuery("SP_VMovement",
                      new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                      new SqlParameter() { ParameterName = "@VehicleCode", SqlDbType = SqlDbType.NVarChar, Value = ddlVehicle.SelectedValue },
                      new SqlParameter() { ParameterName = "@Purpose", SqlDbType = SqlDbType.NVarChar, Value = ddlPurpose.SelectedValue },
                      new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.DateTime, Value = dtpStartDate.SelectedDate == null ? null : dtpStartDate.SelectedDate },
                      new SqlParameter() { ParameterName = "@StartTime", SqlDbType = SqlDbType.Time, Value = dtpfromTime.SelectedTime == null ? null : dtpfromTime.SelectedTime },
                      new SqlParameter() { ParameterName = "@StartKM", SqlDbType = SqlDbType.BigInt, Value = txtStartKM.Text == "" ? "0" : txtStartKM.Text },
                      new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.DateTime, Value = dtpEndDate.SelectedDate == null ? null : dtpEndDate.SelectedDate },
                      new SqlParameter() { ParameterName = "@EndTime", SqlDbType = SqlDbType.Time, Value = dtptoTime.SelectedTime == null ? null : dtptoTime.SelectedTime },
                      new SqlParameter() { ParameterName = "@EndKM", SqlDbType = SqlDbType.BigInt, Value = txtEndKM.Text == "" ? "0" : txtEndKM.Text },
                      new SqlParameter() { ParameterName = "@RunKM", SqlDbType = SqlDbType.BigInt, Value = txtRunningKM.Text == "" ? "0" : txtRunningKM.Text },
                      new SqlParameter() { ParameterName = "@UsedBy", SqlDbType = SqlDbType.NVarChar, Value = txtUsedby.Text },
                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = ddlPurpose.SelectedValue == "Resident" ? cmbResident.SelectedValue : ddlPurpose.SelectedValue == "GuestHouse" ? null : cmbGeneral.SelectedValue },
                      new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                      new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() },
                      new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtUpdateRemarks.Text },
                      new SqlParameter() { ParameterName = "@NetAmount", SqlDbType = SqlDbType.Decimal, Value = txtNetAmount.Text == "" ? "0.00" : txtNetAmount.Text },
                      new SqlParameter() { ParameterName = "@TaxAmount", SqlDbType = SqlDbType.Decimal, Value = txtTaxAmount.Text == "" ? "0.00" : txtTaxAmount.Text },
                      new SqlParameter() { ParameterName = "@SGSTAmount", SqlDbType = SqlDbType.Decimal, Value = txtSGSTAmouont.Text == "" ? "0.00" : txtSGSTAmouont.Text },
                      new SqlParameter() { ParameterName = "@GrossAmount", SqlDbType = SqlDbType.Decimal, Value = txtGrossAmount.Text == "" ? "0.00" : txtGrossAmount.Text }
                      );


                if (txtNetAmount.Text != "")
                {
                    decimal dnetamount = Convert.ToDecimal(txtNetAmount.Text);
                    string strBillNo = "";
                    if (dnetamount > 0)
                    {
                        // -- Strart Post Debit Transaction for net amount
                        DateTime bdate = DateTime.Now;

                        string strday = bdate.ToString("dd");
                        string strmonth = bdate.ToString("MM");
                        string stryear = bdate.ToString("yyyy");
                        string strhour = bdate.ToString("HH");
                        string strmin = bdate.ToString("mm");
                        string strsec = bdate.ToString("ss");
                        strBillNo = stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();

                        Session["AccountType"] = "H";

                        if (ddlPurpose.SelectedValue == "Guest")
                        {
                            strBillNo = stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();
                            string strrsnfilter = "";
                            string custname = "";
                            string doorno = "";
                            //strrsnfilter = cmbGeneral.SelectedItem.Text;
                            //string[] custrsn = strrsnfilter.Split(',');
                            //custname = custrsn[0].ToString();
                            //doorno = custrsn[1].ToString();

                            DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertTxnPosting",
                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = 0000 },
                        new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "GV" },
                        new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                        new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtNetAmount.Text },
                        new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = txtUpdateRemarks.Text },
                        new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                        new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                        new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = Session["AccountType"].ToString() },
                        new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() },
                        new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                        new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = Session["AccCode"].ToString() },
                        new SqlParameter() { ParameterName = "@CGST", SqlDbType = SqlDbType.Decimal, Value = CGSTAmount },
                        new SqlParameter() { ParameterName = "@SGST", SqlDbType = SqlDbType.Decimal, Value = SGSTAmount }
                          );

                            //sqlobj.ExecuteSQLNonQuery("SP_GHCabTransaction",
                            //             new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = doorno.ToString() },
                            //             new SqlParameter() { ParameterName = "@TransType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                            //             new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = dnetamount.ToString() },
                            //             new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString()},
                            //             new SqlParameter() { ParameterName = "@Narration", SqlDbType = SqlDbType.NVarChar, Value = "Cab charges"}
                            //             );

                            //if (txtTaxAmount.Text != "")
                            //{
                            //    decimal dtaxamount = Convert.ToDecimal(txtTaxAmount.Text);


                            //    if (dtaxamount > 0)
                            //    {
                            //        sqlobj.ExecuteSQLNonQuery("SP_GHCabTransaction",
                            //            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = doorno.ToString() },
                            //            new SqlParameter() { ParameterName = "@TransType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                            //            new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = dtaxamount.ToString() },
                            //            new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                            //            new SqlParameter() { ParameterName = "@Narration", SqlDbType = SqlDbType.NVarChar, Value = "CGST " + Session["CGST"].ToString() + "%" }
                            //            );
                            //    }
                            //}


                            //if (txtSGSTAmouont.Text != "")
                            //{
                            //    decimal dsgstamount = Convert.ToDecimal(txtSGSTAmouont.Text);


                            //    if (dsgstamount > 0)
                            //    {
                            //        sqlobj.ExecuteSQLNonQuery("SP_GHCabTransaction",
                            //           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = doorno.ToString() },
                            //           new SqlParameter() { ParameterName = "@TransType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                            //           new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = dsgstamount.ToString() },
                            //           new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                            //           new SqlParameter() { ParameterName = "@Narration", SqlDbType = SqlDbType.NVarChar, Value = "CGST " + Session["CGST"].ToString() + "%" }
                            //           );
                            //    }
                            //}


                            // -- start Update amounts and bill no in vmovement table


                            sqlobj.ExecuteNonQuery("SP_VMovement",
                               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 7 },
                               new SqlParameter() { ParameterName = "@NetAmount", SqlDbType = SqlDbType.Decimal, Value = txtNetAmount.Text },
                               new SqlParameter() { ParameterName = "@TaxAmount", SqlDbType = SqlDbType.Decimal, Value = txtTaxAmount.Text },
                               new SqlParameter() { ParameterName = "@SGSTAmount", SqlDbType = SqlDbType.Decimal, Value = txtSGSTAmouont.Text },
                               new SqlParameter() { ParameterName = "@GrossAmount", SqlDbType = SqlDbType.Decimal, Value = txtGrossAmount.Text },
                               new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                               new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbGeneral.SelectedValue },
                               new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() }
                               );


                            // -- end Update amounts and bill no in vmovement table




                            // ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);


                            //   ClearTransScr();


                        }

                        else
                        {



                            if (ddlPurpose.SelectedValue == "Resident")
                            {
                                Session["RTRSN"] = cmbResident.SelectedValue;
                                Session["AccountType"] = "R";

                            }
                            else if (ddlPurpose.SelectedValue == "Official" || ddlPurpose.SelectedValue == "Fuel" || ddlPurpose.SelectedValue == "Service")
                            {


                                DataSet dsrtrsn = sqlobj.ExecuteSP("SP_GetVehicleUsageRSN",
                                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 }
                                    );


                                //if (dsrtrsn.Tables[0].Rows.Count >0)
                                //{
                                //    Session["RTRSN"] = dsrtrsn.Tables[0].Rows[0]["accountsmrsn"].ToString();
                                //}
                                Session["RTRSN"] = "9999";
                                dsrtrsn.Dispose();

                                Session["AccountType"] = "G";
                            }
                            else if (ddlPurpose.SelectedValue == "Personal")
                            {

                                DataSet dsrtrsn = sqlobj.ExecuteSP("SP_GetVehicleUsageRSN",
                                    new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 }
                                    );


                                if (dsrtrsn.Tables[0].Rows.Count > 0)
                                {
                                    Session["RTRSN"] = dsrtrsn.Tables[0].Rows[0]["accountsmrsn"].ToString();
                                }

                                dsrtrsn.Dispose();


                                Session["AccountType"] = "G";
                            }

                            DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertUNBILLEDTxnPosting",
                              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue.ToString() },
                              new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "CB" },
                              new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                              new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtNetAmount.Text },
                              new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = txtUpdateRemarks.Text },
                              new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                              new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                              new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = Session["AccountType"].ToString() },
                              new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() },
                              new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                              new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = Session["AccCode"].ToString() },
                              new SqlParameter() { ParameterName = "@CGST", SqlDbType = SqlDbType.Decimal, Value = CGSTAmount },
                              new SqlParameter() { ParameterName = "@SGST", SqlDbType = SqlDbType.Decimal, Value = SGSTAmount }
                                );


                            // -- start Update amounts and bill no in vmovement table


                            sqlobj.ExecuteNonQuery("SP_VMovement",
                               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 7 },
                               new SqlParameter() { ParameterName = "@NetAmount", SqlDbType = SqlDbType.Decimal, Value = txtNetAmount.Text },
                               new SqlParameter() { ParameterName = "@TaxAmount", SqlDbType = SqlDbType.Decimal, Value = txtTaxAmount.Text },
                               new SqlParameter() { ParameterName = "@SGSTAmount", SqlDbType = SqlDbType.Decimal, Value = txtSGSTAmouont.Text },
                               new SqlParameter() { ParameterName = "@GrossAmount", SqlDbType = SqlDbType.Decimal, Value = txtGrossAmount.Text },
                               new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                               new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue },
                               new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() }
                               );


                            // -- end Update amounts and bill no in vmovement table


                        }

                    }

                }



                Clear();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Vehicle Movement details updated');", true);
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
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgVMovement_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "UpdateRow")
            {

                hdnRSN.Value = e.CommandArgument.ToString();

                if (e.Item is GridDataItem)
                {

                    GridDataItem ditem = (GridDataItem)e.Item;

                    LinkButton lnkRSN = (LinkButton)e.Item.FindControl("lbtnUpdate");

                    Session["RSN"] = hdnRSN.Value;
                    SqlProcsNew proc = new SqlProcsNew();


                    DataSet dsDT = sqlobj.ExecuteSP("SP_VMovement",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 },
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Session["RSN"].ToString() });


                    if (dsDT.Tables[0].Rows.Count > 0)
                    {

                        lblnetamount.Visible = true;
                        txtNetAmount.Visible = true;
                        lbltaxamount.Visible = true;
                        txtTaxAmount.Visible = true;
                        lblgrossamount.Visible = true;
                        txtGrossAmount.Visible = true;
                        lbltaxpercentage.Visible = true;
                        lblsgstamount.Visible = true;
                        txtSGSTAmouont.Visible = true;
                        lblsgstpercentage.Visible = true;

                        string startdate = dsDT.Tables[0].Rows[0]["StartDate"].ToString();
                        string enddate = dsDT.Tables[0].Rows[0]["EndDate"].ToString();


                        if (startdate != "")
                        {
                            dtpStartDate.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0]["StartDate"].ToString());
                        }

                        if (enddate != "")
                        {
                            dtpEndDate.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0]["EndDate"].ToString());

                        }

                        ddlType.SelectedValue = dsDT.Tables[0].Rows[0]["VehicleCode"].ToString();

                        ddlPurpose.SelectedValue = dsDT.Tables[0].Rows[0]["Purpose"].ToString();


                        if (ddlPurpose.SelectedValue == "Resident")
                        {
                            loadResident();

                            cmbResident.SelectedValue = dsDT.Tables[0].Rows[0]["RTRSN"].ToString();
                        }
                        if (ddlPurpose.SelectedValue == "GuestHouse")
                        {
                            loadResident();

                            cmbGeneral.SelectedValue = dsDT.Tables[0].Rows[0]["RTRSN"].ToString();
                        }

                        LoadVehicleMaster();


                        string fromtime = dsDT.Tables[0].Rows[0]["starttime"].ToString();
                        string totime = dsDT.Tables[0].Rows[0]["endtime"].ToString();


                        if (fromtime != "")
                        {

                            dtpfromTime.SelectedDate = DateTime.Parse(dsDT.Tables[0].Rows[0]["StartTime"].ToString());
                        }
                        else
                        {
                            dtpfromTime.SelectedDate = null;
                        }

                        if (totime != "")
                        {
                            dtptoTime.SelectedDate = DateTime.Parse(dsDT.Tables[0].Rows[0]["EndTime"].ToString());
                        }
                        else
                        {
                            dtptoTime.SelectedDate = null;
                        }

                        Session["BillNo"] = dsDT.Tables[0].Rows[0]["BillNo"].ToString();


                        txtNetAmount.Text = dsDT.Tables[0].Rows[0]["NetAmount"].ToString();
                        txtTaxAmount.Text = dsDT.Tables[0].Rows[0]["TaxAmount"].ToString();
                        txtSGSTAmouont.Text = dsDT.Tables[0].Rows[0]["SGSTAmount"].ToString();
                        txtGrossAmount.Text = dsDT.Tables[0].Rows[0]["GrossAmount"].ToString();

                        ddlVehicle.SelectedValue = dsDT.Tables[0].Rows[0]["VehicleCode"].ToString();

                        txtStartKM.Text = dsDT.Tables[0].Rows[0]["StartKM"].ToString();
                        txtEndKM.Text = dsDT.Tables[0].Rows[0]["EndKM"].ToString();

                        txtUsedby.Text = dsDT.Tables[0].Rows[0]["UsedBy"].ToString();
                        txtUpdateRemarks.Text = dsDT.Tables[0].Rows[0]["Remarks"].ToString();
                        txtRunningKM.Text = dsDT.Tables[0].Rows[0]["RunKM"].ToString();
                        cmbResident.SelectedValue = dsDT.Tables[0].Rows[0]["RTRSN"].ToString();



                        btnUpdate.Visible = true;
                        btnSave.Visible = false;

                        if (Session["BillNo"].ToString() == "")
                        {
                            txtNetAmount.Enabled = true;

                            lbltaxpercentage.Enabled = true;
                            lblsgstamount.Enabled = true;

                            lblsgstpercentage.Enabled = true;


                            lblbwarning.Visible = false;

                        }

                        else
                        {

                            DataSet dsTrans = sqlobj.ExecuteSP("SP_VMovement",
                              new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 8 },
                              new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = Session["BillNo"].ToString() });


                            if (dsTrans.Tables[0].Rows.Count > 0)
                            {

                            }

                            dsTrans.Dispose();


                            btnUpdate.Visible = false;

                            lblbwarning.Visible = true;



                        }


                    }

                    dsDT.Dispose();
                }
            }
            else
            {
                LoadVehicleMovement();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgVMovement_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgVMovement.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
    protected void txtEndKM_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (txtStartKM.Text != "" && txtEndKM.Text != "")
            {

                decimal skm = Convert.ToDecimal(txtStartKM.Text);
                decimal ekm = Convert.ToDecimal(txtEndKM.Text);
                decimal rkm = 0;


                if (ekm < skm)
                {
                    WebMsgBox.Show("Please check your end kilometer is less than the starting killometer");
                }

                else
                {
                    txtRunningKM.Text = Convert.ToString(ekm - skm);

                    rkm = Convert.ToDecimal(txtRunningKM.Text);

                    if (rkm > 1000)
                    {
                        lblwarning.Text = "Warning:Total Running KM exceeds more than 1000 km ";
                    }
                    else
                    {
                        lblwarning.Text = "";
                    }

                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx");
    }


    private void loadResident()
    {
        string strpurpose = ddlPurpose.SelectedValue;

        if (strpurpose == "Resident")
        {
            lblcresident.Visible = true;
            lblcresident.Text = "Resident Name";
            cmbResident.Visible = true;
            cmbGeneral.Visible = false;
        }
        else if (strpurpose == "Guest")
        {
            lblcresident.Visible = true;
            lblcresident.Text = "Guest Name";
            cmbResident.Visible = false;
            cmbGeneral.Visible = true;
        }
        else
        {
            lblcresident.Visible = false;
            cmbResident.Visible = false;
            cmbGeneral.Visible = false;
        }
    }

    protected void ddlPurpose_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlVehicle.SelectedValue == "0" || ddlType.SelectedValue == "0")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Vehicle Name');", true);
                return;
            }
            LoadVehicleMaster();
            loadResident();
            if (ddlPurpose.SelectedValue == "Resident")
            {
                LoadResidentDet();
            }
            if (ddlPurpose.SelectedValue == "Guest")
            {
                LoadGuestDet();
            }
            if (ddlPurpose.SelectedValue == "Fuel")
            {
                LoadFuelDet();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void dtpStartDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            if (dtpStartDate != null)
            {
                dtpEndDate.SelectedDate = dtpStartDate.SelectedDate;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void dtpCDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            LoadVehicleMovement();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {

        DataSet dsStatement = sqlobj.ExecuteSP("SP_VMovement",
               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 },
               new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
               new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate },
               new SqlParameter() { ParameterName = "@VehicleCode", SqlDbType = SqlDbType.NVarChar, Value = ddlVehicleName.SelectedValue == "All" ? null : ddlVehicleName.SelectedValue }
               );

        DateTime sdate = DateTime.Now;


        if (dsStatement.Tables[0].Rows.Count > 0)
        {

            DataGrid dg = new DataGrid();

            dg.DataSource = dsStatement.Tables[0];
            dg.DataBind();




            // THE EXCEL FILE.
            string sFileName = "Vehicle Movement Register as of " + sdate.ToString("dd-MMM-yyyy HH:mm:ss") + ".xls";
            sFileName = sFileName.Replace("/", "");

            // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
            Response.ContentType = "application/vnd.ms-excel";
            EnableViewState = false;

            System.IO.StringWriter objSW = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);


            dg.HeaderStyle.Font.Bold = true;
            dg.HeaderStyle.BackColor = Color.GreenYellow; // SET EXCEL HEADERS AS BOLD.
            dg.RenderControl(objHTW);



            Response.Write("<table><tr><td><b>Vehicle Movement Register as of</b></td><td><b>:" + sdate.ToString("dd-MMM-yyyy HH:mm:ss") + "</b></td></tr></table>");


            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
            Response.Write(objSW.ToString());


            Response.End();
            dg = null;


        }
        else
        {
            WebMsgBox.Show("Vehicle Movement register details  does not exist");
        }
    }

    protected void txtNetAmount_TextChanged(object sender, EventArgs e)
    {

        string strtaxc = "";
        string strsgst = "";



        DataSet dsTaxc = sqlobj.ExecuteSP("SP_GetGST",
            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 }
            );


        if (dsTaxc.Tables[0].Rows.Count > 0)
        {
            strtaxc = dsTaxc.Tables[0].Rows[0]["CGST_PCNT"].ToString();
            Session["CGST"] = strtaxc.ToString();
            strsgst = dsTaxc.Tables[0].Rows[0]["SGST_PCNT"].ToString();
            Session["SGST"] = strsgst.ToString();
        }

        decimal CGSTPER = 0;
        decimal SGSTPER = 0;

        if (strtaxc.ToString() != "")
        {
            CGSTPER = Convert.ToDecimal(Session["CGST"].ToString());
        }
        if (strsgst.ToString() != "")
        {
            SGSTPER = Convert.ToDecimal(Session["SGST"].ToString());
        }

        if (txtNetAmount.Text != "")
        {
            decimal taxamount = CGSTPER * (Convert.ToDecimal(txtNetAmount.Text) / 100);
            decimal sgstamount = SGSTPER * (Convert.ToDecimal(txtNetAmount.Text) / 100);
            decimal grossamount = Convert.ToDecimal(txtNetAmount.Text) + Convert.ToDecimal(taxamount.ToString("0.00")) + Convert.ToDecimal(sgstamount.ToString("0.00"));
            txtTaxAmount.Text = taxamount.ToString("0.00");
            txtSGSTAmouont.Text = sgstamount.ToString("0.00");
            txtGrossAmount.Text = grossamount.ToString("0.00");
        }
    }
    //protected void ddlVehicleName_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        DataSet dsStatement = sqlobj.ExecuteSP("SP_VMovement",
    //          new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 },
    //          new SqlParameter() { ParameterName = "@VehicleCode", SqlDbType = SqlDbType.NVarChar, Value = ddlVehicleName.SelectedValue == "All" ? null : ddlVehicleName.SelectedValue }
    //          );
    //        if (dsStatement.Tables[0].Rows.Count > 0)
    //        {
    //            rgVMovement.DataSource = dsStatement;
    //            rgVMovement.DataBind();
    //            lnkcount.Text = "Count:" + dsStatement.Tables[0].Rows.Count;
    //        }
    //        else
    //        {
    //            rgVMovement.DataSource = string.Empty;
    //            rgVMovement.DataBind();
    //            lnkcount.Text = "Count:0";
    //        }
    //    }
    //    catch(Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);
    //    }
    //}
    protected void cmbGeneral_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsDetails = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 9 },
                new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbGeneral.SelectedValue.ToString() });
            Session["AccCode"] = dsDetails.Tables[0].Rows[0]["AccountCode"].ToString();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    private void LoadDate()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("Sp_ExcessShrtgeRpt", new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                rdtFrom.SelectedDate = DateTime.Parse(dsTitle.Tables[0].Rows[0]["From"].ToString());
                rdtTill.SelectedDate = DateTime.Parse(dsTitle.Tables[0].Rows[0]["Till"].ToString());
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (rdtFrom.SelectedDate > rdtTill.SelectedDate)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select Till date greater then or equal to From date.');", true);
                return;
            }
            DataSet dsStatement = sqlobj.ExecuteSP("SP_VMovement",
              new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 },
              new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
              new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate },
              new SqlParameter() { ParameterName = "@VehicleCode", SqlDbType = SqlDbType.NVarChar, Value = ddlVehicleName.SelectedValue == "All" ? null : ddlVehicleName.SelectedValue }
              );
            if (dsStatement.Tables[0].Rows.Count > 0)
            {
                rgVMovement.DataSource = dsStatement;
                rgVMovement.DataBind();
                lnkcount.Text = "Count:" + dsStatement.Tables[0].Rows.Count;
            }
            else
            {
                rgVMovement.DataSource = string.Empty;
                rgVMovement.DataBind();
                lnkcount.Text = "Count:0";
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }




    protected void rgVMovement_ItemDataBound(object sender, GridItemEventArgs e)
    {
        GridDataItem itm = e.Item as GridDataItem;
        if (itm != null)
        {
            if (itm.Cells[5].Text.Equals("Fuel"))
            {

                itm.Cells[1].ForeColor = System.Drawing.Color.Red;

                itm.Cells[2].ForeColor = System.Drawing.Color.Red;

                itm.Cells[3].ForeColor = System.Drawing.Color.Red;

                itm.Cells[4].ForeColor = System.Drawing.Color.Red;

                itm.Cells[5].ForeColor = System.Drawing.Color.Red;

                itm.Cells[6].ForeColor = System.Drawing.Color.Red;

                itm.Cells[7].ForeColor = System.Drawing.Color.Red;

                itm.Cells[8].ForeColor = System.Drawing.Color.Red;
                itm.Cells[9].ForeColor = System.Drawing.Color.Red;

                itm.Cells[10].ForeColor = System.Drawing.Color.Red;

                itm.Cells[11].ForeColor = System.Drawing.Color.Red;

                itm.Cells[12].ForeColor = System.Drawing.Color.Red;

                itm.Cells[13].ForeColor = System.Drawing.Color.Red;

                itm.Cells[14].ForeColor = System.Drawing.Color.Red;

                itm.Cells[15].ForeColor = System.Drawing.Color.Red;

                itm.Cells[16].ForeColor = System.Drawing.Color.Red;
                itm.Cells[17].ForeColor = System.Drawing.Color.Red;

            }
        }
    }
}