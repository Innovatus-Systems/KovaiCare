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

public partial class KitchenCharts : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    string itemcde = string.Empty;
    string monthdate = string.Empty;
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        string Itemtype = Request.QueryString["Item"];
        string Month = Request.QueryString["month"];

         itemcde = Convert.ToString(Session["item"]);
         monthdate = Convert.ToString(Session["date"]);

        ds = sqlobj.ExecuteSP("SP_GetDataForCharts",
                 new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@month", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Month.ToString() },
                 new SqlParameter() { ParameterName = "@Item", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Itemtype.ToString() });
        string group = ds.Tables[0].Rows[0]["Group"].ToString();
        string item = ds.Tables[0].Rows[0]["Item"].ToString();
        string uom = ds.Tables[0].Rows[0]["UOM"].ToString();
        string AvgVal = ds.Tables[0].Rows[0]["AvgVal"].ToString();
        lblAvgValueShow.Text = AvgVal;
        lblGrpShow.Text = group;
        lblItmShow.Text = Itemtype;
        lblmntShow.Text = Month;
        lblQty.Text = "Quantity in " + uom + " :";
        lblLabelRate.Text=item+"  Purchase Price Chart";
        lblLabelQuantity.Text = item + " Purchase Quantity Chart";
        // Bind Gridview  
        BindGvData();

        // Bind Charts  
        BindChart();

        //Bind Qty Charts
        BindQtyChart();

    }


    private void BindGvData()
    {
        grdview.DataSource = GetChartData();
        grdview.DataBind();

        rgQuantity.DataSource = GetChartData();
        rgQuantity.DataBind();
    }

    private void BindChart()
    {

        DataSet dsChartData = new DataSet();
        StringBuilder strScript = new StringBuilder();

        try
        {
            string Itemtype = Request.QueryString["Item"];
            string Month = Request.QueryString["month"];
            dsChartData = sqlobj.ExecuteSP("SP_GetDataForCharts",
                 new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@month", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Month.ToString() },
                 new SqlParameter() { ParameterName = "@Item", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Itemtype.ToString() });
            string group = dsChartData.Tables[0].Rows[0]["Group"].ToString();
            string item = dsChartData.Tables[0].Rows[0]["Item"].ToString();


            string AvgVal = dsChartData.Tables[0].Rows[0]["AvgVal"].ToString();
            lblAvgValueShow.Text = AvgVal;

            decimal AvgValue = Convert.ToDecimal(AvgVal);
            strScript.Append(@"<script type='text/javascript'>  
                    google.load('visualization', '1', {packages: ['corechart']});</script>  
  
                    <script type='text/javascript'>  
                    function drawVisualization() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['Days', 'Rate', {'type': 'string', 'role': 'style'}],");
           
            for (int i = 1; i <= 31; i++)
            {
                string columns = Convert.ToString(i);
                string check = dsChartData.Tables[0].Rows[0][columns].ToString();
                decimal value = Convert.ToDecimal(dsChartData.Tables[0].Rows[0][columns].ToString());
                

                if (value != 0)
                {
                    if (value > AvgValue)
                    {
                        strScript.Append("[" + i + "," + value + ", 'point { size: 8; shape-type: star; fill-color: Red; }'], ");
                    }
                    else
                    {
                        strScript.Append("[" + i + "," + value + ",null], ");
                    }
                }

            }


            strScript.Remove(strScript.Length - 1, 1);
            strScript.Append("]);");

            strScript.Append("var options = {vAxis: {title: 'Rate'},   hAxis: {title: 'Date'},pointSize: 08};");
            strScript.Append(" var chart = new google.visualization.LineChart(document.getElementById('chart_div'));  chart.draw(data, options); } google.setOnLoadCallback(drawVisualization);");
            strScript.Append(" </script>");

            ltrscr.Text = strScript.ToString();
        }
        catch (Exception e)
        {
            throw e;
        }
        finally
        {
            dsChartData.Dispose();
            strScript.Clear();
        }
    }

    private void BindQtyChart()
    {

        DataSet dsChartData = new DataSet();
        StringBuilder strScript = new StringBuilder();

        try
        {
            string Itemtype = Request.QueryString["Item"];
            string Month = Request.QueryString["month"];
            dsChartData = sqlobj.ExecuteSP("SP_GetDataForCharts",
                 new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
                 new SqlParameter() { ParameterName = "@month", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Month.ToString() },
                 new SqlParameter() { ParameterName = "@Item", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Itemtype.ToString() });
            string group = dsChartData.Tables[0].Rows[0]["Group"].ToString();
            string item = dsChartData.Tables[0].Rows[0]["Item"].ToString();


            string AvgVal = dsChartData.Tables[0].Rows[0]["AvgVal"].ToString();
            lblAvgValueShow.Text = AvgVal;
            decimal AvgValue = Convert.ToDecimal(AvgVal);
            strScript.Append(@"<script type='text/javascript'>  
                    google.load('visualization', '1', {packages: ['corechart']});</script>  
  
                    <script type='text/javascript'>  
                    function drawVisualization() {         
                    var data = google.visualization.arrayToDataTable([  
                    ['Days', 'Quantity'],");



            for (int i = 1; i <= 31; i++)
            {
                string columns = "Q" + Convert.ToString(i);
                decimal value = Convert.ToDecimal(dsChartData.Tables[0].Rows[0][columns].ToString());

                if (value != 0)
                {
                    if (value > AvgValue)
                    {
                        strScript.Append("[" + i + "," + value + "], ");
                    }
                    else
                    {
                        strScript.Append("[" + i + "," + value + "], ");
                    }
                }

            }


            strScript.Remove(strScript.Length - 1, 1);
            strScript.Append("]);");

            strScript.Append("var options = { vAxis: {title: 'Quantity'},   hAxis: {title: 'Date'}, pointSize: 08,pointShape: { type: 'Star', sides:4 }};");
            strScript.Append(" var chart = new google.visualization.LineChart(document.getElementById('chart_div1'));  chart.draw(data, options); } google.setOnLoadCallback(drawVisualization);");
            strScript.Append(" </script>");

            ltrscr1.Text = strScript.ToString();
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
        DataSet dsStatement = new DataSet();
        try
        {

            string Itemtype = Request.QueryString["Item"];
            string Month = Request.QueryString["month"];
            dsStatement = sqlobj.ExecuteSP("SP_GetDataForCharts",
                     new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 },
                     new SqlParameter() { ParameterName = "@month", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Month.ToString() },
                     new SqlParameter() { ParameterName = "@Item", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Itemtype.ToString() });
        }

        catch
        {
            throw;
        }
        return dsStatement.Tables[0];
    }
    protected void btnReturn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("VegCheckList.aspx?itemcode=" + itemcde + "&date=" + monthdate + "", false);
    }
}
