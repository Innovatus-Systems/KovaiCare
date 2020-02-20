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














public partial class MenuIngredientEst : System.Web.UI.Page
{
    //SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadTitle();

            DateTime now = DateTime.Now;
           


            dtpmenuforday.SelectedDate = DateTime.Now;


            //LoadReport(dtpmenuforday.SelectedDate.Value);

            LoadSession();



            //LoadDinerspersessiondetailsTotal();


            //SixDates();

            //LoadSessionDetails(Convert.ToDateTime(dtpmenuforday.SelectedDate));

            //rgItemEstimate.DataSource = string.Empty;
            //rgItemEstimate.DataBind();

            //rgRMEstimate.DataSource = string.Empty;
            //rgRMEstimate.DataBind();

        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 94 });


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

    protected void btnSearch_Click(object sender,EventArgs e)
    {
        tblBDet.Visible = true;
        pnlShowDet.Visible = true;
        LoadDinersDet(Convert.ToDateTime(dtpmenuforday.SelectedDate), ddlDinersSession.SelectedValue);
        LoadSessionDetails(Convert.ToDateTime(dtpmenuforday.SelectedDate), ddlDinersSession.SelectedValue);
        LoadRawMaterial(Convert.ToDateTime(dtpmenuforday.SelectedDate), ddlDinersSession.SelectedValue);
        GenerateProductWiseReport(Convert.ToDateTime(dtpmenuforday.SelectedDate), ddlDinersSession.SelectedValue);
        
    }


    private void LoadDinersDet(DateTime selectdate, string Session)
    {
        try
        {
            DataSet dsSessionDetails = sqlobj.ExecuteSP("SP_FetchMenuIngredForDay",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = selectdate },
                new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session }

                );

            if (dsSessionDetails.Tables[0].Rows.Count > 0)
            {
                rgDinersTotal.DataSource = dsSessionDetails;
                rgDinersTotal.DataBind();
            }
            else
            {
                rgDinersTotal.DataSource = string.Empty;
                rgDinersTotal.DataBind();
            }
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

    protected void LoadRawMaterial(DateTime selectdate, string Session)
    {
        try
        {
            DataSet dsSessionDetails = sqlobj.ExecuteSP("SP_FetchMenuIngredForDay",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = selectdate },
                new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session });

            if (dsSessionDetails.Tables[0].Rows.Count > 0)
            {
                rdgRawMaterial.DataSource = dsSessionDetails;
                rdgRawMaterial.DataBind();
            }
            else
            {
                rdgRawMaterial.DataSource = string.Empty;
                rdgRawMaterial.DataBind();
            }
            dsSessionDetails.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    public static void GenerateProductWiseReport(DateTime selectdate, string Session)
    {
        try
        {
            string body = "", mailserver = "", pwd = "", sentby = "", user = "", mailBody = "";
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
            SqlCommand cmd = new SqlCommand("SP_FetchMenuIngredForDay",con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@iMode", 1);
            cmd.Parameters.Add("@Date", selectdate);
            cmd.Parameters.Add("@Session", Session);
           
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dtBooked = new DataTable();
            sda.Fill(dtBooked);

            body = body + "<font face=\"verdana\" size=\"2\">";
            body = body + "<table align=center width=96% ><tr><td align=center bgcolor=\"#FDF8F1\">Menu & Ingredient Estimate Report<br/>Date : " + selectdate.ToString("dd-MMM-yyyy ddd hh:mm tt") + "<br/>Session : " + Session + "&nbsp;&nbsp;to&nbsp;&nbsp;" + DateTime.Now.ToString("dd-MMM-yyyy") + "</b></td></tr></table>";
            body = body + "<table align=center width=96% border=1>";
            body = body + "<tr bgcolor=\"#00A368\" color=\"#ffffff\"><th align=center><b>Regular<b></th><th align=left>Casual</th><th align=right>Guest</th><th align=right>Total</th></tr>";

            foreach (DataRow row in dtBooked.Rows)
            {
                body = body + "<tr><td align=center>" + row["Regular"].ToString() + "</td><td align=left>" + row["Casual"].ToString() + "</td><td align=right>" + row["Guest"].ToString() + "</td><td align=right>" + row["Total"].ToString() + "</td></tr>";
            }
            //body = body + "<tr  bgcolor=\"#00A368\" color=\"#ffffff\"><td align=center></td><td align=right>Total</td><td align=right>" + dtBooked.Rows.Count.ToString() + ".00</td><td align=right>" + sumValue.ToString() + "</td></tr></table>";
            body = body + "<\font>";

            StringReader sr = new StringReader(body);
            Document pdfDoc = new Document(PageSize.A4, 20f, 25f, 30f, 40f);
            HTMLWorker htmlParser = new HTMLWorker(pdfDoc);


            //using (MemoryStream ms = new MemoryStream())
            //{
            //    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, ms);
            //    pdfDoc.Open();
            //    htmlParser.Parse(sr);
            //    pdfDoc.Close();
            //    byte[] bytes = ms.ToArray();

            //    ms.Close();
           
           


            //}

            //System.Web.HttpResponse.
            //Response.Clear();
            //Response.ContentType = "application/force-download";
            //Response.AddHeader("content-disposition", "attachment;    filename=MenuIngredientsEstimate.pdf");
            //Response.BinaryWrite(bytes);
            //Response.End();


            MemoryStream memoryStream = new MemoryStream();
            TextWriter textWriter = new StreamWriter(memoryStream);
            textWriter.WriteLine("Something");
            textWriter.Flush(); // added this line
            byte[] bytesInStream = memoryStream.ToArray(); // simpler way of converting to array
            memoryStream.Close();

            //Response.Clear();
            //Response.ContentType = "application/force-download";
            //Response.AddHeader("content-disposition", "attachment;  filename=name_you_file.xls");
            //Response.BinaryWrite(bytesInStream);
            //Response.End();


            //String path = System.Reflection.Assembly.GetExecutingAssembly().Location;
            //string filename = "mngr_" + DateTime.Now.ToString("ddMMyyyy_hhmmss") + "_SalesReport.pdf";
            //path = @"D:\" + filename;
            //dynamic output = new FileStream(path, FileMode.Create);


            

            //object sumValue = dtSales.Compute("SUM(VALUE)", "");
            //body = body + "<font face=\"verdana\" size=\"2\">";
            //body = body + "<table align=center width=96% ><tr><td align=center bgcolor=\"#FDF8F1\">MD COMMUNITY KITCHEN (P) LTD<br/>Product-wise Sales Report as on : " + DateTime.Now.ToString("dd-MMM-yyyy ddd hh:mm tt") + "<br/>For the period : " + DateTime.Now.ToString("dd-MMM-yyyy") + "&nbsp;&nbsp;to&nbsp;&nbsp;" + DateTime.Now.ToString("dd-MMM-yyyy") + "<br/>Product count : <b>" + dtSales.Rows.Count.ToString() + ".00 </b>&nbsp;&nbsp;Total Amount : <b>Rs. " + sumValue.ToString() + "</b></td></tr></table>";
            //body = body + "<table align=center width=96% border=1>";
            //body = body + "<tr bgcolor=\"#00A368\" color=\"#ffffff\"><th align=center><b>Outlet Name<b></th><th align=left>Product Name</th><th align=right>Quantity</th><th align=right>Amount(Rs.)</th></tr>";

            //foreach (DataRow row in dtSales.Rows)
            //{
            //    body = body + "<tr><td align=center>" + row["OutletName"].ToString() + "</td><td align=left>" + row["ProductName"].ToString() + "</td><td align=right>" + row["Total Sales"].ToString() + "</td><td align=right>" + row["Value"].ToString() + "</td></tr>";
            //}
            //body = body + "<tr  bgcolor=\"#00A368\" color=\"#ffffff\"><td align=center></td><td align=right>Total</td><td align=right>" + dtSales.Rows.Count.ToString() + ".00</td><td align=right>" + sumValue.ToString() + "</td></tr></table>";
            //body = body + "<\font>";



            //// String path = System.Reflection.Assembly.GetExecutingAssembly().Location;
            ////string filename = "mngr_" + DateTime.Now.ToString("ddMMyyyy_hhmmss") + "_SalesReport.pdf";
            ////string path = @"D:\IFIPL Reports\" + filename;
            ////dynamic output = new FileStream(path, FileMode.Create);
            
            
            //StringReader sr = new StringReader(body);
            //Document pdfDoc = new Document(PageSize.A4, 20f, 25f, 30f, 40f);
            //HTMLWorker htmlParser = new HTMLWorker(pdfDoc);
            //using (MemoryStream ms = new MemoryStream())
            //{
            //    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, ms);
            //    pdfDoc.Open();
            //    htmlParser.Parse(sr);
            //    pdfDoc.Close();
            //    byte[] bytes = ms.ToArray();

            //    ms.Close();
            //    SqlCommand cmd1 = new SqlCommand(string.Concat("SELECT * FROM cpmailcredentials"), con);

            //    SqlDataAdapter da = new SqlDataAdapter(cmd1);
            //    DataSet dsCredential = new DataSet();

            //    da.Fill(dsCredential);

            //    // Write an informational entry to the event log.    

            //    if (dsCredential != null && dsCredential.Tables.Count > 0)
            //    {
            //        foreach (DataRow row in dsCredential.Tables[0].Rows)
            //        {
            //            mailserver = row["mailserver"].ToString();
            //            user = row["username"].ToString();
            //            pwd = row["password"].ToString();
            //            sentby = row["sentbyuser"].ToString();
            //        }
            //        SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
            //        MailAddress From = new MailAddress(user, "Special Support Team - MDCK");
            //        MailMessage myMail = new System.Net.Mail.MailMessage();
            //        myMail.From = From;

            //        string filename = "mngr_" + DateTime.Now.ToString("ddMMyyyy_hhmmss") + "_SalesReport.pdf";

            //        mySmtpClient.UseDefaultCredentials = false;
            //        System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
            //        mySmtpClient.Credentials = basicauth;
            //        mySmtpClient.EnableSsl = true;
            //        myMail.SubjectEncoding = System.Text.Encoding.UTF8;
            //        myMail.BodyEncoding = System.Text.Encoding.UTF8;
            //        myMail.Attachments.Add(new Attachment(new MemoryStream(bytes), filename));
            //        myMail.IsBodyHtml = true;
            //        myMail.To.Add("bhavanivel0410@gmail.com");
            //        myMail.CC.Add("div3_ifpl@yahoo.co.in");
            //        myMail.CC.Add("servicesupport@indianfoods.in");
            //        myMail.CC.Add("sridhar@innovatussystems.com");
            //        myMail.CC.Add("thangavel@innovatussystems.com");
            //        myMail.CC.Add("vivek@innovatussystems.com");
            //        myMail.Bcc.Add("murugan@innovatussystems.com");
            //        myMail.Bcc.Add("varadharaj@innovatussystems.com");

            //        myMail.Subject = "Sales report " + DateTime.Now.ToString("dd-MMM-yyyy");
            //        mailBody = "<p style=\"font-family: Verdana;font-size:12px;color:#0B53B8\">Dear All,<br/>&nbsp;&nbsp;&nbsp;Please find attached the PDF version of product-wise sales report as on " + DateTime.Now.ToString("dd-MMM-yyyy hh:mm tt") + ".<br/><br/>This is an autogenerated mail from MDCK system.</p>";
            //        myMail.Body = mailBody;
            //        mySmtpClient.Send(myMail);

            //    }
            //}


        }
        catch (Exception ex)
        {

        }
    }

    protected void lnkViewHide_Click(object sender, EventArgs e)
    {
        if (rdgRawMaterial.Visible == true)
        {
            rdgRawMaterial.Visible = false;
        }
        else if (rdgRawMaterial.Visible == false)
        {
            rdgRawMaterial.Visible = true;
        }
    }
}