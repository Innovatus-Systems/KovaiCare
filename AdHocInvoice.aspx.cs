using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using Telerik.Web.UI;

public partial class AdHocInvoice : System.Web.UI.Page
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
    string Ref;
    static string strBillNo;
    static string invNo;
    static decimal Amount;
    static decimal Total;
    static decimal CGSTAmt;
    static decimal SGSTAmt;
    static string MailId;
    static string File;
    StringBuilder SB1 = new StringBuilder();
    StringBuilder SB = new StringBuilder();

    public DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            LoadResidentDet();
            LoadTitle();
            LoadDropDown();
            lblnm.Visible = false;
            lblSpace.Visible = false;
            lblDrNo.Visible = false;
            LabelAccNo.Visible = false;
            lblAccNo.Visible = false;
            rgAdHoc.DataSource = string.Empty;
            rgAdHoc.DataBind();
            LoadDetails();
        }
    }
    private void LoadDropDown()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_AdHocInvoice", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                drpService.DataSource = dsTitle.Tables[0];
                drpService.DataTextField = "STDTEXT";
                drpService.DataValueField = "TXNCODE";
                drpService.DataBind();
                drpService.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Please Select", "0"));
                //drpService.Items.Insert(1, new System.Web.UI.WebControls.ListItem("ALL", "AL"));
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 159 });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadGrid()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_AdHocInvoice",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@TXCODE", SqlDbType = SqlDbType.NVarChar, Value = drpService.SelectedValue.ToString() });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                rgAdHoc.DataSource = dsTitle.Tables[0];
                rgAdHoc.DataBind();
            }
            else
            {
                rgAdHoc.DataSource = string.Empty;
                rgAdHoc.DataBind();
                drpService.Enabled = true;
                cmbResident.Enabled = false;
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There is no Unbilled transaction(s).');", true);
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadAllBilled()
    {

        try
        {
            if (cmbResident.SelectedValue == "0")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please select Resident');", true);
                return;
            }
            DataSet dsTitle = sqlobj.ExecuteSP("SP_AdHocInvoice",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 5 },
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                rgAdHoc.DataSource = dsTitle.Tables[0];
                rgAdHoc.DataBind();
            }
            else
            {
                rgAdHoc.DataSource = string.Empty;
                rgAdHoc.DataBind();
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('There is no Billed transaction(s).');", true);
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void LoadResidentDet()
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_AdHocInvoice",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 }
                );
            cmbResident.DataSource = dsResident.Tables[0];
            cmbResident.DataValueField = "RTRSN";
            cmbResident.DataTextField = "RName";
            cmbResident.DataBind();
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbResident.Items.Add(item2);
            dsResident.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void cmbResident_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            DataSet dsDetails = sqlobj.ExecuteSP("SP_TxnDropDownList", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@SelectedValue", SqlDbType = SqlDbType.NVarChar, Value = cmbResident.SelectedValue.ToString() });
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                lblnm.Text = dsDetails.Tables[0].Rows[0]["RtName"].ToString();
                lblDrNo.Text = dsDetails.Tables[0].Rows[0]["RTVillaNo"].ToString();
                lblAccNo.Text = dsDetails.Tables[0].Rows[0]["GLAccount"].ToString();
                lblnm.Visible = true;
                //LabelName.Visible = true;
                //LabelDrNo.Visible = true;
                lblSpace.Visible = true;
                lblDrNo.Visible = true;
                LabelAccNo.Visible = true;
                lblAccNo.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

    protected void rgAdHoc_ItemCreated(object sender, GridItemEventArgs e)
    {

    }

    protected void rgAdHoc_ItemDataBound(object sender, GridItemEventArgs e)
    {

    }

    protected void rgAdHoc_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgAdHoc.FilterMenu;
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

    protected void rgAdHoc_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid();
    }

    protected void drpService_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (cmbResident.SelectedValue == "0" || cmbResident.SelectedValue == "")
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please select Resident.');", true);
            return;
        }
    }
    protected void UpdateTxn(decimal Amt)
    {
        try
        {
            DataSet dsUpdate = sqlobj.ExecuteSP("SP_AdHocInvoice",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 4 },
                  new SqlParameter() { ParameterName = "@Where", SqlDbType = SqlDbType.NVarChar, Value = SB1.ToString() },
                  new SqlParameter() { ParameterName = "@invNo", SqlDbType = SqlDbType.NVarChar, Value = invNo },
                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@TXCODE", SqlDbType = SqlDbType.NVarChar, Value = drpService.SelectedValue },
                   new SqlParameter() { ParameterName = "@Amount", SqlDbType = SqlDbType.Decimal, Value = Amt },
                   new SqlParameter() { ParameterName = "@MailId", SqlDbType = SqlDbType.NVarChar, Value = MailId },
                   new SqlParameter() { ParameterName = "@File", SqlDbType = SqlDbType.NVarChar, Value = File },
                   new SqlParameter() { ParameterName = "@C_BY", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                );
            LoadDetails();
            clear();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message + "');", true);
        }
    }
    protected void clear()
    {
        try
        {
            cmbResident.Enabled = true;
            drpService.Enabled = true;
            chkShow.Checked = false;
            cmbResident.SelectedValue = "0";
            drpService.SelectedValue = "0";
            lblnm.Visible = false;
            lblSpace.Visible = false;
            lblDrNo.Visible = false;
            LabelAccNo.Visible = false;
            lblAccNo.Visible = false;
            rgAdHoc.DataSource = string.Empty;
            rgAdHoc.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void LoadDetails()
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_AdHocInvoice",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 6 }
                );
            lblFandB.Text = dsResident.Tables[0].Rows[0]["Details"].ToString();
            lblMain.Text = dsResident.Tables[0].Rows[1]["Details"].ToString();
            lblCab.Text = dsResident.Tables[0].Rows[2]["Details"].ToString();
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (cmbResident.SelectedValue == "0" || cmbResident.SelectedValue == "" || drpService.SelectedValue == "0" || drpService.SelectedValue == "")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please select Resident and Invoice Type.');", true);
                return;
            }
            cmbResident.Enabled = false;
            drpService.Enabled = false;
            LoadGrid();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        try
        {

            DataSet ds = new DataSet();
            string sb = string.Empty;
            DateTime bdate = DateTime.Now;
            string strday = bdate.ToString("dd");
            string strmonth = bdate.ToString("MM");
            string stryear = bdate.ToString("yyyy");
            string strhour = bdate.ToString("HH");
            string strmin = bdate.ToString("mm");
            string strsec = bdate.ToString("ss");
            strBillNo = stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();
            int count = 0;
            if (cmbResident.SelectedValue == "0" || cmbResident.SelectedValue == "" || drpService.SelectedValue == "0" || drpService.SelectedValue == "")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please select Resident and Invoice Type.');", true);
                return;
            }
            foreach (GridDataItem item in rgAdHoc.MasterTableView.Items)
            {
                if (item.Selected)
                {
                    count = count + 1;
                }
            }
            if (count > 0)
            {
                foreach (GridDataItem rw in rgAdHoc.MasterTableView.Items)
                {
                    if (rw.Selected)
                    {
                        Ref = Convert.ToString(rw.GetDataKeyValue("Ref").ToString());
                        SB.Clear();
                        SB.Append(Ref);
                        SB.Remove(SB.Length - 3, 3);
                        sb = " BillNo Like '" + SB + "%'" + " or ";
                        SB1.Append(sb);
                        string upsb = "REF like '" + Ref + "'";

                    }
                }
                SB1.Remove(SB1.Length - 3, 3);

                DataSet dsDetails = sqlobj.ExecuteSP("SP_DebitFromUnbilled",
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(cmbResident.SelectedValue) },
                            new SqlParameter() { ParameterName = "@RefNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                            new SqlParameter() { ParameterName = "@InvoiceType", SqlDbType = SqlDbType.NVarChar, Value = drpService.SelectedValue.ToString() },
                            new SqlParameter() { ParameterName = "@Where", SqlDbType = SqlDbType.NVarChar, Value = SB1.ToString() },
                             new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = Ref.ToString() }
                         );

                if (dsDetails.Tables[0].Rows.Count > 0)
                {
                    //if (dsDetails.Tables[0].Rows[0]["Status"].ToString() == "Billed")
                    //{
                    //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Already Billed,Try again with different txn(s).');", true);
                    //    clear();
                    //    return;
                    //}
                    //else
                    //{
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
                    if (drpService.SelectedValue == "DI")
                    {
                        DiningInv(dsDetails.Tables[0], dsDetails.Tables[1]);
                        HttpContext.Current.ApplicationInstance.CompleteRequest();
                    }
                    if (drpService.SelectedValue == "MC")
                    {
                        MaintaningInv(dsDetails.Tables[0], dsDetails.Tables[1]);
                        HttpContext.Current.ApplicationInstance.CompleteRequest();
                    }
                    if (drpService.SelectedValue == "CB")
                    {
                        CabInv(dsDetails.Tables[0], dsDetails.Tables[1]);
                        HttpContext.Current.ApplicationInstance.CompleteRequest();
                    }

                    //}

                    clear();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No Data');", true);
                    return;
                }
                //Response.Redirect("AdHocInvoice.aspx");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select atleast one Entry.');", true);
            }
            //HttpContext.Current.Response.End();

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message + "');", true);
        }
    }
    protected void DiningInv(DataTable dt, DataTable dtPersonal)
    {
        try
        {
            string outstd = "";
            Amount = 0;
            Total = 0;
            CGSTAmt = 0;
            SGSTAmt = 0;
            DataTable dtNew = new DataTable();

            for (int i = 0; i < dtPersonal.Rows.Count; i++)
            {
                int count = 0;
                count = 0;
                System.Web.HttpResponse Response = System.Web.HttpContext.Current.Response;
                string mailserver = string.Empty;
                string user = string.Empty;
                string pwd = string.Empty;
                string sentby = string.Empty;
                string Email = string.Empty;

                //SqlCommand cmd = new SqlCommand("Proc_GetEmailCredentials", con);
                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                //DataSet dsCredential = new DataSet();
                //da.Fill(dsCredential);
                //// Write an informational entry to the event log.  

                //if (dsCredential != null && dsCredential.Tables.Count > 0)
                //{
                //    foreach (DataRow row in dsCredential.Tables[0].Rows)
                //    {
                //        mailserver = row["mailserver"].ToString();
                //        user = row["username"].ToString();
                //        pwd = row["password"].ToString();
                //        sentby = row["sentbyuser"].ToString();
                //        Email = row["Email"].ToString();
                //    }
                //}
                //MailId = Email;
                //SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                //MailAddress From = new MailAddress(user, "info@innovatussystems.com");
                //MailMessage myMail = new System.Net.Mail.MailMessage();
                //myMail.From = From;
                //myMail.To.Add(Email);
                ////myMail.CC.Add("covaiproprarch@gmail.com");
                //mySmtpClient.UseDefaultCredentials = false;
                //System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
                //mySmtpClient.Credentials = basicauth;
                //mySmtpClient.EnableSsl = false;
                //mySmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                ////mySmtpClient.Timeout = 200000;
                //myMail.SubjectEncoding = System.Text.Encoding.UTF8;
                //myMail.BodyEncoding = System.Text.Encoding.UTF8;
                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        string Villa = dtPersonal.Rows[i]["Villa"].ToString();
                        string Resident = dtPersonal.Rows[i]["Name"].ToString();
                        string Adress = dtPersonal.Rows[i]["Address1"].ToString();
                        string Cty = dtPersonal.Rows[i]["Address3"].ToString();
                        string Accountcode = dtPersonal.Rows[i]["Accountcode"].ToString();
                        outstd = dtPersonal.Rows[i]["outstd"].ToString();
                        string strQuery = "Accountcode = '" + Accountcode + "'";

                        DateTime Odate = DateTime.Now;
                        string printedOn = Odate.ToString("dd-MMM-yyyy hh:mm tt");
                        string date = Odate.ToString("dd-MMM-yyyy");

                        //DINING INVOICE 
                        DataSet dstxn = sqlobj.ExecuteSP("SP_GETTXNCODEFORBILLING",
                           new SqlParameter() { ParameterName = "@TXNCODE", SqlDbType = SqlDbType.NVarChar, Value = "DI" }
                        );
                        string txncode = dstxn.Tables[0].Rows[0]["WHERE"].ToString();
                        txncode = txncode.Replace("/", "'");

                        DataTable dtservice = null;
                        string where = "txncode in (" + txncode + ") and Billno like '" + strBillNo + "%'";
                        string whr = strQuery + " and " + where;
                        DataSet dsDetails = new DataSet();
                        SqlCommand cmd1 = new SqlCommand("Proc_GetGST", con);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.Parameters.AddWithValue("@where", whr);
                        SqlDataAdapter dap = new SqlDataAdapter(cmd1);
                        dap.Fill(dsDetails, "temp");
                        string Bmonth = dsDetails.Tables[0].Rows[0]["BPName"].ToString();
                        string BFROM = dsDetails.Tables[0].Rows[0]["BPFROM"].ToString();
                        string BTILL = dsDetails.Tables[0].Rows[0]["BPTILL"].ToString();
                        int drows = dsDetails.Tables[0].Rows.Count;
                        decimal Calc = 0;
                        decimal sp = 0;
                        //string whr1 = strQuery + " and txncode in (" + txncode + ") ";
                        string whr1 = strQuery;
                        DataRow[] drfilService = dt.Select(whr1);

                        if (drfilService.Any())
                        {
                            DataSet dsINVOICE = new DataSet();
                            dtservice = drfilService.CopyToDataTable();
                            invNo = dtservice.Rows[0]["InvoiceNo"].ToString();

                            string NARATION = dtservice.Rows[0]["Particulars"].ToString();
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
                            sb1.Append("Date: " + date + "");
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
                                if (column.ColumnName != "#")
                                {
                                    if (column.ColumnName != "RTRSN")
                                    {
                                        if (column.ColumnName != "ACCOUNTCODE")
                                        {
                                            if (column.ColumnName != "TXNCODE")
                                            {
                                                if (column.ColumnName != "REF")
                                                {
                                                    if (column.ColumnName == "Particulars")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;' colspan='1'  align='center'>");
                                                    }

                                                    else if (column.ColumnName == "HSN/SAC")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;' align='center'>");
                                                    }
                                                    else if (column.ColumnName == "GST Rate%")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='center'>");
                                                    }
                                                    else if (column.ColumnName == "TaxableVlu")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;width:8%;' align='center'>");
                                                    }
                                                    else if (column.ColumnName == "CGST Amt")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='center'>");
                                                    }
                                                    else if (column.ColumnName == "SGST Amt")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='center'>");
                                                    }

                                                    else if (column.ColumnName == "Total")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;width:8%;' align='center'>");
                                                    }
                                                    //else
                                                    //    {
                                                    //        sb1.Append("<th style ='font-size:11px;font-family:Verdana;' align='left'>");
                                                    //    }
                                                    if (column.ColumnName == "TaxableVlu")
                                                    {
                                                        sb1.Append("<b>Taxable Value</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                    else if (column.ColumnName == "CGST Amt")
                                                    {
                                                        sb1.Append("<b>CGST Amount</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                    else if (column.ColumnName == "SGST Amt")
                                                    {
                                                        sb1.Append("<b>SGST Amount</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                    else
                                                    {
                                                        sb1.Append("<b>" + column.ColumnName + "</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                }
                                            }
                                        }
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
                                    if (column.ColumnName != "#")
                                    {
                                        if (column.ColumnName != "RTRSN")
                                        {
                                            if (column.ColumnName != "ACCOUNTCODE")
                                            {
                                                if (column.ColumnName != "TXNCODE")
                                                {
                                                    if (column.ColumnName != "REF")
                                                    {
                                                        //if (column.ToString() == "#")
                                                        //{
                                                        //    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;'  align='center'>" + count + "");
                                                        //}
                                                        if (column.ToString() == "Particulars")
                                                        {
                                                            sb1.Append("<td style = 'font-size:8px;font-family:Verdana;'  align='Left'>");
                                                        }
                                                        else if (column.ToString() == "HSN/SAC")
                                                        {
                                                            sb1.Append("<td style = 'font-size:8px;font-family:Verdana;' align='right'>");
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
                            sb1.Append("<table border = '1' width='50%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
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


                            //StringReader sr1 = new StringReader(sb1.ToString());
                            StringReader sr2 = new StringReader(sb1.ToString());
                            StringBuilder sbBody = new StringBuilder();
                            //sbBody.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;font-size:14px;'>");
                            //sbBody.Append("<tr><td><b> Greetings,</b></td></tr>");
                            //sbBody.Append("<tr><td>Amount to pay for this Invoice:- <b>Rs." + Amount + " </b> .");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td>The Invoice(s) are attached.</b>");
                            //sbBody.Append("</td></tr>");
                            ////sbBody.Append("<tr><td>Kindly make arrangements to pay within 10 days of this mail.</td></tr>");
                            //sbBody.Append("<tr><td>With Best Regards,");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td><b>" + commnty + "</b></td></tr>");
                            //sbBody.Append("<tr><td>");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td> ");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td></td></tr>");
                            //sbBody.Append("<tr><td>The Invoice(s) in PDF Format and can be opened by Adobe ® Acrobat reader by clicking on the attachment.");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td></td></tr>");
                            //sbBody.Append("<tr style='font-family:Verdana;font-size:13px;'><td><b>This is an automatically generated mail from <a href='http://bincrm.com/oris/' title='Click here to open ORIS'>ORIS</a>, the software for Retirement Communities.</b></td></tr>");
                            //sbBody.Append("</table>");
                            //myMail.IsBodyHtml = true;
                            //myMail.Body = sbBody.ToString();
                            //myMail.Subject = invNo + "_" + Villa + "_" + Resident;
                            //sb1.Length = 0;
                            //sb1.Clear();
                            string FileName1 = invNo + "_" + Villa + "_" + Resident + "_" + NARATION + ".pdf";
                            //Document pdfDoc1 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                            Document pdfDoc2 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                            HttpContext.Current.Response.Clear();
                            HttpContext.Current.Response.ContentType = "application/pdf";
                            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + FileName1 + "");
                            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                            //HTMLWorker htmlparser1 = new HTMLWorker(pdfDoc1);
                            HTMLWorker htmlparser2 = new HTMLWorker(pdfDoc2);

                            using (MemoryStream memoryStream1 = new MemoryStream())
                            {

                                string replace = FileName1.Replace(@"/", "_");
                                //PdfWriter writer2 = PdfWriter.GetInstance(pdfDoc2, new FileStream(@"F:\Dhinesh\Files" + @"\" + replace, FileMode.Create));
                                PdfWriter writer2 = PdfWriter.GetInstance(pdfDoc2, Response.OutputStream);
                                //PdfWriter writer1 = PdfWriter.GetInstance(pdfDoc1, memoryStream1);                                
                                //pdfDoc1.Open();
                                //writer1.PageEvent = new Footer();                               
                                //htmlparser1.Parse(sr1);
                                //pdfDoc1.Close();

                                pdfDoc2.Open();
                                //writer2.PageEvent = new Footer();
                                htmlparser2.Parse(sr2);
                                pdfDoc2.Close();

                                Response.Write(pdfDoc2);
                                HttpContext.Current.Response.Flush();
                                byte[] bytes1 = memoryStream1.ToArray();
                                memoryStream1.Close();
                                File = replace;
                                //myMail.Attachments.Add(new Attachment(new MemoryStream(bytes1), FileName1));
                            }
                            UpdateTxn(Total);
                        }
                        //End
                        //mySmtpClient.Send(myMail);                      
                    }
                }
                dt.Dispose();
                dtPersonal.Dispose();

            }
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Invoice(s) generated successfully');", true);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Something went wrong." + ex.Message + "'');", true);
        }
    }
    protected void MaintaningInv(DataTable dt, DataTable dtPersonal)
    {
        try
        {

            string outstd = "";
            Amount = 0;
            Total = 0;
            CGSTAmt = 0;
            SGSTAmt = 0;
            DataTable dtNew = new DataTable();

            for (int i = 0; i < dtPersonal.Rows.Count; i++)
            {
                int count = 0;
                count = 0;
                System.Web.HttpResponse Response = System.Web.HttpContext.Current.Response;
                string mailserver = string.Empty;
                string user = string.Empty;
                string pwd = string.Empty;
                string sentby = string.Empty;
                string Email = string.Empty;

                //SqlCommand cmd = new SqlCommand("Proc_GetEmailCredentials", con);
                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                //DataSet dsCredential = new DataSet();
                //da.Fill(dsCredential);
                //// Write an informational entry to the event log.  

                //if (dsCredential != null && dsCredential.Tables.Count > 0)
                //{
                //    foreach (DataRow row in dsCredential.Tables[0].Rows)
                //    {
                //        mailserver = row["mailserver"].ToString();
                //        user = row["username"].ToString();
                //        pwd = row["password"].ToString();
                //        sentby = row["sentbyuser"].ToString();
                //        Email = row["Email"].ToString();
                //    }
                //}
                //MailId = Email;
                //SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                //MailAddress From = new MailAddress(user, "info@innovatussystems.com");
                //MailMessage myMail = new System.Net.Mail.MailMessage();
                //myMail.From = From;
                //myMail.To.Add(Email);
                ////myMail.CC.Add("covaiproprarch@gmail.com");
                //mySmtpClient.UseDefaultCredentials = false;
                //System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
                //mySmtpClient.Credentials = basicauth;
                //mySmtpClient.EnableSsl = false;
                //mySmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                ////mySmtpClient.Timeout = 200000;
                //myMail.SubjectEncoding = System.Text.Encoding.UTF8;
                //myMail.BodyEncoding = System.Text.Encoding.UTF8;
                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        string Villa = dtPersonal.Rows[i]["Villa"].ToString();
                        string Resident = dtPersonal.Rows[i]["Name"].ToString();
                        string Adress = dtPersonal.Rows[i]["Address1"].ToString();
                        string Cty = dtPersonal.Rows[i]["Address3"].ToString();
                        string Accountcode = dtPersonal.Rows[i]["Accountcode"].ToString();
                        outstd = dtPersonal.Rows[i]["outstd"].ToString();
                        string strQuery = "Accountcode = '" + Accountcode + "'";

                        DateTime Odate = DateTime.Now;
                        string printedOn = Odate.ToString("dd-MMM-yyyy hh:mm tt");
                        string date = Odate.ToString("dd-MMM-yyyy");

                        //DINING INVOICE 
                        DataSet dstxn = sqlobj.ExecuteSP("SP_GETTXNCODEFORBILLING",
                           new SqlParameter() { ParameterName = "@TXNCODE", SqlDbType = SqlDbType.NVarChar, Value = "MC" }
                        );
                        string txncode = dstxn.Tables[0].Rows[0]["WHERE"].ToString();
                        txncode = txncode.Replace("/", "'");

                        DataTable dtservice = null;
                        string where = "txncode in (" + txncode + ") and Billno like '" + strBillNo + "%'";
                        string whr = strQuery + " and " + where;
                        DataSet dsDetails = new DataSet();
                        SqlCommand cmd1 = new SqlCommand("Proc_GetGST", con);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.Parameters.AddWithValue("@where", whr);
                        SqlDataAdapter dap = new SqlDataAdapter(cmd1);
                        dap.Fill(dsDetails, "temp");
                        string Bmonth = dsDetails.Tables[0].Rows[0]["BPName"].ToString();
                        string BFROM = dsDetails.Tables[0].Rows[0]["BPFROM"].ToString();
                        string BTILL = dsDetails.Tables[0].Rows[0]["BPTILL"].ToString();
                        int drows = dsDetails.Tables[0].Rows.Count;

                        //string whr1 = strQuery + " and txncode in (" + txncode + ") ";
                        string whr1 = strQuery;
                        DataRow[] drfilService = dt.Select(whr1);

                        if (drfilService.Any())
                        {
                            DataSet dsINVOICE = new DataSet();
                            dtservice = drfilService.CopyToDataTable();
                            invNo = dtservice.Rows[0]["InvoiceNo"].ToString();

                            string NARATION = dtservice.Rows[0]["Particulars"].ToString();
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
                            sb1.Append("Date: " + date + "");
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
                                if (column.ColumnName != "#")
                                {
                                    if (column.ColumnName != "RTRSN")
                                    {
                                        if (column.ColumnName != "ACCOUNTCODE")
                                        {
                                            if (column.ColumnName != "TXNCODE")
                                            {
                                                if (column.ColumnName != "REF")
                                                {
                                                    if (column.ColumnName == "Particulars")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;' colspan='1'  align='center'>");
                                                    }

                                                    else if (column.ColumnName == "HSN/SAC")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;' align='center'>");
                                                    }
                                                    else if (column.ColumnName == "GST Rate%")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='center'>");
                                                    }
                                                    else if (column.ColumnName == "TaxableVlu")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;width:8%;' align='center'>");
                                                    }
                                                    else if (column.ColumnName == "CGST Amt")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='center'>");
                                                    }
                                                    else if (column.ColumnName == "SGST Amt")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='center'>");
                                                    }

                                                    else if (column.ColumnName == "Total")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;width:8%;' align='center'>");
                                                    }
                                                    //else
                                                    //    {
                                                    //        sb1.Append("<th style ='font-size:11px;font-family:Verdana;' align='left'>");
                                                    //    }
                                                    if (column.ColumnName == "TaxableVlu")
                                                    {
                                                        sb1.Append("<b>Taxable Value</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                    else if (column.ColumnName == "CGST Amt")
                                                    {
                                                        sb1.Append("<b>CGST Amount</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                    else if (column.ColumnName == "SGST Amt")
                                                    {
                                                        sb1.Append("<b>SGST Amount</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                    else
                                                    {
                                                        sb1.Append("<b>" + column.ColumnName + "</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                }
                                            }
                                        }
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
                                    if (column.ColumnName != "#")
                                    {
                                        if (column.ColumnName != "RTRSN")
                                        {
                                            if (column.ColumnName != "ACCOUNTCODE")
                                            {
                                                if (column.ColumnName != "TXNCODE")
                                                {
                                                    if (column.ColumnName != "REF")
                                                    {
                                                        //if (column.ToString() == "#")
                                                        //{
                                                        //    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;'  align='center'>" + count + "");
                                                        //}
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
                            sb1.Append("<table border = '1' width='50%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
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


                            //StringReader sr1 = new StringReader(sb1.ToString());
                            StringReader sr2 = new StringReader(sb1.ToString());
                            StringBuilder sbBody = new StringBuilder();
                            //sbBody.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;font-size:14px;'>");
                            //sbBody.Append("<tr><td><b> Greetings,</b></td></tr>");
                            //sbBody.Append("<tr><td>Amount to pay for this Invoice:- <b>Rs." + Amount + " </b> .");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td>The Invoice(s) are attached.</b>");
                            //sbBody.Append("</td></tr>");
                            ////sbBody.Append("<tr><td>Kindly make arrangements to pay within 10 days of this mail.</td></tr>");
                            //sbBody.Append("<tr><td>With Best Regards,");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td><b>" + commnty + "</b></td></tr>");
                            //sbBody.Append("<tr><td>");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td> ");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td></td></tr>");
                            //sbBody.Append("<tr><td>The Invoice(s) in PDF Format and can be opened by Adobe ® Acrobat reader by clicking on the attachment.");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td></td></tr>");
                            //sbBody.Append("<tr style='font-family:Verdana;font-size:13px;'><td><b>This is an automatically generated mail from <a href='http://bincrm.com/oris/' title='Click here to open ORIS'>ORIS</a>, the software for Retirement Communities.</b></td></tr>");
                            //sbBody.Append("</table>");
                            //myMail.IsBodyHtml = true;
                            //myMail.Body = sbBody.ToString();
                            //myMail.Subject = invNo + "_" + Villa + "_" + Resident;
                            //sb1.Length = 0;
                            //sb1.Clear();
                            string FileName1 = invNo + "_" + Villa + "_" + Resident + "_" + NARATION + ".pdf";
                            //Document pdfDoc1 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                            Document pdfDoc2 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                            HttpContext.Current.Response.Clear();
                            HttpContext.Current.Response.ContentType = "application/pdf";
                            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + FileName1 + "");
                            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                            //HTMLWorker htmlparser1 = new HTMLWorker(pdfDoc1);
                            HTMLWorker htmlparser2 = new HTMLWorker(pdfDoc2);

                            using (MemoryStream memoryStream1 = new MemoryStream())
                            {

                                string replace = FileName1.Replace(@"/", "_");
                                //PdfWriter writer2 = PdfWriter.GetInstance(pdfDoc2, new FileStream(@"F:\Dhinesh\Files" + @"\" + replace, FileMode.Create));
                                PdfWriter writer2 = PdfWriter.GetInstance(pdfDoc2, Response.OutputStream);
                                //PdfWriter writer1 = PdfWriter.GetInstance(pdfDoc1, memoryStream1);                                
                                //pdfDoc1.Open();
                                //writer1.PageEvent = new Footer();                               
                                //htmlparser1.Parse(sr1);
                                //pdfDoc1.Close();

                                pdfDoc2.Open();
                                //writer2.PageEvent = new Footer();
                                htmlparser2.Parse(sr2);
                                pdfDoc2.Close();

                                Response.Write(pdfDoc2);
                                HttpContext.Current.Response.Flush();
                                byte[] bytes1 = memoryStream1.ToArray();
                                memoryStream1.Close();
                                File = replace;
                                //myMail.Attachments.Add(new Attachment(new MemoryStream(bytes1), FileName1));
                            }
                            UpdateTxn(Total);
                        }
                        //End
                        //mySmtpClient.Send(myMail);
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Invoice(s) generated successfully');", true);
                    }
                }
                dt.Dispose();
                dtPersonal.Dispose();
            }

        }


        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Something went wrong." + ex.Message + "'');", true);
        }
    }
    protected void CabInv(DataTable dt, DataTable dtPersonal)
    {
        try
        {
            string outstd = "";
            Amount = 0;
            Total = 0;
            CGSTAmt = 0;
            SGSTAmt = 0;
            DataTable dtNew = new DataTable();

            for (int i = 0; i < dtPersonal.Rows.Count; i++)
            {
                int count = 0;
                count = 0;
                System.Web.HttpResponse Response = System.Web.HttpContext.Current.Response;
                string mailserver = string.Empty;
                string user = string.Empty;
                string pwd = string.Empty;
                string sentby = string.Empty;
                string Email = string.Empty;

                //SqlCommand cmd = new SqlCommand("Proc_GetEmailCredentials", con);
                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                //DataSet dsCredential = new DataSet();
                //da.Fill(dsCredential);
                //// Write an informational entry to the event log.  

                //if (dsCredential != null && dsCredential.Tables.Count > 0)
                //{
                //    foreach (DataRow row in dsCredential.Tables[0].Rows)
                //    {
                //        mailserver = row["mailserver"].ToString();
                //        user = row["username"].ToString();
                //        pwd = row["password"].ToString();
                //        sentby = row["sentbyuser"].ToString();
                //        Email = row["Email"].ToString();
                //    }
                //}
                //MailId = Email;
                //SmtpClient mySmtpClient = new SmtpClient(mailserver, 587);
                //MailAddress From = new MailAddress(user, "info@innovatussystems.com");
                //MailMessage myMail = new System.Net.Mail.MailMessage();
                //myMail.From = From;
                //myMail.To.Add(Email);
                ////myMail.CC.Add("covaiproprarch@gmail.com");
                //mySmtpClient.UseDefaultCredentials = false;
                //System.Net.NetworkCredential basicauth = new System.Net.NetworkCredential(user, pwd);
                //mySmtpClient.Credentials = basicauth;
                //mySmtpClient.EnableSsl = false;
                //mySmtpClient.DeliveryMethod = System.Net.Mail.SmtpDeliveryMethod.Network;
                ////mySmtpClient.Timeout = 200000;
                //myMail.SubjectEncoding = System.Text.Encoding.UTF8;
                //myMail.BodyEncoding = System.Text.Encoding.UTF8;
                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        string Villa = dtPersonal.Rows[i]["Villa"].ToString();
                        string Resident = dtPersonal.Rows[i]["Name"].ToString();
                        string Adress = dtPersonal.Rows[i]["Address1"].ToString();
                        string Cty = dtPersonal.Rows[i]["Address3"].ToString();
                        string Accountcode = dtPersonal.Rows[i]["Accountcode"].ToString();
                        outstd = dtPersonal.Rows[i]["outstd"].ToString();
                        string strQuery = "Accountcode = '" + Accountcode + "'";

                        DateTime Odate = DateTime.Now;
                        string printedOn = Odate.ToString("dd-MMM-yyyy hh:mm tt");
                        string date = Odate.ToString("dd-MMM-yyyy");

                        //DINING INVOICE 
                        DataSet dstxn = sqlobj.ExecuteSP("SP_GETTXNCODEFORBILLING",
                           new SqlParameter() { ParameterName = "@TXNCODE", SqlDbType = SqlDbType.NVarChar, Value = "CB" }
                        );
                        string txncode = dstxn.Tables[0].Rows[0]["WHERE"].ToString();
                        txncode = txncode.Replace("/", "'");

                        DataTable dtservice = null;
                        string where = "txncode in (" + txncode + ") and Billno like '" + strBillNo + "%'";
                        string whr = strQuery + " and " + where;
                        DataSet dsDetails = new DataSet();
                        SqlCommand cmd1 = new SqlCommand("Proc_GetGST", con);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.Parameters.AddWithValue("@where", whr);
                        SqlDataAdapter dap = new SqlDataAdapter(cmd1);
                        dap.Fill(dsDetails, "temp");
                        string Bmonth = dsDetails.Tables[0].Rows[0]["BPName"].ToString();
                        string BFROM = dsDetails.Tables[0].Rows[0]["BPFROM"].ToString();
                        string BTILL = dsDetails.Tables[0].Rows[0]["BPTILL"].ToString();
                        int drows = dsDetails.Tables[0].Rows.Count;
                        //string whr1 = strQuery + " and txncode in (" + txncode + ") ";
                        string whr1 = strQuery;
                        DataRow[] drfilService = dt.Select(whr1);

                        if (drfilService.Any())
                        {
                            DataSet dsINVOICE = new DataSet();
                            dtservice = drfilService.CopyToDataTable();
                            invNo = dtservice.Rows[0]["InvoiceNo"].ToString();
                            string NARATION = dtservice.Rows[0]["Particulars"].ToString();
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
                            sb1.Append("Date: " + date + "");
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
                                if (column.ColumnName != "#")
                                {
                                    if (column.ColumnName != "RTRSN")
                                    {
                                        if (column.ColumnName != "ACCOUNTCODE")
                                        {
                                            if (column.ColumnName != "TXNCODE")
                                            {
                                                if (column.ColumnName != "REF")
                                                {
                                                    if (column.ColumnName == "Particulars")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;' colspan='1'  align='center'>");
                                                    }

                                                    else if (column.ColumnName == "HSN/SAC")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;' align='center'>");
                                                    }
                                                    else if (column.ColumnName == "GST Rate%")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='center'>");
                                                    }
                                                    else if (column.ColumnName == "TaxableVlu")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;width:8%;' align='center'>");
                                                    }
                                                    else if (column.ColumnName == "CGST Amt")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='center'>");
                                                    }
                                                    else if (column.ColumnName == "SGST Amt")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;'align='center'>");
                                                    }

                                                    else if (column.ColumnName == "Total")
                                                    {
                                                        sb1.Append("<td style ='font-size:11px;font-family:Verdana;width:8%;' align='center'>");
                                                    }
                                                    //else
                                                    //    {
                                                    //        sb1.Append("<th style ='font-size:11px;font-family:Verdana;' align='left'>");
                                                    //    }
                                                    if (column.ColumnName == "TaxableVlu")
                                                    {
                                                        sb1.Append("<b>Taxable Value</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                    else if (column.ColumnName == "CGST Amt")
                                                    {
                                                        sb1.Append("<b>CGST Amount</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                    else if (column.ColumnName == "SGST Amt")
                                                    {
                                                        sb1.Append("<b>SGST Amount</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                    else
                                                    {
                                                        sb1.Append("<b>" + column.ColumnName + "</b>");
                                                        sb1.Append("</td>");
                                                    }
                                                }
                                            }
                                        }
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
                                    if (column.ColumnName != "#")
                                    {
                                        if (column.ColumnName != "RTRSN")
                                        {
                                            if (column.ColumnName != "ACCOUNTCODE")
                                            {
                                                if (column.ColumnName != "TXNCODE")
                                                {
                                                    if (column.ColumnName != "REF")
                                                    {
                                                        //if (column.ToString() == "#")
                                                        //{
                                                        //    sb1.Append("<td style = 'font-size:8px;font-family:Verdana;'  align='center'>" + count + "");
                                                        //}
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
                            sb1.Append("<table border = '1' width='50%' BORDERCOLOR='#c6ccce' style='margin-left:15px;'>");
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


                            //StringReader sr1 = new StringReader(sb1.ToString());
                            StringReader sr2 = new StringReader(sb1.ToString());
                            StringBuilder sbBody = new StringBuilder();
                            //sbBody.Append("<table width='100%' cellspacing='5' cellpadding='5' style='font-family:Verdana;font-size:14px;'>");
                            //sbBody.Append("<tr><td><b> Greetings,</b></td></tr>");
                            //sbBody.Append("<tr><td>Amount to pay for this Invoice:- <b>Rs." + Amount + " </b> .");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td>The Invoice(s) are attached.</b>");
                            //sbBody.Append("</td></tr>");
                            ////sbBody.Append("<tr><td>Kindly make arrangements to pay within 10 days of this mail.</td></tr>");
                            //sbBody.Append("<tr><td>With Best Regards,");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td><b>" + commnty + "</b></td></tr>");
                            //sbBody.Append("<tr><td>");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td> ");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td></td></tr>");
                            //sbBody.Append("<tr><td>The Invoice(s) in PDF Format and can be opened by Adobe ® Acrobat reader by clicking on the attachment.");
                            //sbBody.Append("</td></tr>");
                            //sbBody.Append("<tr><td></td></tr>");
                            //sbBody.Append("<tr style='font-family:Verdana;font-size:13px;'><td><b>This is an automatically generated mail from <a href='http://bincrm.com/oris/' title='Click here to open ORIS'>ORIS</a>, the software for Retirement Communities.</b></td></tr>");
                            //sbBody.Append("</table>");
                            //myMail.IsBodyHtml = true;
                            //myMail.Body = sbBody.ToString();
                            //myMail.Subject = invNo + "_" + Villa + "_" + Resident;
                            //sb1.Length = 0;
                            //sb1.Clear();
                            string FileName1 = invNo + "_" + Villa + "_" + Resident + "_" + NARATION + ".pdf";
                            //Document pdfDoc1 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                            Document pdfDoc2 = new Document(PageSize.A4, 60f, 30f, 10f, 5f);
                            HttpContext.Current.Response.Clear();
                            HttpContext.Current.Response.ContentType = "application/pdf";
                            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + FileName1 + "");
                            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                            //HTMLWorker htmlparser1 = new HTMLWorker(pdfDoc1);
                            HTMLWorker htmlparser2 = new HTMLWorker(pdfDoc2);

                            using (MemoryStream memoryStream1 = new MemoryStream())
                            {

                                string replace = FileName1.Replace(@"/", "_");
                                //PdfWriter writer2 = PdfWriter.GetInstance(pdfDoc2, new FileStream(@"F:\Dhinesh\Files" + @"\" + replace, FileMode.Create));
                                PdfWriter writer2 = PdfWriter.GetInstance(pdfDoc2, Response.OutputStream);
                                //PdfWriter writer1 = PdfWriter.GetInstance(pdfDoc1, memoryStream1);                                
                                //pdfDoc1.Open();
                                //writer1.PageEvent = new Footer();                               
                                //htmlparser1.Parse(sr1);
                                //pdfDoc1.Close();

                                pdfDoc2.Open();
                                //writer2.PageEvent = new Footer();
                                htmlparser2.Parse(sr2);
                                pdfDoc2.Close();

                                Response.Write(pdfDoc2);
                                HttpContext.Current.Response.Flush();
                                byte[] bytes1 = memoryStream1.ToArray();
                                memoryStream1.Close();
                                File = replace;
                                //myMail.Attachments.Add(new Attachment(new MemoryStream(bytes1), FileName1));
                            }
                            UpdateTxn(Total);
                        }

                        //End


                        //mySmtpClient.Send(myMail);
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Invoice(s) generated successfully');", true);


                    }
                }
                dt.Dispose();
                dtPersonal.Dispose();
            }

        }


        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Something went wrong." + ex.Message + "'');", true);
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
    protected void btnClear_Click(object sender, EventArgs e)
    {
        clear();
    }

    protected void chkShow_CheckedChanged(object sender, EventArgs e)
    {
        if (cmbResident.SelectedValue == "0")
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Please select Resident');", true);
            chkShow.Checked = false;
            return;
        }
        if (chkShow.Checked == true)
        {
            btnGenerate.Visible = false;
            LoadAllBilled();
        }
        else
        {
            btnGenerate.Visible = true;
            LoadGrid();
        }

    }

    protected void lnkAudit_Click(object sender, EventArgs e)
    {
        Response.Redirect("InvoiceAuditLog.aspx", false);
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {

        if (cmbResident.SelectedIndex!=-1)
        {
            byte IsToRegenerate = 0;
            if (chkRegenerate.Checked == true)
            {
                IsToRegenerate = 1;
            }
            else { IsToRegenerate = 0; }
            Response.Redirect(String.Format("PreviewInvoiceNew.aspx?Resident={0}&Rgn={1}", cmbResident.SelectedValue.ToString(), IsToRegenerate));
        }
        else
        {
            WebMsgBox.Show("Please select the Resident!");
            return;
        }

    }

}