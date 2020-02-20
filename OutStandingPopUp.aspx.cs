using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OutStandingPopUp : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {

                StringBuilder str = new StringBuilder();
                Int32 RTRSN =Convert.ToInt32(Request.QueryString["NO"]);
                DataSet dsOutSt = sqlobj.ExecuteSP("Proc_VillaMaster",
               new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 8 },
               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RTRSN });
                if (dsOutSt.Tables[0].Rows.Count > 0)
                {

                    lblBilledFor.Text = "Billed For : " ;
                    lblPREV.Text=dsOutSt.Tables[0].Rows[0]["PrevBilling"].ToString() + " : ";
                    lblBilledForAmount.Text = "RS : " + dsOutSt.Tables[0].Rows[0]["Billed"].ToString();
                    lblPaymentsDone.Text = "RS : " + dsOutSt.Tables[0].Rows[0]["Recipts"].ToString();
                    lblUnBilledFor.Text = "UnBilled For : " ;
                    lblCRT.Text = dsOutSt.Tables[0].Rows[0]["crtBilling"].ToString() + " : ";
                    lblUnBilledForAmount.Text = "RS : " + dsOutSt.Tables[0].Rows[0]["UnBilled"].ToString();
                    lblNetOutAmount.Text = "RS : " + dsOutSt.Tables[0].Rows[0]["OutStanding"].ToString();
                }
                if (dsOutSt.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow r in dsOutSt.Tables[1].Rows)
                    {
                        str.Append("" + r["RTNAME"] + " , ");
                    }
                    str.Remove(str.Length - 2, 2);
                    lblResident.Text = str.ToString();
                    lblAccount.Text = "A/C Code : " + dsOutSt.Tables[1].Rows[0]["AccountCode"].ToString();
                }
                //Response.Redirect("DailyFoodBillReport.aspx");
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
            }
        }
    }
}