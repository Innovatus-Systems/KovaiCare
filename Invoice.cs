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
using System.Web.UI;
using Telerik.Web.UI;

public class Invoice
{
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
    public void DiningInvoice()
    {
        int count = 0;
        DataTable dtNew = new DataTable();
        DataTable dtPersonal = new DataTable();
        DataTable dt = new DataTable();
        try
        {
            for (int i = 0; i < dtPersonal.Rows.Count; i++)
            {

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
                        string Villa = dtPersonal.Rows[i]["Villa"].ToString();
                        string Resident = dtPersonal.Rows[i]["Name"].ToString();
                        string Adress = dtPersonal.Rows[i]["Address1"].ToString();
                        string Cty = dtPersonal.Rows[i]["Address3"].ToString();
                        string Accountcode = dtPersonal.Rows[i]["Accountcode"].ToString();

                        string strQuery = "Accountcode = '" + Accountcode + "'";

                        DateTime Odate = DateTime.Now;
                        string printedOn = Odate.ToString("dd-MMM-yyyy hh:mm tt");
                        string date = Odate.ToString("dd-MMM-yyyy");

                        //DINING INVOICE 
                        DataSet dsINVOICE = new DataSet();
                        SqlCommand cmd2 = new SqlCommand("Proc_GetINVOICEDETAILS", con);
                        cmd2.CommandType = CommandType.StoredProcedure;
                        cmd2.Parameters.AddWithValue("@TXNCODE", "DI");
                        SqlDataAdapter daI = new SqlDataAdapter(cmd2);
                        daI.Fill(dsINVOICE, "temp");
                        string INVOICENO = dsINVOICE.Tables[0].Rows[0]["PREFIX"].ToString() + "/" + dsINVOICE.Tables[0].Rows[0]["YEAR"].ToString() + "/" + dsINVOICE.Tables[0].Rows[0]["CODE"].ToString();
                        string NARATION = dsINVOICE.Tables[0].Rows[0]["STDTEXT"].ToString();

                        DataTable dtservice = null;
                        string where = "txncode in ('DI','AC') ";
                        string whr = strQuery + " and " + where;
                        DataSet dsDetails = new DataSet();
                        SqlCommand cmd1 = new SqlCommand("Proc_GetGST", con);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.Parameters.AddWithValue("@where", whr);
                        SqlDataAdapter dap = new SqlDataAdapter(cmd1);
                        dap.Fill(dsDetails, "temp");
                        decimal Calc = Convert.ToDecimal(dsDetails.Tables[0].Rows[0]["GST"].ToString()) + Convert.ToDecimal(dsDetails.Tables[0].Rows[1]["GST"].ToString());
                        decimal sp = Calc / 2;



                        DataRow[] drfilService = dt.Select(where);

                        if (drfilService.Any())
                        {
                            dtservice = drfilService.CopyToDataTable();
                            // dtservice.DefaultView.Sort = "Date ASC";                            
                            StringBuilder sb1 = new StringBuilder();
                            sb1.Append("<table width='100%' padding='-5PX'  style='font-family:Verdana;margin-left:15px;'>");
                            sb1.Append("<tr><td align='center' colspan='4' style='font-size:10px;'><b> " + commnty + " </b> </td></tr>");
                            sb1.Append("<tr><td align='center' colspan='4' style='font-size:9px;'> " + Address1 + " </td></tr>");
                            sb1.Append("<tr><td align='center' colspan='4' style='font-size:9px;'> " + Address2 + "  </td></tr>");
                            sb1.Append("<tr><td align='center' colspan='4' style='font-size:9px;'> " + Address3 + "  </td></tr>");
                            sb1.Append("<tr><td align='center' colspan='4' style='font-size:9px;'> GSTIN/UIN:33AAFCC6261P1ZC / Pan: AAFCC6261P  </td></tr>");
                            //sb1.Append("<tr><td align='center' colspan='4' style='font-size:10px;'> GSTIN/UIN:" + gstin + " / Pan: " + Pan + "  </td></tr>");

                            sb1.Append("</table>");
                            sb1.Append("<br/>");
                            sb1.Append("<table border = '1' width='100%' style='margin-left:15px;opacity:0.5;border:0.1px solid black'>");
                            sb1.Append("<tr >");
                            sb1.Append("<td align='Left' style='font-size:10px;'>");
                            sb1.Append("<b>Tax Invoice</b> ");
                            sb1.Append("</td>");
                            sb1.Append("<td align='RIGHT' style='font-size:10px;'>");
                            sb1.Append("Invoice No:" + INVOICENO + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr >");
                            sb1.Append("<td align='Left' style='font-size:10px;'>");
                            sb1.Append("" + NARATION + "");
                            sb1.Append("</td>");
                            sb1.Append("<td align='RIGHT' style='font-size:10px;'>");
                            sb1.Append("Invoice Date: " + date + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("</table>");

                            sb1.Append("<br/>");


                            sb1.Append("<table border = '1' width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                            sb1.Append("<tr >");
                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("<b>To:" + Villa + "</b> ");
                            sb1.Append("</td>");
                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("" + Resident + ":");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr >");
                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("<b></b> ");
                            sb1.Append("</td>");

                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("" + Adress + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr >");
                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("<b></b> ");
                            sb1.Append("</td>");

                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("" + Cty + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("</table><br/>");
                            sb1.Append("<table border = '1' width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                            sb1.Append("<tr >");

                            foreach (DataColumn column in dtservice.Columns)
                            {
                                if (column.ColumnName != "RTRSN")
                                {
                                    if (column.ColumnName != "Accountcode")
                                    {
                                        if (column.ColumnName == "#")
                                        {
                                            sb1.Append("<th style ='font-size:11px;font-family:Verdana;' align='center'>");
                                        }
                                        else if (column.ColumnName == "Particulars")
                                        {
                                            sb1.Append("<th style ='font-size:11px;font-family:Verdana;'  align='Left'>");
                                        }

                                        else if (column.ColumnName == "HSN/SAC")
                                        {
                                            sb1.Append("<th style ='font-size:11px;font-family:Verdana;' align='center'>");
                                        }
                                        else if (column.ColumnName == "GST Rate%")
                                        {
                                            sb1.Append("<th style ='font-size:11px;font-family:Verdana;'align='right'>");
                                        }
                                        else if (column.ColumnName == "Amount")
                                        {
                                            sb1.Append("<th style ='font-size:11px;font-family:Verdana;width:8%;' align='right'>");
                                        }
                                        //else
                                        //    {
                                        //        sb1.Append("<th style ='font-size:11px;font-family:Verdana;' align='left'>");
                                        //    }

                                        sb1.Append(column.ColumnName);
                                        sb1.Append("</th>");
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
                                    if (column.ToString() != "RTRSN")
                                    {
                                        if (column.ToString() != "Accountcode")
                                        {
                                            if (column.ToString() == "#")
                                            {
                                                sb1.Append("<td style = 'font-size:8px;font-family:Verdana;'  align='center'>" + count + "");
                                            }
                                            else if (column.ToString() == "Particulars")
                                            {
                                                sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='Left'>");
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
                                            else if (column.ToString() == "Amount")
                                            {
                                                amount = amount + Convert.ToDecimal(row[column]);
                                                sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='right'>");
                                            }
                                            //else
                                            //{
                                            //    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='left'>");
                                            //}
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
                            sb1.Append("<td  align='center' style='font-size:8px;'>" + count + "");
                            sb1.Append("</td>");
                            sb1.Append("<td align='Left' style='font-size:8px;'>Output CGST");
                            sb1.Append("</td>");
                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + CGST + "");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + sp + "");

                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            count = count + 1;
                            sb1.Append("<tr>");
                            sb1.Append("<td  align='center' style='font-size:8px;'>" + count + "");
                            sb1.Append("</td>");
                            sb1.Append("<td align='Left' style='font-size:8px;'>Output SGST");
                            sb1.Append("</td>");
                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + CGST + "");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + sp + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            amount = amount + Calc;
                            sb1.Append("<tr>");
                            sb1.Append("<td  align='center' style='font-size:8px;'>");
                            sb1.Append("</td>");
                            sb1.Append("<td align='Left' style='font-size:8px;'>Total");
                            sb1.Append("</td>");
                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("</td>");
                            sb1.Append("<td align='Left' style='font-size:8px;'>");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + amount + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");

                            sb1.Append("<tr>");
                            sb1.Append("<td align='left' style='font-size:8px;' colspan='4'>Amount chargeable (in words)");
                            sb1.Append("</td>");
                            sb1.Append("<td style='font-size:8px;'>E&O.E.");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr>");
                            sb1.Append("<td align='left' style='font-size:8px;' colspan='5'> Rupees Two Thousand Nine Hundred Sixty One and Twenty Nine Paise only");
                            sb1.Append("</td>");

                            sb1.Append("</tr>");
                            sb1.Append("</table><br/>");

                            sb1.Append("<table border = '1' width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                            sb1.Append("<tr>");
                            sb1.Append("<td colspan='2' style='font-size:8px;'>HSN/SAC");
                            sb1.Append("</td>");
                            sb1.Append("<td style='font-size:8px;' align='right'>GST Rate %");
                            sb1.Append("</td>");
                            sb1.Append("<td style='font-size:8px;' align='right'>Amount");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr>");
                            sb1.Append("<td colspan='2' style='font-size:8px;'> 999322");
                            sb1.Append("</td>");
                            sb1.Append("<td>");
                            sb1.Append("</td>");
                            sb1.Append("<td>");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr>");
                            sb1.Append("<td colspan='2'style='font-size:8px;'> Taxable amount");
                            sb1.Append("</td>");
                            sb1.Append("<td>");
                            sb1.Append("</td>");
                            sb1.Append("<td>");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr>");
                            sb1.Append("<td colspan='2' style='font-size:8px;'> CGST");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + CGST + "");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + sp + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr>");
                            sb1.Append("<td colspan='2' style='font-size:8px;'> SGST");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + CGST + "");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + sp + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr>");
                            sb1.Append("<td colspan='2' style='font-size:8px;'> Tax amount");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>" + Calc + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr>");
                            sb1.Append("<td colspan='3' style='font-size:8px;'> Rupees One Hundred forty One and Zero Two Paise Only");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>");
                            sb1.Append("</td>");
                            sb1.Append("<td align='right' style='font-size:8px;'>");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("</table><br/>");


                            sb1.Append("<table border = '1' width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                            sb1.Append("<tr>");
                            sb1.Append("<td align='left' colspan='4' style='font-size:8px;'>Remarks :");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr>");
                            sb1.Append("<td align='left' colspan='4' style='font-size:8px;'>" + NARATION + " for the month of 26.11.17 to 25.12.17");
                            sb1.Append("</td>");
                            sb1.Append("<td>");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("</table><br/>");

                            sb1.Append("<table border = '1' width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                            sb1.Append("<tr>");
                            sb1.Append("<td align='left' colspan='1' style='font-size:8px;'>Company’s bank details");
                            sb1.Append("</td>");
                            sb1.Append("<td>");
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


                            sb1.Append("<table border = '1' width='100%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
                            sb1.Append("<tr>");
                            sb1.Append("<td align='right' colspan='4' style='font-size:8px;'>For " + commnty + "");
                            sb1.Append("</td>");
                            sb1.Append("</tr>");
                            sb1.Append("<tr>");
                            sb1.Append("<td align='right' colspan='4' style='font-size:8px;'>Authorized signatory");
                            sb1.Append("</td>");
                            sb1.Append("<td>");
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
                            Document pdfDoc1 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);

                            HTMLWorker htmlparser1 = new HTMLWorker(pdfDoc1);
                            using (MemoryStream memoryStream1 = new MemoryStream())
                            {
                                PdfWriter writer1 = PdfWriter.GetInstance(pdfDoc1, memoryStream1);
                                pdfDoc1.Open();
                                //writer1.PageEvent = new Footer();
                                htmlparser1.Parse(sr1);

                                pdfDoc1.Close();
                                byte[] bytes1 = memoryStream1.ToArray();
                                memoryStream1.Close();
                                string FileName1 = "Invoice For Dining._" + Villa + "" + ".pdf";
                                myMail.Attachments.Add(new Attachment(new MemoryStream(bytes1), FileName1));
                            }



                            myMail.IsBodyHtml = true;
                            myMail.Subject = Resident + " - Dec17 - " + Villa + " - Statement for " + "" + " - " + commnty;
                            myMail.Body = "Testing";
                            mySmtpClient.Send(myMail);
                        }
                    }
                }
            }

            dt.Dispose();
            dtPersonal.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

}