using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PaymentFailure : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int i = 0;
    }
    protected void LnkPayAgain_Click(object sender, EventArgs e)
    {
        Response.Redirect("PayDetails.aspx");
    }
    protected void BtnHome_Click(object sender, EventArgs e)
    {
        if (Session["HomePage"] != null)
            Response.Redirect(Session["HomePage"].ToString());
    }

    protected void BtnPayDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("PayDetails.aspx");
    }
    protected void BtnHistory_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaymentHistory.aspx");
    }
    protected void BtnStatement_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaymentStatement.aspx");
    }
}