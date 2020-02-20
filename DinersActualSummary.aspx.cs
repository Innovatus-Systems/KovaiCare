using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;

public partial class DinersActualSummary : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadSession();
            DateTime now = DateTime.Now;
            lblDate.Text = now.ToString("dd-MMM-yyyy HH:mm") + " Hrs.";
            radfromdate.SelectedDate = new DateTime(now.Year, now.Month, 1);
            radtilldate.SelectedDate = DateTime.Today;
            LoadReport();
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 77 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (Convert.ToDateTime(radfromdate.SelectedDate) > Convert.ToDateTime(radtilldate.SelectedDate))
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Please check from and untill date');", true);
            return;
        }
        LoadReport();
    }

    public void LoadReport()
    {
        try
        {

            DataSet dsDinersActual = sqlobj.ExecuteSP("SP_DinersActualSummary",
                new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = radfromdate.SelectedDate },
                new SqlParameter() { ParameterName = "@Tilldate", SqlDbType = SqlDbType.DateTime, Value = radtilldate.SelectedDate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue == "All Sessions" ? null : ddlSession.SelectedValue }
                );

           
            if (dsDinersActual.Tables[0].Rows.Count > 0)
            {
                gvDiners.DataSource = dsDinersActual.Tables[0];
                gvDiners.DataBind();
            }
            else
            {
                gvDiners.DataSource = new string[] { };
                gvDiners.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }


    protected void LoadSession()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_FetchDropDown",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 });


            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {
                ddlSession.DataSource = dsFetchSE.Tables[0];
                ddlSession.DataValueField = "SCode";
                ddlSession.DataTextField = "SName";
                ddlSession.DataBind();
            }

            ddlSession.Items.Insert(0, "All Sessions");
          
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        
        SqlProcsNew sqlobj = new SqlProcsNew();


        DataSet dsDinersActual = sqlobj.ExecuteSP("SP_DinersActualSummary",
                new SqlParameter() { ParameterName = "@FromDate", SqlDbType = SqlDbType.DateTime, Value = radfromdate.SelectedDate },
                new SqlParameter() { ParameterName = "@Tilldate", SqlDbType = SqlDbType.DateTime, Value = radtilldate.SelectedDate }
                );


        if (dsDinersActual.Tables[0].Rows.Count > 0)
        {
            DataGrid dg = new DataGrid();

            dg.DataSource = dsDinersActual.Tables[0];
            dg.DataBind();



            // THE EXCEL FILE.
            string sFileName = "Diners actual summary from " + radfromdate.SelectedDate + " To " + radtilldate.SelectedDate + ".xls";
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


            //"," + strdesc.ToString() +

            Response.Write("<table><tr><td>Diners actual summary from " + radfromdate.SelectedDate + " To " + radtilldate.SelectedDate + "<td></tr></table>");


            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
            Response.Write(objSW.ToString());


            Response.End();
            dg = null;
        }


    }
}