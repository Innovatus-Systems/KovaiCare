using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Drawing;
using Telerik.Web.UI;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.IO;

public partial class DailyFoodBillReport : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;

        if (!IsPostBack)
        {

            LoadTitle();
            CheckPermission();

            dsDT = proc.ExecuteSP("GetServerDateTime");

            // LoadBillingPeriod();

            //ddlBillingPeriod.SelectedValue = Session["CurrentBillingPeriod"].ToString();

            ReportList.DataSource = string.Empty;
            ReportList.DataBind();


            rgDiningSummaryBills.DataSource = string.Empty;
            rgDiningSummaryBills.DataBind();

            rgTCMBillSummary.DataSource = string.Empty;
            rgTCMBillSummary.DataBind();

            DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);


            dtpfordate.SelectedDate = sd;
            dtpuntildate.SelectedDate = DateTime.Now;

            LoadResidentDet();
            LoadAccountNo();

            //LoadGrid1();
        }
    }

   

    protected void LoadResidentDet()
    {
        try
        {

            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = 1 });
            cmbResident.DataSource = dsResident.Tables[0];
            cmbResident.DataValueField = "RTRSN";
            cmbResident.DataTextField = "RName";
            cmbResident.DataBind();

            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbResident.Items.Add(item2);

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }


    protected void LoadAccountNo()
    {
        try
        {
            if (cmbResident.SelectedValue == "0")
            {
                ddlAccountNumber.Items.Clear();
                ddlAccountNumber.Items.Add(new ListItem("All", "0"));
                ddlAccountNumber.Items.Add(new ListItem("G1000000", "1"));
                ddlAccountNumber.Items.Add(new ListItem("D1000000", "2"));

                //ddlAccountNumber.Items.Add("G1000000");
                //ddlAccountNumber.Items.Add("D1000000");
            }
            else
            {
                DataSet dsResident = new DataSet();

                dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                     new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });
                ddlAccountNumber.DataSource = dsResident.Tables[0];
                ddlAccountNumber.DataValueField = "AccountNo";
                ddlAccountNumber.DataTextField = "AccountNo";
                ddlAccountNumber.DataBind();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            if (cmbResident.SelectedValue == "0")
            {
                ddlAccountNumber.Items.Clear();
                ddlAccountNumber.Items.Add(new ListItem("All", "0"));
                ddlAccountNumber.Items.Add(new ListItem("G1000000", "1"));
                ddlAccountNumber.Items.Add(new ListItem("D1000000", "2"));
            }
            else
            {
                DataSet dsResident = new DataSet();

                dsResident = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                     new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });
                ddlAccountNumber.DataSource = dsResident.Tables[0];
                ddlAccountNumber.DataValueField = "AccountNo";
                ddlAccountNumber.DataTextField = "AccountNo";
                ddlAccountNumber.DataBind();
                ddlAccountNumber.Items.Add(new ListItem("All", "0"));

                dsResident.Dispose();


                DataSet dsResidentdetails = new DataSet();

                dsResidentdetails = sqlobj.ExecuteSP("SP_GenDropDownList",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 4 },
                     new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });


                if (dsResidentdetails.Tables[0].Rows.Count >0)
                {
                    lblDoorNo.Text = dsResidentdetails.Tables[0].Rows[0]["rtvillano"].ToString(); 
                    lblstatus.Text =  " ,"  + dsResidentdetails.Tables[0].Rows[0]["sdescription"].ToString();
                    lblaccountname.Text = " ,Billed To:" + dsResidentdetails.Tables[0].Rows[0]["accountname"].ToString();

                }

                dsResidentdetails.Dispose();


            }

            


        }
        catch (Exception ex)
        {

        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 46 });


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

    //protected void LoadBillingPeriod()
    //{
    //    try
    //    {

    //        DataSet ddlistBCode = new DataSet();

    //        ddlistBCode = sqlobj.ExecuteSP("SP_FetchBillingCodeDropDown",
    //             new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 });
    //        ddlBillingPeriod.DataSource = ddlistBCode.Tables[0];
    //        ddlBillingPeriod.DataValueField = "BPName";
    //        ddlBillingPeriod.DataTextField = "BPName";
    //        ddlBillingPeriod.DataBind();

    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }
    //}

    private void CheckPermission()
    {
        try
        {

            if (Session["UserID"] != null)
            {

                Permission p = new Permission();

                string result = p.GetPermission(Session["UserID"].ToString(), "ReportsandCharts");
                string result2 = p.GetPermission(Session["UserID"].ToString(), "ReportsandCharts");

                result = result.Trim();
                result2 = result.Trim();

                if ((result.ToString() == "Y"))
                {

                    Session["UserPermission"] = result.ToString();
                    //Response.Redirect("ResidentAdd.aspx");
                }
                else
                {
                    Response.Redirect("Homemenu.aspx");
                    WebMsgBox.Show("You have not permission to view resident module");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void DiningBillsSummary()
    {
        try
        {

            DataSet dsDiningBills = sqlobj.ExecuteSP("SP_DiningBillsSummary",
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue }
                   );
 

            if (dsDiningBills.Tables[0].Rows.Count >0)
            {
                rgDiningSummaryBills.DataSource = dsDiningBills;
                rgDiningSummaryBills.DataBind();
            }
            else
            {
                rgDiningSummaryBills.DataSource = string.Empty;
                rgDiningSummaryBills.DataBind();
            }


            dsDiningBills.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void TCMBillsSummary()
    {
        try
        {

            DataSet dsDiningBills = sqlobj.ExecuteSP("SP_TCMSummary",
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue }
                   );


            if (dsDiningBills.Tables[0].Rows.Count > 0)
            {
                rgTCMBillSummary.DataSource = dsDiningBills;
                rgTCMBillSummary.DataBind();
            }
            else
            {
                rgTCMBillSummary.DataSource = string.Empty;
                rgTCMBillSummary.DataBind();
            }


            dsDiningBills.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadGrid1()
    {

        try
        {
            string STR = cmbResident.SelectedValue;
            DataSet dsStatement = new DataSet();

            //DataSet dsStatement = sqlobj.ExecuteSP("SP_GetStatementofAccount",
            //       new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(cmbResident.SelectedValue.ToString()) },
            //       new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
            //       new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
            //       new SqlParameter() { ParameterName = "@AcccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue});

            if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetStatementofAccount",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" });

            }
            else if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "1")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetStatementofAccount",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
            }
            else if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "2")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetStatementofAccount",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
            }
            else if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue == "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetStatementofAccount",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 4 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
            }
            else if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue != "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_GetStatementofAccount",
                   new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 5 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
                   new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
            }


            ReportList.DataSource = dsStatement;
            ReportList.DataBind();

            //if (dsStatement.Tables[0].Rows.Count > 0)
            //{
            //    ReportList.DataSource = dsStatement;
            //    ReportList.DataBind();
            //}


            dsStatement.Dispose();

            //DataSet dsgetoutstanding = sqlobj.ExecuteSP("SP_GetResidentOutStanding",
            //           new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = rtrsn.ToString() });

            //if (dsgetoutstanding.Tables[0].Rows.Count > 0)
            //{

            //    decimal os = Convert.ToDecimal(dsgetoutstanding.Tables[0].Rows[0]["OutStanding2"].ToString());

            //    string sos = "0";

            //    if (os < 0)
            //    {
            //        os = Math.Abs(os);

            //        sos = os.ToString() + "CR";

            //    }
            //    else
            //    {
            //        sos = os.ToString();
            //    }


            //    lbloutstanding.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm") + " Current Outstandings as of now :" + sos.ToString();

            //    Session["Rstatus"] = dsgetoutstanding.Tables[0].Rows[0]["Status"].ToString();

            //    Session["RDescription"] = dsgetoutstanding.Tables[0].Rows[0]["sDescription"].ToString();
            //}

            //if (dsgetoutstanding.Tables[1].Rows.Count > 0)
            //{
            //    lbldepositamount.Text = "Deposit Amount : " + dsgetoutstanding.Tables[1].Rows[0]["DepositAmount"].ToString();
            //}

            //dsgetoutstanding.Dispose();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }


    protected void BtnShow_Click(object sender, EventArgs e)
    {

        try
        {
            string strrsnfilter =cmbResident.SelectedItem.Text;

            if (cmbResident.SelectedValue != "0")
            {

                string[] custrsn = strrsnfilter.Split(',');

                Session["RDoorNo"] = custrsn[1].ToString();

                Session["RName"] = custrsn[0].ToString();
            }

            //strrsnfilter = custrsn[3].ToString();

            //custrsn = strrsnfilter.Split(';');

            //Int32 rsn = Convert.ToInt32(custrsn[0].ToString());

            //Int32 rsn = Convert.ToInt32(cmbResident.SelectedValue);



            //Session["ResidentRSN"] = rsn.ToString();

            LoadGrid1();

            DiningBillsSummary();

            TCMBillsSummary();
        }
        catch (Exception ex)
        {

            WebMsgBox.Show(ex.ToString());

        }

    }


    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {

        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsStatementRPT = new DataSet();

        //DataSet dsStatement = sqlobj.ExecuteSP("SP_GetStatementofAccount",
        //           new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = Convert.ToInt32(cmbResident.SelectedValue.ToString())},
        //           new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
        //           new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
        //           new SqlParameter() { ParameterName = "@AcccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });

       

       
        if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "0")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetStatementofAccount",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = 1 },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NA" });

        }
        else if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "1")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetStatementofAccount",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
        }
        else if (cmbResident.SelectedValue == "0" && ddlAccountNumber.SelectedValue == "2")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetStatementofAccount",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 3 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
        }
        else if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue == "0")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetStatementofAccount",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 4 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
        }
        else if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue != "0")
        {
            dsStatementRPT = sqlobj.ExecuteSP("SP_GetStatementofAccount",
               new SqlParameter() { ParameterName = "@iMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 5 },
               new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
               new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
               new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue },
               new SqlParameter() { ParameterName = "@AccountNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAccountNumber.SelectedValue });
        }

        if (dsStatementRPT.Tables[0].Rows.Count > 0)
        {

            DataGrid dg = new DataGrid();

            dg.DataSource = dsStatementRPT.Tables[0];
            dg.DataBind();

            DateTime sdate = dtpfordate.SelectedDate.Value;
            DateTime edate = dtpuntildate.SelectedDate.Value;

            // THE EXCEL FILE.

            string sFileName = "";

            if (cmbResident.SelectedValue != "0")
            {
                sFileName = "Statement of Account - " + Session["RDoorNo"] + "_" + Session["RName"].ToString() + "  From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
            }
            else
            {
                 sFileName = "Statement of Account From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
            }

            //string sFileName = "Statement of Account From " + sdate.ToString("dd/MM/yyyy") + " To " + edate.ToString("dd/MM/yyyy") + ".xls";
            sFileName = sFileName.Replace("/", "");


            //string strstatus = Session["Rstatus"].ToString();
            string strstatus = "";
            string strdesc = "";


            if (strstatus.ToString() == "RS" || strstatus.ToString() == "TS")
            {
                strdesc = Session["RDescription"].ToString();
            }

            // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
            Response.ContentType = "application/vnd.ms-excel";
            EnableViewState = false;

            System.IO.StringWriter objSW = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

            dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
            dg.RenderControl(objHTW);


            //"," + strdesc.ToString() +

            if (cmbResident.SelectedValue != "0")
            {

                Response.Write("<table><tr><td>Statement of Account - " + Session["RDoorNo"] + "," + Session["RName"].ToString() + "," + strdesc.ToString() + "</td><td> From:" + sdate.ToString("dd/MM/yyyy") + "</td><td> To:" + edate.ToString("dd/MM/yyyy") + "</td></tr></table>");
            }

            else
            {
                Response.Write("<table><tr><td>Statement of Account From:" + sdate.ToString("dd/MM/yyyy") + "</td><td> To:" + edate.ToString("dd/MM/yyyy") + "</td></tr></table>");
            }
           
            //Response.Write("<table><tr><td>Statement of Account</td><td> From :" + sdate.ToString("dd/MM/yyyy") + "</td><td> To :" + edate.ToString("dd/MM/yyyy") + "</td></tr></table>");

            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
            Response.Write(objSW.ToString());


            Response.End();
            dg = null;


        }
        else
        {
            WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value + " statement does not exist");
        }

    }


    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid1();
    }

    protected void RMKPlanner_ItemClick(object sender, RadMenuEventArgs e)
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
    protected void rgDiningSummaryBills_Init(object sender, EventArgs e)
    {

    }
}