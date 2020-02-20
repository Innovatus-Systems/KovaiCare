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
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;

public partial class FoodMenu : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();


    static int i = 0;

    public DataTable dt;
    decimal dlastOutStanding;

    protected void Page_Load(object sender, EventArgs e)
    {

        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;


        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }


        rwSpecialReport.VisibleOnPageLoad = true;
        rwSpecialReport.Visible = false;

        if (IsPostBack && ViewState["dt"] == null)
        {

            dt = new DataTable();
            dt.Columns.Add(new DataColumn("ItemCode", typeof(string)));
            dt.Columns.Add(new DataColumn("ItemName", typeof(string)));
            dt.Columns.Add(new DataColumn("Rate", typeof(decimal)));
            dt.Columns.Add(new DataColumn("Persons", typeof(Int32)));
            dt.Columns.Add(new DataColumn("Qty", typeof(Int32)));
            dt.Columns.Add(new DataColumn("Unit", typeof(string)));
            dt.Columns.Add(new DataColumn("AmounttoPay", typeof(decimal)));
            dt.Columns.Add(new DataColumn("From", typeof(string)));
            dt.Columns.Add(new DataColumn("To", typeof(string)));
            // dt.Columns.Add(new DataColumn("SessionCode", typeof(string)));
            // dt.Columns.Add(new DataColumn("Session", typeof(string)));

            rgBookingameal.DataSource = string.Empty;
            rgBookingameal.DataBind();


        }
        else
        {
            dt = (DataTable)ViewState["dt"];
        }


        if (!IsPostBack)
        {

            CheckPermission();
            CheckBillingType();

            dsDT = proc.ExecuteSP("GetServerDateTime");
            DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);

            dtpDCDate.SelectedDate = now.AddDays(1);
            dtpDMDate.SelectedDate = now.AddDays(1);

            dtpDCDate.MinDate = now.AddDays(1);
            dtpDCDate.MaxDate = now.AddDays(7);

            dtpDMDate.MinDate = now.AddDays(1);
            dtpDMDate.MaxDate = now.AddDays(7);

            // dtpfordate.MinDate = now.AddDays(1);

            //dtpDate.MaxDate = now.AddDays(1);

            //dtpDiners.MinDate = now;


            dtpmenuforday.MinDate = now.AddDays(1);
            // dtpmenuforday.MaxDate = now.AddDays(7);
            LoadGrid();
            LoadItem();
            LoadAlacarteMenus();
            LoadSession();
            LoadItemGroup();
            //LoadSessionforEdit();
            //LoadCategory();
            LoadWeekDay();
            LoadDCWeekDay();
            //LoadDoorNo();
            //LoadResident();
            LoadResidentDet();
            LoadBillingPeriod();

            LoadDCSession();

            //Item Master
            LoadUOM();
            //LoadItmCategory();
            LoadDailyMenu();

            LoadByDoorNo();
            LoadByOwner();

            LoadPayMode();

            //  GetMaxItemCode();

            dvDinersUpdate.Visible = false;

            btnDinersSave.Visible = false;
            btnDinersUpdate.Visible = false;

            // RadTabStrip1.SelectedIndex = 2;

            dtpDiners.SelectedDate = DateTime.Now;


            RadMultiPage1.SelectedIndex = 0;

            ddlDinersSession.SelectedValue = "10";

            ddlDinersSession_SelectedIndexChanged(null, null);

            //rdospecificdate.Checked = true;
            //dtpuntildate.Visible = false;
            //lbluntildate.Visible = false;



            if (Request.QueryString["MenuName"] != null)
            {
                string frmMenu = Request.QueryString["MenuName"].ToString();
                SelectedMenu(frmMenu);
            }

            //rgDinersTotal.DataSource = string.Empty;
            //rgDinersTotal.DataBind();

            rgFoodTransaction.DataSource = string.Empty;
            rgFoodTransaction.DataBind();

            rgSessionMenuForDay.DataSource = string.Empty;
            rgSessionMenuForDay.DataBind();



            ddlBMQuantiry.SelectedIndex = 1;
            ddlnoofpersons.SelectedIndex = 1;

            lblDiscount.Visible = false;

            dvWeekly.Visible = false;
            dvDaily.Visible = false;

            //LoadDiningBills();

            dtpfordate.SelectedDate = DateTime.Now;



        }

        rwHelp.VisibleOnPageLoad = true;
        rwHelp.Visible = false;

        rwDTHelp.VisibleOnPageLoad = true;
        rwDTHelp.Visible = false;

        rwMenuItems.VisibleOnPageLoad = true;
        rwMenuItems.Visible = false;

        LoadDayPlanner();
        LoadMenuDet();
        LoadItemList();
        LoadExpCount();

        panLoadMenufordays.Visible = false;


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


            cmbFTResident.DataSource = dsResident.Tables[0];
            cmbFTResident.DataValueField = "RTRSN";
            cmbFTResident.DataTextField = "RName";
            cmbFTResident.DataBind();

            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbResident.Items.Add(item2);
            cmbFTResident.Items.Add(item2);

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }



    private void CheckPermission()
    {
        try
        {

            if (Session["UserID"] != null)
            {

                Permission p = new Permission();

                string result = p.GetPermission(Session["UserID"].ToString(), "Kitchen");
                string result2 = p.GetPermission(Session["UserID"].ToString(), "Kitchen");

                result = result.Trim();
                result2 = result.Trim();

                if ((result.ToString() == "Y"))
                {

                    Session["UserPermission"] = result.ToString();
                    //Response.Redirect("ResidentAdd.aspx");
                }
                else
                {
                    Response.Redirect("Homemenu.aspx");
                    WebMsgBox.Show("You have not permission to view resident module");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void lbShowMenu_click(object sender, EventArgs e)
    {
        pnlMFirst.Visible = true;
        btnSave.Visible = true;
        btnUpdate.Visible = false;

    }

    //private void LoadResident()
    //{
    //    try
    //    {
    //        DataSet dsResident = sqlobj.ExecuteSP("SP_GetResidentNamesForDining");

    //        if (dsResident.Tables[0].Rows.Count > 0)
    //        {

    //            ddlTName.DataSource = dsResident.Tables[0];
    //            ddlTName.DataValueField = "RTRSN";
    //            ddlTName.DataTextField = "RTName";
    //            ddlTName.DataBind();
    //            ddlTName.Dispose();

    //        }

    //        ddlTName.Items.Insert(0, "All");

    //        dsResident.Dispose();

    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);
    //    }
    //}

    private void LoadBillingPeriod()
    {
        try
        {
            DataSet dsBillingPeriod = sqlobj.ExecuteSP("SP_GettingBillingPeriods");

            if (dsBillingPeriod.Tables[0].Rows.Count > 0)
            {
                ddlBillingMonth.DataSource = dsBillingPeriod.Tables[0];
                ddlBillingMonth.DataValueField = "BStatus";
                ddlBillingMonth.DataTextField = "BPName";
                ddlBillingMonth.DataBind();
                ddlBillingMonth.Dispose();

                ddlBillingMonth.SelectedValue = dsBillingPeriod.Tables[1].Rows[0]["BStatus"].ToString();

            }

            //ddlBillingMonth.Items.Insert(0, "--Select--");

            dsBillingPeriod.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    //private void LoadDoorNo()
    //{
    //    try
    //    {
    //        DataSet dsDoorNo = sqlobj.ExecuteSP("SP_GetVillaDoorNo");

    //        if (dsDoorNo.Tables[0].Rows.Count > 0)
    //        {
    //            ddlTDoorNo.DataSource = dsDoorNo.Tables[0];
    //            ddlTDoorNo.DataValueField = "RTRSN";
    //            ddlTDoorNo.DataTextField = "RTVillaNo";
    //            ddlTDoorNo.DataBind();
    //            ddlTDoorNo.Dispose();

    //        }

    //        ddlTDoorNo.Items.Insert(0, "All");

    //        dsDoorNo.Dispose();
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);
    //    }
    //}

    protected void LoadItem()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchAT = new DataSet();

            dsFetchAT = sqlobj.ExecuteSP("SP_FetchDropDown",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 });

            ddlItemCode.DataSource = dsFetchAT.Tables[0];
            ddlItemCode.DataValueField = "ItmCode";
            ddlItemCode.DataTextField = "Item";
            ddlItemCode.DataBind();
            ddlItemCode.Dispose();



            ddlItemCode.Items.Insert(0, "--Select--");



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadItemGroup()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchAT = new DataSet();

            dsFetchAT = sqlobj.ExecuteSP("SP_LoadGroup");

            if (dsFetchAT.Tables[0].Rows.Count > 0)
            {

                ddlitmType.DataSource = dsFetchAT.Tables[0];
                ddlitmType.DataValueField = "GroupName";
                ddlitmType.DataTextField = "GroupName";
                ddlitmType.DataBind();
                ddlitmType.Dispose();

            }

            dsFetchAT.Dispose();

            //ddlitmType.Items.Insert(0, "--Select--");



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    private void LoadByDoorNo()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_OwnerFetchDropDown",
                 new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 1 });
            //ddlByDoorNo.DataSource = dsFetchSE.Tables[0];
            //ddlByDoorNo.DataValueField = "RTRSN";
            //ddlByDoorNo.DataTextField = "Name";
            //ddlByDoorNo.DataBind();

            //ddlByDoorNo.Items.Insert(0, new ListItem("--Select--", "0"));
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

            dsFetchSE = sqlobj.ExecuteSP("SP_OwnerFetchDropDown",
                 new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 2 });
            //ddlByName.DataSource = dsFetchSE.Tables[0];
            //ddlByName.DataValueField = "RTRSN";
            //ddlByName.DataTextField = "Name";
            //ddlByName.DataBind();

            //ddlByName.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadSession()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_FetchDropDown",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 });
            ddlSession.DataSource = dsFetchSE.Tables[0];
            ddlSession.DataValueField = "SCode";
            ddlSession.DataTextField = "SName";
            ddlSession.DataBind();

            ddlDCSession.DataSource = dsFetchSE.Tables[0];
            ddlDCSession.DataValueField = "SCode";
            ddlDCSession.DataTextField = "SName";
            ddlDCSession.DataBind();
            dsFetchSE.Dispose();

            ddlDinersSession.DataSource = dsFetchSE.Tables[0];
            ddlDinersSession.DataValueField = "SCode";
            ddlDinersSession.DataTextField = "SName";
            ddlDinersSession.DataBind();
            ddlDinersSession.Dispose();

            ddlTSession.DataSource = dsFetchSE.Tables[0];
            ddlTSession.DataValueField = "SCode";
            ddlTSession.DataTextField = "SName";
            ddlTSession.DataBind();
            ddlTSession.Dispose();

            //ddlBMSession.DataSource = dsFetchSE.Tables[0];
            //ddlBMSession.DataValueField = "SCode";
            //ddlBMSession.DataTextField = "SName";
            //ddlBMSession.DataBind();
            //ddlBMSession.Dispose();

            ddlMISession.DataSource = dsFetchSE.Tables[0];
            ddlMISession.DataValueField = "SCode";
            ddlMISession.DataTextField = "SName";
            ddlMISession.DataBind();
            ddlMISession.Dispose();




            ddlDinersSession.Items.Insert(0, "--Select--");

            ddlDinersSession.Items.Insert(0, "All");

            //ddlBMSession.Items.Insert(0, "--Select--");

            ddlMISession.Items.Insert(0, "--Select--");

            ddlTSession.Items.Insert(0, "All");


            //ddlSession.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    //protected void LoadSessionforEdit()
    //{
    //    try
    //    {
    //        SqlProcsNew sqlobj = new SqlProcsNew();
    //        DataSet dsFetchET = new DataSet();

    //        dsFetchET = sqlobj.ExecuteSP("SP_FetchDropDown",
    //             new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 });
    //        ddlSessionET.DataSource = dsFetchET.Tables[0];
    //        ddlSessionET.DataValueField = "SCode";
    //        ddlSessionET.DataTextField = "SName";
    //        ddlSessionET.DataBind();

    //        //ddlSessionET.DataSource = dsFetchSE.Tables[0];
    //        //ddlSessionET.DataValueField = "SCode";
    //        //ddlDCSession.DataTextField = "SName";
    //        //ddlDCSession.DataBind();
    //        //dsFetchSE.Dispose();
    //        //ddlSession.Items.Insert(0, new ListItem("--Select--", "0"));

    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }
    //}

    protected void LoadCategory()
    {
        try
        {
            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Code");
            dt.Columns.Add("Text");
            DataRow drow = dt.NewRow();

            drow["Code"] = "Normal";
            drow["Text"] = "Normal";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Diabetic";
            drow["Text"] = "Diabetic";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Hypertension";
            drow["Text"] = "Hypertension";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "HeartDisease";
            drow["Text"] = "Heart Disease";
            dt.Rows.Add(drow);


            //ddlCategory.DataSource = dt;
            //ddlCategory.DataTextField = dt.Columns["Text"].ToString();
            //ddlCategory.DataValueField = dt.Columns["Code"].ToString();
            //ddlCategory.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    //protected void LoadDay()
    //{
    //    try
    //    {
    //        DataTable dt = new DataTable();
    //        dt.Clear();
    //        dt.Columns.Add("Code");
    //        dt.Columns.Add("Text");
    //        DataRow drow = dt.NewRow();

    //        drow["Code"] = "M";
    //        drow["Text"] = "Monday";
    //        dt.Rows.Add(drow);

    //        drow = dt.NewRow();
    //        drow["Code"] = "Tu";
    //        drow["Text"] = "Tuesday";
    //        dt.Rows.Add(drow);

    //        drow = dt.NewRow();
    //        drow["Code"] = "W";
    //        drow["Text"] = "Wednesday";
    //        dt.Rows.Add(drow);

    //        drow = dt.NewRow();
    //        drow["Code"] = "Th";
    //        drow["Text"] = "Thursday";
    //        dt.Rows.Add(drow);

    //        drow = dt.NewRow();
    //        drow["Code"] = "F";
    //        drow["Text"] = "Friday";
    //        dt.Rows.Add(drow);

    //        drow = dt.NewRow();
    //        drow["Code"] = "Sa";
    //        drow["Text"] = "Saturday";
    //        dt.Rows.Add(drow);

    //        drow = dt.NewRow();
    //        drow["Code"] = "Su";
    //        drow["Text"] = "Sunday";
    //        dt.Rows.Add(drow);

    //        drow = dt.NewRow();
    //        drow["Code"] = "Spl";
    //        drow["Text"] = "SplDay";
    //        dt.Rows.Add(drow);


    //        ddlDay.DataSource = dt;
    //        ddlDay.DataTextField = dt.Columns["Text"].ToString();
    //        ddlDay.DataValueField = dt.Columns["Code"].ToString();
    //        ddlDay.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }
    //}

    protected void ddlItemCode_Changed(object sender, EventArgs e)
    {

        try
        {

            string strcsession = ddlSession.SelectedItem.Text;
            string strcitem = ddlItemCode.SelectedItem.Text;

            if (strcitem == "--Select--")
            {
                WebMsgBox.Show("Please select menu item");
                return;
            }

            //  int index = strcitem.LastIndexOf(",");

            // string[] stritemsplit = new string[] { strcitem.Substring(0, index), strcitem.Substring(index + 1) };

            string[] stritemsplit = strcitem.Split(',');

            strcitem = stritemsplit[1].ToString();


            foreach (GridItem rw in rdgMenuList.Items)
            {
                string strsession = rw.Cells[4].Text;
                string stritem = rw.Cells[5].Text;


                if (strsession.Equals(strcsession))
                {
                    if (stritem.Equals(strcitem))
                    {
                        WebMsgBox.Show("Item " + stritem + " has been already assigned for session " + strsession);
                        break;
                    }

                }


            }


            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchItm = new DataSet();

            dsFetchItm = sqlobj.ExecuteSP("SP_FetchItmDet",
                 new SqlParameter() { ParameterName = "@ItmCode", SqlDbType = SqlDbType.NVarChar, Value = ddlItemCode.SelectedValue });

            txtItemName.Text = dsFetchItm.Tables[0].Rows[0]["ItmName"].ToString();
            txtUOM.Text = dsFetchItm.Tables[0].Rows[0]["ItmUOM"].ToString();
            txtCategory.Text = dsFetchItm.Tables[0].Rows[0]["Category"].ToString();
            txtType.Text = dsFetchItm.Tables[0].Rows[0]["Type"].ToString();
            txtItemRate.Text = dsFetchItm.Tables[0].Rows[0]["Rate"].ToString();
            txtContains.Text = dsFetchItm.Tables[0].Rows[0]["Remarks"].ToString();




        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            try
            {
                string strcitem = ddlItemCode.SelectedItem.Text;

                if (strcitem == "--Select--")
                {
                    WebMsgBox.Show("Please select menu item");
                    return;
                }



                sqlobj.ExecuteSP("SP_InsertMenu",
                    new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = ddlItemCode.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = txtItemName.Text.ToString() },
                    new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = txtUOM.Text.ToString() },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = txtCategory.Text.ToString() },
                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = txtType.Text.ToString() },
                    new SqlParameter() { ParameterName = "@ServQty", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(txtServeQty.Text.ToString()) },
                    new SqlParameter() { ParameterName = "@MDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@TuDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@WDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@ThDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@FDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@SaDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@SuDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@SplDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                    );

                ClearMenu();
                LoadMenuDet();

                //WebMsgBox.Show("Menu details saved");

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Menu details saved');", true);

            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());
            }
        }

    }

    protected void LoadMenuDet()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsMenu = null;
            dsMenu = sqlobj.ExecuteSP("SP_FetchMenuDet",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });
            rdgMenuList.DataSource = dsMenu.Tables[0];
            rdgMenuList.DataBind();
            dsMenu.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void lblDayCal_click(object sender, EventArgs e)
    {
        if (pnlDCFirst.Visible == true)
        {
            pnlDCFirst.Visible = false;
        }
        else
        {
            pnlDCFirst.Visible = true;
        }
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        pnlMFirst.Visible = false;
    }
    protected void btnDCClose_Click(object sender, EventArgs e)
    {
        pnlDCFirst.Visible = false;
    }

    protected void LoadWeekDay()
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        dsDT = proc.ExecuteSP("SP_FetchWeekDay",
                new SqlParameter() { ParameterName = "@WDay", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpDMDate.SelectedDate });
        lblWeekDay.Text = dsDT.Tables[0].Rows[0]["WeekDay"].ToString();
    }

    protected void LoadDCWeekDay()
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        dsDT = proc.ExecuteSP("SP_FetchWeekDay",
                new SqlParameter() { ParameterName = "@WDay", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpDCDate.SelectedDate });
        lblDCWeek.Text = dsDT.Tables[0].Rows[0]["WeekDay"].ToString();
    }

    protected void dtpDMDate_Changed(object sender, EventArgs e)
    {
        LoadWeekDay();
    }

    protected void dtpDCDate_Changed(object sender, EventArgs e)
    {
        //LoadDCWeekDay();



        LoadDCSession();

    }

    private void LoadDCSession()
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsFetchSE = new DataSet();

        dsFetchSE = sqlobj.ExecuteSP("SP_DayCalenderSessionFilter",
            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDCDate.SelectedDate.Value });
        ddlDCSession.DataSource = dsFetchSE.Tables[0];
        ddlDCSession.DataValueField = "SCode";
        ddlDCSession.DataTextField = "SName";
        ddlDCSession.DataBind();

        ddlDCSession.Items.Insert(0, "--Select--");


        dsFetchSE.Dispose();
    }

    protected void LoadDayCal()
    {
        try
        {

            //SqlProcsNew sqlobj = new SqlProcsNew();
            //DataSet dsDMenu = null;
            //dsDMenu = sqlobj.ExecuteSP("SP_FetchDayMenu",
            //    new SqlParameter() { ParameterName = "@WeekDay", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = lblWeekDay.Text.ToString() });
            //rdgDayMenu.DataSource = dsDMenu.Tables[0];
            //rdgDayMenu.DataBind();
            //dsDMenu.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }

    }

    protected void btnDCSave_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            try
            {
                string FSplDay;
                if (chkSplDay.Checked == true)
                {
                    FSplDay = "Y";
                }
                else
                {
                    FSplDay = "N";
                }




                sqlobj.ExecuteSP("SP_InsertDayCal",
                        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDCDate.SelectedDate },
                        new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = ddlDCSession.Text.ToString() },
                        new SqlParameter() { ParameterName = "@SplDay", SqlDbType = SqlDbType.NVarChar, Value = FSplDay },
                        new SqlParameter() { ParameterName = "@ExpCount", SqlDbType = SqlDbType.Int, Value = txtECount.Text.ToString() },
                        new SqlParameter() { ParameterName = "@StaffCount", SqlDbType = SqlDbType.Int, Value = txtstaff.Text.ToString() },
                        new SqlParameter() { ParameterName = "@GuestCount", SqlDbType = SqlDbType.Int, Value = txtGuests.Text.ToString() },
                        new SqlParameter() { ParameterName = "@TotalCount", SqlDbType = SqlDbType.Int, Value = txtTotal.Text.ToString() },
                        new SqlParameter() { ParameterName = "@Message", SqlDbType = SqlDbType.NVarChar, Value = txtMessage.Text.ToString() },
                        new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

                WebMsgBox.Show("Day Calendar details saved");
                LoadDayPlanner();
                LoadDailyMenu();
                ClearDCDet();
            }



            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());
            }
        }
    }

    protected void LoadDayPlanner()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsDC = null;
            dsDC = sqlobj.ExecuteSP("SP_FetchDCDet",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });
            rdgDCalendar.DataSource = dsDC.Tables[0];
            rdgDCalendar.DataBind();
            dsDC.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }


    protected void rdgDCalendar_ItemBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridFilteringItem)
        {
            GridFilteringItem filterItem = (GridFilteringItem)e.Item;

            filterItem["Date"].HorizontalAlign = HorizontalAlign.Center;
            filterItem["Session"].HorizontalAlign = HorizontalAlign.Left;
            filterItem["SplDay"].HorizontalAlign = HorizontalAlign.Center;
            filterItem["ExpCount"].HorizontalAlign = HorizontalAlign.Center;
            //filterItem["ActCount"].HorizontalAlign = HorizontalAlign.Center;
            filterItem["Message"].HorizontalAlign = HorizontalAlign.Left;

        }
    }

    protected void btnDCClear_Click(object sender, EventArgs e)
    {
        ClearDCDet();
    }

    protected void ClearDCDet()
    {
        LoadSession();
        chkSplDay.Checked = false;
        txtECount.Text = "";
        txtstaff.Text = "";
        txtGuests.Text = "";
        txtTotal.Text = "";
        txtMessage.Text = "";
        ddlDCSession.Focus();
    }

    protected void LoadExpCount()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsExpCnt = new DataSet();

            dsExpCnt = sqlobj.ExecuteSP("SP_General",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 17 });

            txtECount.Text = dsExpCnt.Tables[0].Rows[0]["ResCnt"].ToString();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadDailyMenu()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsDC = null;
            dsDC = sqlobj.ExecuteSP("SP_FetchDayMenu",
                new SqlParameter() { ParameterName = "@DMDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpDMDate.SelectedDate });
            rdgDayMenu.DataSource = dsDC.Tables[0];
            rdgDayMenu.DataBind();
            dsDC.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadUOM()
    {
        try
        {
            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Code");
            dt.Columns.Add("Text");
            DataRow drow = dt.NewRow();

            drow["Code"] = "Nos";
            drow["Text"] = "Nos";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Grms";
            drow["Text"] = "Grms";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Ml";
            drow["Text"] = "Ml";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "None";
            drow["Text"] = "None";
            dt.Rows.Add(drow);


            ddlUOM.DataSource = dt;
            ddlUOM.DataTextField = dt.Columns["Text"].ToString();
            ddlUOM.DataValueField = dt.Columns["Code"].ToString();
            ddlUOM.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadItmCategory()
    {
        try
        {
            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Code");
            dt.Columns.Add("Text");
            DataRow drow = dt.NewRow();

            drow["Code"] = "Normal";
            drow["Text"] = "Normal";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Diabetic";
            drow["Text"] = "Diabetic";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Special";
            drow["Text"] = "Special";
            dt.Rows.Add(drow);

            ddlitmCategory.DataSource = dt;
            ddlitmCategory.DataTextField = dt.Columns["Text"].ToString();
            ddlitmCategory.DataValueField = dt.Columns["Code"].ToString();
            ddlitmCategory.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadItemList()
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsMenu = null;
            dsMenu = sqlobj.ExecuteSP("SP_FetchItem",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });
            rdgItemList.DataSource = dsMenu.Tables[0];
            rdgItemList.DataBind();


            rgMenuItem.DataSource = dsMenu.Tables[0];
            rgMenuItem.DataBind();

            dsMenu.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
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

    protected void GetMaxItemCode()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsmaxcode = null;
            dsmaxcode = sqlobj.ExecuteSP("SP_MaxItemCode");

            if (dsmaxcode.Tables[0].Rows.Count > 0)
            {
                ItemCode.Text = dsmaxcode.Tables[0].Rows[0]["ItemCode"].ToString();
            }
            else
            {
                ItemCode.Text = "IT100";
            }

            dsmaxcode.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }

    protected void btnSaveItem_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            try
            {
                sqlobj.ExecuteSP("SP_InsertItem",
                    new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = ItemCode.Text.ToString() },
                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = ItemName.Text.ToString() },
                    new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = ddlUOM.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = ddlitmCategory.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlitmType.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Int, Value = txtQtyAlert.Text },
                    new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = txtLeadTime.Text },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = ddlMISession.SelectedValue },
                    new SqlParameter() { ParameterName = "@ServQty ", SqlDbType = SqlDbType.BigInt, Value = txtMIServeQty.Text },
                    new SqlParameter() { ParameterName = "@Rate", SqlDbType = SqlDbType.Decimal, Value = txtRate.Text },
                    new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text.ToString() },
                    new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });


                ItemCode.Text = string.Empty;
                ItemName.Text = string.Empty;
                txtRemarks.Text = String.Empty;
                txtQtyAlert.Text = string.Empty;
                txtLeadTime.Text = string.Empty;
                txtRate.Text = string.Empty;

                LoadItemList();
                LoadItem();
                GetMaxItemCode();


                //WebMsgBox.Show("New item added");

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('New item added');", true);

            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());
            }
        }
    }

    protected void LnkEditItemMaster_Click(object sender, EventArgs e)
    {

        try
        {

            LinkButton lnkEdititemBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdititemBtn.NamingContainer;
            string RSN;
            RSN = row.Cells[2].Text;
            ViewState["ItemRSN"] = RSN.ToString();
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsIT = null;

            dsIT = proc.ExecuteSP("SP_GetItem",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN });


            if (dsIT.Tables[0].Rows.Count > 0)
            {

                ItemCode.Text = dsIT.Tables[0].Rows[0]["ItemCode"].ToString();
                ItemName.Text = dsIT.Tables[0].Rows[0]["ItemName"].ToString();
                ddlUOM.Text = dsIT.Tables[0].Rows[0]["UOM"].ToString();
                ddlitmCategory.SelectedValue = dsIT.Tables[0].Rows[0]["Category"].ToString();
                string strserveqty = dsIT.Tables[0].Rows[0]["Session"].ToString();

                if (strserveqty != "")
                {
                    ddlMISession.SelectedValue = dsIT.Tables[0].Rows[0]["Session"].ToString();
                }


                txtMIServeQty.Text = dsIT.Tables[0].Rows[0]["ServeQty"].ToString();
                ddlitmType.SelectedValue = dsIT.Tables[0].Rows[0]["Type"].ToString();
                txtQtyAlert.Text = dsIT.Tables[0].Rows[0]["QtyAlert"].ToString();
                txtLeadTime.Text = dsIT.Tables[0].Rows[0]["LeadTime"].ToString();
                txtRate.Text = dsIT.Tables[0].Rows[0]["Rate"].ToString();
                txtRemarks.Text = dsIT.Tables[0].Rows[0]["Remarks"].ToString();


                btnUpteItm.Visible = true;
                btnSaveItm.Visible = false;

                pnlMenuItem.Visible = true;
            }


            dsIT.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    protected void btnUpteItm_Click(object sender, EventArgs e)
    {

        try
        {
            if (CnfResult.Value == "true")
            {

                sqlobj.ExecuteSP("SP_UpdateItem",
                    new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = ItemCode.Text.ToString() },
                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = ItemName.Text.ToString() },
                    new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = ddlUOM.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = ddlitmCategory.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlitmType.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Int, Value = txtQtyAlert.Text },
                    new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = txtLeadTime.Text },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = ddlMISession.SelectedValue },
                     new SqlParameter() { ParameterName = "@ServQty ", SqlDbType = SqlDbType.Decimal, Value = txtMIServeQty.Text },
                    new SqlParameter() { ParameterName = "@Rate", SqlDbType = SqlDbType.Decimal, Value = txtRate.Text },
                    new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text.ToString() },
                    new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = ViewState["ItemRSN"].ToString() }
                    );

                //WebMsgBox.Show("Existing item updated");

                ItemCode.Text = string.Empty;
                ItemName.Text = string.Empty;
                txtRemarks.Text = String.Empty;
                txtQtyAlert.Text = string.Empty;
                txtLeadTime.Text = string.Empty;
                txtRate.Text = string.Empty;
                txtstaff.Text = "";
                ddlMISession.SelectedIndex = 0;
                txtMIServeQty.Text = "";
                LoadItemList();
                GetMaxItemCode();

                btnSaveItm.Visible = true;
                btnUpteItm.Visible = false;

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Existing item updated');", true);


            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }

    }


    protected void lnkMenuItem_click(object sender, EventArgs e)
    {
        pnlMenuItem.Visible = true;
    }

    protected void btnCloseItm_Click(object sender, EventArgs e)
    {
        pnlMenuItem.Visible = false;
    }
    //protected void lnkbtnHelp_Click(object sender, EventArgs e)
    //{
    //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Function", "NavigateDir();", true);
    //}

    protected void rdgMonthBill_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridFilteringItem)
        {
            GridFilteringItem filterItem = (GridFilteringItem)e.Item;

            filterItem["Session"].HorizontalAlign = HorizontalAlign.Left;
            filterItem["TItemName"].HorizontalAlign = HorizontalAlign.Center;
            filterItem["TACount"].HorizontalAlign = HorizontalAlign.Center;
            filterItem["TUOM"].HorizontalAlign = HorizontalAlign.Right;
            filterItem["TotServeQty"].HorizontalAlign = HorizontalAlign.Right;
        }
    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {

        //if (HResult.Value == "true")
        //{

        foreach (GridItem rw in rdgDayMenu.Items)
        {
            DateTime MDate = Convert.ToDateTime(dtpDMDate.SelectedDate);
            string MSessionCode = rw.Cells[8].Text;
            string MItemCode = rw.Cells[9].Text;
            string MUOM = rw.Cells[6].Text;
            Decimal MSerQty = Convert.ToDecimal(rw.Cells[10].Text);
            int MCount = Convert.ToInt32(rw.Cells[5].Text);
            Decimal MEstQty = Convert.ToDecimal(rw.Cells[7].Text);

            //string MSessionName = rw.Cells[3].Text;
            //string MItemName = rw.Cells[4].Text;

            try
            {
                string Uname = Session["UserID"].ToString();
                CheckBox Check = (CheckBox)rw.FindControl("ChkConfirm");
                if (Check.Checked == true)
                {
                    SqlProcsNew sqlobj = new SqlProcsNew();
                    sqlobj.ExecuteSQLNonQuery("[SP_InsertDailyMenu]",
                        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = MDate },
                        new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = MSessionCode },
                        new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = MItemCode },
                        new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = MUOM },
                        new SqlParameter() { ParameterName = "@SerQty", SqlDbType = SqlDbType.Decimal, Value = MSerQty },
                        new SqlParameter() { ParameterName = "@Count", SqlDbType = SqlDbType.Int, Value = MCount },
                        new SqlParameter() { ParameterName = "@EstQty", SqlDbType = SqlDbType.Decimal, Value = MEstQty },
                        new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Uname });
                }
            }

            catch
            {

            }





            //DropDownList dlist = (DropDownList)rw.FindControl("ddlBillingCode");

            //int RTRSN = Convert.ToInt32(rw.Cells[3].Text);
            //RadNumericTextBox Bill = (RadNumericTextBox)rw.FindControl("TxtBillFor");
            //int Billfor = Convert.ToInt32(Bill.Text.ToString());
            //RadNumericTextBox Amount = (RadNumericTextBox)rw.FindControl("TxtAmnt");
            //RadNumericTextBox BRate = (RadNumericTextBox)rw.FindControl("TxtBillCodeRate");
            //Decimal BillingRate = Decimal.Parse(BRate.Text.ToString());
            //GridFooterItem footeritem = (GridFooterItem)FoodBillingListView.MasterTableView.GetItems(GridItemType.Footer)[0];
            //var Total = (RadNumericTextBox)footeritem.FindControl("lblTotalAmnt");
            //Decimal DailyTotal = Decimal.Parse(Total.Text.ToString());
            //Decimal TAmount = Decimal.Parse(Amount.Text.ToString());


            //try
            //{
            //    string Uname = Session["UserID"].ToString();

            //    CheckBox Check = (CheckBox)rw.FindControl("ChkConfirm");
            //    if (Check.Checked == true)
            //    {
            //        SqlProcsNew sqlobj = new SqlProcsNew();
            //        sqlobj.ExecuteSQLNonQuery("[SP_InsertFoodBillPostingDtls]",
            //                        new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
            //                           new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RTRSN },
            //                           new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = dlist.SelectedValue },
            //                           new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.Decimal, Value = BillingRate },
            //                           new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = BillingDate.SelectedDate.ToString() },
            //            //new SqlParameter() { ParameterName = "@BDate", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = DateTime.Now },
            //                            new SqlParameter() { ParameterName = "@Bcount", SqlDbType = SqlDbType.Int, Value = Billfor },
            //                              new SqlParameter() { ParameterName = "@BAmount", SqlDbType = SqlDbType.Decimal, Value = TAmount },
            //                                   new SqlParameter() { ParameterName = "@DTotAmount", SqlDbType = SqlDbType.Decimal, Value = DailyTotal },
            //                                   new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Uname }

            //                          );
            //    }
            //    else
            //    {

            //    }

            //}

            //catch (Exception ex)
            //{
            //    WebMsgBox.Show(ex.Message.ToString());

            //}
        }
        WebMsgBox.Show("Menu saved for the selected date");


        //}



        //else
        //{

        //}
    }


    private void LoadTitle(int id)
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = id.ToString() });


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

    private void SelectedMenu(string MenuName)
    {
        try
        {



            if (MenuName.ToString() == "Food Items")
            {
                Response.Redirect("RawMaterial.aspx");
            }
            if (MenuName.ToString() == "Food Ingredients")
            {
                Response.Redirect("RMMenu.aspx");
            }
            if (MenuName.ToString() == "Sessions")
            {
                Response.Redirect("SessionMaster.aspx");
            }

            if (MenuName.ToString() == "Which Menu When?")
            {

                LoadTitle(20);

                dvWhichItemWhen.Visible = true;
                dvDayPlanner.Visible = false;
                dvDailyMenu.Visible = false;
                dvMenuItems.Visible = false;
                dvMenuforday.Visible = false;
                dvHelp.Visible = false;
                dvDinersUpdates.Visible = false;
                dvDiningTransaction.Visible = false;
                dvBookingAlacartemenu.Visible = false;
                dvAcceptPayment.Visible = false;


            }
            else if (MenuName.ToString() == "How many diners?")
            {

                dvWhichItemWhen.Visible = false;
                dvDayPlanner.Visible = true;
                dvDailyMenu.Visible = false;
                dvMenuItems.Visible = false;
                dvMenuforday.Visible = false;
                dvHelp.Visible = false;
                dvDinersUpdates.Visible = false;
                dvDiningTransaction.Visible = false;
                dvBookingAlacartemenu.Visible = false;
                dvAcceptPayment.Visible = false;


            }
            else if (MenuName.ToString() == "Daily Menu")
            {

                dvWhichItemWhen.Visible = false;
                dvDayPlanner.Visible = false;
                dvDailyMenu.Visible = true;
                dvMenuItems.Visible = false;
                dvMenuforday.Visible = false;
                dvHelp.Visible = false;
                dvDinersUpdates.Visible = false;
                dvDiningTransaction.Visible = false;
                dvBookingAlacartemenu.Visible = false;
                dvAcceptPayment.Visible = false;


                GetMaxItemCode();

                btnUpteItm.Visible = false;
            }
            else if (MenuName.ToString() == "Menu Items")
            {

                LoadTitle(18);

                dvWhichItemWhen.Visible = false;
                dvDayPlanner.Visible = false;
                dvDailyMenu.Visible = false;
                dvMenuItems.Visible = true;
                dvMenuforday.Visible = false;
                dvHelp.Visible = false;
                dvDinersUpdates.Visible = false;
                dvDiningTransaction.Visible = false;
                dvBookingAlacartemenu.Visible = false;
                dvAcceptPayment.Visible = false;

                GetMaxItemCode();

                btnUpteItm.Visible = false;
            }
            else if (MenuName.ToString() == "Menu For Day")
            {
                LoadTitle(21);

                dvWhichItemWhen.Visible = false;
                dvDayPlanner.Visible = false;
                dvDailyMenu.Visible = false;
                dvMenuItems.Visible = false;
                dvMenuforday.Visible = true;
                dvHelp.Visible = false;
                dvDinersUpdates.Visible = false;
                dvDiningTransaction.Visible = false;
                dvBookingAlacartemenu.Visible = false;
                dvAcceptPayment.Visible = false;


                panNotSet.Visible = true;
                PanAddMenufordays.Visible = true;

                panSet.Visible = false;
                panEditMenufordays.Visible = false;

                rgEditMenuforday.DataSource = string.Empty;
                rgEditMenuforday.DataBind();


                //panLoadMenufordays.Visible = true;
                //PanAddMenufordays.Visible = false;
                //panEditMenufordays.Visible = false;

                LoadMenuforday();
            }
            else if (MenuName.ToString() == "Help")
            {
                dvWhichItemWhen.Visible = false;
                dvDayPlanner.Visible = false;
                dvDailyMenu.Visible = false;
                dvMenuItems.Visible = false;
                dvMenuforday.Visible = false;
                dvHelp.Visible = true;
                dvDinersUpdates.Visible = false;
                dvDiningTransaction.Visible = false;
                dvBookingAlacartemenu.Visible = false;
                dvAcceptPayment.Visible = false;


            }
            else if (MenuName.ToString() == "Booking A la carte menu")
            {

                LoadTitle(22);

                dvWhichItemWhen.Visible = false;
                dvDayPlanner.Visible = false;
                dvDailyMenu.Visible = false;
                dvMenuItems.Visible = false;
                dvMenuforday.Visible = false;
                dvHelp.Visible = false;
                dvDinersUpdates.Visible = false;
                dvDiningTransaction.Visible = false;
                dvBookingAlacartemenu.Visible = true;
                dvAcceptPayment.Visible = false;


            }
            else if (MenuName.ToString() == "Accept Payment")
            {
                LoadTitle(23);

                dvWhichItemWhen.Visible = false;
                dvDayPlanner.Visible = false;
                dvDailyMenu.Visible = false;
                dvMenuItems.Visible = false;
                dvMenuforday.Visible = false;
                dvHelp.Visible = false;
                dvDinersUpdates.Visible = false;
                dvDiningTransaction.Visible = false;
                dvBookingAlacartemenu.Visible = false;
                dvAcceptPayment.Visible = true;




                if (Session["AcceptPayment"] != null)
                {

                    DataSet dsgetoutstanding = sqlobj.ExecuteSP("SP_GetResidentOutStanding",
                           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["AcceptPayment"].ToString() });

                    if (dsgetoutstanding.Tables[0].Rows.Count > 0)
                    {
                        Session["RTRSN"] = Session["AcceptPayment"].ToString();

                        lblName.Text = dsgetoutstanding.Tables[0].Rows[0]["Name"].ToString() + ",";

                        lblDoorNO.Text = dsgetoutstanding.Tables[0].Rows[0]["DoorNo"].ToString() + ",";

                        lblMobileNo.Text = dsgetoutstanding.Tables[0].Rows[0]["sDescription"].ToString() + ",";

                        lblEmail.Text = dsgetoutstanding.Tables[0].Rows[0]["EMail"].ToString();

                        txtBillingPeriod.Text = Session["CurrentBillingPeriod"].ToString();
                        txtamountoutstanding.Text = dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString();
                    }

                }

            }
            else if (MenuName.ToString() == "Diners Update")
            {

                LoadTitle(24);

                dvWhichItemWhen.Visible = false;
                dvDayPlanner.Visible = false;
                dvDailyMenu.Visible = false;
                dvMenuItems.Visible = false;
                dvMenuforday.Visible = false;
                dvHelp.Visible = false;
                dvDinersUpdates.Visible = true;
                dvDiningTransaction.Visible = false;
                dvBookingAlacartemenu.Visible = false;
                dvAcceptPayment.Visible = false;



                dvDinersUpdate.Visible = false;
                btnDinersUpdate.Visible = false;

                dtpDiners.SelectedDate = DateTime.Now;

                CheckBillingType();
            }
            else if (MenuName.ToString() == "Dining Transactions")
            {

                LoadTitle(25);

                dvWhichItemWhen.Visible = false;
                dvDayPlanner.Visible = false;
                dvDailyMenu.Visible = false;
                dvMenuItems.Visible = false;
                dvMenuforday.Visible = false;
                dvHelp.Visible = false;
                dvDinersUpdates.Visible = false;
                dvDiningTransaction.Visible = true;
                dvAcceptPayment.Visible = false;
                dvBookingAlacartemenu.Visible = false;



            }



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void RMKPlanner_ItemClick(object sender, RadMenuEventArgs e)
    {


        RadTab T1, T2, T3, T4, T5, T6, T7, T8, T9, T10;
        T1 = RadTabStrip1.Tabs.FindTabByText("Which Menu When?");
        T2 = RadTabStrip1.Tabs.FindTabByText("How many diners?");
        T3 = RadTabStrip1.Tabs.FindTabByText("Daily Menu");
        T4 = RadTabStrip1.Tabs.FindTabByText("Menu Items");
        T5 = RadTabStrip1.Tabs.FindTabByText("Menu For Day");
        T6 = RadTabStrip1.Tabs.FindTabByText("Help");
        T7 = RadTabStrip1.Tabs.FindTabByText("Diners Update");
        T8 = RadTabStrip1.Tabs.FindTabByText("Dining Transactions");
        T9 = RadTabStrip1.Tabs.FindTabByText("Booking A la carte menu");
        T10 = RadTabStrip1.Tabs.FindTabByText("Accept Payment");


        if (e.Item.Text == "Food Items")
        {
            Response.Redirect("RawMaterial.aspx");
        }
        if (e.Item.Text == "Food Ingredients")
        {
            Response.Redirect("RMMenu.aspx");
        }
        if (e.Item.Text == "Sessions")
        {
            Response.Redirect("SessionMaster.aspx");
        }


        if (e.Item.Text == "Which Item When?")
        {
            T1.Visible = true;
            T2.Visible = false;
            T3.Visible = false;
            T4.Visible = false;
            T5.Visible = false;
            T6.Visible = false;
            T7.Visible = false;
            T8.Visible = false;
            T9.Visible = false;
            T10.Visible = false;

            T1.PageView.Selected = true;
        }

        else if (e.Item.Text == "How many diners?")
        {
            T1.Visible = false;
            T2.Visible = true;
            T3.Visible = false;
            T4.Visible = false;
            T5.Visible = false;
            T6.Visible = false;
            T7.Visible = false;
            T8.Visible = false;
            T9.Visible = false;
            T10.Visible = false;

            T2.PageView.Selected = true;
        }
        else if (e.Item.Text == "Daily Menu")
        {
            T1.Visible = false;
            T2.Visible = false;
            T3.Visible = true;
            T4.Visible = false;
            T5.Visible = false;
            T6.Visible = false;
            T7.Visible = false;
            T8.Visible = false;
            T9.Visible = false;
            T10.Visible = false;

            T3.PageView.Selected = true;
        }
        else if (e.Item.Text == "Menu Items")
        {
            T1.Visible = false;
            T2.Visible = false;
            T3.Visible = false;
            T4.Visible = true;
            T5.Visible = false;
            T6.Visible = false;
            T7.Visible = false;
            T8.Visible = false;
            T9.Visible = false;
            T10.Visible = false;

            T4.PageView.Selected = true;
            GetMaxItemCode();

            btnUpteItm.Visible = false;
        }
        else if (e.Item.Text == "Menu for the day")
        {
            T1.Visible = false;
            T2.Visible = false;
            T3.Visible = false;
            T4.Visible = false;
            T5.Visible = true;
            T7.Visible = false;
            T6.Visible = false;
            T8.Visible = false;
            T9.Visible = false;
            T10.Visible = false;

            T5.PageView.Selected = true;




            panNotSet.Visible = true;
            PanAddMenufordays.Visible = true;


            panEditMenufordays.Visible = false;
            panSet.Visible = false;

            rgEditMenuforday.DataSource = string.Empty;
            rgEditMenuforday.DataBind();

            //panLoadMenufordays.Visible = true;
            //PanAddMenufordays.Visible = false;
            // panEditMenufordays.Visible = false;

            LoadMenuforday();



        }
        else if (e.Item.Text == "Help")
        {
            T1.Visible = false;
            T2.Visible = false;
            T3.Visible = false;
            T4.Visible = false;
            T5.Visible = false;
            T6.Visible = true;
            T7.Visible = false;
            T8.Visible = false;
            T9.Visible = false;
            T10.Visible = false;

            T6.PageView.Selected = true;
        }

        else if (e.Item.Text == "Booking A la carte menu")
        {
            T1.Visible = false;
            T2.Visible = false;
            T3.Visible = false;
            T4.Visible = false;
            T5.Visible = false;
            T6.Visible = false;
            T7.Visible = false;
            T8.Visible = false;
            T9.Visible = true;
            T10.Visible = false;

            T9.PageView.Selected = true;


        }
        else if (e.Item.Text == "Accept Payment")
        {
            T1.Visible = false;
            T2.Visible = false;
            T3.Visible = false;
            T4.Visible = false;
            T5.Visible = false;
            T6.Visible = false;
            T7.Visible = false;
            T8.Visible = false;
            T9.Visible = false;
            T10.Visible = true;

            T10.PageView.Selected = true;


        }
        else if (e.Item.Text == "Diners Update")
        {
            T1.Visible = false;
            T2.Visible = false;
            T3.Visible = false;
            T4.Visible = false;
            T5.Visible = false;
            T6.Visible = false;
            T7.Visible = true;
            T8.Visible = false;
            T9.Visible = false;
            T10.Visible = false;

            T7.PageView.Selected = true;

            dvDinersUpdate.Visible = false;
            btnDinersUpdate.Visible = false;

            dtpDiners.SelectedDate = DateTime.Now;

            CheckBillingType();
        }
        else if (e.Item.Text == "Dining Transactions")
        {
            T1.Visible = false;
            T2.Visible = false;
            T3.Visible = false;
            T4.Visible = false;
            T5.Visible = false;
            T6.Visible = false;
            T7.Visible = false;
            T8.Visible = true;
            T9.Visible = false;
            T10.Visible = false;

            T8.PageView.Selected = true;
        }


    }

    private void CheckBillingType()
    {
        try
        {

            string strtype = "";

            DataSet dsDT = sqlobj.ExecuteSP("SP_BillingType");

            if (dsDT.Tables[0].Rows.Count > 0)
            {
                strtype = dsDT.Tables[0].Rows[0]["BillingType"].ToString();

                Session["MenuBillingType"] = strtype.ToString();
            }

            dsDT.Dispose();


            if (strtype.ToString() == "M")
            {
                lblmenubasedmsg.Text = "Sorry!  Billing is A la carte (Menu ) based for this residential community.   Hence Session based Booking is not permitted. ";

                rgDiners.Visible = false;

                lnkviewall.Visible = true;

                lnkviewall.Text = " + View all";

                lnkviewall.Enabled = false;

                btnDinersUpdate.Visible = false;
                btnDinersClose.Visible = false;
                btnDinersHelp.Visible = false;
                btnDinersExporttoExcel.Visible = false;
                lblallow.Text = "";



            }
            else
            {
                rgDiners.Visible = false;

                lnkviewall.Visible = true;

                lnkviewall.Text = " + View all";

                lblmenubasedmsg.Text = "";

                lblallow.Text = "";
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }



    protected void rdgDayMenu_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadDailyMenu();
    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        if ((rdgDCalendar.Visible == true) && (rdgDCalendar.Items.Count > 0))
        {
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;

            dsDT = proc.ExecuteSP("GetServerDateTime");
            string CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");
            string FileName = "DayPlanner_" + CDate;

            rdgDCalendar.ExportSettings.ExportOnlyData = true;
            rdgDCalendar.ExportSettings.FileName = FileName;
            rdgDCalendar.ExportSettings.IgnorePaging = true;
            rdgDCalendar.ExportSettings.OpenInNewWindow = true;
            rdgDCalendar.MasterTableView.ExportToExcel();

        }
        else
        {
            WebMsgBox.Show("There are no records to Export");
        }
    }
    protected void rdgMenuList_ItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                if (item["Category"].Text != "Normal")
                {
                    //item.Cells[8].BackColor = System.Drawing.Color.Yellow;



                }
                else
                {

                }
            }
            catch (GridException ex) { }

        }

    }

    //protected void ddlItemCodeET_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}

    //protected void btnSaveET_Click(object sender, EventArgs e)
    //{

    //}
    //protected void btnCloseET_Click(object sender, EventArgs e)
    //{

    //}
    protected void LnkEditItem_Click(object sender, EventArgs e)
    {
        try
        {

            pnlMFirst.Visible = true;
            btnUpdate.Visible = true;
            btnSave.Visible = false;
            LinkButton lnkEdititemBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdititemBtn.NamingContainer;
            string RSN;
            RSN = row.Cells[3].Text;
            ViewState["MenuRSN"] = RSN.ToString();
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;

            dsDT = proc.ExecuteSP("SP_FectchMenuDetforEdit",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN });
            ddlSession.SelectedValue = dsDT.Tables[0].Rows[0]["SessionCode"].ToString();
            ddlItemCode.SelectedValue = dsDT.Tables[0].Rows[0]["ItemCode"].ToString();
            txtItemName.Text = dsDT.Tables[0].Rows[0]["ItemName"].ToString();
            txtUOM.Text = dsDT.Tables[0].Rows[0]["UOM"].ToString();
            txtCategory.Text = dsDT.Tables[0].Rows[0]["Category"].ToString();
            txtType.Text = dsDT.Tables[0].Rows[0]["Type"].ToString();
            txtServeQty.Text = dsDT.Tables[0].Rows[0]["ServeQty"].ToString();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

        //if (CMonday == "Y")
        //{
        //    chkMonday.Checked = true;
        //}
        //else { chkMonday.Checked = false; }
        //if (CTuesday == "Y")
        //{ chkTuesday.Checked = true; }
        //else { chkTuesday.Checked = false; }

        //if (CWednesday == "Y")
        //{
        //    chkWednesday.Checked = true;
        //}
        //else { chkWednesday.Checked = false; }
        //if (CThursday == "Y")
        //{ chkThursday.Checked = true; }
        //else { chkThursday.Checked = false; }


        //if (CFriday == "Y")
        //{
        //    chkFriday.Checked = true;
        //}
        //else { chkFriday.Checked = false; }
        //if (CSaturday == "Y")
        //{ chkSaturday.Checked = true; }
        //else { chkSaturday.Checked = false; }


        //if (CSunday == "Y")
        //{
        //    chkSunday.Checked = true;
        //}
        //else { chkSunday.Checked = false; }
        //if (CSpl == "Y")
        //{ chkSpl.Checked = true; }
        //else { chkSpl.Checked = false; }



    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            string strcitem = ddlItemCode.SelectedItem.Text;

            if (strcitem == "--Select--")
            {
                WebMsgBox.Show("Please select menu item");
                return;
            }



            SqlProcsNew sqlobj = new SqlProcsNew();
            sqlobj.ExecuteSQLNonQuery("[SP_UpdateMenu]",
                    new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = ddlItemCode.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = txtItemName.Text.ToString() },
                    new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = txtUOM.Text.ToString() },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = txtCategory.Text.ToString() },
                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = txtType.Text.ToString() },
                    new SqlParameter() { ParameterName = "@ServQty", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(txtServeQty.Text.ToString()) },
                    new SqlParameter() { ParameterName = "@MDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@TuDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@WDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@ThDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@FDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@SaDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@SuDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@SplDay", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                    new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = ViewState["MenuRSN"].ToString() }
                    );


            ClearMenu();
            LoadMenuDet();

            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Menu details updated');", true);

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }


    }

    private void ClearMenu()
    {
        btnUpdate.Visible = false;
        btnSave.Visible = true;

        ddlItemCode.SelectedIndex = 0;
        ddlSession.SelectedIndex = 0;
        txtItemName.Text = "";
        txtCategory.Text = "";
        txtType.Text = "";
        txtUOM.Text = "";
        txtServeQty.Text = "";
        //chkMonday.Checked = false;
        //chkTuesday.Checked = false;
        //chkWednesday.Checked = false;
        //chkThursday.Checked = false;
        //chkFriday.Checked = false;
        //chkSaturday.Checked = false;
        //chkSunday.Checked = false;
        //chkSplDay.Checked = false;
        pnlMFirst.Visible = false;
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ddlItemCode.SelectedIndex = 0;
        ddlSession.SelectedIndex = 0;
        txtItemName.Text = "";
        txtCategory.Text = "";
        txtUOM.Text = "";
        txtServeQty.Text = "";
        txtItemRate.Text = "";
        txtContains.Text = "";
        //chkMonday.Checked = false;
        //chkTuesday.Checked = false;
        //chkWednesday.Checked = false;
        //chkThursday.Checked = false;
        //chkFriday.Checked = false;
        //chkSaturday.Checked = false;
        //chkSunday.Checked = false;
        chkSplDay.Checked = false;




    }
    protected void rdgDCalendar_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadDayPlanner();
    }
    protected void rdgItemList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadItemList();
    }
    protected void btnClearItm_Click(object sender, EventArgs e)
    {
        ItemCode.Text = string.Empty;
        ItemName.Text = string.Empty;
        txtRemarks.Text = string.Empty;
        txtQtyAlert.Text = string.Empty;
        txtLeadTime.Text = string.Empty;
        ddlUOM.SelectedIndex = 0;
        ddlitmCategory.SelectedIndex = 0;
        ddlitmType.SelectedIndex = 0;
        GetMaxItemCode();
    }


    private void LoadMenuItems(string sessioncode)
    {
        i = 0;

        if (dtpmenuforday.SelectedDate != null)
        {


            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsmenuitem = null;
            dsmenuitem = sqlobj.ExecuteSP("SP_GetMenuItemSessionWise",
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = sessioncode.ToString() }

                    );


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {
                rgMenuforday.DataSource = dsmenuitem;
                rgMenuforday.DataBind();
                rgMenuforday.Dispose();
            }
            else
            {

                rgMenuforday.DataSource = dsmenuitem;
                rgMenuforday.DataBind();
                rgMenuforday.Dispose();
            }

        }
        else
        {
            WebMsgBox.Show("Please select the date");
        }
    }

    private void LoadEditMenuItems()
    {

    }


    private void LoadDate(string sessioncode)
    {

        try
        {

            DateTime getday = Convert.ToDateTime(dtpmenuforday.SelectedDate);

            string selectedday = getday.ToString("dddd");

            var startDate = getday;
            var first = new DateTime(startDate.Year, startDate.Month, 1);
            List<DateTime> weekends = new List<DateTime>();
            for (int i = 0; i <= DateTime.DaysInMonth(startDate.Year, startDate.Month); i++)
            {
                var nextDay = first.AddDays(i);

                string sday = nextDay.DayOfWeek.ToString();

                if (sday.Equals(selectedday))
                {

                    DateTime ddate = Convert.ToDateTime(nextDay);

                    string sgdate = getday.ToString("dd/MM/yyyy");
                    string ggdate = ddate.ToString("dd/MM/yyyy");

                    if (!sgdate.Equals(ggdate))
                    {

                        if (ddate > getday)
                        {

                            SqlProcsNew obj = new SqlProcsNew();

                            DataSet dscheck = obj.ExecuteSP("SP_CheckMenuDate",
                            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = ddate },
                            new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.Int, Value = sessioncode.ToString() }
                            );



                            if (dscheck.Tables[0].Rows.Count == 0)
                            {


                                if (dtpMenuforday1.SelectedDate == null)
                                {
                                    dtpMenuforday1.SelectedDate = ddate;
                                }
                                else if (dtpmenuforday2.SelectedDate == null)
                                {
                                    dtpmenuforday2.SelectedDate = ddate;
                                }
                                else if (dtpMenuforday3.SelectedDate == null)
                                {
                                    dtpMenuforday3.SelectedDate = ddate;
                                }
                                else if (dtpmenuforday4.SelectedDate == null)
                                {
                                    dtpmenuforday4.SelectedDate = ddate;
                                }


                            }

                            dscheck.Dispose();


                        }
                    }

                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void menufordayclear()
    {
        //dtpmenuforday.SelectedDate = null;


        rgSessionMenuForDay.DataSource = string.Empty;
        rgSessionMenuForDay.DataBind();


        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsFetchSE = new DataSet();

        dsFetchSE = sqlobj.ExecuteSP("SP_FetchDropDown",
             new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 });




        chkMenuforday1.Checked = false;
        chkMenuforday2.Checked = false;
        chkmenuforday3.Checked = false;
        chkmenuforday4.Checked = false;

        dtpMenuforday1.SelectedDate = null;
        dtpmenuforday2.SelectedDate = null;
        dtpMenuforday3.SelectedDate = null;
        dtpmenuforday4.SelectedDate = null;


        LoadMenuStatus();



        rgMenuforday.DataSource = string.Empty;
        rgMenuforday.DataBind();



    }
    protected void btnmenufordayclear_Click(object sender, EventArgs e)
    {
        try
        {

            menufordayclear();

            lblATotalDiners.Text = "";
            lblAMainItem.Text = "";
            lblASubItem.Text = "";

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgMenuforday_ItemCreated(object sender, GridItemEventArgs e)
    {
        //if (e.Item is GridHeaderItem)
        //{
        //    if (e.Item.DataItem is DataRowView)
        //    {
        //        GridHeaderItem hItem = (GridHeaderItem)e.Item;
        //        CheckBox chk1 = (CheckBox)hItem.FindControl("ChkConfirm");
        //        HiddenField2.Value = chk1.ClientID.ToString();
        //    }
        //}
    }
    protected void btnmenufordaysave_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                int count = 0;

                foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
                {
                    if (item.Selected)
                    {
                        count = count + 1;
                    }
                }

                string cdate = dtpmenuforday.SelectedDate.Value.ToString("dd-MMM-yyyy");

                if (count > 0)
                {

                    foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
                    {
                        if (item.Selected)
                        {



                            TextBox lblrownumber = (TextBox)item.FindControl("txtRowNumber");
                            LinkButton lnkitemname = (LinkButton)item.FindControl("lnkitemname");


                            SqlProcsNew sqlobj = new SqlProcsNew();

                            string strSNo = lblrownumber.Text;
                            string strItem = lnkitemname.Text;
                            string strCategory = item["Category"].Text.ToString();
                            string strUom = item["Uom"].Text.ToString();
                            string strType = item["Type"].Text.ToString();
                            string strFoodType = item["FoodType"].Text.ToString();
                            int iDiners = Convert.ToInt32(item["Diners"].Text.ToString());
                            double dUsualQty = Convert.ToDouble(item["UsualQty"].Text.ToString());
                            double dTotalQty = Convert.ToDouble(item["TotalQty"].Text.ToString());
                            double dQtyAlert = Convert.ToDouble(item["QtyAlert"].Text.ToString());
                            int iLeadTime = Convert.ToInt32(item["LeadTime"].Text.ToString());

                            string stritemcode = "";


                            DataSet dsGetItemCode = sqlobj.ExecuteSP("SP_GetItemCode",
                                       new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() });

                            if (dsGetItemCode.Tables[0].Rows.Count > 0)
                            {
                                stritemcode = dsGetItemCode.Tables[0].Rows[0][0].ToString();

                            }

                            dsGetItemCode.Dispose();


                            sqlobj.ExecuteSQLNonQuery("SP_InsertMenuforday",
                                    new SqlParameter() { ParameterName = "@SNo", SqlDbType = SqlDbType.Int, Value = strSNo.ToString() },
                                    new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = stritemcode.ToString() },
                                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() },
                                    new SqlParameter() { ParameterName = "@Uom", SqlDbType = SqlDbType.NVarChar, Value = strUom.ToString() },
                                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strType.ToString() },
                                    new SqlParameter() { ParameterName = "@FoodType", SqlDbType = SqlDbType.NVarChar, Value = strFoodType.ToString() },
                                    new SqlParameter() { ParameterName = "@Diners", SqlDbType = SqlDbType.Int, Value = iDiners },
                                    new SqlParameter() { ParameterName = "@UsualQty", SqlDbType = SqlDbType.Decimal, Value = dUsualQty },
                                    new SqlParameter() { ParameterName = "@TotalQty", SqlDbType = SqlDbType.Decimal, Value = dTotalQty },
                                    new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Decimal, Value = dQtyAlert },
                                    new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = iLeadTime },
                                    new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strCategory.ToString() },
                                    new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                                    new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                    );

                        }
                    }



                    if (chkCopyType.SelectedValue == "1")
                    {

                        if (chkMenuforday1.Checked == true && dtpMenuforday1.SelectedDate != null)
                        {
                            InsertMenu(Convert.ToDateTime(dtpMenuforday1.SelectedDate));

                            cdate = cdate + "," + dtpMenuforday1.SelectedDate.Value.ToString("dd-MMM-yyyy");
                        }
                        if (chkMenuforday2.Checked == true && dtpmenuforday2.SelectedDate != null)
                        {
                            InsertMenu(Convert.ToDateTime(dtpmenuforday2.SelectedDate));

                            cdate = cdate + "," + dtpmenuforday2.SelectedDate.Value.ToString("dd-MMM-yyyy");
                        }
                        if (chkmenuforday3.Checked == true && dtpMenuforday3.SelectedDate != null)
                        {
                            InsertMenu(Convert.ToDateTime(dtpMenuforday3.SelectedDate));

                            cdate = cdate + "," + dtpMenuforday3.SelectedDate.Value.ToString("dd-MMM-yyyy");
                        }


                        if (chkmenuforday4.Checked == true && dtpmenuforday4.SelectedDate != null)
                        {
                            InsertMenu(Convert.ToDateTime(dtpmenuforday4.SelectedDate));
                            cdate = cdate + "," + dtpmenuforday4.SelectedDate.Value.ToString("dd-MMM-yyyy");
                        }
                    }

                    else if (chkCopyType.SelectedValue == "2")
                    {

                        if (dtpCopyFrom.SelectedDate != null && dtpCopyTo.SelectedDate != null)
                        {
                            InsertMenuDaily(dtpCopyFrom.SelectedDate.Value, dtpCopyTo.SelectedDate.Value);

                            cdate = Session["cdate"].ToString();
                        }


                    }

                    string strsession = Session["SessionCode"].ToString();

                    LoadMenuforday();
                    LoadMenuStatus();
                    menufordayclear();


                    string strConfirm = "Menu items are inserted for the date on " + cdate.ToString() + " (" + strsession.ToString() + ")";

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + strConfirm + "');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Select atleast one item to save menu for day details.');", true);

                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void InsertMenuDaily(DateTime startdate, DateTime enddate)
    {
        try
        {
            foreach (DateTime date in GetDateRange(startdate, enddate))
            {
                foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
                {
                    if (item.Selected)
                    {

                        TextBox lblrownumber = (TextBox)item.FindControl("txtRowNumber");


                        string strSNo = lblrownumber.Text;
                        string strItem = item["ItemName"].Text.ToString();
                        string strCategory = item["Category"].Text.ToString();
                        string strUom = item["Uom"].Text.ToString();
                        string strType = item["Type"].Text.ToString();
                        string strFoodType = item["FoodType"].Text.ToString();
                        int iDiners = Convert.ToInt32(item["Diners"].Text.ToString());
                        double dUsualQty = Convert.ToDouble(item["UsualQty"].Text.ToString());
                        double dTotalQty = Convert.ToDouble(item["TotalQty"].Text.ToString());
                        double dQtyAlert = Convert.ToDouble(item["QtyAlert"].Text.ToString());
                        int iLeadTime = Convert.ToInt32(item["LeadTime"].Text.ToString());

                        SqlProcsNew sqlobj = new SqlProcsNew();

                        sqlobj.ExecuteSQLNonQuery("SP_InsertMenuforday",
                                new SqlParameter() { ParameterName = "@SNo", SqlDbType = SqlDbType.Int, Value = strSNo.ToString() },
                                new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() },
                                new SqlParameter() { ParameterName = "@Uom", SqlDbType = SqlDbType.NVarChar, Value = strUom.ToString() },
                                new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strType.ToString() },
                                new SqlParameter() { ParameterName = "@FoodType", SqlDbType = SqlDbType.NVarChar, Value = strFoodType.ToString() },
                                new SqlParameter() { ParameterName = "@Diners", SqlDbType = SqlDbType.Int, Value = iDiners },
                                new SqlParameter() { ParameterName = "@UsualQty", SqlDbType = SqlDbType.Decimal, Value = dUsualQty },
                                new SqlParameter() { ParameterName = "@TotalQty", SqlDbType = SqlDbType.Decimal, Value = dTotalQty },
                                new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Decimal, Value = dQtyAlert },
                                new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = iLeadTime },
                                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                                new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strCategory.ToString() },
                                new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = date },
                                new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                );

                        Session["cdate"] = dtpmenuforday.SelectedDate.Value.ToString("dd-MMM-yyyy");

                        if (Session["cdate"] == null)
                        {
                            Session["cdate"] = date.ToString("dd-MMM-yyyy");
                        }
                        else
                        {
                            Session["cdate"] = Session["cdate"] + "," + date.ToString("dd-MMM-yyyy");
                        }

                    }
                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void InsertMenu(DateTime menudate)
    {
        try
        {
            foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
            {
                if (item.Selected)
                {

                    TextBox lblrownumber = (TextBox)item.FindControl("txtRowNumber");


                    string strSNo = lblrownumber.Text;
                    string strItem = item["ItemName"].Text.ToString();
                    string strCategory = item["Category"].Text.ToString();
                    string strUom = item["Uom"].Text.ToString();
                    string strType = item["Type"].Text.ToString();
                    string strFoodType = item["FoodType"].Text.ToString();
                    int iDiners = Convert.ToInt32(item["Diners"].Text.ToString());
                    double dUsualQty = Convert.ToDouble(item["UsualQty"].Text.ToString());
                    double dTotalQty = Convert.ToDouble(item["TotalQty"].Text.ToString());
                    double dQtyAlert = Convert.ToDouble(item["QtyAlert"].Text.ToString());
                    int iLeadTime = Convert.ToInt32(item["LeadTime"].Text.ToString());

                    SqlProcsNew sqlobj = new SqlProcsNew();



                    sqlobj.ExecuteSQLNonQuery("SP_InsertMenuforday",
                            new SqlParameter() { ParameterName = "@SNo", SqlDbType = SqlDbType.Int, Value = strSNo.ToString() },
                            new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() },
                            new SqlParameter() { ParameterName = "@Uom", SqlDbType = SqlDbType.NVarChar, Value = strUom.ToString() },
                            new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strType.ToString() },
                            new SqlParameter() { ParameterName = "@FoodType", SqlDbType = SqlDbType.NVarChar, Value = strFoodType.ToString() },
                            new SqlParameter() { ParameterName = "@Diners", SqlDbType = SqlDbType.Int, Value = iDiners },
                            new SqlParameter() { ParameterName = "@UsualQty", SqlDbType = SqlDbType.Decimal, Value = dUsualQty },
                            new SqlParameter() { ParameterName = "@TotalQty", SqlDbType = SqlDbType.Decimal, Value = dTotalQty },
                            new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Decimal, Value = dQtyAlert },
                            new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = iLeadTime },
                            new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                            new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strCategory.ToString() },
                            new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = menudate },
                            new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                            );


                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void rgMenuforday_ItemDataBound(object sender, GridItemEventArgs e)
    {


        if (e.Item is GridDataItem)
        {

            // -- set serial No

            int strIndex = rgMenuforday.MasterTableView.CurrentPageIndex;

            TextBox txtrno = e.Item.FindControl("txtRowNumber") as TextBox;

            i = i + 5;

            txtrno.Text = i.ToString();


            // -- set total qty text color

            int idiners = Convert.ToInt32(e.Item.Cells[8].Text);
            double dTotalQty = Convert.ToDouble(e.Item.Cells[9].Text);
            double dQtyAlert = Convert.ToDouble(e.Item.Cells[11].Text);



            if (idiners != 0)
            {
                if (dQtyAlert < dTotalQty)
                {
                    e.Item.Cells[11].ForeColor = Color.Red;
                }
            }



        }
    }

    public void LoadGrid()
    {

        rgMenuforday.DataSource = string.Empty;
    }


    protected void txtGuests_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(txtGuests.Text) && !string.IsNullOrEmpty(txtstaff.Text) && !string.IsNullOrEmpty(txtECount.Text))
                txtTotal.Text = (Convert.ToInt32(txtGuests.Text) + Convert.ToInt32(txtstaff.Text) + Convert.ToInt32(txtECount.Text)).ToString();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void txtstaff_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(txtGuests.Text) && !string.IsNullOrEmpty(txtstaff.Text) && !string.IsNullOrEmpty(txtECount.Text))
                txtTotal.Text = (Convert.ToInt32(txtGuests.Text) + Convert.ToInt32(txtstaff.Text) + Convert.ToInt32(txtECount.Text)).ToString();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgMenuforday_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        rgMenuforday.CurrentPageIndex = e.NewPageIndex;
        // LoadMenuItems();
    }
    protected void lnkmenuforday_Click(object sender, EventArgs e)
    {
        try
        {
            panLoadMenufordays.Visible = false;
            PanAddMenufordays.Visible = true;
            panEditMenufordays.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadMenuforday()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsmenuitem = null;
            dsmenuitem = sqlobj.ExecuteSP("SP_LoadMenuForDay");


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {
                rgLoadMenuforday.DataSource = dsmenuitem;
                rgLoadMenuforday.DataBind();
                rgLoadMenuforday.Dispose();
            }
            else
            {

                rgLoadMenuforday.DataSource = string.Empty;
                rgLoadMenuforday.DataBind();

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LnkEditMenuforday_Click(object sender, EventArgs e)
    {
        try
        {

            LinkButton lnk = sender as LinkButton;

            GridDataItem item = lnk.NamingContainer as GridDataItem;

            DateTime date = Convert.ToDateTime(item.GetDataKeyValue("filterdate").ToString());
            string strSession = item.GetDataKeyValue("sessioncode").ToString();

            LoadEditMenufordayItems(date, strSession);


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadEditMenufordayItems(DateTime date, string session)
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsmenuitem = null;
            DataSet dsGetmenuitem = null;


            // --- Load from which item when -- //

            dsmenuitem = sqlobj.ExecuteSP("SP_GetMenuItemSessionWise",
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = date },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = session }
                    );


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {
                rgEditMenuforday.DataSource = dsmenuitem;
                rgEditMenuforday.DataBind();
                rgEditMenuforday.Dispose();

                // panLoadMenufordays.Visible = false;
                PanAddMenufordays.Visible = false;
                panEditMenufordays.Visible = true;

                //dtpUMenuforday.SelectedDate = date;
                //ddlEditMenuforday.SelectedValue = session.ToString();
            }
            else
            {
                rgEditMenuforday.DataSource = string.Empty;
                rgEditMenuforday.DataBind();

            }


            dsmenuitem.Dispose();

            //-- Load from menuforday table -- //

            dsGetmenuitem = sqlobj.ExecuteSP("SP_GetMenuForDay",
                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = date },
                   new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = session }
                   );


            if (dsGetmenuitem.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dsGetmenuitem.Tables[0].Rows.Count; i++)
                {

                    string strItemName = dsGetmenuitem.Tables[0].Rows[i]["ItemName"].ToString();

                    foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
                    {

                        LinkButton lnkitemname = (LinkButton)item.FindControl("lnkitemname");

                        string strGetItemName = lnkitemname.Text;

                        // string strGetItemName = item.Cells[4].Text;

                        if (strGetItemName.Equals(strItemName))
                        {
                            item.Selected = true;

                            TextBox txtbox = (TextBox)item.FindControl("txtRowNumber");

                            txtbox.Text = dsGetmenuitem.Tables[0].Rows[i]["SNo"].ToString();
                        }

                    }

                }
            }
            else
            {
                rgEditMenuforday.DataSource = string.Empty;

            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnUpdateMenuforday_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                int count = 0;

                foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
                {
                    if (item.Selected)
                    {
                        count = count + 1;
                    }
                }

                if (count > 0)
                {


                    SqlProcsNew sqlobj = new SqlProcsNew();

                    //-- Delete Existing Menu --//

                    sqlobj.ExecuteSQLNonQuery("SP_DeleteMenuForDay",
                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate },
                   new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() }
                   );


                    // -- Insert New Menu -- //





                    foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
                    {
                        if (item.Selected)
                        {

                            TextBox lblrownumber = (TextBox)item.FindControl("txtRowNumber");
                            LinkButton lnkitemname = (LinkButton)item.FindControl("lnkitemname");


                            string strSNo = lblrownumber.Text;
                            string strItem = lnkitemname.Text;
                            string strCategory = item["Category"].Text.ToString();
                            string strUom = item["Uom"].Text.ToString();
                            string strType = item["Type"].Text.ToString();
                            string strFoodType = item["FoodType"].Text.ToString();
                            int iDiners = Convert.ToInt32(item["Diners"].Text.ToString());
                            double dUsualQty = Convert.ToDouble(item["UsualQty"].Text.ToString());
                            double dTotalQty = Convert.ToDouble(item["TotalQty"].Text.ToString());
                            double dQtyAlert = Convert.ToDouble(item["QtyAlert"].Text.ToString());
                            int iLeadTime = Convert.ToInt32(item["LeadTime"].Text.ToString());


                            string stritemcode = "";


                            DataSet dsGetItemCode = sqlobj.ExecuteSP("SP_GetItemCode",
                                       new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() });

                            if (dsGetItemCode.Tables[0].Rows.Count > 0)
                            {
                                stritemcode = dsGetItemCode.Tables[0].Rows[0][0].ToString();

                            }

                            dsGetItemCode.Dispose();



                            sqlobj.ExecuteSQLNonQuery("SP_InsertMenuforday",
                                    new SqlParameter() { ParameterName = "@SNo", SqlDbType = SqlDbType.Int, Value = strSNo.ToString() },
                                     new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = stritemcode.ToString() },
                                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() },
                                    new SqlParameter() { ParameterName = "@Uom", SqlDbType = SqlDbType.NVarChar, Value = strUom.ToString() },
                                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strType.ToString() },
                                    new SqlParameter() { ParameterName = "@FoodType", SqlDbType = SqlDbType.NVarChar, Value = strFoodType.ToString() },
                                    new SqlParameter() { ParameterName = "@Diners", SqlDbType = SqlDbType.Int, Value = iDiners },
                                    new SqlParameter() { ParameterName = "@UsualQty", SqlDbType = SqlDbType.Decimal, Value = dUsualQty },
                                    new SqlParameter() { ParameterName = "@TotalQty", SqlDbType = SqlDbType.Decimal, Value = dTotalQty },
                                    new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Decimal, Value = dQtyAlert },
                                    new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = iLeadTime },
                                    new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strCategory.ToString() },
                                    new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                                    new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                    );

                        }
                    }

                    string dtpEditMenuforday = dtpmenuforday.SelectedDate.Value.ToString("dd-MMM-yyyy");
                    string strsession = Session["SessionCode"].ToString();

                    //menufordayclear();

                    //panLoadMenufordays.Visible = true;
                    PanAddMenufordays.Visible = false;

                    rgEditMenuforday.DataSource = string.Empty;
                    rgEditMenuforday.DataBind();



                    string stralert = "Menu items are updated for the date on " + dtpEditMenuforday.ToString() + " (" + strsession.ToString() + ")";

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + stralert + "');", true);

                }
                else
                {

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select atleast one item update the menu for day details.');", true);
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnCloseMenuforday_Click(object sender, EventArgs e)
    {
        try
        {
            //panLoadMenufordays.Visible = true;
            //PanAddMenufordays.Visible = false;
            //panEditMenufordays.Visible = false;

            dtpmenuforday.SelectedDate = null;


            rgSessionMenuForDay.DataSource = string.Empty;
            rgSessionMenuForDay.DataBind();

            rgEditMenuforday.DataSource = string.Empty;
            rgEditMenuforday.DataBind();

            lblTotalDiners.Text = "";
            lblMainItem.Text = "";
            lblSubItem.Text = "";

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgLoadMenuforday_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridFilteringItem)
            {
                GridFilteringItem filterItem = (GridFilteringItem)e.Item;

                filterItem["menudate"].HorizontalAlign = HorizontalAlign.Center;


            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void dtpmenuforday_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            LoadMenuStatus();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadMenuStatus()
    {

        try
        {

            DataSet dsFetchSE = sqlobj.ExecuteSP("SP_Menuforday",
                      new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value });


            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {
                rgSessionMenuForDay.DataSource = dsFetchSE;
                rgSessionMenuForDay.DataBind();


            }
            else
            {
                rgSessionMenuForDay.DataSource = string.Empty;
                rgSessionMenuForDay.DataBind();


            }


            dsFetchSE.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnmenufordayclose_Click(object sender, EventArgs e)
    {
        try
        {

            dtpmenuforday.SelectedDate = null;

            rgSessionMenuForDay.DataSource = string.Empty;
            rgSessionMenuForDay.DataBind();

            // panLoadMenufordays.Visible = true;
            PanAddMenufordays.Visible = false;
            panEditMenufordays.Visible = false;

            rgMenuforday.DataSource = string.Empty;
            rgMenuforday.DataBind();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void HiddenButton_Click(object sender, EventArgs e)
    {
        try
        {
            string FSplDay;
            if (chkSplDay.Checked == true)
            {
                FSplDay = "Y";
            }
            else
            {
                FSplDay = "N";
            }

            sqlobj.ExecuteSP("SP_InsertDayCal",
                                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDCDate.SelectedDate },
                                new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = ddlDCSession.Text.ToString() },
                                new SqlParameter() { ParameterName = "@SplDay", SqlDbType = SqlDbType.NVarChar, Value = FSplDay },
                                new SqlParameter() { ParameterName = "@ExpCount", SqlDbType = SqlDbType.Int, Value = txtECount.Text.ToString() },
                                new SqlParameter() { ParameterName = "@StaffCount", SqlDbType = SqlDbType.Int, Value = txtstaff.Text.ToString() },
                                new SqlParameter() { ParameterName = "@GuestCount", SqlDbType = SqlDbType.Int, Value = txtGuests.Text.ToString() },
                                new SqlParameter() { ParameterName = "@TotalCount", SqlDbType = SqlDbType.Int, Value = txtTotal.Text.ToString() },
                                new SqlParameter() { ParameterName = "@Message", SqlDbType = SqlDbType.NVarChar, Value = txtMessage.Text.ToString() },
                                new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

            WebMsgBox.Show("Day Calendar details saved");
            LoadDayPlanner();
            LoadDailyMenu();
            ClearDCDet();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void rbNotSet_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            panNotSet.Visible = true;
            PanAddMenufordays.Visible = true;
            panSet.Visible = false;
            panEditMenufordays.Visible = false;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rbSet_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            panNotSet.Visible = false;
            PanAddMenufordays.Visible = false;
            panSet.Visible = true;
            panEditMenufordays.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    protected void btnmenufordayexporttoexcel_Click(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsmenuitem = null;


            DateTime cdate = dtpmenuforday.SelectedDate.Value;

            dsmenuitem = sqlobj.ExecuteSP("SP_GetMenufordayExporttoExcel",
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() }

                    );


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsmenuitem.Tables[0];
                dg.DataBind();

                // THE EXCEL FILE.
                string sFileName = "Menuforday-" + cdate.ToString("dd-MM-yyyy") + " - " + Session["SessionName"].ToString() + ".xls";
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


                Response.Write("<table><tr><td>MenuForDay</td><td>Menu Date:" + cdate.ToString("dd-MM-yyyy") + "</td><td>Session:" + Session["SessionName"].ToString() + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show("" + dtpmenuforday.SelectedDate.Value + "-" + Session["SessionName"].ToString() + " Menu does not exist");
            }

        }
        catch (Exception ex)
        {
            //WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadDinerspersessiondetailsTotal()
    {
        try
        {

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
                lblsessionandtime.Text = ddlDinersSession.SelectedItem.Text + " - From:" + dsdinersTotal.Tables[1].Rows[0]["FromTime"].ToString() + " Till:" + dsdinersTotal.Tables[1].Rows[0]["TillTime"].ToString();
            }

            if (dsdinersTotal.Tables[2].Rows.Count > 0)
            {
                rgDinersRate.DataSource = dsdinersTotal.Tables[2];
                rgDinersRate.DataBind();

            }
            else
            {
                rgDinersRate.DataSource = string.Empty;
                rgDinersRate.DataBind();
            }


            rgDinersTotal.Dispose();
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

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsdiners = null;

            //dsdiners.Clear();


            DateTime cdate = dtpDiners.SelectedDate.Value;

            DateTime currenttime = DateTime.Now;


            LoadDinerspersessiondetailsTotal();

            //DataSet dsdinersTotal = sqlobj.ExecuteSP("SP_DinersPerSessionTotal",
            //        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
            //        new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }

            //        );


            //if (dsdinersTotal.Tables[0].Rows.Count >0 )
            //{
            //    rgDinersTotal.DataSource = dsdinersTotal.Tables[0];
            //    rgDinersTotal.DataBind();

            //}
            //else
            //{
            //    rgDinersTotal.DataSource = string.Empty;
            //    rgDinersTotal.DataBind();
            //}

            //if (dsdinersTotal.Tables[1].Rows.Count > 0)
            //{
            //    lblsessionandtime.Text = ddlDinersSession.SelectedItem.Text + " - From:" + dsdinersTotal.Tables[1].Rows[0]["FromTime"].ToString() + " Till:" +  dsdinersTotal.Tables[1].Rows[0]["TillTime"].ToString();  
            //}


            //rgDinersTotal.Dispose();


            dsdiners = sqlobj.ExecuteSP("SP_SelectDiners",
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


            if (dsdiners.Tables[4].Rows.Count > 0)
            {


                btnDinersSave.Visible = false;
                btnDinersUpdate.Visible = true;
                dvDinersUpdate.Visible = true;

                //chkAll.Checked = true;


                //chkByDoorNo.Checked = false;
                //chkByName.Checked = false;

                // lnkmsg.Text = "You are now updating the count of actual diners and guests  for a session.";

            }


            if (dsdiners.Tables[4].Rows.Count > 0)
            {
                rgDiners.DataSource = dsdiners.Tables[4];
                rgDiners.DataBind();
            }
            else
            {
                rgDiners.DataSource = string.Empty;
                rgDiners.DataBind();
            }

            dsdiners.Clear();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadDinersGrid()
    {
        try
        {
            rgDiners.DataSource = string.Empty;
            rgDiners.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void ClearDiners()
    {
        try
        {
            dtpDiners.SelectedDate = DateTime.Now;
            ddlDinersSession.SelectedIndex = 0;

            //ddlByDoorNo.SelectedIndex = 0;
            //ddlByName.SelectedIndex = 0; 

            dvDinersUpdate.Visible = false;
            btnDinersUpdate.Visible = false;
            btnDinersSave.Visible = false;

            rgDiners.DataSource = string.Empty;
            rgDiners.DataBind();

            // lnkmsg.Text = "";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void btnDinersSave_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {


                foreach (GridDataItem item in rgDiners.MasterTableView.Items)
                {

                    TextBox txtBooked = (TextBox)item.FindControl("txtBooked");
                    TextBox txtActual = (TextBox)item.FindControl("txtActual");
                    TextBox txtGuestBooked = (TextBox)item.FindControl("txtGuestBooked");
                    TextBox txtGuestActual = (TextBox)item.FindControl("txtGuestActual");
                    TextBox txtTotal = (TextBox)item.FindControl("txtTotal");
                    TextBox txtTotalActual = (TextBox)item.FindControl("txtTotalActual");
                    TextBox txtHSBooked = (TextBox)item.FindControl("txtHSBooked");
                    TextBox txtHSActual = (TextBox)item.FindControl("txtHSActual");

                    string strDoorNo = item["DoorNo"].Text.ToString();
                    string strName = item["Name"].Text.ToString();


                    sqlobj.ExecuteSP("SP_InsertDiners",
                                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                                   new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                                   new SqlParameter() { ParameterName = "@SessionName", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedItem.Text },
                                   new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = strDoorNo.ToString() },
                                   new SqlParameter() { ParameterName = "@Name", SqlDbType = SqlDbType.NVarChar, Value = strName.ToString() },
                                   new SqlParameter() { ParameterName = "@Booked", SqlDbType = SqlDbType.Int, Value = txtBooked.Text },
                                   new SqlParameter() { ParameterName = "@Actual", SqlDbType = SqlDbType.Int, Value = txtActual.Text },
                                   new SqlParameter() { ParameterName = "@GuestBooked", SqlDbType = SqlDbType.Int, Value = txtGuestBooked.Text },
                                   new SqlParameter() { ParameterName = "@GuestActual", SqlDbType = SqlDbType.Int, Value = txtGuestActual.Text },
                                   new SqlParameter() { ParameterName = "@Total", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(txtBooked.Text) + Convert.ToInt32(txtGuestBooked.Text) },
                                   new SqlParameter() { ParameterName = "@TotalActual", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(txtActual.Text) + Convert.ToInt32(txtGuestActual.Text) },
                                   new SqlParameter() { ParameterName = "@HomeServiceBooked", SqlDbType = SqlDbType.Int, Value = txtHSBooked.Text },
                                   new SqlParameter() { ParameterName = "@HomeServiceActual", SqlDbType = SqlDbType.Int, Value = txtHSActual.Text },
                                   new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                   );



                }

                DateTime cdate = dtpDiners.SelectedDate.Value;
                string strSession = ddlDinersSession.SelectedItem.Text;

                ClearDiners();


                WebMsgBox.Show("Diners count details saved on " + cdate.ToString("dd-MMM-yyyy") + " - " + strSession.ToString());

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void btnDinersUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {

                DataSet dsDiningRSN = sqlobj.ExecuteSP("SP_GetDiningRSN",
                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                   new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = Session["RTRSN"].ToString() }
                   );


                Int32 irsn = 0;
                if (dsDiningRSN.Tables[0].Rows.Count > 0)
                {
                    irsn = Convert.ToInt32(dsDiningRSN.Tables[0].Rows[0]["RSN"].ToString());
                }


                // Get check Existing BillNo  

                string strbillno = "";

                DataSet dsBillNo = sqlobj.ExecuteSP("SP_CheckBillNo",
                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = irsn.ToString() });


                if (dsBillNo.Tables[0].Rows.Count > 0)
                {
                    strbillno = dsBillNo.Tables[0].Rows[0]["BillNo"].ToString();
                }


                dsBillNo.Dispose();



                if (strbillno.ToString() == "")
                {



                    sqlobj.ExecuteSP("SP_UpdateDiners",
                                   new SqlParameter() { ParameterName = "@Booked", SqlDbType = SqlDbType.Int, Value = ddlRegular.SelectedValue },
                                   new SqlParameter() { ParameterName = "@Actual", SqlDbType = SqlDbType.Int, Value = ddlRegularA.SelectedValue },
                                   new SqlParameter() { ParameterName = "@GuestBooked", SqlDbType = SqlDbType.Int, Value = ddlGuest.SelectedValue },
                                   new SqlParameter() { ParameterName = "@GuestActual", SqlDbType = SqlDbType.Int, Value = ddlGuestA.SelectedValue },
                                   new SqlParameter() { ParameterName = "@Total", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(ddlRegular.SelectedValue) + Convert.ToInt32(ddlGuest.SelectedValue) },
                                   new SqlParameter() { ParameterName = "@TotalActual", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(ddlRegularA.SelectedValue) + Convert.ToInt32(ddlGuestA.SelectedValue) },
                                   new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = "" },
                                   new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                                   new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = irsn },
                                   new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.BigInt, Value = Session["UMode"].ToString() }
                                   );




                    if (ddlRegularA.Enabled == true && ddlGuestA.Enabled == true)
                    {

                        // Insert New Transaction start


                        // Get Rate Start

                        decimal dRegularRate = 0;
                        decimal dGuestRate = 0;
                        decimal dTotalRate = 0;
                        decimal ddisper = 0;

                        DataSet dsGetRate = sqlobj.ExecuteSP("SP_GetSessionRate",
                        new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue });


                        if (dsGetRate.Tables[0].Rows.Count > 0)
                        {
                            dRegularRate = Convert.ToDecimal(dsGetRate.Tables[0].Rows[0]["RegularRate"].ToString());
                            dGuestRate = Convert.ToDecimal(dsGetRate.Tables[0].Rows[0]["GuestRate"].ToString());

                            // Get Status start

                            DataSet dsgetoutstanding = sqlobj.ExecuteSP("SP_GetResidentOutStanding",
                              new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["RTRSN"].ToString() });

                            if (dsgetoutstanding.Tables[0].Rows.Count > 0)
                            {

                                lblName.Text = dsgetoutstanding.Tables[0].Rows[0]["Name"].ToString() + ",";

                                string strname = dsgetoutstanding.Tables[0].Rows[0]["Name"].ToString();
                                string strStatus = dsgetoutstanding.Tables[0].Rows[0]["Status"].ToString();


                                if (strname.ToString() == "Non Residing Staff" || strStatus.ToString() == "RS" || strStatus.ToString() == "TS")
                                {


                                    DataSet dsdiscount = sqlobj.ExecuteSP("sp_getstaffdiscount");




                                    if (dsdiscount.Tables[0].Rows.Count > 0)
                                    {

                                        decimal ddiscount = Convert.ToDecimal(dsdiscount.Tables[0].Rows[0]["stafdiscountpcnt"].ToString());

                                        Session["dper"] = ddiscount.ToString();

                                        dTotalRate = (Convert.ToDecimal(ddlRegularA.SelectedValue) * dRegularRate) + (Convert.ToDecimal(ddlGuestA.SelectedValue) * dGuestRate);

                                        decimal drate = (dTotalRate) * (Convert.ToDecimal(Session["dper"].ToString()) / 100);
                                        dTotalRate = (dTotalRate) - drate;


                                    }
                                }

                                else
                                {

                                    dTotalRate = (Convert.ToDecimal(ddlRegularA.SelectedValue) * dRegularRate) + (Convert.ToDecimal(ddlGuestA.SelectedValue) * dGuestRate);
                                }

                                // Get Status End


                            }





                        }


                        // Get Rate End

                        DateTime bdate = DateTime.Now;

                        string strday = bdate.ToString("dd");
                        string strmonth = bdate.ToString("MM");
                        string stryear = bdate.ToString("yyyy");
                        string strhour = bdate.ToString("HH");
                        string strmin = bdate.ToString("mm");
                        string strsec = bdate.ToString("ss");

                        string strBillNo = "D" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();


                        sqlobj.ExecuteSP("SP_InsertTransaction",
                                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                                        new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "DINING" },
                                        new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "DINING" },
                                        new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                        new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = "UnBilled" },
                                        new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = dTotalRate.ToString() },
                                        new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                                        new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = dTotalRate.ToString() },
                                        new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                        new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                                        new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = "Session Bill" },
                                        new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                        new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                        new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() }
                                        );


                        // Update BillNo to RTRSN start


                        DataSet dsupdatebillno = sqlobj.ExecuteSP("SP_UpdateBillNo",
                            new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NChar, Value = strBillNo.ToString() },
                            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = irsn.ToString() }
                            );




                        // // Update BillNo to RTRSN end



                        decimal dlastdebit = 0;
                        decimal dlastcredit = 0;

                        DataSet dsgetdebitcredittoal = null;
                        dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = Session["RTRSN"].ToString() });

                        if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
                        {
                            dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
                            dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
                            dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());
                        }

                        sqlobj.ExecuteNonQuery("SP_UpdateClosingBalance",
                            new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                            new SqlParameter() { ParameterName = "@Closing", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding });


                        sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                            new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
                            new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
                            new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
                            new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                            new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
                            new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });

                    }

                    // Insert New Transaction End


                    DateTime cdate = dtpDiners.SelectedDate.Value;
                    string strSession = ddlDinersSession.SelectedItem.Text;

                    //ClearDiners();

                    //LoadDinerspersessiondetailsTotal();

                    ddlDinersSession_SelectedIndexChanged(null, null);

                    string confirmmsg = "Diners count details updated on " + cdate.ToString("dd-MMM-yyyy") + " - " + strSession.ToString();

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + confirmmsg + "');", true);


                    //WebMsgBox.Show("Diners count details updated on " + cdate.ToString("dd-MMM-yyyy") + " - " + strSession.ToString()); 
                    //}


                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Bill already raised. do not allow to update the actual');", true);
                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnDinersClose_Click(object sender, EventArgs e)
    {
        try
        {
            ClearDiners();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void rgDiners_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {


            if (Session["DiningStatus"] != null)
            {

                string strStatus = Session["DiningStatus"].ToString();

                //GridDataItem item = (GridDataItem)e.Item;

                if (e.Item is GridDataItem)
                {
                    GridDataItem item = (GridDataItem)e.Item;

                    //RadNumericTextBox txtRegularB = (RadNumericTextBox)item["Booked"].FindControl("txtBooked");

                    TextBox txtRegularB = (TextBox)item["Booked"].FindControl("txtBooked");
                    TextBox txtRegularA = (TextBox)item["Actual"].FindControl("txtActual");
                    TextBox txtCasualB = (TextBox)item["CasualB"].FindControl("txtCasualBooked");
                    TextBox txtCasualA = (TextBox)item["CasualA"].FindControl("txtCasualActual");
                    TextBox txtGuestB = (TextBox)item["GuestBooked"].FindControl("txtGuestBooked");
                    TextBox txtGuestA = (TextBox)item["GuestActual"].FindControl("txtGuestActual");
                    TextBox txtHSB = (TextBox)item["HSBooked"].FindControl("txtHSBooked");
                    TextBox txtHSA = (TextBox)item["HSActual"].FindControl("txtHSActual");
                    TextBox txtTotalB = (TextBox)item["Total"].FindControl("txtTotal");
                    TextBox txtTotalA = (TextBox)item["TotalActual"].FindControl("txtTotalActual");

                    if (strStatus == "Done previous billing")
                    {
                        txtRegularB.Enabled = false;
                        txtRegularA.Enabled = false;
                        txtCasualB.Enabled = false;
                        txtGuestA.Enabled = false;
                        txtGuestB.Enabled = false;
                        txtHSB.Enabled = false;
                        txtHSA.Enabled = false;
                        txtTotalB.Enabled = false;
                        txtTotalA.Enabled = false;

                        ddlRegular.Enabled = false;
                        ddlRegularA.Enabled = false;
                        ddlGuest.Enabled = false;
                        ddlGuestA.Enabled = false;

                        lblallow.Text = "Monthly Billing Completed No Updates Allowed!";

                    }
                    else if (strStatus == "Done")
                    {
                        txtRegularB.Enabled = false;
                        txtRegularA.Enabled = true;
                        txtCasualB.Enabled = false;
                        txtGuestA.Enabled = true;
                        txtGuestB.Enabled = false;
                        txtHSB.Enabled = false;
                        txtHSA.Enabled = true;
                        txtTotalB.Enabled = false;
                        txtTotalA.Enabled = false;

                        ddlRegular.Enabled = false;
                        ddlRegularA.Enabled = true;
                        ddlGuest.Enabled = false;
                        ddlGuestA.Enabled = true;

                        lblallow.Text = "You are now updating the ACTUAL COUNT OF DINERS";

                        Session["UMode"] = "2";
                    }
                    else if (strStatus == "Open")
                    {
                        txtRegularB.Enabled = false;
                        txtRegularA.Enabled = true;
                        txtCasualB.Enabled = false;
                        txtGuestA.Enabled = true;
                        txtGuestB.Enabled = false;
                        txtHSB.Enabled = false;
                        txtHSA.Enabled = true;
                        txtTotalB.Enabled = false;
                        txtTotalA.Enabled = false;

                        ddlRegular.Enabled = false;
                        ddlRegularA.Enabled = true;
                        ddlGuest.Enabled = false;
                        ddlGuestA.Enabled = true;

                        lblallow.Text = "You are now updating the ACTUAL COUNT OF DINERS";
                        Session["UMode"] = "2";
                    }
                    else if (strStatus == "Yet to Open")
                    {
                        txtRegularB.Enabled = true;
                        txtRegularA.Enabled = false;
                        txtCasualB.Enabled = true;
                        txtGuestA.Enabled = false;
                        txtGuestB.Enabled = true;
                        txtHSB.Enabled = true;
                        txtHSA.Enabled = false;
                        txtTotalB.Enabled = false;
                        txtTotalA.Enabled = false;

                        ddlRegular.Enabled = true;
                        ddlRegularA.Enabled = false;
                        ddlGuest.Enabled = true;
                        ddlGuestA.Enabled = false;

                        lblallow.Text = "You are accepting BOOKING for a Session now";

                        Session["UMode"] = "1";
                    }


                    if (Session["MenuBillingType"] != null)
                    {


                        if (Session["MenuBillingType"].ToString() == "M")
                        {

                            txtRegularA.Enabled = false;

                            txtGuestA.Enabled = false;
                            txtCasualA.Enabled = false;

                            txtHSA.Enabled = false;

                            txtTotalA.Enabled = false;

                            ddlRegular.Enabled = false;
                            ddlRegularA.Enabled = false;
                            ddlGuest.Enabled = false;
                            ddlGuestA.Enabled = false;


                        }
                    }

                }

                TextBox txtActual = (TextBox)e.Item.FindControl("txtActual");

            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void chkAll_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            //if (chkAll.Checked == true)


            //{
            //    chkByDoorNo.Checked = false;
            //    chkByName.Checked = false;

            //    chkByDoorNo.Enabled = false;
            //    chkByName.Enabled = false;
            //    chkAll.Enabled = true;
            //}
            //else
            //{
            //    //chkByDoorNo.Checked = true;
            //   // chkByName.Checked = true;

            //    chkByDoorNo.Enabled = true;
            //    chkByName.Enabled = true; 
            //}
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnDinersGO_Click(object sender, EventArgs e)
    {
        try
        {


            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsdiners = null;

            Int32 iRTRSN = 0;

            int intmode = 0;



            string strrsnfilter = racResidentSearch.Text;

            string[] custrsn = strrsnfilter.Split(',');

            strrsnfilter = custrsn[3].ToString();

            custrsn = strrsnfilter.Split(';');

            Int32 rsn = Convert.ToInt32(custrsn[0].ToString());

            Session["RTRSN"] = rsn.ToString();

            dsdiners = sqlobj.ExecuteSP("SP_GetDiners",
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                    new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 2 },
                    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = rsn }
                     );


            //if (dsdiners.Tables[1].Rows.Count > 0)
            //{
            //    Session["Diners"] = dsdiners.Tables[1].Rows[0]["Status"].ToString();
            //}

            if (dsdiners.Tables[0].Rows.Count > 0)
            {
                rgDiners.DataSource = dsdiners.Tables[0];
                rgDiners.DataBind();

                rgDiners.Visible = true;
            }
            else
            {
                rgDiners.DataSource = string.Empty;
                rgDiners.DataBind();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No Records found this resident name');", true);
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }
    protected void chkGuestBooked_CheckedChanged(object sender, EventArgs e)
    {
        try
        {

            string strStatus = Session["Diners"].ToString();

            foreach (GridDataItem item in rgDiners.MasterTableView.Items)
            {

                TextBox txtBooked = (TextBox)item.FindControl("txtBooked");
                TextBox txtActual = (TextBox)item.FindControl("txtActual");

                if (strStatus.ToString() == "true")
                {
                    txtActual.Text = txtBooked.Text;
                }

            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnDinersHelp_Click(object sender, EventArgs e)
    {
        try
        {
            rwHelp.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnHelp_Click(object sender, EventArgs e)
    {

    }
    protected void btnDinersExporttoExcel_Click(object sender, EventArgs e)
    {

    }
    protected void txtActual_TextChanged(object sender, EventArgs e)
    {
        try
        {
            foreach (GridDataItem Item in rgDiners.Items)
            {
                TextBox txtActual = (TextBox)Item.FindControl("txtActual");

                TextBox txtGuestActual = (TextBox)Item.FindControl("txtGuestActual");

                TextBox txtTotalActual = (TextBox)Item.FindControl("txtTotalActual");

                txtTotalActual.Text = Convert.ToString(Convert.ToInt32(txtActual.Text) + Convert.ToInt32(txtGuestActual.Text));

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void txtGuestActual_TextChanged(object sender, EventArgs e)
    {
        try
        {
            foreach (GridDataItem Item in rgDiners.Items)
            {
                TextBox txtActual = (TextBox)Item.FindControl("txtActual");

                TextBox txtGuestActual = (TextBox)Item.FindControl("txtGuestActual");

                TextBox txtTotalActual = (TextBox)Item.FindControl("txtTotalActual");

                txtTotalActual.Text = Convert.ToString(Convert.ToInt32(txtActual.Text) + Convert.ToInt32(txtGuestActual.Text));

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnTOK_Click(object sender, EventArgs e)
    {
        LoadDiningBills();
    }

    protected void LoadDiningBills()
    {
        try
        {
            if (ddlBillingMonth.SelectedValue.ToString() != "0")
            {

                string bm = ddlBillingMonth.SelectedValue;
                string[] sbm = bm.Split(',');

                string strrsnfilter = "";

                string doorno = "";

                if (cmbFTResident.SelectedValue != "0")
                {

                    strrsnfilter = cmbFTResident.SelectedItem.Text;

                    string[] custrsn = strrsnfilter.Split(',');

                    string custname = custrsn[0].ToString();

                    doorno = custrsn[1].ToString();

                }


                DataSet dsFoodTransaction = sqlobj.ExecuteSP("SP_GetFoodTransactionDetails",
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbFTResident.SelectedValue == "0" ? null : cmbFTResident.SelectedValue },
                       new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlTSession.SelectedValue == "All" ? null : ddlTSession.SelectedValue },
                       new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = cmbFTResident.SelectedValue == "0" ? null : doorno.ToString() },
                       new SqlParameter() { ParameterName = "@BillingMonth", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingMonth.SelectedValue == "0" ? null : sbm[0].ToString() },
                       new SqlParameter() { ParameterName = "@BillingStatus", SqlDbType = SqlDbType.NVarChar, Value = sbm[1].ToString() }
                       );

                if (dsFoodTransaction.Tables[0].Rows.Count > 0)
                {
                    lblCount.Text = "Count:" + dsFoodTransaction.Tables[0].Rows.Count;

                    rgFoodTransaction.DataSource = dsFoodTransaction;
                    rgFoodTransaction.DataBind();
                }
                else
                {
                    lblCount.Text = "Count:0";
                }

                dsFoodTransaction.Dispose();
            }
            else
            {
                WebMsgBox.Show("Please select a billing month");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    protected void ddlTSession_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnDTHelp_Click(object sender, EventArgs e)
    {
        rwDTHelp.Visible = true;
    }
    protected void BbtnTClear_Click(object sender, EventArgs e)
    {
        try
        {

            cmbFTResident.SelectedValue = "0";
            ddlTSession.SelectedIndex = 0;
            ddlBillingMonth.SelectedIndex = 0;


            rgFoodTransaction.DataSource = string.Empty;
            rgFoodTransaction.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rdospecificdate_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            //if (rdospecificdate.Checked == true)
            //{
            //    dtpuntildate.Visible = false;
            //    lbluntildate.Visible = false;
            //    rdodaterange.Checked = false;
            //}
            //else
            //{
            //    dtpuntildate.Visible = true;
            //    lbluntildate.Visible = true;
            //    rdodaterange.Checked = true;
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rdodaterange_CheckedChanged(object sender, EventArgs e)
    {
        try
        {

            //if (rdodaterange.Checked == true)
            //{
            //    dtpuntildate.Visible = true;
            //    lbluntildate.Visible = true;
            //    rdospecificdate.Checked = false;
            //}
            //else
            //{

            //    dtpuntildate.Visible = false;
            //    lbluntildate.Visible = false;
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void dtpfordate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {

            //if (rdospecificdate.Checked == true)
            //{
            //    txtNoofdays.Text = "1";
            //}



            // DateTime tilldate = Convert.ToDateTime(dtpfordate.SelectedDate);


            // dtpuntildate.MinDate = tilldate.AddDays(1);


            //DataSet dsmenuitem = sqlobj.ExecuteSP("SP_GetMenuItemSessionWise",
            //            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate }
            //            //,
            //            //new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = ddlBMSession.SelectedValue }
            //            );


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    private void LoadAlacarteMenus()
    {

        try
        {

            DataSet dsmenuitem = sqlobj.ExecuteSP("SP_FetchItem",
                  new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {
                ddlItemName.DataSource = dsmenuitem.Tables[0];
                ddlItemName.DataValueField = "ItemCode";
                ddlItemName.DataTextField = "ItemName";
                ddlItemName.DataBind();
                ddlItemName.Dispose();

                ddlItemName.Items.Insert(0, "--Select--");


            }
            else
            {
                ddlItemName.Items.Insert(0, "--Select--");

            }

            dsmenuitem.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void dtpuntildate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {

            //if (rdodaterange.Checked == true)
            //{
            //    DateTime fdate = Convert.ToDateTime(dtpfordate.SelectedDate);
            //   // DateTime tdate = Convert.ToDateTime(dtpuntildate.SelectedDate);

            //    Int32 noofdays = TotalDays(fdate, tdate);

            //    txtNoofdays.Text = noofdays.ToString();
            //}

            //if (dtpfordate.SelectedDate != null)
            //{
            //    DateTime tilldate = Convert.ToDateTime(dtpfordate.SelectedDate);


            //    dtpuntildate.MinDate = tilldate.AddDays(1);
            //}
            //else
            //{
            //    dtpuntildate.SelectedDate = null;
            //    WebMsgBox.Show("Please select your For Date.");
            //}
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

    protected void DdlUhid_EntryAdded(object sender, AutoCompleteEntryEventArgs e)
    {
        try
        {
            string strrsn = e.Entry.Value;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //try
        //{


        //string strrsnfilter = DdlUhid.Text;

        //    string[] custrsn = strrsnfilter.Split(',');

        //    strrsnfilter = custrsn[3].ToString();

        //    custrsn = strrsnfilter.Split(';');

        //    Int32 rsn = Convert.ToInt32(custrsn[0].ToString());

        //    DataSet dscustomerdetails = sqlobj.ExecuteSP("SP_GetResidentdetailswithRSN",
        //             new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = rsn }
        //             );


        //    if (dscustomerdetails.Tables[0].Rows.Count > 0)
        //    {

        //        Session["RTRSN"] = rsn.ToString();
        //    }


        //    dscustomerdetails.Dispose();

        //    DataSet dsgetoutstanding = sqlobj.ExecuteSP("SP_GetResidentOutStanding",
        //       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

        //    if (dsgetoutstanding.Tables[0].Rows.Count > 0)
        //    {

        //        lblName.Text = dsgetoutstanding.Tables[0].Rows[0]["Name"].ToString() + ",";

        //        string strname = dsgetoutstanding.Tables[0].Rows[0]["Name"].ToString();
        //        string strStatus = dsgetoutstanding.Tables[0].Rows[0]["Status"].ToString();


        //        if (strname.ToString() == "Non Residing Staff" || strStatus.ToString() == "RS" || strStatus.ToString() == "TS")
        //        {


        //            DataSet dsdiscount = sqlobj.ExecuteSP("sp_getstaffdiscount");




        //            if (dsdiscount.Tables[0].Rows.Count > 0)
        //            {

        //                decimal ddiscount = Convert.ToDecimal(dsdiscount.Tables[0].Rows[0]["stafdiscountpcnt"].ToString());

        //                Session["dper"] = ddiscount.ToString();

        //                if (ddiscount > 0)
        //                {

        //                    lblDiscount.Text = "(" + dsgetoutstanding.Tables[0].Rows[0]["sDescription"].ToString() + ")  " + dsdiscount.Tables[0].Rows[0]["stafdiscountpcnt"].ToString() + "%  " + " Discount applied";

        //                    lblDiscount.Visible = true;
        //                }
        //                else
        //                {
        //                    lblDiscount.Visible = false;
        //                }

        //                dsdiscount.Dispose();

        //            }

        //            else
        //            {
        //                lblDiscount.Visible = false;
        //            }

        //            lblDoorNO.Text = dsgetoutstanding.Tables[0].Rows[0]["DoorNo"].ToString() + ",";

        //            lblMobileNo.Text = dsgetoutstanding.Tables[0].Rows[0]["sDescription"].ToString() + ",";

        //            lblEmail.Text = dsgetoutstanding.Tables[0].Rows[0]["EMail"].ToString();

        //            txtBillingPeriod.Text = Session["CurrentBillingPeriod"].ToString();

        //            txtamountoutstanding.Text = dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString();

        //            string stroutstanding = dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString();

        //            if (stroutstanding.ToString() != "")
        //            {

        //                lblOutstanding.Text = "Outstanding:" + stroutstanding.ToString();
        //            }
        //            else
        //            {
        //                lblOutstanding.Text = "Outstanding:0";
        //            }
        //        }

        //        dsgetoutstanding.Dispose();

        //        DataSet dsgetdiners = sqlobj.ExecuteSP("SP_GetTotalResidentDiners",
        //             new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

        //        if (dsgetdiners.Tables[0].Rows.Count > 0)
        //        {
        //            ddlnoofpersons.SelectedValue = dsgetdiners.Tables[0].Rows[0]["Booked"].ToString();
        //        }

        //        dsgetdiners.Dispose();

        //    }
        //}

        //catch (Exception ex)
        //{
        //    WebMsgBox.Show(ex.Message);
        //}
    }

    protected void ddlItemName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            string strcsession = ddlSession.SelectedItem.Text;
            string strcitem = ddlItemName.SelectedItem.Text;

            if (strcitem == "--Select--")
            {
                WebMsgBox.Show("Please select menu item");
                return;
            }

            //  int index = strcitem.LastIndexOf(",");

            // string[] stritemsplit = new string[] { strcitem.Substring(0, index), strcitem.Substring(index + 1) };

            string[] stritemsplit = strcitem.Split(',');

            strcitem = stritemsplit[0].ToString();


            //foreach (GridItem rw in rdgMenuList.Items)
            //{
            //    string strsession = rw.Cells[4].Text;
            //    string stritem = rw.Cells[5].Text;


            //    if (strsession.Equals(strcsession))
            //    {
            //        if (stritem.Equals(strcitem))
            //        {
            //            WebMsgBox.Show("Item " + stritem + " has been already assigned for session " + strsession);
            //            break;
            //        }

            //    }


            //}


            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchItm = new DataSet();

            dsFetchItm = sqlobj.ExecuteSP("SP_FetchItmDet",
                 new SqlParameter() { ParameterName = "@ItmCode", SqlDbType = SqlDbType.NVarChar, Value = ddlItemName.SelectedValue });



            if (lblDiscount.Visible == true)
            {
                decimal drate = Convert.ToDecimal(dsFetchItm.Tables[0].Rows[0]["Rate"].ToString()) * (Convert.ToDecimal(Session["dper"].ToString()) / 100);
                decimal orate = Convert.ToDecimal(dsFetchItm.Tables[0].Rows[0]["Rate"].ToString()) - drate;

                lbloriginalrate.Text = dsFetchItm.Tables[0].Rows[0]["Rate"].ToString();

                txtBMRate.Text = orate.ToString("0.00");
            }
            else
            {
                txtBMRate.Text = dsFetchItm.Tables[0].Rows[0]["Rate"].ToString();
                lbloriginalrate.Visible = false;
            }


            lblunit.Text = dsFetchItm.Tables[0].Rows[0]["itmuom"].ToString();
            lblcontains.Text = dsFetchItm.Tables[0].Rows[0]["Remarks"].ToString();



            int iTotalQty = Convert.ToInt32(ddlnoofpersons.SelectedValue) * Convert.ToInt32(ddlBMQuantiry.SelectedValue);

            txtBMTotQty.Text = iTotalQty.ToString();

            decimal iatop = Convert.ToDecimal(txtBMRate.Text) * Convert.ToInt32(ddlBMQuantiry.SelectedValue) * Convert.ToInt32(ddlnoofpersons.SelectedValue);

            txtBMAmounttopay.Text = iatop.ToString();




        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    private DataTable AddRow(DataTable dt)
    {
        // method to create row        
        DataRow dr = dt.NewRow();
        dr["Text"] = "";

        dt.Rows.Add(dr);
        return dt;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        try
        {


            string struntildate = "";

            //if (rdospecificdate.Checked == true)
            //{
            //    struntildate = dtpfordate.SelectedDate.Value.ToString();
            //}
            //else
            //{
            //    struntildate = dtpuntildate.SelectedDate.Value.ToString();
            //}

            DateTime fdate = Convert.ToDateTime(dtpfordate.SelectedDate);
            //DateTime tdate = Convert.ToDateTime(struntildate);

            DataRow dr = dt.NewRow();
            dr["ItemCode"] = ddlItemName.SelectedValue;
            dr["ItemName"] = ddlItemName.SelectedItem.Text;
            dr["Rate"] = Convert.ToDecimal(txtBMRate.Text);
            dr["Persons"] = Convert.ToInt32(ddlnoofpersons.SelectedValue);
            dr["Qty"] = Convert.ToInt32(ddlBMQuantiry.SelectedValue) * Convert.ToInt32(ddlnoofpersons.SelectedValue);
            dr["Unit"] = lblunit.Text;
            dr["AmounttoPay"] = Convert.ToDecimal(txtBMAmounttopay.Text);
            dr["From"] = fdate.ToString("dd/MM/yyyy");
            dr["To"] = fdate.ToString("dd/MM/yyyy");
            //dr["SessionCode"] = ddlBMSession.SelectedValue;
            //dr["Session"] = ddlBMSession.SelectedItem.Text;
            dt.Rows.Add(dr);
            ViewState["dt"] = dt;
            //rgBookingameal.Rebind(); 
            rgBookingameal.DataSource = dt;
            rgBookingameal.DataBind();


            //ddlBMSession.SelectedIndex = 0;
            //rdodaterange.Checked = false;
            //rdospecificdate.Checked = true;
            //lbluntildate.Visible = false;
            //dtpuntildate.Visible = false;
            //dtpfordate.SelectedDate = null;
            //txtNoofdays.Text = "";
            ddlnoofpersons.SelectedIndex = 1;
            txtBMAmounttopay.Text = "";
            txtContains.Text = "";
            ddlBMQuantiry.SelectedIndex = 1;
            txtBMRate.Text = "";
            txtBMTotQty.Text = "";

            // DdlUhid.Enabled = false;

            btnPreparetobill.Visible = true;
            //btnpaynow.Visible = true;


            // RadWindowManager2.RadConfirm("Do you wish to make the same update for a date range?", "confirmAddMoreCallbackFn", 400, 200, null, "Confirm");

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }




    }
    protected void rgBookingameal_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (IsPostBack)
        {
            ViewState["dt"] = dt;
            dt = (DataTable)ViewState["dt"];
            rgBookingameal.DataSource = dt;
        }
    }
    protected void rgBookingameal_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LinkButton lnk = sender as LinkButton;

        GridDataItem item = lnk.NamingContainer as GridDataItem;

        // DateTime date = Convert.ToDateTime(item.GetDataKeyValue("filterdate").ToString());
        string strSession = item.GetDataKeyValue("Text").ToString();
    }
    protected void btnPreparetobill_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                string strBStatus = "";

                DateTime cdate = DateTime.Now;



                //DataSet dsStatus = sqlobj.ExecuteSP("SP_CheckBillingStatus",
                //       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = cdate.ToString() });

                //if (dsStatus.Tables[0].Rows.Count > 0)
                //{

                //    //strBStatus = dsStatus.Tables[0].Rows[0]["BStatus"].ToString();

                //}
                //else
                //{
                //    WebMsgBox.Show("Please wait for month end billing");
                //    return;
                //}


                if (dt.Rows.Count > 0)
                {

                    DateTime bdate = DateTime.Now;

                    string strday = bdate.ToString("dd");
                    string strmonth = bdate.ToString("MM");
                    string stryear = bdate.ToString("yyyy");
                    string strhour = bdate.ToString("HH");
                    string strmin = bdate.ToString("mm");
                    string strsec = bdate.ToString("ss");

                    string strBillNo = "D" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();


                    //string strrsnfilter = DdlUhid.Text;

                    //string[] custrsn = strrsnfilter.Split(',');

                    //strrsnfilter = custrsn[3].ToString();

                    //custrsn = strrsnfilter.Split(';');

                    //Int32 rsn = Convert.ToInt32(custrsn[0].ToString());

                    decimal TotalAmount = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {

                        Int64 iRTRSN = Convert.ToInt64(cmbResident.SelectedValue);
                        string strItemCode = dt.Rows[i]["ItemCode"].ToString();
                        decimal dRate = Convert.ToDecimal(dt.Rows[i]["Rate"].ToString());
                        Int32 ipersons = Convert.ToInt32(dt.Rows[i]["Persons"].ToString());
                        Int32 iQty = Convert.ToInt32(dt.Rows[i]["Qty"].ToString());
                        decimal damounttopay = Convert.ToDecimal(dt.Rows[i]["AmounttoPay"].ToString());
                        // string strSessionCode = dt.Rows[i]["SessionCode"].ToString();

                        TotalAmount = TotalAmount + damounttopay;


                        DateTime sdate = DateTime.ParseExact(dt.Rows[i]["From"].ToString(), "dd/MM/yyyy", null);
                        DateTime edate = DateTime.ParseExact(dt.Rows[i]["To"].ToString(), "dd/MM/yyyy", null);

                        //DateTime StartingDate = DateTime.ParseExact(sdate.ToString(),"dd/MM/yyyy", null);
                        //DateTime EndingDate = DateTime.ParseExact(edate.ToString(),"dd/MM/yyyy", null);

                        //foreach (DateTime date in GetDateRange(sdate, edate))
                        //{

                        //    // Get Dining RSN

                        //    Int32 iDiningRSN = 0;

                        //    DataSet dsDiningRSN = sqlobj.ExecuteSP("SP_GetDiningRSN",
                        //    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = date },
                        //    new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = strSessionCode.ToString() },
                        //    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = iRTRSN.ToString() }
                        //    );

                        //    if (dsDiningRSN.Tables[0].Rows.Count > 0)
                        //    {
                        //        iDiningRSN = Convert.ToInt32(dsDiningRSN.Tables[0].Rows[0]["RSN"].ToString());
                        //    }

                        //    dsDiningRSN.Dispose();


                        // Insert Booking a meal


                        sqlobj.ExecuteNonQuery("SP_InsertBookingameal",
                            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = sdate },

                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = iRTRSN.ToString() },
                            new SqlParameter() { ParameterName = "@DiningRSN", SqlDbType = SqlDbType.BigInt, Value = null },
                            new SqlParameter() { ParameterName = "@MenuItemCode", SqlDbType = SqlDbType.NVarChar, Value = strItemCode.ToString() },
                            new SqlParameter() { ParameterName = "@Rate", SqlDbType = SqlDbType.Decimal, Value = dRate },
                            new SqlParameter() { ParameterName = "@Persons", SqlDbType = SqlDbType.Int, Value = ipersons },
                            new SqlParameter() { ParameterName = "@Qty", SqlDbType = SqlDbType.Int, Value = iQty },
                            new SqlParameter() { ParameterName = "@Amounttopay", SqlDbType = SqlDbType.Decimal, Value = damounttopay },
                            new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() }

                            );

                        //string strdates = date.ToString();
                        //}

                    }


                    if (TotalAmount != 0)
                    {

                        sqlobj.ExecuteSP("SP_InsertTransactionDetailsTxn",
                                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = cmbResident.SelectedValue },
                                      new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "DINING" },
                                      new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "DINING" },
                                      new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                      new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = "UnBilled" },
                                      new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = TotalAmount },
                                      new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                                      new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = TotalAmount },
                                      new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                      new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                                      new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = "A la carte Bill" },
                                      new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                      new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                      new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                      new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() }
                                      );



                        //decimal dlastdebit = 0;
                        //decimal dlastcredit = 0;

                        //DataSet dsgetdebitcredittoal = null;
                        //dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
                        //    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

                        //if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
                        //{
                        //    dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
                        //    dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
                        //    dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());
                        //}

                        //sqlobj.ExecuteNonQuery("SP_UpdateClosingBalance",
                        //    new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                        //    new SqlParameter() { ParameterName = "@Closing", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding });


                        //sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
                        //    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = rsn.ToString() },
                        //    new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
                        //    new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
                        //    new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
                        //    new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                        //    new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
                        //    new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });

                    }

                    //ddlBMSession.SelectedIndex = 0;
                    //rdodaterange.Checked = false;
                    //rdospecificdate.Checked = true;
                    //lbluntildate.Visible = false;
                    //dtpuntildate.Visible = false;
                    dtpfordate.SelectedDate = null;

                    ddlnoofpersons.SelectedIndex = 0;
                    txtBMAmounttopay.Text = "";
                    ddlBMQuantiry.SelectedValue = "0";
                    txtBMRate.Text = "";
                    txtBMTotQty.Text = "";

                    rgBookingameal.DataSource = string.Empty;
                    rgBookingameal.DataBind();

                    ddlnoofpersons.Enabled = true;

                    //DdlUhid.Entries.Clear();

                    cmbResident.SelectedValue = "0";

                    dt.Rows.Clear();

                    //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Credit transaction updated');", true);

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Total Bill Amount debited and will appear in the outstanding bills.');", true);

                    //WebMsgBox.Show("Bill prepared");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('There is nothing to bill!');", true);
                    // WebMsgBox.Show("There is nothing to bill!");
                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private List<DateTime> GetDateRange(DateTime StartingDate, DateTime EndingDate)
    {
        if (StartingDate > EndingDate)
        {
            return null;
        }
        List<DateTime> rv = new List<DateTime>();
        DateTime tmpDate = StartingDate;
        do
        {
            rv.Add(tmpDate);
            tmpDate = tmpDate.AddDays(1);
        } while (tmpDate <= EndingDate);
        return rv;
    }
    protected void lnkviewall_Click(object sender, EventArgs e)
    {
        if (lnkviewall.Text == "+ View all")
        {
            rgDiners.Visible = true;
            lnkviewall.Text = "- Hide all";
        }
        else
        {
            rgDiners.Visible = false;
            lnkviewall.Text = "+ View all";
        }
    }
    protected void txtBMQuantity_TextChanged(object sender, EventArgs e)
    {
        try
        {

            if (txtBMRate.Text != "" && ddlBMQuantiry.SelectedValue.ToString() != "0")
            {
                decimal iatop = Convert.ToDecimal(txtBMRate.Text) * Convert.ToInt32(ddlBMQuantiry.SelectedValue) * Convert.ToInt32(ddlnoofpersons.SelectedValue);

                txtBMAmounttopay.Text = iatop.ToString();

                Int32 itotqty = Convert.ToInt32(ddlBMQuantiry.SelectedValue) * Convert.ToInt32(ddlnoofpersons.SelectedValue);

                txtBMTotQty.Text = itotqty.ToString();
            }




        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnClearAll_Click(object sender, EventArgs e)
    {
        try
        {


            dtpfordate.SelectedDate = null;

            // ddlnoofpersons.SelectedIndex = 0;
            txtContains.Text = "";
            txtBMAmounttopay.Text = "";
            ddlBMQuantiry.SelectedIndex = 1;
            txtBMRate.Text = "";
            txtBMTotQty.Text = "";

            // DdlUhid.Enabled = true;

            btnPreparetobill.Visible = false;
            /// btnpaynow.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnAPSearch_Click(object sender, EventArgs e)
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

                lblName.Text = dsgetoutstanding.Tables[0].Rows[0]["Name"].ToString() + ",";

                lblDoorNO.Text = dsgetoutstanding.Tables[0].Rows[0]["DoorNo"].ToString() + ",";

                lblMobileNo.Text = dsgetoutstanding.Tables[0].Rows[0]["sDescription"].ToString() + ",";

                lblEmail.Text = dsgetoutstanding.Tables[0].Rows[0]["EMail"].ToString();

                txtBillingPeriod.Text = Session["CurrentBillingPeriod"].ToString();

                hdnAmtOutstanding.Value = dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString() == string.Empty ? "0" : dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString();
                if (Convert.ToDecimal(hdnAmtOutstanding.Value) > 0)
                {
                    txtamountoutstanding.Text = hdnAmtOutstanding.Value.ToString();
                }
                else
                {
                    txtamountoutstanding.Text = (Convert.ToDecimal(hdnAmtOutstanding.Value) * -1).ToString() + " CR";
                }

                //txtamountoutstanding.Text = dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString() == string.Empty ? "0" : dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString();
            }

            dsgetoutstanding.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnAPOK_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {

                if (ddlPayMode.SelectedValue == "CASH")
                {
                    InsertTxn();
                }
                else
                {
                    if (txtNo.Text.ToString() != string.Empty && dtpDate.SelectedDate.ToString() != string.Empty && txtBankandBranch.Text.ToString() != string.Empty)
                    {
                        InsertTxn();
                    }
                    else
                    {
                        WebMsgBox.Show("Please enter mandatory field(s).");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void InsertTxn()
    {
        DateTime bdate = DateTime.Now;

        string strday = bdate.ToString("dd");
        string strmonth = bdate.ToString("MM");
        string stryear = bdate.ToString("yyyy");
        string strhour = bdate.ToString("HH");
        string strmin = bdate.ToString("mm");

        string strsec = bdate.ToString("ss");

        string strBillNo = "D" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();


        DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertTransaction",
                          new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
                          new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = ddlPayMode.SelectedValue },
                          new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "CASH" },
                          new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                          new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = "Billed" },
                          new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = txtamountreceived.Text },
                          new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                          new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = txtamountreceived.Text },
                          new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                          new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = "CR" },
                          new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = txtAPRemarks.Text },
                          new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                          new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                          new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() },
                          new SqlParameter() { ParameterName = "@No", SqlDbType = SqlDbType.NVarChar, Value = txtNo.Text == "" ? null : txtNo.Text },
                          new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDate.SelectedDate == null ? null : dtpDate.SelectedDate },
                          new SqlParameter() { ParameterName = "@BankandBranch", SqlDbType = SqlDbType.NVarChar, Value = txtBankandBranch.Text == "" ? null : txtBankandBranch.Text }
                          );


        if (dsRSN.Tables[0].Rows.Count > 0)
        {
            Session["ReceiptRSN"] = dsRSN.Tables[0].Rows[0]["ReceiptNo"].ToString();
        }

        dsRSN.Dispose();

        //new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "DINING" },

        sqlobj.ExecuteNonQuery("SP_UpdateTransactionStatus",
                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = Session["RTRSN"].ToString() });

        decimal dlastdebit = 0;
        decimal dlastcredit = 0;

        DataSet dsgetdebitcredittoal = null;
        dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = Session["RTRSN"].ToString() });

        if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
        {
            dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
            dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
            dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());
        }


        sqlobj.ExecuteNonQuery("SP_UpdateClosingBalance",
                  new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                  new SqlParameter() { ParameterName = "@Closing", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding });

        sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
            new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
            new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
            new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
            new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
            new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
            new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });



        StringBuilder sb = new StringBuilder();

        sb.AppendFormat("ORIS");
        sb.AppendLine();
        sb.AppendFormat(lblDoorNO.Text + "" + lblName.Text + " Payment received. Amount:" + txtamountreceived.Text);
        sb.AppendLine();

        sqlobj.ExecuteNonQuery("SP_InsertSMS",
            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Session["RTRSN"].ToString() },
            new SqlParameter() { ParameterName = "@smstext", SqlDbType = SqlDbType.NVarChar, Value = sb.ToString() });

        ClearAcceptPayment();


        RadWindowManager2.RadConfirm("Do you want print the Receipt? ", "confirmReceiptCallbackFn", 400, 200, null, "Confirm");


        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Credit transaction updated');", true);
    }

    private void ClearAcceptPayment()
    {
        try
        {

            txtBillingPeriod.Text = "";
            txtamountoutstanding.Text = "";
            txtamountreceived.Text = "";
            txtAPRemarks.Text = "";
            txtBalance.Text = "";

            lblName.Text = "";
            lblDoorNO.Text = "";
            lblMobileNo.Text = "";
            lblEmail.Text = "";
            racAPResident.Entries.Clear();

            ddlPayMode.SelectedIndex = 0;

            LoadPayMode();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void btnOutstandingBills_Click(object sender, EventArgs e)
    {
        try
        {

            if (cmbResident.SelectedValue != "0")
            {


                Int32 rsn = Convert.ToInt32(cmbResident.SelectedValue);

                string strrsnfilter = cmbResident.SelectedItem.Text;




                string[] custrsn = strrsnfilter.Split(',');

                string custname = custrsn[0].ToString();



                DataSet dsgetoutstanding = sqlobj.ExecuteSP("SP_GetResidentOutStanding",
                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

                if (dsgetoutstanding.Tables[0].Rows.Count > 0)
                {


                    string stroutstanding = dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString();

                    if (stroutstanding.ToString() != "")
                    {

                        Response.Redirect("BillSummary.aspx?ResidentRSN=" + rsn.ToString());
                    }
                    else
                    {
                        WebMsgBox.Show("There is no outstanding bills for the selected resident.");
                    }

                }
                else
                {
                    WebMsgBox.Show("There is no outstanding bills for the selected resident.");

                }


            }
            else
            {
                WebMsgBox.Show("Please choose the resident ID / Door No. / Name");

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void txtamountreceived_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (txtamountoutstanding.Text != "" && txtamountreceived.Text != "")
            {
                //double dos = Convert.ToDouble(txtamountoutstanding.Text);
                double dos = Convert.ToDouble(hdnAmtOutstanding.Value);
                double dar = Convert.ToDouble(txtamountreceived.Text);
                //txtBalance.Text = (dos - dar).ToString();
                hdnBalance.Value = (dos - dar).ToString();

                if (Convert.ToDecimal(hdnBalance.Value) > 0)
                {
                    txtBalance.Text = hdnBalance.Value.ToString();
                }
                else
                {
                    txtBalance.Text = (Convert.ToDecimal(hdnBalance.Value) * -1).ToString() + " CR";
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void ddlBMQuantiry_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if (txtBMRate.Text != "" && ddlBMQuantiry.SelectedValue.ToString() != "0")
            {
                decimal iatop = Convert.ToDecimal(txtBMRate.Text) * Convert.ToInt32(ddlBMQuantiry.SelectedValue) * Convert.ToInt32(ddlnoofpersons.SelectedValue);

                txtBMAmounttopay.Text = iatop.ToString();

                Int32 itotqty = Convert.ToInt32(ddlBMQuantiry.SelectedValue) * Convert.ToInt32(ddlnoofpersons.SelectedValue);

                txtBMTotQty.Text = itotqty.ToString();
                btnPreparetobill.Visible = true;
                //btnpaynow.Visible = true;

            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnpaynow_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                if (dt.Rows.Count > 0)
                {

                    DateTime bdate = DateTime.Now;

                    string strday = bdate.ToString("dd");
                    string strmonth = bdate.ToString("MM");
                    string stryear = bdate.ToString("yyyy");
                    string strhour = bdate.ToString("HH");
                    string strmin = bdate.ToString("mm");
                    string strsec = bdate.ToString("ss");

                    string strBillNo = "D" + stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();


                    //string strrsnfilter = DdlUhid.Text;

                    //string[] custrsn = strrsnfilter.Split(',');

                    //strrsnfilter = custrsn[3].ToString();

                    //custrsn = strrsnfilter.Split(';');

                    Int32 rsn = Convert.ToInt32(cmbResident.SelectedValue);

                    decimal TotalAmount = 0;

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {

                        Int64 iRTRSN = Convert.ToInt64(rsn.ToString());
                        string strItemCode = dt.Rows[i]["ItemCode"].ToString();
                        decimal dRate = Convert.ToDecimal(dt.Rows[i]["Rate"].ToString());
                        Int32 ipersons = Convert.ToInt32(dt.Rows[i]["Persons"].ToString());
                        Int32 iQty = Convert.ToInt32(dt.Rows[i]["Qty"].ToString());
                        decimal damounttopay = Convert.ToDecimal(dt.Rows[i]["AmounttoPay"].ToString());
                        string strSessionCode = dt.Rows[i]["SessionCode"].ToString();

                        TotalAmount = TotalAmount + damounttopay;


                        DateTime sdate = DateTime.ParseExact(dt.Rows[i]["From"].ToString(), "dd/MM/yyyy", null);
                        DateTime edate = DateTime.ParseExact(dt.Rows[i]["To"].ToString(), "dd/MM/yyyy", null);

                        //DateTime StartingDate = DateTime.ParseExact(sdate.ToString(),"dd/MM/yyyy", null);
                        //DateTime EndingDate = DateTime.ParseExact(edate.ToString(),"dd/MM/yyyy", null);

                        foreach (DateTime date in GetDateRange(sdate, edate))
                        {

                            // Get Dining RSN

                            Int32 iDiningRSN = 0;

                            DataSet dsDiningRSN = sqlobj.ExecuteSP("SP_GetDiningRSN",
                            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = date },
                            new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = strSessionCode.ToString() },
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = iRTRSN.ToString() }
                            );

                            if (dsDiningRSN.Tables[0].Rows.Count > 0)
                            {
                                iDiningRSN = Convert.ToInt32(dsDiningRSN.Tables[0].Rows[0]["RSN"].ToString());
                            }

                            dsDiningRSN.Dispose();


                            // Insert Booking a meal


                            sqlobj.ExecuteNonQuery("SP_InsertBookingameal",
                                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = date },
                                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = strSessionCode.ToString() },
                                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = iRTRSN.ToString() },
                                new SqlParameter() { ParameterName = "@DiningRSN", SqlDbType = SqlDbType.BigInt, Value = iDiningRSN.ToString() },
                                new SqlParameter() { ParameterName = "@MenuItemCode", SqlDbType = SqlDbType.NVarChar, Value = strItemCode.ToString() },
                                new SqlParameter() { ParameterName = "@Rate", SqlDbType = SqlDbType.Decimal, Value = dRate },
                                new SqlParameter() { ParameterName = "@Persons", SqlDbType = SqlDbType.Int, Value = ipersons },
                                new SqlParameter() { ParameterName = "@Qty", SqlDbType = SqlDbType.Int, Value = iQty },
                                new SqlParameter() { ParameterName = "@Amounttopay", SqlDbType = SqlDbType.Decimal, Value = damounttopay },
                                new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() }

                                );

                            string strdates = date.ToString();
                        }

                    }


                    if (TotalAmount != 0)
                    {


                        sqlobj.ExecuteSP("SP_InsertTransaction",
                                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = rsn.ToString() },
                                      new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = "DINING" },
                                      new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "DINING" },
                                      new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                                      new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = "UnBilled" },
                                      new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.NVarChar, Value = TotalAmount },
                                      new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.NVarChar, Value = "1" },
                                      new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = TotalAmount },
                                      new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now },
                                      new SqlParameter() { ParameterName = "@TType", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                                      new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = "A la carte Bill" },
                                      new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                                      new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                                      new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() }
                                      );

                        decimal dlastdebit = 0;
                        decimal dlastcredit = 0;

                        DataSet dsgetdebitcredittoal = null;
                        dsgetdebitcredittoal = sqlobj.ExecuteSP("[SP_GetTotalS]",
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

                        if (dsgetdebitcredittoal.Tables[0].Rows.Count > 0)
                        {
                            dlastdebit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumDR"].ToString());
                            dlastcredit = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["SumCR"].ToString());
                            dlastOutStanding = Convert.ToDecimal(dsgetdebitcredittoal.Tables[0].Rows[0]["OutStanding"].ToString());
                        }

                        sqlobj.ExecuteNonQuery("SP_UpdateClosingBalance",
                            new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                            new SqlParameter() { ParameterName = "@Closing", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding });


                        sqlobj.ExecuteNonQuery("SP_UpdateDebitCreditTotal",
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = rsn.ToString() },
                            new SqlParameter() { ParameterName = "@TotalDebit", SqlDbType = SqlDbType.Decimal, Value = dlastdebit },
                            new SqlParameter() { ParameterName = "@TotalCredit", SqlDbType = SqlDbType.Decimal, Value = dlastcredit },
                            new SqlParameter() { ParameterName = "@OutStanding", SqlDbType = SqlDbType.Decimal, Value = dlastOutStanding },
                            new SqlParameter() { ParameterName = "@Transtype", SqlDbType = SqlDbType.NVarChar, Value = "DR" },
                            new SqlParameter() { ParameterName = "@CR_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) },
                            new SqlParameter() { ParameterName = "@DB_MD", SqlDbType = SqlDbType.DateTime, Value = Convert.ToString(DateTime.Now) });

                    }

                    Session["GetRSN"] = rsn.ToString();


                    dtpfordate.SelectedDate = null;

                    ddlnoofpersons.SelectedIndex = 0;
                    txtBMAmounttopay.Text = "";
                    ddlBMQuantiry.SelectedValue = "0";
                    txtBMRate.Text = "";
                    txtBMTotQty.Text = "";

                    rgBookingameal.DataSource = string.Empty;
                    rgBookingameal.DataBind();

                    ddlnoofpersons.Enabled = true;

                    cmbResident.SelectedValue = "0";

                    dt.Rows.Clear();


                    // Redirect Accept payment


                    //RadTab T1, T2, T3, T4, T5, T6, T7, T8, T9, T10;
                    //T1 = RadTabStrip1.Tabs.FindTabByText("Which Menu When?");
                    //T2 = RadTabStrip1.Tabs.FindTabByText("How many diners?");
                    //T3 = RadTabStrip1.Tabs.FindTabByText("Daily Menu");
                    //T4 = RadTabStrip1.Tabs.FindTabByText("Menu Items");
                    //T5 = RadTabStrip1.Tabs.FindTabByText("Menu For Day");
                    //T6 = RadTabStrip1.Tabs.FindTabByText("Help");
                    //T7 = RadTabStrip1.Tabs.FindTabByText("Diners Update");
                    //T8 = RadTabStrip1.Tabs.FindTabByText("Dining Transactions");
                    //T9 = RadTabStrip1.Tabs.FindTabByText("Booking A la carte menu");
                    //T10 = RadTabStrip1.Tabs.FindTabByText("Accept Payment");

                    //T1.Visible = false;
                    //T2.Visible = false;
                    //T3.Visible = false;
                    //T4.Visible = false;
                    //T5.Visible = false;
                    //T6.Visible = false;
                    //T7.Visible = false;
                    //T8.Visible = false;
                    //T9.Visible = false;
                    //T10.Visible = true;

                    //T10.PageView.Selected = true;


                    dvBookingAlacartemenu.Visible = false;
                    dvAcceptPayment.Visible = true;



                    LoadTitle(23);

                    DataSet dsgetoutstanding = sqlobj.ExecuteSP("SP_GetResidentOutStanding",
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = Session["GetRSN"].ToString() });

                    if (dsgetoutstanding.Tables[0].Rows.Count > 0)
                    {
                        Session["RTRSN"] = Session["GetRSN"].ToString();

                        lblName.Text = dsgetoutstanding.Tables[0].Rows[0]["Name"].ToString() + ",";

                        lblDoorNO.Text = dsgetoutstanding.Tables[0].Rows[0]["DoorNo"].ToString() + ",";

                        lblMobileNo.Text = dsgetoutstanding.Tables[0].Rows[0]["sDescription"].ToString() + ",";

                        lblEmail.Text = dsgetoutstanding.Tables[0].Rows[0]["EMail"].ToString();

                        txtBillingPeriod.Text = Session["CurrentBillingPeriod"].ToString();

                        decimal dos = Convert.ToDecimal(dsgetoutstanding.Tables[0].Rows[0]["Outstanding"].ToString());

                        txtamountoutstanding.Text = dos.ToString("0.00");

                        //racAPResident. = Session["RTRSN"].ToString() + ',' + lblDoorNO.Text + ',' + lblName.Text + ', ' +  Session["RTRSN"].ToString();   
                    }

                    dsgetoutstanding.Dispose();


                    DataSet dsResident = sqlobj.ExecuteSP("SP_LoadBillwiseTransactions",
                     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

                    if (dsResident.Tables[0].Rows.Count > 0)
                    {

                        gvBillSummary.DataSource = dsResident;
                        gvBillSummary.DataBind();
                    }
                    else
                    {
                        gvBillSummary.DataSource = string.Empty;
                        gvBillSummary.DataBind();
                    }

                    dsResident.Dispose();


                    //Response.Redirect("FoodMenu.aspx?MenuName=Accept Payment", false);


                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('There is nothing to bill!');", true);
                    // WebMsgBox.Show("There is nothing to bill!");
                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnPrintReceipt_Click(object sender, EventArgs e)
    {
        try
        {


            DataSet dsReceipt = sqlobj.ExecuteSP("SP_GetReceiptNo",
            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Session["ReceiptRSN"].ToString() });

            if (dsReceipt.Tables[0].Rows.Count > 0)
            {


                string strName = dsReceipt.Tables[0].Rows[0]["Name"].ToString();
                string strDoorNo = dsReceipt.Tables[0].Rows[0]["DoorNo"].ToString();
                string strReceiptNo = dsReceipt.Tables[0].Rows[0]["ReceiptNo"].ToString();
                DateTime dReceiptDate = Convert.ToDateTime(dsReceipt.Tables[0].Rows[0]["TXDATE"].ToString());
                string strNarration = dsReceipt.Tables[0].Rows[0]["TXDESC"].ToString();
                string strPayMode = dsReceipt.Tables[0].Rows[0]["BCode"].ToString();
                string strAmount = dsReceipt.Tables[0].Rows[0]["TXAMOUNT"].ToString();
                string strcname = dsReceipt.Tables[1].Rows[0]["CommunityName"].ToString();
                string strphone = dsReceipt.Tables[1].Rows[0]["FromMobileNo"].ToString();
                string stremail = dsReceipt.Tables[1].Rows[0]["FromID"].ToString();
                string stramtinwords = dsReceipt.Tables[0].Rows[0]["AmtInWords"].ToString();
                string strNo = dsReceipt.Tables[0].Rows[0]["No"].ToString();
                string strDate = dsReceipt.Tables[0].Rows[0]["Date"].ToString();
                string strBankandBranch = dsReceipt.Tables[0].Rows[0]["BankandBranch"].ToString();

                string strRemarks = "";

                if (strPayMode == "CHEQUE")
                {
                    strRemarks = " Cheque No:" + strNo.ToString() + " Cheque Date:" + strDate.ToString() + " Bank and Branch:" + strBankandBranch.ToString() + " " + strNarration.ToString();
                }
                else if (strPayMode == "TRANSFER")
                {
                    strRemarks = " Ref No:" + strNo.ToString() + " Ref Date:" + strDate.ToString() + " Bank and Branch:" + strBankandBranch.ToString() + " " + strNarration.ToString();
                }

                else
                {
                    strRemarks = strNarration.ToString();
                }




                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        StringBuilder sb = new StringBuilder();

                        //Generate Invoice (Bill) Header.

                        sb.Append("<table width='100%' align=center cellspacing='0' cellpadding='2'>");
                        sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>");
                        sb.Append(strcname);
                        sb.Append("</b></td></tr>");
                        sb.Append("<tr><td align='center' colspan='2'>Mobile:");
                        sb.Append(strphone);
                        sb.Append("</td></tr>");
                        sb.Append("<tr><td align='center' colspan='2'>Email:");
                        sb.Append(stremail);
                        sb.Append("<tr><td align='center' colspan = '2'><b>Cash Receipt</b>");
                        sb.Append("</td></tr>");
                        sb.Append("</td></tr>");
                        sb.Append("<tr><td><b>Receipt No: </b>");
                        sb.Append(strReceiptNo);
                        sb.Append("</td><td align = 'right'><b>Date: </b>");
                        sb.Append(dReceiptDate.ToString("dd/MM/yyyy"));
                        sb.Append("</td></tr>");
                        sb.Append("</table>");
                        sb.Append("<br />");


                        sb.Append("<table width='100%' cellspacing='0' cellpadding='2' border='0.5'>");
                        sb.Append("<tr><td ><b>Received From:</b></td>");
                        sb.Append("<td>");
                        sb.Append(strName);
                        sb.Append("</td></tr>");
                        sb.Append("<tr><td ><b>Door No:</b></td>");
                        sb.Append("<td>");
                        sb.Append(strDoorNo);
                        sb.Append("</td></tr>");
                        sb.Append("<tr><td ><b>Amount:</b></td>");
                        sb.Append("<td>");
                        sb.Append(strAmount);
                        sb.Append("</td></tr>");
                        //sb.Append("<tr><td ><b>Payment Mode:</b></td>");
                        //sb.Append("<td>");
                        //sb.Append(strPayMode);
                        //sb.Append("</td></tr>");
                        sb.Append("<tr><td ><b>Remarks:</b></td>");
                        sb.Append("<td>");
                        sb.Append(strRemarks);
                        sb.Append("</td></tr>");
                        sb.Append("</table>");
                        sb.Append("<br/>");

                        sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
                        sb.Append("<tr><td align='left' ><b>Amount Received : </b><u>");
                        sb.Append(stramtinwords);
                        sb.Append("</u></td></tr>");
                        sb.Append("</table>");
                        sb.Append("<br/>");


                        sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
                        sb.Append("<tr><td align='right' ><b>Signed By</b></td></tr>");
                        sb.Append("</table>");
                        sb.Append("<br/>");

                        sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
                        sb.Append("<tr><td>User ID :");
                        sb.Append(Session["UserID"].ToString());
                        sb.Append("</td><td align='right'>Date :");
                        sb.Append(DateTime.Now.ToString());
                        sb.Append("</td></tr>");
                        sb.Append("</table>");
                        sb.Append("<br/>");

                        sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
                        sb.Append("<tr><td align='center' ><b>----------------------------</b></td></tr>");
                        sb.Append("</table>");


                        sb.Append("<table width='100%' align=center cellspacing='0' cellpadding='2'>");
                        sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>");
                        sb.Append(strcname);
                        sb.Append("</b></td></tr>");
                        sb.Append("<tr><td align='center' colspan='2'>Mobile:");
                        sb.Append(strphone);
                        sb.Append("</td></tr>");
                        sb.Append("<tr><td align='center' colspan='2'>Email:");
                        sb.Append(stremail);
                        sb.Append("<tr><td align='center' colspan = '2'><b>Cash Receipt</b>");
                        sb.Append("</td></tr>");
                        sb.Append("</td></tr>");
                        sb.Append("<tr><td><b>Receipt No: </b>");
                        sb.Append(strReceiptNo);
                        sb.Append("</td><td align = 'right'><b>Date: </b>");
                        sb.Append(dReceiptDate.ToString("dd/MM/yyyy"));
                        sb.Append("</td></tr>");
                        sb.Append("</table>");
                        sb.Append("<br />");
                        sb.Append("<br />");


                        sb.Append("<table width='100%' cellspacing='0' cellpadding='2' border='0.5'>");
                        sb.Append("<tr><td ><b>Received From:</b></td>");
                        sb.Append("<td>");
                        sb.Append(strName);
                        sb.Append("</td></tr>");
                        sb.Append("<tr><td ><b>Door No:</b></td>");
                        sb.Append("<td>");
                        sb.Append(strDoorNo);
                        sb.Append("</td></tr>");
                        sb.Append("<tr><td ><b>Amount:</b></td>");
                        sb.Append("<td>");
                        sb.Append(strAmount);
                        sb.Append("</td></tr>");
                        //sb.Append("<tr><td ><b>Payment Mode:</b></td>");
                        //sb.Append("<td>");
                        //sb.Append(strPayMode);
                        //sb.Append("</td></tr>");
                        sb.Append("<tr><td ><b>Remarks:</b></td>");
                        sb.Append("<td>");
                        sb.Append(strRemarks);
                        sb.Append("</td></tr>");
                        sb.Append("</table>");
                        sb.Append("<br/>");

                        sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
                        sb.Append("<tr><td align='left' ><b>Amount Received : </b><u>");
                        sb.Append(stramtinwords);
                        sb.Append("</u></td></tr>");
                        sb.Append("</table>");
                        sb.Append("<br/>");


                        sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
                        sb.Append("<tr><td align='right' ><b>Signed By</b></td></tr>");
                        sb.Append("</table>");
                        sb.Append("<br/>");

                        sb.Append("<table width='100%' cellspacing='0' cellpadding='2' >");
                        sb.Append("<tr><td>User ID :");
                        sb.Append(Session["UserID"].ToString());
                        sb.Append("</td><td align='right'>Date :");
                        sb.Append(DateTime.Now.ToString());
                        sb.Append("</td></tr>");
                        sb.Append("</table>");




                        ////Generate Invoice (Bill) Items Grid.
                        //sb.Append("<table border = '1'>");
                        //sb.Append("<tr>");
                        //foreach (DataColumn column in dt.Columns)
                        //{
                        //    sb.Append("<th style = 'background-color: #D20B0C;color:#ffffff'>");
                        //    sb.Append(column.ColumnName);
                        //    sb.Append("</th>");
                        //}
                        //sb.Append("</tr>");
                        //foreach (DataRow row in dt.Rows)
                        //{
                        //    sb.Append("<tr>");
                        //    foreach (DataColumn column in dt.Columns)
                        //    {
                        //        sb.Append("<td>");
                        //        sb.Append(row[column]);
                        //        sb.Append("</td>");
                        //    }
                        //    sb.Append("</tr>");
                        //}
                        //sb.Append("<tr><td align = 'right' colspan = '");
                        //sb.Append(dt.Columns.Count - 1);
                        //sb.Append("'>Total</td>");
                        //sb.Append("<td>");
                        //sb.Append(dt.Compute("sum(Total)", ""));
                        //sb.Append("</td>");
                        //sb.Append("</tr></table>");

                        //Export HTML String as PDF.
                        StringReader sr = new StringReader(sb.ToString());
                        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                        PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                        pdfDoc.Open();
                        htmlparser.Parse(sr);
                        pdfDoc.Close();
                        Response.ContentType = "application/pdf";
                        Response.AddHeader("content-disposition", "attachment;filename=Receipt_" + strReceiptNo.ToString() + ".pdf");
                        Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        Response.Write(pdfDoc);
                        Response.End();
                    }
                }


                //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Transactions details saved successfully');", true);

                //// WebMsgBox.Show("Transactions details saved successfully");
                //ClearTransScr();
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LnkSessionMenuforday_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkEdititemBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdititemBtn.NamingContainer;

            // TableCell cell=(TableCell)row[""]

            LinkButton lnkstatus = (LinkButton)row.FindControl("LnkSessionMenuforday");

            string Status;
            Status = lnkstatus.Text;



            Session["SessionName"] = row.Cells[2].Text;


            string sessioncode = lnkstatus.CommandArgument.ToString();


            Session["SessionCode"] = sessioncode.ToString();


            if (Status == "Click to Set")
            {
                panNotSet.Visible = true;
                PanAddMenufordays.Visible = true;
                panSet.Visible = false;
                panEditMenufordays.Visible = false;

                LoadDate(sessioncode);


                LoadMenuItems(sessioncode);

                string strTotalDiners = "0";
                int iMainItem = 0;
                int iSubItem = 0;

                foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
                {

                    strTotalDiners = item["Diners"].Text.ToString();
                    string strCategory = item["Category"].Text.ToString();

                    if (strCategory.ToString() == "Main")
                    {
                        iMainItem = iMainItem + 1;
                    }

                    if (strCategory.ToString() == "Sub")
                    {
                        iSubItem = iSubItem + 1;
                    }



                }


                lblATotalDiners.Text = Session["SessionName"].ToString();

                // lblATotalDiners.Text = "Estimated Diners:" + strTotalDiners.ToString();
                //lblAMainItem.Text = "  Main Items:" + iMainItem.ToString();
                // lblASubItem.Text = "  Sub Items:" + iSubItem.ToString();

            }
            else
            {
                panNotSet.Visible = false;
                PanAddMenufordays.Visible = false;
                panSet.Visible = true;
                panEditMenufordays.Visible = true;


                DateTime date = dtpmenuforday.SelectedDate.Value;
                string strSession = Session["SessionName"].ToString();

                LoadEditMenufordayItems(date, sessioncode);

                string strTotalDiners = "0";
                int iMainItem = 0;
                int iSubItem = 0;

                foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
                {
                    if (item.Selected)
                    {
                        strTotalDiners = item["Diners"].Text.ToString();
                        string strCategory = item["Category"].Text.ToString();

                        if (strCategory.ToString() == "Main")
                        {
                            iMainItem = iMainItem + 1;
                        }

                        if (strCategory.ToString() == "Sub")
                        {
                            iSubItem = iSubItem + 1;
                        }


                    }
                }


                lblTotalDiners.Text = Session["SessionName"].ToString();

                //lblTotalDiners.Text = "Estimated Diners:" + strTotalDiners.ToString();
                //lblMainItem.Text = " Main Items:" + iMainItem.ToString();
                //lblSubItem.Text = " Sub Items:" + iSubItem.ToString();
            }





        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void chkCopyType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (chkCopyType.SelectedValue == "1")
        {
            dvWeekly.Visible = true;
            dvDaily.Visible = false;
        }
        else
        {
            dvWeekly.Visible = false;
            dvDaily.Visible = true;
        }
    }

    private void LoadPayMode()
    {
        try
        {

            if (ddlPayMode.SelectedValue == "CASH")
            {
                lblNo.Visible = false;
                lblDate.Visible = false;
                lblBankandBranch.Visible = false;

                lblSNo.Visible = false;
                lblSDate.Visible = false;
                lblSBankandBranch.Visible = false;

                txtNo.Visible = false;
                dtpDate.Visible = false;
                txtBankandBranch.Visible = false;

                txtNo.Text = "";
                dtpDate.SelectedDate = null;
                txtBankandBranch.Text = "";
            }
            else if (ddlPayMode.SelectedValue == "CHEQUE")
            {
                lblNo.Visible = true;
                lblDate.Visible = true;
                lblBankandBranch.Visible = true;

                lblSNo.Visible = true;
                lblSDate.Visible = true;
                lblSBankandBranch.Visible = true;

                txtNo.Visible = true;
                dtpDate.Visible = true;
                txtBankandBranch.Visible = true;


                lblNo.Text = "Cheque No";
                lblDate.Text = "Cheque Date";
                lblBankandBranch.Text = "Bank and Branch";
            }
            else if (ddlPayMode.SelectedValue == "TRANSFER")
            {
                lblNo.Visible = true;
                lblDate.Visible = true;
                lblBankandBranch.Visible = true;

                lblSNo.Visible = true;
                lblSDate.Visible = true;
                lblSBankandBranch.Visible = true;

                txtNo.Visible = true;
                dtpDate.Visible = true;
                txtBankandBranch.Visible = true;


                lblNo.Text = "Ref No";
                lblDate.Text = "Ref Date";
                lblBankandBranch.Text = "Bank and Branch";
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadPayMode();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnAddMore_Click(object sender, EventArgs e)
    {
        try
        {

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

    protected void lnkprofile_Click(object sender, EventArgs e)
    {

        try
        {


            string strrsnfilter = racAPResident.Text;

            string[] custrsn = strrsnfilter.Split(',');

            strrsnfilter = custrsn[3].ToString();

            custrsn = strrsnfilter.Split(';');

            Int32 rsn = Convert.ToInt32(custrsn[0].ToString());

            Session["RTRSN"] = rsn.ToString();

            DataSet dsSpecialReport = sqlobj.ExecuteSP("SP_ResidentSpecialReport",
                  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

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

    protected void lnkpro_Click(object sender, EventArgs e)
    {
        try
        {


            //string strrsnfilter = DdlUhid.Text;

            //string[] custrsn = strrsnfilter.Split(',');

            //strrsnfilter = custrsn[3].ToString();

            //custrsn = strrsnfilter.Split(';');

            //Int32 rsn = Convert.ToInt32(custrsn[0].ToString());

            //DataSet dsSpecialReport = sqlobj.ExecuteSP("SP_ResidentSpecialReport",
            //      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = rsn.ToString() });

            //if (dsSpecialReport.Tables[0].Rows.Count > 0)
            //{

            //    lblRName.Text = dsSpecialReport.Tables[0].Rows[0]["Name"].ToString();
            //    lblRStatus.Text = dsSpecialReport.Tables[0].Rows[0]["RStatus"].ToString();
            //    lblRDoorNo.Text = dsSpecialReport.Tables[0].Rows[0]["DoorNo"].ToString();

            //    rgSpecialReport.DataSource = dsSpecialReport;
            //    rgSpecialReport.DataBind();

            //    rwSpecialReport.Visible = true;
            //}
            //else
            //{
            //    rgSpecialReport.DataSource = string.Empty;
            //    rwSpecialReport.DataBind();


            //    rwSpecialReport.Visible = false;
            //}

            //dsSpecialReport.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgFoodTransaction_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {

                string bm = ddlBillingMonth.SelectedValue;
                string[] sbm = bm.Split(',');

                string strrsnfilter = "";

                string doorno = "";

                if (cmbFTResident.SelectedValue != "0")
                {

                    strrsnfilter = cmbFTResident.SelectedItem.Text;

                    string[] custrsn = strrsnfilter.Split(',');

                    string custname = custrsn[0].ToString();

                     doorno = custrsn[1].ToString();

                }

                DataSet dsFoodTransaction = sqlobj.ExecuteSP("SP_GetFoodTransactionDetails",
                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbFTResident.SelectedValue == "0" ? null : cmbFTResident.SelectedValue },
                      new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlTSession.SelectedValue == "All" ? null : ddlTSession.SelectedValue },
                      new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = cmbFTResident.SelectedValue == "0" ? null : doorno.ToString() },
                      new SqlParameter() { ParameterName = "@BillingMonth", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingMonth.SelectedValue == "0" ? null : sbm[0].ToString() },
                      new SqlParameter() { ParameterName = "@BillingStatus", SqlDbType = SqlDbType.NVarChar, Value = sbm[1].ToString() }
                      );

                if (dsFoodTransaction.Tables[0].Rows.Count > 0)
                {
                        GridDataItem dataBoundItem = e.Item as GridDataItem;
                        if (dataBoundItem["RegularAmount"].Text == "0.00")
                        {
                            dataBoundItem["RegularAmount"].BackColor = Color.LightGray; // chanmge particuler cell
                        }
                        if (dataBoundItem["CasualAmount"].Text == "0.00")
                        {
                            dataBoundItem["CasualAmount"].BackColor = Color.LightGray; // chanmge particuler cell
                        }
                        if (dataBoundItem["GuestAmount"].Text == "0.00")
                        {
                            dataBoundItem["GuestAmount"].BackColor = Color.LightGray; // chanmge particuler cell
                        }
                        if (dataBoundItem["TotalAmount"].Text == "0.00")
                        {
                            dataBoundItem["TotalAmount"].BackColor = Color.LightGray; // chanmge particuler cell
                        }

                    
                }

                dsFoodTransaction.Dispose();

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgFoodTransaction_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadDiningBills();
    }
}