using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using Telerik.Web.UI;

public partial class BillSummary : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            rwPopUp.VisibleOnPageLoad = true;
            rwPopUp.Visible = false;

            if (!IsPostBack)
            {

                LoadTitle();

                if (Request.QueryString["ResidentRSN"] != null)
                {

                    Session["ResidentRSN"]= Request.QueryString["ResidentRSN"].ToString();
                    LoadDefault(Session["ResidentRSN"].ToString());

                    DataSet dsgetoutstanding = sqlobj.ExecuteSP("SP_GetResidentOutStanding",
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["ResidentRSN"].ToString() });

                    if (dsgetoutstanding.Tables[0].Rows.Count > 0)
                    {

                        lblName.Text = "Name:" + dsgetoutstanding.Tables[0].Rows[0]["Name"].ToString();

                        lblDoorNO.Text = "DoorNo:" + dsgetoutstanding.Tables[0].Rows[0]["DoorNo"].ToString();

                        lblMobileNo.Text = "Mobile No:" + dsgetoutstanding.Tables[0].Rows[0]["Mobile"].ToString();

                        lblEmail.Text = "Email:" + dsgetoutstanding.Tables[0].Rows[0]["EMail"].ToString();

                        decimal doutstanding = Convert.ToDecimal(dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString());

                        lbloutstanding.Text = "Outstanding:" + doutstanding.ToString("0.00");
                    }

                    dsgetoutstanding.Dispose();
                }
                else
                {
                    Session["ResidentRSN"] = null;
                    LoadDefaultAll();
                }

                //DateTime now = DateTime.Now;
               // radfromdate.SelectedDate = new DateTime(now.Year, now.Month, 1);

                //radtilldate.SelectedDate = DateTime.Today;
                //LoadSession();
                
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 32 });


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

    private void LoadDefault(string rsn)
    {
        try
        {
            Session["ResidentRSN"] = rsn.ToString();

            DataSet dsResident = sqlobj.ExecuteSP("SP_LoadBillwiseTransactions",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

            gvBillSummary.DataSource = dsResident;
            gvBillSummary.DataBind();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadDefaultAll()
    {
        try
        {

            DataSet dsResident = sqlobj.ExecuteSP("SP_LoadBillwiseDefaultTransactions");

            gvBillSummary.DataSource = dsResident;
            gvBillSummary.DataBind();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rmReports_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        if (e.Item.Text == "Financial Transactions")
        {
            Response.Redirect("DailyFoodBillReport.aspx");
        }
        else if (e.Item.Text == "Monthly Statement")
        {
            Response.Redirect("MailBilling.aspx");
        }
        else if (e.Item.Text == "Billing Summary View")
        {
            Response.Redirect("MonthlyBilling.aspx?MBVal=" + 2);
        }
        else if (e.Item.Text == "Billing History Per Resident")
        {
            Response.Redirect("ResidentTxnSummary.aspx?RSVal=" + 2);
        }
        else if (e.Item.Text == "Diners Summary")
        {
            Response.Redirect("DinerssummRep.aspx");
        }
        else if (e.Item.Text == "Which Menu which day")
        {
            Response.Redirect("MenuItemReport.aspx");
        }
        else if (e.Item.Text == "Ingredients Report")
        {
            Response.Redirect("IngredientsRep.aspx");
        }
        else if (e.Item.Text == "Menu for the day")
        {
            Response.Redirect("MenuItemPerday.aspx");
        }
        else if (e.Item.Text == "A la Carte Booking List")
        {
            Response.Redirect("AlacarteBookingList.aspx");
        }
        else if (e.Item.Text == "A la Carte Booking Summary")
        {
            Response.Redirect("AlacarteBookingSummary.aspx");
        }
    }

    private void LoadBillingDetails(string BillNo)
    {
        try
        {
            DataSet dsResident = sqlobj.ExecuteSP("SP_BillingDetails",
                new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = BillNo.ToString() });

            if (dsResident.Tables[0].Rows.Count > 0)
            {

                gvBillingDetails.DataSource = dsResident;
                gvBillingDetails.DataBind();
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvBillSummary_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "BillNo")
            {

                string sbn = e.CommandArgument.ToString();


               // lblbillno.Text = "BillNo:" + sbn.ToString();

                LoadBillingDetails(sbn);

                rwPopUp.Visible = true;
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
       
    }
    protected void btnAcceptPayment_Click(object sender, EventArgs e)
    {
        try
        {
            Session["AcceptPayment"] = Session["ResidentRSN"].ToString();
            Response.Redirect("FoodMenu.aspx?MenuName=Accept Payment",false);
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string strrsnfilter = racAPResident.Text;

            string[] custrsn = strrsnfilter.Split(',');

            strrsnfilter = custrsn[3].ToString();

            custrsn = strrsnfilter.Split(';');

            Int32 rsn = Convert.ToInt32(custrsn[0].ToString());

            Session["RTRSN"] = rsn.ToString();


            DataSet dsgetoutstanding = sqlobj.ExecuteSP("SP_GetResidentOutStanding",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

            if (dsgetoutstanding.Tables[0].Rows.Count > 0)
            {

                lblName.Text =dsgetoutstanding.Tables[0].Rows[0]["Name"].ToString() + ",";

                lblDoorNO.Text = dsgetoutstanding.Tables[0].Rows[0]["DoorNo"].ToString() + ",";

                lblMobileNo.Text =  dsgetoutstanding.Tables[0].Rows[0]["Mobile"].ToString() + ",";

                lblEmail.Text = "Email:" + dsgetoutstanding.Tables[0].Rows[0]["EMail"].ToString();

                decimal doutstanding = Convert.ToDecimal(dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString());

                lbloutstanding.Text = "Outstanding:" + doutstanding.ToString("0.00");
              
            }

            dsgetoutstanding.Dispose();

            LoadDefault(rsn.ToString());
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}