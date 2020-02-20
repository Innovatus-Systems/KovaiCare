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

public partial class GeneralTransactions : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        if (!IsPostBack)
        {
            ReportList.Visible = false;
            LoadTitle();
            CheckPermission();           
            dsDT = proc.ExecuteSP("GetServerDateTime");
            ReportList.DataSource = string.Empty;
            ReportList.DataBind();
            //DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            //dtpfordate.SelectedDate = sd;
            //dtpuntildate.SelectedDate = DateTime.Now;
            LoadDate();
            LoadResidentDet();
            
        }
    }
    protected void LoadDate()
    {
        try
        {

            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_GETBILLINGDATE");
            dtpfordate.SelectedDate = Convert.ToDateTime(dsResident.Tables[0].Rows[0]["FROM"].ToString());
            dtpuntildate.SelectedDate = Convert.ToDateTime(dsResident.Tables[0].Rows[0]["TILL"].ToString());
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void LoadResidentDet()
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_GeneralTransactions",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });
            cmbResident.DataSource = dsResident.Tables[0];
            cmbResident.DataValueField = "AccountsMRSN";
            cmbResident.DataTextField = "AccountName";
            cmbResident.DataBind();           
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;           
            cmbResident.Items.Add(item2);

            RadComboBoxItem item3 = new RadComboBoxItem();
            item3.Text = "ALL";
            item3.Value = "1"; 
            item3.Selected = true;
            cmbResident.Items.Add(item3);

             
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void LoadOtherDet()
    {

        try
        {
            string STR = cmbResident.SelectedValue;

            ReportList.DataSource = string.Empty;
            ReportList.DataBind();
            DataSet dsStatement = new DataSet();

            if (cmbResident.SelectedValue != "0")
            {
                dsStatement = sqlobj.ExecuteSP("SP_SOAGeneralTransactions",
                   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@AccountCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = lblAccountCode.Text }
                   );
            }

            Session["Exportexcel"] = null;
            if (dsStatement.Tables[0].Rows.Count > 0)
            {
                //int rowindex = Convert.ToInt32(dsStatement.Tables[0].Rows.Count - 1);
                //lblClosingbalval.Visible = true;
                //lblClosingbal.Visible = true;
                //lblClosingbalval.Text = dsStatement.Tables[0].Rows[rowindex]["Closing"].ToString();
                ReportList.DataSource = dsStatement;
                ReportList.DataBind();
                Session["Exportexcel"] = dsStatement.Tables[0];
            }            

            if (dsStatement.Tables[1].Rows.Count > 0)
            {
                lblDebitCnt.Text = dsStatement.Tables[1].Rows[0]["DR"].ToString();
            }
            else
            {
                lblDebitCnt.Text = "-";
            }
            if (dsStatement.Tables[2].Rows.Count > 0)
            {
                lblCreditcnt.Text = dsStatement.Tables[2].Rows[0]["CR"].ToString();
            }
            else
            {
                lblCreditcnt.Text = "-";
            }
            if (dsStatement.Tables[3].Rows.Count > 0)
            {
                lblCategory.Text = dsStatement.Tables[3].Rows[0]["AccountGroup"].ToString();
                lblSubGrp1.Text = dsStatement.Tables[3].Rows[0]["SubGroup1"].ToString();
                lblDis.Text = dsStatement.Tables[3].Rows[0]["AccountName"].ToString() + "-";
                lblDis.Visible = true;
                lblAccountCode.Visible = true;
            }
            else
            {
                lblCategory.Text = "-";
                lblSubGrp1.Text = "-";
                lblDis.Visible = false;
                lblAccountCode.Visible = false;
            }
            if (dsStatement.Tables[4].Rows.Count > 0)
            {
                lblLastTxn.Text = dsStatement.Tables[4].Rows[0]["LastTxn"].ToString();
                //lblClosingbalval.Text = dsStatement.Tables[0].Rows[0]["AccountBalance"].ToString();   
            }

            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                lblClosingbalval.Text = "0.00";
                lblLastTxn.Text = "-";
            }

            if (dsStatement.Tables[5].Rows.Count > 0)
            {
                lblOpnBal.Text = dsStatement.Tables[5].Rows[0]["OpBal"].ToString();
            }
            else
            {
                lblOpnBal.Text = "0.00";
            }
            if (dsStatement.Tables[6].Rows.Count > 0)
            {
                lblClosingbalval.Text = dsStatement.Tables[6].Rows[0]["Closing"].ToString();
            }
            else
            {
                lblClosingbalval.Text = "0.00";
            }

            dsStatement.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
       
    
   

    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            ReportList.Visible = false;
            ReportList.DataSource = string.Empty;
            ReportList.DataBind();
            if (cmbResident.SelectedValue != "0")
            {
                DataSet dsResident = new DataSet();
                dsResident = sqlobj.ExecuteSP("SP_GeneralTransactions",
                     new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                     new SqlParameter() { ParameterName = "@AccountsMRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });
                if(cmbResident.SelectedValue != "0" && cmbResident.SelectedValue != "1")
                {
                    lblAccountCode.Text = dsResident.Tables[0].Rows[0]["AccountCode"].ToString();
                }
                else if (cmbResident.SelectedValue != "0" && cmbResident.SelectedValue == "1")
                {
                    lblAccountCode.Text = cmbResident.SelectedValue.ToString();
                }
                else
                {
                    lblAccountCode.Text = cmbResident.SelectedValue.ToString();
                }

                dsResident.Dispose();
                LoadOtherDet();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 132 });


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

    protected void LoadGrid1()
    {
        try
        {
            string STR = cmbResident.SelectedValue;
            DataSet dsStatement = new DataSet();       
           
            if (cmbResident.SelectedValue != "0" )
            {
                dsStatement = sqlobj.ExecuteSP("SP_SOAGeneralTransactions",
                   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate },
                   new SqlParameter() { ParameterName = "@AccountCode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = lblAccountCode.Text.ToString() }
                   );
            }
            Session["Exportexcel"] = null;
            if (dsStatement.Tables[0].Rows.Count > 0)
            {
                //int rowindex = Convert.ToInt32(dsStatement.Tables[0].Rows.Count - 1);
                //lblClosingbalval.Visible = true;
                //lblClosingbal.Visible = true;
                //lblClosingbalval.Text = dsStatement.Tables[0].Rows[rowindex]["Closing"].ToString();
                ReportList.DataSource = dsStatement;
                ReportList.DataBind();
                Session["Exportexcel"] = dsStatement.Tables[0];
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
            }
            //if (dsStatement.Tables[1].Rows.Count > 0)
            //{
            //    lblDebitCnt.Text = dsStatement.Tables[1].Rows[0]["DR"].ToString();
            //}
            //if (dsStatement.Tables[2].Rows.Count > 0)
            //{
            //    lblCreditcnt.Text = dsStatement.Tables[2].Rows[0]["CR"].ToString();
            //}
            dsStatement.Dispose();
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
            ReportList.Visible = true;
            string strrsnfilter = cmbResident.SelectedItem.Text;           
            if (cmbResident.SelectedValue != "0" && cmbResident.SelectedValue != "1")
            {
                rdTrailBal.Visible = false ;               
                string[] custrsn = strrsnfilter.Split(',');
                Session["RName"] = custrsn[0].ToString();           
                lblClosingbal.Visible = true;
                lblClosingbalval.Visible = true;
                //LoadGrid1();
                LoadOtherDet();
            }
            else if (cmbResident.SelectedValue != "0" && cmbResident.SelectedValue == "1")
            {

                LoadGrid1();
                 
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('There is no Transaction for selected date range!');", true);
            }
  
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }


    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        try { 
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsStatementRPT = new DataSet();        
        //if (cmbResident.SelectedValue != "0" && ddlAccountNumber.SelectedValue != "0")
        //{
        //    dsStatementRPT = Session["Exportexcel"];
        //}
        if (Session["Exportexcel"] != null)
        {

            DataGrid dg = new DataGrid();

            dg.DataSource = Session["Exportexcel"];
            dg.DataBind();
            DateTime sdate = dtpfordate.SelectedDate.Value;
             DateTime edate = dtpuntildate.SelectedDate.Value;
            // THE EXCEL FILE.
            string date = DateTime.Now.ToString("dd-MM-yyyy-hh-mm");
            string dateasof = DateTime.Now.ToString("dd-MMM-yyyy hh:mm");
            dateasof = dateasof + " Hrs";
            string sFileName = date;
            sFileName = sFileName.Replace("-", "");
            sFileName = "Statement of Account -"+ lblDis.Text.ToString() + sFileName;           

            // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=" + sFileName + ".xls");
            Response.ContentType = "application/vnd.ms-excel";
            EnableViewState = false;

            System.IO.StringWriter objSW = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

            dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
            dg.RenderControl(objHTW);


            Response.Write("<table style='font-weight:bold;font-size:12px;font-family:Verdana;'><tr><td>Statement of Account -</td><td>  From " + sdate.ToString("dd-MMM-yyyy") + "</td><td>  Till " + edate.ToString("dd-MMM-yyyy") + "</td><td> Printed on  :" + dateasof + "</td></tr><tr><td></td></tr></table>");
            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:soild 1px #999; } " +
                "TD { border:soild 1px #D5D5D5; text-align:center } </style>");
            Response.Write("<table><tr><td>");
            Response.Write(objSW.ToString());
            Response.Write("</td></tr></table>");
            Response.End();
            dg = null;
        }
        else
        {
            WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " Till " + dtpuntildate.SelectedDate.Value + " statement does not exist");
        }
        }
        catch(Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.ToString() + "');", true);
        }
    }


    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid1();
    }

    //protected void rdSubGrp2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    //{

    //}
   
}