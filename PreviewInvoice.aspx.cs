using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;


public partial class PreviewInvoice : System.Web.UI.Page
{
    private string ResidentId1
    {
        get; set;

    }
    StringBuilder UpS = new StringBuilder();

    string BLNGPRD = string.Empty;
    TblInvoiceFormat_B tblInvoiceFormat_B;
    TblInvoiceFormat_A tblInvoiceFormat_A;
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
    private DataSet GetDataSet1()
    {
        BLNGPRD = Get_Month_Year();
        ResidentId1 = Request.QueryString["Resident"];
        string conString = ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString;
        SqlConnection conObj = new SqlConnection(conString);
        SqlCommand cmd1 = new SqlCommand("Proc_Get_Invoice", conObj);
        { cmd1.CommandType = CommandType.StoredProcedure; }

        SqlParameter Prm1 = cmd1.CreateParameter();

        Prm1.ParameterName = "@RTRSN";
        Prm1.Value = ResidentId1;
        Prm1.SqlDbType = SqlDbType.VarChar;
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

        //@Message
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
    private void Generate_PDF(DataSet Ds1)
    {

        if (Ds1 != null)
        {
            if (Ds1 != null && Ds1.Tables.Count > 0)
            {
                DataTable dt = Ds1.Tables[0];
                DataTable dt1 = Ds1.Tables[1];
                DataTable dt2 = Ds1.Tables[2];
                DataTable dt3 = Ds1.Tables[3];
                string fieldValue;
                StringBuilder sb1 = new StringBuilder();
                foreach (DataRow dataRow in dt.Rows)
                {
                    foreach (DataColumn dataColumn in dt.Columns)
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
                //T1
                sb1.Append("<table style = 'width: 100 %; border: 1px solid black;font-size: 8pt;font-family:Arial'>");

                sb1.Append("<tr><td align='left' valign='top' style ='border:1px solid black'><img src = '" + Server.MapPath("~/Images/CovaiCareS3.png") + "' visible = 'true' runat = 'server' /> </td>" +
                    "<td align='left' valign = 'top'><b> " + tblInvoiceFormat_A.CommunityName + " </b>");
                sb1.Append("<br/>");
                sb1.Append(tblInvoiceFormat_A.CompanyAddress1 + ", " + tblInvoiceFormat_A.CompanyAddress2 + ", ");
                sb1.Append("<br/>");
                sb1.Append(tblInvoiceFormat_A.GSTIn_UIN + "<br/>");
                sb1.Append(tblInvoiceFormat_A.StateNameWithCode + "</td>");
                sb1.Append("</tr>");
                sb1.AppendLine();
                sb1.AppendLine();
                sb1.Append("<tr><td align='center' colspan='4' style='font-size:10px;'><b>INVOICE</b></td></tr>");
                sb1.Append("<tr><td colspan='5'>.................................................................................................................................................................................................................................</td></tr>");
                sb1.Append("</table>");
                sb1.Append("<table style = 'border: 2px solid black;font-size: 8pt;font-family:Arial;width:100%'>");
                sb1.Append("<tr>");
                sb1.Append("<td align='left' valign='top' style ='border:1px solid black;width:40%'>To.<br/>" + tblInvoiceFormat_A.VillaNo + " - " + tblInvoiceFormat_A.NameOfResident + ",<br/>");
                sb1.Append(tblInvoiceFormat_A.RTAddress1 + ", " + tblInvoiceFormat_A.RTAddress2 + ",<br/>");
                sb1.Append(tblInvoiceFormat_A.CityName + " - " + tblInvoiceFormat_A.Pincode + ",<br/>");
                sb1.Append("Mobile No.: " + tblInvoiceFormat_A.ContactcellNo + ",<br/>");
                sb1.Append("Email : " + tblInvoiceFormat_A.ContactMail + "</td>");
                sb1.Append("<td></td><td align='left' valign='top' style = 'width:30%'>Invoice No.<br/><b>" + tblInvoiceFormat_A.InvoiceNo + "</b></td>");

                sb1.Append("<td align='left' valign='top' style = 'width:30%'>Dated.<br/>" + tblInvoiceFormat_A.InvoiceDate + "</td>");

                sb1.Append("</tr>");
                sb1.Append("</table>");

                sb1.Append("<table style = 'width: 100 %; border: 1px solid black;font-size: 8pt;font-family:Arial'>");
                sb1.Append("<tr><td colspan='5'>.................................................................................................................................................................................................................................</td></tr>");

                sb1.Append("<tr><td align='left'><b>Sl.No.</b></td><td align='left'><b>Description of goods and Services</b></td><td align='center'><b>HSN/SAC</b></td><td align='center'><b>Rate %</b></td><td align='center'><b>Amount</b></td></tr>");
                sb1.Append("<tr><td colspan='5'>.................................................................................................................................................................................................................................</td></tr>");
                sb1.Append("</table>");

                int RowCounter = 0;
                decimal TotalAmount = 0;
                decimal TotalCGST = 0;
                decimal TotalSGST = 0;
                decimal TotalGST = 0;
                decimal GrandTotal = 0;

                sb1.Append("<table style = 'width: 100 %; border: 1px solid black;font-size: 8pt;font-family:Arial'>");
                if (dt1 != null && dt1.Rows.Count > 0)
                {
                    foreach (DataRow dataRow in dt1.Rows)
                    {
                        RowCounter += 1;
                        sb1.Append("<tr>");
                        sb1.Append("<td align='left'>" + RowCounter + "</td>");
                        foreach (DataColumn dataColumn in dt1.Columns)
                        {
                            fieldValue = dataRow[dataColumn].ToString();
                            if (dataColumn.ColumnName == "PARTICULAR")
                            {
                                tblInvoiceFormat_B.PARTICULAR = fieldValue;
                                if (tblInvoiceFormat_B.PARTICULAR.Length > 0)
                                { sb1.Append("<td align='right'>" + tblInvoiceFormat_B.PARTICULAR + "</td>"); }
                                else { sb1.Append("<td>.</td>"); }

                            }
                            if (dataColumn.ColumnName == "HSN")
                            {
                                tblInvoiceFormat_B.HSN = fieldValue;
                                if (tblInvoiceFormat_B.HSN.Length > 0)
                                { sb1.Append("<td align='center'>" + tblInvoiceFormat_B.HSN + "</td>"); }
                                else { sb1.Append("<td>.</td>"); }
                            }
                            if (dataColumn.ColumnName == "GSTPERCENTAGE")
                            {
                                tblInvoiceFormat_B.GSTPERCENTAGE = Convert.ToDecimal(fieldValue);
                                if (tblInvoiceFormat_B.GSTPERCENTAGE > 0)
                                { sb1.Append("<td align='center'>" + tblInvoiceFormat_B.GSTPERCENTAGE + "</td>"); }
                                else { sb1.Append("<td>" + "0" + "</td>"); }
                            }
                            if (dataColumn.ColumnName == "CGST")
                            {
                                tblInvoiceFormat_B.CGST = Convert.ToDecimal(fieldValue);
                            }
                            if (dataColumn.ColumnName == "SGST")
                            {
                                tblInvoiceFormat_B.SGST = Convert.ToDecimal(fieldValue);
                            }
                            if (dataColumn.ColumnName == "AMOUNT")
                            {
                                tblInvoiceFormat_B.AMOUNT = Convert.ToDecimal(fieldValue);
                                if (tblInvoiceFormat_B.AMOUNT > 0)
                                { sb1.Append("<td align='right'>" + tblInvoiceFormat_B.AMOUNT + "</td>"); }
                                else { sb1.Append("<td>.</td>"); }
                                TotalAmount += tblInvoiceFormat_B.AMOUNT;
                            }
                            if (dataColumn.ColumnName == "PAYCATEGORY")
                            {
                                tblInvoiceFormat_B.PAYCATEGORY = fieldValue;
                                if (tblInvoiceFormat_B.PAYCATEGORY.Length > 0)
                                {
                                }
                            }
                        }
                        sb1.Append("</tr>");
                        sb1.Append("<tr></tr>");
                    }

                }
                if (dt2 != null && dt2.Rows.Count > 0)
                {
                    foreach (DataRow dataRow in dt2.Rows)
                    {
                        RowCounter += 1;
                        sb1.Append("<tr>");
                        sb1.Append("<td align='left'>" + RowCounter + "</td>");
                        foreach (DataColumn dataColumn in dt2.Columns)
                        {
                            fieldValue = dataRow[dataColumn].ToString();
                            if (dataColumn.ColumnName == "PARTICULAR")
                            {
                                tblInvoiceFormat_B.PARTICULAR = fieldValue;
                                if (tblInvoiceFormat_B.PARTICULAR.Length > 0)
                                { sb1.Append("<td align='right'>" + tblInvoiceFormat_B.PARTICULAR + "</td>"); }
                                else { sb1.Append("<td>.</td>"); }

                            }
                            if (dataColumn.ColumnName == "HSN")
                            {
                                sb1.Append("<td>.</td>");
                            }
                            if (dataColumn.ColumnName == "GSTPERCENTAGE")
                            {
                                sb1.Append("<td>.</td>");
                            }
                            if (dataColumn.ColumnName == "CGST")
                            {
                            }
                            if (dataColumn.ColumnName == "SGST")
                            {
                            }
                            if (dataColumn.ColumnName == "AMOUNT")
                            {
                                tblInvoiceFormat_B.AMOUNT = Convert.ToDecimal(fieldValue);
                                if (tblInvoiceFormat_B.AMOUNT > 0)
                                { sb1.Append("<td align='right'>" + tblInvoiceFormat_B.AMOUNT + "</td>"); }
                                else { sb1.Append("<td>.</td>"); }
                                TotalCGST += tblInvoiceFormat_B.AMOUNT;
                            }
                            if (dataColumn.ColumnName == "PAYCATEGORY")
                            {
                                tblInvoiceFormat_B.PAYCATEGORY = fieldValue;
                                if (tblInvoiceFormat_B.PAYCATEGORY.Length > 0)
                                {
                                }
                            }
                        }
                        sb1.Append("</tr>");
                        sb1.Append("<tr></tr>");

                    }

                }
                if (dt3 != null && dt3.Rows.Count > 0)
                {
                    foreach (DataRow dataRow in dt3.Rows)
                    {
                        RowCounter += 1;
                        sb1.Append("<tr>");
                        sb1.Append("<td align='left'>" + RowCounter + "</td>");
                        foreach (DataColumn dataColumn in dt3.Columns)
                        {
                            fieldValue = dataRow[dataColumn].ToString();
                            if (dataColumn.ColumnName == "PARTICULAR")
                            {
                                tblInvoiceFormat_B.PARTICULAR = fieldValue;
                                if (tblInvoiceFormat_B.PARTICULAR.Length > 0)
                                { sb1.Append("<td align='right'>" + tblInvoiceFormat_B.PARTICULAR + "</td>"); }
                                else { sb1.Append("<td>.</td>"); }

                            }
                            if (dataColumn.ColumnName == "HSN")
                            {
                                sb1.Append("<td>.</td>");
                            }
                            if (dataColumn.ColumnName == "GSTPERCENTAGE")
                            {
                                sb1.Append("<td>.</td>");
                            }
                            if (dataColumn.ColumnName == "CGST")
                            {
                            }
                            if (dataColumn.ColumnName == "SGST")
                            {
                            }
                            if (dataColumn.ColumnName == "AMOUNT")
                            {
                                tblInvoiceFormat_B.AMOUNT = Convert.ToDecimal(fieldValue);
                                if (tblInvoiceFormat_B.AMOUNT > 0)
                                { sb1.Append("<td align='right'>" + tblInvoiceFormat_B.AMOUNT + "</td>"); }
                                else { sb1.Append("<td>.</td>"); }
                                TotalSGST += tblInvoiceFormat_B.AMOUNT;
                            }
                            if (dataColumn.ColumnName == "PAYCATEGORY")
                            {
                                tblInvoiceFormat_B.PAYCATEGORY = fieldValue;
                                if (tblInvoiceFormat_B.PAYCATEGORY.Length > 0)
                                {
                                }
                            }
                        }
                        TotalGST = TotalCGST + TotalSGST;
                        GrandTotal = TotalAmount + TotalGST;

                        string AmountInWords = string.Empty;
                        sb1.Append("</tr>");

                        sb1.Append("<tr><td colspan='5'>.................................................................................................................................................................................................................................</td></tr>");
                        sb1.Append("<tr><td></td><td align='right'><b>Total</b></td><td></td><td></td><td align='right'>" + GrandTotal.ToString() + "</td></tr>");
                        sb1.Append("<tr><td colspan='5'>.................................................................................................................................................................................................................................</td></tr>");
                        sb1.Append("<tr><td align='left' colspan='2' >Amount Chargeable (In Words)</td><td></td><td></td><td align='right'>E & OE</td></tr><br/>");
                        sb1.Append("<tr><td colspan='5'><b>" + Get_Amount_InWords(GrandTotal) + "</b></td></tr>");
                        sb1.Append("<tr><td colspan='5'>.................................................................................................................................................................................................................................</td></tr>");
                        sb1.Append("</table>");
                    }

                }

                sb1.Append("<table style = 'width: 100 %; border: 1px solid black;font-size: 8pt;font-family:Arial'>");
                sb1.Append("<tr><td align='right'>HSN/SAC</td><td align='right'>Taxable Value</td><td align='right'>CGST%</td><td align='right'>CGST Amount</td><td align='right'>SGST%</td><td align='right'>SGST Amount</td><td align='right'>Total Tax Amount</td></tr>");
                sb1.Append("<tr><td colspan='7'>.................................................................................................................................................................................................................................</td></tr>");
                sb1.Append("<tr><td align='right'>" + tblInvoiceFormat_B.HSN + "</td><td align='right'><b>" + TotalAmount + "</b></td><td align='right'>" + tblInvoiceFormat_B.CGST + "</td><td align='right'>" + TotalCGST + "</td><td align='right'>" + tblInvoiceFormat_B.SGST + "</td><td align='right'>" + TotalSGST + "</td><td align='right'>" + TotalGST + "</td></tr>");
                sb1.Append("<tr><td colspan='7'>.................................................................................................................................................................................................................................</td></tr>");
                sb1.Append("<tr><td align='right'><b>Total</b></td><td align='right'><b>" + TotalAmount + "</b></td><td align='right'></td><td align='right'><b>" + TotalCGST + "</b></td><td align='right'></td><td align='right'><b>" + TotalSGST + "</b></td><td align='right'><b>" + TotalGST + "</b></td></tr>");
                sb1.Append("<tr><td colspan='7'>.................................................................................................................................................................................................................................</td></tr>");
                sb1.Append("<tr><td colspan='7'>Tax Amount (in words): <b>" + Get_Amount_InWords(TotalGST) + "</b></td></tr>");
                sb1.Append("<tr><td colspan='7'>.................................................................................................................................................................................................................................</td></tr>");
                sb1.Append("</table>");

                sb1.Append("<table style = 'width: 100 %; border: 1px solid black;font-size: 8pt;font-family:Arial'>");
                sb1.Append("<tr><td align='left'>Remarks</td><td></td><td align='left'>Company's Bank Details</td></tr>");
                sb1.Append("</table>");

                sb1.Append("<table style = 'width: 100 %; border: 1px solid black;font-size: 8pt;font-family:Arial'>");
                sb1.Append("<tr><td align='left'>Being Maintenance charges for the period of " + tblInvoiceFormat_A.BPFrom +
                    "<br/> to " + tblInvoiceFormat_A.BPTill + " Invoice No." + tblInvoiceFormat_A.InvoiceNo + " </td><td>Bank Name :</td><td>" + tblInvoiceFormat_A.BankName + "</td></tr>");
                sb1.Append("<tr><td align='left'>Company's PAN : <b>" + tblInvoiceFormat_A.PAN_NO + "</b></td><td>A/C No. :</td><td>" + tblInvoiceFormat_A.AccountNo + "</td></tr>");
                sb1.Append("<tr><td align='left'> <u>Declaration : </u></td><td>Branch & IFSC Code : </td><td>" + tblInvoiceFormat_A.BranchName + " & <br/> " + tblInvoiceFormat_A.IFSCCode + "</td></tr>");
                sb1.Append("<tr><td align='left'>We declare that this invoice shows the actual price of the goods " +
                    "<br/> described and that all particulars are true and correct.</td><td></td><td>for <b>" + tblInvoiceFormat_A.CommunityName + "</b></td></tr>");
                sb1.Append("br/");
                sb1.Append("br/");
                sb1.Append("br/");
                sb1.Append("br/");
                sb1.Append("<tr><td align='right' colspan='7'>Authorized Signatory</td></tr>");
                sb1.Append("br/");
                sb1.Append("br/");
                sb1.Append("br/");
                sb1.Append("br/");
                sb1.Append("<tr><td></td><td align='center'>This is a Computer Generated Invoice</td><td></td></tr>");
                sb1.Append("</table>");

                //Jan19__SDM 10_Sukuntha V_MEB_2
                string FileName1 = tblInvoiceFormat_A.BMonth + "_" + tblInvoiceFormat_A.NameOfResident + "MEB";
                Document pdfDoc2 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.ContentType = "application/pdf";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + FileName1);
                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HTMLWorker htmlparser2 = new HTMLWorker(pdfDoc2);
                StringReader sr2 = new StringReader(sb1.ToString());


                using (MemoryStream memoryStream1 = new MemoryStream())
                {
                    string File = string.Empty;
                    string replace = FileName1.Replace(@"/", "_");
                    PdfWriter writer2 = PdfWriter.GetInstance(pdfDoc2, Response.OutputStream);
                    pdfDoc2.Open();
                    htmlparser2.Parse(sr2);
                    pdfDoc2.Close();

                    Response.Write(pdfDoc2);
                    HttpContext.Current.Response.Flush();
                    byte[] bytes1 = memoryStream1.ToArray();
                    memoryStream1.Close();
                    File = replace;
                }
                dt.Dispose();
                dt1.Dispose();
                dt2.Dispose();
                dt3.Dispose();
            }
        }
        Response.Clear();
        Response.End();
    }

    protected string Get_Amount_InWords(decimal amount)
    {
        DataSet DS = new DataSet();
        string GetAmountInWords = string.Empty;
        SqlProcsNew proc = new SqlProcsNew();
        DS = proc.ExecuteSP("getAmountinwords",
        new SqlParameter() { ParameterName = "@Amount", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Float, Value = amount }
        );

        if (DS.Tables[0].Rows.Count > 0)
        {
            GetAmountInWords = DS.Tables[0].Rows[0]["AmountInWords"].ToString();

        }
        return GetAmountInWords;
    }


    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        ResidentId1 = Request.QueryString["Resident"];
        if (ResidentId1 != string.Empty)
        {
            if (Convert.ToInt32(ResidentId1) > 0)
            {
                Generate_PDF(GetDataSet1());
            }
        }
    }


    //private static void DrawLine(PdfWriter writer, float x1, float y1, float x2, float y2, iTextSharp.text.BaseColor color)
    //{
    //    PdfContentByte contentByte = writer.DirectContent;
    //    contentByte.SetColorStroke(color);
    //    contentByte.MoveTo(x1, y1);
    //    contentByte.LineTo(x2, y2);
    //    contentByte.Stroke();
    //}
    //private static PdfPCell PhraseCell(Phrase phrase, int align)
    //{
    //    PdfPCell cell = new PdfPCell(phrase);
    //    cell.BorderColor = iTextSharp.text.BaseColor.BLACK;
    //    cell.VerticalAlignment = Element.ALIGN_TOP;
    //    cell.HorizontalAlignment = align;
    //    cell.PaddingBottom = 2f;
    //    cell.PaddingTop = 0f;
    //    return cell;
    //}
    //private static PdfPCell ImageCell(string path, float scale, int align)
    //{
    //    iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath(path));
    //    image.ScalePercent(scale);
    //    PdfPCell cell = new PdfPCell(image);
    //    cell.BorderColor = iTextSharp.text.BaseColor.WHITE;
    //    cell.VerticalAlignment = PdfPCell.ALIGN_TOP;
    //    cell.HorizontalAlignment = align;
    //    cell.PaddingBottom = 0f;
    //    cell.PaddingTop = 0f;
    //    return cell;
    //}

}