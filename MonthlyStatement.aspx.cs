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

public partial class MonthlyStatement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;

        if (!IsPostBack)
        {
            dsDT = proc.ExecuteSP("GetServerDateTime");
            DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
            var startDate = new DateTime(now.Year, now.Month, 1);
            var endDate = startDate.AddMonths(1).AddDays(-1);

            FromDate.SelectedDate = Convert.ToDateTime(startDate);
            ToDate.SelectedDate = Convert.ToDateTime(endDate);

            LoadVillaNo();

        }
    }

    protected void LoadVillaNo()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistVilla = new DataSet();

            ddlistVilla = sqlobj.ExecuteSP("SP_FecthVillaNO",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value =2 });
            ddlVillaNo.DataSource = ddlistVilla.Tables[0];
            ddlVillaNo.DataValueField = "RSN";
            ddlVillaNo.DataTextField = "Name";
            ddlVillaNo.DataBind();
            ddlVillaNo.Dispose();           
            //ddlVillaNo.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void BtnShow_Click(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        if(Convert.ToDateTime(FromDate.SelectedDate) > Convert.ToDateTime(ToDate.SelectedDate))
        {
           WebMsgBox.Show("Please check From and To date");
            return;
        }
       
        dsDT = proc.ExecuteSP("GetServerDateTime");
            DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
        var startDate = new DateTime(now.Year, now.Month, 1);
        var endDate = startDate.AddMonths(1).AddDays(-1);
        FromDate.SelectedDate = Convert.ToDateTime(startDate);
        ToDate.SelectedDate = Convert.ToDateTime(endDate);

        Response.Redirect("MonthlyStatement_Print.aspx?VillaNo=" + ddlVillaNo.SelectedValue.ToString() , false);
        //ShowMonthlyStat();  
        //+ "&SDate =" + Convert.ToString(FromDate.SelectedDate) + "&EDate=" + Convert.ToString(ToDate.SelectedDate)
    }
    protected void ShowMonthlyStat()
    {
        pnlStatementDet.Visible = true;
        //BtnnExcelExport.Visible = true;
        DateTime Fdate = DateTime.Parse(FromDate.SelectedDate.ToString());
        DateTime Tdate = DateTime.Parse(ToDate.SelectedDate.ToString());
        lblFromDt.Text = Fdate.ToString("dd-MMM-yyyy");
        lblToDt.Text = Tdate.ToString("dd-MMM-yyyy");

        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsCDT = null;
        dsCDT = proc.ExecuteSP("GetServerDateTime");
        DateTime Cdate = DateTime.Parse(dsCDT.Tables[0].Rows[0][0].ToString());
        lblPrintedOn.Text = Cdate.ToString("dd-MMM-yyyy hh:mm:ss");


        DataSet DS = new DataSet();

        
        DS = proc.ExecuteSP("SP_FetchMonthlyStatDet",
        new SqlParameter() { ParameterName = "@RSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = ddlVillaNo.SelectedValue.ToString()});

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

            lblIncharge.Text =  DS.Tables[1].Rows[0]["ContactPName"].ToString();
            lblCommunity.Text =  DS.Tables[1].Rows[0]["CommunityName"].ToString();
            lblInstruction.Text =  DS.Tables[1].Rows[0]["PaymentInstruction"].ToString();

            BindMonthlyStat();   
        }

    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        //string FileName, CDate;
        //SqlProcsNew proc = new SqlProcsNew();
        //DataSet dsDT = null;

        //DownloadDetUpdate();

        //dsDT = proc.ExecuteSP("GetServerDateTime");
        //CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");

        //FileName = "MS_" + lblResident.Text.ToString() + "_" + CDate + ".pdf";





        //Response.ContentType = "application/pdf";
        //Response.AddHeader("content-disposition", "attachment;filename=" + FileName);
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter hw = new HtmlTextWriter(sw);
        //pnlStatementDet.RenderControl(hw);
        //StringReader sr = new StringReader(sw.ToString());
        ////Document pdfDoc = new Document(PageSize.LEGAL, 5f, 5f, 100f, 5f);
        //Document pdfDoc = new Document(PageSize.LEGAL);
        //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //pdfDoc.Open();
        //htmlparser.Parse(sr);
        //pdfDoc.Close();
        //Response.Write(pdfDoc);
        //Response.End();


        ////Response.ContentType = "application/pdf";
        ////Response.AddHeader("content-disposition", "attachment;filename=Panel.pdf");
        ////Response.Cache.SetCacheability(HttpCacheability.NoCache);
        ////StringWriter sw = new StringWriter();
        ////HtmlTextWriter hw = new HtmlTextWriter(sw);
        //////pnlPerson.RenderControl(hw);
        ////StringReader sr = new StringReader(sw.ToString());
        ////Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 100f, 0f);
        ////HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        ////PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        ////pdfDoc.Open();
        ////htmlparser.Parse(sr);
        ////pdfDoc.Close();
        ////Response.Write(pdfDoc);
        ////Response.End();


        //Response.ClearContent();
        //Response.Charset = "";
        //dsDT = proc.ExecuteSP("GetServerDateTime");
        //CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");
        //FileName = "SD_" + lblResident.Text.ToString() + "_" + CDate + ".doc";
        //Response.AppendHeader("content-disposition", "attachment;  filename=" + FileName);
        //Response.ContentType = "application/msword";
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter htw = new HtmlTextWriter(sw);
        //pnlStatementDet.RenderControl(htw);




        //Response.Write(sw.ToString());
        //Response.End();

        //Response.AddHeader("content-disposition", "attachment;filename=Export.doc");
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.ContentType = "application/vnd.word";
        //System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        //System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        //// Create a form to contain the grid
        //HtmlForm frm = new HtmlForm();
        //gv.Parent.Controls.Add(frm);
        //frm.Attributes["runat"] = "server";
        //frm.Controls.Add(gv);
        //frm.RenderControl(htmlWrite);
        ////GridView1.RenderControl(htw);
        //Response.Write(stringWrite.ToString());
        //Response.End();


        //Response.ContentType = "application/pdf";

        //Response.AddHeader("content-disposition", "attachment;filename=Export.pdf");
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter hw = new HtmlTextWriter(sw);
        //HtmlForm frm = new HtmlForm();
        //rdgMonthlyStat.Parent.Controls.Add(frm);
        //frm.Attributes["runat"] = "server";
        //frm.Controls.Add(rdgMonthlyStat);
        //frm.RenderControl(hw);
        //StringReader sr = new StringReader(sw.ToString());
        //Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        //HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        //pdfDoc.Open();
        //htmlparser.Parse(sr);
        //pdfDoc.Close();
        //Response.Write(pdfDoc);
        //Response.End();
    }

    protected void BindMonthlyStat()
    {
        try
        {
            int RSN = Convert.ToInt32(Session["ResidentRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsACDet = null;
            dsACDet = sqlobj.ExecuteSP("SP_FetchMonthlyStatement",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = ddlVillaNo.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@FromDt", SqlDbType = SqlDbType.DateTime, Value = FromDate.SelectedDate },
                new SqlParameter() { ParameterName = "@ToDt", SqlDbType = SqlDbType.DateTime, Value = ToDate.SelectedDate });
            rdgMonthlyStat.DataSource = dsACDet.Tables[0];
            rdgMonthlyStat.DataBind();
            dsACDet.Dispose();

            if (dsACDet.Tables.Count > 0)
            {
                for (int i = 0; i < dsACDet.Tables[0].Rows.Count; i++)
                {
                    Response.Write("<tr>");
                    Response.Write("<td> " + dsACDet.Tables[0].Rows[i]["Date"].ToString() + " </td>");
                    Response.Write("<td> " + dsACDet.Tables[0].Rows[i]["Code"].ToString() + " </td>");
                    Response.Write("<td> " + "NO" + "  </td>");
                    Response.Write("<td> " + "YES" + "  </td>");
                    Response.Write("<td> " + dsACDet.Tables[0].Rows[i]["Narration"].ToString() + " </td>");
                    Response.Write("<td> " + 1.00 + " </td>");
                    Response.Write("<td> " + 1.00 + "  </td>");
                    Response.Write("<td> " + dsACDet.Tables[0].Rows[i]["TxnType"].ToString() + " </td>");
                    Response.Write("</tr>");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //    /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
    //       server control at run time. */
    //}
}