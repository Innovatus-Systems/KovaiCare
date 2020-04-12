using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using Font = iTextSharp.text.Font;

struct TblInvoiceFormat_B
{
    public int RSN;
    public string PARTICULAR;
    public string HSN;
    public decimal GSTPERCENTAGE;
    public decimal CGST;
    public decimal SGST;
    public decimal AMOUNT;
    public decimal TOTAL;
    public int RTRSN;
    public string ACCOUNTCODE;
    public string INVOICENO;
    public string YYYY;
    public string BMONTH;
    public string REF;
    public string BILLED;
    public string C_ID;
    public DateTime C_ON;
    public string M_ID;
    public DateTime M_ON;
    public int INVPCOUNT;
    public string PAYCATEGORY;
    public decimal CGAMOUNT;
    public decimal SGAMOUNT;
}

struct TblInvoiceFormat_X
{
    public string HSN_SAC;
    public string TaxableValue;
    public string CGSTP;
    public string CGSTAmount;
    public string SGSTP;
    public string SGSTAmount;
    public string TotalTaxAmount;
}

struct TblInvoiceFormat_C
{
    public string HSN;
    public decimal CGST;
    public decimal SGST;
    public decimal Amount;
}
struct TblInvoiceFormat_D
{
    public string HSN;
    public decimal CGST;
    public decimal SGST;
    public decimal Amount;
}
struct TblInvoiceFormat_E
{
    public string HSN;
    public decimal CGST;
    public decimal SGST;
    public decimal Amount;
}
struct TblInvoiceFormat_A
{
    public int RSN;
    public int RTRSN;
    public string CommunityName;
    public string CompanyAddress1;
    public string CompanyAddress2;
    public string StateNameWithCode;
    public string BankName;
    public string BranchName;
    public string AccountNo;
    public string IFSCCode;
    public string InvoiceNo;
    public string InvoiceDate;
    public string VillaNo;
    public string NameOfResident;
    public string RTAddress1;
    public string RTAddress2;
    public string CityName;
    public string Pincode;
    public string Country;
    public string ContactcellNo;
    public string ContactMail;
    public string BPFrom;
    public string BPTill;
    public string BMonth;
    public string GSTIn_UIN;
    public string PAN_NO;
}


public partial class PreviewInvoiceNew : System.Web.UI.Page
{
    enum AlignCell { TopLeft = 0, MiddleLeft = 1, BottomLeft = 2, TopCenter = 3, MiddleCeter = 4, BottomCenter = 5, TopRight = 6, MiddleRight = 7, BottomRight = 8 }
    enum FontStyles { Normal = 0, NormalBold = 1, Big = 2, BigBold = 3 }
    TblInvoiceFormat_B tblInvoiceFormat_B;
    TblInvoiceFormat_A tblInvoiceFormat_A;
    TblInvoiceFormat_C tblInvoiceFormat_C;
    TblInvoiceFormat_D tblInvoiceFormat_D;
    TblInvoiceFormat_E tblInvoiceFormat_E;
    SqlProcsNew sqlobj = new SqlProcsNew();
    string BLNGPRD = string.Empty;
    private string ResidentId1
    {
        get; set;

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        ResidentId1 = Request.QueryString["Resident"];
        lblPrompt.Visible = false;
        if (ResidentId1 != string.Empty)
        {
            if (Convert.ToInt32(ResidentId1) > 0)
            {
                try
                {
                    DataSet dataset = GetDataSet1();
                    if (dataset != null)
                    {
                        lblPrompt.Visible = false;
                        Generate_PDF(dataset);

                    }
                    else { lblPrompt.Visible = true; }
                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message);
                }

            }
        }

    }
    private DataSet GetDataSet1()
    {
        BLNGPRD = Get_Month_Year();
        string conString = ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString;
        SqlConnection conObj = new SqlConnection(conString);
        SqlCommand cmd1 = new SqlCommand("Proc_Get_Invoice", conObj);
        cmd1.CommandType = CommandType.StoredProcedure;

        SqlParameter Prm1 = cmd1.CreateParameter();

        Prm1.ParameterName = "@RTRSN";
        Prm1.Value = ResidentId1;
        Prm1.SqlDbType = SqlDbType.Int;
        cmd1.Parameters.Add(Prm1);

        Prm1 = cmd1.CreateParameter();
        Prm1.ParameterName = "@BLNGPRD";
        Prm1.Value = BLNGPRD;
        cmd1.Parameters.Add(Prm1);

        Prm1 = cmd1.CreateParameter();
        Prm1.ParameterName = "@C_ID";
        Prm1.Value = Session["UserId"];
        cmd1.Parameters.Add(Prm1);

        Prm1 = cmd1.CreateParameter();
        Prm1.ParameterName = "@Message";
        Prm1.Value = string.Empty;
        Prm1.Direction = ParameterDirection.Output;
        cmd1.Parameters.Add(Prm1);

        SqlDataAdapter sqlDa = new SqlDataAdapter(cmd1);
        DataSet DS1 = new DataSet();
        sqlDa.Fill(DS1);
        if (DS1 != null)
        {
            if (DS1.Tables.Count == 0)
            { return null; }
        }
        return DS1;
    }

    private string Get_Month_Year()
    {
        string DateTime1 = string.Empty;
        DataSet dsMonthYear = sqlobj.ExecuteSP("Proc_Get_Month_Year_Default");
        if (dsMonthYear.Tables.Count > 0)
        {
            DataTable dt1 = dsMonthYear.Tables[0];
            DataRow drw1 = dt1.Rows[0];
            DateTime1 = drw1["MonthYear"].ToString();
        }
        return DateTime1;
    }

    private void Generate_PDF(DataSet Ds1)
    {
        try
        {

            if (Ds1 != null && Ds1.Tables.Count > 0)
            {
                string fieldValue;
                foreach (DataRow dataRow in Ds1.Tables[0].Rows)
                {
                    foreach (DataColumn dataColumn in Ds1.Tables[0].Columns)
                    {
                        fieldValue = dataRow[dataColumn].ToString();

                        if (dataColumn.ColumnName == "CommunityName")
                        { tblInvoiceFormat_A.CommunityName = fieldValue; }
                        if (dataColumn.ColumnName == "CompanyAddress1")
                        { tblInvoiceFormat_A.CompanyAddress1 = fieldValue; }
                        if (dataColumn.ColumnName == "CompanyAddress2")
                        { tblInvoiceFormat_A.CompanyAddress2 = fieldValue; }
                        if (dataColumn.ColumnName == "StateNameWithCode")
                        { tblInvoiceFormat_A.StateNameWithCode = fieldValue; }
                        if (dataColumn.ColumnName == "BankName")
                        { tblInvoiceFormat_A.BankName = fieldValue; }
                        if (dataColumn.ColumnName == "BranchName")
                        { tblInvoiceFormat_A.BranchName = fieldValue; }
                        if (dataColumn.ColumnName == "AccountNo")
                        { tblInvoiceFormat_A.AccountNo = fieldValue; }
                        if (dataColumn.ColumnName == "IFSCCode")
                        { tblInvoiceFormat_A.IFSCCode = fieldValue; }
                        if (dataColumn.ColumnName == "InvoiceNo")
                        { tblInvoiceFormat_A.InvoiceNo = fieldValue; }
                        if (dataColumn.ColumnName == "InvoiceDate")
                        { tblInvoiceFormat_A.InvoiceDate = fieldValue; }
                        if (dataColumn.ColumnName == "VillaNo")
                        { tblInvoiceFormat_A.VillaNo = fieldValue; }
                        if (dataColumn.ColumnName == "NameOfResident")
                        { tblInvoiceFormat_A.NameOfResident = fieldValue; }
                        if (dataColumn.ColumnName == "RTAddress1")
                        { tblInvoiceFormat_A.RTAddress1 = fieldValue; }
                        if (dataColumn.ColumnName == "RTAddress2")
                        { tblInvoiceFormat_A.RTAddress2 = fieldValue; }
                        if (dataColumn.ColumnName == "CityName")
                        { tblInvoiceFormat_A.CityName = fieldValue; }
                        if (dataColumn.ColumnName == "Pincode")
                        { tblInvoiceFormat_A.Pincode = fieldValue; }
                        if (dataColumn.ColumnName == "Country")
                        { tblInvoiceFormat_A.Country = fieldValue; }
                        if (dataColumn.ColumnName == "ContactcellNo")
                        { tblInvoiceFormat_A.ContactcellNo = fieldValue; }
                        if (dataColumn.ColumnName == "ContactMail")
                        { tblInvoiceFormat_A.ContactMail = fieldValue; }
                        if (dataColumn.ColumnName == "BPFrom")
                        { tblInvoiceFormat_A.BPFrom = fieldValue; }
                        if (dataColumn.ColumnName == "BPTill")
                        { tblInvoiceFormat_A.BPTill = fieldValue; }
                        if (dataColumn.ColumnName == "BMonth")
                        { tblInvoiceFormat_A.BMonth = fieldValue; }
                        if (dataColumn.ColumnName == "GSTIn_UIN")
                        { tblInvoiceFormat_A.GSTIn_UIN = fieldValue; }
                        if (dataColumn.ColumnName == "PAN_No")
                        { tblInvoiceFormat_A.PAN_NO = fieldValue; }
                    }
                }

                Document doc = new Document(PageSize.A4);
                PdfPTable tableLayout = new PdfPTable(8);
                string FileName1 = tblInvoiceFormat_A.BMonth + "_" + tblInvoiceFormat_A.NameOfResident + "MEB.pdf";
                PdfWriter.GetInstance(doc, new FileStream(Server.MapPath(@"~\PDFDocuments\" + FileName1), FileMode.OpenOrCreate));
                doc.Open();
                doc.Add(Add_Content_To_PDF(tableLayout, Ds1));
                doc.Close();
                //Process.Start(Server.MapPath(@"~\PDFDocuments\" + FileName1));
                DownloadFile(@"~\PDFDocuments\" + FileName1);
            }
            else { WebMsgBox.Show("No Such data exists..."); }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
        finally
        {
            Ds1.Dispose();
            Response.Clear();
            Response.End();
        }

    }
    private void DownloadFile(string strURL)
    {
        try
        {

            System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
            response.ClearContent();
            response.Clear();
            response.ContentType = "text/plain";
            response.AddHeader("Content-Disposition",
                               "attachment; filename=" + strURL + ";");
            response.TransmitFile(Server.MapPath(strURL));
            response.Flush();
            response.End();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected string Get_Amount_InWords(decimal amount)
    {
        string GetAmountInWords = string.Empty;
        DataSet DS = null;
        try
        {

            DS = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            DS = proc.ExecuteSP("getAmountinwords",
            new SqlParameter() { ParameterName = "@Amount", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Float, Value = amount }
            );

            if (DS.Tables[0].Rows.Count > 0)
            {
                GetAmountInWords = DS.Tables[0].Rows[0]["AmountInWords"].ToString();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
        finally { DS.Dispose(); }
        return GetAmountInWords;
    }

    private PdfPTable Add_Content_To_PDF(PdfPTable tableLayout, DataSet Ds1)
    {
        float[] headers = {
            6,
        12,
        11,
        10,
        12,
        11,
        11,
        12
    }; //Header Widths  

        StringBuilder Topaddress = new StringBuilder();
        StringBuilder ResidentAddress = new StringBuilder();
        tableLayout.SetWidths(headers);
        tableLayout.WidthPercentage = 85;

        AddImageCellToBody(tableLayout, Server.MapPath(@"~\Images\CovaiCareS3.png"));
        AddCellToBody(tableLayout, "", 1, AlignCell.TopLeft, 0, 35);
        Topaddress.Append(tblInvoiceFormat_A.CommunityName + Environment.NewLine + tblInvoiceFormat_A.CompanyAddress1 + Environment.NewLine + tblInvoiceFormat_A.CompanyAddress2 +
            Environment.NewLine + tblInvoiceFormat_A.GSTIn_UIN + tblInvoiceFormat_A.StateNameWithCode + Environment.NewLine + Environment.NewLine);
        AddCellToBody(tableLayout, Topaddress.ToString(), 7, AlignCell.TopLeft, 0, 35, FontStyles.Big);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.TopLeft, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.TopLeft, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.TopLeft, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.TopLeft, 0, 17);
        AddCellToBody(tableLayout, "INVOICE", 4, AlignCell.MiddleLeft, 0, 17, FontStyles.BigBold);

        ResidentAddress.Append("To." + Environment.NewLine + Environment.NewLine + tblInvoiceFormat_A.VillaNo + " - " + tblInvoiceFormat_A.NameOfResident + "," + Environment.NewLine +
            tblInvoiceFormat_A.RTAddress1 + "," + Environment.NewLine + tblInvoiceFormat_A.CityName + ", " + tblInvoiceFormat_A.Pincode + "," + Environment.NewLine + "Mobile No. : " + tblInvoiceFormat_A.ContactcellNo +
            Environment.NewLine + "EMail ID : " + tblInvoiceFormat_A.ContactMail + ".");

        AddCellToBody(tableLayout, ResidentAddress.ToString(), 4, AlignCell.MiddleLeft, 1, 60);
        AddCellToBody(tableLayout, "Invoice No." + Environment.NewLine + tblInvoiceFormat_A.InvoiceNo, 2, AlignCell.TopLeft, 1, 60);
        AddCellToBody(tableLayout, "Dated" + Environment.NewLine + tblInvoiceFormat_A.InvoiceDate, 2, AlignCell.TopLeft, 1, 60);

        AddCellToBody(tableLayout, "Sl.No.", 1, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "Description of Goods and Services", 3, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "HSN/SAC", 1, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "Rate %", 1, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "Amount", 2, AlignCell.MiddleCeter, 1, 17);
        int SlNo = 0;
        foreach (DataRow datarow in Ds1.Tables[1].Rows)
        {
            SlNo += 1;

            tblInvoiceFormat_B.PARTICULAR = datarow["Particular"].ToString();
            tblInvoiceFormat_B.HSN = datarow["HSN"].ToString();
            tblInvoiceFormat_B.GSTPERCENTAGE = (decimal)datarow["GSTPERCENTAGE"];
            tblInvoiceFormat_B.AMOUNT = (decimal)datarow["AMOUNT"];

            AddCellToBody(tableLayout, SlNo.ToString(), 1, AlignCell.MiddleCeter, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_B.PARTICULAR, 3, AlignCell.MiddleRight, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_B.HSN, 1, AlignCell.MiddleCeter, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_B.GSTPERCENTAGE.ToString(), 1, AlignCell.MiddleCeter, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_B.AMOUNT.ToString(), 2, AlignCell.MiddleRight, 1, 17);
        }

        foreach (DataRow datarow in Ds1.Tables[2].Rows)
        {
            SlNo += 1;

            tblInvoiceFormat_B.PARTICULAR = datarow["Particular"].ToString();
            tblInvoiceFormat_B.HSN = datarow["HSN"].ToString();
            tblInvoiceFormat_B.GSTPERCENTAGE = (decimal)datarow["GSTPERCENTAGE"];
            tblInvoiceFormat_B.AMOUNT = (decimal)datarow["AMOUNT"];

            AddCellToBody(tableLayout, SlNo.ToString(), 1, AlignCell.MiddleCeter, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_B.PARTICULAR, 3, AlignCell.MiddleRight, 1, 17);
            AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleCeter, 1, 17);
            AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleCeter, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_B.AMOUNT.ToString(), 2, AlignCell.MiddleRight, 1, 17);
        }
        foreach (DataRow datarow in Ds1.Tables[3].Rows)
        {
            SlNo += 1;

            tblInvoiceFormat_B.PARTICULAR = datarow["Particular"].ToString();
            tblInvoiceFormat_B.HSN = datarow["HSN"].ToString();
            tblInvoiceFormat_B.GSTPERCENTAGE = (decimal)datarow["GSTPERCENTAGE"];
            tblInvoiceFormat_B.AMOUNT = (decimal)datarow["AMOUNT"];

            AddCellToBody(tableLayout, SlNo.ToString(), 1, AlignCell.MiddleCeter, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_B.PARTICULAR, 3, AlignCell.MiddleRight, 1, 17);
            AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleCeter, 1, 17);
            AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_B.AMOUNT.ToString(), 2, AlignCell.MiddleRight, 1, 17);
        }
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 1, 17);
        AddCellToBody(tableLayout, "Total", 3, AlignCell.MiddleRight, 1, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 1, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 1, 17);
        DataRow datarow1 = Ds1.Tables[11].Rows[0];
        decimal GRAND_TOTAL = (decimal)datarow1["GRAND_TOTAL"];
        AddCellToBody(tableLayout, GRAND_TOTAL.ToString(), 2, AlignCell.MiddleRight, 1, 17);

        string AmountInWords = Get_Amount_InWords(GRAND_TOTAL);
        AddCellToBody(tableLayout, AmountInWords, 6, AlignCell.MiddleLeft, 1, 20);
        AddCellToBody(tableLayout, "E & OE", 2, AlignCell.MiddleRight, 1, 20);

        AddCellToBody(tableLayout, "HSN/SAC", 2, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "Taxable Value", 1, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "CGST %", 1, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "CGST Amount", 1, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "SGST %", 1, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "SGST Amount", 1, AlignCell.MiddleCeter, 1, 17);
        AddCellToBody(tableLayout, "Total Tax Amount", 1, AlignCell.MiddleCeter, 1, 17);
        decimal Total_TaxableValue = 0;
        Total_TaxableValue = Convert.ToDecimal(Ds1.Tables[7].Rows[0]["TOTAL_TAXABLE_VALUE"]);
        decimal TotalGST = 0;
        decimal TotalCGST = Convert.ToDecimal(Ds1.Tables[8].Rows[0]["TOTAL_CGST_VALUE"]);
        decimal TotalSGST = Convert.ToDecimal(Ds1.Tables[9].Rows[0]["TOTAL_SGST_VALUE"]);
        decimal SumOfGST = Convert.ToDecimal(Ds1.Tables[10].Rows[0]["TOTAL_GST_VALUE"]);

        for (int i = 0; i < Ds1.Tables[4].Rows.Count; i++)
        {
            tblInvoiceFormat_C.HSN = Ds1.Tables[4].Rows[i]["HSN"].ToString();
            tblInvoiceFormat_C.Amount = Convert.ToDecimal(Ds1.Tables[4].Rows[i]["Amount"]);
            tblInvoiceFormat_D.CGST = Convert.ToDecimal(Ds1.Tables[5].Rows[i]["CGST"]);
            tblInvoiceFormat_D.Amount = Convert.ToDecimal(Ds1.Tables[5].Rows[i]["Amount"]);
            tblInvoiceFormat_E.CGST = Convert.ToDecimal(Ds1.Tables[6].Rows[i]["SGST"]);
            tblInvoiceFormat_E.Amount = Convert.ToDecimal(Ds1.Tables[6].Rows[i]["Amount"]);
            TotalGST = tblInvoiceFormat_D.Amount + tblInvoiceFormat_E.Amount;

            AddCellToBody(tableLayout, tblInvoiceFormat_C.HSN, 2, AlignCell.MiddleCeter, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_C.Amount.ToString(), 1, AlignCell.MiddleRight, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_D.CGST.ToString(), 1, AlignCell.MiddleRight, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_D.Amount.ToString(), 1, AlignCell.MiddleRight, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_E.CGST.ToString(), 1, AlignCell.MiddleRight, 1, 17);
            AddCellToBody(tableLayout, tblInvoiceFormat_E.Amount.ToString(), 1, AlignCell.MiddleRight, 1, 17);
            AddCellToBody(tableLayout, TotalGST.ToString(), 1, AlignCell.MiddleRight, 1, 17);

        }

        AddCellToBody(tableLayout, "Total", 2, AlignCell.MiddleRight, 1, 17);
        AddCellToBody(tableLayout, Total_TaxableValue.ToString(), 1, AlignCell.MiddleRight, 1, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 1, 17);
        AddCellToBody(tableLayout, TotalCGST.ToString(), 1, AlignCell.MiddleRight, 1, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 1, 17);
        AddCellToBody(tableLayout, TotalSGST.ToString(), 1, AlignCell.MiddleRight, 1, 17);
        AddCellToBody(tableLayout, SumOfGST.ToString(), 1, AlignCell.MiddleRight, 1, 17);

        AmountInWords = Get_Amount_InWords(SumOfGST);
        AddCellToBody(tableLayout, AmountInWords.ToString(), 8, AlignCell.MiddleLeft, 1, 20);

        AddCellToBody(tableLayout, "Remarks :", 2, AlignCell.MiddleLeft, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, "Company's Bank Details", 3, AlignCell.MiddleLeft, 0, 17);

        AddCellToBody(tableLayout, "Being Maintenance charges for the period of : "
            + tblInvoiceFormat_A.BPFrom + " to " + tblInvoiceFormat_A.BPTill + " - Invoice No. "
            + tblInvoiceFormat_A.InvoiceNo, 5, AlignCell.MiddleLeft, 0, 25);
        AddCellToBody(tableLayout, "Bank Name :", 1, AlignCell.MiddleLeft, 0, 17);
        AddCellToBody(tableLayout, tblInvoiceFormat_A.BankName.ToString(), 2, AlignCell.MiddleLeft, 0, 17);

        AddCellToBody(tableLayout, "Company's PAN : " + tblInvoiceFormat_A.PAN_NO, 3, AlignCell.MiddleLeft, 0, 25);
        AddCellToBody(tableLayout, string.Empty, 2, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, "A/C No. :", 1, AlignCell.MiddleLeft, 0, 17);
        AddCellToBody(tableLayout, tblInvoiceFormat_A.AccountNo.ToString(), 2, AlignCell.MiddleLeft, 0, 17);

        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleLeft, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, "Branch & IFSC Code : ", 1, AlignCell.MiddleLeft, 0, 17);
        AddCellToBody(tableLayout, tblInvoiceFormat_A.BranchName.ToString() + " & " + tblInvoiceFormat_A.IFSCCode.ToString(), 2, AlignCell.MiddleLeft, 0, 17);

        AddCellToBody(tableLayout, "Declaration : ", 2, AlignCell.MiddleLeft, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 1, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 3, AlignCell.MiddleRight, 0, 17);


        AddCellToBody(tableLayout, "We declare that this Invoice shows the actual price of "
            + "goods described and that all particulars are true and correct.", 5, AlignCell.MiddleLeft, 0, 17);

        AddCellToBody(tableLayout, "for Covai Senior Citizens Services Pvt. Ltd.,", 3, AlignCell.MiddleRight, 0, 17);

        AddCellToBody(tableLayout, string.Empty, 8, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 8, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, "Authorised Signatory", 8, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 8, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, string.Empty, 8, AlignCell.MiddleRight, 0, 17);
        AddCellToBody(tableLayout, "This is a Computer Generated Invoice", 8, AlignCell.MiddleCeter, 0, 17);

        return tableLayout;
    }


    private static void AddCellToBody(PdfPTable tableLayout, string cellText, byte CSpan, AlignCell alignCell, float BorderWidth, byte MinimumHeight, FontStyles Fs = FontStyles.Normal)
    {
        iTextSharp.text.Font fontN = null;
        try
        {

            if (Fs == FontStyles.Normal)
            {
                BaseFont bf = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                fontN = new iTextSharp.text.Font(bf, 7, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.DARK_GRAY);
            }
            else if (Fs == FontStyles.NormalBold)
            {
                BaseFont bf = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                fontN = new iTextSharp.text.Font(bf, 7, iTextSharp.text.Font.BOLD, iTextSharp.text.BaseColor.DARK_GRAY);
            }
            else if (Fs == FontStyles.Big)
            {
                BaseFont bf = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                fontN = new iTextSharp.text.Font(bf, 8, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.DARK_GRAY);
            }
            else if (Fs == FontStyles.BigBold)
            {
                BaseFont bf = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                fontN = new iTextSharp.text.Font(bf, 8, iTextSharp.text.Font.BOLD, iTextSharp.text.BaseColor.DARK_GRAY);
            }

            if (alignCell == AlignCell.TopLeft)
            {
                //tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(fontN)))
                tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.DARK_GRAY)))
                {
                    HorizontalAlignment = Element.ALIGN_LEFT,
                    VerticalAlignment = Element.ALIGN_TOP,
                    Colspan = CSpan,
                    PaddingBottom = 1,
                    PaddingTop = 1,
                    PaddingLeft = 1,
                    PaddingRight = 1,
                    MinimumHeight = MinimumHeight,
                    BackgroundColor = iTextSharp.text.BaseColor.WHITE,
                    BorderWidth = BorderWidth,
                    BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY

                });
            }
            if (alignCell == AlignCell.TopCenter)
            {
                tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK)))
                //tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(fontN)))
                {
                    HorizontalAlignment = Element.ALIGN_CENTER,
                    VerticalAlignment = Element.ALIGN_TOP,
                    Colspan = CSpan,
                    PaddingBottom = 1,
                    PaddingTop = 1,
                    PaddingLeft = 1,
                    PaddingRight = 1,
                    MinimumHeight = MinimumHeight,
                    BackgroundColor = iTextSharp.text.BaseColor.WHITE,
                    BorderWidth = BorderWidth,
                    BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY


                });
            }
            if (alignCell == AlignCell.TopRight)
            {
                tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK)))
                //tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(fontN)))
                {
                    HorizontalAlignment = Element.ALIGN_RIGHT,
                    VerticalAlignment = Element.ALIGN_TOP,
                    Colspan = CSpan,
                    PaddingBottom = 0,
                    PaddingTop = 0,
                    PaddingLeft = 0,
                    PaddingRight = 0,
                    BackgroundColor = iTextSharp.text.BaseColor.WHITE,
                    BorderWidth = 1,
                    BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY

                });
            }
            if (alignCell == AlignCell.MiddleCeter)
            {
                tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK)))
                //tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(fontN)))
                {
                    HorizontalAlignment = Element.ALIGN_CENTER,
                    VerticalAlignment = Element.ALIGN_MIDDLE,
                    Colspan = CSpan,
                    PaddingBottom = 1,
                    PaddingTop = 1,
                    PaddingLeft = 1,
                    PaddingRight = 1,
                    MinimumHeight = MinimumHeight,
                    BackgroundColor = iTextSharp.text.BaseColor.WHITE,
                    BorderWidth = BorderWidth,
                    BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY

                });
            }
            if (alignCell == AlignCell.MiddleLeft)
            {
                tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK)))
                //tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(fontN)))
                {
                    HorizontalAlignment = Element.ALIGN_LEFT,
                    VerticalAlignment = Element.ALIGN_MIDDLE,
                    Colspan = CSpan,
                    PaddingBottom = 1,
                    PaddingTop = 1,
                    PaddingLeft = 1,
                    PaddingRight = 1,
                    MinimumHeight = MinimumHeight,
                    BackgroundColor = iTextSharp.text.BaseColor.WHITE,
                    BorderWidth = BorderWidth,
                    BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY

                });
            }
            if (alignCell == AlignCell.MiddleRight)
            {
                tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK)))
                //tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(fontN)))
                {
                    HorizontalAlignment = Element.ALIGN_RIGHT,
                    VerticalAlignment = Element.ALIGN_MIDDLE,
                    Colspan = CSpan,
                    PaddingBottom = 1,
                    PaddingTop = 1,
                    PaddingLeft = 1,
                    PaddingRight = 1,
                    MinimumHeight = MinimumHeight,
                    BackgroundColor = iTextSharp.text.BaseColor.WHITE,
                    BorderWidth = BorderWidth,
                    BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY

                });
            }
        }
        catch (Exception ex)
        { WebMsgBox.Show(ex.Message); }


    }


    private static void AddCellToHeader(PdfPTable tableLayout, string cellText)
    {
        tableLayout.AddCell(new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.BLACK)))
        {
            VerticalAlignment = Element.ALIGN_TOP,
            HorizontalAlignment = Element.ALIGN_CENTER,
            Padding = 0,
            BackgroundColor = new iTextSharp.text.BaseColor(255, 255, 255),
            BorderWidth = 0
        });

    }

    private static void AddImageCellToBody(PdfPTable tableLayout, string ImagePath)
    {
        iTextSharp.text.Image myImage = iTextSharp.text.Image.GetInstance(ImagePath);
        PdfPCell cell = new PdfPCell(myImage);
        myImage.ScaleToFit(75, 27);
        cell.Border = 0;
        cell.PaddingBottom = 2;
        cell.PaddingTop = 2;
        cell.PaddingLeft = 2;
        cell.PaddingRight = 2;
        tableLayout.AddCell(cell);
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdHocInvoice.aspx");
    }
}