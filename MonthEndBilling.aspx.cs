using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using Telerik.Web.UI;

public partial class MonthEndBilling : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    static string contName;
    static string commnty;
    static string Address1;
    static string Address2;
    static string Address3;
    static string Pan;
    static string gstin;
    static string Jurisdiction;
    static string BankName;
    static string BranchName;
    static string AccountNo;
    static string IFSCCode;
    static string payment;
    static string strFooter;
    static string Duration;
    static decimal DI = 0;
    static decimal MI = 0;
    static decimal NC = 0;
    static string invNo;
    static decimal Amount;
    static decimal Total;
    static decimal CGSTAmt;
    static decimal SGSTAmt;
    static string RTRSN;
    static string Villa;
    static string Resident;
    static string Adress;
    static string Cty;
    static string Accountcode;
    static string outstd;
    static string MobileNo;
    static string EmailId;
    static string strQuery;
    DateTime Odate;
    static string printedOn;
    static string date;
    DataTable dtservice = null;
    DataTable dtGSTF = null;
    static string whr;
    static string Bmonth;
    static string BFROM;
    static string BTILL;
    static string Email;
    static string FileName1;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            rgMonthEndBillDashboard.Visible = false;
            LoadTitle();
            //LoadDetails();
            //LoadMonthEndDashBoard();
            //rdobtnTrial.Checked = true;
            btnSearch.Visible = true;
            btnProcess.Visible = false;
            btnStatus.Visible = false;
            btnExit.Visible = false;
            ViewState["Footer"] = null;
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 126 });
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

    private void LoadDetails()
    {
        try
        {

            DataSet dsDetails = new DataSet();
            dsDetails = sqlobj.ExecuteSP("SP_GetBillingPerioddetails");
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                lblCurrentBillingMonth.Text = dsDetails.Tables[1].Rows[0]["CurrentBillingMonth"].ToString();
                lbltodayis.Text = dsDetails.Tables[1].Rows[0]["Todayis"].ToString();
                DateTime cdate = DateTime.Now;
                // --  Start enable live
                string strdate = cdate.ToString("dd/MM/yyyy");
                DateTime bdate = DateTime.ParseExact(dsDetails.Tables[1].Rows[0]["Tilldate"].ToString(), @"dd/MM/yyyy",
                System.Globalization.CultureInfo.InvariantCulture);
                bdate = bdate.AddDays(1);
                string tilldate = bdate.ToString("dd/MM/yyyy");
                btnProcess.Visible = true;
                btnSearch.Visible = true;
                btnStatus.Visible = true;
                //if (strdate.ToString() == tilldate.ToString())
                //{
                //    //rdobtnLive.Visible = true;
                //    btnProcess.Visible = true;
                //    btnSearch.Visible = false;
                //    btnStatus.Visible = false;
                //}
                //else
                //{
                //    //rdobtnLive.Visible = false;
                //    btnProcess.Visible = false;
                //    btnSearch.Visible = false;
                //    btnStatus.Visible = false;
                //    //btnProcess.Visible = false;
                //    //btnSearch.Visible = false;
                //    //btnStatus.Visible = false;
                //}
                // -- End enable live
                lblpossibleon.Text = dsDetails.Tables[1].Rows[0]["Possibleon"].ToString();
                lbltotalnoofresidents.Text = dsDetails.Tables[3].Rows[0]["TotalResidents"].ToString();
                lbltotalnoofbills.Text = dsDetails.Tables[4].Rows[0]["TotalBills"].ToString();
            }
            dsDetails.Dispose();
            btnExit.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadMonthEndDashBoard()
    {
        try
        {
            DataSet dsMonthEndDashBoard = sqlobj.ExecuteSP("SP_MonthendbillDashboard");

            if (dsMonthEndDashBoard.Tables[0].Rows.Count > 0)
            {
                rgMonthEndBillDashboard.DataSource = dsMonthEndDashBoard.Tables[0];
                rgMonthEndBillDashboard.DataBind();
            }
            else
            {
                rgMonthEndBillDashboard.DataSource = string.Empty;
                rgMonthEndBillDashboard.DataBind();
            }
            dsMonthEndDashBoard.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                string rsn = string.Empty;

                SqlDataAdapter da = new SqlDataAdapter();
                DataSet dsRSN = sqlobj.ExecuteSP("Sp_GetDetailsForInvoice");
                //da.Fill(dsRSN);
                if (dsRSN.Tables[0] != null && dsRSN.Tables[0].Rows.Count > 0)
                {
                    rsn = dsRSN.Tables[0].Rows[0]["RSN"].ToString();
                }
                if (dsRSN.Tables[1] != null && dsRSN.Tables[1].Rows.Count > 0)
                {
                    DI = Convert.ToDecimal(dsRSN.Tables[1].Rows[0]["DI"].ToString());
                }
                if (dsRSN.Tables[2] != null && dsRSN.Tables[2].Rows.Count > 0)
                {
                    MI = Convert.ToDecimal(dsRSN.Tables[2].Rows[0]["MI"].ToString());
                }
                if (dsRSN.Tables[3] != null && dsRSN.Tables[3].Rows.Count > 0)
                {
                    NC = Convert.ToDecimal(dsRSN.Tables[3].Rows[0]["NC"].ToString());
                }
                DataSet dsDetails = sqlobj.ExecuteSP("Proc_GetData_AccountCode");
                if (dsDetails.Tables[0].Rows.Count > 0)
                {
                    commnty = dsDetails.Tables[2].Rows[0]["CommunityName"].ToString();
                    Address1 = dsDetails.Tables[2].Rows[0]["Name"].ToString();
                    Address2 = dsDetails.Tables[2].Rows[0]["Add1"].ToString();
                    Address3 = dsDetails.Tables[2].Rows[0]["City"].ToString() + " , " + dsDetails.Tables[2].Rows[0]["pincode"].ToString();
                    gstin = dsDetails.Tables[2].Rows[0]["gstin_UIN"].ToString();
                    Pan = dsDetails.Tables[2].Rows[0]["pan_NO"].ToString();
                    Jurisdiction = dsDetails.Tables[2].Rows[0]["Jurisdiction"].ToString();
                    BankName = dsDetails.Tables[2].Rows[0]["BankName"].ToString();
                    BranchName = dsDetails.Tables[2].Rows[0]["BranchName"].ToString();
                    AccountNo = dsDetails.Tables[2].Rows[0]["AccountNo"].ToString();
                    IFSCCode = dsDetails.Tables[2].Rows[0]["IFSCCode"].ToString();
                    SendMail(dsDetails.Tables[0], dsDetails.Tables[1], dsDetails.Tables[3]);
                    btnSearch.Visible = false;
                    btnProcess.Visible = false;
                    btnStatus.Visible = true;
                }
            }

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    public partial class Footer : PdfPageEventHelper
    {
        //string msg = ViewState["Footer"].ToString();
        public override void OnEndPage(PdfWriter writer, Document doc)
        {
            float cellHeight = doc.TopMargin;
            Rectangle page = doc.PageSize;
            //Paragraph footer = new Paragraph(commnty + " || " + "  Incharge : " + contName + "||" + " Instruction : " + payment, FontFactory.GetFont(FontFactory.TIMES, 12, iTextSharp.text.Font.NORMAL));
            Paragraph footer = new Paragraph(strFooter, FontFactory.GetFont(FontFactory.TIMES, 12, iTextSharp.text.Font.NORMAL));
            footer.Alignment = Element.ALIGN_CENTER;
            PdfPTable footerTbl = new PdfPTable(1);
            footerTbl.TotalWidth = 500;
            footerTbl.HorizontalAlignment = Element.ALIGN_CENTER;
            PdfPCell cell = new PdfPCell(footer);
            cell.Border = 0;
            cell.PaddingLeft = 10;
            footerTbl.AddCell(cell);
            //Paragraph header = new Paragraph(commnty, FontFactory.GetFont(FontFactory.TIMES, 14, iTextSharp.text.Font.BOLD));
            //header.Alignment = Element.ALIGN_CENTER;
            //PdfPTable headertbl = new PdfPTable(1);
            //headertbl.TotalWidth = 500;
            //headertbl.HorizontalAlignment = Element.ALIGN_CENTER;
            //PdfPCell hcell = new PdfPCell(header);
            //hcell.Border = 0;
            //hcell.PaddingLeft = 10;
            //headertbl.AddCell(hcell);
            ////footerTbl.WriteSelectedRows(0, -1, 415, 30, writer.DirectContent);
            //footerTbl.WriteSelectedRows(0, -1, 150, 50, writer.DirectContent);
            ////footerTbl.WriteSelectedRows(0, -1, 10f, writer.PageSize.GetBottom(doc.BottomMargin), writer.DirectContent);
            //headertbl.WriteSelectedRows(0, -1, 270, page.Height - cellHeight + headertbl.TotalHeight, writer.DirectContent);
        }
    }
    public void SendSA()
    {
        try
        {
            DataSet dsBillingMonth = sqlobj.ExecuteSP("SP_GetBillingMonth");
            string strBillingMonth = dsBillingMonth.Tables[0].Rows[0]["BillingMonth"].ToString();
            DateTime dFrom = Convert.ToDateTime(dsBillingMonth.Tables[0].Rows[0]["FromDate"].ToString());
            DateTime dTo = Convert.ToDateTime(dsBillingMonth.Tables[0].Rows[0]["ToDate"].ToString());
            // -- Innovatus Header
            StringBuilder sb = new StringBuilder();
            sb.Append("<table width='100%' cellspacing='2' cellpadding='2' style='font-family:Verdana;margin-left:15px;'>");
            //sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'><b> " + commnty + " </b> </td></tr>");
            sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'>Innovatus Systems</td></tr>");
            sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:10px;'>No 42, Meenakshi Nagar,Kovaipudur,Coimbatore-641042</td></tr>");
            sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:10px;'>Phone:422 2604370,Email:info@innovatussystems.com</td></tr>");
            sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:10px;'>Registration No:AAEFI1030JSD002,PAN No:AAEFI1030J</td></tr>");
            sb.Append("</table>");
            sb.Append("-----------------------------------------------------------------------------------------------------------------------------------");
            sb.Append("<table width='100%' cellspacing='3' cellpadding='3' style='font-family:Verdana;margin-left:15px;'>");
            sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:12px;'>Software Usage - Statement of Account</td></tr>");
            sb.Append("</table>");
            sb.Append("<br/>");
            // -- customer Name
            string strComName = "";
            string strPhone = "";
            string strEmail = "";
            string strContatName = "";
            DataSet dsCommunity = sqlobj.ExecuteSP("SP_GetCommunityDeatils");
            if (dsCommunity.Tables[0].Rows.Count > 0)
            {
                strComName = dsCommunity.Tables[0].Rows[0]["CommunityName"].ToString();
                strPhone = dsCommunity.Tables[0].Rows[0]["FromMobileNo"].ToString();
                strEmail = dsCommunity.Tables[0].Rows[0]["FromID"].ToString();
                strContatName = dsCommunity.Tables[0].Rows[0]["ContactPName"].ToString();
            }
            sb.Append("<table width='100%' cellspacing='3' cellpadding='3' style='font-family:Verdana;margin-left:15px;'>");
            sb.Append("<tr><td align='left' colspan='4' style='background-color: #18B5F0;font-size:10px;'>Community Name:" + strComName.ToString() + "</td></tr>");
            sb.Append("<tr><td align='left' colspan='4' style='background-color: #18B5F0;font-size:10px;'>Phone:" + strPhone.ToString() + ",Email:" + strEmail.ToString() + "</td></tr>");
            sb.Append("<tr><td align='left' colspan='4' style='background-color: #18B5F0;font-size:10px;'>Contact Name:" + strContatName.ToString() + "</td></tr>");
            sb.Append("</table>");
            // -- Daily Billing Details
            DataTable dtNew = new DataTable();
            DataSet dsUsageBilling = sqlobj.ExecuteSP("SP_ReceiptsofDailyUsageBilling",
                new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = dFrom.ToString("yyyy-MM-dd") },
                new SqlParameter() { ParameterName = "@ToDate", SqlDbType = SqlDbType.DateTime, Value = dTo.ToString("yyyy-MM-dd") }
                );
            if (dsUsageBilling.Tables[0].Rows.Count > 0)
            {
                dtNew = dsUsageBilling.Tables[0];
            }
            dsUsageBilling.Dispose();
            sb.Append("<table border = '1' width='100%' style='margin-left:15px;'>");
            sb.Append("<tr>");
            foreach (DataColumn column in dtNew.Columns)
            {
                if (column.ColumnName == "Date")
                {
                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='center'>");
                }
                else if (column.ColumnName == "Narration")
                {
                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='left'>");
                }
                else if (column.ColumnName == "Type")
                {
                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='center'>");
                }
                else if (column.ColumnName == "Amount")
                {
                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='right'>");
                }
                else if (column.ColumnName == "Balance")
                {
                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='right'>");
                }
                sb.Append(column.ColumnName);
                sb.Append("</th>");
            }

            sb.Append("</tr>");
            foreach (DataRow row in dtNew.Rows)
            {
                sb.Append("<tr>");
                foreach (DataColumn column in dtNew.Columns)
                {
                    if (column.ToString() == "Date")
                    {
                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='center'>");
                    }
                    else if (column.ToString() == "Narration")
                    {
                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='left'>");
                    }
                    else if (column.ToString() == "Type")
                    {
                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='center'>");
                    }
                    else if (column.ToString() == "Amount")
                    {
                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='right'>");
                    }
                    else if (column.ToString() == "Balance")
                    {
                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='right'>");
                    }

                    sb.Append(row[column]);
                    sb.Append("</td>");
                }
                sb.Append("</tr>");
            }
            //sb.Append("<tr>");
            //foreach (DataColumn column in dt.Columns)
            //{
            //    sb.Append("<td>");
            //    sb.Append(dt.Rows[i][column]);
            //    sb.Append("</td>");
            //}
            //sb.Append("</tr>");
            sb.Append("</table>");
            StringBuilder sbBody = new StringBuilder();
            sbBody.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;font-size:14px;'>");
            //sbBody.Append("<tr style='font-family:Verdana;font-size:14px;'><td><b> Dear " + Resident + " ,</b></td></tr>");
            sbBody.Append("<tr><td><b> Dear Sir/Madam ,</b></td></tr>");
            sbBody.Append("<tr><td>Please find attached the software usage - statement of account for " + strBillingMonth.ToString());
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td></td></tr>");
            sbBody.Append("<tr><td></td></tr>");
            sbBody.Append("<tr><td>The statement is in PDF Format and can be opened by Adobe ® Acrobat reader by clicking on the attachment.");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td></td></tr>");
            sbBody.Append("<tr><td></td></tr>");
            sbBody.Append("<tr><td>Sincerely yours,");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td>Innovatus Systems");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td>Phone:422-2604370</td></tr>");
            sbBody.Append("<tr><td>Email:Info@innvoatussystems.com</td></tr>");
            sbBody.Append("</table>");
            StringReader sr = new StringReader(sb.ToString());
            Document pdfDoc = new Document(PageSize.A4, 50f, 20f, 40f, 50f);
            //Document pdfDoc = new Document(PageSize.A4,50f,20f,)
            //pdfDoc.SetMargins(30f,20f,20f,20f);                   
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            using (MemoryStream memoryStream = new MemoryStream())
            {
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
                pdfDoc.Open();
                writer.PageEvent = new Footer();
                htmlparser.Parse(sr);
                pdfDoc.Close();
                byte[] bytes = memoryStream.ToArray();
                memoryStream.Close();
                string mailserver = string.Empty;
                string user = string.Empty;
                string pwd = string.Empty;
                string sentby = string.Empty;
                SqlCommand cmd = new SqlCommand(string.Concat("SELECT * FROM cpmailcredentials"), con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet dsCredential = new DataSet();
                da.Fill(dsCredential);
                // Write an informational entry to the event log.  
                if (dsCredential != null && dsCredential.Tables.Count > 0)
                {
                    foreach (DataRow row in dsCredential.Tables[0].Rows)
                    {
                        mailserver = row["mailserver"].ToString();
                        user = row["username"].ToString();
                        pwd = row["password"].ToString();
                        sentby = row["sentbyuser"].ToString();
                    }
                }

                //SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                //MailAddress From = new MailAddress(user, "info@innovatussystems.com");
                //MailMessage myMail = new System.Net.Mail.MailMessage();
                //myMail.From = From;
                //myMail.To.Add("varadharaj@innovatussystems.com");

                SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                MailAddress From = new MailAddress(user, "info@innovatussystems.com");
                MailMessage myMail = new System.Net.Mail.MailMessage();
                myMail.From = From;
                //myMail.To.Add("rangan@innovatussystems.com");
                myMail.To.Add("varadharaj@innovatussystems.com");
                //myMail.CC.Add("rangan@innovatussystems.com");

                //foreach (DataRow row in dsMails.Tables[0].Rows)
                //{
                //    //myMail.CC.Add(row[0].ToString());
                //    if (strCC == "")
                //    {
                //        strCC = row[0].ToString();
                //    }
                //    else
                //    {
                //        strCC = strCC + ";" + row[0].ToString();
                //    }
                //}Name of the resident -  Door No. -    Statement for mmm-yy -    Name of Community
                string FileName = "Software usage - statement of account for" + strBillingMonth.ToString() + ".pdf";
                mySmtpClient.UseDefaultCredentials = false;
                System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
                mySmtpClient.Credentials = basicauth;
                mySmtpClient.EnableSsl = true;
                myMail.SubjectEncoding = System.Text.Encoding.UTF8;
                myMail.BodyEncoding = System.Text.Encoding.UTF8;
                myMail.Attachments.Add(new Attachment(new MemoryStream(bytes), FileName));
                myMail.IsBodyHtml = true;
                myMail.Subject = "Software usage - statement of account for " + strBillingMonth.ToString() + ".pdf";
                myMail.Body = sbBody.ToString();
                mySmtpClient.Send(myMail);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LocalSaving(DataTable dtData)
    {
        string outstd = "";
        int count = 0;
        outstd = "";
        Amount = 0;
        CGSTAmt = 0;
        SGSTAmt = 0;
        Total = 0;
        count = 0;
        System.Web.HttpResponse Response = System.Web.HttpContext.Current.Response;
        HttpContext.Current.Response.Clear();
        string mailserver = string.Empty;
        string user = string.Empty;
        string pwd = string.Empty;
        string sentby = string.Empty;

        SqlCommand cmd = new SqlCommand("Proc_GetEmailCredentials", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet dsCredential = new DataSet();
        da.Fill(dsCredential);
        // Write an informational entry to the event log.
        if (dsCredential != null && dsCredential.Tables.Count > 0)
        {
            foreach (DataRow row in dsCredential.Tables[0].Rows)
            {
                mailserver = row["mailserver"].ToString();
                user = row["username"].ToString();
                pwd = row["password"].ToString();
                sentby = row["sentbyuser"].ToString();
                Email = row["Email"].ToString();
            }
        }
        SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
        MailAddress From = new MailAddress(user, "info@innovatussystems.com");
        MailMessage myMail = new System.Net.Mail.MailMessage();
        myMail.From = From;
        myMail.To.Add(Email);
        myMail.CC.Add("covaiproprarch@gmail.com");
        mySmtpClient.UseDefaultCredentials = false;
        System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
        mySmtpClient.Credentials = basicauth;
        mySmtpClient.EnableSsl = false;
        mySmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
        //mySmtpClient.Timeout = 200000;
        myMail.SubjectEncoding = System.Text.Encoding.UTF8;
        myMail.BodyEncoding = System.Text.Encoding.UTF8;
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter hw = new HtmlTextWriter(sw))
            {
                dtservice = dtData;
                invNo = dtservice.Rows[0]["InvoiceNo"].ToString();
                //string NARATION = dtservice.Rows[0]["Particulars"].ToString();
                string NARATION = "MEB";
                // dtservice.DefaultView.Sort = "Date ASC";                            
                StringBuilder sb1 = new StringBuilder();
                sb1.Append("<table width='100%' padding='-5PX'  style='font-family:Verdana;margin-left:15px;'>");
                sb1.Append("<tr><td align='center' colspan='4' style='font-size:10px;'><b> " + commnty + " </b> </td></tr>");
                sb1.Append("<tr><td align='center' colspan='4' style='font-size:9px;'> " + Address1 + " </td></tr>");
                sb1.Append("<tr><td align='center' colspan='4' style='font-size:9px;'> " + Address2 + "  </td></tr>");
                sb1.Append("<tr><td align='center' colspan='4' style='font-size:9px;'> " + Address3 + "  </td></tr>");
                sb1.Append("<tr><td align='center' colspan='4' style='font-size:9px;'> GSTIN/UIN: " + gstin + " / Pan: " + Pan + "  </td></tr>");
                sb1.Append("</table>");
                sb1.Append("<table  width='100%' style='margin-left:15px;opacity:0.5;border:0.1px solid black'>");
                sb1.Append("<tr >");
                sb1.Append("<td align='Left' style='font-size:10px;'>");
                sb1.Append("Invoice No.:" + invNo + "");
                sb1.Append("</td>");
                sb1.Append("<td align='RIGHT' style='font-size:10px;'>");
                sb1.Append("Invoice Date: " + date + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("</table>");

                sb1.Append("<table  width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                sb1.Append("<tr >");
                sb1.Append("<td align='Left' style='font-size:8px;'>");
                sb1.Append("<b>" + Villa + "</b> - " + Resident + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<tr >");
                sb1.Append("<td align='Left' style='font-size:8px;'>");
                sb1.Append("" + Adress + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<tr >");
                sb1.Append("<td align='Left' style='font-size:8px;'>");
                sb1.Append("" + Cty + " ");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("</table>");
                sb1.Append("<table border = '1' width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                sb1.Append("<tr >");

                foreach (DataColumn column in dtservice.Columns)
                {

                    if (column.ColumnName != "RTRSN")
                    {
                        if (column.ColumnName != "ACCOUNTCODE")
                        {
                            if (column.ColumnName == "Particulars")
                            {
                                sb1.Append("<td style ='font-size:11px;font-family:Verdana;' colspan='1'  align='Left'>");
                            }
                            else if (column.ColumnName == "HSN/SAC")
                            {
                                sb1.Append("<td style ='font-size:11px;font-family:Verdana;' align='center'>");
                            }
                            else if (column.ColumnName == "GST Rate%")
                            {
                                sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='right'>");
                            }
                            else if (column.ColumnName == "TaxableVlu")
                            {
                                sb1.Append("<td style ='font-size:11px;font-family:Verdana;width:8%;' align='right'>");
                            }
                            else if (column.ColumnName == "CGST Amt")
                            {
                                sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='right'>");
                            }
                            else if (column.ColumnName == "SGST Amt")
                            {
                                sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='right'>");
                            }
                            else if (column.ColumnName == "Total")
                            {
                                sb1.Append("<td style ='font-size:11px;font-family:Verdana;width:8%;' align='right'>");
                            }
                            sb1.Append("<b>" + column.ColumnName + "</b>");
                            sb1.Append("</td>");
                        }
                    }
                }
                sb1.Append("</tr>");
                string GST = "";
                decimal amount = 0;
                foreach (DataRow row in dtservice.Rows)
                {
                    count = count + 1;
                    sb1.Append("<tr>");
                    foreach (DataColumn column in dtservice.Columns)
                    {
                        if (column.ColumnName != "RTRSN")
                        {
                            if (column.ColumnName != "ACCOUNTCODE")
                            {
                                if (column.ToString() == "Particulars")
                                {
                                    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;'  align='Left'>");
                                }
                                else if (column.ToString() == "HSN/SAC")
                                {
                                    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='center'>");
                                }
                                else if (column.ToString() == "GST Rate%")
                                {
                                    GST = row[column].ToString();
                                    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='right'>");
                                }
                                else if (column.ToString() == "TaxableVlu")
                                {
                                    Amount = Amount + Convert.ToDecimal(row[column]);
                                    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='right'>");
                                }
                                else if (column.ToString() == "CGST Amt")
                                {
                                    CGSTAmt = CGSTAmt + Convert.ToDecimal(row[column]);
                                    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='right'>");
                                }
                                else if (column.ToString() == "SGST Amt")
                                {
                                    SGSTAmt = SGSTAmt + Convert.ToDecimal(row[column]);
                                    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='right'>");
                                }

                                else if (column.ToString() == "Total")
                                {
                                    Total = Total + Convert.ToDecimal(row[column]);
                                    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='right'>");
                                }
                                if (column.ToString() != "#")
                                {
                                    sb1.Append(row[column]);
                                }
                                sb1.Append("</td>");
                            }
                        }
                    }
                    sb1.Append("</tr>");
                }
                decimal CGST = Convert.ToDecimal(GST) / 2;
                count = count + 1;
                sb1.Append("<tr>");
                sb1.Append("<td  align='left' colspan='3' style='font-size:8px;'>Total");
                sb1.Append("</td>");
                sb1.Append("<td  align='Right' style='font-size:8px;'>" + Amount + "");
                sb1.Append("</td>");
                sb1.Append("<td  align='Right' style='font-size:8px;'>" + CGSTAmt + "");
                sb1.Append("</td>");
                sb1.Append("<td  align='Right' style='font-size:8px;'>" + SGSTAmt + "");
                sb1.Append("</td>");
                sb1.Append("<td  align='Right' style='font-size:8px;'>" + Total + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<tr>");
                sb1.Append("<td align='left' style='font-size:8px;' colspan='6'>Amount chargeable (in words)");
                sb1.Append("</td>");
                sb1.Append("<td style='font-size:8px;'>E&O.E.");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<tr>");
                sb1.Append("<td align='left' style='font-size:8px;' colspan='7'>Rupees " + ConvertToWords(Convert.ToString(Total)) + "");
                Amount = amount;
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("</table>");
                sb1.Append("<table  width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                sb1.Append("<tr>");
                sb1.Append("<td align='left' colspan='6' style='font-size:8px;'>Invoice Printed on " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm") + " Hrs.");
                sb1.Append("</td>");
                sb1.Append("<td>");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("</table>");
                sb1.Append("<table border = '1' width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                sb1.Append("<tr>");
                sb1.Append("<td align='left' colspan='2' style='font-size:8px;'><b>Company’s bank details</b>");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<tr>");
                sb1.Append("<td align='left' colspan='1' style='font-size:8px;'>Bank name");
                sb1.Append("</td>");
                sb1.Append("<td style='font-size:8px;'>" + BankName + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<tr>");
                sb1.Append("<td align='left' colspan='1' style='font-size:8px;'>Branch");
                sb1.Append("</td>");
                sb1.Append("<td style='font-size:8px;'>" + BranchName + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<tr>");
                sb1.Append("<td align='left' colspan='1' style='font-size:8px;'>Account no");
                sb1.Append("</td>");
                sb1.Append("<td style='font-size:8px;'>" + AccountNo + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<tr>");
                sb1.Append("<td align='left' colspan='1' style='font-size:8px;'>IFSC Code");
                sb1.Append("</td>");
                sb1.Append("<td style='font-size:8px;'>" + IFSCCode + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("</table><br/>");
                sb1.Append("<table  width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                sb1.Append("<tr>");
                sb1.Append("<td align='right' colspan='4' style='font-size:8px;'>" + commnty + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<br/>");
                sb1.Append("<tr>");
                sb1.Append("<td align='right' colspan='4' style='font-size:8px;'>");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<br/>");
                sb1.Append("<tr>");
                sb1.Append("<td align='right' colspan='4' style='font-size:8px;'>");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("</table><br/>");
                sb1.Append("<table  width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                sb1.Append("<tr>");
                sb1.Append("<td align='Center' colspan='4'  style='font-size:10px;'>" + Jurisdiction + "");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("<tr>");
                sb1.Append("<td align='Center' colspan='4' style='font-size:8px;'>This is a computer generated invoice");
                sb1.Append("</td>");
                sb1.Append("<td>");
                sb1.Append("</td>");
                sb1.Append("</tr>");
                sb1.Append("</table><br/>");
                StringReader sr1 = new StringReader(sb1.ToString());
                //sb1.Length = 0;
                //sb1.Clear();
                FileName1 = Villa + "_" + Resident + "_" + Bmonth + ".pdf";
                Document pdfDoc1 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                //Document pdfDoc2 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                //HttpContext.Current.Response.Clear();
                //HttpContext.Current.Response.ClearContent();    // Add this line
                //HttpContext.Current.Response.ClearHeaders();
                //HttpContext.Current.Response.ContentType = "application/pdf";
                //HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + FileName1 + "");
                //HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HTMLWorker htmlparser1 = new HTMLWorker(pdfDoc1);
                //HTMLWorker htmlparser2 = new HTMLWorker(pdfDoc2);

                using (MemoryStream memoryStream1 = new MemoryStream())
                {
                    PdfWriter writer1 = PdfWriter.GetInstance(pdfDoc1, Response.OutputStream);
                    //PdfWriter writer2 = PdfWriter.GetInstance(pdfDoc2, new FileStream(@"F:\Dhinesh\Files" + @"\" + replace, FileMode.Create));

                    pdfDoc1.Open();
                    writer1.PageEvent = new Footer();
                    htmlparser1.Parse(sr1);
                    pdfDoc1.Close();
                    //Response.Write(pdfDoc2);
                    //HttpContext.Current.Response.Flush();
                    byte[] bytes1 = memoryStream1.ToArray();
                    memoryStream1.Close();
                    FileName1 = Bmonth + "_" + "_" + Villa + "_" + Resident + "_" + NARATION + ".pdf";
                    myMail.Attachments.Add(new Attachment(new MemoryStream(bytes1), FileName1));
                }
            }
            StringBuilder sbBody = new StringBuilder();
            sbBody.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;font-size:14px;'>");
            sbBody.Append("<tr><td><b> Greetings,</b></td></tr>");
            sbBody.Append("<tr><td>Your Billing for <b>" + Bmonth + "</b> <b> is " + outstd + "</b>.");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td>The Invoice(s) are attached.</b>");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td>Kindly make arrangements to pay within 10 days of this mail.</td></tr>");
            sbBody.Append("<tr><td>With Best Regards,");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td><b>" + commnty + "</b></td></tr>");
            sbBody.Append("<tr><td>");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td> ");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td></td></tr>");
            sbBody.Append("<tr><td>The Invoice(s) in PDF Format and can be opened by Adobe ® Acrobat reader by clicking on the attachment.");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td></td></tr>");
            sbBody.Append("<tr style='font-family:Verdana;font-size:13px;'><td><b>This is an automatically generated mail from <a href='http://www.covaiseniorliving.com/' title='Click here to open ORIS'>CovaiSmart</a>, the software for Retirement Communities.</b></td></tr>");
            sbBody.Append("</table>");
            myMail.IsBodyHtml = true;
            myMail.Subject = Bmonth + "_" + "_" + Villa + "_" + Resident;
            myMail.Body = sbBody.ToString();
            mySmtpClient.Send(myMail);

            //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
        }
    }
    public void SendMail(DataTable dt, DataTable dtPersonal, DataTable dtGST)
    {
        try
        {
            System.Web.HttpResponse Response = System.Web.HttpContext.Current.Response;
            HttpContext.Current.Response.Clear();

            string mailserver = string.Empty;
            string user = string.Empty;
            string pwd = string.Empty;
            string sentby = string.Empty;
            int InvCount = 0;

            SqlCommand cmd = new SqlCommand("Proc_GetEmailCredentials", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet dsCredential = new DataSet();
            da.Fill(dsCredential);
            // Write an informational entry to the event log.
            if (dsCredential != null && dsCredential.Tables.Count > 0)
            {
                foreach (DataRow row in dsCredential.Tables[0].Rows)
                {
                    mailserver = row["mailserver"].ToString();
                    user = row["username"].ToString();
                    pwd = row["password"].ToString();
                    sentby = row["sentbyuser"].ToString();
                    //Email = row["Email"].ToString();
                    Email = "rangan@innovatussystems.com";
                    //Email = "vijaya@covaicare.com";
                }
            }
            SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
            MailAddress From = new MailAddress(user, "covais3@covaicare.com");
            MailMessage myMail = new System.Net.Mail.MailMessage();
            myMail.From = From;
            myMail.To.Add(Email);
            //myMail.CC.Add("covaiproprarch@gmail.com");
            //myMail.Bcc.Add("thangavel@innovatussystems.com");
            mySmtpClient.UseDefaultCredentials = false;
            System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
            mySmtpClient.Credentials = basicauth;
            mySmtpClient.EnableSsl = false;
            mySmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            mySmtpClient.Timeout = 400000;
            myMail.SubjectEncoding = System.Text.Encoding.UTF8;
            myMail.BodyEncoding = System.Text.Encoding.UTF8;

            DataSet dsDetails = new DataSet();
            SqlCommand cmd1 = new SqlCommand("Proc_GetGST", con);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@where", whr);
            SqlDataAdapter dap = new SqlDataAdapter(cmd1);
            dap.Fill(dsDetails, "temp");
            Bmonth = dsDetails.Tables[0].Rows[0]["BPName"].ToString();
            BFROM = dsDetails.Tables[0].Rows[0]["BPFROM"].ToString();
            BTILL = dsDetails.Tables[0].Rows[0]["BPTILL"].ToString();
            DataTable dtNew = new DataTable();
            for (int i = 0; i < dtPersonal.Rows.Count; i++)
            {
                string outstd = "";
                int count = 0;
                outstd = "";
                Amount = 0;
                CGSTAmt = 0;
                SGSTAmt = 0;
                Total = 0;
                count = 0;
                RTRSN = dtPersonal.Rows[i]["RTRSN"].ToString();
                Villa = dtPersonal.Rows[i]["Villa"].ToString();
                Resident = dtPersonal.Rows[i]["Name"].ToString();
                Adress = dtPersonal.Rows[i]["Address1"].ToString();
                Cty = dtPersonal.Rows[i]["Address3"].ToString();
                Accountcode = dtPersonal.Rows[i]["Accountcode"].ToString();
                outstd = dtPersonal.Rows[i]["outstd"].ToString();
                MobileNo = dtPersonal.Rows[i]["MobileNo"].ToString();
                EmailId = dtPersonal.Rows[i]["EmailId"].ToString();
                strQuery = "Accountcode = '" + Accountcode + "'";
                Odate = DateTime.Now;
                printedOn = Odate.ToString("dd-MMM-yyyy hh:mm tt");
                date = Odate.ToString("dd-MMM-yyyy");
                whr = strQuery;
                DataRow[] drfilService = dt.Select(whr);
                if (drfilService.Any())
                {
                    var query = drfilService.Select(x => x.Field<String>("InvoiceNo")).Distinct();
                    DataRow[] drInvoiceNo;
                    InvCount = query.ToArray().Length;
                    foreach (var value in query)
                    {
                        count += 1;
                        drInvoiceNo = dt.Select("InvoiceNo = '" + value + "'");

                        //dtservice = drfilService.CopyToDataTable();
                        dtservice = drInvoiceNo.CopyToDataTable();
                        using (StringWriter sw = new StringWriter())
                        {
                            using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                            {
                                invNo = dtservice.Rows[0]["InvoiceNo"].ToString();
                                string NARATION = "MEB";

                                StringBuilder sb1 = new StringBuilder();
                                int Jai = 0;
                                String logo = Server.MapPath(".") + "/Images/CSCS_logo200.jpg";
                                sb1.Append("<font face=\"verdana\" size=\"1\">");
                                sb1.Append("<table align=center width=100% ><tr><td width=20%><img src=" + logo + " runat=server width=75%/></td><td width=80% align=left><b>" + commnty + "</b><br />Reg. Office 13/4 Covaicare Tower, V.G.Rao Nagar, Ganapathy, Coimbatore - 641006 <br />");
                                sb1.Append("GSTIN/UIN : " + gstin + ", State Name : Tamil Nadu, Code : 33 <br /></td></tr></table>");
                                sb1.Append("<table align=center width=100% ><tr><td align=center><b>INVOICE</b></td></tr></table>");

                                sb1.Append("<table align=center border=0.2 bordercolor=gray>");
                                sb1.Append("<tr><td width=50%><b>To,</b><br /> " + Villa + " - " + Resident + "<br />" + Adress + "<br />" + Cty + "<br /> Mobile No.: " + MobileNo + "<br /> Email ID: " + EmailId + "<br /><br /> </td>");
                                sb1.Append("<td width=25% valign=top>Invoice No.<br /><b>" + invNo + "</b></td><td width=25% valign=top>Dated<br /><b> " + printedOn.Remove(11) + " </b></td></tr></table>");

                                sb1.Append("<table align=center border=0.2 bordercolor=gray>");

                                sb1.Append("<tr><th align=center width=5%><b>Sl No.</b></th> <th align=center width=45%><b>Description of Goods and Services</b></th> <th align=center width=15%><b>HSN/SAC</b></th> <th align=center width=10%><b>Rate %</b></th>" +
                                    "<th align=center width=25%><b>Amount</b></th> </tr>");

                                foreach (DataRow row in dtservice.Rows)
                                {
                                    Jai = Jai + 1;

                                    sb1.Append("<tr><td align=center width=5%>" + Jai + "</td><td align=right width=45%>" + row["Particulars"].ToString() + "</td><td align=center width=15%>" + row["HSN/SAC"].ToString() + "</td>" +
                                        "<td align=center width=10%>" + row["Rate"].ToString() + "</td>" +
                                            "<td align=right width=25%>" + row["TaxableVlu"].ToString() + "</td></tr>");
                                }
                                object sumObject;
                                sumObject = dtservice.Compute("Sum(TaxableVlu)", string.Empty);
                                sb1.Append("<tr><td align=center width=5%></td><td align=right width=45%><b>Total</b></td><td align=left width=15%></td><td align=left width=10%></td><td align=right width=25%><b>" + sumObject.ToString() + "</b></td></tr>");
                                sb1.Append("<tr><td colspan=4>Amount Chargeable (in words)<br /><b> Rupees " + ConvertToWords(sumObject.ToString()) + "</b></td><td align=right><i> E. & O.E </i></td></tr>");
                                sb1.Append("<tr  bgcolor=\"#EEE8AA\" color=\"#8B4513\"> <td></td><td></td><td></td><td></td><td></td></tr></table>");

                                DataRow[] drfilGST = dtGST.Select("InvoiceNo = '" + value + "'");
                                if (drfilGST.Any())
                                {
                                    dtGSTF = drfilGST.CopyToDataTable();
                                }

                                sb1.Append("<table align=center border=0.2 bordercolor=gray>");
                                sb1.Append("<tr><th align=center width=20%>HSN/SAC</th> <th align=center width=15%>Taxable Value</th> <th align=center width=10%>CGST%</th> <th align=center width=15%>CGST Amount</th>");
                                sb1.Append("<th align=center width=10%>SGST%</th> <th align=center width=15%>SGST Amount</th> <th align=center width=15%>Total Tax Amount</th></tr>");
                                foreach (DataRow dr in dtGSTF.Rows)
                                {
                                    sb1.Append("<tr><td align=center width=20%>" + dr["HSN/SAC"].ToString() + "</td><td align=right width=15%><b>" + dr["TaxableVlu"].ToString() + "</b></td><td align=right width=10%>" + dr["CGST"].ToString() + "</td><td align=right width=15%>" + dr["CGSTAmt"].ToString() + "</td></tr>");
                                    sb1.Append("<tr><td align=right width=10%>" + dr["CGST"].ToString() + "</td><td align=right width=15%>" + dr["SGSTAmt"].ToString() + "</td><td align=right width=15%><b>" + dr["TotalAmount"].ToString() + "</b></td></tr>");
                                }
                                object sumObjectG, sumObjectS, sumObjectT;
                                sumObject = dtGSTF.Compute("Sum(TaxableVlu)", string.Empty);
                                sumObjectG = dtGSTF.Compute("Sum(CGSTAmt)", string.Empty);
                                sumObjectS = dtGSTF.Compute("Sum(SGSTAmt)", string.Empty);
                                sumObjectT = dtGSTF.Compute("Sum(TotalAmount)", string.Empty);
                                sb1.Append("<tr> <td align=right><b>Total</b></td><td align=right><b>" + sumObject.ToString() + "</b></td><td></td><td align=right><b>" + sumObjectG.ToString() + "</b></td><td></td><td align=right><b>" + sumObjectS.ToString() + "</b></td><td align=right><b>" + sumObjectT.ToString() + "</b></td></tr>");
                                sb1.Append("<tr> <td colspan=7>Tax Amount (in words) : <b>Rupees " + ConvertToWords(sumObjectT.ToString()) + "</b></td></tr>");
                                sb1.Append("<tr  bgcolor=\"#EEE8AA\" color=\"#8B4513\"> <td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr></table>");

                                sb1.Append("<table><tr><td valign=top style=font-size:8px;><i>Remarks: </i><br />");
                                sb1.Append("Being Maintenance charges for the period of " + BFROM + " to " + BTILL + " - Invoice No. " + invNo + " <br /><br /> Company's PAN : <b> " + Pan + "</b> <br /><br />");
                                sb1.Append("<u> Declaration:</u><br />We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct.</td>");
                                sb1.Append("<td><table><tr><td valign=top><i>Company's Bank Details </i></td><td></td></tr>");
                                sb1.Append("<tr><td>Bank Name :</td><td>Indian Overseas Bank</td></tr><tr><td>A/C No. :</td><td>193702000000317</td></tr><tr><td>Branch & IFSC Code :</td><td>Madampatti Branch & IOBA0001937</td></tr>");
                                sb1.Append("<tr><td colspan=2 align=right><i>for</i> <b>" + commnty + "</b></td></tr><tr><td colspan=2>&nbsp; <br /></td></tr><tr><td colspan=2>&nbsp;<br /></td></tr>");
                                sb1.Append("<tr><td colspan=2 align=right>Authorised Signatory </td></tr></table></td></tr><tr><td colspan=2>&nbsp;</td><tr><td colspan=2>&nbsp;</td></table>");

                                sb1.Append("<table align=center width=100% ><tr><td align=center style=font-size:8px>This is a Computer Generated Invoice</td></tr></table>");
                                sb1.Append("<\font>");

                                StringReader sr1 = new StringReader(sb1.ToString());
                                byte[] bytes1 = null;
                                FileName1 = Bmonth + "_" + "_" + Villa + "_" + Resident + "_" + NARATION + "_" + count.ToString() + ".pdf";
                                strFooter = FileName1;

                                Document pdfDoc1 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                                HTMLWorker htmlparser1 = new HTMLWorker(pdfDoc1);

                                using (MemoryStream memoryStream1 = new MemoryStream())
                                {

                                    PdfWriter writer1 = PdfWriter.GetInstance(pdfDoc1, memoryStream1);
                                    pdfDoc1.Open();

                                    writer1.PageEvent = new Footer();
                                    htmlparser1.Parse(sr1);

                                    pdfDoc1.Close();
                                    bytes1 = memoryStream1.ToArray();
                                    memoryStream1.Close();
                                    myMail.Attachments.Add(new Attachment(new MemoryStream(bytes1), FileName1));

                                    //string saveTo = "D:\\ORIS\\Invoices";
                                    //FileStream writeStream = new FileStream(saveTo, FileMode.Create, FileAccess.Write);
                                    //ReadWriteStream(new MemoryStream(bytes1), writeStream);
                                }
                            }
                        }
                        UpdateTxn(RTRSN, Email, FileName1, Convert.ToString(Total));
                    }
                }

            }
            myMail.IsBodyHtml = true;
            StringBuilder sbBody = new StringBuilder();
            sbBody.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;font-size:14px;'>");
            sbBody.Append("<tr><td><b> Greetings,</b></td></tr>");
            sbBody.Append("<tr><td>Month End Billing Invoice(s) for the month of  <b>" + Bmonth + "</b>.");
            //sbBody.Append("<tr><td>Month End Billing Invoice(s) for the month of  <b>Dec18</b>.");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td>The Invoice(s) are attached.</b>");
            sbBody.Append("</td></tr>");

            sbBody.Append("<tr><td>With Best Regards,");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td><b>" + commnty + "</b></td></tr>");
            sbBody.Append("<tr><td>");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td> ");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td></td></tr>");
            sbBody.Append("<tr><td>The Invoice(s) in PDF Format and can be opened by Adobe ® Acrobat reader by clicking on the attachment.");
            sbBody.Append("</td></tr>");
            sbBody.Append("<tr><td></td></tr>");
            sbBody.Append("<tr style='font-family:Verdana;font-size:13px;'><td><b>This is an automatically generated mail from <a href='http://www.covaiseniorliving.com/' title='Click here to open ORIS'>CovaiSmart</a>, the software for Retirement Communities.</b></td></tr>");
            sbBody.Append("</table>");
            myMail.Subject = "Month End Billing Invoice(s) for the month of " + Bmonth;
            //myMail.Subject = "Month End Billing Invoice(s) for the month of Dec18";
            myMail.Body = sbBody.ToString();
            mySmtpClient.Send(myMail);
            dt.Dispose();
            dtPersonal.Dispose();
            //HttpContext.Current.ApplicationInstance.CompleteRequest();
            //AdminMail();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    private void ReadWriteStream(Stream readStream, Stream writeStream)
    {
        int Length = 256;
        Byte[] buffer = new Byte[Length];
        int bytesRead = readStream.Read(buffer, 0, Length);
        // write the required bytes
        while (bytesRead > 0)
        {
            writeStream.Write(buffer, 0, bytesRead);
            bytesRead = readStream.Read(buffer, 0, Length);
        }
        readStream.Close();
        writeStream.Close();
    }
    protected void UpdateTxn(string rtrsn, string mailID, string file, string Amt)
    {
        try
        {
            DataSet dsUpdate = sqlobj.ExecuteSP("CC_UPDATEINVAUDITLOG",
                   new SqlParameter() { ParameterName = "@invNo", SqlDbType = SqlDbType.NVarChar, Value = invNo },
                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = rtrsn },
                   new SqlParameter() { ParameterName = "@TXCODE", SqlDbType = SqlDbType.NVarChar, Value = "NO" },
                   new SqlParameter() { ParameterName = "@Amount", SqlDbType = SqlDbType.Decimal, Value = Amt },
                   new SqlParameter() { ParameterName = "@MailId", SqlDbType = SqlDbType.NVarChar, Value = mailID },
                   new SqlParameter() { ParameterName = "@File", SqlDbType = SqlDbType.NVarChar, Value = file },
                   new SqlParameter() { ParameterName = "@C_BY", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                );
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message + "');", true);
        }
    }
    private static string ConvertToWords(string numb)
    {
        string val = "", wholeNo = numb, points = "", andStr = "", pointStr = "";
        string endStr = "Only";
        try
        {
            int decimalPlace = numb.IndexOf(".");
            if (decimalPlace > 0)
            {
                wholeNo = numb.Substring(0, decimalPlace);
                points = numb.Substring(decimalPlace + 1);
                if (Convert.ToInt32(points) > 0)
                {
                    andStr = "and";// just to separate whole numbers from points/cents  
                    endStr = "Paisa " + endStr;//Cents  
                    pointStr = ConvertDecimals(points);
                }
            }
            val = string.Format("{0} {1}{2} {3}", ConvertWholeNumber(wholeNo).Trim(), andStr, pointStr, endStr);
        }
        catch { }
        return val;
    }
    private static string ConvertDecimals(string number)
    {
        string cd = "", digit = "", engOne = "", num = "";
        if (number.Equals("0"))
        {
            //engOne = "Zero";
        }
        else
        {
            if (number.Length > 1)
            {
                if (Convert.ToInt32(number) > 9 && Convert.ToInt32(number) < 20)
                {
                    engOne = tens(number);
                    cd += " " + engOne;
                }
                else
                {
                    for (int J = 0; J < number.Length; J++)
                    {
                        digit = number[J].ToString();
                        if (J == 0)
                        {
                            engOne = tens(digit);
                        }
                        else
                        {
                            engOne = ones(digit);
                        }
                        num += " " + engOne;
                    }
                    cd += " " + num;
                    //engOne = ones(digit);
                }
            }
            //cd += " " + engOne;
        }

        return cd;
    }
    private static string ones(string Number)
    {
        int _Number = Convert.ToInt32(Number);
        string name = "";
        switch (_Number)
        {

            case 1:
                name = "One";
                break;
            case 2:
                name = "Two";
                break;
            case 3:
                name = "Three";
                break;
            case 4:
                name = "Four";
                break;
            case 5:
                name = "Five";
                break;
            case 6:
                name = "Six";
                break;
            case 7:
                name = "Seven";
                break;
            case 8:
                name = "Eight";
                break;
            case 9:
                name = "Nine";
                break;
        }
        return name;
    }
    private static string tens(string Number)
    {
        int _Number = Convert.ToInt32(Number);
        string name = null;
        switch (_Number)
        {
            case 0:
                name = "";
                break;
            case 2:
                name = "Twenty";
                break;
            case 3:
                name = "Thirty";
                break;
            case 4:
                name = "Fourty";
                break;
            case 5:
                name = "Fifty";
                break;
            case 6:
                name = "Sixty";
                break;
            case 7:
                name = "Seventy";
                break;
            case 8:
                name = "Eighty";
                break;
            case 9:
                name = "Ninety";
                break;
            case 10:
                name = "Ten";
                break;
            case 11:
                name = "Eleven";
                break;
            case 12:
                name = "Twelve";
                break;
            case 13:
                name = "Thirteen";
                break;
            case 14:
                name = "Fourteen";
                break;
            case 15:
                name = "Fifteen";
                break;
            case 16:
                name = "Sixteen";
                break;
            case 17:
                name = "Seventeen";
                break;
            case 18:
                name = "Eighteen";
                break;
            case 19:
                name = "Nineteen";
                break;
            case 20:
                name = "Twenty";
                break;
            case 30:
                name = "Thirty";
                break;
            case 40:
                name = "Fourty";
                break;
            case 50:
                name = "Fifty";
                break;
            case 60:
                name = "Sixty";
                break;
            case 70:
                name = "Seventy";
                break;
            case 80:
                name = "Eighty";
                break;
            case 90:
                name = "Ninety";
                break;
            default:
                if (_Number > 0)
                {
                    name = tens(Number.Substring(0, 1) + "0") + " " + ones(Number.Substring(1));
                }
                break;
        }
        return name;
    }
    private static string ConvertWholeNumber(string Number)
    {
        string word = "";
        try
        {
            bool beginsZero = false;//tests for 0XX  
            bool isDone = false;//test if already translated  
            double dblAmt = (Convert.ToDouble(Number));
            //if ((dblAmt > 0) && number.StartsWith("0"))  
            if (dblAmt > 0)
            {//test for zero or digit zero in a nuemric  
                beginsZero = Number.StartsWith("0");

                int numDigits = Number.Length;
                int pos = 0;//store digit grouping  
                string place = "";//digit grouping name:hundres,thousand,etc...  
                switch (numDigits)
                {
                    case 1://ones' range  

                        word = ones(Number);
                        isDone = true;
                        break;
                    case 2://tens' range  
                        word = tens(Number);
                        isDone = true;
                        break;
                    case 3://hundreds' range  
                        pos = (numDigits % 3) + 1;
                        place = " Hundred ";
                        break;
                    case 4://thousands' range  
                    case 5:
                    case 6:
                        pos = (numDigits % 4) + 1;
                        place = " Thousand ";
                        break;
                    case 7://millions' range  
                    case 8:
                    case 9:
                        pos = (numDigits % 7) + 1;
                        place = " Million ";
                        break;
                    case 10://Billions's range  
                    case 11:
                    case 12:

                        pos = (numDigits % 10) + 1;
                        place = " Billion ";
                        break;
                    //add extra case options for anything above Billion...  
                    default:
                        isDone = true;
                        break;
                }
                if (!isDone)
                {//if transalation is not done, continue...(Recursion comes in now!!)  
                    if (Number.Substring(0, pos) != "0" && Number.Substring(pos) != "0")
                    {
                        try
                        {
                            word = ConvertWholeNumber(Number.Substring(0, pos)) + place + ConvertWholeNumber(Number.Substring(pos));
                        }
                        catch { }
                    }
                    else
                    {
                        word = ConvertWholeNumber(Number.Substring(0, pos)) + ConvertWholeNumber(Number.Substring(pos));
                    }

                    //check for trailing zeros  
                    //if (beginsZero) word = " and " + word.Trim();  
                }
                //ignore digit grouping names  
                if (word.Trim().Equals(place.Trim())) word = "";
            }
        }
        catch { }
        return word.Trim();
    }
    //protected void rdobtnTrial_CheckedChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (rdobtnTrial.Checked == true)
    //        {
    //            btnSearch.Visible = true;

    //            if (rdobtnLive.Visible == true)
    //            {
    //                rdobtnLive.Checked = false;
    //            }
    //        }
    //        else
    //        {
    //            if (rdobtnLive.Visible == true)
    //            {
    //                rdobtnLive.Checked = true;
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);
    //    }
    //}
    //protected void rdobtnLive_CheckedChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (rdobtnLive.Checked == true)
    //        {
    //            btnSearch.Visible = true;
    //            rdobtnTrial.Checked = false;
    //        }
    //        else
    //        {
    //            rdobtnTrial.Checked = true;
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);
    //    }
    //}
    protected void rgMonthEndBillDashboard_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadMonthEndDashBoard();
    }

    protected void rgMonthEndBillDashboard_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgMonthEndBillDashboard.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains"
            || menu.Items[i].Text == "GreaterThanOrEqualTo" || menu.Items[i].Text == "LessThanOrEqualTo")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
    protected void rgMonthEndBillDashboard_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            //if (e.Item is GridDataItem)
            //{
            //    GridDataItem dataItem = e.Item as GridDataItem;
            //    decimal imc = Convert.ToDecimal(dataItem["MaintenanceCharge"].Text);
            //    //decimal imtax = Convert.ToDecimal(dataItem["MTax"].Text);
            //    decimal ikoc = Convert.ToDecimal(dataItem["KitchenOverheadCharges"].Text);
            //    decimal imeals = Convert.ToDecimal(dataItem["Meals"].Text);
            //    decimal itcm = Convert.ToDecimal(dataItem["TCM"].Text);
            //    //decimal iub = Convert.ToDecimal(dataItem["UnBilled"].Text);
            //    //decimal icr = Convert.ToDecimal(dataItem["Credits"].Text);
            //    //decimal icb = Convert.ToDecimal(dataItem["ClBal"].Text);
            //    if (imc <= 0 || ikoc <= 0 || imeals <= 0 || itcm <= 0)
            //    {
            //        dataItem["Name"].ForeColor = System.Drawing.Color.Red;
            //    }
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Dashboard.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnPreviewInvoice_Click(object sender, EventArgs e)
    {

    }
    protected void btnStatus_Click(object sender, EventArgs e)
    {
        try
        {
            //  -- Update Billing period status assigned to next month billing transactions
            DataSet ds = sqlobj.ExecuteSP("SP_UpdateBillingPeriodStatus",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });
            string Bmnth = ds.Tables[0].Rows[0]["BPNAME"].ToString();

            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert(' Billing month is now " + Bmnth + ".\n You can start posting transactions for this month');", true);
            //btnSearch.Visible = false;
            //btnProcess.Visible = false;
            //btnStatus.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnProcess_Click(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ds = sqlobj.ExecuteSP("SP_TotalAccountBilled",
            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });
            ViewState["InvoiceStart"] = Convert.ToDecimal(ds.Tables[0].Rows[0]["Invoicecode"].ToString());

            foreach (GridDataItem item in rgMonthEndBillDashboard.Items)
            {

                DateTime bdate = DateTime.Now;
                string strday = bdate.ToString("dd");
                string strmonth = bdate.ToString("MM");
                string stryear = bdate.ToString("yyyy");
                string strhour = bdate.ToString("HH");
                string strmin = bdate.ToString("mm");
                string strsec = bdate.ToString("ss");
                string strBillNo = stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();
                string rtrsn = item["rtrsn"].Text;

                string accountcode = item["Accountcode"].Text;
                string mmc = item["MaintenanceCharge"].Text;
                string koc = item["KitchenOverheadCharges"].Text;
                string nc = item["NCCharges"].Text;
                string wc = item["WCCharges"].Text;
                string tl = item["TLCharges"].Text;

                DataSet dsCnt = sqlobj.ExecuteSP("SP_AutoDebitNew",
                 new SqlParameter() { ParameterName = "@MaintenanceCharge", SqlDbType = SqlDbType.Decimal, Value = mmc.ToString() },
                 new SqlParameter() { ParameterName = "@KitchenOverheadCharges", SqlDbType = SqlDbType.Decimal, Value = koc.ToString() },
                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = rtrsn.ToString() },
                 new SqlParameter() { ParameterName = "@AcccountCode", SqlDbType = SqlDbType.NVarChar, Value = accountcode.ToString() },
                 new SqlParameter() { ParameterName = "@RefNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                 new SqlParameter() { ParameterName = "@NCCharges", SqlDbType = SqlDbType.Decimal, Value = nc.ToString() },
                 new SqlParameter() { ParameterName = "@WCCharges", SqlDbType = SqlDbType.Decimal, Value = wc.ToString() },
                 new SqlParameter() { ParameterName = "@TLCharges", SqlDbType = SqlDbType.Decimal, Value = tl.ToString() }
                 );

                DataSet dsTtlAccount = sqlobj.ExecuteSP("SP_TotalAccountBilled",
                     new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 1 });
                string TtlAccount = dsTtlAccount.Tables[0].Rows[0]["Total"].ToString();

                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Total accounts affected = " + TtlAccount + ".\n Choose 'Raise Invoices' option next.');", true);

            }
            btnSearch.Visible = true;
            btnProcess.Visible = false;
            btnStatus.Visible = false;
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void AdminMail()
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_TotalAccountBilled",
              new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 });
            ViewState["InvoiceEnd"] = Convert.ToDecimal(ds.Tables[0].Rows[0]["Invoicecode"].ToString());

            DataSet dsTtlAccount = sqlobj.ExecuteSP("SP_TotalAccountBilled",
                    new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 2 });
            string BillingMonth = dsTtlAccount.Tables[0].Rows[0]["BillingMonth"].ToString();
            string NoOfInvoice = dsTtlAccount.Tables[0].Rows[0]["NoOfInvoice"].ToString();
            string AmountBilled = dsTtlAccount.Tables[0].Rows[0]["AmountBilled"].ToString();
            string NextMonth = dsTtlAccount.Tables[0].Rows[0]["NextMonth"].ToString();
            string Resident = dsTtlAccount.Tables[0].Rows[0]["Resident"].ToString();
            string Tenant = dsTtlAccount.Tables[0].Rows[0]["Tenant"].ToString();
            string Away = dsTtlAccount.Tables[0].Rows[0]["Away"].ToString();
            string NoOfResident = dsTtlAccount.Tables[0].Rows[0]["NoOfResident"].ToString();
            //DataTable dtservice = dsTtlAccount.Tables[1];


            System.Web.HttpResponse Response = System.Web.HttpContext.Current.Response;
            string mailserver = string.Empty;
            string user = string.Empty;
            string pwd = string.Empty;
            string sentby = string.Empty;
            string Email = string.Empty;

            SqlCommand cmd = new SqlCommand("Proc_GetEmailCredentials", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet dsCredential = new DataSet();
            da.Fill(dsCredential);
            // Write an informational entry to the event log.  

            if (dsCredential != null && dsCredential.Tables.Count > 0)
            {
                foreach (DataRow row in dsCredential.Tables[0].Rows)
                {
                    mailserver = row["mailserver"].ToString();
                    user = row["username"].ToString();
                    pwd = row["password"].ToString();
                    sentby = row["sentbyuser"].ToString();
                    Email = row["Email"].ToString();
                }
            }
            SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
            MailAddress From = new MailAddress(user, "info@innovatussystems.com");
            MailMessage myMail = new System.Net.Mail.MailMessage();
            myMail.From = From;
            myMail.To.Add(Email);
            mySmtpClient.UseDefaultCredentials = false;
            System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
            mySmtpClient.Credentials = basicauth;
            mySmtpClient.EnableSsl = false;
            mySmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
            //mySmtpClient.Timeout = 200000;
            myMail.SubjectEncoding = System.Text.Encoding.UTF8;
            myMail.BodyEncoding = System.Text.Encoding.UTF8;
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringBuilder sbBody = new StringBuilder();
                    sbBody.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;font-size:14px;'>");
                    sbBody.Append("<tr><td><b> Greetings,</b></td></tr>");
                    sbBody.Append("<tr><td>Month End Billing control Report for " + BillingMonth + ".</td></tr>");
                    sbBody.Append("<tr><td >1.Invoice No. Start: " + ViewState["InvoiceStart"].ToString() + ".</tr>");
                    sbBody.Append("<tr><td >2.Invoice No. End: " + ViewState["InvoiceEnd"].ToString() + ".</tr>");
                    sbBody.Append("<tr><td >3.No. Of Invoice:" + NoOfInvoice + ".</tr>");
                    sbBody.Append("<tr><td >4.Total Invoice Amount: " + AmountBilled + ".</tr>");
                    sbBody.Append("<tr><td >5.Resident-(OR): " + Resident + ".</tr>");
                    sbBody.Append("<tr><td >6.Tenant-(T): " + Tenant + ".</tr>");
                    sbBody.Append("<tr><td >7.Away-(OA): " + Away + ".</tr>");
                    sbBody.Append("<tr><td >8.Total-(OR,T,OA): " + NoOfResident + ".</tr>");
                    sbBody.Append("<tr><td>The Invoice(s) are archived as PDF files in '<b><u>covaiproprarch@gmail.com</u></b>'.</td></tr>");
                    sbBody.Append("<tr><td>Invoice File Name:- <b>DoorNo_Name_MMMYY.pdf</b>.</td></tr>");
                    sbBody.Append("<tr><td>New Billing Month:- " + NextMonth + ".</td></tr>");
                    sbBody.Append("</table>");
                    myMail.IsBodyHtml = true;
                    myMail.Subject = "Month end Billing Snapshot For " + BillingMonth + ".";
                    myMail.Body = sbBody.ToString();
                    mySmtpClient.Send(myMail);
                }
            }
            btnSearch.Visible = false;
            btnProcess.Visible = false;
            btnStatus.Visible = true;
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

    protected void btnDashboard_Click(object sender, EventArgs e)
    {
        LoadMonthEndDashBoard();
        LoadDetails();
        rgMonthEndBillDashboard.Visible = true;
        btnDashboard.Visible = false;
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Script", "Sys.Application.add_load(HideUpdateProgress);", true);
    }

    protected void btnPro_Click(object sender, EventArgs e)
    {

        //DataSet dsMonthEndDashBoard = sqlobj.ExecuteSP("CC_PROCESSTXNSFORMEB");
        btnDashboard.Visible = true;
        btnPro.Visible = false;
    }
}