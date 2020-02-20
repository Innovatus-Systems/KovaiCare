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



public partial class BillingLevel : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSession();
            BindGeneralInformation();
        
        }
        
    }


    protected void Cmb_DataBound(object sender, EventArgs e)
    {
        var combo = (DropDownList)sender;
        combo.Items.Insert(0, "-- Select --");
    }

    #region Load Session drop down
    protected void LoadSession()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistStatus = new DataSet();

            ddlistStatus = sqlobj.ExecuteSP("SP_FetchSessionDropDown",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 });
            ddlSession.DataSource = ddlistStatus.Tables[0];
            ddlSession.DataValueField = "SCode";
            ddlSession.DataTextField = "SDescription";
            ddlSession.DataBind();
            ddlSession.Dispose();
            ddlSession.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    #endregion
    protected void BindGeneralInformation()
    {
        int RSN = Convert.ToInt32(Session["ResidentRSN"]);
        try
        {
            DataSet dsProfile = new DataSet();
            DataSet dsKTSection = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            dsProfile = proc.ExecuteSP("[SP_FetchVSNDet]", new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = RSN });
            //string TotAmount2;

            if (dsProfile.Tables[0].Rows.Count > 0)
            {


                lblVN1.Text = dsProfile.Tables[0].Rows[0]["RTVILLANO"].ToString();
                lblST1.Text = dsProfile.Tables[0].Rows[0]["RStatus"].ToString();
                lblNME1.Text = dsProfile.Tables[0].Rows[0]["Name"].ToString();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void BillingListView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

    }
    protected void BillingListView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
      {


      }
    protected void BillingListView_SortCommand(object sender, GridSortCommandEventArgs e)
    {



    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        int RSN = Convert.ToInt32(Session["ResidentRSN"]);
        SqlProcsNew sqlobj = new SqlProcsNew();
        if (ddlSession.SelectedValue != String.Empty)
        {
            try
            {
                
                int Count = ((Convert.ToInt32(TxtNOG.Text.Trim())) + (Convert.ToInt32(TxtNOR.Text.Trim())));
                //lblValue.Text = (Convert.ToInt32(lblResidentRate.Text) * (Convert.ToInt32(TxtNOR.Text);
                Decimal a = Convert.ToDecimal(lblResidentRate.Text);
                Decimal b = Convert.ToDecimal(TxtNOR.Text);

                decimal  c = Math.Round((a * b),0);
               
                lblValue.Text = c.ToString();

                sqlobj.ExecuteSQLNonQuery("SP_InsertBillingDtls",
                                new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
                                   new SqlParameter() { ParameterName = "@sessioncode", SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue },
                                   new SqlParameter() { ParameterName = "@NOOFGUEST", SqlDbType = SqlDbType.Int, Value = TxtNOG.Text },                                 
                                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = BillingDate.SelectedDate },
                                    new SqlParameter() { ParameterName = "@NOOFRESIDENT", SqlDbType = SqlDbType.Int, Value = TxtNOR.Text },
                                      new SqlParameter() { ParameterName = "@count", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(Count) },
                                  new SqlParameter() { ParameterName = "@value", SqlDbType = SqlDbType.BigInt, Value = lblValue.Text });

                WebMsgBox.Show("Bill Detail Saved.");
                ClearScr();
                //LoadCustDet();
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message.ToString());
            }
        }
        else
        {
            WebMsgBox.Show("Please enter RACode ");
        }
        }
    protected void ClearScr()
    {

        BillingDate.SelectedDate = DateTime.Now;
        LoadSession();
        TxtNOR.Text = String.Empty;
        TxtNOG.Text = String.Empty;
        this.TxtNOR.Focus();

    }    
  
    #region Session dropdown selected index changed
    protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if (ddlSession.SelectedValue != "0" && ddlSession.SelectedValue != "")
            {

                SqlCommand cmd = new SqlCommand("SP_FetchRate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@SessionCode", SqlDbType.NVarChar).Value = ddlSession.SelectedValue;
                SqlDataAdapter ad = new SqlDataAdapter(cmd);
                DataSet dsGrid = new DataSet();
                ad.Fill(dsGrid);
                lblGuestRate.Text = dsGrid.Tables[0].Rows[0]["GuestRate"].ToString();
                lblResidentRate.Text = dsGrid.Tables[0].Rows[0]["ResidentRate"].ToString();
                lblGuestRate.DataBind();
                lblResidentRate.DataBind();
            }

        }
        catch (Exception ex)
        {

        }
    }
    #endregion
}