using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;


public partial class DiningReport : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadTitle();

            gvCount.DataSource = string.Empty;
            gvCount.DataBind();

            gvMenu.DataSource = string.Empty;
            gvMenu.DataBind();

            gvBooking.DataSource = string.Empty;
            gvBooking.DataBind();

            gvBooking2.DataSource = string.Empty;
            gvBooking2.DataBind();
            
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 55 });


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

    private void LoadDinersReport()
    {
        try
        {


            DataSet dsFetchSE = sqlobj.ExecuteSP("SP_EstimateDinersandQty",
                 new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = radfromdate.SelectedDate });


            DateTime sdate = Convert.ToDateTime(radfromdate.SelectedDate);

            string sday = sdate.ToString("ddd");


            if (dsFetchSE.Tables[0].Rows.Count>0)
            {
                lblcdate.Text = "For " + sday.ToString() + " , " + sdate.ToString("dd/MM/yyyy");

                gvCount.DataSource = dsFetchSE.Tables[0];
                gvCount.DataBind();
            }
            else
            {
                gvCount.DataSource = string.Empty;
                gvCount.DataBind();
            }

            if (dsFetchSE.Tables[1].Rows.Count>0)
            {

                lblmdate.Text = "For " + sday.ToString() + " , " + sdate.ToString("dd/MM/yyyy");

                gvMenu.DataSource = dsFetchSE.Tables[1];
                gvMenu.DataBind();

            }
            else
            {
                gvMenu.DataSource = string.Empty;
                gvMenu.DataBind();
            }

            if (dsFetchSE.Tables[2].Rows.Count>0)
            {
                

                lblb1date.Text = "For " + sday.ToString() + " , " + sdate.ToString("dd/MM/yyyy");

                gvBooking.DataSource = dsFetchSE.Tables[2];
                gvBooking.DataBind();

            }
            else
            {
                gvBooking.DataSource = string.Empty;
                gvBooking.DataBind();
            }

            if (dsFetchSE.Tables[3].Rows.Count > 0)
            {

             

                lblb2date.Text = "For " + sday.ToString() + " , " + sdate.ToString("dd/MM/yyyy");

                gvBooking2.DataSource = dsFetchSE.Tables[3];
                gvBooking2.DataBind();

            }
            else
            {
                gvBooking2.DataSource = string.Empty;
                gvBooking2.DataBind();
            }


        }
        catch(Exception ex)
        {

        }
    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {

            LoadDinersReport();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {

           DateTime sdate = Convert.ToDateTime(radfromdate.SelectedDate);

            gvCount.ExportSettings.ExportOnlyData = true;
            gvCount.ExportSettings.FileName = "Diners Count for " + sdate.ToString();
            gvCount.MasterTableView.Caption = "Diners Count Report";
            gvCount.MasterTableView.Font.Name = "verdana";
            gvCount.MasterTableView.Font.Size = 12;
            gvCount.ExportSettings.IgnorePaging = true;
            gvCount.ExportSettings.OpenInNewWindow = true;
            gvCount.MasterTableView.ExportToExcel();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnMenuExport_Click(object sender, EventArgs e)
    {
        try
        {

            DateTime sdate = Convert.ToDateTime(radfromdate.SelectedDate);

            gvMenu.ExportSettings.ExportOnlyData = true;
            gvMenu.ExportSettings.FileName = "Menu for " + sdate.ToString();
            gvMenu.MasterTableView.Caption = "Menu for " + sdate.ToString();
            gvMenu.MasterTableView.Font.Name = "verdana";
            gvMenu.MasterTableView.Font.Size = 12;
            gvMenu.ExportSettings.IgnorePaging = true;
            gvMenu.ExportSettings.OpenInNewWindow = true;
            gvMenu.MasterTableView.ExportToExcel();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSWExport_Click(object sender, EventArgs e)
    {
        try
        {

            DateTime sdate = Convert.ToDateTime(radfromdate.SelectedDate);

            gvBooking.ExportSettings.ExportOnlyData = true;
            gvBooking.ExportSettings.FileName = "A la carte menu for " + sdate.ToString();
            gvBooking.MasterTableView.Caption = "A la carte menu for " + sdate.ToString();
            gvBooking.MasterTableView.Font.Name = "verdana";
            gvBooking.MasterTableView.Font.Size = 12;
            gvBooking.ExportSettings.IgnorePaging = true;
            gvBooking.ExportSettings.OpenInNewWindow = true;
            gvBooking.MasterTableView.ExportToExcel();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnIWExport_Click(object sender, EventArgs e)
    {
        try
        {

            DateTime sdate = Convert.ToDateTime(radfromdate.SelectedDate);

            gvBooking2.ExportSettings.ExportOnlyData = true;
            gvBooking2.ExportSettings.FileName = "A la carte menu for " + sdate.ToString();
            gvBooking2.MasterTableView.Caption = "A la carte menu for " + sdate.ToString();
            gvBooking2.MasterTableView.Font.Name = "verdana";
            gvBooking2.MasterTableView.Font.Size = 12;
            gvBooking2.ExportSettings.IgnorePaging = true;
            gvBooking2.ExportSettings.OpenInNewWindow = true;
            gvBooking2.MasterTableView.ExportToExcel();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}

