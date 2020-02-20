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


public partial class WorkSchedule : System.Web.UI.Page
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

            rwEditWorkSchedule.VisibleOnPageLoad = true;
            rwEditWorkSchedule.Visible = false;

            rwBulkUpdate.VisibleOnPageLoad = true;
            rwBulkUpdate.Visible = false;

            rwPendingBulk.VisibleOnPageLoad = true;
            rwPendingBulk.Visible = false;


            if (!IsPostBack)
            {
                LoadTitle();

                dtpdate.SelectedDate = DateTime.Now;

               

                dtpFrom.SelectedDate = DateTime.Now;

                DateTime firstOfNextMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).AddMonths(1);
                DateTime lastOfThisMonth = firstOfNextMonth.AddDays(-1);

                dtpTo.SelectedDate = lastOfThisMonth;

                dtpCopy.SelectedDate= DateTime.Now;
                dtpFromDate.SelectedDate = DateTime.Now;
                dtpToDate.SelectedDate = lastOfThisMonth;

                ddlViewTask.Items.Insert(0, "All");
                ddlViewStaff.Items.Insert(0, "All");


                LoadCategory();
                LoadTask();
                LoadPersonName();
                LoadStaffName();
                LoadSiteName();
                LoadWorkType();
                LoadResidentDet();
                LoadWorkSchedule();
                LoadWorkSchedulePending();
                LoadStaffWorkChart();
                LoadServiceRequestPending();
                LoadViewTaskList();
                LoadCopyFrom();
                

                //racHKResident.Visible = false;

                cmbResident.Visible = false;

                dvDailySchedule.Visible = true;
                dvcopy.Visible = false;
                dvPending.Visible = false;
                dvViewTaskList.Visible = false;

                dvStaffWorkLoad.Visible = false;

                lnkhide.Visible = false;

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadWorkType()
    {
        try
        {
            DataSet dsLoadProvisionType = sqlobj.ExecuteSP("SP_WorkType", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 }
                );


            ddlWorkType.Items.Clear();
            ddlPendingWorkType.Items.Clear();
            ddlViewWorkType.Items.Clear();


            if (dsLoadProvisionType.Tables[0].Rows.Count > 0)
            {
                ddlWorkType.DataSource = dsLoadProvisionType;
                ddlWorkType.DataValueField = "WorkType";
                ddlWorkType.DataTextField = "WorkType";
                ddlWorkType.DataBind();


                ddlPendingWorkType.DataSource = dsLoadProvisionType;
                ddlPendingWorkType.DataValueField = "WorkType";
                ddlPendingWorkType.DataTextField = "WorkType";
                ddlPendingWorkType.DataBind();


                ddlViewWorkType.DataSource = dsLoadProvisionType;
                ddlViewWorkType.DataValueField = "WorkType";
                ddlViewWorkType.DataTextField = "WorkType";
                ddlViewWorkType.DataBind();


            }

            ddlWorkType.Items.Insert(0, "All");
            ddlPendingWorkType.Items.Insert(0, "All");
            ddlViewWorkType.Items.Insert(0, "All");

            dsLoadProvisionType.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    // -- Start Category

    private void LoadCategory()
    {
        try
        {

            //DataSet dsCategory = sqlobj.ExecuteSP("Proc_LoadServiceConfig",
            //  new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 });

            DataSet dsCategory = sqlobj.ExecuteSP("SP_HouseKeeping",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
              new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate }
              );

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                ddlCategory.DataSource = dsCategory.Tables[0];
                ddlCategory.DataTextField = "Category";
                ddlCategory.DataValueField = "value";
                ddlCategory.DataBind();

                ddlViewCategory.DataSource = dsCategory.Tables[0];
                ddlViewCategory.DataTextField = "Category";
                ddlViewCategory.DataValueField = "value";
                ddlViewCategory.DataBind();
            }
           
            ddlCategory.Items.Insert(0, "All");
            ddlViewCategory.Items.Insert(0, "All");



            dsCategory.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadTask();
            LoadPersonName();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    //-- End Category

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 40 });


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

    private void LoadSiteName()
    {
        DataSet dsLoadSite = sqlobj.ExecuteSP("SP_LoadSitelkup");

        ddlSite.Items.Clear();

        if (dsLoadSite.Tables[0].Rows.Count > 0)
        {
            ddlSite.DataSource = dsLoadSite;
            ddlSite.DataTextField = "SiteName";
            ddlSite.DataValueField = "SiteName";
            ddlSite.DataBind();

            ddlViewSite.DataSource = dsLoadSite;
            ddlViewSite.DataTextField = "SiteName";
            ddlViewSite.DataValueField = "SiteName";
            ddlViewSite.DataBind();

        }

        ddlViewSite.Items.Insert(0, "All");

        dsLoadSite.Dispose();
    }


    private void LoadCopyFrom()
    {
        try
        {


            DataSet dsBillingPeriod = sqlobj.ExecuteSP("SP_GetCurrentBillingPeriod");


            DateTime sd = DateTime.Now;
                ;


            DateTime cd=DateTime.Now; 

            if (dsBillingPeriod.Tables[0].Rows.Count >0)
            {
                sd = Convert.ToDateTime(dsBillingPeriod.Tables[0].Rows[0]["BPFrom"].ToString());

                cd = Convert.ToDateTime(dsBillingPeriod.Tables[0].Rows[0]["BPTill"].ToString());

                dtpFrom.MinDate = sd;

                //dtpTo.MinDate = cd;
            }

            dsBillingPeriod.Dispose();



            DataSet dsCopyFrom = sqlobj.ExecuteSP("SP_GetWorkScheduleDates",
                      new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = sd },
                      new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.DateTime, Value = cd }
                      );

            if (dsCopyFrom.Tables[0].Rows.Count >0 )
            {
                ddlCopyFrom.DataSource = dsCopyFrom;
                ddlCopyFrom.DataTextField = "Date";
                ddlCopyFrom.DataValueField = "Date";
                ddlCopyFrom.DataBind();
            }

            ddlCopyFrom.Items.Insert(0, "--Select--");


            dsCopyFrom.Dispose();
          
        }
        catch(Exception ex)
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

    private void LoadWorkSchedule()
    {
        try
        {
           DataSet dsWorkSchedule = sqlobj.ExecuteSP("SP_LoadWorkSchedule",
                       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate },
                       new SqlParameter() { ParameterName = "@Staff", SqlDbType = SqlDbType.NVarChar, Value = ddlStaff.SelectedValue == "All" ? null:ddlStaff.SelectedValue },
                       new SqlParameter() { ParameterName = "@WorkType", SqlDbType = SqlDbType.NVarChar, Value = ddlWorkType.SelectedValue == "All" ? null:ddlWorkType.SelectedValue }
                       );

            
            if (dsWorkSchedule.Tables[0].Rows.Count>0)
            {
                gvWorkSchedule.DataSource = dsWorkSchedule;
                gvWorkSchedule.DataBind();
            }
            else
            {
                gvWorkSchedule.DataSource = string.Empty;
                gvWorkSchedule.DataBind();
            }

            dsWorkSchedule.Dispose();


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadWorkSchedulePending()
    {
        try
        {

            DateTime currentdate = DateTime.Now;

            DataSet dsWorkSchedule = sqlobj.ExecuteSP("SP_LoadWorkSchedulePending",
                        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = currentdate.ToString() },
                        new SqlParameter() { ParameterName = "@Staff", SqlDbType = SqlDbType.NVarChar, Value = ddlPendingStaff.SelectedValue == "All" ? null : ddlPendingStaff.SelectedValue },
                       new SqlParameter() { ParameterName = "@WorkType", SqlDbType = SqlDbType.NVarChar, Value = ddlPendingWorkType.SelectedValue == "All" ? null : ddlPendingWorkType.SelectedValue },
                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlPenStatus.SelectedValue == "All" ? null : ddlPenStatus.SelectedValue }
                        
                        );


            if (dsWorkSchedule.Tables[0].Rows.Count > 0)
            {
                gvWorkSchedulePending.DataSource = dsWorkSchedule;
                gvWorkSchedulePending.DataBind();
            }
            else
            {
                gvWorkSchedulePending.DataSource = string.Empty;
                gvWorkSchedulePending.DataBind();
            }

            dsWorkSchedule.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadServiceRequestPending()
    {
        try
        {
            DataSet dsServiceRequestPending = sqlobj.ExecuteSP("SP_ServiceRequestPending");


            if (dsServiceRequestPending.Tables[0].Rows.Count > 0)
            {
                rgServiceRequestPending.DataSource = dsServiceRequestPending;
                rgServiceRequestPending.DataBind();
            }
            else
            {
                rgServiceRequestPending.DataSource = string.Empty;
                rgServiceRequestPending.DataBind();
            }

            dsServiceRequestPending.Dispose();


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadStaffWorkChart()
    {
        try
        {
            DataSet dsStaffWorkLoadChart = sqlobj.ExecuteSP("SP_StaffWorkloadChart",
                        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate });


            if (dsStaffWorkLoadChart.Tables[0].Rows.Count > 0)
            {
                rgStaffWorkLoadChart.DataSource = dsStaffWorkLoadChart;
                rgStaffWorkLoadChart.DataBind();
            }
            else
            {
                rgStaffWorkLoadChart.DataSource = string.Empty;
                rgStaffWorkLoadChart.DataBind();
            }

            dsStaffWorkLoadChart.Dispose();

            DateTime copydate = Convert.ToDateTime(dtpdate.SelectedDate.Value);

            //lblstaffworkloadchart.Text = "Staff workload chart for " + copydate.ToString("dd-MM-yyyy");

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTask()
    {
        try
        {
            //SP_LoadWorkTasks

            string categoryvalue = ddlCategory.SelectedValue.ToString();

            string[] strcatval = categoryvalue.Split(',');

            //DataSet dsTask = sqlobj.ExecuteSP("SP_LoadWorkTasks",
            //    new SqlParameter() { ParameterName = "@CategoryCode", SqlDbType = SqlDbType.NVarChar, Value = strcatval[0].ToString() });

            DataSet dsTask = sqlobj.ExecuteSP("SP_HouseKeeping",
                new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strcatval[0].ToString() },
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate });

            ddlTask.Items.Clear();


            if (dsTask.Tables[0].Rows.Count > 0)
            {
                ddlTask.DataSource = dsTask;
                ddlTask.DataValueField = "Value";
                ddlTask.DataTextField = "Title";
                ddlTask.DataBind();
            }


            dsTask.Dispose();

            ddlTask.Items.Insert(0, "--Select--");

            if (dsTask.Tables[1].Rows.Count >0)
            {
                lbldepartment.Text = "Department:" + dsTask.Tables[1].Rows[0]["Department"].ToString();
            }
            else
            {
                lbldepartment.Text = "";
            }


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadPersonName()
    {
        try
        {
            //SP_LoadWorkForce

            //string taskvalue = ddlTask.SelectedValue.ToString();

            string taskvalue = ddlCategory.SelectedValue.ToString();

            string[] strtask = taskvalue.Split(',');

            //DataSet dsPersonName = sqlobj.ExecuteSP("SP_GetTaskNames",
            //    new SqlParameter() { ParameterName = "@TaskCategory", SqlDbType = SqlDbType.NVarChar, Value = strtask[0].ToString() });

          

            DataSet dsPersonName = sqlobj.ExecuteSP("SP_HouseKeeping",
                new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strtask[0].ToString() },
                new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 },
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate });

            if (dsPersonName.Tables[0].Rows.Count > 0)
            {
                ddlAssignedTo.DataSource = dsPersonName;
                ddlAssignedTo.DataValueField = "RSN";
                ddlAssignedTo.DataTextField = "PersonName";
                ddlAssignedTo.DataBind();

               
            }
            else
            {
                ddlAssignedTo.Items.Clear();
               
            }


            dsPersonName.Dispose();

            ddlAssignedTo.Items.Insert(0, "--Select--");
          

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadStaffName()
    {
        try
        {

            DataSet dsPersonName = sqlobj.ExecuteSP("SP_GetTaskNames",
                new SqlParameter() { ParameterName = "@TaskCategory", SqlDbType = SqlDbType.NVarChar, Value = ddlStaff.SelectedValue == "" ? null : ddlStaff.SelectedValue });

            if (dsPersonName.Tables[0].Rows.Count > 0)
            {
                ddlStaff.DataSource = dsPersonName;
                ddlStaff.DataValueField = "PersonName";
                ddlStaff.DataTextField = "PersonName";
                ddlStaff.DataBind();


                ddlPendingStaff.DataSource = dsPersonName;
                ddlPendingStaff.DataValueField = "PersonName";
                ddlPendingStaff.DataTextField = "PersonName";
                ddlPendingStaff.DataBind();

            }
            else
            {
                ddlStaff.Items.Clear();
            }

            dsPersonName.Dispose();

            ddlStaff.Items.Insert(0, "All");

            ddlPendingStaff.Items.Insert(0, "All");
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    protected void dtpdate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {

            LoadCategory();
            LoadWorkSchedule();
           // LoadStaffWorkChart();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    
    protected void ddlSite_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            string status = "";

            DataSet dsSiteStatus = sqlobj.ExecuteSP("SP_CheckSiteStatus",
              new SqlParameter() { ParameterName = "@SiteName", SqlDbType = SqlDbType.NVarChar, Value = ddlSite.SelectedValue });


            if (dsSiteStatus.Tables[0].Rows.Count > 0)
            {

                status = dsSiteStatus.Tables[0].Rows[0]["IsVilla"].ToString();

                Session["SiteStatus"] = status.ToString();

                if (status == "Yes")
                {
                    txtLocation.Visible = false;
                    //racHKResident.Visible = true;
                    cmbResident.Visible = true;

                }
                else
                {
                    txtLocation.Visible = true;
                   // racHKResident.Visible = false;
                    cmbResident.Visible = false;
                }
            }
            else
            {
                txtLocation.Visible = true;
                //racHKResident.Visible = false;

                cmbResident.Visible = false;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void ClearWorkSchedule()
    {
        ddlSite.SelectedIndex = 0;
        ddlTask.SelectedIndex = 0;
        ddlAssignedTo.SelectedIndex = 0;
        txtLocation.Text ="";
        //racHKResident.Entries.Clear();
        cmbResident.SelectedIndex = 0;
        txtRemarks.Text = "";

        txtLocation.Visible = true;
        //racHKResident.Visible = false;
        cmbResident.Visible = false;
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                string strlocation = "";
                string strrtrsn = "";

                string strstatus = Session["SiteStatus"].ToString();


                if (Session["SiteStatus"].ToString() == "Yes")
                {
                    strlocation = DoorNo();

                    DataSet dsgetrtrsn = sqlobj.ExecuteSP("SP_GetRTRSN",
                       new SqlParameter() { ParameterName = "@RTVillaNo", SqlDbType = SqlDbType.NVarChar, Value = strlocation.ToString() });


                  if (dsgetrtrsn.Tables.Count>0)
                  {

                   if(dsgetrtrsn.Tables[0].Rows.Count >0)
                   {
                       strrtrsn = dsgetrtrsn.Tables[0].Rows[0]["RTRSN"].ToString();
                   }

                  }

                    dsgetrtrsn.Dispose();
                }
                else
                {
                    strlocation = txtLocation.Text;
                    strrtrsn = "";
                }

                string categoryvalue = "";
                string cvalue = "";

                
                string taskvalue = ddlTask.SelectedValue.ToString();

                string[] strtask = taskvalue.Split('-');
                
                if (ddlCategory.SelectedValue == "All")
                {
                    DataSet dsGetCategory = sqlobj.ExecuteSP("SP_HouseKeeping",
                       new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 },
                       new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strtask[1].ToString() }
                      );


                    if (dsGetCategory.Tables[0].Rows.Count >0)
                    {
                        cvalue = dsGetCategory.Tables[0].Rows[0]["rsn"].ToString();
                    }

                    dsGetCategory.Dispose();

                }
                else
                {
                    categoryvalue = ddlCategory.SelectedValue.ToString();
                    string[] strcatval = categoryvalue.Split(',');
                    cvalue = strcatval[1].ToString();
                }

                sqlobj.ExecuteSQLNonQuery("SP_InserttblWorkSchedule",
                       new SqlParameter() { ParameterName = "@CategoryID", SqlDbType = SqlDbType.BigInt, Value =  cvalue.ToString() }, 
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value =  strrtrsn.ToString() == "" ? "0":strrtrsn.ToString() },
                       new SqlParameter() { ParameterName = "@TaskId", SqlDbType = SqlDbType.BigInt, Value =  strtask[0].ToString() },
                       new SqlParameter() { ParameterName = "@WFId", SqlDbType = SqlDbType.BigInt, Value = ddlAssignedTo.SelectedValue },
                       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate },
                       new SqlParameter() { ParameterName = "@Location", SqlDbType = SqlDbType.NVarChar, Value = ddlSite.SelectedValue },
                       new SqlParameter() { ParameterName = "@LocationDesc", SqlDbType = SqlDbType.NVarChar, Value = strlocation.ToString()},
                       new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "00" },
                       new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                       
                       );

                LoadWorkSchedule();
                //LoadStaffWorkChart();
                //LoadCopyFrom();

                ClearWorkSchedule();
                
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('House keeping work schedule details saved');", true);
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private string DoorNo()
    {
       
        string strrsnfilter =cmbResident.SelectedItem.Text;

        string[] custrsn = strrsnfilter.Split(',');

        strrsnfilter = custrsn[0].ToString();

        return strrsnfilter;
    }
   
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                sqlobj.ExecuteSQLNonQuery("SP_UpdatetblWorkSchedule",
                          new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RSN"].ToString() },
                          new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtUpdateRemarks.Text },
                          new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue },
                          new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                          new SqlParameter() { ParameterName = "@FromTime", SqlDbType = SqlDbType.Time, Value = dtpfromTime.SelectedTime },
                          new SqlParameter() { ParameterName = "@ToTime", SqlDbType = SqlDbType.Time, Value = dtptoTime.SelectedTime },
                          new SqlParameter() { ParameterName = "@UsualTime", SqlDbType = SqlDbType.BigInt, Value = txtestimatedmins.Text }
                          );

                LoadWorkSchedule();
                LoadWorkSchedulePending();
                LoadStaffWorkChart();

                rwEditWorkSchedule.Visible = false;

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('House keeping work schedule details updated');", true);
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvWorkSchedule_ItemCommand(object sender, GridCommandEventArgs e)
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

                    DataSet dsRes = sqlobj.ExecuteSP("SP_GetWorkSchedule",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text });

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {
                        lblTask.Text = dsRes.Tables[0].Rows[0]["taskid"].ToString();
                        lblPersonName.Text = dsRes.Tables[0].Rows[0]["wfid"].ToString();
                        lblDate.Text = dsRes.Tables[0].Rows[0]["Date"].ToString();
                        lbllocation.Text = dsRes.Tables[0].Rows[0]["Location"].ToString();
                        lbllocationdesc.Text = dsRes.Tables[0].Rows[0]["LocationDesc"].ToString();
                        txtUpdateRemarks.Text = dsRes.Tables[0].Rows[0]["Remarks"].ToString();
                        ddlStatus.SelectedValue = dsRes.Tables[0].Rows[0]["Status"].ToString();
                        txtestimatedmins.Text = dsRes.Tables[0].Rows[0]["UsualTime"].ToString();

                       // DateTime fromdatetime = DateTime.ParseExact(dsRes.Tables[0].Rows[0]["fromtime"].ToString(), "h:m t", CultureInfo.InvariantCulture);

                        string fromtime =dsRes.Tables[0].Rows[0]["fromtime"].ToString();
                        string totime = dsRes.Tables[0].Rows[0]["totime"].ToString();

                        if (fromtime != "")
                        {

                            dtpfromTime.SelectedDate = DateTime.Parse(dsRes.Tables[0].Rows[0]["fromtime"].ToString());
                        }
                        else
                        {
                            dtpfromTime.SelectedDate = null;
                        }

                        if (totime !="")
                        {
                            dtptoTime.SelectedDate = DateTime.Parse(dsRes.Tables[0].Rows[0]["totime"].ToString());
                        }
                        else
                        {
                            dtptoTime.SelectedDate = null;
                        }
                       


                        rwEditWorkSchedule.Visible = true;
                        
                    }

                    dsRes.Dispose();

             

                }
            }
            else
            {
                LoadWorkSchedule();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnCopy_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                if(Convert.ToString(dtpCopy.SelectedDate)==""|| dtpCopy.SelectedDate==null)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Copy From date.');", true);
                    return;
                }

                DataSet dsCopy = sqlobj.ExecuteSP("SP_GetDateWorkSchedule",
                            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpCopy.SelectedDate) },
                            //new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value =  DateTime.ParseExact(ddlCopyFrom.SelectedValue,"dd/MM/yyyy",null) },
                            new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = dtpFrom.SelectedDate },
                            new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.DateTime, Value = dtpTo.SelectedDate },
                            new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.VarChar, Value = Session["UserID"].ToString() }
                            );

                if (dsCopy.Tables[0].Rows.Count > 0)
                {


                    lbltotalupdated.Text = "Copied:" + dsCopy.Tables[0].Rows[0]["Updated"].ToString();
                    //lbltotalnotupdated.Text = "Count of dates not updated:" + dsCopy.Tables[0].Rows[0]["NotUpdated"].ToString();

                    WebMsgBox.Show("Work Schedule copied");


                    //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Work Schedule copied');", true);

                }

                dsCopy.Dispose();

            }

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {


        SqlProcsNew sqlobj = new SqlProcsNew();


        DataSet dsStatement = sqlobj.ExecuteSP("SP_ExportWorkSchedule",
              new SqlParameter() { ParameterName = "@Date", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate }
              );


        if (dsStatement.Tables[0].Rows.Count > 0)
        {

            DataGrid dg = new DataGrid();

            dg.DataSource = dsStatement.Tables[0];
            dg.DataBind();

            DateTime sdate = dtpdate.SelectedDate.Value;
            

            // THE EXCEL FILE.
            string sFileName = "Work Schedule For " + sdate.ToString("dd/MM/yyyy")  + ".xls";
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


            Response.Write("<table><tr><td>House Keeping Schedule For</td><td>:" + sdate.ToString("dd/MM/yyyy") + "</td></tr></table>");


            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
            Response.Write(objSW.ToString());


            Response.End();
            dg = null;


        }
        else
        {
            WebMsgBox.Show("Work Schedule For" + dtpdate.SelectedDate.Value +  " does not exist");
        }

    }
    protected void ddlTask_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            LoadPersonName();


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlCopyFrom_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlCopyFrom.SelectedValue != "0")
            {

                LoadCopyWorkSchedule();
                LoadCopyStaffWorkChart();
            }
            

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadCopyWorkSchedule()
    {
        try
        {
            DataSet dsWorkSchedule = sqlobj.ExecuteSP("SP_LoadWorkSchedule",
                        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpCopy.SelectedDate) });


            if (dsWorkSchedule.Tables[0].Rows.Count > 0)
            {
                gvWorkSchedule.DataSource = dsWorkSchedule;
                gvWorkSchedule.DataBind();
            }
            else
            {
                gvWorkSchedule.DataSource = string.Empty;
                gvWorkSchedule.DataBind();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No work scheduled for your selected date.');", true);
                return;
            }

            dsWorkSchedule.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadCopyStaffWorkChart()
    {
        try
        {
            DataSet dsStaffWorkLoadChart = sqlobj.ExecuteSP("SP_StaffWorkloadChart",
                        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = Convert.ToDateTime(dtpCopy.SelectedDate) });


            if (dsStaffWorkLoadChart.Tables[0].Rows.Count > 0)
            {
                rgStaffWorkLoadChart.DataSource = dsStaffWorkLoadChart;
                rgStaffWorkLoadChart.DataBind();
            }
            else
            {
                rgStaffWorkLoadChart.DataSource = string.Empty;
                rgStaffWorkLoadChart.DataBind();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No work scheduled for your selected date.');", true);
                return;
            }

            dsStaffWorkLoadChart.Dispose();

            DateTime copydate = Convert.ToDateTime(dtpCopy.SelectedDate);

            lblstaffworkloadchart.Text = "Staff workload chart for " + copydate.ToString("dd-MM-yyyy");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


  
    protected void dtpTo_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {

                DateTime fdate = Convert.ToDateTime(dtpFrom.SelectedDate);
                DateTime tdate = Convert.ToDateTime(dtpTo.SelectedDate);

                Int32 noofdays = TotalDays(fdate, tdate);

                lbltotalnotupdated.Text = "Total Days:" + noofdays.ToString();
            
          
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private Int32 TotalDays(DateTime startDate, DateTime endDate)
    {
        int totalDays = 0;
        while (startDate <= endDate)
        {
            //if (startDate.DayOfWeek == DayOfWeek.Saturday
            //    || startDate.DayOfWeek == DayOfWeek.Sunday)
            //{
            //    startDate = startDate.AddDays(1);
            //    continue;
            //}
            startDate = startDate.AddDays(1);
            totalDays++;
        }

        return totalDays;
    }


    protected void ToggleSelectedState(object sender, EventArgs e)
    {
        CheckBox headerCheckBox = (sender as CheckBox);
        foreach (GridDataItem dataItem in gvWorkSchedule.MasterTableView.Items)
        {
           // string strRef = dataItem["Reference"].Text.ToString();
            //if (strRef != "#Aptmnt")
            //{
                (dataItem.FindControl("chkJSel") as CheckBox).Checked = headerCheckBox.Checked;
                dataItem.Selected = headerCheckBox.Checked;
           // }
        }
    }

    protected void TogglePendingSelectedState(object sender, EventArgs e)
    {
        CheckBox headerCheckBox = (sender as CheckBox);
        foreach (GridDataItem dataItem in gvWorkSchedulePending.MasterTableView.Items)
        {
             string strRef = dataItem["Status"].Text.ToString();
            if (strRef != "Done")
            {
            (dataItem.FindControl("chkJSel") as CheckBox).Checked = headerCheckBox.Checked;
            dataItem.Selected = headerCheckBox.Checked;
            }
        }
    }

    protected void btnMainbulkupdate_Click(object sender, EventArgs e)
    {
        try
        {
            ViewState["Bulk"] = null;
            int CNT = 0;
            foreach (GridDataItem itm in gvWorkSchedule.Items)
            {
                CheckBox chk = (CheckBox)itm.FindControl("chkJSel");
                if (chk.Checked)
                {
                    LinkButton lb = (LinkButton)itm.FindControl("lnkRSN");
                    CNT++;
                    string STaskID = lb.Text;
                    ViewState["Bulk"] = ViewState["Bulk"] + STaskID + ",";
                }
            }
            if (CNT > 1)
            {
                ViewState["Bulk"] = ViewState["Bulk"].ToString().Remove(ViewState["Bulk"].ToString().Length - 1);
                Label21.Text = ViewState["Bulk"].ToString();
                //LoadStatus();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "alertmsg();", true);
                //if (CnfResult.Value == "true")
                //{
                //    rwBulkUpdate.Visible = true;
                //}

            }
            else
            {
                //WebMsgBox.Show("Select one or more tasks first.");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "alertmsg1();", true);
            }

        }
        catch (Exception qr)
        {
            throw qr;
        }
    }
    protected void btnbulksubmit_Click(object sender, EventArgs e)
    {
        try
        {
            if (ViewState["Bulk"] != null)
            {
                string strtaskid = ViewState["Bulk"].ToString();
                string[] taskid = strtaskid.Split(',');
                int len = Convert.ToInt16(taskid.Length);
                int ucount = 0;
                foreach (string id in taskid)
                {
                    string test = id;
                   DataSet dsBulkUpdate = sqlobj.ExecuteSP("SP_BulkUpdate",
                         new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = id },
                         new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtbulktext.Text },
                         new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                         new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlbulkstatus.SelectedValue }
                         );                  

                  
                    int count = Convert.ToInt16(dsBulkUpdate.Tables[0].Rows[0]["TotalCount"].ToString());
                    if (count != 0)
                    {
                        ucount += 1;
                    }
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "confirmbulk('" + len.ToString() + "','" + ucount + "');", true);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "ConfirmClick();", true);
                txtbulktext.Text = string.Empty;
            }

            LoadWorkSchedule();

            rwBulkUpdate.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void btnbulkclose_Click(object sender, EventArgs e)
    {
        try
        {
            rwBulkUpdate.Visible = false;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        rwBulkUpdate.Visible = true;
    }
    protected void ddlStaff_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadWorkSchedule();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlWorkType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadWorkSchedule();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvWorkSchedulePending_ItemCommand(object sender, GridCommandEventArgs e)
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

                    DataSet dsRes = sqlobj.ExecuteSP("SP_GetWorkSchedule",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text });

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {
                        lblTask.Text = dsRes.Tables[0].Rows[0]["taskid"].ToString();
                        lblPersonName.Text = dsRes.Tables[0].Rows[0]["wfid"].ToString();
                        lblDate.Text = dsRes.Tables[0].Rows[0]["Date"].ToString();
                        lbllocation.Text = dsRes.Tables[0].Rows[0]["Location"].ToString();
                        lbllocationdesc.Text = dsRes.Tables[0].Rows[0]["LocationDesc"].ToString();
                        txtUpdateRemarks.Text = dsRes.Tables[0].Rows[0]["Remarks"].ToString();
                        ddlStatus.SelectedValue = dsRes.Tables[0].Rows[0]["Status"].ToString();
                        txtestimatedmins.Text = dsRes.Tables[0].Rows[0]["UsualTime"].ToString();

                        rwEditWorkSchedule.Visible = true;

                    }

                    dsRes.Dispose();

                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnDailySchedule_Click(object sender, EventArgs e)
    {
        dvPending.Visible = false;
        dvDailySchedule.Visible = true;
        dvcopy.Visible = false;
        dvViewTaskList.Visible = false;
    }
    protected void btnSchedule_Click(object sender, EventArgs e)
    {
        dvPending.Visible = false;
        dvDailySchedule.Visible = false;
        dvcopy.Visible = true;
        dvViewTaskList.Visible = false;
    }
    protected void btnPending_Click(object sender, EventArgs e)
    {
        dvcopy.Visible = false;
        dvDailySchedule.Visible = false;
        dvPending.Visible = true;
        dvViewTaskList.Visible = false;
    }

    protected void btnViewTaskList_Click(object sender, EventArgs e)
    {
        dvcopy.Visible = false;
        dvDailySchedule.Visible = false;
        dvPending.Visible = false;
        dvViewTaskList.Visible = true;
    }


    protected void lnkworkload_Click(object sender, EventArgs e)
    {
        dvStaffWorkLoad.Visible = true;
        lnkhide.Visible = true;
        lnkworkload.Visible = false;
    }
    protected void lnkhide_Click(object sender, EventArgs e)
    {
        dvStaffWorkLoad.Visible = false;
        lnkhide.Visible = false;
        lnkworkload.Visible = true;
    }
    protected void ddlPendingStaff_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadWorkSchedulePending();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlPendingWorkType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadWorkSchedulePending();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnPendingBulkupdate_Click(object sender, EventArgs e)
    {
        try
        {
            ViewState["PendingBulk"] = null;
            int CNT = 0;
            foreach (GridDataItem itm in gvWorkSchedulePending.Items)
            {
                CheckBox chk = (CheckBox)itm.FindControl("chkJSel");
                if (chk.Checked)
                {
                    LinkButton lb = (LinkButton)itm.FindControl("lnkRSN");
                    CNT++;
                    string STaskID = lb.Text;
                    ViewState["PendingBulk"] = ViewState["PendingBulk"] + STaskID + ",";
                }
            }
            if (CNT > 1)
            {
                ViewState["PendingBulk"] = ViewState["PendingBulk"].ToString().Remove(ViewState["PendingBulk"].ToString().Length - 1);
                Label21.Text = ViewState["PendingBulk"].ToString();
                //LoadStatus();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "alertmsgPending();", true);
                //if (CnfResult.Value == "true")
                //{
                //    rwBulkUpdate.Visible = true;
                //}

            }
            else
            {
                //WebMsgBox.Show("Select one or more tasks first.");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "alertmsg1();", true);
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    
 protected void Button1_Click(object sender, EventArgs e)
 {
     rwPendingBulk.Visible = true;
    
 }
 protected void btnPendingUpdate_Click(object sender, EventArgs e)
 {
     try
     {
        
             if (ViewState["PendingBulk"] != null)
             {
                 string strtaskid = ViewState["PendingBulk"].ToString();
                 string[] taskid = strtaskid.Split(',');
                 int len = Convert.ToInt16(taskid.Length);
                 int ucount = 0;
                 foreach (string id in taskid)
                 {
                     string test = id;
                     DataSet dsBulkUpdate = sqlobj.ExecuteSP("SP_BulkUpdate",
                           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = id },
                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtPendingRemarks.Text },
                           new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlPendingstatus.SelectedValue }
                           );


                     int count = Convert.ToInt16(dsBulkUpdate.Tables[0].Rows[0]["TotalCount"].ToString());
                     if (count != 0)
                     {
                         ucount += 1;
                     }
                 }
                 ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "confirmbulk('" + len.ToString() + "','" + ucount + "');", true);
                 //ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "ConfirmClick();", true);
                 txtbulktext.Text = string.Empty;
             }

             LoadWorkSchedulePending();

             rwPendingBulk.Visible = false;
        
     }
     catch (Exception ex)
     {
         WebMsgBox.Show(ex.Message.ToString());
     }
 }
 protected void btnPendingClose_Click(object sender, EventArgs e)
 {
     try
     {
         rwPendingBulk.Visible = false;
     }
     catch (Exception ex)
     {
         WebMsgBox.Show(ex.Message);
     }
 }
 protected void btnPendingUpdate_Click1(object sender, EventArgs e)
 {
     try
     {
         if (CnfResult.Value == "true")
         {

             if (ViewState["PendingBulk"] != null)
             {
                 string strtaskid = ViewState["PendingBulk"].ToString();
                 string[] taskid = strtaskid.Split(',');
                 int len = Convert.ToInt16(taskid.Length);
                 int ucount = 0;
                 foreach (string id in taskid)
                 {
                     string test = id;
                     DataSet dsBulkUpdate = sqlobj.ExecuteSP("SP_BulkUpdate",
                           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = id },
                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtPendingRemarks.Text },
                           new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                           new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlPendingstatus }
                           );


                     int count = Convert.ToInt16(dsBulkUpdate.Tables[0].Rows[0]["TotalCount"].ToString());
                     if (count != 0)
                     {
                         ucount += 1;
                     }
                 }
                 ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "confirmbulk('" + len.ToString() + "','" + ucount + "');", true);
                 //ScriptManager.RegisterStartupScript(this, this.GetType(), "Function", "ConfirmClick();", true);
                 txtbulktext.Text = string.Empty;
             }

             LoadWorkSchedulePending();

             rwPendingBulk.Visible = false;
         }
     }
     catch (Exception ex)
     {
         WebMsgBox.Show(ex.Message.ToString());
     }
 }
 protected void ddlViewCategory_SelectedIndexChanged(object sender, EventArgs e)
 {
     try
     {
         LoadViewTask();
     }
     catch(Exception ex)
     {
         WebMsgBox.Show(ex.Message);
     }
 }

 private void LoadViewTask()
 {
     try
     {
         //SP_LoadWorkTasks

         string categoryvalue = ddlViewCategory.SelectedValue.ToString();

         string[] strcatval = categoryvalue.Split(',');

         DataSet dsTask = sqlobj.ExecuteSP("SP_LoadWorkTasks",
             new SqlParameter() { ParameterName = "@CategoryCode", SqlDbType = SqlDbType.NVarChar, Value = strcatval[0].ToString() });

         ddlTask.Items.Clear();


         if (dsTask.Tables[0].Rows.Count > 0)
         {
             ddlViewTask.DataSource = dsTask;
             ddlViewTask.DataValueField = "Value";
             ddlViewTask.DataTextField = "Title";
             ddlViewTask.DataBind();
         }


         dsTask.Dispose();

         ddlViewTask.Items.Insert(0, "All");

         //if (dsTask.Tables[1].Rows.Count > 0)
         //{
         //    lbldepartment.Text = "Department:" + dsTask.Tables[1].Rows[0]["Department"].ToString();
         //}
         //else
         //{
         //    lbldepartment.Text = "";
         //}


     }
     catch (Exception ex)
     {
         WebMsgBox.Show(ex.Message);
     }
 }

 protected void ddlViewTask_SelectedIndexChanged(object sender, EventArgs e)
 {
     try
     {
         LoadviewPersonName();
     }
     catch(Exception ex)
     {
         WebMsgBox.Show(ex.Message);
     }
 }


 private void LoadviewPersonName()
 {
     try
     {
         //SP_LoadWorkForce

         string taskvalue = ddlViewTask.SelectedValue.ToString();

         string[] strtask = taskvalue.Split('-');

         DataSet dsPersonName = sqlobj.ExecuteSP("SP_GetTaskNames",
             new SqlParameter() { ParameterName = "@TaskCategory", SqlDbType = SqlDbType.NVarChar, Value = strtask[1].ToString() });


         ddlViewStaff.Items.Clear();
         
         if (dsPersonName.Tables[0].Rows.Count > 0)
         {
             ddlViewStaff.DataSource = dsPersonName;
             ddlViewStaff.DataValueField = "RSN";
             ddlViewStaff.DataTextField = "PersonName";
             ddlViewStaff.DataBind();

         }
         else
         {
             ddlViewStaff.Items.Clear();

         }


         dsPersonName.Dispose();

         ddlViewStaff.Items.Insert(0, "All");


     }
     catch (Exception ex)
     {
         WebMsgBox.Show(ex.Message);
     }
 }

 protected void btnSearch_Click(object sender, EventArgs e)
 {
     try
     {

         LoadViewTaskList();

     }
     catch(Exception ex)
     {
         WebMsgBox.Show(ex.Message);
     }
 }

 private void LoadViewTaskList()
 {
     try
     {
         DataSet dsViewWorkSchedule = sqlobj.ExecuteSP("SP_LoadViewTaskList",
                    new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = dtpFromDate.SelectedDate },
                    new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.DateTime, Value = dtpToDate.SelectedDate },
                    new SqlParameter() { ParameterName = "@Staff", SqlDbType = SqlDbType.NVarChar, Value = ddlViewStaff.SelectedItem.Text == "All" ? null : ddlViewStaff.SelectedItem.Text },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = ddlViewCategory.SelectedItem.Text == "All" ? null : ddlViewCategory.SelectedItem.Text },
                    new SqlParameter() { ParameterName = "@Task", SqlDbType = SqlDbType.NVarChar, Value = ddlViewTask.SelectedItem.Text == "All" ? null : ddlViewTask.SelectedItem.Text },
                    new SqlParameter() { ParameterName = "@Site", SqlDbType = SqlDbType.NVarChar, Value = ddlViewSite.SelectedItem.Text == "All" ? null : ddlViewSite.SelectedItem.Text },
                    new SqlParameter() { ParameterName = "@WorkType", SqlDbType = SqlDbType.NVarChar, Value = ddlPendingWorkType.SelectedValue == "All" ? null : ddlPendingWorkType.SelectedValue }

                    );


         if (dsViewWorkSchedule.Tables[0].Rows.Count > 0)
         {
             rgViewTaskList.DataSource = dsViewWorkSchedule;
             rgViewTaskList.DataBind();
         }
         else
         {
             rgViewTaskList.DataSource = string.Empty;
             rgViewTaskList.DataBind();
         }

         dsViewWorkSchedule.Dispose();
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
         Page.ClientScript.RegisterStartupScript(
this.GetType(), "OpenWindow", "window.open('CalendarPendingTasks.aspx','_newtab');", true);

     
     }
     catch(Exception ex)
     {
         WebMsgBox.Show(ex.Message);
     }
 }
 protected void ddlPenStatus_SelectedIndexChanged(object sender, EventArgs e)
 {
     try
     {
         LoadWorkSchedulePending();
     }
     catch(Exception ex)
     {
         WebMsgBox.Show(ex.Message);
     }
 }

 protected void gvWorkSchedule_ItemDataBound(object sender, GridItemEventArgs e)
 {
     try
     {
         if (e.Item is GridDataItem)
         {
             GridDataItem dataItem = e.Item as GridDataItem;


             String strStatus = dataItem["Status"].Text;

             if (strStatus == "Done")
             {
                 dataItem["Status"].ForeColor = System.Drawing.Color.Green;
             }


         }
     }
     catch (Exception ex)
     {
         WebMsgBox.Show(ex.Message);
     }
 }

 protected void gvWorkSchedule_Init(object sender, EventArgs e)
 {
     GridFilterMenu menu = gvWorkSchedule.FilterMenu;
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
 protected void gvWorkSchedulePending_Init(object sender, EventArgs e)
 {
     GridFilterMenu menu = gvWorkSchedulePending.FilterMenu;
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
 protected void rgViewTaskList_Init(object sender, EventArgs e)
 {
     GridFilterMenu menu = rgViewTaskList.FilterMenu;
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

    protected void dtpCopy_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        if(dtpCopy.SelectedDate!=null)
        {
            LoadCopyWorkSchedule();
            LoadCopyStaffWorkChart();
        }  
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select Copy from date.');", true);
            return;
        }      
    }
}
