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

public partial class MenuPrepared : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadTitle();

            DateTime now = DateTime.Now;

            dtpmenuforday.SelectedDate = DateTime.Now;

            LoadSession();

            rgDinersTotal.DataSource = string.Empty;
            rgDinersTotal.DataBind();

        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 95 });


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

    private void LoadSession()
    {

        try
        {
          
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_General",
                new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 30 });

            ddlDinersSession.DataSource = dsFetchSE.Tables[0];
            ddlDinersSession.DataValueField = "SCode";
            ddlDinersSession.DataTextField = "SName";
            ddlDinersSession.DataBind();

            ddlDinersSession.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));

            dsFetchSE.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        tblBDet.Visible = true;
        pnlShowDet.Visible = true;
        LoadDinersDet(Convert.ToDateTime(dtpmenuforday.SelectedDate), ddlDinersSession.SelectedValue);
        LoadSessionDetails(Convert.ToDateTime(dtpmenuforday.SelectedDate), ddlDinersSession.SelectedValue);
       


    }


    private void LoadDinersDet(DateTime selectdate, string Session)
    {
        try
        {
            DataSet dsSessionDetails = sqlobj.ExecuteSP("SP_FetchMenuIngredForDay",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 4 },
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = selectdate },
                new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session }

                );

            if (dsSessionDetails.Tables[0].Rows.Count > 0)
            {
                rgDinersTotal.DataSource = dsSessionDetails;
                rgDinersTotal.DataBind();


                hdnBtot.Value = dsSessionDetails.Tables[0].Rows[0]["TotalBooking"].ToString();
                hdnAtot.Value = dsSessionDetails.Tables[0].Rows[1]["TotalBooking"].ToString();
            }
            else
            {
                rgDinersTotal.DataSource = string.Empty;
                rgDinersTotal.DataBind();
            }

            //if (dsSessionDetails.Tables[1].Rows.Count > 0)
            //{
            //    hdnBtot.Value = dsSessionDetails.Tables[1].Rows[0]["BTotal"].ToString();
            //    hdnAtot.Value = dsSessionDetails.Tables[1].Rows[0]["ATotal"].ToString();
            //}
            dsSessionDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadSessionDetails(DateTime selectdate, string Session)
    {
        try
        {
            DataSet dsSessionDetails = sqlobj.ExecuteSP("SP_FetchMenuIngredForDay",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = selectdate },
                new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session });

            if (dsSessionDetails.Tables[0].Rows.Count > 0)
            {
                rdgMenuDetails.DataSource = dsSessionDetails;
                rdgMenuDetails.DataBind();
            }
            else
            {
                rdgMenuDetails.DataSource = string.Empty;
                rdgMenuDetails.DataBind();
            }
            dsSessionDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            foreach (GridDataItem item in rdgMenuDetails.MasterTableView.Items)
            {
                try
                {
                    DateTime MDate = Convert.ToDateTime(dtpmenuforday.SelectedDate);
                    string Session = ddlDinersSession.SelectedValue.ToString();
                    int BCount = Convert.ToInt16(hdnBtot.Value.ToString());
                    int ACount = Convert.ToInt16(hdnAtot.Value.ToString());
                    string Menu = item["ItemName"].Text.ToString();
                    Double ServeQty = Convert.ToDouble(item["ServeQty"].Text.ToString());
                    string UOM = item["UOM"].Text.ToString();
                    Double EstQty = Convert.ToDouble(item["Total"].Text.ToString());


                    TextBox textBoxNC = item.FindControl("txtNotConsumed") as TextBox;
                    //Double NotConsumed = Convert.ToDouble(textBoxNC.Text.ToString());
                    string NotConsumed = textBoxNC.Text.ToString();
                    TextBox textBoxRem = item.FindControl("txtRemarks") as TextBox;
                    string Remarks = textBoxRem.Text.ToString();
                    string ItemCode = item["ItemCode"].Text.ToString();

                    //if (Convert.ToString(NotConsumed) == string.Empty || Convert.ToString(NotConsumed) == "")
                    //{
                    //    double? euros = null;
                    //    NotConsumed = Convert.ToDouble(euros);
                    //}


                    SqlProcsNew sqlobj = new SqlProcsNew();
                    sqlobj.ExecuteSQLNonQuery("SP_InsertNonConsumption",
                            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                            new SqlParameter() { ParameterName = "@MDate", SqlDbType = SqlDbType.DateTime, Value = MDate },
                            new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session },
                            new SqlParameter() { ParameterName = "@BCount", SqlDbType = SqlDbType.Int, Value = BCount },
                            new SqlParameter() { ParameterName = "@ACount", SqlDbType = SqlDbType.Int, Value = ACount },
                            new SqlParameter() { ParameterName = "@Menu", SqlDbType = SqlDbType.NVarChar, Value = ItemCode },
                            new SqlParameter() { ParameterName = "@ServeQty", SqlDbType = SqlDbType.Decimal, Value = ServeQty },
                            new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = UOM },
                            new SqlParameter() { ParameterName = "@EstQty", SqlDbType = SqlDbType.Decimal, Value = EstQty },
                            //new SqlParameter() { ParameterName = "@NotConsumed", SqlDbType = SqlDbType.Decimal, Value = NotConsumed },
                            new SqlParameter() { ParameterName = "@NotConsumed", SqlDbType = SqlDbType.Decimal, Value = NotConsumed == string.Empty ? null : NotConsumed },
                            new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = Remarks });

                     //new SqlParameter() { ParameterName = "@TaskDate", SqlDbType = SqlDbType.Date, Value = txtMDate.SelectedDate == null ? null : txtMDate.SelectedDate },
                }
                catch (Exception ex)
                {

                }
            }
           
            WebMsgBox.Show("Detail saved successfully.'");
        }

       
    }

    

   


}