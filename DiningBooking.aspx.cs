using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class DiningBooking : System.Web.UI.Page
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

                dtpDiners.MinDate = DateTime.Now;

                dtpDiners.SelectedDate = DateTime.Now;

                LoadSession();

                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue),1);

            }

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 84 });


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


    private void LoadSession()
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_DinersSessionFilter",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value });

            ddlDinersSession.DataSource = dsFetchSE.Tables[0];
            ddlDinersSession.DataValueField = "SCode";
            ddlDinersSession.DataTextField = "SName";
            ddlDinersSession.DataBind();

            ddlDinersSession.Items.Insert(0, new ListItem("--Select--", "0"));

            dsFetchSE.Dispose();

        }
        catch (Exception ex)
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

            
           DataSet dsFetchSE = sqlobj.ExecuteSP("SP_GetResidentType",
            new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = Type },
            new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.Int, Value = ResidentType },
            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate },
            new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }
            
            );


            ddlByDoorNo.Items.Clear();

            if (dsFetchSE.Tables[0].Rows.Count>0)
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
        }
        catch (Exception ex)
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
                ddlDiner.SelectedValue = dsFetchSE.Tables[0].Rows[0]["Booked"].ToString();
                ddlGuest.SelectedValue = dsFetchSE.Tables[0].Rows[0]["GuestBooked"].ToString();


                hfregularcount.Value = dsFetchSE.Tables[0].Rows[0]["Booked"].ToString(); 
            }

            if (dsFetchSE.Tables[1].Rows.Count > 0)
            {
                decimal diningad = Convert.ToDecimal(dsFetchSE.Tables[1].Rows[0]["DiningAd"].ToString());

                if (diningad > 0)
                {
                    lbldiningmsg.Text = "Monthly Payment Rs." + diningad.ToString();

                    Session["MonthlyCharge"] = diningad.ToString();

                }
                else
                {


                    lbldiningmsg.Text = "";

                    Session["MonthlyCharge"] = "";
                }


            }

            DataSet dsCharge = sqlobj.ExecuteSP("SP_GetSessionCharges",
                 new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue });
           
             if (dsCharge.Tables[0].Rows.Count >0)
             {

                 decimal dRegularRate = 0;

                 if (lbldiningmsg.Text == "")
                 {

                     dRegularRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["RegularRate"].ToString());

                     dRegularRate = dRegularRate * Convert.ToInt32(ddlDiner.SelectedValue);
                 }


                 decimal dGuestRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["GuestRate"].ToString());

                 dGuestRate = dGuestRate * Convert.ToInt32(ddlGuest.SelectedValue);


                 if (lbldiningmsg.Text == "")
                 {
                     lblamtcharged.Text = "Amount to be charged: Rs." + Convert.ToString(dRegularRate + dGuestRate);

                 }
                 else
                 {
                     lblamtcharged.Text = "Amount to be charged: Rs." + Convert.ToString(dRegularRate + dGuestRate);
                 }


             }

             dsCharge.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlDiner_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet dsCharge = sqlobj.ExecuteSP("SP_GetSessionCharges",
               new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue });

            if (dsCharge.Tables[0].Rows.Count > 0)
            {
                decimal dRegularRate = 0;

                if (lbldiningmsg.Text == "")
                {

                    dRegularRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["RegularRate"].ToString());

                    dRegularRate = dRegularRate * Convert.ToInt32(ddlDiner.SelectedValue);
                }
                

                decimal dGuestRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["GuestRate"].ToString());

                dGuestRate = dGuestRate * Convert.ToInt32(ddlGuest.SelectedValue);


                if (lbldiningmsg.Text == "")
                {

                    lblamtcharged.Text = "Amount to be charged: Rs." + Convert.ToString(dRegularRate + dGuestRate);

                }
                else
                {
                    lblamtcharged.Text = "Amount to be charged: Rs." + Convert.ToString(dRegularRate + dGuestRate);
                }


            }

            dsCharge.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlGuest_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DataSet dsCharge = sqlobj.ExecuteSP("SP_GetSessionCharges",
               new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue });

            if (dsCharge.Tables[0].Rows.Count > 0)
            {

                decimal dRegularRate = 0;

                if (lbldiningmsg.Text == "")
                {

                    dRegularRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["RegularRate"].ToString());

                    dRegularRate = dRegularRate * Convert.ToInt32(ddlDiner.SelectedValue);
                }


                decimal dGuestRate = Convert.ToDecimal(dsCharge.Tables[0].Rows[0]["GuestRate"].ToString());

                dGuestRate = dGuestRate * Convert.ToInt32(ddlGuest.SelectedValue);


                if (lbldiningmsg.Text == "")
                {

                    lblamtcharged.Text = "Amount to be charged: Rs." + Convert.ToString(dRegularRate + dGuestRate);

                }
                else
                {
                    lblamtcharged.Text = "Amount to be charged: Rs." + Convert.ToString(dRegularRate + dGuestRate);
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


                sqlobj.ExecuteSP("SP_UpdateBookingDiners",
                       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                       new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                       new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = strDoorNo.ToString() },
                       new SqlParameter() { ParameterName = "@Actual", SqlDbType = SqlDbType.NVarChar, Value = ddlDiner.SelectedValue },
                       new SqlParameter() { ParameterName = "@GuestActual", SqlDbType = SqlDbType.NVarChar, Value = ddlGuest.SelectedValue },
                       new SqlParameter() { ParameterName = "@TotalActual", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt32(ddlDiner.SelectedValue) + Convert.ToInt32(ddlGuest.SelectedValue) }
                       );

                
                
                WebMsgBox.Show("Dining Booking confirmed for " + ddlByDoorNo.SelectedItem.Text + " on " + dtpDiners.SelectedDate.Value.ToString("dd-MMM-yyyy") + " Session :" + ddlDinersSession.SelectedItem.Text);

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
            //dtpDiners.SelectedDate = DateTime.Now;
            ddlByDoorNo.SelectedIndex = 0;
            ddlDiner.SelectedIndex = 0;
            ddlGuest.SelectedIndex = 0;
            //ddlDinersSession.SelectedIndex = 0;

            lblamtcharged.Text = "";
            lbldiningmsg.Text = "";

           
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }
    protected void btnNotNow_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("AllMenus.aspx");
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

                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 2);
            }
            else
            {
                LoadResident(Convert.ToInt32(ddlforwhom.SelectedValue), 1);
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}