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
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.IO;
using System.Data.OleDb;
using System.Text;
using System.Reflection;
using System.Web.Services;


public partial class CovaiSoft : System.Web.UI.MasterPage
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }


            Page.Header.DataBind();
            DataSet dsProcess = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;

            if (!IsPostBack)
            {

                // -- Set Menus

                GetDepartment();

                string CurrentPage = Page.ToString().Replace("ASP.", "").Replace("_", ".");

                string absolutepath = HttpContext.Current.Request.Url.AbsoluteUri.ToString();


                string Authority = HttpContext.Current.Request.Url.Authority.ToString();


              



                dsDT = proc.ExecuteSP("GetServerDateTime");
                //GetserverDateTime.Text = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dddd") + " , " + Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd MMM yyyy | hh : mm tt"); ;

                GetserverDateTime.Text = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddd") + "   " + Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd-MMM-yyyy HH:mm 'Hrs'"); ;

                //Add by Prakash.M
                //DateTime dt = Convert.ToDateTime(dsUserDetails.Tables[0].Rows[0]["lastloggedin"].ToString()); // get current date time
                //lbllastlogin.Text = "You last logged in on  " + dt.ToString("ddd") + " " + string.Format("{0:dd-MMM-yyyy HH:mm 'Hrs'}", dt);

               


                if (Authority == "localhost:60163")
                {

                    absolutepath = absolutepath.ToString().Replace("http://localhost:60163/", "").Replace("%20", " ");
                }
                else
                {
                    absolutepath = absolutepath.ToString().Replace("http://bincrm.com/oris/", "").Replace("%20", " ");

                }



                InsertMenuLog(absolutepath);


                DataTable dt = GetData(0);
                PopulateMenu(dt, 0, null);

                LoadHighlight();

                if (CurrentPage == "HomeMenu.aspx")
                {
                    //ImgBHome.Visible = false;
                    //lnkHome.Visible = false;
                }
                else
                {
                    //ImgBHome.Visible = true;
                    //lnkHome.Visible = true;
                }

                if (CurrentPage == "allmenus.aspx")
                {
                    Menu1.Visible = false;
                    //lnkHome.Visible = false;
                }
                else
                {
                    Menu1.Visible = true;
                    //lnkHome.Visible = true;
                }

                LoadRecentCrDr();
                LoadBillingPeriod();
                ProductStatus();
            }
            //LoadGridVillaCount();
        }
        catch (Exception ex)
        {
            //ShowMsgBox(ex.Message, "Exception");
        }
    }

    protected override void Render(HtmlTextWriter writer)
    {



        StringBuilder stringBuilder = new StringBuilder();

        StringWriter stringWriter = new StringWriter(stringBuilder);



        HtmlTextWriter htmlWriter = new HtmlTextWriter(stringWriter);

        base.Render(htmlWriter);



        string html = stringBuilder.ToString();

        //html = html.Replace("onmouseover="(Menu_HoverStatic(this))"","onclick="(Menu_HoverStatic(this)""));

        html = html.Replace("onmouseover=\"Menu_HoverStatic(this)\"", "onclick=\"Menu_HoverStatic(this)\"");



        writer.Write(html);



    }

    private void InsertMenuLog(string url)
    {
        try
        {

            string strUrl = "~/" + url.ToString();

            DataSet dsMenuID = sqlobj.ExecuteSP("SP_GetMenuID",
                 new SqlParameter() { ParameterName = "@Url", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = strUrl.ToString() });

            DateTime currentdate = DateTime.Now;


            if (dsMenuID.Tables[0].Rows.Count > 0)
            {
                sqlobj.ExecuteSP("SP_InsertUserMenuLog",
                new SqlParameter() { ParameterName = "@UserID", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                new SqlParameter() { ParameterName = "@MenuID", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = dsMenuID.Tables[0].Rows[0]["MenuId"].ToString() },
                new SqlParameter() { ParameterName = "@AccessDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = currentdate.ToString() }
                );
            }

            dsMenuID.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void GetDepartment()
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsDept = null;
        dsDept = sqlobj.ExecuteSP("SP_GetDepartment",
            new SqlParameter() { ParameterName = "@UserId", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Session["UserId"].ToString() });

        Session["DeptCode"] = dsDept.Tables[0].Rows[0]["DeptCode"].ToString();

        //lblUserId.Text = dsDept.Tables[0].Rows[0]["UserName"].ToString();
        //lblDepartName.Text = dsDept.Tables[1].Rows[0]["DeptName"].ToString();
        //lblDeptAccess.Text = "(Has access to " ;
        //has access to

    }


    private DataTable GetData(int parentMenuId)
    {

        DataTable dt = new DataTable();

        DataSet dsMenus = sqlobj.ExecuteSP("SP_GetMenus",
               new SqlParameter() { ParameterName = "@ParentMenuId", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = parentMenuId },
               new SqlParameter() { ParameterName = "@Deptcodes", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.VarChar, Value = Session["DeptCode"].ToString() }
               );


        if (dsMenus.Tables[0].Rows.Count > 0)
        {
            dt = dsMenus.Tables[0];
        }

        return dt;

    }

    private void PopulateMenu(DataTable dt, int parentMenuId, MenuItem parentMenuItem)
    {
        string currentPage = Path.GetFileName(Request.Url.AbsolutePath);
        foreach (DataRow row in dt.Rows)
        {
            MenuItem menuItem = new MenuItem
            {
                Value = row["MenuId"].ToString(),
                Text = row["Title"].ToString(),
                NavigateUrl = row["Url"].ToString(),
                Selected = row["Url"].ToString().EndsWith(currentPage, StringComparison.CurrentCultureIgnoreCase)

            };
            if (parentMenuId == 0)
            {
                Menu1.Items.Add(menuItem);
                DataTable dtChild = this.GetData(int.Parse(menuItem.Value));
                PopulateMenu(dtChild, int.Parse(menuItem.Value), menuItem);
            }
            else
            {
                parentMenuItem.ChildItems.Add(menuItem);
            }
        }
    }

    private void LoadHighlight()
    {
        try
        {
            foreach (MenuItem menuitem in Menu1.Items)
            {
                foreach (MenuItem submenuitem in menuitem.ChildItems)
                {
                    string svalue = submenuitem.Value;


                    DataSet dsHighlight = sqlobj.ExecuteSP("SP_GetHighlight",
                    new SqlParameter() { ParameterName = "@MenuID", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = svalue });

                    if (dsHighlight.Tables[0].Rows.Count > 0)
                    {

                        string svisible = dsHighlight.Tables[0].Rows[0]["IsVisible"].ToString();

                        if (svisible == "2")
                        {
                            // coloring the sub menu item
                            submenuitem.Text = "<div style='color:Black;font-weight:bold; background-color:yellow'>" + submenuitem.Text + "</div>";
                        }
                    }

                    dsHighlight.Dispose();


                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void LoadBillingPeriod()
    {
        try
        {

            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_FetchBillingPeriods",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });

            lblCurrBillPeriod.Text = "Billing Period: Current-" + dsGroup.Tables[1].Rows[0]["CurrentPeriod"].ToString() + "";
            Session["CurrentBillingPeriod"] = dsGroup.Tables[1].Rows[0]["CurrentPeriod"].ToString();

            if (dsGroup.Tables[2].Rows.Count > 0)
            {

                lblBilledPeriod.Text = "Previous-" + dsGroup.Tables[2].Rows[0]["BilledPeriod"].ToString();
            }

            lblcomName.Text = dsGroup.Tables[3].Rows[0]["CommunityName"].ToString();
            lblversionnumber.Text = dsGroup.Tables[3].Rows[0]["versionnumber"].ToString();

            lblcompanycode.Text = dsGroup.Tables[3].Rows[0]["CompanyCode"].ToString();

            lblsignin.Text = "Welcome-" + Session["UserID"].ToString();



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    public void ProductStatus()
    {
        try
        {
            DataSet dsSection = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            dsSection = proc.ExecuteSP("[SP_AdminEdit]");
            if (dsSection.Tables[0].Rows.Count > 0)
            {
                if (dsSection.Tables[0].Rows[0]["status"].ToString() == "TRL")
                {
                    DateTime date = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["uptoDate"].ToString());
                    //DateTime date = DateTime.Now;
                    //lblTrial.Text = "Welcome! Explore all features for free until " + date.ToString("dd-MMM-yyyy");
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void LoadRecentCrDr()
    {

        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsRecentCD = new DataSet();
        dsRecentCD = proc.ExecuteSP("SP_GetRecentCrDr");
        //lblRecentCr.Text = dsRecentCD.Tables[0].Rows[0]["CR"].ToString();
        //lblRecentDr.Text = dsRecentCD.Tables[1].Rows[0]["DR"].ToString();
    }

    protected void lblSignOut_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }

    protected void ImgBHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("AllMenus.aspx");
    }

    //protected void LoadGridVillaCount()
    //{

    //    SqlCommand cmd = new SqlCommand("SP_General", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 8;
    //    DataSet dsGrid = new DataSet();
    //    VillaCountListView.DataBind();

    //    SqlDataAdapter da = new SqlDataAdapter(cmd);

    //    da.Fill(dsGrid);
    //    if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
    //    {

    //        VillaCountListView.DataSource = dsGrid.Tables[0];
    //        VillaCountListView.DataBind();

    //        VillaCountListView.AllowPaging = true;

    //    }
    //    else
    //    {
    //        VillaCountListView.DataSource = new String[] { };
    //        VillaCountListView.DataBind();
    //    }
    //}

    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        //if(txtNSearch.Text.Length >= 4)
        //{
        ////ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Function", "NavigateDir2();", true);       
        //    string RName = txtNSearch.Text.ToString();
        //    Response.Redirect("LevelSFilter.aspx?RName=" + RName, true);
        //    txtNSearch.Text = string.Empty;          
        //}
        //else
        //{
        //    WebMsgBox.Show("Please enter minimum four characters");
        //    txtNSearch.Text = string.Empty;
        //}
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string url = "page2.aspx";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append("http://www.innovatussystems.com");
        sb.Append("');");
        sb.Append("</script>");


        Page.ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());
    }
    //protected void lnkHome_Click(object sender, EventArgs e)
    //{
    //    //Response.Redirect("AllMenus.aspx");
    //    Response.Redirect("Dashboard.aspx");
    //}
    protected void lbSignOut_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
    protected void masterquicklinks_ItemClick(object sender, RadMenuEventArgs e)
    {
        try
        {
            string result = "";

            if (e.Item.Text == "Residents")
            {

                result = CheckPermission("Profile");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("ResidentAdd.aspx", false);

                }

            }
            else if (e.Item.Text == "Living Alone")
            {
                result = CheckPermission("Profile");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("SAlone.aspx?Value1=2", false);

                }
            }
            else if (e.Item.Text == "Owners Away")
            {
                result = CheckPermission("Profile");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("OwnersAway.aspx", false);

                }
            }

            else if (e.Item.Text == "Vacant")
            {
                result = CheckPermission("Profile");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Vacants.aspx", false);

                }
            }

            else if (e.Item.Text == "Vacant")
            {
                result = CheckPermission("Profile");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Vacants.aspx", false);

                }
            }

            else if (e.Item.Text == "Staff & Others")
            {
                result = CheckPermission("Profile");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("StaffandOthers.aspx", false);

                }
            }
            else if (e.Item.Text == "Previous Tenants")
            {
                result = CheckPermission("Profile");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("PreviousTenants.aspx", false);

                }
            }

            else if (e.Item.Text == "Profile ++")
            {
                result = CheckPermission("Profile");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("ProfilePP.aspx", false);

                }
            }
            else if (e.Item.Text == "Dining")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodMenu.aspx", false);

                }
            }
            else if (e.Item.Text == "Menu Items")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodMenu.aspx?MenuName=Menu Items", false);

                }
            }
            else if (e.Item.Text == "Which Item When?")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodMenu.aspx?MenuName=Which Menu When?", false);

                }
            }
            else if (e.Item.Text == "How many diners?")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodMenu.aspx?MenuName=How many diners?", false);

                }
            }
            else if (e.Item.Text == "Menu for the Day")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodMenu.aspx?MenuName=Menu For Day", false);

                }
            }

            else if (e.Item.Text == "Booking A la carte menu")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodMenu.aspx?MenuName=Booking A la carte menu", false);

                }
            }
            else if (e.Item.Text == "A la Carte Booking List")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("AlacarteBookingList.aspx", false);

                }
            }
            else if (e.Item.Text == "A la Carte Booking Summary")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("AlacarteBookingSummary.aspx", false);

                }
            }

            else if (e.Item.Text == "Dining Report")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("DiningReport.aspx", false);

                }
            }

            else if (e.Item.Text == "Accept Payment")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Session["AcceptPayment"] = null;

                    Response.Redirect("FoodMenu.aspx?MenuName=Accept Payment", false);

                }
            }

            else if (e.Item.Text == "Diners Update")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodMenu.aspx?MenuName=Diners Update", false);

                }
            }

            else if (e.Item.Text == "Dining Transactions")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodMenu.aspx?MenuName=Dining Transactions", false);

                }
            }

            else if (e.Item.Text == "Help")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodMenu.aspx?MenuName=Help", false);

                }
            }
            else if (e.Item.Text == "Billing & Receipts")
            {
                result = CheckPermission("Accounts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TransactionLevelInd.aspx", false);

                }
            }
            else if (e.Item.Text == "Post Debits & Credits")
            {
                result = CheckPermission("Accounts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TransactionLevelInd.aspx", false);

                }
            }
            else if (e.Item.Text == "Bill Payment")
            {
                result = CheckPermission("Accounts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TransactionLevelInd.aspx", false);

                }
            }
            else if (e.Item.Text == "Bill Summary")
            {
                result = CheckPermission("Accounts");


                if ((result.ToString() == "Y"))
                {


                    Response.Redirect("BillSummary.aspx", false);

                }
            }
            else if (e.Item.Text == "Transactions")
            {
                result = CheckPermission("Accounts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TransactionLevelInd.aspx", false);

                }
            }
            else if (e.Item.Text == "Diary")
            {
                result = CheckPermission("Accounts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TransactionLevelInd.aspx", false);

                }
            }
            else if (e.Item.Text == "Summary")
            {
                result = CheckPermission("Accounts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("MonthlyBilling.aspx?MBVal=1", false);

                }
            }
            else if (e.Item.Text == "Group Billing")
            {
                result = CheckPermission("Accounts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FoodBillPosting.aspx", false);

                }
            }
            else if (e.Item.Text == "Care & Safety")
            {
                result = CheckPermission("Care");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("ExitEntry.aspx", false);

                }
            }
            else if (e.Item.Text == "Checkout Register")
            {
                result = CheckPermission("Care");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("CheckINOUT.aspx", false);

                }
            }
            else if (e.Item.Text == "Living Alone")
            {
                result = CheckPermission("Care");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("SAlone.aspx?Value=1", false);

                }
            }
            else if (e.Item.Text == "Birthdays in 7 days")
            {
                result = CheckPermission("Care");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("BirthdayGrid.aspx", false);

                }
            }
            else if (e.Item.Text == "Events")
            {
                result = CheckPermission("Care");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Events.aspx", false);

                }
            }
            //else if (e.Item.Text == "Daily Messages")
            //{
            //    result = CheckPermission("Care");


            //    if ((result.ToString() == "Y") )
            //    {
            //       // Response.Redirect("Events.aspx", false);

            //    }
            //}
            else if (e.Item.Text == "Help")
            {
                result = CheckPermission("Care");


                if ((result.ToString() == "Y"))
                {
                    // Response.Redirect("Events.aspx", false);

                }
            }
            else if (e.Item.Text == "Tasks & Events")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TaskList.aspx?Value1=3&Value2=-", false);

                }
            }

            else if (e.Item.Text == "Work Schedule Summary")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("ScheduleSummary.aspx", false);

                }
            }
            else if (e.Item.Text == "Services & Events")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("DayCalendar.aspx", false);

                }
            }
            else if (e.Item.Text == "New Service Request")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TaskList.aspx?Value1=3&Value2=-", false);

                }
            }
            else if (e.Item.Text == "View Service List")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TaskList.aspx?Value1=2&Value2=-", false);

                }
            }
            else if (e.Item.Text == "View Services Calendar")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("DayCalendar.aspx", false);

                }
            }
            else if (e.Item.Text == "Diary Link")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TransactionLevelInd.aspx", false);

                }
            }
            else if (e.Item.Text == "Events")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Events.aspx", false);

                }
            }

            else if (e.Item.Text == "Add Event")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Events.aspx?Type=AddEvent", false);

                }
            }
            else if (e.Item.Text == "On coming Event")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Events.aspx?Type=OncomingEvent", false);

                }
            }
            else if (e.Item.Text == "View Events List")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Events.aspx?Type=ViewEventsList", false);

                }
            }
            else if (e.Item.Text == "View Events Calendar")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("DayCalendar.aspx", false);

                }
            }


            else if (e.Item.Text == "Standard Tasks")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("WorkTasksMaster.aspx", false);

                }
            }

            else if (e.Item.Text == "Staff Master")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("WorkForceMaster.aspx", false);

                }
            }

            else if (e.Item.Text == "Work Schedule")
            {
                result = CheckPermission("Tasks");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("WorkSchedule.aspx", false);

                }
            }

            else if (e.Item.Text == "Reports")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("DailyFoodBillReport.aspx", false);

                }
            }
            else if (e.Item.Text == "Statement of Account")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("DailyFoodBillReport.aspx", false);

                }
            }

            else if (e.Item.Text == "Financial Transactions")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FinancialTransactions.aspx", false);

                }
            }
            else if (e.Item.Text == "Financial Transaction Summary")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("FinancialTransactionSummary.aspx", false);

                }
            }



            else if (e.Item.Text == "Monthly Statement")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("MailBilling.aspx", false);

                }
            }
            else if (e.Item.Text == "Billing Summary View")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("MonthlyBilling.aspx?MBVal=2", false);


                }
            }
            else if (e.Item.Text == "Billing History Per Resident")
            {
                result = CheckPermission("ReportsAndCharts");

                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("ResidentTxnSummary.aspx?RSVal=2", false);

                }
            }
            else if (e.Item.Text == "Charts")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Charts.aspx", false);

                }
            }
            else if (e.Item.Text == "Gentlemen/Ladies ratio")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Charts.aspx?Value=GLR", false);
                }
            }
            else if (e.Item.Text == "People per Residence")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Charts.aspx?Value=PPR", false);

                }
            }
            else if (e.Item.Text == "Owners & Tenants")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Charts.aspx?Value=OT", false);

                }
            }
            else if (e.Item.Text == "Owners Residing/Away")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Charts.aspx?Value=ORA", false);

                }
            }
            else if (e.Item.Text == "Age Distribution(Gents)")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Charts.aspx?Value=ADG", false);

                }
            }
            else if (e.Item.Text == "Age Distribution(Ladies)")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Charts.aspx?Value=ADL", false);

                }
            }

            else if (e.Item.Text == "Snap Shot")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("SnapShot.aspx", false);

                }
            }

            else if (e.Item.Text == "Settings")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Admin.aspx", false);

                }
            }
            else if (e.Item.Text == "Admin")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Admin.aspx", false);

                }
            }
            else if (e.Item.Text == "Profile ++ LookUp")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("AttribLkUpAdd.aspx", false);

                }
            }
            else if (e.Item.Text == "User Management")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("UserManagement.aspx", false);

                }
            }
            else if (e.Item.Text == "Villa Master")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("VillaMaster.aspx", false);

                }
            }

            else if (e.Item.Text == "Service Categories")
            {
                result = CheckPermission("Settings");

                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("ServiceConfigLkup.aspx", false);

                }
            }
            else if (e.Item.Text == "Service Types")
            {
                result = CheckPermission("Settings");

                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("ServiceConfig.aspx", false);

                }
            }



            else if (e.Item.Text == "Task List Lookup")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("TaskLkup.aspx", false);

                }
            }
            else if (e.Item.Text == "Assets")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("Assets.aspx", false);

                }
            }
            else if (e.Item.Text == "Food Items")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("RawMaterial.aspx", false);

                }
            }
            else if (e.Item.Text == "Food Ingredients")
            {
                result = CheckPermission("Kitchen");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("RMMenu.aspx", false);

                }
            }
            else if (e.Item.Text == "Sessions")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("SessionMaster.aspx", false);

                }
            }
            else if (e.Item.Text == "Diners Summary")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("DinerssummRep.aspx", false);

                }
            }
            else if (e.Item.Text == "Which day what menu")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("MenuItemReport.aspx", false);

                }
            }
            else if (e.Item.Text == "Ingredients Report")
            {
                result = CheckPermission("Settings");

                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("IngredientsRep.aspx", false);

                }
            }
            else if (e.Item.Text == "Department Lookup")
            {
                result = CheckPermission("Settings");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("DeptLkup.aspx", false);

                }
            }
            else if (e.Item.Text == "Menu for the day Report")
            {
                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("MenuItemPerday.aspx", false);

                }
            }

            if (e.Item.Text == "Recharge")
            {

                Session["PayUser"] = "Admin";
                Response.Redirect("PayDetails.aspx");

            }
            if (e.Item.Text == "Daily Usage Billing")
            {

                result = CheckPermission("ReportsAndCharts");


                if ((result.ToString() == "Y"))
                {
                    Response.Redirect("DailyUsageBilling.aspx", false);

                }

            }
        }
        catch (Exception ex)
        {
            // WebMsgBox.Show(ex.Message);
        }
    }

    private string CheckPermission(string modulename)
    {
        Permission p = new Permission();

        string result = p.GetPermission(Session["UserID"].ToString(), modulename.ToString());

        result = result.Trim();

        return result;

    }

    protected void Menu1_MenuItemDataBound(object sender, MenuEventArgs e)
    {
        try
        {

            //if (e.Item.Text != "")
            //{
            //    e.Item
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void lnkSnapshot_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("SnapShot.aspx", false);


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ImgCalendart_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("DayCalendar.aspx", false);


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
   
    protected void lnkControlPanel_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("ControlPanal.aspx");


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkvegPrice_Click(object sender, EventArgs e)
    {
        try
        {
            var url = "http://savegetables.com/products.php";
            //var url = "http://rates.goldenchennai.com/vegetable-price.php?a=3";
            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.open('");
            sb.Append(url);
            sb.Append("');");
            sb.Append("</script>");
            Page.ClientScript.RegisterStartupScript(this.GetType(),"script", sb.ToString());            
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void lnkSearch_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Response.Redirect("SearchMenu.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void lnkSearch_Click1(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("SearchMenu.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}
