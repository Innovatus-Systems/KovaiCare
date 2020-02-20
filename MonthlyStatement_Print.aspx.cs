using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;

public partial class MonthlyStatement_Print : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            
        }
        string VillaNo = Request.QueryString["VillaNo"];
        //DateTime StarDate = Convert.ToDateTime(Request.QueryString["SDate"]);
        //DateTime EndDate = Convert.ToDateTime(Request.QueryString["EDate"]);
        ShowMonthlyStat();
    }

    protected void ShowMonthlyStat()
    {

        string VillaNo = Request.QueryString["VillaNo"];
       pnlStatementDet.Visible = true;
        //BtnnExcelExport.Visible = true;
        //DateTime Fdate = DateTime.Parse(FromDate.SelectedDate.ToString());
        //DateTime Tdate = DateTime.Parse(ToDate.SelectedDate.ToString());
        //lblFromDt.Text = Fdate.ToString("dd-MMM-yyyy");
        //lblToDt.Text = Tdate.ToString("dd-MMM-yyyy");

        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsCDT = null;
        dsCDT = proc.ExecuteSP("GetServerDateTime");
        DateTime Cdate = DateTime.Parse(dsCDT.Tables[0].Rows[0][0].ToString());
        lblPrintedOn.Text = Cdate.ToString("dd-MMM-yyyy hh:mm:ss");


        DataSet DS = new DataSet();


        DS = proc.ExecuteSP("SP_FetchMonthlyStatDet",
        new SqlParameter() { ParameterName = "@RSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = VillaNo });

        if (DS.Tables[0].Rows.Count > 0)
        {
            lblVilla.Text = DS.Tables[0].Rows[0]["Villa"].ToString();
            lblResident.Text = DS.Tables[0].Rows[0]["Name"].ToString();
            lblStatus.Text = DS.Tables[0].Rows[0]["Status"].ToString();
            lblEmail.Text = DS.Tables[0].Rows[0]["Email"].ToString();
            lblMobile.Text = DS.Tables[0].Rows[0]["Mobile"].ToString();

            lblAmountPay.Text = DS.Tables[0].Rows[0]["OutStanding"].ToString();
            DateTime Odate = Convert.ToDateTime(dsCDT.Tables[0].Rows[0][0]).AddDays(10);
            lblOutDt.Text = Odate.ToString("dd-MMM-yyyy");

            lblIncharge.Text = DS.Tables[1].Rows[0]["ContactPName"].ToString();
            lblCommunity.Text = DS.Tables[1].Rows[0]["CommunityName"].ToString();
            lblInstruction.Text = DS.Tables[1].Rows[0]["PaymentInstruction"].ToString();

            BindMonthlyStat();
        }

    }
    protected void BindMonthlyStat()
    {
        try
        {
            string VillaNo = Request.QueryString["VillaNo"];
            //DateTime StarDate = Convert.ToDateTime(Request.QueryString["SDate"]);
            //DateTime EndDate = Convert.ToDateTime(Request.QueryString["EDate"]);
            int RSN = Convert.ToInt32(Session["ResidentRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsACDet = null;
            dsACDet = sqlobj.ExecuteSP("SP_FetchMonthlyStatement",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = VillaNo }
                //new SqlParameter() { ParameterName = "@FromDt", SqlDbType = SqlDbType.DateTime, Value = null },
                //new SqlParameter() { ParameterName = "@ToDt", SqlDbType = SqlDbType.DateTime, Value = null }
                );
            rdgMonthlyStat.DataSource = dsACDet.Tables[0];
            rdgMonthlyStat.DataBind();
            dsACDet.Dispose();

            //if (dsACDet.Tables.Count > 0)
            //{
            //    for (int i = 0; i < dsACDet.Tables[0].Rows.Count; i++)
            //    {
            //        Response.Write("<tr>");
            //        Response.Write("<td> " + dsACDet.Tables[0].Rows[i]["Date"].ToString() + " </td>");
            //        Response.Write("<td> " + dsACDet.Tables[0].Rows[i]["Code"].ToString() + " </td>");
            //        Response.Write("<td> " + "NO" + "  </td>");
            //        Response.Write("<td> " + "YES" + "  </td>");
            //        Response.Write("<td> " + dsACDet.Tables[0].Rows[i]["Narration"].ToString() + " </td>");
            //        Response.Write("<td> " + 1.00 + " </td>");
            //        Response.Write("<td> " + 1.00 + "  </td>");
            //        Response.Write("<td> " + dsACDet.Tables[0].Rows[i]["TxnType"].ToString() + " </td>");
            //        Response.Write("</tr>");
            //    }
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
}