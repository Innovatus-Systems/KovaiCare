using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class PrintReceipt : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            string rsn = Request.QueryString[0].ToString();
            LoadDetails(Convert.ToInt64(rsn.ToString()));
           
        }

    }

    protected void LoadDetails(Int64 receiptrsn)
    {


        SqlProcsNew proc = new SqlProcsNew();

        DataSet dsReceipt = proc.ExecuteSP("SP_GetReceiptNo",
        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Session["ReceiptRSN"].ToString() });

        if (dsReceipt.Tables[0].Rows.Count > 0)
        {

            string strName = dsReceipt.Tables[0].Rows[0]["Title"].ToString() + dsReceipt.Tables[0].Rows[0]["Name"].ToString();
            string strDoorNo = dsReceipt.Tables[0].Rows[0]["DoorNo"].ToString();
            string strReceiptNo = dsReceipt.Tables[0].Rows[0]["ReceiptNo"].ToString();
            DateTime dReceiptDate = Convert.ToDateTime(dsReceipt.Tables[0].Rows[0]["TXDATE"].ToString());
            string strNarration = dsReceipt.Tables[0].Rows[0]["TXDESC"].ToString();
            string strPayMode = dsReceipt.Tables[0].Rows[0]["BCode"].ToString();
            string strAmount = dsReceipt.Tables[0].Rows[0]["TXAMOUNT"].ToString();
            string strcname = dsReceipt.Tables[1].Rows[0]["CommunityName"].ToString();
            string strphone = "Mobile :" + dsReceipt.Tables[1].Rows[0]["FromMobileNo"].ToString();
            string stremail = "Email :" + dsReceipt.Tables[1].Rows[0]["FromID"].ToString();
            string stramtinwords = dsReceipt.Tables[0].Rows[0]["AmtInWords"].ToString();



            lblstrcname.Text = strcname.ToString();
            lblstrcname2.Text = strcname.ToString();

            lblstrphone.Text = strphone.ToString();
            lblstrphone2.Text = strphone.ToString();

            lblstremail.Text = stremail.ToString();
            lblstremail2.Text = stremail.ToString();


            lblstrreceiptno.Text = strReceiptNo.ToString();
            lblstrreceiptno2.Text = strReceiptNo.ToString();


            lblstrreceiptdate.Text = dReceiptDate.ToString("dd/MM/yyyy");
            lblstrreceiptdate2.Text = dReceiptDate.ToString("dd/MM/yyyy");

            lblstrname.Text = strName.ToString();
            lblstrname2.Text = strName.ToString();


            lblstrdoorno.Text = strDoorNo.ToString();
            lblstrdoorno2.Text = strDoorNo.ToString();

            lblstramount.Text = strAmount.ToString();
            lblstramount2.Text = strAmount.ToString();


            lblstrpaymode.Text = strPayMode.ToString();
            lblstrpaymode2.Text = strPayMode.ToString();


            lblstrnarration.Text = strNarration.ToString();
            lblstrnarration2.Text = strNarration.ToString();


            lblstramtinwords.Text = stramtinwords.ToString();
            lblstramtinwords2.Text = stramtinwords.ToString(); 

            bPrintedByVal.Text = Session["UserID"].ToString();
            bPrintedByVal2.Text = Session["UserID"].ToString();
            lblPrintedOnDate.Text = DateTime.Now.ToString("dd-MMM-yyyy HH:MM:tt");
            lblPrintedOnDate2.Text = DateTime.Now.ToString("dd-MMM-yyyy HH:MM:tt"); 


        }

    }


   

}