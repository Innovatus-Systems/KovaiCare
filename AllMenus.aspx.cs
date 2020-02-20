using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;

public partial class AllMenus : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

           

            if (!IsPostBack)
            {

                string currPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
                Session["HomePage"] = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath + currPage;


                LoadMenus();


             


                rgResidents.Visible = false;
                rgDining.Visible = false;
                rgBillingandReceipts.Visible = false;
                rgHousekeeping.Visible = false;
                rgevents.Visible = false;
                rgreports.Visible = false;
                rgsettings.Visible = false;


                

                //LoadSession();

                CheckBillingType();

                
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadMenus()
    {
        try
        {
            DataSet dsmenus = sqlobj.ExecuteSP("SP_LoadProgMenus");

            if (dsmenus.Tables[0].Rows.Count > 0)
            {
                rgResidents.DataSource = dsmenus.Tables[0];
                rgResidents.DataBind();

                rcResidents.DataSource = dsmenus.Tables[0];
                rcResidents.DataTextField = "Title";
                rcResidents.DataValueField = "MenuID";
                rcResidents.DataBind();

            }
            else
            {
                rgResidents.DataSource = string.Empty;
                rgResidents.DataBind();
            }

            DataView dvresidents = dsmenus.Tables[0].DefaultView;
            dvresidents.RowFilter = "IsVisible='" + 2 + "'";
            foreach (DataRowView dr in dvresidents)
            {
                foreach (RadComboBoxItem item in rcResidents.Items)
                {
                    if (dr["MenuID"].ToString() == item.Value.ToString())
                    {
                        item.Attributes.Add("style", "background-color:#FFFF2A;font-weight:bold;");
                    }
                }
            }


            rcResidents.Items.Insert(0, new RadComboBoxItem("--Select--", string.Empty));


            if (dsmenus.Tables[1].Rows.Count > 0)
            {
                rgDining.DataSource = dsmenus.Tables[1];
                rgDining.DataBind();


                rcDining.DataSource = dsmenus.Tables[1];
                rcDining.DataTextField = "Title";
                rcDining.DataValueField = "MenuID";
                rcDining.DataBind();
            }
            else
            {
                rgDining.DataSource = string.Empty;
                rgDining.DataBind();


            }

            DataView dv = dsmenus.Tables[1].DefaultView;
            dv.RowFilter = "IsVisible='" + 2 + "'";
            foreach (DataRowView dr in dv)
            {
                foreach (RadComboBoxItem item in rcDining.Items)
                {
                    if (dr["MenuID"].ToString() == item.Value.ToString())
                    {
                        item.Attributes.Add("style", "background-color:#FFFF2A;font-weight:bold;");
                    }
                }
            }


            rcDining.Items.Insert(0, new RadComboBoxItem("--Select--", string.Empty));

            if (dsmenus.Tables[2].Rows.Count > 0)
            {
                rgBillingandReceipts.DataSource = dsmenus.Tables[2];
                rgBillingandReceipts.DataBind();


                rcBillingandReceipts.DataSource = dsmenus.Tables[2];
                rcBillingandReceipts.DataTextField = "Title";
                rcBillingandReceipts.DataValueField = "MenuID";
                rcBillingandReceipts.DataBind();
            }
            else
            {
                rgBillingandReceipts.DataSource = string.Empty;
                rgBillingandReceipts.DataBind();
            }


            DataView dvBillingandReceipts = dsmenus.Tables[2].DefaultView;
            dvBillingandReceipts.RowFilter = "IsVisible='" + 2 + "'";
            foreach (DataRowView dr in dvBillingandReceipts)
            {
                foreach (RadComboBoxItem item in rgBillingandReceipts.Items)
                {
                    if (dr["MenuID"].ToString() == item.Value.ToString())
                    {
                        item.Attributes.Add("style", "background-color:#FFFF2A;font-weight:bold;");
                    }
                }
            }


            rcBillingandReceipts.Items.Insert(0, new RadComboBoxItem("--Select--", string.Empty));

           

            if (dsmenus.Tables[5].Rows.Count > 0)
            {
                rgHousekeeping.DataSource = dsmenus.Tables[5];
                rgHousekeeping.DataBind();

                rcHouseKeeping.DataSource = dsmenus.Tables[5];
                rcHouseKeeping.DataTextField = "Title";
                rcHouseKeeping.DataValueField = "MenuID";
                rcHouseKeeping.DataBind();
            }
            else
            {
                rgHousekeeping.DataSource = string.Empty;
                rgHousekeeping.DataBind();
            }


            DataView dvHouseKeeping = dsmenus.Tables[5].DefaultView;
            dvHouseKeeping.RowFilter = "IsVisible='" + 2 + "'";
            foreach (DataRowView dr in dvHouseKeeping)
            {
                foreach (RadComboBoxItem item in rgHousekeeping.Items)
                {
                    if (dr["MenuID"].ToString() == item.Value.ToString())
                    {
                        item.Attributes.Add("style", "background-color:#FFFF2A;font-weight:bold;");
                    }
                }
            }


            rcHouseKeeping.Items.Insert(0, new RadComboBoxItem("--Select--", string.Empty));

            if (dsmenus.Tables[6].Rows.Count > 0)
            {
                rgevents.DataSource = dsmenus.Tables[6];
                rgevents.DataBind();

                rcEvents.DataSource = dsmenus.Tables[6];
                rcEvents.DataTextField = "Title";
                rcEvents.DataValueField = "MenuID";
                rcEvents.DataBind();
            }
            else
            {
                rgevents.DataSource = string.Empty;
                rgevents.DataBind();
            }


            DataView dvEvents = dsmenus.Tables[6].DefaultView;
            dvEvents.RowFilter = "IsVisible='" + 2 + "'";
            foreach (DataRowView dr in dvEvents)
            {
                foreach (RadComboBoxItem item in rcEvents.Items)
                {
                    if (dr["MenuID"].ToString() == item.Value.ToString())
                    {
                        item.Attributes.Add("style", "background-color:#FFFF2A;font-weight:bold;");
                    }
                }
            }

            rcEvents.Items.Insert(0, new RadComboBoxItem("--Select--", string.Empty));

            if (dsmenus.Tables[7].Rows.Count > 0)
            {
                rgreports.DataSource = dsmenus.Tables[7];
                rgreports.DataBind();

                rcReports.DataSource = dsmenus.Tables[7];
                rcReports.DataTextField = "Title";
                rcReports.DataValueField = "MenuID";
                rcReports.DataBind();

            }
            else
            {
                rgreports.DataSource = string.Empty;
                rgreports.DataBind();
            }

            DataView dvReports = dsmenus.Tables[7].DefaultView;
            dvReports.RowFilter = "IsVisible='" + 2 + "'";
            foreach (DataRowView dr in dv)
            {
                foreach (RadComboBoxItem item in rcReports.Items)
                {
                    if (dr["MenuID"].ToString() == item.Value.ToString())
                    {
                        item.Attributes.Add("style", "background-color:#FFFF2A;font-weight:bold;");
                    }
                }
            }

            rcReports.Items.Insert(0, new RadComboBoxItem("--Select--", string.Empty));



            if (dsmenus.Tables[9].Rows.Count > 0)
            {
                rgsettings.DataSource = dsmenus.Tables[9];
                rgsettings.DataBind();


                rcSettings.DataSource = dsmenus.Tables[9];
                rcSettings.DataTextField = "Title";
                rcSettings.DataValueField = "MenuID";
                rcSettings.DataBind();
            }
            else
            {
                rgsettings.DataSource = string.Empty;
                rgsettings.DataBind();
            }

            DataView dvSettings = dsmenus.Tables[9].DefaultView;
            dvSettings.RowFilter = "IsVisible='" + 2 + "'";
            foreach (DataRowView dr in dv)
            {
                foreach (RadComboBoxItem item in rcSettings.Items)
                {
                    if (dr["MenuID"].ToString() == item.Value.ToString())
                    {
                        item.Attributes.Add("style", "background-color:#FFFF2A;font-weight:bold;");
                    }
                }
            }

            rcSettings.Items.Insert(0, new RadComboBoxItem("--Select--", string.Empty));


            dsmenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void rgResidents_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void rgDining_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void rgBillingandReceipts_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void rgcareandsafety_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void rgservices_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void rgHousekeeping_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void rgevents_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void rgreports_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void rgCharts_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void rgsettings_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();

            Session["MenuID"] = hbtnRSN.Value.ToString();

            if (e.Item is GridDataItem)
            {


                DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = hbtnRSN.Value });


                if (dsMenus.Tables[0].Rows.Count > 0)
                {
                    string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                    string[] path = strpath.Split('/');

                    Response.Redirect(path[1].ToString(), false);

                }

                dsMenus.Dispose();


            }
        }
    }
    protected void lnksnapshot_Click(object sender, EventArgs e)
    {
        Response.Redirect("SnapShot.aspx", false);
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
    protected void lnktiles_Click(object sender, EventArgs e)
    {
        Response.Redirect("HomeMenu.aspx", false);
    }


    protected void btnDinersUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["MenuBillingType"].ToString() == "S")
            {

                //rwDinersUpdate.Visible = true;
            }
            else
            {
                WebMsgBox.Show("Sorry!  Billing is A la carte (Menu ) based for this residential community. Hence Session based Booking is not permitted.");
            }
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
            //LoadSession();

            //rwDinersUpdate.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
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
   
    

    private void LoadDiners(DateTime ddate, string ssession)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_GetDinersdetailsessionwise",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = ddate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ssession.ToString() }

                );

            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {
                //rgDiners.DataSource = dsFetchSE.Tables[0];
                //rgDiners.DataBind();
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
            //rwDinersUpdate.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void ClearDiners()
    {


        //ddlDinersSession.SelectedIndex = 0;

        //ddlByDoorNo.SelectedIndex = 0;

        //ddlByName.SelectedIndex = 0;

        //chkByDoorNo.Checked = false;
        //chkByName.Checked = false;

        //ddlDiner.SelectedIndex = 0;
        //ddlGuest.SelectedIndex = 0;

        //chkByDoorNo.Enabled = false;
        //chkByName.Enabled = false;

        //ddlByDoorNo.Enabled = false;
        //ddlByName.Enabled = false;

        //lbldiningmsg.Text = "";


    }

   

    protected void btnDinersBooking_Click(object sender, EventArgs e)
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();



            DataSet dsConfirmDiningR = sqlobj.ExecuteSP("SP_GetSessionForResident",
                 new SqlParameter() { ParameterName = "@Time", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now.ToString("HH:mm") }

                 );

            if (dsConfirmDiningR.Tables[0].Rows.Count > 0)
            {

                Session["SessionCode"] = dsConfirmDiningR.Tables[0].Rows[0]["SessionCode"].ToString();
                Session["SessionName"] = dsConfirmDiningR.Tables[0].Rows[0]["SessionName"].ToString();

                Page.ClientScript.RegisterStartupScript(
    this.GetType(), "OpenWindow", "window.open('ConfirmDiningR.aspx','_newtab');", true);
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    protected void btnSnapshot_Click(object sender, EventArgs e)
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
    protected void rtResidents_Click(object sender, EventArgs e)
    {
        try
        {
            rgResidents.Visible = true;
            rgDining.Visible = false;
            rgBillingandReceipts.Visible = false;
            rgHousekeeping.Visible = false;
            rgevents.Visible = false;
            rgreports.Visible = false;
            rgsettings.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rtDining_Click(object sender, EventArgs e)
    {
        try
        {
            rgResidents.Visible = false;
            rgDining.Visible = true;
            rgBillingandReceipts.Visible = false;
            rgHousekeeping.Visible = false;
            rgevents.Visible = false;
            rgreports.Visible = false;
            rgsettings.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rtBillingandReceipts_Click(object sender, EventArgs e)
    {
        try
        {
            rgResidents.Visible = false;
            rgDining.Visible = false;
            rgBillingandReceipts.Visible = true;
            rgHousekeeping.Visible = false;
            rgevents.Visible = false;
            rgreports.Visible = false;
            rgsettings.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rtHouseKeeping_Click(object sender, EventArgs e)
    {
        try
        {
            rgResidents.Visible = false;
            rgDining.Visible = false;
            rgBillingandReceipts.Visible = false;
            rgHousekeeping.Visible = true;
            rgevents.Visible = false;
            rgreports.Visible = false;
            rgsettings.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rtEvents_Click(object sender, EventArgs e)
    {
        try
        {
            rgResidents.Visible = false;
            rgDining.Visible = false;
            rgBillingandReceipts.Visible = false;
            rgHousekeeping.Visible = false;
            rgevents.Visible = true;
            rgreports.Visible = false;
            rgsettings.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rtReports_Click(object sender, EventArgs e)
    {
        try
        {
            rgResidents.Visible = false;
            rgDining.Visible = false;
            rgBillingandReceipts.Visible = false;
            rgHousekeeping.Visible = false;
            rgevents.Visible = false;
            rgreports.Visible = true;
            rgsettings.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rtSettings_Click(object sender, EventArgs e)
    {
        try
        {
            rgResidents.Visible = false;
            rgDining.Visible = false;
            rgBillingandReceipts.Visible = false;
            rgHousekeeping.Visible = false;
            rgevents.Visible = false;
            rgreports.Visible = false;
            rgsettings.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rcResidents_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {

            DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = rcResidents.SelectedValue });


            if (dsMenus.Tables[0].Rows.Count > 0)
            {
                string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                string[] path = strpath.Split('/');

                Response.Redirect(path[1].ToString(), false);

            }

            dsMenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rcDining_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                   new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = rcDining.SelectedValue });


            if (dsMenus.Tables[0].Rows.Count > 0)
            {
                string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                string[] path = strpath.Split('/');

                Response.Redirect(path[1].ToString(), false);

                //Server.Transfer(path[1].ToString(),true);

            }

            dsMenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rcBillingandReceipts_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                   new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = rcBillingandReceipts.SelectedValue });


            if (dsMenus.Tables[0].Rows.Count > 0)
            {
                string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                string[] path = strpath.Split('/');

                Response.Redirect(path[1].ToString(), false);

            }

            dsMenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rcHouseKeeping_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                   new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = rcHouseKeeping.SelectedValue });


            if (dsMenus.Tables[0].Rows.Count > 0)
            {
                string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                string[] path = strpath.Split('/');

                Response.Redirect(path[1].ToString(), false);

            }

            dsMenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rcEvents_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                   new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = rcEvents.SelectedValue });


            if (dsMenus.Tables[0].Rows.Count > 0)
            {
                string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                string[] path = strpath.Split('/');

                Response.Redirect(path[1].ToString(), false);

            }

            dsMenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rcReports_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                   new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = rcReports.SelectedValue });


            if (dsMenus.Tables[0].Rows.Count > 0)
            {
                string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                string[] path = strpath.Split('/');

                Response.Redirect(path[1].ToString(), false);

            }

            dsMenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rcSettings_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsMenus = sqlobj.ExecuteSP("SP_ProgMenus",
                   new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@MenuID", SqlDbType = SqlDbType.NVarChar, Value = rcSettings.SelectedValue });


            if (dsMenus.Tables[0].Rows.Count > 0)
            {
                string strpath = dsMenus.Tables[0].Rows[0]["url"].ToString();

                string[] path = strpath.Split('/');

                Response.Redirect(path[1].ToString(), false);

            }

            dsMenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}