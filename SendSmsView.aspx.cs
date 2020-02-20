using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI;

public partial class SendSmsView : System.Web.UI.Page
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
                LoadSendSMS();                
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadSendSMS()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_SendSMS",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 });

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                gvSendSMS.DataSource = dsCategory;
                gvSendSMS.DataBind();                
            }
            else
            {
                gvSendSMS.DataSource = string.Empty;
                gvSendSMS.DataBind();
            }
            dsCategory.Dispose();

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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 158 });


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

    protected void gvSendSMS_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {

    }

    protected void gvSendSMS_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvSendSMS.FilterMenu;
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(txtMobilNo.Text) || string.IsNullOrEmpty(txtText.Text))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Provide Valid Data.');", true);
                return;
            }
            DataSet ds = sqlobj.ExecuteSP("SP_SendSMS",
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                        new SqlParameter() { ParameterName = "@MobileNo", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(txtMobilNo.Text) },
                        new SqlParameter() { ParameterName = "@SMSTEXT", SqlDbType = SqlDbType.NVarChar, Value = txtText.Text },
                        new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                     );
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Successfully Sent .');", true);
            LoadSendSMS();
            btnClear_Click(sender, e);
        }

        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please enter valid Number (numeric only)');", true);
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtMobilNo.Text = "";
        txtText.Text = "";
    }

    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsStatementRPT = new DataSet();
            DataSet dsCategory = sqlobj.ExecuteSP("SP_SendSMS",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                DataGrid dg = new DataGrid();
                dg.DataSource = dsCategory.Tables[0];
                dg.DataBind();
                string sFileName = "SMS SenT List.xls";
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
}