using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;


public partial class ConfirmDiningR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadBillingPeriod();
            

            lblcsession.Text = "Happy Seniors welcomes you for " + Session["SessionName"].ToString() ;

            LoadTodayMenu();
            LoadTodayEvents();
            LoadTodayBirthday();
            LoadByDoorNo();
            LoadByOwner();
            //chkRByDoorNo.Enabled = false;
            //chkRByName.Enabled = false;

            ddlRByDoorNo.Enabled = false;
            ddlRByName.Enabled = false;

           // rgTodaysMenu.DataSource = string.Empty;
           // rgTodaysMenu.DataBind();
        }
    }

    private void LoadTodayBirthday()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsTodaysEvents = sqlobj.ExecuteSP("SP_GetBirthday"
              

                );


            if (dsTodaysEvents.Tables[0].Rows.Count > 0)
            {

                string names = "";

                for (int i = 0; i < dsTodaysEvents.Tables[0].Rows.Count; i++ )
                {

                    if (names == "")
                    {
                        names = dsTodaysEvents.Tables[0].Rows[i]["RTNAME"].ToString();
                    }
                    else
                    {
                        names =names + ',' + dsTodaysEvents.Tables[0].Rows[i]["RTNAME"].ToString();
                    }

                }

                lblcbirthday.Text = "Greetings on birthday for " + names.ToString();

            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadTodayEvents()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsTodaysEvents = sqlobj.ExecuteSP("SP_GetTodayEvents",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now.ToString("yyyy-MM-dd") }
               
                );


            if (dsTodaysEvents.Tables[0].Rows.Count > 0)
            {

                string names = "";

                for (int i = 0; i < dsTodaysEvents.Tables[0].Rows.Count; i++)
                {

                    if (names == "")
                    {
                        names = dsTodaysEvents.Tables[0].Rows[i]["Description"].ToString();
                    }
                    else
                    {
                        names = names + ',' + dsTodaysEvents.Tables[0].Rows[i]["Description"].ToString();
                    }

                }


                lblcevents.Text = names;

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadTodayMenu()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsTodaysMenu = sqlobj.ExecuteSP("SP_GetMenuForDay",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now.ToString("yyyy-MM-dd") },
                new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() }
                );

           
            if (dsTodaysMenu.Tables[0].Rows.Count >0)
            {
                gvTodaysMenu.DataSource = dsTodaysMenu;
                gvTodaysMenu.DataBind();
            }



        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadBillingPeriod()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_FetchBillingPeriods",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });

            
            lblcomName.Text = dsGroup.Tables[3].Rows[0]["CommunityName"].ToString();
            lblversionnumber.Text = dsGroup.Tables[3].Rows[0]["versionnumber"].ToString();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    private void LoadSession()
    {
        try
        {

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void chkRByDoorNo_CheckedChanged(object sender, EventArgs e)
    {
        try
        {

            if (chkRByDoorNo.Checked == true)
            {
                ddlRByDoorNo.Enabled = true;
            }
            else
            {
                ddlRByDoorNo.Enabled = false;
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    private void LoadByDoorNo()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_DailyDinersUpdateDropDown",
                 new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now.ToString("yyyy-MM-dd") },
                  new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() }
                 );



            ddlRByDoorNo.DataSource = dsFetchSE.Tables[0];
            ddlRByDoorNo.DataValueField = "rtrsn";
            ddlRByDoorNo.DataTextField = "Name";
            ddlRByDoorNo.DataBind();

            ddlRByDoorNo.Items.Insert(0, new ListItem("--Select--", "0"));

            chkRByDoorNo.Enabled = true;


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadByOwner()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_DailyDinersUpdateDropDown",
                new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now.ToString("yyyy-MM-dd") },
                 new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() }
                );

            ddlRByName.DataSource = dsFetchSE.Tables[0];
            ddlRByName.DataValueField = "rtrsn";
            ddlRByName.DataTextField = "Name";
            ddlRByName.DataBind();

            ddlRByName.Items.Insert(0, new ListItem("--Select--", "0"));

            chkRByName.Enabled = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlRByDoorNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_GetDinerforDoors",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = ddlRByDoorNo.SelectedValue }

                );

            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {
                ddlDiner.SelectedValue = dsFetchSE.Tables[0].Rows[0]["Booked"].ToString();
                ddlGuest.SelectedValue = dsFetchSE.Tables[0].Rows[0]["GuestBooked"].ToString();
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void chkRByName_CheckedChanged(object sender, EventArgs e)
    {
        try
        {

            if (chkRByName.Checked == true)
            {
                ddlRByName.Enabled = true;
            }
            else
            {
                ddlRByName.Enabled = false;
            }

            
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlRByName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_GetDinerforDoors",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = "" },
                new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = ddlRByName.SelectedValue }

                );

            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {
                ddlDiner.SelectedValue = dsFetchSE.Tables[0].Rows[0]["Booked"].ToString();
                ddlGuest.SelectedValue = dsFetchSE.Tables[0].Rows[0]["GuestBooked"].ToString();
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();


            string strDoorNo = "";
            int idoorno = 0;

            if (chkRByDoorNo.Checked == true)
            {
                strDoorNo = ddlRByDoorNo.SelectedItem.Text  ;

                string[] adoorno = strDoorNo.Split(',');
                strDoorNo = adoorno[0].ToString();

                idoorno = Convert.ToInt32( ddlRByDoorNo.SelectedValue);
            }
            else if (chkRByName.Checked == true)
            {
                strDoorNo = ddlRByName.SelectedItem.Text;
                string[] adoorno = strDoorNo.Split(',');
                strDoorNo = adoorno[0].ToString();

                idoorno = Convert.ToInt32(ddlRByName.SelectedValue);
            }


            DataSet dsCheckBinNo = sqlobj.ExecuteSP("SP_CheckPinNo",
                new SqlParameter() { ParameterName = "@PinNo", SqlDbType = SqlDbType.Int, Value = txtPinNumber.Text },
                new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = strDoorNo.ToString() });


            if (dsCheckBinNo.Tables[0].Rows.Count > 0)
            {

                dsFetchSE = sqlobj.ExecuteSP("SP_GetDinerforDoors",
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now.ToString("yyyy-MM-dd") },
                    new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                    new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = idoorno.ToString() });

                if (dsFetchSE.Tables[0].Rows.Count > 0)
                {

                    lblRName.Text = dsFetchSE.Tables[0].Rows[0]["Name"].ToString();
                    ddlDiner.SelectedValue = dsFetchSE.Tables[0].Rows[0]["Booked"].ToString();
                    ddlGuest.SelectedValue = dsFetchSE.Tables[0].Rows[0]["GuestBooked"].ToString();
                }

            }
            else
            {
                WebMsgBox.Show("Please check your DoorNo (or) Pin No.");
            }

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {


        if (CnfResult.Value == "true")
        {


            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsdiners = new DataSet();


            string strDoorNo = "";

            if (chkRByDoorNo.Checked == true)
            {
                strDoorNo = ddlRByDoorNo.SelectedValue;
            }
            else if (chkRByName.Checked == true)
            {
                strDoorNo = ddlRByName.SelectedValue;
            }

            sqlobj.ExecuteSP("SP_UpdateExistDiners",
                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now.ToString("yyyy-MM-dd") },
                   new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                   new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = strDoorNo.ToString() },
                   new SqlParameter() { ParameterName = "@Actual", SqlDbType = SqlDbType.NVarChar, Value = ddlDiner.SelectedValue },
                   new SqlParameter() { ParameterName = "@GuestActual", SqlDbType = SqlDbType.NVarChar, Value = ddlGuest.SelectedValue },
                   new SqlParameter() { ParameterName = "@TotalActual", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt32(ddlDiner.SelectedValue) + Convert.ToInt32(ddlGuest.SelectedValue) }
                   );

            ddlDiner.SelectedIndex=0;
            ddlGuest.SelectedIndex=0; 

            WebMsgBox.Show("Your dining details updated on " + DateTime.Now.ToString("dd-MM-yyyy") + " " + Session["SessionName"].ToString());
        }


        //LoadDiners(dtpDiners.SelectedDate.Value, ddlDinersSession.SelectedValue);

        //LoadActualDiners();

       // ClearDiners();

        //rwDinersUpdate.Visible = true;

    }
}