using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
//using System.Security.Cryptography.Xml;
using System.Net;
using System.Net.Security;
using System.Diagnostics;
using System.IO;
using System.ComponentModel;

public partial class ExcessShrtgeRpt : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            rgDinBkng.DataSource = string.Empty;
            rgDinBkng.DataBind();
            LoadDate();
            LoadTitle();
            LoadSession();
            LoadData();
           
        }
    }   
    private void LoadSession()
    {
        DataSet dsFetchSE = new DataSet();
        try
        {
            
                dsFetchSE = sqlobj.ExecuteSP("SP_GetSessionforDining",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
                drpSession.DataSource = dsFetchSE.Tables[0];
                drpSession.DataValueField = "SessionCode";
                drpSession.DataTextField = "SessionName";
                drpSession.DataBind();
                drpSession.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));                
                dsFetchSE.Dispose();
            //}
            //else
            //{
            //    dsFetchSE = sqlobj.ExecuteSP("SP_GetSessionforDining",
            //        new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 });
            //    drpSession.DataSource = dsFetchSE.Tables[0];
            //    drpSession.DataValueField = "SessionCode";
            //    drpSession.DataTextField = "SessionName";
            //    drpSession.DataBind();
            //    drpSession.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", "0"));
            //    dsFetchSE.Dispose();
            //}
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 151 });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadDate()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("Sp_ExcessShrtgeRpt", new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                rdtFrom.SelectedDate = DateTime.Parse(dsTitle.Tables[0].Rows[0]["From"].ToString());
                rdtTill.SelectedDate = DateTime.Parse(dsTitle.Tables[0].Rows[0]["Till"].ToString());
            }
            dsTitle.Dispose();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadData()
    {
        try
        {
            DataSet ds = new DataSet();
            if (rdtFrom.SelectedDate > rdtTill.SelectedDate)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select Till date greater then or equal to From date.');", true);
                return;
            }
            if(drpSession.SelectedValue=="0")
            {
                ds = sqlobj.ExecuteSP("Sp_ExcessShrtgeRpt",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3},
                     new SqlParameter() { ParameterName = "@FDate", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
                     new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate }
                    );
            }
            else
            {
             ds = sqlobj.ExecuteSP("Sp_ExcessShrtgeRpt",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 },
                     new SqlParameter() { ParameterName = "@FDate", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
                     new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate },
                     new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue }
                    );
            }
            
            if (ds.Tables[0].Rows.Count > 0)
            {
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
            }
            else
            {
                rgDinBkng.DataSource = string.Empty;
                rgDinBkng.DataBind();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No Records.');", true);
            }
            BindChart();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void drpSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (drpSession.SelectedValue == "0")
            {

            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadData();
    }

    protected void rgDinBkng_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgDinBkng.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
    private void BindChart()
    {
        string dt = DateTime.Now.ToString("dd-MMM-yyyy HH:mm");
        dt = dt + " Hrs";
        DataTable dsChartData = new DataTable();
        StringBuilder strScript = new StringBuilder();

        try
        {
            dsChartData = GetData();

            strScript.Append(@"<script type='text/javascript'>  
                    google.load('visualization', '1', {packages: ['corechart']});</script>  
  
                    <script type='text/javascript'>  
                    function drawVisualization() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['Dt4Charts', 'Total', 'Actual'],");

            foreach (DataRow row in dsChartData.Rows)
            {
                strScript.Append("['" + row["Dt4Charts"] + "'," + row["Total"] + "," + row["Actual"] + "],");
            }
            strScript.Remove(strScript.Length - 1, 1);
            strScript.Append("]);");

            strScript.Append("var options = { title : 'Total Vs Actual Chart ', vAxis: {title: 'Count'},  hAxis: {title: 'Date'}, seriesType: 'bars', series: {3: {type: 'area'}} };");
            strScript.Append(" var chart = new google.visualization.ComboChart(document.getElementById('chart_div')); chart.draw(data, options); } google.setOnLoadCallback(drawVisualization);");
            strScript.Append(" </script>");

            ltrscr.Text = strScript.ToString();
        }
        catch
        {
        }
        finally
        {
            dsChartData.Dispose();
            strScript.Clear();
        }
    }

//    private void BindChart()
//    {
//        string dt = DateTime.Now.ToString("dd-MMM-yyyy HH:mm");
//        dt = dt + " Hrs";
//        DataTable dsChartData = new DataTable();
//        StringBuilder strScript = new StringBuilder();

//        try
//        {
//            dsChartData = GetData();

//            strScript.Append(@"<script type='text/javascript'>  
//                     $(function Chart() {          
//                        var sampleData = [");

//            foreach (DataRow row in dsChartData.Rows)
//            {
//                strScript.Append("{Date:'" + row["Date"] + "',Total:'" + row["Total"] + "',Actual:'" + row["Actual"] + "'},");
//            }
//            strScript.Remove(strScript.Length - 1, 1);
//            strScript.Append("];");

//            strScript.Append("var settings = { title: 'Total Vs Actual',description: 'Excess / Shortage Report', padding: { left: 5, top: 5, right: 5, bottom: 0 },titlePadding: { left: 90, top: 0, right: 0, bottom: 10 },source: sampleData,");
//            strScript.Append("xAxis:{ dataField: 'Date', gridLines: { visible: false },tickMarks: { visible: true }},valueAxis:{minValue: 20,maxValue: 250,unitInterval: 20,title: { text: 'Count' }},colorScheme: 'scheme01',");
//            strScript.Append("seriesGroups:[{type: 'column',columnsGapPercent: 30,seriesGapPercent: 10, series: [{ dataField: 'Total', displayText: 'Total' },{ dataField: 'Actual', displayText: 'Actual' }]}]};");    
//            strScript.Append("$('#chartContainer').jqxChart(settings);");    
//            strScript.Append("});");
//            strScript.Append(" </script>");
//            ltrscr.Text = strScript.ToString();
//        }
//        catch
//        {
//        }
//        finally
//        {
//            dsChartData.Dispose();
//            strScript.Clear();
//        }
//    }
    private DataTable GetData()
    {
        DataSet dsData = new DataSet();
        try
        {

            if (drpSession.SelectedValue == "0")
            {
                dsData = sqlobj.ExecuteSP("Sp_ExcessShrtgeRpt",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                     new SqlParameter() { ParameterName = "@FDate", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
                     new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate }
                    );
            }
            else
            {
                dsData = sqlobj.ExecuteSP("Sp_ExcessShrtgeRpt",
                       new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 },
                        new SqlParameter() { ParameterName = "@FDate", SqlDbType = SqlDbType.DateTime, Value = rdtFrom.SelectedDate },
                        new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = rdtTill.SelectedDate },
                        new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue }
                       );
            }
        }
        catch
        {
            throw;
        }
        return dsData.Tables[0];
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("DinnersBooking.aspx");
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
}