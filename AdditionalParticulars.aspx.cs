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

public partial class AdditionalParticulars : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        ////if (!IsPostBack)
        ////{
        ////    LoadGridLevelP();
        
        ////}
        LoadGridLevelP();
    }

    protected void LoadGridLevelP()
    {

        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsGroup = null;
        dsGroup = sqlobj.ExecuteSP("SP_AttributeDet",
            new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 3 },
            new SqlParameter() { ParameterName = "@Group", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "A" },
            new SqlParameter() { ParameterName = "@RName", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Request.QueryString["SResult"].ToString() });          
        rdgAttribute.DataSource = dsGroup.Tables[0];
        rdgAttribute.DataBind();
        dsGroup.Dispose();
    }

    protected void lbtnName_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[3].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();


        ClientScript.RegisterStartupScript(typeof(Page), "closePage", "window.close();", true);

        Response.Redirect("ResidentView?=31");

        //Response.Redirect("TransactionLevel.aspx");

        //var win = Ext.WindowManager.getActive();
        //if (win) 
        //{
        //win.close();
    }
}