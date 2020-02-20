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

public partial class Charts : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CheckPermission();

            LoadTitle();


            RadChartLoad();
            RadChartLoad1();
            RadChartLoad2();
            RadChartLoad3();
            RadChartLoad4();
            RadChartLoad5();
            LoadGridChart();
            LoadGridChart1();
            LoadGridChart2();
            LoadGridChart3();
            LoadGridChart4();
            LoadGridChart5();
           
           
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 78 });


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
    protected void RadChartLoad()
    {
        SqlCommand cmd = new SqlCommand("SP_GetChartData_MaleFemale", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        DataSet dsChart = new DataSet();
        GenderChart.DataBind();

        

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsChart);
        if (dsChart != null && dsChart.Tables.Count > 0 && dsChart.Tables[0].Rows.Count > 0)
        {

            GenderChart.DataSource = dsChart.Tables[0];
            GenderChart.DataBind();
            GenderChart.BackColor = Color.FloralWhite;
        }
        else
        {
            GenderChart.DataSource = new String[] { };
            GenderChart.DataBind();
        }

    }
    protected void LoadGridChart()
    {
        SqlCommand cmd = new SqlCommand("SP_GetGridData_Charts", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 2;
        DataSet dsGrid = new DataSet();
        GenderGrid.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            GenderGrid.DataSource = dsGrid.Tables[0];
            GenderGrid.DataBind();

        }
        else
        {
            GenderGrid.DataSource = new String[] { };
            GenderGrid.DataBind();
        }

    }
    protected void GenderGrid_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LoadGridChart();
    }
    protected void GenderGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGridChart();
    }
    protected void GenderGrid_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadGridChart();
    }
    protected void GenderGrid_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        LoadGridChart();
    }

    protected void RadChartLoad1()
    {
        SqlCommand cmd = new SqlCommand("[SP_GetChartData_Occupants]", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        DataSet dsChart = new DataSet();
        OccupantChart.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsChart);
        if (dsChart != null && dsChart.Tables.Count > 0 && dsChart.Tables[0].Rows.Count > 0)
        {

            OccupantChart.DataSource = dsChart.Tables[0];
            OccupantChart.DataBind();
            OccupantChart.BackColor = Color.FloralWhite;

        }
        else
        {
            OccupantChart.DataSource = new String[] { };
            OccupantChart.DataBind();
        }

    }

    protected void LoadGridChart1()
    {
        SqlCommand cmd = new SqlCommand("SP_GetGridData_Charts", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 3;
        DataSet dsGrid = new DataSet();
        OccupantsGrid.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            OccupantsGrid.DataSource = dsGrid.Tables[0];
            OccupantsGrid.DataBind();

        }
        else
        {
            OccupantsGrid.DataSource = new String[] { };
            OccupantsGrid.DataBind();
        }

    }
    protected void OccupantsGrid_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        LoadGridChart1();
    }
    protected void OccupantsGrid_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGridChart1();
    }
    protected void OccupantsGrid_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        LoadGridChart1();
    }
    protected void OccupantsGrid_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        LoadGridChart1();
    }

    protected void RadChartLoad2()
    {
        SqlCommand cmd = new SqlCommand("SP_GetChartData_Status", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        DataSet dsChart = new DataSet();
        ORTChart.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsChart);
        if (dsChart != null && dsChart.Tables.Count > 0 && dsChart.Tables[0].Rows.Count > 0)
        {

            ORTChart.DataSource = dsChart.Tables[0];
            ORTChart.DataBind();
            ORTChart.BackColor = Color.FloralWhite;

        }
        else
        {
            ORTChart.DataSource = new String[] { };
            ORTChart.DataBind();
        }

    }

    protected void LoadGridChart2()
    {
        SqlCommand cmd = new SqlCommand("SP_GetGridData_Charts", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        DataSet dsGrid = new DataSet();
        StatusGrid.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            StatusGrid.DataSource = dsGrid.Tables[0];
            StatusGrid.DataBind();

        }
        else
        {
            StatusGrid.DataSource = new String[] { };
            StatusGrid.DataBind();
        }

    }
    protected void StatusGrid_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadGridChart2();
    }
    protected void StatusGrid_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadGridChart2();
    }
    protected void StatusGrid_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadGridChart2();
    }
    protected void StatusGrid_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGridChart2();
    }
    protected void LoadGridChart3()
    {
        SqlCommand cmd = new SqlCommand("SP_GetGridData_Charts", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 4;
        DataSet dsGridA = new DataSet();
        StatusGridA.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGridA);
        if (dsGridA != null && dsGridA.Tables.Count > 0 && dsGridA.Tables[0].Rows.Count > 0)
        {

            StatusGridA.DataSource = dsGridA.Tables[0];
            StatusGridA.DataBind();

        }
        else
        {
            StatusGridA.DataSource = new String[] { };
            StatusGridA.DataBind();
        }

    }

    protected void StatusGridA_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadGridChart3();
    }
    protected void StatusGridA_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGridChart3();
    }
    protected void StatusGridA_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadGridChart3();
    }
    protected void StatusGridA_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadGridChart3();
    }

    protected void RadChartLoad3()
    {
        SqlCommand cmd = new SqlCommand("SP_GetChartData_StatusA", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        DataSet dsChartA = new DataSet();
        OROAVChart.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsChartA);
        if (dsChartA != null && dsChartA.Tables.Count > 0 && dsChartA.Tables[0].Rows.Count > 0)
        {

            OROAVChart.DataSource = dsChartA.Tables[0];
            OROAVChart.DataBind();
            OROAVChart.BackColor = Color.FloralWhite;




        }
        else
        {
            OROAVChart.DataSource = new String[] { };
            OROAVChart.DataBind();
        }

    }

    protected void RadChartLoad4()
    {
        SqlCommand cmd = new SqlCommand("SP_GetChartData_Male", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        DataSet dsChartMale = new DataSet();
        RadMaleChart.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsChartMale);
        if (dsChartMale != null && dsChartMale.Tables.Count > 0 && dsChartMale.Tables[0].Rows.Count > 0)
        {

            RadMaleChart.DataSource = dsChartMale.Tables[0];
            RadMaleChart.DataBind();
            RadMaleChart.BackColor = Color.FloralWhite;




        }
        else
        {
            RadMaleChart.DataSource = new String[] { };
            RadMaleChart.DataBind();
        }

    }


    protected void MaleRatioGrid_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadGridChart4();
    }
    protected void MaleRatioGrid_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGridChart4();
    }
    protected void MaleRatioGrid_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadGridChart4();
    }
    protected void MaleRatioGrid_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadGridChart4();
    }
    protected void LoadGridChart4()
    {
        SqlCommand cmd = new SqlCommand("SP_GetGridData_Charts", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 5;
        DataSet dsChartMale = new DataSet();
        MaleRatioGrid.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsChartMale);
        if (dsChartMale != null && dsChartMale.Tables.Count > 0 && dsChartMale.Tables[0].Rows.Count > 0)
        {

            MaleRatioGrid.DataSource = dsChartMale.Tables[0];
            MaleRatioGrid.DataBind();

        }
        else
        {
            MaleRatioGrid.DataSource = new String[] { };
            MaleRatioGrid.DataBind();
        }

    }
    protected void FemaleRatioGrid_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

    }
    protected void FemaleRatioGrid_ItemCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void FemaleRatioGrid_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {

    }
    protected void FemaleRatioGrid_SortCommand(object sender, GridSortCommandEventArgs e)
    {

    }

    protected void LoadGridChart5()
    {
        SqlCommand cmd = new SqlCommand("[SP_GetGridData_Charts]", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 6;
        DataSet dsChartFeMale = new DataSet();
        FemaleRatioGrid.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsChartFeMale);
        if (dsChartFeMale != null && dsChartFeMale.Tables.Count > 0 && dsChartFeMale.Tables[0].Rows.Count > 0)
        {

            FemaleRatioGrid.DataSource = dsChartFeMale.Tables[0];
            FemaleRatioGrid.DataBind();

        }
        else
        {
            FemaleRatioGrid.DataSource = new String[] { };
            FemaleRatioGrid.DataBind();
        }

    }

    protected void RadChartLoad5()
    {
        SqlCommand cmd = new SqlCommand("SP_GetChartData_FeMale", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        DataSet dsChartFeMale = new DataSet();
        RadFeMaleChart.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsChartFeMale);
        if (dsChartFeMale != null && dsChartFeMale.Tables.Count > 0 && dsChartFeMale.Tables[0].Rows.Count > 0)
        {

            RadFeMaleChart.DataSource = dsChartFeMale.Tables[0];
            RadFeMaleChart.DataBind();
            RadFeMaleChart.BackColor = Color.FloralWhite;




        }
        else
        {
            RadFeMaleChart.DataSource = new String[] { };
            RadFeMaleChart.DataBind();
        }

    }
   
}