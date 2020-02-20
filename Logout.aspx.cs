using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text;
using System.Data.SqlClient;

public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Clear();
        Session["PASSWORD"] = "";
        Session["UserName"] = "";
        Session["ReportingHead"] = "";
        Session["USERID"] = "";
        Session["MobileNo"] = "";
        Session["Email"] = "";
        Session["RSN"] = "";
        Session.Abandon();
        Response.Cookies.Clear();
        FormsAuthentication.SignOut();
        Server.Transfer("Login.aspx");
    }
}