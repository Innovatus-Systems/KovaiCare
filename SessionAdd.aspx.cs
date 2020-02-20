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

public partial class SessionAdd : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
       if(!IsPostBack)
       {


       }
    }
    protected void btnnSave_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        if (TxtSCode.Text != String.Empty && TxtSName.Text != String.Empty)
        {
            try
            {
                sqlobj.ExecuteSP("SP_InsertSessionDtls",
                                    
                                   new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = TxtSCode.Text },
                                   new SqlParameter() { ParameterName = "@SessionName", SqlDbType = SqlDbType.NVarChar, Value = TxtSName.Text },
                                   new SqlParameter() { ParameterName = "@SessionHelp", SqlDbType = SqlDbType.NVarChar, Value = TxtSHelp.Text },
                                    new SqlParameter() { ParameterName = "@ResidentRate", SqlDbType = SqlDbType.Decimal, Value = TxtRRate.Text },
                                   new SqlParameter() { ParameterName = "@GuestRate", SqlDbType = SqlDbType.Decimal, Value = TxtGRate.Text },
                                   new SqlParameter() { ParameterName = "@FreeUpTo", SqlDbType = SqlDbType.Int, Value = TxtFUTo.Text });
                                   

                WebMsgBox.Show("Session Detail Saved Successfully.");
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
            WebMsgBox.Show("Please enter Mandatory field(s) ");
        }
    }
    protected void btnnClear_Click(object sender, EventArgs e)
    {

    }
    protected void btnnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }

    protected void ClearScr()
    {
          TxtSCode.Text = String.Empty;
          TxtSName.Text  = String.Empty;
          TxtSHelp.Text  = String.Empty;
          TxtRRate.Text  = String.Empty;
          TxtGRate.Text  = String.Empty;
          TxtFUTo.Text = String.Empty;
          this.TxtSCode.Focus();



    }
}