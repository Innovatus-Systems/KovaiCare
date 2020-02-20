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
using System.IO;

public partial class CheckINOUT : System.Web.UI.Page
{
    public static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    SqlProcsNew proc = new SqlProcsNew();

    SqlProcsNew sqlobj = new SqlProcsNew();
   
    static string strDoorNo;
    protected void Page_Load(object sender, EventArgs e)
    {

        rwSpecialReport.VisibleOnPageLoad = true;
        rwSpecialReport.Visible = false;

        if(!IsPostBack)
        {
            LoadTitle();
            CheckPermission();
            LoadDoorNo();
            LoadCheckOut();
            strDoorNo = ddlName.SelectedValue;
            //LoadCheckIn(strDoorNo);
            LoadCheckIn(strDoorNo);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = proc.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 33 });


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

                string result = p.GetPermission(Session["UserID"].ToString(), "Care");
                string result2 = p.GetPermission(Session["UserID"].ToString(), "Care");

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
    public void LoadCheckOut()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_CheckinandoutAll",con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 4);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds, "temp");
            if(ds.Tables[0].Rows.Count > 0)
            {
                lblChkIn.Visible = true;
                LblOutCount.Text = "Residents Checked Out as of now :   " + ds.Tables[0].Rows.Count;
                radgrdCheckin.DataSource = ds;
                radgrdCheckin.DataBind();
            }
            else
            {
                lblChkIn.Visible = true;
                LblOutCount.Text = "Residents Checked Out as of now :   0";
                radgrdCheckin.DataSource = ds;
                radgrdCheckin.DataBind();
            }
        }
        catch (Exception ex)
        {
          
        }
    }

    public void LoadDoorNo()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_LoadResident",con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 1);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            dap.Fill(ds, "temp");
            if(ds.Tables[0].Rows.Count > 0)
            {
                ddlName.DataSource = ds.Tables[0];
                ddlName.DataTextField = "RTName";
                ddlName.DataValueField = "RTVILLANO";
                ddlName.DataBind();

                ddlVillaNo.DataSource = ds.Tables[1];
                ddlVillaNo.DataTextField = "RTName";
                ddlVillaNo.DataValueField = "RTVILLANO";
                ddlVillaNo.DataBind();
            }

            ddlName.Items.Insert(0, "--Select--");
            ddlVillaNo.Items.Insert(0, "--Select--");

        }
        catch (Exception ex)
        {
           
        }

    }    
    protected void RMCare_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        if (e.Item.Text == "Checkout register")
        {
            Response.Redirect("CheckINOUT.aspx");
        }
        else if (e.Item.Text == "Living alone")
        {
            Response.Redirect("SAlone.aspx?Value=" + 1);
        }
        else if (e.Item.Text == "Birthdays in 7 days")
        {
            Response.Redirect("BirthdayGrid.aspx");
        }
        else if (e.Item.Text == "Raw material master")
        {
            Response.Redirect("RawMaterial.aspx");
        }
        else if (e.Item.Text == "Raw material menu")
        {
            Response.Redirect("RMMenu.aspx");
        }
        else if (e.Item.Text == "Help")
        {

        }
    }
    protected void ddlName_SelectedIndexChanged(object sender, EventArgs e)
    {
        strDoorNo = ddlName.SelectedValue;
        ddlVillaNo.SelectedValue = ddlName.SelectedValue;
        LoadCheckIn(strDoorNo);
    }
    public void LoadCheckIn(string doorno)
    {
        DataSet dsRadGrid = new DataSet();
        try
        {
            dsRadGrid = proc.ExecuteSP("Proc_GetResident_Checkin", new SqlParameter()
            {
                ParameterName = "@DoorNo",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = doorno
            });
            if(dsRadGrid.Tables[0].Rows.Count > 0)
            {
                lblChkout.Visible = true;
                radgrdCheckout.DataSource = dsRadGrid;
                radgrdCheckout.DataBind();
            }
            else
            {
                lblChkout.Visible = true;
                radgrdCheckout.DataSource = new String[] { };
                radgrdCheckout.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void ddlVillaNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        //strDoorNo = ddlVillaNo.SelectedItem.ToString();
        strDoorNo = ddlVillaNo.SelectedValue.ToString();
        LoadCheckIn(strDoorNo);
    }
    protected void radgrdCheckin_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            GridDataItem item = e.Item as GridDataItem;
            Button lbtnupdate = (Button)e.Item.FindControl("btngrdchkin");
            string test = lbtnupdate.Text;
            if (test == "CheckOut")
            {
                test = "CheckIn";
            }
            else if (test == "CheckIn")
            {
                test = "CheckOut";
            }
            string RTRSN = e.CommandArgument.ToString();
            SqlCommand cmd = new SqlCommand("Proc_CheckinandoutAll", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 3);
            cmd.Parameters.AddWithValue("@RTRSN", RTRSN);
            cmd.Parameters.AddWithValue("@AStatus", lbtnupdate.Text);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            
            lbtnupdate.Enabled = false;
            
           // LoadCheckIn(strDoorNo);
                        
            ddlName.SelectedIndex = 0;
            ddlVillaNo.SelectedIndex = 0;

            LoadCheckOut();
        }
        else if (e.CommandName == "SendSMS")
        {
            GridDataItem item = e.Item as GridDataItem;
            string strName = item["RTName"].Text.ToString();
            DataSet dsAdmin = new DataSet();
            dsAdmin = proc.ExecuteSP("GetAdmindetails");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("Greetings from " + dsAdmin.Tables[0].Rows[0]["CommunityName"].ToString());
            sb.Append("\n");
            sb.Append(".Please do not hesitate to call us for any help " + dsAdmin.Tables[0].Rows[0]["FromMobileNo"].ToString());

            SqlCommand cmd = new SqlCommand("Proc_InsertSMS", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MobNo", e.CommandArgument.ToString());
            //cmd.Parameters.AddWithValue("@MobNo", "9092455984");
            cmd.Parameters.AddWithValue("@SMS", sb.ToString());
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            string msg = "SMS alert sent to " + strName;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "ALert", "alert('"+ msg +"');", true);
        }
        else
        {
            LoadCheckOut();
        }
    }
    protected void radgrdCheckout_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            GridDataItem item = e.Item as GridDataItem;
            Button lbtnupdate = (Button)e.Item.FindControl("btngrdchkout");
            //string test = lbtnupdate.Text;
            //if (test == "CheckOut")
            //{
            //    test = "CheckIn";
            //}
            //else if (test == "CheckIn")
            //{
            //    test = "CheckOut";
            //}
            string RTRSN = e.CommandArgument.ToString();
            SqlCommand cmd = new SqlCommand("Proc_CheckinandoutAll", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 1);
            cmd.Parameters.AddWithValue("@RTRSN", RTRSN);
            cmd.Parameters.AddWithValue("@AStatus", lbtnupdate.Text);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //lbtnupdate.Text = test;
            LoadCheckIn(strDoorNo);

            
            LoadCheckOut();
            lbtnupdate.Enabled = false;
            //LoadCheckOut();
        }
        else
        {
            LoadCheckIn(strDoorNo);
        }
    }
    protected void lbtnName_Click(object sender, EventArgs e)
    {
        try
        {
            string CustomerRSN;
            LinkButton lnkOpenProjBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
            Session["ResidentRSN"] = lnkOpenProjBtn.CommandName.ToString();
            CustomerRSN = Session["ResidentRSN"].ToString();

            DataSet dsSpecialReport = sqlobj.ExecuteSP("SP_ResidentSpecialReport",
                    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = CustomerRSN.ToString() });

            if (dsSpecialReport.Tables[0].Rows.Count > 0)
            {
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
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void radgrdCheckout_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = radgrdCheckout.FilterMenu;
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
    protected void radgrdCheckin_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = radgrdCheckin.FilterMenu;
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