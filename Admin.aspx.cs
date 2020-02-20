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

public partial class Admin : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            CheckPermission();
            LoadHeader();
            //LoadAdminGrid();
            loadAdminDet();
            pnlAdd.Visible = false;
            pnlbtn.Visible = false;
        }

    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 62 });


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

    private void CheckPermission()
    {
        try
        {

            if (Session["UserID"] != null)
            {

                Permission p = new Permission();

                string result = p.GetPermission(Session["UserID"].ToString(), "Settings");
                string result2 = p.GetPermission(Session["UserID"].ToString(), "Settings");

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
    public void LoadHeader()
    {
        try
        {
           
            DataSet dsSection = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            dsSection = proc.ExecuteSP("[SP_AdminEdit_Header]");           
            if (dsSection.Tables[0].Rows.Count > 0)
            {
                lbl1.Text = dsSection.Tables[0].Rows[0]["CommunityName"].ToString();
                lbl1.Font.Bold = true;
                lbl2.Text = dsSection.Tables[0].Rows[0]["Name"].ToString();
                lbl3.Text = dsSection.Tables[0].Rows[0]["Add1"].ToString();
                lbl4.Text = dsSection.Tables[0].Rows[0]["City"].ToString() + " - " + dsSection.Tables[0].Rows[0]["Pincode"].ToString();
                lbl5.Text = "GSTIN/UIN: " + dsSection.Tables[0].Rows[0]["GSTIN_UIN"].ToString() + " / " + "PAN: " + dsSection.Tables[0].Rows[0]["PAN_No"].ToString();          
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    public void loadAdminDet()
    {
        try
        {
            //int RSN = Convert.ToInt32(Session["ADRSN"]);
            DataSet dsSection = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            dsSection = proc.ExecuteSP("[SP_AdminEdit]");
            //DateTime Dtime= Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"]);
            if (dsSection.Tables[0].Rows.Count > 0)
            {

                TxtCommunityName.Text = dsSection.Tables[0].Rows[0]["CommunityName"].ToString();
                TxtFromID.Text = dsSection.Tables[0].Rows[0]["FromID"].ToString();
                TxtFromMobileNo.Text = dsSection.Tables[0].Rows[0]["FromMobileNo"].ToString();
                TxtContactPName.Text = dsSection.Tables[0].Rows[0]["ContactPName"].ToString();
                txtscrollmessage.Text = dsSection.Tables[0].Rows[0]["scrollmsg"].ToString();
                txtStatus.Text = dsSection.Tables[0].Rows[0]["status"].ToString();
                txtUptodate.Text = dsSection.Tables[0].Rows[0]["uptoDate"].ToString();
                txtversionnumber.Text = dsSection.Tables[0].Rows[0]["versionnumber"].ToString();
                //ddlBillingType.SelectedValue = dsSection.Tables[0].Rows[0]["BillingType"].ToString();
                //ddlBillingFrequency.SelectedValue = dsSection.Tables[0].Rows[0]["BillingFrequency"].ToString();
                txtCommnunityName.Text = dsSection.Tables[0].Rows[0]["Name"].ToString();
                txtAddress1.Text = dsSection.Tables[0].Rows[0]["Add1"].ToString();
                txtAddress2.Text = dsSection.Tables[0].Rows[0]["Add2"].ToString();
                txtCity.Text = dsSection.Tables[0].Rows[0]["City"].ToString();
                txtPincode.Text = dsSection.Tables[0].Rows[0]["Pincode"].ToString();
                //txtRatepermeal.Text = dsSection.Tables[0].Rows[0]["RatePerMeal"].ToString();
               // txtnoofmealsperday.Text = dsSection.Tables[0].Rows[0]["NoofMealsPerDay"].ToString();
                //txtminnoofmeals.Text = dsSection.Tables[0].Rows[0]["MinnNoofMeals"].ToString();
                //txtRateException.Text = dsSection.Tables[0].Rows[0]["RateException"].ToString();
                //txthousekeepingratepersqft.Text = dsSection.Tables[0].Rows[0]["HKRT"].ToString();
               // txtmmct.Text = dsSection.Tables[0].Rows[0]["HKRT"].ToString();

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (HRResult.Value == "true")
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            try
            {
                sqlobj.ExecuteSQLNonQuery("SP_InsertAdminDtls",
                                                  new SqlParameter() { ParameterName = "@CommunityName", SqlDbType = SqlDbType.NVarChar, Value = TxtCommunityName.Text },
                                                  new SqlParameter() { ParameterName = "@FromID", SqlDbType = SqlDbType.NVarChar, Value = TxtFromID.Text },
                                                   new SqlParameter() { ParameterName = "@FromMobileNo", SqlDbType = SqlDbType.NVarChar, Value = TxtFromMobileNo.Text },
                                                   new SqlParameter() { ParameterName = "@ContactPName", SqlDbType = SqlDbType.NVarChar, Value = TxtContactPName.Text }
                                                    //new SqlParameter() { ParameterName = "@BillingType", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingType.SelectedValue },
                                                    //new SqlParameter() { ParameterName = "@BillingFrequency", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingFrequency.SelectedValue }
                    //new SqlParameter() { ParameterName = "@NextBillingDate", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = NextBDate.SelectedDate }
                                                 );


                ClearScr();
                //LoadGrid();
                WebMsgBox.Show("Admin Detail Saved Successfully.");

            }
            catch
            {

            }

        }
        else
        { }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();

    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }


    protected void ClearScr()
    {
        TxtContactPName.Text = String.Empty;
        TxtFromID.Text = String.Empty;
        TxtFromMobileNo.Text = String.Empty;
        TxtCommunityName.Text = String.Empty;
        this.TxtCommunityName.Focus();
        //NextBDate.SelectedDate = DateTime.Now;


    }
    //protected void LoadAdminGrid()
    //{

    //    SqlCommand cmd = new SqlCommand("[SP_FetchAdmin]", con);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
    //    DataSet dsGrid = new DataSet();
    //    AdmingrdView.DataBind();

    //    SqlDataAdapter da = new SqlDataAdapter(cmd);

    //    da.Fill(dsGrid);
    //    if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
    //    {

    //        AdmingrdView.DataSource = dsGrid.Tables[0];
    //        AdmingrdView.DataBind();

    //        AdmingrdView.AllowPaging = true;

    //    }
    //    else
    //    {
    //        AdmingrdView.DataSource = new String[] { };
    //        AdmingrdView.DataBind();
    //    }



    //}
    //protected void AdmingrdView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    //{
    //    LoadAdminGrid();
    //}
    //protected void AdmingrdView_ItemCommand(object sender, GridCommandEventArgs e)
    //{
    //    LoadAdminGrid();
    //}
    //protected void AdmingrdView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    //{
    //    LoadAdminGrid();
    //}
    //protected void AdmingrdView_SortCommand(object sender, GridSortCommandEventArgs e)
    //{
    //    LoadAdminGrid();
    //}
    //protected void Lnkbtnedit_Click(object sender, EventArgs e)
    //{
    //    string AdminRSN;
    //    LinkButton LnkEditAdditionalsBtn = (LinkButton)sender;
    //    GridDataItem row = (GridDataItem)LnkEditAdditionalsBtn.NamingContainer;
    //    Session["ADRSN"] = row.Cells[2].Text;
    //    AdminRSN = Session["ADRSN"].ToString();
    //    Response.Redirect("AdminEdit.aspx");
    //}
    protected void RMSettings_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Admin")
        {
            Response.Redirect("Admin.aspx");
        }
        if (e.Item.Text == "Profile ++ LookUp")
        {
            Response.Redirect("AttribLkUpAdd.aspx");
        }
        if (e.Item.Text == "Item Master")
        {
            Response.Redirect("ItemMaster.aspx");
        }
        if (e.Item.Text == "Billing Periods")
        {

        }
        if (e.Item.Text == "Help")
        {

        }
        if (e.Item.Text == "User Management")
        {
            Response.Redirect("~/UserManagement.aspx");
        }
        if (e.Item.Text == "Villa Master")
        {
            Response.Redirect("~/VillaMaster.aspx");
        }
        if (e.Item.Text == "Task List Lookup")
        {
            Response.Redirect("~/TaskLkup.aspx");
        }
        if (e.Item.Text == "Assets")
        {
            Response.Redirect("~/Assets.aspx");
        }
        if (e.Item.Text == "Department Lookup")
        {
            Response.Redirect("~/DeptLkup.aspx");
        }
        if (e.Item.Text == "Service Categories")
        {
            Response.Redirect("~/ServiceConfigLkup.aspx");
        }
        if (e.Item.Text == "Service Types")
        {
            Response.Redirect("~/ServiceConfig.aspx");
        }
    }
}