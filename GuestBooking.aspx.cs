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
using System.Globalization;

public partial class GuestBooking : System.Web.UI.Page
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
                lnkaddnewtask.Text = "+ Add Booking";
                LoadTitle();
                LoadGuestBookingDetails();
                LoadFacilityGroup();
                LoadResidentDet();
                ddlBookingFor.Items.Insert(0, "--Select--");               
                //dtpfromdate.MinDate = DateTime.Now;
                //dtptilldate.MinDate = DateTime.Now;
                dtpfromdate.SelectedDate = DateTime.Now;
                dtptilldate.SelectedDate = DateTime.Now;
                btnSave.Visible = true;
                btnUpdate.Visible = false;
                lblcresident.Visible = false;
                cmbResident.Visible = false;
                lblstatus.Visible = false;
                ddlStatus.Visible = false;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
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

            

            ddlBookingType.SelectedIndex = 0;


            ddlBookingType_SelectedIndexChanged(null, null);


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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 119 });


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
           

            LoadGuestBookingDetails();

            btnSave.Visible = true;
            btnUpdate.Visible = false;

          

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
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 }
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


                sqlobj.ExecuteSQLNonQuery("SP_GuestBooking",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                       new SqlParameter() { ParameterName = "@BookingType", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                       new SqlParameter() { ParameterName = "@BookingFor", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingFor.SelectedValue },
                       new SqlParameter() { ParameterName = "@Purpose", SqlDbType = SqlDbType.NVarChar, Value = ddlPurpose.SelectedValue },
                       new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
                       new SqlParameter() { ParameterName = "@Address", SqlDbType = SqlDbType.NVarChar, Value = txtAddress.Text },
                       new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = txtMobileNo.Text },
                       new SqlParameter() { ParameterName = "@EmailId", SqlDbType = SqlDbType.NVarChar, Value = txtEmailID.Text },
                       new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = dtpfromdate.SelectedDate == null ? null : dtpfromdate.SelectedDate },
                       new SqlParameter() { ParameterName = "@TillDate", SqlDbType = SqlDbType.DateTime, Value = dtptilldate.SelectedDate == null ? null : dtptilldate.SelectedDate },
                       new SqlParameter() { ParameterName = "@CheckInTime", SqlDbType = SqlDbType.Time, Value = null},
                       new SqlParameter() { ParameterName = "@CheckOutTime", SqlDbType = SqlDbType.Time, Value = null },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "00" },
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue == "0" ? null : cmbResident.SelectedValue },
                       new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text }

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

                string status = "";
               
                
                sqlobj.ExecuteSQLNonQuery("SP_GuestBooking",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@BookingType", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                       new SqlParameter() { ParameterName = "@BookingFor", SqlDbType = SqlDbType.NVarChar, Value = ddlBookingFor.SelectedValue },
                       new SqlParameter() { ParameterName = "@Purpose", SqlDbType = SqlDbType.NVarChar, Value = ddlPurpose.SelectedValue },
                       new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = txtName.Text },
                       new SqlParameter() { ParameterName = "@Address", SqlDbType = SqlDbType.NVarChar, Value = txtAddress.Text },
                       new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.NVarChar, Value = txtMobileNo.Text },
                       new SqlParameter() { ParameterName = "@EmailId", SqlDbType = SqlDbType.NVarChar, Value = txtEmailID.Text },
                       new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = dtpfromdate.SelectedDate == null ? null : dtpfromdate.SelectedDate },
                       new SqlParameter() { ParameterName = "@TillDate", SqlDbType = SqlDbType.DateTime, Value = dtptilldate.SelectedDate == null ? null : dtptilldate.SelectedDate },
                       new SqlParameter() { ParameterName = "@CheckInTime", SqlDbType = SqlDbType.Time, Value =  null },
                       new SqlParameter() { ParameterName = "@CheckOutTime", SqlDbType = SqlDbType.Time, Value =  null },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue},
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() },
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue == "0" ? null : cmbResident.SelectedValue },
                       new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text }
                       
                       );


                Clear();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Booking details updated');", true);
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

    protected void gvGuestBooking_ItemCommand(object sender, GridCommandEventArgs e)
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

                    DataSet dsRes = sqlobj.ExecuteSP("SP_GuestBooking",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text },
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.BigInt, Value = 4 }
                        );

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {

                        ddlBookingType.SelectedValue = dsRes.Tables[0].Rows[0]["BookingType"].ToString();

                        LoadBookingFor();

                        ddlBookingFor.SelectedValue = dsRes.Tables[0].Rows[0]["BookingFor"].ToString();


                        string sfromdate = dsRes.Tables[0].Rows[0]["FromDate"].ToString();
                        string stodate = dsRes.Tables[0].Rows[0]["TillDate"].ToString();
                       // string safromdate = dsRes.Tables[0].Rows[0]["ActualFromDate"].ToString();
                       // string satodate = dsRes.Tables[0].Rows[0]["ActualTillDate"].ToString();

                        if (sfromdate != "")
                        {
                            dtpfromdate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["FromDate"].ToString()).Date;
                        }
                        
                        if (stodate != "")
                        {
                            dtptilldate.SelectedDate = Convert.ToDateTime(dsRes.Tables[0].Rows[0]["TillDate"].ToString()).Date;
                        }                        

                        txtName.Text = dsRes.Tables[0].Rows[0]["Name"].ToString();
                        txtAddress.Text = dsRes.Tables[0].Rows[0]["Address"].ToString();
                        txtMobileNo.Text = dsRes.Tables[0].Rows[0]["MobileNo"].ToString();
                        txtEmailID.Text = dsRes.Tables[0].Rows[0]["EmailID"].ToString();
                        ddlPurpose.SelectedValue = dsRes.Tables[0].Rows[0]["Purpose"].ToString();
                        txtRemarks.Text = dsRes.Tables[0].Rows[0]["Remarks"].ToString();


                        if (ddlPurpose.SelectedValue == "Resident")
                        {
                            loadResident();

                            cmbResident.SelectedValue = dsRes.Tables[0].Rows[0]["RTRSN"].ToString();
                        }


                        ddlStatus.SelectedValue = dsRes.Tables[0].Rows[0]["Status"].ToString();


                        lblstatus.Visible = true;
                        ddlStatus.Visible = true;

                        string fromtime = dsRes.Tables[0].Rows[0]["CheckInTime"].ToString();
                        string totime = dsRes.Tables[0].Rows[0]["CheckOutTime"].ToString();
                       // string afromtime = dsRes.Tables[0].Rows[0]["ACheckInTime"].ToString();
                       // string atotime = dsRes.Tables[0].Rows[0]["ACheckOutTime"].ToString();

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

                        lnkaddnewtask.Text = "Close";
                        lnkaddnewtask.ToolTip = "Click here to close.";
                        pnladdnewtask.Visible = true;


                        btnSave.Visible = false;
                        btnUpdate.Visible = true;

                       
                    }

                    dsRes.Dispose();


                }
            }
            else if (e.CommandName =="CheckIn")
            {
               
                Session["GBRSN"] = e.CommandArgument.ToString();

                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    string bdate = ditem["FromDate"].Text;                    

                    string[] fdate = bdate.Split(',');

                    DateTime fromdate = Convert.ToDateTime(fdate[1].ToString());                    
                    DateTime odbdate = fromdate.AddDays(-1);                   

                    DateTime odadate = fromdate.AddDays(1);

                    DateTime sdate = DateTime.Now.Date;                    
                    //DateTime sdate = DateTime.ParseExact(DateTime.Now.Date.ToString(), "dd-MM-yyyy", CultureInfo.GetCultureInfo("hi-IN").DateTimeFormat);                    

                    if (sdate.Equals(fromdate) ||  sdate.Equals(odbdate) || sdate.Equals(odadate) )
                    {
                        Response.Redirect("~/GuestChkInOut.aspx");
                    }

                   
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

            //ddlBookingFor.Items.Insert(0, "--Select--");


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

                LinkButton lnkcheckout = (LinkButton)e.Item.FindControl("lnkCheckOut");
                string bdate = dataItem["FromDate"].Text;
                string[] fdate = bdate.Split(',');
                DateTime fromdate = DateTime.Parse(fdate[1].ToString());
                DateTime odbdate = fromdate.AddDays(-1);
                DateTime odadate = fromdate.AddDays(1);
                DateTime sdate = DateTime.Now.Date;
                //sdate = Convert.ToDateTime(sdate.ToString("dd-MM-yyy"));
                //if (sdate.Equals(fromdate) || sdate.Equals(odbdate))
                if (sdate.Date >= fromdate.Date) 
                {
                    lnkcheckout.Visible = true;
                }
                else
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
      

    }
    protected void BtnShow_Click(object sender, EventArgs e)
    {
        try
        {

            DataSet dsGuestBookingDetails = sqlobj.ExecuteSP("SP_GuestBookingReport");

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



    protected void lnkaddnewtask_Click(object sender, EventArgs e)
    {
        if (lnkaddnewtask.Text == "+ Add Booking")
        {
            lnkaddnewtask.Text = "Close";
            lnkaddnewtask.ToolTip = "Click here to close.";
            pnladdnewtask.Visible = true;
            //pnlbtns.Visible = true;
            //lblHeading2.Visible = true;
        }
        else
            if (lnkaddnewtask.Text == "Close")
            {
                lnkaddnewtask.Text = "+ Add Booking";
                lnkaddnewtask.ToolTip = "Click to add more bookings for the guest house.";
                pnladdnewtask.Visible = false;
                //pnlbtns.Visible = false;
                //lblHeading2.Visible = false;
            }
    }
}