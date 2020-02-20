using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.ComponentModel.Design;
using System.Collections.Generic;
using System.Net;
using System.IO;

public partial class HomeMenu : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        rwPopUp.VisibleOnPageLoad = true;
        rwPopUp.Visible = false;

        rwDinersUpdate.VisibleOnPageLoad = true;
        rwDinersUpdate.Visible = false;

        //rwDinersBooking.VisibleOnPageLoad = true;
       // rwDinersBooking.Visible = true;


        if (!IsPostBack)
        {

            string currPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            Session["HomePage"] = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath + currPage;


            FetchOutCount();
            LoadBirthdayGrid();
            FetchAdmin();
            //LoadByDoorNo();
            //LoadByOwner();

            rgDiners.DataSource = string.Empty;
            rgDiners.DataBind();

           
           
            dtpDiners.SelectedDate = DateTime.Now;

            chkByDoorNo.Enabled = false;
            chkByName.Enabled = false;

            ddlByDoorNo.Enabled = false;
            ddlByName.Enabled = false; 

            LoadSession();

            CheckBillingType();

            dtpDiners.Enabled = false;

        }


        LoadRecentCrDr();
    }

    private void CheckBillingType()
    {
        try
        {

            string strtype = "";

            SqlProcsNew proc = new SqlProcsNew();

            DataSet dsDT = proc.ExecuteSP("SP_BillingType");

            if (dsDT.Tables[0].Rows.Count > 0)
            {
                strtype = dsDT.Tables[0].Rows[0]["BillingType"].ToString();

                Session["MenuBillingType"] = strtype.ToString();
            }

            dsDT.Dispose();



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void FetchAdmin()
    {
        SqlProcsNew proc = new SqlProcsNew();

        DataSet dsAdmin = proc.ExecuteSP("[SP_FetchAdmin]", new SqlParameter()
        {
            ParameterName = "@IMODE",
            Direction = ParameterDirection.Input,
            SqlDbType = SqlDbType.Int,
            Value = 1
        });

        if (dsAdmin.Tables[0].Rows.Count > 0)
        {
            lblDayMsg.Text = dsAdmin.Tables[0].Rows[0]["scrollmsg"].ToString();
        }

        dsAdmin.Dispose();
    }

    protected void FetchOutCount()
    {
        try
        {
            SqlProcsNew proc = new SqlProcsNew();

            DataSet dsOutCount = new DataSet();
            DataSet dsResidCnt = new DataSet();
            DataSet dsStayAlone = new DataSet();
            DataSet dsOwnersAway = new DataSet();
            DataSet dsStaffList = new DataSet();
            DataSet dsOutCountMF = new DataSet();
            DataSet dsTasks = new DataSet();
            DataSet dsBillUnBill = new DataSet();

            dsOutCount = proc.ExecuteSP("SP_FetchOutCountData", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = 1
            });

            if (dsOutCount.Tables[0].Rows.Count > 0)
            {
                lblCheckedOutCnt.Text = "Checked Out (" + dsOutCount.Tables[0].Rows[0]["InOutCount"].ToString() + ")";
            }
            else
            {
                lblCheckedOutCnt.Text = "Checked Out ( - )";
            }

            dsResidCnt = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 13
            });

            if (dsResidCnt.Tables[0].Rows.Count > 0)
            {
                lblResidentCnt.Text = "Residents  (" + dsResidCnt.Tables[0].Rows[0]["ResCnt"].ToString() + ")";
            }
            else
            {
                lblResidentCnt.Text = "Residents  ( - )";
            }
            if (dsResidCnt.Tables[1].Rows.Count > 0)
            {
                lblVacantCnt.Text = "Vacant  (" + dsResidCnt.Tables[1].Rows[0]["Vacant"].ToString() + ")";
            }
            else
            {
                lblVacantCnt.Text = "Vacant  ( - )";
            }

            dsStayAlone = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 14
            });

            if (dsStayAlone.Tables[0].Rows.Count > 0)
            {
                lblLivingAloneCnt.Text = "Living alone (" + dsStayAlone.Tables[0].Rows[0]["StayAlone"].ToString() + ")";
            }
            else
            {
                lblLivingAloneCnt.Text = "Living alone ( - )";
            }

            dsOutCountMF = proc.ExecuteSP("SP_FetchOutCountData", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = 1
            });
            if (dsOutCountMF.Tables[1].Rows.Count > 0)
            {
                //lblAlerts.Text = "Checked Out (" + dsOutCountMF.Tables[0].Rows[0]["InOutCount"].ToString() +") / Alerts (" + dsOutCountMF.Tables[1].Rows[0]["COTime"].ToString() + ")";
                if (dsOutCountMF.Tables[1].Rows[0]["COTime"].ToString() == "0")
                {
                    lblAlerts.Text = " No Alerts";
                    lblAlerts.ForeColor = System.Drawing.Color.Black;
                }
                else
                {
                    lblAlerts.Text = "Alerts (" + dsOutCountMF.Tables[1].Rows[0]["COTime"].ToString() + ")";
                    lblAlerts.ForeColor = System.Drawing.Color.Red;
                }

            }
            else
            {

                lblAlerts.Text = "Alerts (-)";
            }

            dsTasks = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 18
            });

            if (dsTasks.Tables[0].Rows.Count > 0)
            {
                lblTasks.Text = "Open Requests (" + dsTasks.Tables[0].Rows[0]["TaskCnt"].ToString() + ")";
            }
            else
            {
                lblTasks.Text = "Open Requests (-)";
            }

            if (dsTasks.Tables[1].Rows.Count > 0)
            {
                lblOverduetasks.Text = "Overdue (" + dsTasks.Tables[1].Rows[0]["OverDueTaskCnt"].ToString() + ")";
            }
            else
            {
                lblOverduetasks.Text = "Overdue (-)";
            }

            dsBillUnBill = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 19
            });

            if (dsBillUnBill.Tables[0].Rows.Count > 0)
            {
                lblBilled.Text = "Billed Rs." + dsBillUnBill.Tables[0].Rows[0]["BTotal"].ToString() + " for " + dsBillUnBill.Tables[0].Rows[0]["BName"].ToString();
            }
            else
            {
                lblBilled.Text = "Billed (-) ";
            }

            if (dsBillUnBill.Tables[1].Rows.Count > 0)
            {
                lblUnBilled.Text = "Unbilled Rs." + dsBillUnBill.Tables[1].Rows[0]["UBTotal"].ToString() + " for " + dsBillUnBill.Tables[1].Rows[0]["UBName"].ToString(); ;
            }
            else
            {
                lblUnBilled.Text = "Unbilled (-) ";
            }


            DataSet dsOutstanding = proc.ExecuteSP("SP_TotalOutstanding");

            if (dsOutstanding.Tables[0].Rows.Count > 0)
            {
                lblOutstanding.Text = "Outstanding Rs." + dsOutstanding.Tables[0].Rows[0]["Outstanding"].ToString();
            }

            dsOutstanding.Dispose();


        }

        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void LoadRecentCrDr()
    {

        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsRecentCD = new DataSet();
        dsRecentCD = proc.ExecuteSP("SP_GetRecentCrDr");

        if (dsRecentCD.Tables[0].Rows.Count > 0)
        {
            lblRecentCr.Text = dsRecentCD.Tables[0].Rows[0]["CR"].ToString();
            lblRecentDr.Text = dsRecentCD.Tables[1].Rows[0]["DR"].ToString();
        }
    }
    protected void LoadBirthdayGrid()
    {
        SqlCommand Cmd = new SqlCommand("SP_General", con);
        Cmd.CommandType = CommandType.StoredProcedure;
        Cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 4;
        DataSet dsGrid = new DataSet();
        //BirthdaygrdView.DataBind();    
        SqlDataAdapter da = new SqlDataAdapter(Cmd);
        
        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            //lbldispbirthdays.Text = "Upcoming birthdays  :" + dsGrid.Tables[0].Rows.Count;
            //lblBirthdays.Text = "Birthdays (" + dsGrid.Tables[0].Rows.Count + ")";
        }

        else
        {
            // lblBirthdays.Text = "Birthdays (-)";
            //lbldispbirthdays.Text = "No upcoming birthdays ";

        }

    }

    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dschkRName = new DataSet();

        if (txtNSearch.Text.Length >= 4)
        {
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Function", "NavigateDir2();", true);       
            string HRName = txtNSearch.Text.ToString();
            dschkRName = proc.ExecuteSP("SP_CheckRName", new SqlParameter()
            {
                ParameterName = "@RName",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = txtNSearch.Text.ToString()
            });

            if (dschkRName.Tables[0].Rows.Count > 0)
            {
                Response.Redirect("ResidentAdd.aspx?HRName=" + HRName, true);
            }
            else
            {
                WebMsgBox.Show("Sorry! No matches found. Kindly check the spelling.");
            }
            txtNSearch.Text = string.Empty;
        }
        else
        {
            WebMsgBox.Show("Please enter minimum four characters");
            txtNSearch.Text = string.Empty;
        }
    }

    protected void lblAlerts_Click(object sender, EventArgs e)
    {
        Response.Redirect("ExitEntry.aspx");

    }

    protected void lblTasks_Click(object sender, EventArgs e)
    {
        Response.Redirect("TaskList.aspx");

    }





    protected void btnScoreboard_Click(object sender, EventArgs e)
    {


        string url = "Information_Board.aspx?Value=1";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(url);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());
    }
    protected void btnEvents_Click(object sender, EventArgs e)
    {
        LoadGrid();
        rwPopUp.Visible = true;
    }
    public void LoadGrid()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_Events", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 6);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds, "temp");
            dlistEvents.DataSource = ds;
            dlistEvents.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        rwPopUp.Visible = false;
    }
    protected void btnDinersUpdate_Click(object sender, EventArgs e)
    {
        try
        {   
                if (Session["MenuBillingType"].ToString() == "S")
                {

                    rwDinersUpdate.Visible = true;
                }
                else
                {
                    WebMsgBox.Show("Sorry!  Billing is A la carte (Menu ) based for this residential community. Hence Session based Booking is not permitted.");
                }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void dtpDiners_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            LoadSession();

            rwDinersUpdate.Visible = true;
        }
        catch(Exception ex)
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
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnDinersSave_Click(object sender, EventArgs e)
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsdiners = new DataSet();


            string strDoorNo = "";

            if (chkByDoorNo.Checked == true )
            {
                strDoorNo = ddlByDoorNo.SelectedValue; 
            }
            else if (chkByName.Checked ==true )
            {
                strDoorNo = ddlByName.SelectedValue;  
            }

            sqlobj.ExecuteSP("SP_UpdateExistDiners",
                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                   new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                   new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = strDoorNo.ToString()},
                   new SqlParameter() { ParameterName = "@Actual", SqlDbType = SqlDbType.NVarChar, Value = ddlDiner.SelectedValue  },
                   new SqlParameter() { ParameterName = "@GuestActual", SqlDbType = SqlDbType.NVarChar, Value = ddlGuest.SelectedValue  },
                   new SqlParameter() { ParameterName = "@TotalActual", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt32(ddlDiner.SelectedValue) + Convert.ToInt32(ddlGuest.SelectedValue)}
                   );


             LoadDiners(dtpDiners.SelectedDate.Value, ddlDinersSession.SelectedValue);

             LoadActualDiners();

             ClearDiners();

             rwDinersUpdate.Visible = true;


             //SentSMS("9790089998", "This is the first ORIS Msg");



            WebMsgBox.Show("Diners updated successfully"); 


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message); 
        }
    }

  

    private void ClearDiners()
    {
        

        ddlDinersSession.SelectedIndex = 0;

        ddlByDoorNo.SelectedIndex = 0;

        ddlByName.SelectedIndex = 0;

        chkByDoorNo.Checked = false;
        chkByName.Checked = false;

        ddlDiner.SelectedIndex = 0;
        ddlGuest.SelectedIndex = 0;

        chkByDoorNo.Enabled = false;
        chkByName.Enabled = false;

        ddlByDoorNo.Enabled = false;
        ddlByName.Enabled = false; 
 

    }
    protected void btnDinersClose_Click(object sender, EventArgs e)
    {
        try
        {
            ClearDiners();
            rwDinersUpdate.Visible = false;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message); 
        }
    }

    private void LoadDiners(DateTime ddate,string ssession) 
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_GetDinersdetailsessionwise",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = ddate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ssession.ToString() }
                
                );

            if (dsFetchSE.Tables[0].Rows.Count >0 )
            {
                rgDiners.DataSource = dsFetchSE.Tables[0];
                rgDiners.DataBind();
            }

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadActualDiners()
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

            lblactualbooked.Text = dsFetchSE.Tables[1].Rows[0]["Actual"].ToString();
            lblactualguest.Text = dsFetchSE.Tables[1].Rows[0]["GuestActual"].ToString();
        }
        catch(Exception ex)
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
                 new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                  new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue  }
                 );
            
             
            
            ddlByDoorNo.DataSource = dsFetchSE.Tables[0];
            ddlByDoorNo.DataValueField = "rtrsn";
            ddlByDoorNo.DataTextField = "Name";
            ddlByDoorNo.DataBind();

            ddlByDoorNo.Items.Insert(0, new ListItem("--Select--", "0"));

            chkByDoorNo.Enabled = true; 
            
            
            
            lblbooked.Text = dsFetchSE.Tables[1].Rows[0]["Booked"].ToString();
            lblguestbooked.Text = dsFetchSE.Tables[1].Rows[0]["GuestBooked"].ToString();
            lblactualbooked.Text = dsFetchSE.Tables[1].Rows[0]["Actual"].ToString();
            lblactualguest.Text = dsFetchSE.Tables[1].Rows[0]["GuestActual"].ToString();



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
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                 new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }
                );

            ddlByName.DataSource = dsFetchSE.Tables[0];
            ddlByName.DataValueField = "rtrsn";
            ddlByName.DataTextField = "Name";
            ddlByName.DataBind();

            ddlByName.Items.Insert(0, new ListItem("--Select--", "0"));

            chkByName.Enabled = true; 
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void chkByDoorNo_CheckedChanged(object sender, EventArgs e)
    {

        try
        {
           
            if (chkByDoorNo.Checked == true )
            {
                ddlByDoorNo.Enabled = true; 
            }
            else
            {
                ddlByDoorNo.Enabled = false; 
            }

            rwDinersUpdate.Visible = true; 

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void chkByName_CheckedChanged(object sender, EventArgs e)
    {
        try
        {

            if (chkByName.Checked == true )
            {
                ddlByName.Enabled = true; 
            }
            else
            {
                ddlByName.Enabled = false; 
            }

            rwDinersUpdate.Visible = true;
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
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue},
                new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = ddlByDoorNo.SelectedValue});

            if (dsFetchSE.Tables[0].Rows.Count >0)
            {
                ddlDiner.SelectedValue = dsFetchSE.Tables[0].Rows[0]["Booked"].ToString();
                ddlGuest.SelectedValue = dsFetchSE.Tables[0].Rows[0]["GuestBooked"].ToString();
            }

            rwDinersUpdate.Visible = true; 

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlByName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_GetDinerforDoors",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = ddlByName.SelectedValue });

            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {
                ddlDiner.SelectedValue = dsFetchSE.Tables[0].Rows[0]["Booked"].ToString();
                ddlGuest.SelectedValue = dsFetchSE.Tables[0].Rows[0]["GuestBooked"].ToString();
            }


            rwDinersUpdate.Visible = true;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message); 
        }
    }
    protected void ddlDinersSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {   
            LoadByDoorNo();
            LoadByOwner();

            rwDinersUpdate.Visible = true;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

   protected void  aResidentAdd_Click(object sender, EventArgs e)
    {
        try
        {
            Permission p = new Permission();

            string result = p.GetPermission(Session["UserID"].ToString(), "Profile");
            
                if (result == "Y" || result == "V")
                {
                    Response.Redirect("ResidentAdd.aspx");
                }
                else
                {
                    WebMsgBox.Show("You have not permission to view resident module");
                }

        }
       catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
   protected void btnDinersBooking_Click(object sender, EventArgs e)
   {
       try
       {

           SqlProcsNew sqlobj = new SqlProcsNew();

           
           
           DataSet dsConfirmDiningR = sqlobj.ExecuteSP("SP_GetSessionForResident",
                new SqlParameter() { ParameterName = "@Time", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now.ToString("HH:mm") }
               
                );

           if (dsConfirmDiningR.Tables[0].Rows.Count>0)
           {

               Session["SessionCode"] = dsConfirmDiningR.Tables[0].Rows[0]["SessionCode"].ToString();
               Session["SessionName"] = dsConfirmDiningR.Tables[0].Rows[0]["SessionName"].ToString();

               Page.ClientScript.RegisterStartupScript(
  this.GetType(), "OpenWindow", "window.open('ConfirmDiningR.aspx','_newtab');", true);
           }

          
       }
       catch(Exception ex)
       {
           WebMsgBox.Show(ex.Message);
       }
   }
   protected void chkRByDoorNo_CheckedChanged(object sender, EventArgs e)
   {

   }
   protected void ddlRByDoorNo_SelectedIndexChanged(object sender, EventArgs e)
   {

   }
   protected void chkRByName_CheckedChanged(object sender, EventArgs e)
   {

   }
   protected void ddlRByName_SelectedIndexChanged(object sender, EventArgs e)
   {

   }
}