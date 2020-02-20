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

public partial class AdminEdit : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            loadAdminDet();
        }

    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();


        if (HRResult.Value == "true")
        {
            int RSN = Convert.ToInt32(Session["ADRSN"]);
            try
            {



                sqlobj.ExecuteSQLNonQuery("[SP_UpdateAdminDtls]",
                     new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                      new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN.ToString() },
                   new SqlParameter() { ParameterName = "@CommunityName", SqlDbType = SqlDbType.NVarChar, Value = TxtCommunityName.Text },
                   new SqlParameter() { ParameterName = "@FromID", SqlDbType = SqlDbType.NVarChar, Value = TxtFromID.Text },
                       new SqlParameter() { ParameterName = "@FromMobileNo", SqlDbType = SqlDbType.NVarChar, Value = TxtFromMobileNo.Text },
                       new SqlParameter() { ParameterName = "@ContactPName", SqlDbType = SqlDbType.NVarChar, Value = TxtContactPName.Text },
                        new SqlParameter() { ParameterName = "@ScrollMessage", SqlDbType = SqlDbType.NVarChar, Value = txtscrollmessage.Text }
                                    //new SqlParameter() { ParameterName = "@NextBillingDate", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = NextBDate.SelectedDate }
                                   );


                WebMsgBox.Show("Admin details Updated successfully.");
                ClearScr();

            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message.ToString());
            }
        }
        else
        {

        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("Admin.aspx");
    }
    public void loadAdminDet()
    {
        if (Session["ADRSN"].ToString() != "")
        {

            try
            {
                int RSN = Convert.ToInt32(Session["ADRSN"]);

                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsSection = proc.ExecuteSP("[SP_AdminEdit]", new SqlParameter()
                {
                    ParameterName = "@RSN",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = RSN
                });

                //DateTime Dtime= Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"]);





                TxtCommunityName.Text = dsSection.Tables[0].Rows[0]["CommunityName"].ToString();

                TxtFromID.Text = dsSection.Tables[0].Rows[0]["FromID"].ToString();

                TxtFromMobileNo.Text = dsSection.Tables[0].Rows[0]["FromMobileNo"].ToString();
                TxtContactPName.Text = dsSection.Tables[0].Rows[0]["ContactPName"].ToString();
                txtscrollmessage.Text = dsSection.Tables[0].Rows[0]["scrollmsg"].ToString();
                //NextBDate.SelectedDate = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["NextBillingDate"].ToString()
            
            }

            catch (Exception ex)
            {

                WebMsgBox.Show(ex.ToString());


            }

        }

        else
        {

            WebMsgBox.Show("There are some error in edit process.Try again!");

        }

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

}