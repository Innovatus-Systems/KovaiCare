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
using System.IO;
using System.Text;

public partial class SnapShot : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            rwResidents75plus.VisibleOnPageLoad = true;
            rwResidents75plus.Visible = false;

            rwSpecialattention.VisibleOnPageLoad = true;
            rwSpecialattention.Visible = false;

            rwServiceRate.VisibleOnPageLoad = true;
            rwServiceRate.Visible = false;

            if (!IsPostBack)
            {
                LoadTitle();

                LoadSnapShot();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 54 });


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

    private void LoadSnapShot()
    {
        try
        {

            DataSet dsSnapShot = sqlobj.ExecuteSP("SP_SnapShot");

            // Residents

            if (dsSnapShot.Tables[0].Rows.Count>0)
            {
                //lnkDwellingUnits.Text = dsSnapShot.Tables[0].Rows[0]["DwellingUnits"].ToString();

                //lbltotalhouse.Text = dsSnapShot.Tables[0].Rows[0]["DwellingUnits"].ToString();
                lnktotalhouse.Text = dsSnapShot.Tables[0].Rows[0]["DwellingUnits"].ToString();

               
            }

            if (dsSnapShot.Tables[1].Rows.Count > 0)
            {

                //lnkNoofResidnts.Text = dsSnapShot.Tables[1].Rows[0]["NoofResidnts"].ToString();

                //lblTotalResidents.Text = dsSnapShot.Tables[1].Rows[0]["NoofResidnts"].ToString();

                lnkTotalResidents.Text = dsSnapShot.Tables[1].Rows[0]["NoofResidnts"].ToString();
            }


            // Care & Safty

            if (dsSnapShot.Tables[2].Rows.Count > 0)
            {

                //lnkNoofLivingAlone.Text = dsSnapShot.Tables[2].Rows[0]["NoofLivingAlone"].ToString();
                
                lblsingle.Text = dsSnapShot.Tables[2].Rows[0]["NoofLivingAlone"].ToString();
            }

            if (dsSnapShot.Tables[3].Rows.Count > 0)
            {

                //lnkResidents75plus.Text = dsSnapShot.Tables[3].Rows[0]["Residents75plus"].ToString();

               // lbl75plus.Text = dsSnapShot.Tables[3].Rows[0]["Residents75plus"].ToString();
                lnk75plus.Text = dsSnapShot.Tables[3].Rows[0]["Residents75plus"].ToString();
            }

            if (dsSnapShot.Tables[4].Rows.Count > 0)
            {

               // lnkSpecialattention.Text  = dsSnapShot.Tables[4].Rows[0]["Specialattention"].ToString();
            }


            // Dining


            if (dsSnapShot.Tables[5].Rows.Count > 0)
            {

                //lnkBillingType.Text  = dsSnapShot.Tables[5].Rows[0]["BillingType"].ToString();
            }

            if (dsSnapShot.Tables[6].Rows.Count > 0)
            {

                //lnkBillingFrequency.Text  = dsSnapShot.Tables[6].Rows[0]["BillingFrequency"].ToString();
            }
           

            if (dsSnapShot.Tables[7].Rows.Count > 0)
            {

                //lnkNoofMenuItems.Text = dsSnapShot.Tables[7].Rows[0]["NoofMenuItems"].ToString();

                lblDMenuitems.Text = dsSnapShot.Tables[7].Rows[0]["NoofMenuItems"].ToString();
            }

            if (dsSnapShot.Tables[8].Rows.Count > 0)
            {

                //lnkDiningsessions.Text = dsSnapShot.Tables[8].Rows[0]["DiningSessions"].ToString();
            }

            if (dsSnapShot.Tables[9].Rows.Count > 0)
            {

                //lnkFoodItems.Text = dsSnapShot.Tables[9].Rows[0]["FoodItems"].ToString();
            }

            if (dsSnapShot.Tables[10].Rows.Count > 0)
            {

                //lnkDiningSessionUpto.Text  = dsSnapShot.Tables[10].Rows[0]["DiningSessionUpto"].ToString();

                lblDMenuupto.Text = dsSnapShot.Tables[10].Rows[0]["DiningSessionUpto"].ToString();
            }

            if (dsSnapShot.Tables[11].Rows.Count > 0)
            {

                //lnkMenufordayDefinedUpto.Text  = dsSnapShot.Tables[11].Rows[0]["MenufordayDefinedUpto"].ToString();

                lblDSessionupto.Text = dsSnapShot.Tables[11].Rows[0]["MenufordayDefinedUpto"].ToString();
            }

            // Billing


            if (dsSnapShot.Tables[12].Rows.Count > 0)
            {

                //lnkBillingMonthsDefinedUpto.Text  = dsSnapShot.Tables[12].Rows[0]["BillingMonthsDefinedUpto"].ToString();
            }

            if (dsSnapShot.Tables[13].Rows.Count > 0)
            {

                //lnkCurrentBillingMonth.Text  = dsSnapShot.Tables[13].Rows[0]["CurrentBillingMonth"].ToString();
            }

            if (dsSnapShot.Tables[14].Rows.Count > 0)
            {

                //lnkLastBillingMonth.Text = dsSnapShot.Tables[14].Rows[0]["LastBillingMonth"].ToString();
            }

            if (dsSnapShot.Tables[15].Rows.Count > 0)
            {

                //lnkbilledlastmonth.Text = dsSnapShot.Tables[15].Rows[0]["billedlastmonth"].ToString();
            }

            if (dsSnapShot.Tables[16].Rows.Count > 0)
            {

                //lnkaccruedthismonth.Text = dsSnapShot.Tables[16].Rows[0]["accruedthismonth"].ToString();
            }

            // Service Requsts

            if (dsSnapShot.Tables[17].Rows.Count > 0)
            {

                //lnkTypeofservices.Text = dsSnapShot.Tables[17].Rows[0]["Typeofservices"].ToString();
            }

            if (dsSnapShot.Tables[18].Rows.Count > 0)
            {

                //lnkTypeofserviceswithRate.Text = dsSnapShot.Tables[18].Rows[0]["TypeofserviceswithRate"].ToString();
            }

            // Assets

            if (dsSnapShot.Tables[19].Rows.Count > 0)
            {

                //lnkNoofAssets.Text = dsSnapShot.Tables[19].Rows[0]["NoofAssets"].ToString();
            }


            // System Parameters

            if (dsSnapShot.Tables[20].Rows.Count > 0)
            {

                //lnkCommunityName.Text = dsSnapShot.Tables[20].Rows[0]["CommunityName"].ToString();
            }

            if (dsSnapShot.Tables[20].Rows.Count > 0)
            {

                //lnkCommunitycode.Text = dsSnapShot.Tables[20].Rows[0]["Communitycode"].ToString();
            }

            if (dsSnapShot.Tables[20].Rows.Count > 0)
            {

                //lnkManager.Text = dsSnapShot.Tables[20].Rows[0]["Manager"].ToString();
            }

            if (dsSnapShot.Tables[20].Rows.Count > 0)
            {

                //lnkOfficialEmailID.Text = dsSnapShot.Tables[20].Rows[0]["OfficialEmailID"].ToString();
            }

            if (dsSnapShot.Tables[20].Rows.Count > 0)
            {

                //lnkOfficialMobileNo.Text = dsSnapShot.Tables[20].Rows[0]["OfficialMobileNo"].ToString();
            }

            if (dsSnapShot.Tables[21].Rows.Count > 0)
            {

                //lnkHouseinVacantStatus.Text  = dsSnapShot.Tables[21].Rows[0]["Housesinvacantstatus"].ToString();

                //lblvacant.Text = dsSnapShot.Tables[21].Rows[0]["Housesinvacantstatus"].ToString();
                lnkvacant.Text = dsSnapShot.Tables[21].Rows[0]["Housesinvacantstatus"].ToString();
            }

            if (dsSnapShot.Tables[22].Rows.Count > 0)
            {

               // lnkHouseinOccupiedStatus.Text  = dsSnapShot.Tables[22].Rows[0]["Housesinoccupiedstatus"].ToString();

                //lbloccupied.Text = dsSnapShot.Tables[22].Rows[0]["Housesinoccupiedstatus"].ToString();
                lnkoccupied.Text = dsSnapShot.Tables[22].Rows[0]["Housesinoccupiedstatus"].ToString();
            }

            if (dsSnapShot.Tables[23].Rows.Count > 0)
            {

                //lnkHouseinBlokedStatus.Text = dsSnapShot.Tables[23].Rows[0]["Housesinblockedstatus"].ToString();

                //lblblocked.Text = dsSnapShot.Tables[23].Rows[0]["Housesinblockedstatus"].ToString();

                lnkblocked.Text = dsSnapShot.Tables[23].Rows[0]["Housesinblockedstatus"].ToString();
            }

            if (dsSnapShot.Tables[24].Rows.Count > 0)
            {

                //lnkhouseinlockedstatus.Text = dsSnapShot.Tables[24].Rows[0]["Housesinlockedstatus"].ToString();

                //lbllocked.Text = dsSnapShot.Tables[24].Rows[0]["Housesinlockedstatus"].ToString();
                lnklocked.Text = dsSnapShot.Tables[24].Rows[0]["Housesinlockedstatus"].ToString(); 
            }

            if (dsSnapShot.Tables[25].Rows.Count > 0)
            {

                //lnknoofresidentprofiles.Text = dsSnapShot.Tables[25].Rows[0]["Noofresidentprofiles"].ToString();
            }

            if (dsSnapShot.Tables[26].Rows.Count > 0)
            {

                //lnkprimaryresidents.Text = dsSnapShot.Tables[26].Rows[0]["primaryresident"].ToString();
            }

            if (dsSnapShot.Tables[27].Rows.Count > 0)
            {

                //lnkdependents.Text = dsSnapShot.Tables[27].Rows[0]["Dependents"].ToString();
            }

            if (dsSnapShot.Tables[28].Rows.Count > 0)
            {

                //  lnkhousekeepingscheduledupto.Text = dsSnapShot.Tables[28].Rows[0]["HouseKeepingTasksScheduledUpto"].ToString();

                lblhkscheduledupto.Text = dsSnapShot.Tables[28].Rows[0]["HouseKeepingTasksScheduledUpto"].ToString();
            }

            if (dsSnapShot.Tables[30].Rows.Count > 0)
            {
                //lnknoofdetailedprofilesadded.Text = dsSnapShot.Tables[30].Rows[0]["NoDetProfiles"].ToString();
            }

            if (dsSnapShot.Tables[31].Rows.Count > 0)
            {
                //lnkRegularResidents.Text = dsSnapShot.Tables[31].Rows[0]["Regular"].ToString();

                lblRegulardiners.Text = dsSnapShot.Tables[31].Rows[0]["Regular"].ToString();  
            }

            if (dsSnapShot.Tables[32].Rows.Count > 0)
            {
                //lnkCasualDiners.Text = dsSnapShot.Tables[32].Rows[0]["Casual"].ToString();
                lblcasualdiners.Text = dsSnapShot.Tables[32].Rows[0]["Casual"].ToString();
            }
           
             if (dsSnapShot.Tables[33].Rows.Count > 0)
            {

                //lnkSpecialCodes.Text = dsSnapShot.Tables[33].Rows[0]["SpecialCodes"].ToString();
            }

            if (dsSnapShot.Tables[34].Rows.Count>0)
            {
                //lnkWarrentyending.Text = dsSnapShot.Tables[34].Rows[0]["TotalWarrnty"].ToString();

                //int iwt = Convert.ToInt32(lnkWarrentyending.Text); 

                //if (iwt > 0)
                //{
                //    lblmsgWarrentyending.Text = "Warranty ending in 30 days for certain assets";
                //}
                //else
                //{
                //    lblmsgWarrentyending.Text = "";
                //}
            }

            if (dsSnapShot.Tables[35].Rows.Count > 0)
            {
                //lnkamcending.Text = dsSnapShot.Tables[35].Rows[0]["TotalAMC"].ToString();

                //int iwt = Convert.ToInt32(lnkamcending.Text);

                //if (iwt > 0)
                //{
                //    lblmsgamcending.Text = "AMC ending in 30 days for certain assets";
                //}
                //else
                //{
                //    lblmsgamcending.Text = "";
                //}
            }

            if (dsSnapShot.Tables[36].Rows.Count > 0)
            {
               // lnkbirthday.Text = dsSnapShot.Tables[36].Rows[0]["ResidentBirthday"].ToString();

                lblBirthdays.Text = dsSnapShot.Tables[36].Rows[0]["ResidentBirthday"].ToString();

               // int iwt = Convert.ToInt32(lnkbirthday.Text);

                //if (iwt > 0)
                //{
                //    lblmsgbirthday.Text = "Birthdays coming up";


                //}
                //else
                //{
                //    lnkbirthday.Text = "None";
                //    lnkbirthday.ForeColor = Color.Brown ;
                //    lblmsgbirthday.Text = "";
                //}
            }


            if (dsSnapShot.Tables[37].Rows.Count > 0)
            {
                //lnkeventsactivities.Text = dsSnapShot.Tables[37].Rows[0]["TaskorEventCount"].ToString();

                //int iwt = Convert.ToInt32(lnkeventsactivities.Text);

                //if (iwt > 0)
                //{
                //    lblmsgeventsactivities.Text = "Events / Activities coming up";
                //}
                //else
                //{
                //    lnkeventsactivities.Text = "None";
                //    lnkeventsactivities.ForeColor = Color.Brown;
                //    lblmsgeventsactivities.Text = "";
                //}
            }


            if (dsSnapShot.Tables[39].Rows.Count > 0)
            {
                string strmd  = dsSnapShot.Tables[39].Rows[0]["MonthEnd"].ToString();

               

                if (strmd.ToString() == "Yes")
                {
                    //lblmonthendcoming.Text = "       (Month End coming up. Ensure all bills are in order)";
                }
                else
                {
                    //lblmonthendcoming.Text = " ";
                }
            }

            if (dsSnapShot.Tables[40].Rows.Count > 0)
            {
                lblunasgnd.Text = dsSnapShot.Tables[40].Rows[0]["UnAsgnd"].ToString();
            }

            if (dsSnapShot.Tables[41].Rows.Count > 0)
            {
                lblwalkin.Text = dsSnapShot.Tables[41].Rows[0]["WALKIN"].ToString();
            }


            if (dsSnapShot.Tables[42].Rows.Count > 0)
            {
                lblstaff.Text = dsSnapShot.Tables[42].Rows[0]["STAFF"].ToString();
            }


            if (dsSnapShot.Tables[43].Rows.Count > 0)
            {
                lblhktotaltoday.Text = dsSnapShot.Tables[43].Rows[0]["HkTotalToday"].ToString();
            }


            if (dsSnapShot.Tables[44].Rows.Count > 0)
            {
                lblhkdonetoday.Text = dsSnapShot.Tables[44].Rows[0]["HkDoneToday"].ToString();
            }

           
            if (dsSnapShot.Tables[45].Rows.Count > 0)
            {
                lblhkoverdue.Text = dsSnapShot.Tables[45].Rows[0]["HkOverdue"].ToString();
            }

            if (dsSnapShot.Tables[46].Rows.Count > 0)
            {
                lblhkstaff.Text = dsSnapShot.Tables[46].Rows[0]["HKStaff"].ToString();
            }


            if (dsSnapShot.Tables[47].Rows.Count > 0)
            {
                lblSRPending.Text = dsSnapShot.Tables[47].Rows[0]["SRPending"].ToString();
            }


            if (dsSnapShot.Tables[48].Rows.Count > 0)
            {
                lblSRDoneToday.Text = dsSnapShot.Tables[48].Rows[0]["SRDoneToday"].ToString();
            }

            if (dsSnapShot.Tables[49].Rows.Count > 0)
            {
                lblSROverdue.Text = dsSnapShot.Tables[49].Rows[0]["SROverdue"].ToString();
            }

            if (dsSnapShot.Tables[50].Rows.Count > 0)
            {
                lblSRPriority.Text = dsSnapShot.Tables[50].Rows[0]["SRPriority"].ToString();
            }

            if (dsSnapShot.Tables[51].Rows.Count > 0)
            {
                lblALastMonth.Text = dsSnapShot.Tables[51].Rows[0]["APriviousmonth"].ToString();
            }

            if (dsSnapShot.Tables[52].Rows.Count > 0)
            {
                lblAThisMonth.Text = dsSnapShot.Tables[52].Rows[0]["ACurrentmonth"].ToString();
            }

            if (dsSnapShot.Tables[53].Rows.Count > 0)
            {
                lblANextMonth.Text = dsSnapShot.Tables[53].Rows[0]["ANextmonth"].ToString();
            }

            if (dsSnapShot.Tables[54].Rows.Count > 0)
            {
                lblANext7days.Text = dsSnapShot.Tables[54].Rows[0]["A7days"].ToString();
            }

            if (dsSnapShot.Tables[55].Rows.Count > 0)
            {
                lblAToday.Text = dsSnapShot.Tables[55].Rows[0]["AToday"].ToString();
            }

            if (dsSnapShot.Tables[56].Rows.Count > 0)
            {
               // lblkiprovisions.Text = dsSnapShot.Tables[56].Rows[0]["KIProvisions"].ToString();
            }

            if (dsSnapShot.Tables[57].Rows.Count > 0)
            {
                //lblkiperishables.Text = dsSnapShot.Tables[57].Rows[0]["KIPerishables"].ToString();
            }

            if (dsSnapShot.Tables[58].Rows.Count > 0)
            {
               // lblkiconsumables.Text = dsSnapShot.Tables[58].Rows[0]["KIConsumables"].ToString();
            }

            if (dsSnapShot.Tables[59].Rows.Count > 0)
            {
                lblROProvisions.Text = dsSnapShot.Tables[59].Rows[0]["ROProvisions"].ToString();
            }

            if (dsSnapShot.Tables[60].Rows.Count > 0)
            {
                lblROPerishables.Text = dsSnapShot.Tables[60].Rows[0]["ROPerishables"].ToString();
            }

            if (dsSnapShot.Tables[61].Rows.Count > 0)
            {
                lblROConsumables.Text = dsSnapShot.Tables[61].Rows[0]["ROConsumables"].ToString();
            }

            if (dsSnapShot.Tables[62].Rows.Count > 0)
            {
                lblPSVProvisions.Text = dsSnapShot.Tables[62].Rows[0]["PSVProvisions"].ToString();
            }

            if (dsSnapShot.Tables[63].Rows.Count > 0)
            {
                lblPSVPerishables.Text = dsSnapShot.Tables[63].Rows[0]["PSVPerishables"].ToString();
            }


            if (dsSnapShot.Tables[64].Rows.Count > 0)
            {
                lblPSVConsumables.Text = dsSnapShot.Tables[64].Rows[0]["PSVConsumables"].ToString();
            }

            if (dsSnapShot.Tables[65].Rows.Count > 0)
            {
                lbllbm.Text = dsSnapShot.Tables[65].Rows[0]["LBM"].ToString();
            }

            if (dsSnapShot.Tables[66].Rows.Count > 0)
            {
                lblcbm.Text = dsSnapShot.Tables[66].Rows[0]["CBM"].ToString();
            }

            if (dsSnapShot.Tables[67].Rows.Count > 0)
            {
                lblnbm.Text = dsSnapShot.Tables[67].Rows[0]["NBM"].ToString();
            }

            if (dsSnapShot.Tables[68].Rows.Count > 0)
            {
                lblbmdefinedupto.Text = dsSnapShot.Tables[68].Rows[0]["BMDifinedupto"].ToString();
            }

            if (dsSnapShot.Tables[69].Rows.Count > 0)
            {
                lblassetcount.Text = dsSnapShot.Tables[69].Rows[0]["AssetCount"].ToString();
            }

            if (dsSnapShot.Tables[70].Rows.Count > 0)
            {
                lblw30days.Text = dsSnapShot.Tables[70].Rows[0]["Warrentyend"].ToString();
            }

            if (dsSnapShot.Tables[71].Rows.Count > 0)
            {
                lblamc30days.Text = dsSnapShot.Tables[71].Rows[0]["Amcend"].ToString();
            }

            if (dsSnapShot.Tables[71].Rows.Count > 0)
            {
                lblamc30days.Text = dsSnapShot.Tables[71].Rows[0]["Amcend"].ToString();
            }

            if (dsSnapShot.Tables[72].Rows.Count > 0)
            {
                lblDsession.Text = dsSnapShot.Tables[72].Rows[0]["SName"].ToString();
                lblDRegulardiners.Text = dsSnapShot.Tables[72].Rows[0]["Regular"].ToString();
                lblDCasualdiners.Text = dsSnapShot.Tables[72].Rows[0]["Casual"].ToString();
                lblDGuests.Text = dsSnapShot.Tables[72].Rows[0]["Guest"].ToString();
            }

            

            dsSnapShot.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }
    protected void lnkDwellingUnits_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("VillaMaster.aspx",false);
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkNoofResidnts_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ResidentAdd.aspx",false);
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkNoofLivingAlone_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("SAlone.aspx?Value1=2", false);
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkNoofMenuItems_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("FoodMenu.aspx?MenuName=Menu Items", false);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkDiningsessions_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("SessionMaster.aspx", false);
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkFoodItems_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("RawMaterial.aspx", false);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkTypeofservices_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ServiceConfig.aspx", false);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkNoofAssets_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Assets.aspx", false);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkResidents75plus_Click(object sender, EventArgs e)
    
    {
        try
        {
            DataSet dsResidents75plus = sqlobj.ExecuteSP("SP_GetResident75plus");
           
            if (dsResidents75plus.Tables[0].Rows.Count>0)
            {
                rgResidents75plus.DataSource = dsResidents75plus;
                rgResidents75plus.DataBind();

                rwResidents75plus.Visible = true;
            }
            else
            {
                rgResidents75plus.DataSource = string.Empty;
                rgResidents75plus.DataBind();
                rwResidents75plus.Visible = true;
            }

            dsResidents75plus.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkSpecialattention_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet dsSA = sqlobj.ExecuteSP("SP_GetSpecialattentioin");

            if (dsSA.Tables[0].Rows.Count > 0)
            {
                rgSpecialattention.DataSource = dsSA;
                rgSpecialattention.DataBind();

                rwSpecialattention.Visible = true;
            }
            else
            {
                rgSpecialattention.DataSource = string.Empty;
                rgSpecialattention.DataBind();
                rwSpecialattention.Visible = true;
            }

            dsSA.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkTypeofserviceswithRate_Click(object sender, EventArgs e)
    {
        try
        {

            DataSet dsSR = sqlobj.ExecuteSP("SP_GetServiceRate");

            if (dsSR.Tables[0].Rows.Count > 0)
            {
                rgServiceRate.DataSource = dsSR;
                rgServiceRate.DataBind();

                rwServiceRate.Visible = true;
            }
            else
            {
                rgServiceRate.DataSource = string.Empty;
                rgServiceRate.DataBind();

                rwServiceRate.Visible = true;
            }

            dsSR.Dispose();

            

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnCancel_Click(object sender,EventArgs e)
    {
        Response.Redirect("Dashboard.aspx");
    }
    protected void lnkchousekeeping_Click(object sender, EventArgs e)
    {
        Response.Redirect("WorkSchedule.aspx");
    }
    protected void lnkcservicerequestss_Click(object sender, EventArgs e)
    {
        Response.Redirect("TaskList.aspx?Value1=2&Value2=-");
    }
    protected void lnkcactivities_Click(object sender, EventArgs e)
    {
        Response.Redirect("Events.aspx?Type=ViewEventsList");
    }
    protected void lnkckitchen_Click(object sender, EventArgs e)
    {
        Response.Redirect("RawMaterial.aspx");
    }
    protected void lnkcassets_Click(object sender, EventArgs e)
    {
        Response.Redirect("Assets.aspx");
    }
}