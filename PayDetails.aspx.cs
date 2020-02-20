using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClsPaymentGatewayDet;

public partial class PayDetails : System.Web.UI.Page
{
    static ClsPayDetails payDetails;
    public string action1 = string.Empty;
    public string key = string.Empty;
    public string hash1 = string.Empty;
    public string txnid1 = string.Empty;

    SqlProcsNew proc = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if(String.IsNullOrEmpty(Convert.ToString(Session["PayUser"])))
            {
            Response.Redirect("PayLogin.aspx");
            return;
        }
        if (!IsPostBack)
        {
            try
            {
                payDetails = new ClsPayDetails();
            }
            catch (Exception ex)
            { 
            
            }
           LoadDetails();
           LoadRechargeHistory();
        }
    }

    private void LoadRechargeHistory()
    {
        try
        {
           DataSet dsDT = proc.ExecuteSP("SP_RechargeHistory");

           if (dsDT.Tables[0].Rows.Count>0)
           {
               rdgTxns.DataSource = dsDT;
               rdgTxns.DataBind();
           }
           else
           {
               rdgTxns.DataSource = string.Empty;
               rdgTxns.DataBind();
           }


           dsDT.Dispose();


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnPay_Click(object sender, EventArgs e)
    {
        Session["Desc"] = TxtDesc.Text;
        GoToPayment();
    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        TxtAmt.Text = "";
        TxtServiceTax.Text = "";
        TxtSBCess.Text = "";
        TxtFinalAmt.Text = "";
        TxtDesc.Text = "";
        TxtAmt.Focus();
        //Response.Redirect("PayLogin.aspx");
    }
    public void LoadDetails()
    {
        try
        {

            DataSet dsPayDetails = payDetails.GetData();
            Session["STax"] = payDetails.billingDetails.Rows[0]["ServiceTax"].ToString();
            Session["SBCess"] = payDetails.billingDetails.Rows[0]["SBCess"].ToString();

            DateTime lastday, lastmoth, txndate;
            /*SqlProcs proc= new SqlProcs();
            DataSet dsDet=new DataSet();
            DateTime lastday, lastmoth, txndate;
            dsDet=proc.ExecuteSP("SP_PAYMENTADMIN",
                new SqlParameter() {ParameterName="@IMODE", SqlDbType=SqlDbType.Int, Value=3}
                );*/
            if (payDetails.billingDetails.Rows.Count > 0)
            {
                //Loading Billing details            
                /*paymentDetails.LastDebitByDay = Convert.ToDateTime(payDetails.Rows[0]["LASTDEBIT_DAILY"]);
                paymentDetails.LastDebitByMonth = Convert.ToDateTime(payDetails.Rows[0]["LASTDEBIT_MONTHLY"]);
                paymentDetails.LastRechargeOn = Convert.ToDateTime(payDetails.Rows[0]["MODIFIEDDATE"]);
                paymentDetails.Name = payDetails.Rows[0]["Name"].ToString();
                paymentDetails.ContactNo = payDetails.Rows[0]["ContactNo"].ToString();
                paymentDetails.Address = payDetails.Rows[0]["Address"].ToString();
                paymentDetails.InvoiceTo = payDetails.Rows[0]["InvoiceTo"].ToString();
                paymentDetails.BillingAddress = payDetails.Rows[0]["BillingAddress"].ToString();
                paymentDetails.TotalAmt = Math.Round(Convert.ToDecimal(payDetails.Rows[0]["AMOUNT"]));
                paymentDetails.ServiceTax = Math.Round(Convert.ToDecimal(payDetails.Rows[0]["SERVICETAX"]));
                paymentDetails.SwachBharathCess = Math.Round(Convert.ToDecimal(payDetails.Rows[0]["SBCESS"]));
                paymentDetails.FinalAmt = Math.Round(Convert.ToDecimal(payDetails.Rows[0]["FINALAMOUNT"]));
                paymentDetails.CreditLimit = Math.Round(Convert.ToDecimal(payDetails.Rows[0]["CREDITLIMIT"]));
                paymentDetails.BalAmt=Math.Round(Convert.ToDecimal(dsDet.Tables[1].Rows[0]["BALANCE"]));*/
                /*paymentDetails.Amount;
                paymentDetails.STax
                paymentDetails.SBCess
                paymentDetails.FAmt
                paymentDetails.Description*/

                /*LblInvoiceTo.Text = payDetails.billingDetails.Rows[0]["InvoiceTo"].ToString();
                txndate = Convert.ToDateTime(payDetails.billingDetails.Rows[0]["M_DATE"]);
                LblCentreName.Text = payDetails.billingDetails.Rows[0]["AddressLine1"].ToString();
                LblAddress.Text = payDetails.billingDetails.Rows[0]["AddressLine2"].ToString();
                LblContactNo.Text = payDetails.billingDetails.Rows[0]["ContactNo"].ToString();
                LblContactPerson.Text = payDetails.billingDetails.Rows[0]["ContactPerson"].ToString();
                LblEmailID.Text = payDetails.billingDetails.Rows[0]["ContactEmailId"].ToString();
                //LblBillAddr.Text = payDetails.billingDetails.Rows[0]["BillingAddress"].ToString();
                LblTariffAmt.Text = Math.Round(Convert.ToDouble(payDetails.billingDetails.Rows[0]["TARIFFAMOUNT"])).ToString();
                LblServiceTax.Text = Convert.ToDecimal(payDetails.billingDetails.Rows[0]["SERVICETAX"]).ToString();
                LblSBCess.Text = Convert.ToDecimal(payDetails.billingDetails.Rows[0]["SBCESS"]).ToString();
                LblCreditBalance.Text = Math.Round(Convert.ToDouble(payDetails.billingDetails.Rows[0]["CreditBalance"])).ToString();
                LblCreditLimit.Text = Math.Round(Convert.ToDouble(payDetails.billingDetails.Rows[0]["CREDITLIMIT"])).ToString();
                LblLastDebit.Text = payDetails.billingDetails.Rows[0]["LASTDEBIT"].ToString(); ;
                LblLastCredit.Text = payDetails.billingDetails.Rows[0]["LASTCREDIT"].ToString(); */
                LblTxnDate.Text = DateTime.Now.ToString("dd-MMM-yyyy ddd");
            }
            if (payDetails.rechargeDetails.Rows.Count > 0)
            {
                txndate = Convert.ToDateTime(payDetails.rechargeDetails.Rows[0]["C_DATE"]);
                //LblLastLastTxn.Text = txndate.ToString("dd-MMM-yyyy ddd HH:mm") + " Hrs.";
                //LblBalance.Text = Math.Round(Convert.ToDouble(payDetails.rechargeDetails.Rows[0]["BALANCE"])).ToString();
            }
            else
            {
                //LblBalance.Text = "0";
                //LblLastLastTxn.Text = "-";
            }
        }
        catch(Exception ex)
        {

        }
    }
    protected void GoToPayment()
    {
        try
        {

            string[] hashVarsSeq;
            string hash_string = string.Empty;
            string strVirtualPath = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;

            Session["Description"] = TxtDesc.Text;
            //if(!strVirtualPath.Contains("https:"))
            //    strVirtualPath=strVirtualPath.Replace("http:", "https:");
            string surl = strVirtualPath + "PaymentSuccess.aspx";
            string furl = strVirtualPath + "PaymentFailure.aspx";
            string curl = strVirtualPath + "PayDetails.aspx";


            //string surl = ConfigurationManager.AppSettings["PAYU_SUC_URL"];
            //string furl = ConfigurationManager.AppSettings["PAYU_FAIL_URL"];
            //string curl = ConfigurationManager.AppSettings["PAYU_CURR_URL"];
            string email = payDetails.GetAdminParamsDetails().Rows[0]["MailIDs"].ToString();///Please get mail id from tblwmadmin
            //string sms = "";
            if (string.IsNullOrEmpty(txnid1))
            {
                Random rnd = new Random();
                string strHash = Generatehash512(rnd.ToString() + DateTime.Now);
                txnid1 = strHash.ToString().Substring(0, 20);

            }
            hashVarsSeq = payDetails.GetAdminParamsDetails().Rows[0]["HashSequence"].ToString().Split('|');
            //ConfigurationManager.AppSettings["hashSequence"].Split('|');
            hash_string = "";
            foreach (string hash_var in hashVarsSeq)
            {
                if (hash_var == "key")
                {
                    hash_string = hash_string + payDetails.GetAdminParamsDetails().Rows[0]["MerchantKey"].ToString();
                    //ConfigurationManager.AppSettings["MERCHANT_KEY"];
                    hash_string = hash_string + '|';
                }
                else if (hash_var == "txnid")
                {
                    hash_string = hash_string + txnid1;
                    hash_string = hash_string + '|';
                }
                else if (hash_var == "amount")
                {
                    hash_string = hash_string + Math.Round(Convert.ToDecimal(TxtAmt.Text)).ToString("g29");
                    hash_string = hash_string + '|';
                }
                else if (hash_var.Equals("productinfo"))
                {
                    hash_string = hash_string + "MoSeMaSo";
                    hash_string = hash_string + '|';
                }
                else if (hash_var.Equals("firstname"))
                {
                    hash_string = hash_string + (payDetails.billingDetails.Rows[0]["AddressLine1"].ToString() != null ? payDetails.billingDetails.Rows[0]["AddressLine1"].ToString() : "");
                    hash_string = hash_string + '|';
                }
                else if (hash_var.Equals("email"))
                {
                    hash_string = hash_string + (email != null ? email : "");
                    hash_string = hash_string + '|';
                }
                //else if (hash_var.Equals("phone"))
                //{
                //    hash_string = hash_string + (LblContactNo.Text != null ? LblContactNo.Text : "");
                //    hash_string = hash_string + '|';
                //}
                else if (hash_var.Equals("udf1"))
                {
                    hash_string = hash_string + (TxtServiceTax.Text != null ? TxtServiceTax.Text : "");
                    hash_string = hash_string + '|';
                }
                else if (hash_var.Equals("udf2"))
                {
                    hash_string = hash_string + (TxtSBCess.Text != null ? TxtSBCess.Text : "");
                    hash_string = hash_string + '|';
                }
                else if (hash_var.Equals("udf3"))
                {
                    hash_string = hash_string + (TxtFinalAmt.Text != null ? TxtFinalAmt.Text : "");
                    hash_string = hash_string + '|';
                }
                else if (hash_var.Equals("udf4"))
                {
                    hash_string = hash_string + (TxtDesc.Text != null ? TxtDesc.Text : "");
                    hash_string = hash_string + '|';
                }
                else if (hash_var.Equals("udf5"))
                {
                    if (payDetails.rechargeDetails.Rows.Count > 0)
                    {
                        hash_string = hash_string + ((Math.Round(Convert.ToDouble(payDetails.rechargeDetails.Rows[0]["BALANCE"])).ToString() != null ? Math.Round(Convert.ToDouble(payDetails.rechargeDetails.Rows[0]["BALANCE"])).ToString() : ""));
                    }
                    else
                    {
                        hash_string = hash_string + "0";
                    }
                    hash_string = hash_string + '|';

                }
                else if (hash_var.Equals("udf6"))
                {
                    hash_string = hash_string + (payDetails.billingDetails.Rows[0]["InvoiceTo"].ToString() != null ? payDetails.billingDetails.Rows[0]["InvoiceTo"].ToString() : "");
                    hash_string = hash_string + '|';
                }
                else if (hash_var.Equals("udf7"))
                {
                    hash_string = hash_string + (payDetails.billingDetails.Rows[0]["AddressLine2"].ToString() != null ? payDetails.billingDetails.Rows[0]["AddressLine2"].ToString() : "");
                    hash_string = hash_string + '|';
                }
                else if (hash_var.Equals("udf10"))
                {
                    hash_string = hash_string + Convert.ToString(Session["PayUser"]);
                    hash_string = hash_string + '|';
                }
                else
                {
                    hash_string = hash_string + "";
                    hash_string = hash_string + '|';
                }
            }
            hash_string += payDetails.GetAdminParamsDetails().Rows[0]["Salt"].ToString();
            //ConfigurationManager.AppSettings["SALT"];

            hash1 = Generatehash512(hash_string).ToLower();
            action1 = payDetails.GetAdminParamsDetails().Rows[0]["PaybaseUrl"].ToString();
            //ConfigurationManager.AppSettings["PAYU_BASE_URL"] + "/_payment";

            if (!string.IsNullOrEmpty(hash1))
            {

                System.Collections.Hashtable data = new System.Collections.Hashtable(); 
                data.Add("hash", hash1);
                data.Add("txnid", txnid1);
                data.Add("key", payDetails.GetAdminParamsDetails().Rows[0]["MERCHANTKEY"].ToString());
                //ConfigurationManager.AppSettings["MERCHANT_KEY"]);
                string AmountForm = Math.Round(Convert.ToDecimal(TxtAmt.Text.Trim())).ToString("g29");
                TxtAmt.Text = AmountForm;

                //Recharge Details
                 //paymentDetails.RechargeDate;



                data.Add("amount", AmountForm);
                data.Add("firstname", payDetails.billingDetails.Rows[0]["AddressLine1"].ToString().Trim());
                data.Add("email", email);
                //data.Add("phone", LblContactNo.Text.Trim());
                data.Add("productinfo", "MoSeMaSo");
                data.Add("surl", surl);
                data.Add("furl", furl);
                data.Add("lastname", "");
                data.Add("curl", curl);
                data.Add("address1", "");
                data.Add("address2", "");
                data.Add("city", "");
                data.Add("state", "");
                data.Add("country", "");
                data.Add("zipcode", "");

                /*paymentDetails.Amount = Math.Round(Convert.ToDecimal(AmountForm)); 
                paymentDetails.STax = Math.Round(Convert.ToDecimal(TxtServiceTax.Text));
                paymentDetails.SBCess = Math.Round(Convert.ToDecimal(TxtSBCess.Text));
                paymentDetails.FAmt = Math.Round(Convert.ToDecimal(TxtFinalAmt.Text));
                paymentDetails.Description = TxtDesc.Text;*/

                data.Add("udf1", TxtServiceTax.Text);
                data.Add("udf2", TxtSBCess.Text);
                data.Add("udf3", TxtFinalAmt.Text);
                data.Add("udf4", TxtDesc.Text);

               if(payDetails.rechargeDetails.Rows.Count>0){
                	data.Add("udf5", Math.Round(Convert.ToDouble(payDetails.rechargeDetails.Rows[0]["BALANCE"])).ToString());
		            }
		        else
		        {
			   data.Add("udf5", "0");
		         }

                //data.Add("udf5", Math.Round(Convert.ToDouble(payDetails.rechargeDetails.Rows[0]["BALANCE"])).ToString());
                data.Add("udf6", payDetails.billingDetails.Rows[0]["InvoiceTo"].ToString());
                data.Add("udf7", payDetails.billingDetails.Rows[0]["AddressLine2"].ToString());
                data.Add("udf8", "");
                data.Add("udf9", "");
                data.Add("udf10", Convert.ToString(Session["PayUser"]));

                string strForm = PreparePOSTForm(action1, data);
                Page.Controls.Add(new LiteralControl(strForm));

            }
            else
            {
                //no hash

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
    private string PreparePOSTForm(string url, System.Collections.Hashtable data)      // post form
    {
        //Set a name for the form
        string formID = "PostForm";
        //Build the form using the specified data to be posted.
        StringBuilder strForm = new StringBuilder();
        strForm.Append("<form id=\"" + formID + "\" name=\"" +
                       formID + "\" action=\"" + url +
                       "\" method=\"POST\">");

        foreach (System.Collections.DictionaryEntry key in data)
        {

            strForm.Append("<input type=\"hidden\" name=\"" + key.Key +
                           "\" value=\"" + key.Value + "\">");
        }


        strForm.Append("</form>");
        //Build the JavaScript which will do the Posting operation.
        StringBuilder strScript = new StringBuilder();
        strScript.Append("<script language='javascript'>");
        strScript.Append("var v" + formID + " = document." +
                         formID + ";");
        strScript.Append("v" + formID + ".submit();");
        strScript.Append("</script>");
        //Return the form and the script concatenated.
        //(The order is important, Form then JavaScript)
        return strForm.ToString() + strScript.ToString();
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
    protected void rdgTxns_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            LoadRechargeHistory();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}