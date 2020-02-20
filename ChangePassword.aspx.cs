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
using System.Text;
using System.Web.Services;
using Telerik.Web.UI;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;

public partial class ChangePassword : System.Web.UI.Page
{
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {          
        }
        TxtUserId.Text = Session["Uname"].ToString();       

    }    
    protected void btnChange_Click(object sender, EventArgs e)
    {
        if (TxtUserId.Text != string.Empty && TxtCurrentPassword.Text != string.Empty && TxtNewpassword.Text != string.Empty && TxtConfirmPwd.Text != string.Empty)
        {
            if (TxtNewpassword.Text == TxtConfirmPwd.Text)
            {
                try
                {
                    SqlCommand pwdcmd = new SqlCommand("Get_Currentpwd", con);
                    pwdcmd.CommandType = CommandType.StoredProcedure;
                    pwdcmd.Parameters.AddWithValue("@UserName", TxtUserId.Text);
                    SqlDataAdapter dap = new SqlDataAdapter(pwdcmd);
                    DataSet ds = new DataSet();
                    dap.Fill(ds, "temp");
                    if(ds.Tables[0].Rows.Count > 0)
                    {
                        string strcpwd = ds.Tables[0].Rows[0]["Password"].ToString();
                        if (strcpwd == TxtCurrentPassword.Text)
                        {
                            SqlCommand cmd = new SqlCommand("Porc_UpdatePwd", con);
                            cmd.CommandType = CommandType.StoredProcedure;                           
                            cmd.Parameters.AddWithValue("@UserName", TxtUserId.Text);
                            cmd.Parameters.AddWithValue("@CPassword", TxtCurrentPassword.Text);
                            cmd.Parameters.AddWithValue("@UPassword", TxtNewpassword.Text);
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            WebMsgBox.Show("Password Changed Successfully");
                            ClearScr();
                            Response.Redirect("~/Login.aspx");
                        }
                        else
                        {
                            WebMsgBox.Show("Please check your current password");
                            TxtCurrentPassword.Text = string.Empty;
                            TxtNewpassword.Text = string.Empty;
                            TxtConfirmPwd.Text = string.Empty;
                        }
                    }
                    else
                    {
                        WebMsgBox.Show("Please check your current password");
                        TxtCurrentPassword.Text = string.Empty;
                        TxtNewpassword.Text = string.Empty;
                        TxtConfirmPwd.Text = string.Empty;
                    }
                    
                    //SqlProcsNew sqlobj = new SqlProcsNew();
                    //DataSet ds = new DataSet();
                    //ds = sqlobj.ExecuteSP("SP_GETPASSWORDDETAILS",
                    //     new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.NVarChar, Value = 1 },
                    //         new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = TxtUserId.Text },
                    //         new SqlParameter() { ParameterName = "@PWD", SqlDbType = SqlDbType.NVarChar, Value = TxtCurrentPassword.Text }
                    //         );



                    //if (ds != null && ds.Tables[0].Rows.Count > 0)
                    //{
                    //    if (ds.Tables[0].Rows.Count == 0)
                    //    {
                    //        WebMsgBox.Show("Kindly check your User ID.");
                    //        return;
                    //    }
                    //    if (TxtCurrentPassword.Text == ds.Tables[0].Rows[0]["UPassword"].ToString())
                    //    {

                    //        sqlobj.ExecuteSQLNonQuery("SP_CHANGEPASSWORD",
                    //        new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.NVarChar, Value = 1 },
                    //        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt32(ds.Tables[0].Rows[0]["RSN"]) },
                    //        new SqlParameter() { ParameterName = "@PWD", SqlDbType = SqlDbType.NVarChar, Value = TxtConfirmPwd.Text }
                    //        );
                            
                    //        WebMsgBox.Show("Password Changed Successfully");
                    //        ClearScr();
                    //    }
                    //    else
                    //    {
                    //        WebMsgBox.Show("Kindly check your current password");
                    //        return;

                    //    }
                    //}
                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message);
                }
            }
            else
            {
                WebMsgBox.Show("Error! New password and Confirm Password do not match. Please re-enter.");
            }
        }
        else
        {
            WebMsgBox.Show("Enter Mandatory Field");
        }
    }


    protected void ClearScr()
    {

        TxtUserId.Text = string.Empty;
        TxtCurrentPassword.Text = string.Empty;
        TxtNewpassword.Text = string.Empty;
        TxtConfirmPwd.Text = string.Empty;
        TxtUserId.Focus();

    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        string url = "page2.aspx";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append("http://www.innovatussystems.com");
        sb.Append("');");
        sb.Append("</script>");


        Page.ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());
    }
}
