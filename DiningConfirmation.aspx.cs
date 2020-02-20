using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;
using Telerik.Web.UI;

public partial class DiningConfirmation : System.Web.UI.Page
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

            rwSpecialReport.VisibleOnPageLoad = true;
            rwSpecialReport.Visible = false;


            if (!IsPostBack)
            {

                LoadTitle();

                dtpDiners.SelectedDate = DateTime.Now;

                SixDates();

                LoadSession();
                LoadDefaultSession();

                LoadDinerspersessiondetailsTotal();

                LoadSessionDetails(Convert.ToDateTime(ddlDates.SelectedValue));

                LoadDiningStatus();

                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue),1);

                LoadEvents();


                lbldiners.Text = "0";
                lblGuests.Text = "0";


            }

            rwMenuItems.VisibleOnPageLoad = true;
            rwMenuItems.Visible = false;

            rwHelp1.VisibleOnPageLoad = true;
            rwHelp1.Visible = false;

            rwHelp2.VisibleOnPageLoad = true;
            rwHelp2.Visible = false;

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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 85 });


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


    private void LoadEvents()
    {
        DataSet dsEvents = new DataSet();
        try
        {
           

            dsEvents = sqlobj.ExecuteSP("SP_TodaysEvent",
                new SqlParameter { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate });
            if (dsEvents.Tables[0].Rows.Count > 0)
            {
                lblmsg.Text = dsEvents.Tables[0].Rows[0]["EventName"].ToString();
            }
            else
            {
                lblmsg.Text = "";
            }
            

            dsEvents.Dispose();


        }
        catch (Exception ex)
        {

        }
    }

    private void LoadSession()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_ConfirmDinersSessionFilter",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value });

            ddlDinersSession.Items.Clear();

            if (dsFetchSE.Tables.Count>0)
            {

                if (dsFetchSE.Tables[0].Rows.Count > 0)
                {
                    ddlDinersSession.DataSource = dsFetchSE.Tables[0];
                    ddlDinersSession.DataValueField = "SCode";
                    ddlDinersSession.DataTextField = "SName";
                    ddlDinersSession.DataBind();
                }
            }

            ddlDinersSession.Items.Insert(0, new ListItem("--Select--", "0"));

            dsFetchSE.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    private void LoadDefaultSession()
    {

        try
        {
            DataSet dsNextSession = sqlobj.ExecuteSP("SP_GetNextCSession");

            if (dsNextSession.Tables[0].Rows.Count > 0)
            {
                ddlDinersSession.SelectedValue = dsNextSession.Tables[0].Rows[0]["SessionCode"].ToString();

               
            }

            dsNextSession.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    private void LoadSessionDetails(DateTime selectdate)
    {
        try
        {
            DataSet dsSessionDetails = sqlobj.ExecuteSP("SP_GetDinersSessionDetails",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = selectdate });

            if (dsSessionDetails.Tables[0].Rows.Count > 0)
            {
                rgDinersSessionDetails.DataSource = dsSessionDetails;
                rgDinersSessionDetails.DataBind();

            }
            else
            {
                rgDinersSessionDetails.DataSource = string.Empty;
                rgDinersSessionDetails.DataBind();
            }



            dsSessionDetails.Dispose();

             DateTime forday = Convert.ToDateTime(ddlDates.SelectedValue);

            GridFooterItem item = (GridFooterItem)rgDinersSessionDetails.MasterTableView.GetItems(GridItemType.Footer)[0];
            item["SessionName"].Text = forday.ToString("ddd") + ',' + ddlDates.SelectedValue;
            

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void ddlforwhom_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkDoorNo.Checked == true)
            {

                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 2);
            }
            else
            {
                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 1);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadResident(int Type,int ResidentType)
    {
        try
        {

            DataSet dsFetchSE = sqlobj.ExecuteSP("SP_GetNotUpdatedResidentType",
             new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = Type },
             new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.Int, Value = ResidentType },
             new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate },
             new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }
             );


            ddlByDoorNo.Items.Clear();

            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {

                ddlByDoorNo.DataSource = dsFetchSE.Tables[0];
                ddlByDoorNo.DataValueField = "rtrsn";
                ddlByDoorNo.DataTextField = "Name";
                ddlByDoorNo.DataBind();
            }

            ddlByDoorNo.Items.Insert(0, new ListItem("--Select--", "0"));

            dsFetchSE.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void dtpDiners_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            LoadSession();
            
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlByDoorNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_GetDinerforDoors",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = ddlByDoorNo.SelectedValue });

            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {   
                lbldiners.Text = dsFetchSE.Tables[0].Rows[0]["Booked"].ToString();
                lblGuests.Text = dsFetchSE.Tables[0].Rows[0]["GuestBooked"].ToString();

                ddlDinerDined.SelectedValue = dsFetchSE.Tables[0].Rows[0]["Booked"].ToString();

                ddlGuestDined.SelectedValue = dsFetchSE.Tables[0].Rows[0]["GuestBooked"].ToString();

                btnBookNow.Enabled = true;

            }
            else
            {

                lbldiners.Text = "0";
                ddlDinerDined.SelectedIndex = 0;
                
                lbldinerswarning.Text = "";

                lblguestwarning.Text = "";

                lblGuests.Text = "0";

                ddlGuestDined.SelectedIndex = 0;

                lbldineramount.Text = "";
                lblguestamount.Text = "";

                btnBookNow.Enabled = false;

            }

            if (dsFetchSE.Tables[1].Rows.Count > 0)
            {
                decimal diningad = Convert.ToDecimal(dsFetchSE.Tables[1].Rows[0]["DiningAd"].ToString());

                if (diningad > 0)
                {
                   // lbldiningmsg.Text = "Monthly Payment Rs." + diningad.ToString();

                    Session["MonthlyCharge"] = diningad.ToString();

                }
                else
                {

                   // lbldiningmsg.Text = "";

                    Session["MonthlyCharge"] = "";
                }


            }

            DataSet dsCharge = sqlobj.ExecuteSP("SP_GetSessionCharges",
                 new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue });

            if (dsCharge.Tables[0].Rows.Count > 0)
            {

                decimal dRegularRate = 0;


                if (Session["MonthlyCharge"].ToString() == "")
                {

                    dRegularRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["RegularRate"].ToString());

                    dRegularRate = dRegularRate * Convert.ToInt32(lbldiners.Text);

                    lbldineramount.Text = dRegularRate.ToString();
                }
                else
                {
                    lbldineramount.Text = "Regular Prepaid";
                }


                decimal dGuestRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["GuestRate"].ToString());

                dGuestRate = dGuestRate * Convert.ToInt32(lblGuests.Text);

                lblguestamount.Text = dGuestRate.ToString();
                

                if (lbldiningmsg.Text == "")
                {

                   // lblamtcharged.Text = "Amount to be charged: Rs." + Convert.ToString(dRegularRate + dGuestRate);

                }
                else
                {
                    //lblamtcharged.Text = "Amount to be charged: Rs." + Convert.ToString(dRegularRate + dGuestRate);
                }


            }

            dsCharge.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlDinerDined_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet dsCharge = sqlobj.ExecuteSP("SP_GetSessionCharges",
               new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue });

            if (dsCharge.Tables[0].Rows.Count > 0)
            {
                 decimal dRegularRate = 0;

                 if (Session["MonthlyCharge"] == "")
                 {

                     dRegularRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["RegularRate"].ToString());

                     dRegularRate = dRegularRate * Convert.ToInt32(ddlDinerDined.SelectedValue);

                     lbldineramount.Text = dRegularRate.ToString();
                 }
                 else
                 {
                     lbldineramount.Text = "Regular Prepaid";
                 }


                 int idiners = Convert.ToInt32(lbldiners.Text);
                 int iadiners = Convert.ToInt32(ddlDinerDined.SelectedValue);

                 if (idiners != iadiners)
                 {
                    lbldinerswarning.Text = "(Not Equal)";
                 }
                 else
                 {
                     lbldinerswarning.Text = "";
                 }

            }

            dsCharge.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlGuestDined_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
             DataSet dsCharge = sqlobj.ExecuteSP("SP_GetSessionCharges",
               new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue });

             if (dsCharge.Tables[0].Rows.Count > 0)
             {

                 decimal dRegularRate = 0;

                 

                 decimal dGuestRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["GuestRate"].ToString());

                 dGuestRate = dGuestRate * Convert.ToInt32(ddlGuestDined.SelectedValue);

                 lblguestamount.Text = dGuestRate.ToString();


                 int iguests = Convert.ToInt32(lblGuests.Text);
                 int iaguests = Convert.ToInt32(ddlGuestDined.SelectedValue);

                 if (iguests != iaguests)
                 {
                     lblguestwarning.Text = "(Not Equal)";
                 }
                 else
                 {
                     lblguestwarning.Text = "";
                 }
                 
             }

             dsCharge.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnBookNow_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {


                string strDoorNo = ddlByDoorNo.SelectedValue;


                sqlobj.ExecuteSP("SP_UpdateActualDiners",
                       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                       new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                       new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = strDoorNo.ToString() },
                       new SqlParameter() { ParameterName = "@Actual", SqlDbType = SqlDbType.NVarChar, Value = ddlDinerDined.SelectedValue },
                       new SqlParameter() { ParameterName = "@GuestActual", SqlDbType = SqlDbType.NVarChar, Value = ddlGuestDined.SelectedValue },
                       new SqlParameter() { ParameterName = "@TotalActual", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt32(ddlDinerDined.SelectedValue) + Convert.ToInt32(ddlGuestDined.SelectedValue) }
                       );


                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 1);

                LoadDinerspersessiondetailsTotal();

                LoadSessionDetails(Convert.ToDateTime(dtpDiners.SelectedDate));
                

                WebMsgBox.Show("Dining confirmed and will be billed at month end " + ddlByDoorNo.SelectedItem.Text + " on " + dtpDiners.SelectedDate.Value.ToString("dd-MMM-yyyy") + " Session :" + ddlDinersSession.SelectedItem.Text);


                Clear();
            }
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
           // dtpDiners.SelectedDate = DateTime.Now;
            ddlByDoorNo.SelectedIndex = 0;
        

            lbldiners.Text = "0";
            lblGuests.Text = "0";
            ddlDinerDined.SelectedIndex = 0;
            ddlGuestDined.SelectedIndex = 0;
            //ddlDinersSession.SelectedIndex = 0;

            LoadDinerspersessiondetailsTotal();


            lbldineramount.Text = "";
            lblguestamount.Text = "";

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }

    protected void btnNotNow_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Dashboard.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void chkDoorNo_CheckedChanged(object sender, EventArgs e)
    {
        try
        {

            if (chkDoorNo.Checked == true)
            {
                chkRegular.Checked = false;

                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 2);
            }
            else
            {
                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 1);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlDinersSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkDoorNo.Checked == true)
            {
                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 2);
               
            }
            else
            {
                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 1);
            }

            LoadBooking();

            LoadDinerspersessiondetailsTotal();

            LoadDiningStatus();
            
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadDinerspersessiondetailsTotal()
    {
        try
        {

            string stimeandrate = "";

            DataSet dsdinersTotal = sqlobj.ExecuteSP("SP_DinersPerSessionTotal",
                       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                       new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }

                       );


            if (dsdinersTotal.Tables[0].Rows.Count > 0)
            {
                rgDinersTotal.DataSource = dsdinersTotal.Tables[0];
                rgDinersTotal.DataBind();

            }
            else
            {
                rgDinersTotal.DataSource = string.Empty;
                rgDinersTotal.DataBind();
            }


            if (dsdinersTotal.Tables[1].Rows.Count > 0)
            {
               stimeandrate = ddlDinersSession.SelectedItem.Text + " - From:" + dsdinersTotal.Tables[1].Rows[0]["FromTime"].ToString() + " Till:" + dsdinersTotal.Tables[1].Rows[0]["TillTime"].ToString();
            }
            else
            {
                lblsessionandtime.Text = "";
            }


            if (dsdinersTotal.Tables[2].Rows.Count > 0)
            {

                lblsessionandtime.Text = stimeandrate + " ( Resident Rs." + dsdinersTotal.Tables[2].Rows[0]["Regular"].ToString() + " Guest Rs." + dsdinersTotal.Tables[2].Rows[0]["Guest"].ToString() + ")";

                //rgDinersRate.DataSource = dsdinersTotal.Tables[2];
               // rgDinersRate.DataBind();

            }
            else
            {
               // rgDinersRate.DataSource = string.Empty;
               // rgDinersRate.DataBind();
            }


           
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }


    }

    private void LoadDiningStatus()
    {
        try
        {

            DateTime currenttime = DateTime.Now;

            DataSet dsdiners = sqlobj.ExecuteSP("SP_SelectDiners",
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                    new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                    new SqlParameter() { ParameterName = "@Time", SqlDbType = SqlDbType.Time, Value = currenttime.ToString("HH:mm") }

                    );


            // Color code change for session

            string strSessionCode = "";
            string dinestatus = "";

            if (dsdiners.Tables[0].Rows.Count > 0)
            {
                dinestatus = dsdiners.Tables[0].Rows[0]["BStatus"].ToString();
            }



            if (dinestatus.ToString() == "90")
            {
                lblsessionandtime.ForeColor = Color.Blue;

                Session["DiningStatus"] = "Done previous billing";
            }
            else if (dtpDiners.SelectedDate < DateTime.Today)
            {

                lblsessionandtime.ForeColor = Color.Red;
                Session["DiningStatus"] = "Done";
            }
            else if (dtpDiners.SelectedDate > DateTime.Today)
            {
                lblsessionandtime.ForeColor = Color.Maroon;

                Session["DiningStatus"] = "Yet to Open";
            }
            else
            {
                // -- Closed session

                int k = dsdiners.Tables[1].Rows.Count - 1;


                if (dsdiners.Tables[1].Rows.Count > 0)
                {

                    for (int i = 0; i <= dsdiners.Tables[1].Rows.Count - 1; i++)
                    {

                        strSessionCode = dsdiners.Tables[1].Rows[i]["SessionCode"].ToString();

                        if (strSessionCode.Equals(ddlDinersSession.SelectedValue))
                        {
                            lblsessionandtime.ForeColor = Color.Red;
                            Session["DiningStatus"] = "Done";
                        }
                        else
                        {
                            if (k == i)
                            {

                                // Inprogress session

                                if (dsdiners.Tables[2].Rows.Count > 0)
                                {

                                    strSessionCode = dsdiners.Tables[2].Rows[0]["SessionCode"].ToString();

                                    if (strSessionCode.Equals(ddlDinersSession.SelectedValue))
                                    {
                                        lblsessionandtime.ForeColor = Color.Green;

                                        Session["DiningStatus"] = "Open";
                                    }
                                    else
                                    {
                                        for (int j = 0; j < dsdiners.Tables[3].Rows.Count; j++)
                                        {

                                            strSessionCode = dsdiners.Tables[3].Rows[j]["SessionCode"].ToString();

                                            if (strSessionCode.Equals(ddlDinersSession.SelectedValue))
                                            {
                                                lblsessionandtime.ForeColor = Color.Orange;

                                                Session["DiningStatus"] = "Yet to Open";
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    for (int j = 0; j < dsdiners.Tables[3].Rows.Count; j++)
                                    {

                                        strSessionCode = dsdiners.Tables[3].Rows[j]["SessionCode"].ToString();

                                        if (strSessionCode.Equals(ddlDinersSession.SelectedValue))
                                        {
                                            lblsessionandtime.ForeColor = Color.Orange;

                                            Session["DiningStatus"] = "Yet to Open";
                                        }
                                    }
                                }


                            }


                        }
                    }
                }
                else
                {
                    // Inprogress session

                    if (dsdiners.Tables[2].Rows.Count > 0)
                    {

                        strSessionCode = dsdiners.Tables[2].Rows[0]["SessionCode"].ToString();

                        if (strSessionCode.Equals(ddlDinersSession.SelectedValue))
                        {
                            lblsessionandtime.ForeColor = Color.Green;

                            Session["DiningStatus"] = "Open";
                        }
                        else
                        {
                            for (int j = 0; j < dsdiners.Tables[3].Rows.Count; j++)
                            {

                                strSessionCode = dsdiners.Tables[3].Rows[j]["SessionCode"].ToString();

                                if (strSessionCode.Equals(ddlDinersSession.SelectedValue))
                                {
                                    lblsessionandtime.ForeColor = Color.Orange;

                                    Session["DiningStatus"] = "Yet to Open";
                                }
                            }
                        }
                    }
                    else
                    {
                        for (int j = 0; j < dsdiners.Tables[3].Rows.Count; j++)
                        {

                            strSessionCode = dsdiners.Tables[3].Rows[j]["SessionCode"].ToString();

                            if (strSessionCode.Equals(ddlDinersSession.SelectedValue))
                            {
                                lblsessionandtime.ForeColor = Color.Orange;

                                Session["DiningStatus"] = "Yet to Open";
                            }
                        }
                    }
                }



            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    private void LoadBooking()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_DailyDinersUpdateDropDown",
                 new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                  new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }
            
                  );


            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {

                //lblbooked.Text = dsFetchSE.Tables[1].Rows[0]["Booked"].ToString();
               // lblguestbooked.Text = dsFetchSE.Tables[1].Rows[0]["GuestBooked"].ToString();
               // lblactualbooked.Text = dsFetchSE.Tables[1].Rows[0]["Actual"].ToString();
               // lblactualguest.Text = dsFetchSE.Tables[1].Rows[0]["GuestActual"].ToString();
            }

            dsFetchSE.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void chkChoose_CheckedChanged(object sender, EventArgs e)
    {
        try
        {

            //if (chkChoose.Checked == true)
            //{
            //    ddlDinerDined.SelectedValue = lbldiners.Text;
            //    ddlGuestDined.SelectedValue = lblGuests.Text;


            //}
            //else
            //{
            //    ddlDinerDined.SelectedIndex = 0;
            //    ddlGuestDined.SelectedIndex = 0;
            //}
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void chkRegular_CheckedChanged(object sender, EventArgs e)
    {
        try
        {

            if (chkRegular.Checked == true)
            {
                chkDoorNo.Checked = false; 

                LoadResident(4, 1);
            }
            else
            {
                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 1);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void SixDates()
    {
        try
        {
            DateTime currentdate= DateTime.Now;

            List<DateTime> listdates = Pastsixdates(currentdate);


            for (int i = 0; i < listdates.Count; i++)
            {
                DateTime dates = Convert.ToDateTime(listdates[i].ToString());

                ddlDates.Items.Add(dates.ToString("dd-MMM-yyyy"));

                //ddlDates.Items.Add(listdates[i].ToString());
            }


            DateTime cdate = DateTime.Now;

            ddlDates.SelectedValue = cdate.ToString("dd-MMM-yyyy");


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    public List<DateTime> Pastsixdates(DateTime currentdate)
    {
        List<DateTime> psixdays = new List<DateTime>();

        int i = 0;
        int k = 6;
 
        while (i <= 5)
        {   

             DateTime dates = currentdate.AddDays(-(k-i));

            psixdays.Add(dates);

            i = i + 1;
        }


        int j = 0;

        DateTime futuredate = DateTime.Now;

        psixdays.Add(futuredate);

        while (j <= 6)
        {
            futuredate = futuredate.AddDays(1);

            psixdays.Add(futuredate);

            j = j + 1;
            
        }

        return psixdays;

    }
    protected void ddlDates_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadSessionDetails(Convert.ToDateTime(ddlDates.SelectedValue));


            DateTime forday = Convert.ToDateTime(ddlDates.SelectedValue);

            GridFooterItem item = (GridFooterItem)rgDinersSessionDetails.MasterTableView.GetItems(GridItemType.Footer)[0];
            item["SessionName"].Text = forday.ToString("ddd") + ',' + ddlDates.SelectedValue;
  


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnDiningBooking_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("DiningBookingNew.aspx");

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
   
    protected void btnOneTouchUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("BulkUpdate.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnMenuItems_Click(object sender, EventArgs e)
    {
        try
        {
            LoadMenuItems();
            rwMenuItems.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void rgMenuItem_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            LoadMenuItems();
            rwMenuItems.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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
                rgMenuItem.DataSource = dsMenu.Tables[0];
                rgMenuItem.DataBind();
            }
            else
            {
                rgMenuItem.DataSource = string.Empty;
                rgMenuItem.DataBind();
            }

            dsMenu.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void Help1_Click(object sender, EventArgs e)
    {
        try
        {
            rwHelp1.Visible = true;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void Help2_Click(object sender, EventArgs e)
    {
        try
        {
            rwHelp2.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnAlacarteBilling_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Booking A la carte menu");
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnDailyMenu_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("MenuItemPerday.aspx");
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnCalendar_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Calendar.aspx");
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void lnkprofile_Click(object sender, EventArgs e)
    {

        try
        {

            DataSet dsSpecialReport = sqlobj.ExecuteSP("SP_ResidentSpecialReport",
                  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = ddlByDoorNo.SelectedValue });

            if (dsSpecialReport.Tables[0].Rows.Count > 0)
            {

                lblRName.Text = dsSpecialReport.Tables[0].Rows[0]["Name"].ToString();
                lblRStatus.Text = dsSpecialReport.Tables[0].Rows[0]["RStatus"].ToString();
                lblRDoorNo.Text = dsSpecialReport.Tables[0].Rows[0]["DoorNo"].ToString();

                rgSpecialReport.DataSource = dsSpecialReport;
                rgSpecialReport.DataBind();

                rwSpecialReport.Visible = true;
            }
            else
            {
                rgSpecialReport.DataSource = string.Empty;
                rwSpecialReport.DataBind();


                rwSpecialReport.Visible = false;
            }

            dsSpecialReport.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

}