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
using System.Data.SqlClient;
using System.Web.Services;
using System.ComponentModel.Design;
using System.Collections.Generic;
using Telerik.Web.UI;


public partial class EditBPMessage : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;

            dsGroup = sqlobj.ExecuteSP("SP_BPMessageDet",
                new SqlParameter() { ParameterName = "@BPRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = Request.QueryString["MsgRSN"].ToString() });

            hdnBPRSN.Value = Request.QueryString["MsgRSN"].ToString();
            txtBillingPeriod.Text = dsGroup.Tables[0].Rows[0]["Period"].ToString();
            txtMessage.Text = dsGroup.Tables[0].Rows[0]["Message"].ToString();
        }
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        ClientScript.RegisterStartupScript(typeof(Page), "closePage", "window.close();", true);
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (txtMessage.Text != string.Empty && txtMessage.Text != "")
        {
            if (CnfResult.Value == "true")
            {
                try
                {
                    sqlobj.ExecuteSP("SP_InsertBPMessage",
                        new SqlParameter() { ParameterName = "@BPRSN", SqlDbType = SqlDbType.Decimal, Value = hdnBPRSN.Value },
                        new SqlParameter() { ParameterName = "@Message", SqlDbType = SqlDbType.NVarChar, Value = txtMessage.Text });

                    WebMsgBox.Show("Message saved");
                   
                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.ToString());
                }
            }
        }
        else
        {
            WebMsgBox.Show("Please enter the message");
        }      
    }
}
