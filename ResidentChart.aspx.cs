using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ResidentChart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindGvData();

        // Bind Charts  
        BindChart();
    }
    private void BindGvData()
    {
        grdview.DataSource = GetChartData();
        grdview.DataBind();
    }

    private void BindChart()
    {
        DataTable dsChartData = new DataTable();
        StringBuilder strScript = new StringBuilder();

        string dt = DateTime.Now.ToString("dd-MMM-yyyy");
        try
        {
            dsChartData = GetChartData();

            strScript.Append(@"<script type='text/javascript'>  
                    google.load('visualization', '1', {packages: ['corechart']});</script>  
  
                    <script type='text/javascript'>  
                    function drawVisualization() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['Resident Type',  'Count'],");

            foreach (DataRow row in dsChartData.Rows)
            {
                strScript.Append("['" + row["Resident"] + "'," + row["COUNT"] + "],");
            }
            strScript.Remove(strScript.Length - 1, 1);
            strScript.Append("]);");

            strScript.Append("var options = { title : 'Residence Status Chart as of " + dt + " ', vAxis: {title: 'Count'}, hAxis: {title: 'Resident Type'},is3D:true, };");
            strScript.Append(" var chart = new google.visualization.PieChart(document.getElementById('chart_div'));  chart.draw(data, options); } google.setOnLoadCallback(drawVisualization);");
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

    private DataTable GetChartData()
    {
        grdview.Visible = true;
        DataSet dsData = new DataSet();
        try
        {
            SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["GCConnectionString"].ConnectionString);
            SqlDataAdapter sqlCmd = new SqlDataAdapter("Chart_Resident", sqlCon);
            sqlCmd.SelectCommand.CommandType = CommandType.StoredProcedure;

            sqlCon.Open();

            sqlCmd.Fill(dsData);

            sqlCon.Close();
        }
        catch
        {
            throw;
        }
        return dsData.Tables[0];
    }
}