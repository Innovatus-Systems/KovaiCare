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


public partial class DayBook : System.Web.UI.Page
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
            DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
            dtpfordate.SelectedDate = DateTime.Now;
            dtpuntildate.SelectedDate = DateTime.Now;
            LoadResidentDet();
            LoadGrid();
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
            RadComboBoxItem item3 = new RadComboBoxItem();
            item3.Text = "All";
            item3.Value = "0";
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

            //if (dsStatement.Tables[0].Rows.Count > 0)
            //{
            //    //int rowindex = Convert.ToInt32(dsStatement.Tables[0].Rows.Count - 1);                   
            //    lblClosingbalval.Text = dsStatement.Tables[0].Rows[0]["Closing"].ToString();
            //}
            //else
            //{
            //    ReportList.DataSource = string.Empty;
            //    ReportList.DataBind();
            //}
            //if (dsStatement.Tables[1].Rows.Count > 0)
            //{
            //    lblDebitCnt.Text = dsStatement.Tables[1].Rows[0]["DR"].ToString();
            //}
            //if (dsStatement.Tables[2].Rows.Count > 0)
            //{
            //    lblCreditcnt.Text = dsStatement.Tables[2].Rows[0]["CR"].ToString();
            //}
            if (dsStatement.Tables[3].Rows.Count > 0)
            {
                lblCategory.Text = dsStatement.Tables[3].Rows[0]["AccountGroup"].ToString();
                lblSubGrp1.Text = dsStatement.Tables[3].Rows[0]["SubGroup1"].ToString();
                lblDis.Text = dsStatement.Tables[3].Rows[0]["AccountName"].ToString() + "-";
                lblDis.Visible = true;
                lblAccountCode.Visible = true;
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
            if (cmbResident.SelectedValue != "0")
            {
                DataSet dsResident = new DataSet();
                dsResident = sqlobj.ExecuteSP("SP_GeneralTransactions",
                     new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                     new SqlParameter() { ParameterName = "@AccountsMRSN", SqlDbType = SqlDbType.Decimal, Value = cmbResident.SelectedValue });
                lblAccountCode.Text = dsResident.Tables[0].Rows[0]["AccountCode"].ToString();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 145 });


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

    protected void LoadGrid()
    {
        try
        {
            string STR = cmbResident.SelectedValue;
            DataSet dsStatement = new DataSet();

          
                dsStatement = sqlobj.ExecuteSP("SP_DayBookData",
                   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }

                   );
           
            Session["Exportexcel"] = null;
            if (dsStatement.Tables[0].Rows.Count > 0)
            {
                ReportList.DataSource = dsStatement;
                ReportList.DataBind();
                Session["Exportexcel"] = dsStatement.Tables[0];
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
            }
            
            dsStatement.Dispose();
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

            if (cmbResident.SelectedValue != "0")
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
                
                ReportList.DataSource = dsStatement;
                ReportList.DataBind();
                Session["Exportexcel"] = dsStatement.Tables[0];
            }
            else
            {
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No data for your selection, Please try again for some other details.');", true);
                return;
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
            string strrsnfilter = cmbResident.SelectedItem.Text;


            if (cmbResident.SelectedValue != "0")
            {
                rdTrailBal.Visible = false;
                string[] custrsn = strrsnfilter.Split(',');
                Session["RName"] = custrsn[0].ToString();
                ReportList.DataSource = string.Empty;
                ReportList.DataBind();
                LoadGrid1();
            }
            if (cmbResident.SelectedValue == "0")
            {
                string STR = cmbResident.SelectedValue;
                DataSet dsStatement = new DataSet();
                dsStatement = sqlobj.ExecuteSP("SP_DayBookData",
                   new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                   new SqlParameter() { ParameterName = "@FromDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpfordate.SelectedDate },
                   new SqlParameter() { ParameterName = "@ToDate", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpuntildate.SelectedDate }
                   );
                Session["Exportexcel"] = null;
                if (dsStatement.Tables[0].Rows.Count > 0)
                {
                    ReportList.DataSource = dsStatement.Tables[0];
                    ReportList.DataBind();
                    
                    Session["Exportexcel"] = dsStatement.Tables[0];
                }
                else
                {
                    ReportList.DataSource = string.Empty;
                    ReportList.DataBind();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No data for your selection, Please try again for some other details.');", true);
                    return;
                }

                dsStatement.Dispose();
            }
        }


        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }


    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {
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
                sFileName = "Statement of Account -" + lblDis.Text.ToString() + sFileName;

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

                if (sdate == edate)
                {
                    Response.Write("<table style='font-weight:bold;font-size:16px;font-family:Verdana;'><tr><td>Day Book - </td><td> as of  :" + dateasof + "</td></tr><tr><td></td></tr></table>");
                }
                else
                {
                    Response.Write("<table style='font-weight:bold;font-size:16px;font-family:Verdana;'><tr><td>Day Book - </td><td>  From " + sdate.ToString("dd-MMM-yyyy") + "</td><td>  To " + edate.ToString("dd-MMM-yyyy") + "</td><td> as of  :" + dateasof + "</td></tr><tr><td></td></tr></table>");
                }
                
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
                WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value + " statement does not exist");
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('" + ex.ToString() + "');", true);
        }
    }


    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid1();
    }



}