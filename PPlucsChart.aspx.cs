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

public partial class PPlucsChart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataSet dsData = new DataSet();
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["GCConnectionString"].ConnectionString);
            SqlCommand cmd = new SqlCommand("Chart_PPLUS", con);
            cmd.Parameters.Add("@IMODE", SqlDbType.VarChar).Value = '1';
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            try
            {
                if (con.State == ConnectionState.Closed)
                    con.Open();
                adp.Fill(dt);
                if (dt.Rows.Count > 0)
                {

                    DRPGROUP.DataSource = dt;
                    DRPGROUP.DataTextField = "RAGROUP";
                    DRPGROUP.DataValueField = "RAGROUP";
                    DRPGROUP.DataBind();
                    DRPGROUP.Items.Insert(0, new ListItem("Please Select", ""));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }


        }

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

        string dt = DateTime.Now.ToString("dd-MMM-yyyy HH:mm");
        dt = dt + " Hrs";
        try
        {
            dsChartData = GetChartData();

            strScript.Append(@"<script type='text/javascript'>  
                    google.load('visualization', '1', {packages: ['corechart']});</script>  
  
                    <script type='text/javascript'>  
                    function drawVisualization() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['STATUS',  'COUNT'],");

            foreach (DataRow row in dsChartData.Rows)
            {
                strScript.Append("['" + row["STATUS"] + "'," + row["COUNT"] + "],");
            }
            strScript.Remove(strScript.Length - 1, 1);
            strScript.Append("]);");

            strScript.Append("var options = { title : 'P++ Detailed Chart as of " + dt + " ', vAxis: {title: 'COUNT'}, hAxis: {title: 'STATUS'}, seriesType: 'bars', series: {3: {type: 'area'}},colors: ['blue', 'red', 'green', 'yellow', 'gray'], };");
            strScript.Append(" var chart = new google.visualization.PieChart(document.getElementById('chart_div'));  chart.draw(data, options); } google.setOnLoadCallback(drawVisualization);");
            strScript.Append(" </script>");

            ltrscr.Text = strScript.ToString();
            //                      var chart = new google.visualization.BarChart(document.getElementById('visualization'));
            //chart.draw(data, {isStacked: true, width: 400, height: 240, title: 'Company Performance',
            //                            vAxis: {title: 'Year', titleTextStyle: {color: 'red'}},
            //                            series: [{color: 'blue', visibleInLegend: true}, {color: 'red', visibleInLegend: false}]
            //                           });
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
            SqlDataAdapter sqlCmd = new SqlDataAdapter("Chart_PPLUS", sqlCon);
            sqlCmd.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlCmd.SelectCommand.Parameters.Add("@IMODE", SqlDbType.VarChar).Value = '3';
            sqlCmd.SelectCommand.Parameters.Add("@GROUP", SqlDbType.VarChar).Value = DRPGROUP.SelectedValue;
            sqlCmd.SelectCommand.Parameters.Add("@CODE", SqlDbType.VarChar).Value = DRPCODE.SelectedValue;
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

    protected void BTNSEARCH_Click(object sender, EventArgs e)
    {

        if (DRPGROUP.SelectedValue == "")
        {
            Response.Write("<script>alert('Please Select Group.');</script>");
            return;
        }
        else if (DRPCODE.SelectedValue == "")
        {
            Response.Write("<script>alert('Please Select Code.');</script>");
            return;
        }
        // Bind Gridview  
        BindGvData();

        // Bind Charts  
        BindChart();

        grdview.Visible = true;
    }

    protected void DRPGROUP_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataSet dsData = new DataSet();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["GCConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("Chart_PPLUS", con);
        cmd.Parameters.Add("@IMODE", SqlDbType.VarChar).Value = '2';
        cmd.Parameters.Add("@GROUP", SqlDbType.VarChar).Value = DRPGROUP.SelectedValue.ToString();
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adp = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        try
        {
            if (con.State == ConnectionState.Closed)
                con.Open();

            adp.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                // DRPCODE.Items.Insert(-1, new ListItem("Please Select", ""));
                DRPCODE.DataSource = dt;
                DRPCODE.DataTextField = "RACODE";
                DRPCODE.DataValueField = "RACODE";
                DRPCODE.DataBind();
                DRPCODE.Items.Insert(0, new ListItem("Please Select", ""));
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
}