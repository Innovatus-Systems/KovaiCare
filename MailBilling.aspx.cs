using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Net.Mail;
using System.Data.SqlClient;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Configuration;
using System.Text;

public partial class MailBilling : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    static string contName;
    static string commnty;
    static string payment;
    static string strFooter;
    static string Duration;

    protected void Page_Load(object sender, EventArgs e)
    {
        

        if (!IsPostBack)
        {
            LoadTitle();
            LoadBilling();
            LoadDetails();
            ViewState["Footer"] = null;
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 49 });


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


    public void LoadBilling()
    {
        try
        {
            DataSet dsBilling = new DataSet();
            dsBilling = sqlobj.ExecuteSP("Proc_LoadBilling");
            if (dsBilling.Tables[0].Rows.Count > 0)
            {
                ddlBilling.DataSource = dsBilling.Tables[0];
                ddlBilling.DataTextField = "BPName";
                ddlBilling.DataValueField = "RSN";
                ddlBilling.DataBind();
            }
        }
        catch (Exception ex)
        {
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
               lblPreviousBillingMonth.Text = dsDetails.Tables[0].Rows[0]["PreviousBillingMonth"].ToString();
               lblTotal.Text = dsDetails.Tables[2].Rows[0]["Total"].ToString();
            }

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {


            //string url = string.Format("PDF.aspx?pdf=MonthlyBill _Sri Ram _Apr16.pdf");
            //string script = "<script type='text/javascript'>window.open('" + url + "')</script>";
            //this.ClientScript.RegisterStartupScript(this.GetType(), "script", script);



            //SendSA();

            DataSet dsDetails = new DataSet();
            //SqlCommand cmd = new SqlCommand("Proc_GetData", con);
            SqlCommand cmd = new SqlCommand("Proc_GetData", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@RSN", ddlBilling.SelectedValue);
            cmd.Parameters.AddWithValue("@RSN", 25);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsDetails, "temp");
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                contName = dsDetails.Tables[2].Rows[0]["ContactPName"].ToString();
                commnty = dsDetails.Tables[2].Rows[0]["CommunityName"].ToString();
                payment = dsDetails.Tables[2].Rows[0]["PaymentInstruction"].ToString();
                Duration = dsDetails.Tables[2].Rows[0]["Duration"].ToString();
                SendMail(dsDetails.Tables[0], dsDetails.Tables[1]);
                //System.Threading.Thread.Sleep(2000);
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
            }
        }
        catch (Exception ex)
        {
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

            Paragraph header = new Paragraph(commnty, FontFactory.GetFont(FontFactory.TIMES, 14, iTextSharp.text.Font.BOLD));

            header.Alignment = Element.ALIGN_CENTER;

            PdfPTable headertbl = new PdfPTable(1);

            headertbl.TotalWidth = 500;

            headertbl.HorizontalAlignment = Element.ALIGN_CENTER;

            PdfPCell hcell = new PdfPCell(header);

            hcell.Border = 0;

            hcell.PaddingLeft = 10;

            headertbl.AddCell(hcell);

            //footerTbl.WriteSelectedRows(0, -1, 415, 30, writer.DirectContent);
            footerTbl.WriteSelectedRows(0, -1, 150, 50, writer.DirectContent);
            //footerTbl.WriteSelectedRows(0, -1, 10f, writer.PageSize.GetBottom(doc.BottomMargin), writer.DirectContent);
            headertbl.WriteSelectedRows(0, -1, 270, page.Height - cellHeight + headertbl.TotalHeight, writer.DirectContent);
        }
    }
    protected void rmReports_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        if (e.Item.Text == "Financial Transactions")
        {
            Response.Redirect("DailyFoodBillReport.aspx");
        }
        else if (e.Item.Text == "Monthly Statement")
        {
            Response.Redirect("MailBilling.aspx");
        }
        else if (e.Item.Text == "Billing Summary View")
        {
            Response.Redirect("MonthlyBilling.aspx?MBVal=" + 2);
        }
        else if (e.Item.Text == "Billing History Per Resident")
        {
            Response.Redirect("ResidentTxnSummary.aspx?RSVal=" + 2);
        }
        else if (e.Item.Text == "Diners Summary")
        {
            Response.Redirect("DinerssummRep.aspx");
        }
        else if (e.Item.Text == "Which Menu which day")
        {
            Response.Redirect("MenuItemReport.aspx");
        }
        else if (e.Item.Text == "Ingredients Report")
        {
            Response.Redirect("IngredientsRep.aspx");
        }
        else if (e.Item.Text == "Menu for the day")
        {
            Response.Redirect("MenuItemPerday.aspx");
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



            if (dsUsageBilling.Tables[0].Rows.Count>0)
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

                            SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                            MailAddress From = new MailAddress(user, "info@innovatussystems.com");
                            MailMessage myMail = new System.Net.Mail.MailMessage();
                            myMail.From = From;
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
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    public void SendMail(DataTable dt, DataTable dtPersonal)
    {
        DataTable dtNew = new DataTable();
        try
        {
            for (int i = 0; i <= dt.Rows.Count; i++)
            {
                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        string Villa = dtPersonal.Rows[i]["Villa"].ToString();
                        string Resident = dtPersonal.Rows[i]["Name"].ToString();
                        string status = dtPersonal.Rows[i]["Status"].ToString();
                        string Email = dtPersonal.Rows[i]["Email"].ToString();
                        string Mobile = dtPersonal.Rows[i]["Mobile"].ToString();
                        string Occupants = dtPersonal.Rows[i]["Occupants"].ToString();
                        Int64 RSN = Convert.ToInt64(dtPersonal.Rows[i]["RTRSN"].ToString());


                        string Outstand = dtPersonal.Rows[i]["OutStanding"].ToString();
                        DateTime Odate = DateTime.Now;
                        string date = Odate.ToString("dd-MMM-yyyy hh:mm tt");
                        //return;
                        dtNew = null;
                        string strQuery = "RTRSN = '" + RSN + "'";
                        DataRow[] drFilterRows = dt.Select(strQuery);
                        dtNew = drFilterRows.CopyToDataTable();

                        dtNew.DefaultView.Sort = "Date ASC";

                        double debit = Convert.ToDouble(dtNew.Compute("sum(Debit)", ""));
                        double credit = Convert.ToDouble(dtNew.Compute("sum(Credit)", ""));
                        double total = debit - credit;

                        double Lastmonth = Convert.ToDouble(dtPersonal.Rows[i]["LastMonth"].ToString());
                        double AmtPay = total + Lastmonth;

                        double dBillDoneinthemonth = Convert.ToDouble(dtPersonal.Rows[i]["BilledAmnt"].ToString());
                        double dReceivedAmnt = Convert.ToDouble(dtPersonal.Rows[i]["ReceivedAmt"].ToString());

                        string strTotal = total.ToString("F");
                        string strLastMonth = Lastmonth.ToString("F");
                        string strAmtPay = AmtPay.ToString("F");

                        string  sBillDoneinthemonth = dBillDoneinthemonth.ToString("F");
                        string sReceivedAmnt = dReceivedAmnt.ToString("F");

                        StringBuilder sb = new StringBuilder();
                        sb.Append("<table width='100%' cellspacing='3' cellpadding='3' style='font-family:Verdana;margin-left:15px;'>");
                        //sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'><b> " + commnty + " </b> </td></tr>");
                        sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'></td></tr>");
                        sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'></td></tr>");
                        sb.Append("<br />");
                        sb.Append("</table>");
                        sb.Append("<table width='100%' cellspacing='3' cellpadding='3' style='font-family:Verdana;margin-top:15px;'>");
                        sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'></td></tr>");
                        sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:13px;'><b> Monthly Statement for " + ddlBilling.SelectedItem.ToString() + " </b> </td></tr>");
                        //sb.Append("<tr><td></td></tr>");
                        //sb.Append("<tr><td></td></tr>");
                        sb.Append("<tr style='font-size:8px;' colspan='4'><td align='right'>Print : ");
                        sb.Append(date);
                        sb.Append("</td></tr>");

                        sb.Append("<tr style='font-size:10px;width:100%;'><td style='width:15%;'><b>Door No : </b>");
                        sb.Append(Villa);
                        sb.Append("</td><td style='width:45%;'><b>Name : </b>");
                        sb.Append(Resident);
                        sb.Append("</td><td style='width:20%;'><b>No of Persons : </b>");
                        sb.Append(Occupants);
                        sb.Append("</td><td style='width:20%;'><b> Status : </b>");
                        sb.Append(status);
                        sb.Append("</td></tr>");


                        //sb.Append("<tr style='font-size:10px;'><td><b>Resident : </b> ");
                        //sb.Append(Resident);
                        //sb.Append("</td></tr>");

                        sb.Append("<tr style='font-size:10px;'><td colspan='2'><b>Mobile No : </b>");
                        sb.Append(Mobile);
                        sb.Append("</td><td colspan='2'><b>Email : </b>");
                        sb.Append(Email);
                        sb.Append("</td></tr>");

                        sb.Append("<tr style='font-size:10px;'><td align='left' colspan='1'>C/F from previous month  :");
                        sb.Append("</td><td align='left' colspan='3'>");
                        sb.Append(strLastMonth);
                        sb.Append("</td></tr>");

                        sb.Append("<tr style='font-size:10px;'><td align='left' colspan='1'>Billing done in the month  :");
                        sb.Append("</td><td align='left' colspan='3'>");
                        sb.Append(sBillDoneinthemonth);
                        sb.Append("</td></tr>");

                        sb.Append("<tr style='font-size:10px;'><td align='left' colspan='1'>Amount received in the month :");
                        sb.Append("</td><td align='left' colspan='3'>");
                        sb.Append(sReceivedAmnt);
                        sb.Append("</td></tr>");



                        sb.Append("<tr style='font-size:10px;'><td align='left' colspan='1'>Outstandings as of end of the month :");
                        sb.Append("</td><td align='left' colspan='3'>");
                        sb.Append(strAmtPay);
                        sb.Append("</td></tr>");

                        sb.Append("<tr style='font-size:9px;'><td  colspan='2' align='left'>");
                        sb.Append(payment);
                        sb.Append("</td><td  colspan='2' align='right'>");
                        sb.Append("(All amount in Rs.)");
                        sb.Append("</td></tr>");

                        //sb.Append("<tr style='font-size:10px;'><td><b>Payment instruction : </b> ");
                        //sb.Append(payment);
                        //sb.Append("</td></tr>");

                        //sb.Append("<tr style='font-size:10px;'><td><b>Billing Period : </b> ");
                        //sb.Append(ddlBilling.SelectedItem.ToString());
                        //sb.Append("</td></tr>");

                        sb.Append("</table>");
                        sb.Append("<br />");
                        sb.Append("<table border = '1' width='100%' style='margin-left:15px;'>");
                        sb.Append("<tr>");

                        foreach (DataColumn column in dtNew.Columns)
                        {
                            if (column.ColumnName != "RTRSN")
                            {
                                //sb.Append("<th style = 'background-color: #D20B0C;color:#ffffff'>");
                                if (column.ColumnName == "Date")
                                {
                                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='center'>");
                                }
                                else if (column.ColumnName == "TxnType")
                                {
                                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='center'>");
                                }
                                //else if (column.ColumnName == "Rate")
                                //{
                                //    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='right'>");
                                //}
                                //else if (column.ColumnName == "Count")
                                //{
                                //    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='center'>");
                                //}
                                else if (column.ColumnName == "Debit")
                                {
                                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='right'>");
                                }
                                else if (column.ColumnName == "Credit")
                                {
                                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='right'>");
                                }
                                else
                                {
                                    sb.Append("<th style = 'background-color: #D20B0C;font-size:11px;font-family:Verdana;' align='left'>");
                                }

                                sb.Append(column.ColumnName);
                                sb.Append("</th>");
                            }
                        }
                        sb.Append("</tr>");
                        foreach (DataRow row in dtNew.Rows)
                        {
                            sb.Append("<tr>");
                            foreach (DataColumn column in dtNew.Columns)
                            {
                                if (column.ToString() != "RTRSN")
                                {
                                    if (column.ToString() == "Date")
                                    {
                                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='center'>");
                                    }
                                    else if (column.ToString() == "TxnType")
                                    {
                                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='center'>");
                                    }
                                    //else if (column.ToString() == "Rate")
                                    //{
                                    //    sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='right'>");
                                    //}
                                    //else if (column.ToString() == "Count")
                                    //{
                                    //    sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='center'>");
                                    //}
                                    else if (column.ToString() == "Debit")
                                    {
                                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='right'>");
                                    }
                                    else if (column.ToString() == "Credit")
                                    {
                                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='right'>");
                                    }
                                    else
                                    {
                                        sb.Append("<td style = 'font-size:10px;font-family:Verdana;' align='left'>");
                                    }
                                    sb.Append(row[column]);
                                    sb.Append("</td>");
                                }
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
                        //sb.Append("<br />");
                        //sb.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;margin-left:15px;'>");
                        //sb.Append("<tr style='font-size:10px;'><td><b>Community Name : </b>");
                        //sb.Append(commnty);
                        //sb.Append("</td></tr>");

                        //sb.Append("<tr style='font-size:10px;'><td><b>Incharge : </b> ");
                        //sb.Append(contName);
                        //sb.Append("</td></tr>");

                        //sb.Append("<tr style='font-size:10px;'><td><b>Instruction : </b> ");
                        //sb.Append(payment);
                        //sb.Append("</td></tr>");


                        //sb.Append("</table>");

                        StringBuilder sbFooter = new StringBuilder();
                        sbFooter.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;margin-left:15px;'>");
                        sbFooter.Append("<tr style='font-size:10px;'><td><b>Community Name : </b>");
                        sbFooter.Append(commnty);
                        sbFooter.Append("</td></tr>");

                        sbFooter.Append("<tr style='font-size:10px;'><td><b>Incharge : </b> ");
                        sbFooter.Append(contName);
                        sbFooter.Append("</td></tr>");

                        sbFooter.Append("<tr style='font-size:10px;'><td><b>Instruction : </b> ");
                        sbFooter.Append(payment);
                        sbFooter.Append("</td></tr>");


                        sbFooter.Append("</table>");
                        //return;

                        StringBuilder sbBody = new StringBuilder();
                        sbBody.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;font-size:14px;'>");
                        //sbBody.Append("<tr style='font-family:Verdana;font-size:14px;'><td><b> Dear " + Resident + " ,</b></td></tr>");
                        sbBody.Append("<tr><td><b> Dear Sir/Madam ,</b></td></tr>");
                        sbBody.Append("<tr><td>Please find attached the monthly statement for  " + ddlBilling.SelectedItem.Text.ToString() + ".");
                        sbBody.Append("</td></tr>");
                        sbBody.Append("<tr><td>The amount payable is <b> Rs." + strAmtPay + "</b>, within <b>" + Duration + "</b> from the date of the statement. ");
                        sbBody.Append("</td></tr>");
                        sbBody.Append("<tr><td></td></tr>");
                        sbBody.Append("<tr><td></td></tr>");
                        sbBody.Append("<tr><td>The statement is in PDF Format and can be opened by Adobe ® Acrobat reader by clicking on the attachment.");
                        sbBody.Append("</td></tr>");
                        sbBody.Append("<tr><td></td></tr>");
                        sbBody.Append("<tr><td></td></tr>");
                        sbBody.Append("<tr><td>Sincerely yours,");
                        sbBody.Append("</td></tr>");
                        sbBody.Append("<tr><td></td></tr>");
                        sbBody.Append("<tr><td> " + contName);
                        sbBody.Append("</td></tr>");
                        sbBody.Append("<tr><td> " + commnty);
                        sbBody.Append("</td></tr>");
                        //sbBody.Append("<br/>");
                        sbBody.Append("<tr><td></td></tr>");
                        sbBody.Append("<tr><td></td></tr>");
                        sbBody.Append("<tr style='font-family:Verdana;font-size:13px;'><td><b>This is an automatically generated mail from <a href='http://bincrm.com/oris/' title='Click here to open ORIS'>ORIS</a>, the software for Retirement Communities.</b></td></tr>");
                        sbBody.Append("</table>");

                        //strFooter = "                   " + Villa + "  ||  " + Resident + "  ||  " + ddlBilling.SelectedItem.ToString() + "\n" + commnty + " || " + "  Incharge : " + contName + " || " + " Instruction : " + payment;
                        strFooter = commnty + "  ||  " + Villa + "  ||  " + Resident + "  ||  " + ddlBilling.SelectedItem.ToString();

                        StringReader sr = new StringReader(sb.ToString());
                        StringReader srfooter = new StringReader(sbFooter.ToString());

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

                            SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                            MailAddress From = new MailAddress(user, "info@innovatussystems.com");
                            MailMessage myMail = new System.Net.Mail.MailMessage();
                            myMail.From = From;
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

                            string FileName = "MonthlyBill _" + Resident + " _" + ddlBilling.SelectedItem.ToString() + ".pdf";

                            mySmtpClient.UseDefaultCredentials = false;
                            System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
                            mySmtpClient.Credentials = basicauth;
                            mySmtpClient.EnableSsl = true;
                            myMail.SubjectEncoding = System.Text.Encoding.UTF8;
                            myMail.BodyEncoding = System.Text.Encoding.UTF8;
                            myMail.Attachments.Add(new Attachment(new MemoryStream(bytes), FileName));
                            myMail.IsBodyHtml = true;
                            myMail.Subject = Resident + " - " + Villa + " - Statement for " + ddlBilling.SelectedItem.ToString() + " - " + commnty;
                            myMail.Body = sbBody.ToString();
                            mySmtpClient.Send(myMail);

                            return;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
}