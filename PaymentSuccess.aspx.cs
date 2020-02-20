using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Net;
using ClsPaymentGatewayDet;

public partial class PaymentSuccess : System.Web.UI.Page
{
    static ClsPayDetails payDetails;

    SqlProcsNew sqlobj = new SqlProcsNew();

    string strProductName = "";
    string strBeforeBalance = "";
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {
                try
                {
                    payDetails = new ClsPayDetails();
                }
                catch (Exception ex)
                {

                }

                string[] merc_hash_vars_seq;
                string merc_hash_string = string.Empty;
                string merc_hash = string.Empty;
                string order_id = string.Empty;
                string hash_seq = payDetails.GetAdminParamsDetails().Rows[0]["HashSequence"].ToString();
                //"key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5|udf6|udf7|udf8|udf9|udf10";
                
                if (Request.Form["status"] == "success")
                {
                    merc_hash_vars_seq = hash_seq.Split('|');
                    Array.Reverse(merc_hash_vars_seq);
                    merc_hash_string = payDetails.GetAdminParamsDetails().Rows[0]["Salt"].ToString() + "|" + Request.Form["status"];
                    //ConfigurationManager.AppSettings["SALT"] + "|" + Request.Form["status"];
                    foreach (string merc_hash_var in merc_hash_vars_seq)
                    {
                        merc_hash_string += "|";
                        merc_hash_string = merc_hash_string + (Request.Form[merc_hash_var] != null ? Request.Form[merc_hash_var] : "");
                    }
                    merc_hash = Generatehash512(merc_hash_string).ToLower();
                    if (merc_hash != Request.Form["hash"])
                    {
                        Response.Write("Hash value did not matched");
                    }
                    else
                    {
                        double bal = Convert.ToDouble(Request.Form["udf3"]) + Convert.ToDouble(Request.Form["udf5"]);
                        Session["NewBal"] = bal;
                        LblAmount.Text = "Rs." + Request.Form["Amount"];
                        LblNewBal.Text = "New Balance : Rs." + Math.Round(bal).ToString();
                        double a = Math.Round(bal/10);
                        LblGoodFor.Text = "Good for : " + a.ToString()+" CCC Ids";
                        //LblOldBalance.Text = Request.Form["udf5"];
                        LblTotAmt.Text = Math.Round(Convert.ToDouble(Request.Form["Amount"])).ToString();
                        LblServiceTax.Text = Request.Form["udf1"];
                        LblSBCess.Text = Request.Form["udf2"];
                        LblFinalAmt.Text = Request.Form["udf3"];
                        //LblNewBalance.Text = Math.Round(bal).ToString();
                        LblInvoiceNo.Text = Request.Form["Txnid"];
                        LblDate.Text = DateTime.Now.ToString("dd-MMM-yyyy ddd HH:mm") + " Hrs.";
                        
                        DataSet dsDet = new DataSet();
                        dsDet = payDetails.GetData();
                        if (payDetails.billingDetails.Rows.Count > 0)
                        {
                            LblInvoiceTo.Text = payDetails.billingDetails.Rows[0]["InvoiceTo"].ToString();
                            LblBillingAddress.Text = payDetails.billingDetails.Rows[0]["AddressLine2"].ToString();
                        }


                        //DataSet dscom = sqlobj.ExecuteSP("SP_LoadCompanyInformation");
                        //if (dscom.Tables[0].Rows.Count > 0)
                        //{
                        //    strProductName = dscom.Tables[0].Rows[0]["ProductName"].ToString();
                        //}


                        savedet();
                    }


                    System.Globalization.CultureInfo Indian = new System.Globalization.CultureInfo("hi-IN");

                    String strTotAmt = String.Format(Indian, "{0:N}", Convert.ToDouble(LblTotAmt.Text));
                    String strSrvTax = String.Format(Indian, "{0:N}", Convert.ToDouble(LblServiceTax.Text));
                    String strSBCess = String.Format(Indian, "{0:N}", Convert.ToDouble(LblSBCess.Text));
                    String strFinalAmt = String.Format(Indian, "{0:N}", Convert.ToDouble(LblFinalAmt.Text));
                    //String strNewBal = String.Format(Indian, "{0:N}", Convert.ToDouble(LblNewBalance.Text));


                    payDetails.fromId = payDetails.GetAdminParamsDetails().Rows[0]["FromID"].ToString();
                    payDetails.MailPwd = payDetails.GetAdminParamsDetails().Rows[0]["Password"].ToString();
                    payDetails.MailIDs = payDetails.GetAdminParamsDetails().Rows[0]["MailIDs"].ToString().Split(';');
                    payDetails.CCMailIDs = payDetails.GetAdminParamsDetails().Rows[0]["CCMailIDs"].ToString().Split(';');
                    payDetails.BCCMailIDs = payDetails.GetAdminParamsDetails().Rows[0]["CCMailIDs"].ToString().Split(';');
                    String strDate = DateTime.Now.ToString("dd-MMM-yyyy");
                    //payDetails.MailSubject = "Account recharged for Rs " + strFinalAmt.ToString();
                    payDetails.MailSubject = "Payment Successful";
                    String strDescription = "";

                    if (Session["Description"] != null)
                    {
                        strDescription = Session["Description"].ToString();
                    }


                    DataSet dsbalance = sqlobj.ExecuteSP("SP_GetCreditBalance");
                    if (dsbalance.Tables[0].Rows.Count > 0)
                    {
                        strBeforeBalance = dsbalance.Tables[0].Rows[0]["AvailableBalance"].ToString();
                    }

                    dsbalance.Dispose();



                    payDetails.MailBody = "<table style=\"font-name:verdana;\" ><tr><td>Dear Customer,</td></tr></table><br/>";
                    payDetails.MailBody += "<table ><tr><td>We thank you for your payment of  Rs " + strTotAmt.ToString() + "</td></tr></table><br/>";
                    payDetails.MailBody += "<table style=\"font-name:verdana;\" ><tr><td>Payment Reference:" + LblInvoiceNo.Text + "</td></tr></table><br/>";
                    payDetails.MailBody += "<table><tr><td style=\"font-name:verdana;\" align='right'>Payment Date:" + LblDate.Text + "</td></tr></table><br/>";
                    payDetails.MailBody += "<table ><tr><td>After adjusting the taxes, the amount that will be credited to your account Rs" + strFinalAmt + "</td></tr></table><br/>";
                    payDetails.MailBody += "<table ><tr><td>New account balance is: Rs " + strBeforeBalance.ToString() + "</td></tr></table>";
                    
                    
                    //payDetails.MailBody += "<table ><tr><td>Greetings. We thank you for your continued patronage. Given below are the details of your account recharge.<br/><br/></td></tr></table><br/>";
                    //payDetails.MailBody += "<table ><tr><td>(All amount in Indian Rupees)</td></tr></table><br/>";
                    //payDetails.MailBody += "<table ><tr><td>Your account is now recharged for " + strFinalAmt.ToString() + "</td></tr></table>";
                    //payDetails.MailBody += "<table ><tr><td>Account balance before recharge: " + strBeforeBalance.ToString() + "</td></tr></table><br/>";



                    //payDetails.MailBody += "<table style=\"border:1px solid #ddd;border-collapse:collapse;\"><tr><td style=\"border:1px solid #ddd; Padding:5px;\">Transaction No</td><td style=\"border:1px solid #ddd; Padding:5px;\" align='right'>" + LblInvoiceNo.Text + "</td></tr>";
                    //payDetails.MailBody += "<tr><td style=\"border:1px solid #ddd; Padding:5px;\">Transaction Date</td><td style=\"border:1px solid #ddd; Padding:5px;\" align='right'>" + LblDate.Text + "</td></tr>";
                    //payDetails.MailBody += "<tr><td style=\"border:1px solid #ddd; Padding:5px;\">Amount paid</td><td style=\"border:1px solid #ddd; Padding:5px;\" align='right'>" + strTotAmt + "</td></tr>";
                    //payDetails.MailBody += "<tr><td style=\"border:1px solid #ddd; Padding:5px;\">Service Tax deducted</td><td style=\"border:1px solid #ddd; Padding:5px;\" align='right'>" + strSrvTax + "</td></tr>";
                    //payDetails.MailBody += "<tr><td style=\"border:1px solid #ddd; Padding:5px;\">Swachh Bharath Tax deducted</td><td style=\"border:1px solid #ddd; Padding:5px;\" align='right'>" + strSBCess + "<br/></td></tr>";
                    //payDetails.MailBody += "<tr><td style=\"border:1px solid #ddd; Padding:5px;\">Amount added to account balance</td><td style=\"border:1px solid #ddd; Padding:5px;\" align='right'>" + strFinalAmt + "</td></tr>";
                    //payDetails.MailBody += "<tr><td style=\"border:1px solid #ddd; Padding:5px;\">Narration</td><td style=\"border:1px solid #ddd; Padding:5px;\" align='right'>" + strDescription + "</td></tr></table><br/>";

                    //payDetails.MailBody += "<table><tr><td>Account recharge was carried out by " + Session["UserID"].ToString() + "</td></tr></table>";


                    payDetails.MailBody += "<table><tr><td><span ><br/>This is an auto generated mail, please do not reply.</span><br/></td></tr></table>";
                    payDetails.MailBody += "<tr><td><span >System:ORIS</span><br/></td></tr></table><br/>";


                    payDetails.MailBody += "<tr><td><span >Regards</span><br/></td></tr></table><br/>";
                    payDetails.MailBody += "<table><tr><td>Innovatus Systems</td></tr>";
                    payDetails.MailBody += "<tr><td><span>42, Meenakshi Nagar, Kovai Pudur,</span><br/></td></tr>";
                    payDetails.MailBody += "<tr><td><span>Coimbatore - 641042</span><br/></td></tr></table>";


                    payDetails.MailBody += "<table><tr><td><span>For any clarifications, please contact us at info@innovatussystems.com or +91 422 2604370/9487104370 between 9AM to 6PM Mon to Fri.</span><br/></td></tr></table><br/>";
                    
                    payDetails.MailBody += "<table><tr><td><span>Assuring our best services always.</span><br/></td></tr></table>";



                    payDetails.CreatedOn = DateTime.Now.ToString("yyyy-MM-dd");
                    if (Session["UserName"] != null)
                        payDetails.CreatedBy = Session["UserName"].ToString();
                    else
                        payDetails.CreatedBy = Session["PayUser"].ToString();
                    payDetails.Senton = DateTime.Now.ToString("yyyy-MM-dd");
                    if (Session["USERID"]!=null)
                         payDetails.Sentby = Session["USERID"].ToString();
                    else
                        payDetails.Sentby = Session["PayUser"].ToString();

                    payDetails.SendMail();


                    string strMessage="Txn ID : "+LblInvoiceNo.Text+"\r\nDescription:"+strDescription+"\r\nRecharge Amt : "+strTotAmt+"\r\nService Tax : "+strSrvTax+"\r\nSwachhBharath CESS : "+strSBCess+"\r\nTotal Amount : "+strFinalAmt+"\r\n";

                    //string contactno=payDetails.billingDetails.Rows[0]["CONTACTNO"].ToString();
                    payDetails.MobileNo = payDetails.billingDetails.Rows[0]["CONTACTNO"].ToString();
                    //payDetails.MobileNo = "9884087364";
                    payDetails.smstext = strMessage;
                    //payDetails.CreatedOn = DateTime.Now.ToString("yyyy-MM-dd");
                    //payDetails.CreatedBy = Session["UserName"].ToString();
                    payDetails.SendSMS();
                }
                else
                {
                    Response.Write("Hash value did not matched");
                }

            }
        }
        catch (Exception ex)
        {
            Response.Write("<span style='color:red'>" + ex.Message + "</span>");
        }
    }
    public string Generatehash512(string text)
    {
        byte[] message = Encoding.UTF8.GetBytes(text);
        UnicodeEncoding UE = new UnicodeEncoding();
        byte[] hashValue;
        SHA512Managed hashString = new SHA512Managed();
        string hex = "";
        hashValue = hashString.ComputeHash(message);
        foreach (byte x in hashValue)
        {
            hex += String.Format("{0:x2}", x);
        }
        return hex;
    }
    protected void BtnPrint_Click(object sender, EventArgs e)
    {
        try
        {
            string fname = "RechargeSuccess " + DateTime.Now.ToString("dd-MM-yyyy");
            BtnPrint.Visible = false;
            Response.ClearContent();
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=" + fname + "_Details.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            PnlPaymentDet.RenderControl(hw);
            Document pdfDoc = new Document(PageSize.A4, 10f, 20f, 10f, 0f);
            PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            pdfDoc.Open();
            StringReader sr = new StringReader(sw.ToString());
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            htmlparser.Parse(sr);
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
            BtnPrint.Visible = true;
        }
        catch (Exception ex)
        {
            BtnPrint.Visible = true;
        }
    }
    protected void savedet()
    {
        try
        {
            payDetails.imode = 1;
            payDetails.TxnInvoiceNo = Request.Form["txnid"];
            payDetails.TxnAmount = Math.Round(Convert.ToDouble(Request.Form["Amount"]));
            payDetails.TxnSERVICETAX = Math.Round(Convert.ToDouble(Request.Form["udf1"]));
            payDetails.TxnSBCess = Math.Round(Convert.ToDouble(Request.Form["udf2"]));
            payDetails.TxnFinalAmount = Math.Round(Convert.ToDouble(Request.Form["udf3"]));
            payDetails.TxnBalance = Math.Round(Convert.ToDouble(Session["NewBal"]));
            payDetails.TxnDesc = Convert.ToString(Session["Desc"]);
            payDetails.TxnTXNMODE = "CR";
            payDetails.TxnC_ID = Convert.ToString(Session["PayUser"]);
            payDetails.SaveTxn();
            /*SqlProcs proc = new SqlProcs();

            proc.ExecuteSP("SP_AMTTXNS",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@InvoiceNo", SqlDbType = SqlDbType.NVarChar, Value = Request.Form["txnid"] },
                new SqlParameter() { ParameterName = "@Amount", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Request.Form["Amount"])) },
                new SqlParameter() { ParameterName = "@SERVICETAX", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Request.Form["udf1"])) },
                new SqlParameter() { ParameterName = "@SBCess", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Request.Form["udf2"])) },
                new SqlParameter() { ParameterName = "@FinalAmount", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Request.Form["udf3"])) },
                new SqlParameter() { ParameterName = "@Balance", SqlDbType = SqlDbType.Float, Value = Math.Round(Convert.ToDouble(Session["NewBal"])) },
                new SqlParameter() { ParameterName = "@Desc", SqlDbType = SqlDbType.VarChar, Value = Convert.ToString(Session["Desc"]) },
                new SqlParameter() { ParameterName = "@TXNMODE", SqlDbType = SqlDbType.Char, Value = "CR" },
                new SqlParameter() { ParameterName = "@C_ID", SqlDbType = SqlDbType.VarChar, Value = Convert.ToString(Session["PayUser"]) }
                );*/
        }
        catch (Exception ex)
        {

        }
    }

    protected void BtnHome_Click(object sender, EventArgs e)
    {
        if (Session["HomePage"] != null)
            Response.Redirect(Session["HomePage"].ToString());
    }

    protected void BtnPayDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("PayDetails.aspx");
    }
    protected void BtnHistory_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaymentHistory.aspx");
    }
    protected void BtnStatement_Click(object sender, EventArgs e)
    {
        Response.Redirect("PaymentStatement.aspx");
    }
}