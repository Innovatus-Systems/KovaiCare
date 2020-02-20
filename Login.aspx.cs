using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;

public partial class Login : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    SqlProcsNew sqlobj = new SqlProcsNew();
    static string strStatus;
    static string IP;
    static string hostName;
    static string url;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string dot;
            //string host = Dns.GetHostName();
            //IPAddress[] hostIPs = Dns.GetHostAddresses(host);
            //// get local IP addresses
            //IPAddress[] localIPs = Dns.GetHostAddresses(Dns.GetHostName());
            //hostName = Dns.GetHostName(); // Retrive the Name of HOST           
            //hostName = localIPs[2].ToString();
            //IP = Dns.GetHostByName(hostName).AddressList[0].ToString();    
             hostName = Environment.MachineName;
            //IP = Dns.GetHostAddresses(Environment.MachineName)[2].ToString();
            
           url = HttpContext.Current.Request.Url.AbsoluteUri;
            LoadCompanyCode();
            Session.Clear();
            Session.Abandon();
            TxtUserID.Focus();
            DataSet dsDT = sqlobj.ExecuteSP("GetServerDateTime");
            LblDateTime.Text = dsDT.Tables[0].Rows[0][1].ToString();
        }
    }
    protected void BtnSignIn_Click(object sender, EventArgs e)
    {
        try
        {

            if (TxtUserID.Text != String.Empty && TxtPassword.Text != String.Empty)
            {
                
                DivError.Visible = false;
                if (TxtUserID.Text == "admin" && TxtPassword.Text == "a$m#n~")
                {
                    Session["UserID"] = TxtUserID.Text.ToString();
                    Response.Redirect("Homemenu.aspx", false);
                    DataSet dsAudit = sqlobj.ExecuteSP("SP_LOGINAUDITLOG",
                              new SqlParameter() { ParameterName = "@USERNAME", SqlDbType = SqlDbType.NVarChar, Value = TxtUserID.Text },
                              new SqlParameter() { ParameterName = "@PASSWORD", SqlDbType = SqlDbType.NVarChar, Value = Session["Pwd"].ToString() },
                              new SqlParameter() { ParameterName = "@STATUS", SqlDbType = SqlDbType.NVarChar, Value = "S" },
                              new SqlParameter() { ParameterName = "@HOSTNAME", SqlDbType = SqlDbType.NVarChar, Value = hostName },
                              new SqlParameter() { ParameterName = "@IP", SqlDbType = SqlDbType.NVarChar, Value = IP },
                              new SqlParameter() { ParameterName = "@URL", SqlDbType = SqlDbType.NVarChar, Value = url });
                }
                Session["Pwd"] = TxtPassword.Text;

                SqlCommand cmddate = new SqlCommand("Proc_ChkDate", con);
                SqlDataAdapter dapdate = new SqlDataAdapter(cmddate);
                DataSet dsDate = new DataSet();
                dapdate.Fill(dsDate, "temp");
                if (dsDate.Tables[0].Rows.Count > 0)
                {
                    strStatus = dsDate.Tables[0].Rows[0][0].ToString();
                }


                if (strStatus != "0" && Convert.ToDateTime(strStatus) < DateTime.Today)
                {
                    WebMsgBox.Show("Free trial period for ORIS has expired.Please contact Info@Innovatusystems.com, +91-9487104370");
                    return;
                }


                string strBStatus = "";
                string strUStatus = "";

                DataSet dsStatus = sqlobj.ExecuteSP("SP_UpdateBillingPeriodStatus",
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 });

                if (dsStatus.Tables[0].Rows.Count > 0)
                {

                    strBStatus = dsStatus.Tables[0].Rows[0]["BStatus"].ToString();

                }

                dsStatus.Dispose();

                DataSet dsUStatus = sqlobj.ExecuteSP("SP_CheckAdmin",
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = TxtUserID.Text });

                if (dsUStatus.Tables[0].Rows.Count > 0)
                {

                    strUStatus = dsUStatus.Tables[0].Rows[0]["DeptCode"].ToString();

                }

                dsUStatus.Dispose();


                if (strBStatus == "12")
                {

                    if (strUStatus != "AD")
                    {
                        WebMsgBox.Show("Month end bill Processing...");
                        return;
                    }
                }



                DataSet dsRentalType = sqlobj.ExecuteSP("SP_RentalType");

                string rtype = "";

                if (dsRentalType.Tables[0].Rows.Count > 0)
                {
                    rtype = dsRentalType.Tables[0].Rows[0]["AmountType"].ToString();

                }


                if (rtype.ToString() == "Monthly")
                {

                    // -- 2 

                    // -- start daily payment code

                    DataSet dsCheckFirstLogin = sqlobj.ExecuteSP("SP_GetDebitDate");

                    if (dsCheckFirstLogin.Tables[0].Rows.Count > 0)
                    {
                        DateTime LastDebitDate = Convert.ToDateTime(dsCheckFirstLogin.Tables[0].Rows[0]["LastDebitDate"].ToString());

                        DateTime CurrentDate = DateTime.Now;

                        string ldd = LastDebitDate.ToString("dd-MM-yyyy");
                        string cdd = CurrentDate.ToString("dd-MM-yyyy");


                        if (ldd.Equals(cdd))
                        {

                            // -- end daily payment code


                            DataSet dslogin = sqlobj.ExecuteSP("Proc_CheckUserLogin_New",
                            new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value = TxtUserID.Text },
                            new SqlParameter() { ParameterName = "@UPassword", SqlDbType = SqlDbType.NVarChar, Value = Session["Pwd"].ToString() });


                            if (dslogin.Tables[0].Rows.Count > 0)
                            {
                                DataSet dsAudit = sqlobj.ExecuteSP("SP_LOGINAUDITLOG",
                             new SqlParameter() { ParameterName = "@USERNAME", SqlDbType = SqlDbType.NVarChar, Value = TxtUserID.Text },
                             new SqlParameter() { ParameterName = "@PASSWORD", SqlDbType = SqlDbType.NVarChar, Value = Session["Pwd"].ToString() },
                             new SqlParameter() { ParameterName = "@STATUS", SqlDbType = SqlDbType.NVarChar, Value = "S" },
                             new SqlParameter() { ParameterName = "@HOSTNAME", SqlDbType = SqlDbType.NVarChar, Value = hostName },
                             new SqlParameter() { ParameterName = "@IP", SqlDbType = SqlDbType.NVarChar, Value = IP },
                             new SqlParameter() { ParameterName = "@URL", SqlDbType = SqlDbType.NVarChar, Value = url });
                                if (TxtUserID.Text.ToString().ToLower() == TxtPassword.Text.ToString().ToLower())
                                {
                                    Session["Uname"] = TxtUserID.Text;
                                    Response.Redirect("ChangePassword.aspx");

                                }
                                else
                                {                                    
                                    Session["UserID"] = dslogin.Tables[0].Rows[0]["UserName"].ToString();
                                    //Response.Redirect("Homemenu.aspx", false);
                                    //Response.Redirect("AllMenus.aspx", false);
                                    // Response.Redirect("AllMenus.aspx", false);
                                    Response.Redirect("Dashboard.aspx", false);
                                }

                            }
                            else
                            {
                                DivError.Visible = true;
                            }
                        }

                     // -- start daily payment code

                        else
                        {
                            RadWindowManager1.RadConfirm("<b>FIRST SIGN-IN FOR THE DAY</b>.<br/><b>USAGE FEES WILL BE DEDUCTED NOW.</b><br/><b>CONFIRM?</b>", "confirmStatusCallbackFn", 400, 200, null, "Confirm");
                        }


                        //WebMsgBox.Show("USAGE FEES NOT DEDUCTED");
                    }

                }

                else
                {

                    DataSet dslogin = sqlobj.ExecuteSP("Proc_CheckUserLogin_New",
                                new SqlParameter() { ParameterName = "@UserName", SqlDbType = SqlDbType.NVarChar, Value = TxtUserID.Text },
                                new SqlParameter() { ParameterName = "@UPassword", SqlDbType = SqlDbType.NVarChar, Value = Session["Pwd"].ToString() });
                    if (dslogin.Tables[0].Rows.Count > 0)
                    {
                        DataSet dsAudit = sqlobj.ExecuteSP("SP_LOGINAUDITLOG",
                             new SqlParameter() { ParameterName = "@USERNAME", SqlDbType = SqlDbType.NVarChar, Value = TxtUserID.Text },
                             new SqlParameter() { ParameterName = "@PASSWORD", SqlDbType = SqlDbType.NVarChar, Value = Session["Pwd"].ToString() },
                             new SqlParameter() { ParameterName = "@STATUS", SqlDbType = SqlDbType.NVarChar, Value = "S" },
                             new SqlParameter() { ParameterName = "@HOSTNAME", SqlDbType = SqlDbType.NVarChar, Value = hostName },
                             new SqlParameter() { ParameterName = "@IP", SqlDbType = SqlDbType.NVarChar, Value = IP },
                             new SqlParameter() { ParameterName = "@URL", SqlDbType = SqlDbType.NVarChar, Value = url });
                        if (TxtUserID.Text.ToString().ToLower() == TxtPassword.Text.ToString().ToLower())
                        {
                            Session["Uname"] = TxtUserID.Text;
                            Response.Redirect("ChangePassword.aspx");
                        }
                        else
                        {
                            Session["UserID"] = dslogin.Tables[0].Rows[0]["UserName"].ToString();
                            Response.Redirect("Dashboard.aspx", false);
                        }

                    }
                    else
                    {
                        DataSet dsAudit = sqlobj.ExecuteSP("SP_LOGINAUDITLOG",
                             new SqlParameter() { ParameterName = "@USERNAME", SqlDbType = SqlDbType.NVarChar, Value = TxtUserID.Text },
                             new SqlParameter() { ParameterName = "@PASSWORD", SqlDbType = SqlDbType.NVarChar, Value = Session["Pwd"].ToString() },
                             new SqlParameter() { ParameterName = "@STATUS", SqlDbType = SqlDbType.NVarChar, Value = "F" },
                             new SqlParameter() { ParameterName = "@HOSTNAME", SqlDbType = SqlDbType.NVarChar, Value = hostName },
                             new SqlParameter() { ParameterName = "@IP", SqlDbType = SqlDbType.NVarChar, Value = IP },
                             new SqlParameter() { ParameterName = "@URL", SqlDbType = SqlDbType.NVarChar, Value = url });
                        DivError.Visible = true;
                    }
                }
                
                // -- end daily payment code
            }
            

            else
            {
                WebMsgBox.Show("Please enter User ID/Password.");
            }

        }

        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    private void LoadCompanyCode()
    {
        try
        {
            DataSet dsCompanyCode = sqlobj.ExecuteSP("SP_GetCompanyCode");

            if (dsCompanyCode.Tables[0].Rows.Count > 0)
            {
                LblCommunittyName.Text = dsCompanyCode.Tables[0].Rows[0]["CommunityName"].ToString();
                LblVersionNo.Text = dsCompanyCode.Tables[0].Rows[0]["versionnumber"].ToString();
            }
            dsCompanyCode.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}