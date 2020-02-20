using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class MobileAppAuditLog : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadTitle();
                LoadLog();              

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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 165 });

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
    private void LoadLog()
    {
        try
        {
            DataSet dsLOG = sqlobj.ExecuteSP("CC_MOBAPPAUDITLOG",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 });

            if (dsLOG.Tables[0].Rows.Count > 0)
            {
                gvLog.DataSource = dsLOG;
                gvLog.DataBind();
            }
            else
            {
                gvLog.DataSource = string.Empty;
                gvLog.DataBind();
            }
            dsLOG.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvLog_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadLog();
    }

    protected void gvLog_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvLog.FilterMenu;
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

    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsStatementRPT = new DataSet();
            DataSet dsCategory = sqlobj.ExecuteSP("CC_MOBAPPAUDITLOG",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                DataGrid dg = new DataGrid();
                dg.DataSource = dsCategory.Tables[0];
                dg.DataBind();
                string DT = DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss");
                string sFileName = "MOBILEAPPAUDITLOG_" + DT + ".xls";
                // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
                Response.ContentType = "application/vnd.ms-excel";
                EnableViewState = false;

                System.IO.StringWriter objSW = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);
                dg.HeaderStyle.Font.Bold = true;
                dg.HeaderStyle.BackColor = System.Drawing.Color.GreenYellow; // SET EXCEL HEADERS AS BOLD.
                dg.RenderControl(objHTW);


                Response.Write("<table><tr><td>MOBILE APP. AUDIT LOG</td></tr></table>");


                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                //WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value + " statement does not exist");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Dashboard.aspx");
        }
        catch(Exception ex)
        {

        }
    }
}