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

public partial class Age : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Bind Gridview  
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
        string dt = DateTime.Now.ToString("dd-MMM-yyyy HH:mm");
        dt = dt + " Hrs";
        DataTable dsChartData = new DataTable();
        StringBuilder strScript = new StringBuilder();

        try
        {
            dsChartData = GetChartData();

            strScript.Append(@"<script type='text/javascript'>  
                    google.load('visualization', '1', {packages: ['corechart']});</script>  
  
                    <script type='text/javascript'>  
                    function drawVisualization() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['Age', 'Male', 'Female'],");

            foreach (DataRow row in dsChartData.Rows)
            {
                strScript.Append("['" + row["AGE"] + "'," + row["M"] + "," +
                    row["F"] + "],");
            }
            strScript.Remove(strScript.Length - 1, 1);
            strScript.Append("]);");

            strScript.Append("var options = { title : 'Age Chart as of " + dt + " ', vAxis: {title: 'Count'},   hAxis: {title: 'Age Limit'}, seriesType: 'bars', series: {3: {type: 'area'}} };");
            strScript.Append(" var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));  chart.draw(data, options); } google.setOnLoadCallback(drawVisualization);");
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
        DataSet dsData = new DataSet();
        try
        {
            SqlConnection sqlCon = new SqlConnection(ConfigurationManager.ConnectionStrings["GCConnectionString"].ConnectionString);
            SqlDataAdapter sqlCmd = new SqlDataAdapter("chart_data", sqlCon);
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