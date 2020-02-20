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

public partial class OccupancyHistory : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {

                LoadTitle();

                rgOccupancyHistory.DataSource = string.Empty;
                rgOccupancyHistory.DataBind();

                DateTime sd = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);


               // dtpfordate.SelectedDate = sd;
               // dtpuntildate.SelectedDate = DateTime.Now;
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 76 });


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

    private void LoadOccupancyHistory(string DoorNo)
    {
        try
        {

            DataSet dsOccupancyHistory = sqlobj.ExecuteSP("SP_GetOccupancyHistory ",
                 new SqlParameter() { ParameterName = "@DoorNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = DoorNo.ToString()});

            if (dsOccupancyHistory.Tables[0].Rows.Count > 0)
            {
                rgOccupancyHistory.DataSource = dsOccupancyHistory;
                rgOccupancyHistory.DataBind();
            }
            else
            {
                rgOccupancyHistory.DataSource = string.Empty;
                rgOccupancyHistory.DataBind();
            }


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

            string strrsnfilter = DdlUhid.Text;

            string[] custrsn = strrsnfilter.Split(',');

            Session["RDoorNo"] = custrsn[1].ToString();

            Session["RName"] = custrsn[2].ToString();

            strrsnfilter = custrsn[3].ToString();

            custrsn = strrsnfilter.Split(';');

            Int32 rsn = Convert.ToInt32(custrsn[0].ToString());

            Session["ResidentRSN"] = rsn.ToString();

            LoadOccupancyHistory(Session["RDoorNo"].ToString());

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();


            DataSet dsOccupancyHistory = sqlobj.ExecuteSP("SP_GetOccupancyHistory ",
                new SqlParameter() { ParameterName = "@DoorNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Session["RDoorNo"].ToString() }
                );


            if (dsOccupancyHistory.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();
                dsOccupancyHistory.Tables[0].Columns["Date"].ColumnName = "New Status Date";
                dsOccupancyHistory.Tables[0].Columns["oldstatus"].ColumnName = "Old Status";
                dsOccupancyHistory.Tables[0].Columns["Newstatus"].ColumnName = "New Status";
                dsOccupancyHistory.Tables[0].Columns["OldStatusDate"].ColumnName = "Old Status Date";
                dg.DataSource = dsOccupancyHistory.Tables[0];
                dg.DataBind();

                // THE EXCEL FILE.
                string sFileName = "Occupany History for  " + Session["RDoorNo"].ToString()  + ".xls";
                sFileName = sFileName.Replace("/", "");

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


                Response.Write("<table><tr><td>Occupany History for  " + Session["RDoorNo"].ToString() + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show( "Door No" + Session["RDoorNo"].ToString() + " Occupancy History does not exist");
            }
        }
        catch (Exception ex)
        {
            //WebMsgBox.Show(ex.Message);
        }
    }
    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            LoadOccupancyHistory(Session["RDoorNo"].ToString());
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


}