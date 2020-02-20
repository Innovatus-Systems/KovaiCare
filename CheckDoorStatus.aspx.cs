using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class CheckDoorStatus : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadGrid();          
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 162 });
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

    public void LoadGrid()
    {
        try
        {
            DataSet dsUsers = sqlobj.ExecuteSP("SP_CheckVacant");
            if (dsUsers.Tables[0].Rows.Count > 0)
            {

                gvDoorStatus.DataSource = dsUsers;
                gvDoorStatus.DataBind();
            }
            else
            {
                gvDoorStatus.DataSource = string.Empty;
                gvDoorStatus.DataBind();
            }
        }
        catch (Exception ex)
        {
            gvDoorStatus.DataSource = string.Empty;
            gvDoorStatus.DataBind();
        }
    }
    protected void gvDoorStatus_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid();
    }

    protected void gvDoorStatus_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvDoorStatus.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains"
            || menu.Items[i].Text == "GreaterThanOrEqualTo" || menu.Items[i].Text == "LessThanOrEqualTo")
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
            DataSet dsCategory = sqlobj.ExecuteSP("SP_CheckVacant");
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                DataGrid dg = new DataGrid();
                dg.DataSource = dsCategory.Tables[0];
                dg.DataBind();
                string dt = DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss");
                string sFileName = "Check_Door_Status_" + dt + ".xls";
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

                string date = DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss")+" Hrs.";
                Response.Write("<table><tr><td colspan='5'>UnOccupied Villa Details as of "+ date.ToString()+"</td></tr></table>");

                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());

                Response.End();
                dg = null;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No data.');", true);
            }
        }
        catch(Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
}