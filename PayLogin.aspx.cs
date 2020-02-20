using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClsPaymentGatewayDet;

public partial class PayLogin : System.Web.UI.Page
{
    static ClsPayDetails payDetails;
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["PayUser"] = null;
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            try
            {
                payDetails = new ClsPayDetails();
                payDetails.UserID = TxtUsername.Text.ToString();
                payDetails.Password = TxtPassword.Text.ToString();
            }
            catch (Exception ex)
            {

            }
            if (payDetails.GetUserDetails().Rows.Count > 0)
            {
                Session["PayUser"] = TxtUsername.Text;
                Response.Redirect("PayDetails.aspx");
            }
            else
                WebMsgBox.Show("Invaild Username and Password!");

           
        }
        catch (Exception ex)
        {

        }

    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {

    }
}