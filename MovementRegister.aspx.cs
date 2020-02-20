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

public partial class MovementRegister : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet dsDT = null;
        dsDT = sqlobj.ExecuteSP("GetServerDateTime");
        DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
       

        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadTitle();
            LoadResidentDet();
            LoadStatus();
            LoadGrid();
            dtpFromDate.SelectedDate = now;

           
            //LoadMinMaxDT();


            //dtpFromDate.MinDate = now;
            //dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.MinDate);

           
            //dtpTillDate.SelectedDate = Convert.ToDateTime(dtpFromDate.SelectedDate);

            //LoadResident();
            //LoadBillingMonth();


             
            
             



            //dtpFromDate.MinDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPFrom"].ToString());
            //dtpFromDate.MaxDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPTill"].ToString());

            //dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.MinDate);
            //dtpTillDate.MaxDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPTill"].ToString());

            //dtpFromDate.SelectedDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPFrom"].ToString());
            //dtpTillDate.SelectedDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPFrom"].ToString());

            //DateTime d1 = Convert.ToDateTime(dtpFromDate.SelectedDate);
            //DateTime d2 = Convert.ToDateTime(dtpTillDate.SelectedDate);                                

            //DateTime firstOfNextMonth = new DateTime(now.Year, now.Month, 1).AddMonths(1);
            //DateTime lastOfThisMonth = firstOfNextMonth.AddDays(-1);

            //dtpFromDate.MinDate = new DateTime(now.Year, now.Month, 1);
            //dtpFromDate.MaxDate = lastOfThisMonth;
            //dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.SelectedDate);
            //dtpTillDate.MaxDate = Convert.ToDateTime(dtpFromDate.MaxDate);

            //TimeSpan t = d2 - d1;
            //double NrOfDays = t.TotalDays;
            //txtNoDaysDinned.Text = NrOfDays.ToString();
        }
    }

    private void LoadStatus()
    {
        ddlStatus.Items.Insert(0, "Checked Out");
        ddlStatus.Items.Insert(1, "Checked In");
        ddlStatus.Items.Insert(2, "All");
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 33 });


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

            dsResident.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {


            string strrsnfilter = cmbResident.SelectedItem.Text;

            string[] custrsn = strrsnfilter.Split(',');

            string custname = custrsn[0].ToString();

            string doorno = custrsn[1].ToString();

            string RTRSN = cmbResident.SelectedValue;

             

            DataSet dsdeposit = sqlobj.ExecuteSP("Proc_CheckinandoutAll",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 5 },
              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = cmbResident.SelectedValue });

            if (dsdeposit.Tables[0].Rows.Count > 0)
            {
                txtDoorNo.Text = dsdeposit.Tables[0].Rows[0]["DoorNo"].ToString();
                txtMobileNo.Text = dsdeposit.Tables[0].Rows[0]["MobileNo"].ToString();
            }
            

             
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        LoadGrid();
    }

    public void LoadGrid()
    {
        try
        {
            DataSet dsUsers = new DataSet();

            if (ddlStatus.SelectedIndex == 0)
            {
                 dsUsers = sqlobj.ExecuteSP("Proc_CheckinandoutAll",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 10 });
            }
            else if (ddlStatus.SelectedIndex == 1)
            {
                 dsUsers = sqlobj.ExecuteSP("Proc_CheckinandoutAll",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 11});
            }
            else if (ddlStatus.SelectedIndex == 2)
            {
                 dsUsers = sqlobj.ExecuteSP("Proc_CheckinandoutAll",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 12});
            
            } 
            
           


            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                grdCheckInOut.DataSource = dsUsers;
                grdCheckInOut.DataBind();
            }
            else
            {
                grdCheckInOut.DataSource = string.Empty;
                grdCheckInOut.DataBind();
            }

            LblOutCount.Text = "Resident(s) checked out as of now :   " + dsUsers.Tables[1].Rows[0]["RCnt"].ToString();

            dsUsers.Dispose();


        }
        catch (Exception ex)
        {
        }
    }


    

     

    protected void LoadMinMaxDT()
    {
        try
        {
            DataSet dsDt = sqlobj.ExecuteSP("SP_FetchMinMaxDate",
            new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
            new SqlParameter() { ParameterName = "@BPName", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });

            if (dsDt.Tables[0].Rows.Count > 0)
            {

                RadDatePicker minValDate = new RadDatePicker();
                minValDate.MinDate = new System.DateTime();
                minValDate.SelectedDate = new System.DateTime();

                dtpFromDate.Clear();
                dtpTillDate.Clear();



                dtpFromDate.MinDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPFrom"].ToString());
                dtpFromDate.MaxDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPTill"].ToString());

                dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.MinDate);
                dtpTillDate.MaxDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPTill"].ToString());

                dtpFromDate.SelectedDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPFrom"].ToString());
                dtpTillDate.SelectedDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPFrom"].ToString());

                DateTime d1 = Convert.ToDateTime(dtpFromDate.SelectedDate);
                DateTime d2 = Convert.ToDateTime(dtpTillDate.SelectedDate);

                TimeSpan t = d2 - d1;
                double NrOfDays = t.TotalDays;
                //txtNoDaysDinned.Text = NrOfDays.ToString();


            }
        }
        catch (Exception ex)
        {
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                if (cmbResident.SelectedIndex != 0 && txtDoorNo.Text != string.Empty && txtMobileNo.Text != string.Empty && Convert.ToString(dtpFromTime.SelectedTime) != string.Empty)
                {

                    sqlobj.ExecuteSP("Proc_CheckinandoutAll",
                        new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 6 },
                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                        new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckOut" },
                        new SqlParameter() { ParameterName = "@CheckOutDt", SqlDbType = SqlDbType.DateTime, Value = dtpFromDate.SelectedDate },
                        new SqlParameter() { ParameterName = "@CheckOutTime", SqlDbType = SqlDbType.Time, Value = dtpFromTime.SelectedTime },
                        //new SqlParameter() { ParameterName = "@CheckInDt", SqlDbType = SqlDbType.DateTime, Value = dtpTillDate.SelectedDate },
                        //new SqlParameter() { ParameterName = "@CheckInTime", SqlDbType = SqlDbType.Time, Value = dtpTillTime.SelectedTime },     
                        new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                        new SqlParameter() { ParameterName = "@C_ID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });



                    //LoadGrid();
                    ClearScr();
                    WebMsgBox.Show("Successfully checked out");
                }
                else
                {
                    WebMsgBox.Show("Please select/enter mandatory field(s) ");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }






    public void ClearScr()
    {

        DataSet dsDT = null;
        dsDT = sqlobj.ExecuteSP("GetServerDateTime");
        DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);

        cmbResident.SelectedIndex = 0;
        txtDoorNo.Text = string.Empty;
        txtMobileNo.Text = string.Empty;
        txtRemarks.Text = string.Empty;

        dtpFromDate.SelectedDate = now;

       

        trCheckIn.Visible = false;
        cmbResident.Enabled = true;
        dtpFromDate.Enabled = true;
        dtpFromTime.Enabled = true;

        LoadGrid();
         


        
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
        btnSave.Visible = true;
        btnUpdate.Visible = false;
    }

    protected void LnkEditItem_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet dsDT2 = null;
            dsDT2 = sqlobj.ExecuteSP("GetServerDateTime");
            DateTime now = Convert.ToDateTime(dsDT2.Tables[0].Rows[0][0]);


            btnUpdate.Visible = true;
            btnSave.Visible = false;
            LinkButton lnkEdititemBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdititemBtn.NamingContainer;
            string RSN;
            RSN = row.Cells[3].Text;
            
            hdnRSN.Value = RSN.ToString();
            SqlProcsNew proc = new SqlProcsNew();      

            DataSet dsDT = sqlobj.ExecuteSP("Proc_CheckinandoutAll",
               new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 8 },
               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = RSN });

            cmbResident.SelectedValue = dsDT.Tables[0].Rows[0]["RTRSN"].ToString();
            txtDoorNo.Text = dsDT.Tables[0].Rows[0]["DoorNo"].ToString();
            txtMobileNo.Text = dsDT.Tables[0].Rows[0]["MobileNo"].ToString();  
            dtpFromDate.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0]["CheckOutDate"].ToString());
            dtpFromTime.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0]["CheckOutTime"].ToString());           
            txtRemarks.Text = dsDT.Tables[0].Rows[0]["Remarks"].ToString();

         

            //dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.SelectedDate);
            //dtpTillDate.MaxDate = now;

            DateTime d1 = Convert.ToDateTime(dtpFromDate.SelectedDate);
            DateTime d2 = Convert.ToDateTime(now);

            TimeSpan t = d2 - d1;
            double NrOfDays = t.TotalDays;

            if (NrOfDays < 0)
            {
                dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.SelectedDate);
                dtpTillDate.MaxDate = Convert.ToDateTime(dtpFromDate.SelectedDate);
                dtpTillDate.SelectedDate = Convert.ToDateTime(dtpFromDate.SelectedDate);
            }

            else
            {
                dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.SelectedDate);
                dtpTillDate.MaxDate = now;
                dtpTillDate.SelectedDate = now;
            
            }
               


            trCheckIn.Visible = true;
            cmbResident.Enabled = false;
            dtpFromDate.Enabled = false;
            dtpFromTime.Enabled = false;




        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {


            if (CnfResult.Value == "true")
            {

                if (cmbResident.SelectedIndex != 0 && txtDoorNo.Text != string.Empty && txtMobileNo.Text != string.Empty && Convert.ToString(dtpTillTime.SelectedTime) != string.Empty)
                {


                    sqlobj.ExecuteSP("Proc_CheckinandoutAll",
                      new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 9 },
                      new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = hdnRSN.Value },
                      //new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                      new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckIn" },
                      //new SqlParameter() { ParameterName = "@CheckOutDt", SqlDbType = SqlDbType.DateTime, Value = dtpFromDate.SelectedDate },
                      //new SqlParameter() { ParameterName = "@CheckOutTime", SqlDbType = SqlDbType.Time, Value = dtpFromTime.SelectedTime },
                      new SqlParameter() { ParameterName = "@CheckInDt", SqlDbType = SqlDbType.DateTime, Value = dtpTillDate.SelectedDate },
                      new SqlParameter() { ParameterName = "@CheckInTime", SqlDbType = SqlDbType.Time, Value = dtpTillTime.SelectedTime },     
                      new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                      new SqlParameter() { ParameterName = "@C_ID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

                    WebMsgBox.Show("Successfully checked in ");
                    ClearScr();
                    
                }
                else
                {
                    WebMsgBox.Show("Please select/enter mandatory field(s) ");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }


    protected void grdCheckInOut_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid();
    }


    protected void grdCheckInOu_ItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {

                if (item["CheckInDt"].Text.Equals("&nbsp;"))
                {
                    LinkButton lnkdependent = (LinkButton)item.FindControl("lbtnUpdate");
                    lnkdependent.Visible = true;

                }
                else
                {
                    LinkButton lnkdependent = (LinkButton)item.FindControl("lbtnUpdate");
                    lnkdependent.Visible = false;
                }

                

            }
            catch (GridException ex) { }

        }
    }



    //protected void grdBillingDays_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    //{
    //    LoadGrid();
    //}
    //protected void grdCheckInOut_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    //{
    //    LoadGrid();
    //}
    //protected void grdBillingDays_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    //{
    //    LoadGrid();
    //}
    //protected void grdBillingDays_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    //{
    //    LoadGrid();
    //}

    protected void dtpFromDate_Changed(object sender, EventArgs e)
    {
        double NrOfDays;

        dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.SelectedDate);

        DateTime d1 = Convert.ToDateTime(dtpFromDate.SelectedDate);
        DateTime d2 = Convert.ToDateTime(dtpTillDate.SelectedDate);

        TimeSpan t = d2 - d1;
        if (d1 == d2)
        {
            NrOfDays = t.TotalDays;
        }
        else
        {
            NrOfDays = t.TotalDays + 1;
        }

        //txtNoDaysDinned.Text = NrOfDays.ToString();
    }

    protected void ddlBillingMonth_Changed(object sender, EventArgs e)
    {
        LoadMinMaxDT();
    }
    protected void grdCheckInOut_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = grdCheckInOut.FilterMenu;
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
}