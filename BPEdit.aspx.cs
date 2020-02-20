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

public partial class BPEdit : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            loadAdminDet();
        }

    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
 
        SqlProcsNew sqlobj = new SqlProcsNew();
        if (HRResult.Value == "true")
        {
            int RSN = Convert.ToInt32(Session["BPRSN"]);
            try
            {



                sqlobj.ExecuteSQLNonQuery("[SP_UpdateBPDtls]",
                     new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                      new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN.ToString() },
                       new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlBStatus.SelectedValue },
                        new SqlParameter() { ParameterName = "@BPFrom", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = BPFrom.SelectedDate },
                                 new SqlParameter() { ParameterName = "@BPTill", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = BPTill.SelectedDate }
                                   );


                WebMsgBox.Show("Details Updated successfully.");
                //ClearScr();

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

    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("BillingPeriods.aspx");
    }
    public void loadAdminDet()
    {
        if (Session["BPRSN"].ToString() != "")
        {

            try
            {
                int RSN = Convert.ToInt32(Session["BPRSN"]);

                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsSection = proc.ExecuteSP("[SP_BPEdit]", new SqlParameter()
                {
                    ParameterName = "@RSN",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = RSN
                });

                BPFrom.SelectedDate = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["BPFrom"].ToString());
                BPTill.SelectedDate = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["BPTill"].ToString());
                ddlBStatus.SelectedValue = dsSection.Tables[0].Rows[0]["BStatus"].ToString();                        

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
}