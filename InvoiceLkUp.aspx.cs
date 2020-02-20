using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class InvoiceLkUp : System.Web.UI.Page
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
                LoadInvoiceLkup();
                btnUpdate.Visible = false;
                btnSave.Visible = true;
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 157 });


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
    private void LoadInvoiceLkup()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("Proc_InvoiceLkUp",
                new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 3 });
            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                gvInvoiceLkUp.DataSource = dsTitle.Tables[0];
                gvInvoiceLkUp.DataBind();
            }
            else
            {
                gvInvoiceLkUp.DataSource = string.Empty;
                gvInvoiceLkUp.DataBind();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void Clear()
    {
        try
        {
            txtHSNCode.Text = "";
            txtPrefix.Text = "";
            txtStdText.Text = "";
            txtTXNCode.Text = ""; 
            txtYear.Text = "";
            btnUpdate.Visible = false;
            //txtTXNCode.Enabled = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvInvoiceLkUp_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "UpdateRow")
            {
                LnkSH.Text = "Update Record.";
                hbtnRSN.Value = e.CommandArgument.ToString();
                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;
                    LinkButton lnkRSN = (LinkButton)e.Item.FindControl("lnkRSN");
                    DataSet dsRes= sqlobj.ExecuteSP("Proc_InvoiceLkUp",
                                       new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 4 },
                                       new SqlParameter() { ParameterName = "@TXNCODE", SqlDbType = SqlDbType.NVarChar, Value = lnkRSN.Text }
                                       );
                    if (dsRes.Tables[0].Rows.Count > 0)
                    {
                        //txtTXNCode.Enabled = false;
                        txtHSNCode.Text = dsRes.Tables[0].Rows[0]["HSNCode"].ToString();
                        txtPrefix.Text = dsRes.Tables[0].Rows[0]["Prefix"].ToString();
                        txtStdText.Text = dsRes.Tables[0].Rows[0]["StdText"].ToString();
                        txtTXNCode.Text = dsRes.Tables[0].Rows[0]["TXNCode"].ToString();
                        txtYear.Text = dsRes.Tables[0].Rows[0]["Year"].ToString();  
                        txtRSN.Text= dsRes.Tables[0].Rows[0]["RSN"].ToString();
                        btnSave.Visible = false;
                        btnUpdate.Visible = true;                      
                    }
                    dsRes.Dispose();
                }
            }
            else
            {
                LoadInvoiceLkup();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.ToString() + "');", true);
        }
    }

    protected void gvInvoiceLkUp_Init(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //txtTXNCode.Enabled = true;
        sqlobj.ExecuteSP("Proc_InvoiceLkUp",
               new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@TXNCODE", SqlDbType = SqlDbType.NVarChar, Value = txtTXNCode.Text },
                 new SqlParameter() { ParameterName = "@PREFIX", SqlDbType = SqlDbType.NVarChar, Value = txtPrefix.Text },
                  new SqlParameter() { ParameterName = "@YEAR", SqlDbType = SqlDbType.NVarChar, Value = txtYear.Text },
                   new SqlParameter() { ParameterName = "@STDTEXT", SqlDbType = SqlDbType.NVarChar, Value = txtStdText.Text },
                    new SqlParameter() { ParameterName = "@HSNCODE", SqlDbType = SqlDbType.NVarChar, Value = txtHSNCode.Text },
                    new SqlParameter() { ParameterName = "@CID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
               );
        Clear();
        LnkSH.Text = "Add New";
        LoadInvoiceLkup();
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Invoice Details Saved Successfully.');", true);
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            //txtTXNCode.Enabled = false;
            sqlobj.ExecuteSP("Proc_InvoiceLkUp",
               new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = txtRSN.Text },
                new SqlParameter() { ParameterName = "@TXNCODE", SqlDbType = SqlDbType.NVarChar, Value = txtTXNCode.Text },
                 new SqlParameter() { ParameterName = "@PREFIX", SqlDbType = SqlDbType.NVarChar, Value = txtPrefix.Text },
                  new SqlParameter() { ParameterName = "@YEAR", SqlDbType = SqlDbType.NVarChar, Value = txtYear.Text },
                   new SqlParameter() { ParameterName = "@STDTEXT", SqlDbType = SqlDbType.NVarChar, Value = txtStdText.Text },
                    new SqlParameter() { ParameterName = "@HSNCODE", SqlDbType = SqlDbType.NVarChar, Value = txtHSNCode.Text },
                    new SqlParameter() { ParameterName = "@CID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
               );
            Clear();
                LnkSH.Text = "Add New";
                LoadInvoiceLkup();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Invoice Details Updated Successfully.');", true);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('"+ex.Message.ToString()+"');", true);
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx", false);
    }

    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        try {
            string DT = DateTime.Now.ToString("ddMMMyyyyhhmmss");
            SqlProcsNew sqlobj = new SqlProcsNew();            
            DataSet dsCategory = sqlobj.ExecuteSP("Proc_InvoiceLkUp",
              new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                System.Web.UI.WebControls.DataGrid dg = new System.Web.UI.WebControls.DataGrid();

                dg.DataSource = dsCategory.Tables[0];
                dg.DataBind();

                // THE EXCEL FILE.
                string sFileName = "InvoiceLkup_" + DT + ".xls";
                //sFileName = sFileName.Replace("/", "");

                // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
                Response.ContentType = "application/vnd.ms-excel";
                EnableViewState = false;

                System.IO.StringWriter objSW = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

                dg.HeaderStyle.Font.Bold = true;
                dg.HeaderStyle.BackColor = Color.GreenYellow; // SET EXCEL HEADERS AS BOLD.
                dg.RenderControl(objHTW);


                Response.Write("<table><tr><td>Invoice Lookup</td></tr></table>");

                //+ "</td><td>" + lbltotoutstanding.Text + " " + lbltotdebitcredit.Text + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:Solid 1px #999; } " +
                    "TD { border:Solid 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
        {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No Data To Export');", true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
}