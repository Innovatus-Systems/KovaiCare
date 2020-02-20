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

public partial class Information_Board : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            string Value;
            Value = Request.QueryString["Value"];
            if(Value == "1")
            {
                //btnreturnfromlevelR.Visible = false;
                LoadGridLevelR();
            }
            else
            {
                //btnreturnfromlevelR.Visible = true;
                LoadGridLevelR();
            }
            

            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsDT = null;
           
            dsDT = proc.ExecuteSP("GetServerDateTime");
            lblSDate.Text = "ORIS Snapshot as of  " + Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd MMM yyyy"); ;
               
        }
    }

    #region Grid load function for LevelR
    protected void LoadGridLevelR()
    {

        SqlCommand cmd = new SqlCommand("SP_FetchLevelRDtls1", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;


        DataSet dsGrid = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            lblOccupiedHouse.Text = dsGrid.Tables[0].Rows[0]["OccupiedHouses"].ToString();
            lblTotResidents.Text = dsGrid.Tables[0].Rows[0]["TotalResidents"].ToString();
            lblBilledFor.Text = dsGrid.Tables[0].Rows[0]["BilledFor"].ToString();
            lblTotBilling.Text = dsGrid.Tables[0].Rows[0]["Totalbilling"].ToString();
            lblAmountcollected.Text = dsGrid.Tables[0].Rows[0]["Amountcollected"].ToString();
            lblOutstanding.Text = dsGrid.Tables[0].Rows[0]["Outstanding"].ToString();
            lblYetToBill.Text = dsGrid.Tables[0].Rows[0]["YetToBill"].ToString();
            lblAboveEighty.Text = dsGrid.Tables[0].Rows[0]["AbvEighty"].ToString();

            //lbldispTotalnumberofresidents.Text = dsGrid.Tables[0].Rows[0]["Totalnumberofresidents"].ToString();
            //lbldispOwnersresiding.Text = dsGrid.Tables[0].Rows[0]["Ownersresiding"].ToString();
            //lbldispTenantsresiding.Text = dsGrid.Tables[0].Rows[0]["Tenantsresiding"].ToString();
            //lbldispDependents.Text = dsGrid.Tables[0].Rows[0]["Dependents"].ToString();
            lbldispResidentslivingalone.Text = dsGrid.Tables[0].Rows[0]["Residentslivingalone"].ToString();
            //lbldispLastbillingmonth.Text = dsGrid.Tables[0].Rows[0]["Lastbillingmonth"].ToString();
            //lbldispBilledamountforthebillingmonth.Text = dsGrid.Tables[0].Rows[0]["Billedamountforthebillingmonth"].ToString();
            //lbldispOutstandingsasofnow.Text = dsGrid.Tables[0].Rows[0]["OutstandingsasofnowCnvrtd"].ToString();
            lbldispOwnersnotresiding.Text = dsGrid.Tables[0].Rows[0]["Ownersnotresiding"].ToString();
            //lbldispTenantsawayforsometime.Text = dsGrid.Tables[0].Rows[0]["Tenantsawayforsometime"].ToString();
            lbldispVacantresidences.Text = dsGrid.Tables[0].Rows[0]["Vacantresidences"].ToString();
            lbldispStaffcount.Text = dsGrid.Tables[0].Rows[0]["StaffandOthers"].ToString();
            //lbldispPrevioustenantsandtheirdependents.Text = dsGrid.Tables[0].Rows[0]["Previoustenantstheirdependents"].ToString();
            lbldispopentasks.Text = dsGrid.Tables[0].Rows[0]["Opentaskcount"].ToString();
            lbldispOverdueTasks.Text = dsGrid.Tables[0].Rows[0]["overduetaskcount"].ToString();
            //lbldispTDA.Text = dsGrid.Tables[0].Rows[0]["TenantDependantAway"].ToString();
            //lbldispLBP.Text = dsGrid.Tables[0].Rows[0]["LASTBP"].ToString();
            //lbldispTAON.Text = "Rs." + dsGrid.Tables[0].Rows[0]["TOTALOUTSTANDING"];

        }
        else
        {

        }

    }

    #endregion
    protected void btnreturnfromlevelR_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }


    protected void RMResident_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Information Board")
        {
            Response.Redirect("Information_Board.aspx");
        }
        if (e.Item.Text == "Vacant")
        {
            Response.Redirect("Vacants.aspx");
        }
        if (e.Item.Text == "Staff & Others")
        {
            Response.Redirect("StaffandOthers.aspx");
        }
        if (e.Item.Text == "Owners Away")
        {
            Response.Redirect("OwnersAway.aspx");
        }
        if (e.Item.Text == "Previous Tenants")
        {
            Response.Redirect("PreviousTenants.aspx");
        }
        if (e.Item.Text == "Living Alone")
        {
            Response.Redirect("SAlone.aspx?Value1=" + 2);
        }
        if (e.Item.Text == "Profile ++")
        {
            Response.Redirect("ProfilePP.aspx");
        }
        if (e.Item.Text == "Residents")
        {
            Response.Redirect("ResidentAdd.aspx");
        }

    }
}