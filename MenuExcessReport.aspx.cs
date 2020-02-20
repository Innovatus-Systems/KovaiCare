using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;

using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;

using System.Web.UI.HtmlControls;

using System.Text;
using System.Net.Mail;

using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
//using System.Security.Cryptography.Xml;
using System.Net;
using System.Net.Security;
using System.Diagnostics;
using System.IO;
using System.ComponentModel;

public partial class MenuExcessReport : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadTitle();

            DateTime now = DateTime.Now;

            dtpfrom.SelectedDate = DateTime.Now;
            dtptil.SelectedDate = DateTime.Now;
            grdBillingDays.Visible = true;
            grdBillingDays.DataSource = string.Empty;
            grdBillingDays.DataBind();


            LoadItem();



        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 136 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadItem()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchAT = new DataSet();
            ddlMenuItem.Items.Clear();
            dsFetchAT = sqlobj.ExecuteSP("Load_ItemMenu");
            ddlMenuItem.DataSource = dsFetchAT.Tables[0];

            ddlMenuItem.DataValueField = "ItmCode";
            ddlMenuItem.DataTextField = "Item";
            ddlMenuItem.DataBind();
            ddlMenuItem.Dispose();
            ddlMenuItem.Items.Insert(0, "--Select--");

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    public void LoadGrid()
    {
        try
        {


            if (ddlMenuItem.SelectedValue != "--Select--")
            {


                DataSet dsUsers = sqlobj.ExecuteSP("SP_InsertNonConsumption",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = ddlMenuItem.SelectedValue },
               new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = dtpfrom.SelectedDate },
               new SqlParameter() { ParameterName = "@TillDate", SqlDbType = SqlDbType.DateTime, Value = dtptil.SelectedDate }
               );


                if (dsUsers.Tables[0].Rows.Count > 0)
                {
                    grdBillingDays.DataSource = dsUsers;
                    grdBillingDays.DataBind();
                }
                else
                {
                    grdBillingDays.DataSource = string.Empty;
                    grdBillingDays.DataBind();
                }

                dsUsers.Dispose();


            }
            else
            {
                WebMsgBox.Show("Please select a menu item");
            }


            


        }
        catch (Exception ex)
        {
        }
    }

    protected void grdBillingDays_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {

        LoadGrid();
       

    }
}