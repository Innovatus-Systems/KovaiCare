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

public partial class GLAccMasterView : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            LoadTitle();
            LoadGrid();
            LoadContraAcc();
        }
        rwGSTPopUp.VisibleOnPageLoad = true;
        rwGSTPopUp.Visible = false;
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 139 });

            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
                //lnktitle1.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                //lnktitle1.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadGrid()
    {
        try
        {
            DataSet dsGrid = sqlobj.ExecuteSP("SP_GetGLAccGrid");

            if (dsGrid.Tables[0].Rows.Count > 0)
            {
                gvGLView.DataSource = dsGrid.Tables[0];
                gvGLView.DataBind();
                Session["GridData"] = dsGrid.Tables[0];
            }
            else
            {
                gvGLView.DataSource = null;
                gvGLView.DataBind();
                Session["GridData"] = null;
            }
            dsGrid.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadContraAcc()
    {
        try
        {
            DataSet dsConAcc = sqlobj.ExecuteSP("SP_GetTxnPostingContraAcc");

            if (dsConAcc.Tables[0].Rows.Count > 0)
            {
                drpContraAcc.DataSource = dsConAcc.Tables[0];
                drpContraAcc.DataTextField = "AccountCode";
                drpContraAcc.DataValueField = "AccountCode";
                drpContraAcc.DataBind();                
            }
            else
            {
                          
            }
            drpContraAcc.Items.Insert(0, "--Select--");
            dsConAcc.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsGrid = new DataSet();
        if (Session["GridData"] != null)
        {

            DataGrid dg = new DataGrid();

            dg.DataSource = Session["GridData"];
            dg.DataBind();

            // THE EXCEL FILE.
            string date = DateTime.Now.ToString("dd-MM-yyyy-hh-mm");
            string dateasof = DateTime.Now.ToString("dd-MMM-yyyy hh:mm");
            dateasof = dateasof + " Hrs";
            string sFileName = date;
            sFileName = sFileName.Replace("-", "");
            sFileName = "Txn. Posting Rules-" + sFileName;



            // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=" + sFileName + ".xls");
            Response.ContentType = "application/vnd.ms-excel";
            EnableViewState = false;

            System.IO.StringWriter objSW = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

            dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
            dg.RenderControl(objHTW);


            Response.Write("<table style='font-weight:bold;font-size:16px;font-family:Verdana;'><tr><td>Txn. Posting Rules</td><td> as of  :" + dateasof + "</td></tr><tr><td></td></tr></table>");
            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:soild 1px #999; } " +
                "TD { border:soild 1px #D5D5D5; text-align:center } </style>");
            Response.Write("<table><tr><td>");
            Response.Write(objSW.ToString());
            Response.Write("</td></tr></table>");
            Response.End();
            dg = null;
        }

        else
        {
            WebMsgBox.Show("No Data.");
        }
        Session["GridData"] = null;
    }
    protected void gvGLView_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvGLView.FilterMenu;
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

    protected void gvGLView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "UpdateRow")
            {




            }
            else
            {
                LoadGrid();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void BtnAdd_Click(object sender, EventArgs e)
    {
        Clear();
        DivtPRAddEdit.Visible = true;
        //DivTPRView.Visible = true;
        TxtTxnCode.Focus();
    }
    protected void BtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if(drpContraAcc.SelectedValue=="0")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select Contra Account Code.');", true);              
                return;
            }
            int flag = 1;
            string msg = "New Transaction posting rule has been saved successfully";
            if (BtnSave.Text == "Update")
            {
                flag = 2;
                msg = "Transaction posting rule has been updated successfully";
            }
            else
            {
                DataSet dsCkTxnCode = sqlobj.ExecuteSP("SP_TxnPostingRulesAddEdit",
                    new SqlParameter() { ParameterName = "@IMODE", Value = 4, SqlDbType = SqlDbType.Int },
                    new SqlParameter() { ParameterName = "@TxnCode", Value = TxtTxnCode.Text, SqlDbType = SqlDbType.NVarChar }
                );
                if (dsCkTxnCode != null && dsCkTxnCode.Tables.Count > 0 && dsCkTxnCode.Tables[0].Rows.Count > 0)
                {
                    WebMsgBox.Show("The given txn code already exists. Please try another code.");
                    return;
                }
            }
            if (string.IsNullOrEmpty(TxtCGST.Text))
                TxtCGST.Text = "0";
            if (string.IsNullOrEmpty(TxtSGST.Text))
                TxtSGST.Text = "0";
            sqlobj.ExecuteSP("SP_TxnPostingRulesAddEdit",
                new SqlParameter() { ParameterName = "@IMODE", Value = flag, SqlDbType = SqlDbType.Int },
                new SqlParameter() { ParameterName = "@TxnCode", Value = TxtTxnCode.Text, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@StdDescription", Value = TxtStdNarration.Text, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@StdNarration", Value = TxtStdNarration.Text, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@DrCr", Value = DdlDrCr.SelectedValue, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@Affects", Value = DdlAffects.SelectedValue, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@ContraAC", Value = drpContraAcc.SelectedValue, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@CGST_PCNT", Value = TxtCGST.Text, SqlDbType = SqlDbType.Decimal },
                new SqlParameter() { ParameterName = "@CGST_AC", Value = TxtCGSTGL.Text, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@SGST_PCNT", Value = TxtSGST.Text, SqlDbType = SqlDbType.Decimal },
                new SqlParameter() { ParameterName = "@SGST_AC", Value = TxtSGSTGL.Text, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@IorE", Value = DdlIE.SelectedValue, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@SorC", Value = DdlSC.SelectedValue, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@PM", Value = DdlProg.SelectedValue, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@Help", Value = TxtHelp.Text, SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@C_BY", Value = Convert.ToString(Session["UserID"]), SqlDbType = SqlDbType.NVarChar },
                new SqlParameter() { ParameterName = "@M_BY", Value = Convert.ToString(Session["UserID"]), SqlDbType = SqlDbType.NVarChar }, 
                new SqlParameter() { ParameterName = "@HSNCODE", Value = Convert.ToString(txthsncode.Text), SqlDbType = SqlDbType.NVarChar }
                );
            Clear();
            LoadGrid();
            DivtPRAddEdit.Visible = false;
            //DivTPRView.Visible = true;
            WebMsgBox.Show(msg);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        DivtPRAddEdit.Visible = false;
        //DivTPRView.Visible = true;
    }
    protected void Clear()
    {
        TxtTxnCode.Text = "";
        TxtTxnCode.Enabled = true;
        TxtStdNarration.Text = "";
        DdlDrCr.SelectedValue = "CR";
        DdlAffects.SelectedValue = "R";
        //TxtContraAc.Text = "";
        TxtCGST.Text = "";
        TxtCGSTGL.Text = "";
        TxtSGST.Text = "";
        TxtSGSTGL.Text = "";
        DdlIE.SelectedValue = "E";
        DdlSC.SelectedValue = "S";
        DdlProg.SelectedValue = "AC";
        TxtHelp.Text = "";
        BtnSave.Text = "Save";
        LblTitle1.Text = "Add New Rule";
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkEdit = (LinkButton)sender;
            DataSet dsTxnDet = sqlobj.ExecuteSP("SP_TxnPostingRulesAddEdit",
                new SqlParameter() { ParameterName = "@IMODE", Value = 3, SqlDbType = SqlDbType.Int },
                new SqlParameter() { ParameterName = "@TxnCode", Value = lnkEdit.CommandName, SqlDbType = SqlDbType.NVarChar }
            );
            if (dsTxnDet != null && dsTxnDet.Tables.Count > 0 && dsTxnDet.Tables[0].Rows.Count > 0)
            {
                TxtTxnCode.Text = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["TxnCode"]);
                TxtTxnCode.Enabled = false;
                TxtStdNarration.Text = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["StdNarration"]);
                DdlDrCr.SelectedValue = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["DrCr"]);
                DdlAffects.SelectedValue = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["Affects"]);
                drpContraAcc.SelectedValue = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["ContraAC"]);
                //TxtContraAc.Text = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["ContraAC"]);
                TxtCGST.Text = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["CGST_PCNT"]);
                TxtCGSTGL.Text = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["CGST_AC"]);
                TxtSGST.Text = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["SGST_PCNT"]);
                TxtSGSTGL.Text = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["SGST_AC"]);
                txthsncode.Text= Convert.ToString(dsTxnDet.Tables[0].Rows[0]["HSNCODE"]);
                DdlIE.SelectedValue = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["IorE"]);
                DdlSC.SelectedValue = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["SorC"]);
                DdlProg.SelectedValue = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["PM"]);
                TxtHelp.Text = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["Help"]);
                BtnSave.Text = "Update";
                DivtPRAddEdit.Visible = true;
                //DivTPRView.Visible = true;
                TxtTxnCode.Enabled = false;
                TxtStdNarration.Focus();
                LblTitle1.Text = "Edit Rule";
            }
            else
            {
                WebMsgBox.Show("No record found");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());

        }        
    }
    protected void lnkGSTPopup_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkEdit = (LinkButton)sender;
            decimal CGST = 0, SGST = 0, CGSTAmt = 0, SGSTAmt = 0;

            DataSet dsTxnDet = sqlobj.ExecuteSP("SP_TxnPostingRulesAddEdit",
                new SqlParameter() { ParameterName = "@IMODE", Value = 3, SqlDbType = SqlDbType.Int },
                new SqlParameter() { ParameterName = "@TxnCode", Value = lnkEdit.CommandName, SqlDbType = SqlDbType.NVarChar }
            );
            if (dsTxnDet != null && dsTxnDet.Tables.Count > 0 && dsTxnDet.Tables[0].Rows.Count > 0)
            {
                LblTxnCode.Text = Convert.ToString(dsTxnDet.Tables[0].Rows[0]["TxnCode"]);
                LblCGSTPer.Text = "CGST(" + Convert.ToString(dsTxnDet.Tables[0].Rows[0]["CGST_PCNT"]) + "%)";
                LblSGSTPer.Text = "SGST(" + Convert.ToString(dsTxnDet.Tables[0].Rows[0]["SGST_PCNT"]) + "%)";
                LblIorE.Text = "(" + Convert.ToString(dsTxnDet.Tables[0].Rows[0]["IorE"]) + ")";
                if (!String.IsNullOrEmpty(Convert.ToString(dsTxnDet.Tables[0].Rows[0]["CGST_PCNT"])) && !String.IsNullOrEmpty(Convert.ToString(dsTxnDet.Tables[0].Rows[0]["SGST_PCNT"])))
                {
                    if (Convert.ToString(dsTxnDet.Tables[0].Rows[0]["IorE"]) == "I")
                    {
                        CGST = Convert.ToDecimal(dsTxnDet.Tables[0].Rows[0]["CGST_PCNT"]);
                        SGST = Convert.ToDecimal(dsTxnDet.Tables[0].Rows[0]["SGST_PCNT"]);
                        CGSTAmt = ((decimal)1000.00 - ((decimal)100000.00 / ((decimal)100.00 + CGST)));
                        SGSTAmt = ((decimal)1000.00 - ((decimal)100000.00 / ((decimal)100.00 + SGST)));
                        LblTotalAmt.Text = ((decimal)1000.00 - (CGSTAmt + SGSTAmt)).ToString("0.00");
                        LblCGSTAmt.Text = CGSTAmt.ToString("0.00");
                        LblSGSTAmt.Text = SGSTAmt.ToString("0.00");
                    }
                    else if (Convert.ToString(dsTxnDet.Tables[0].Rows[0]["IorE"]) == "E")
                    {
                        CGST = Convert.ToDecimal(dsTxnDet.Tables[0].Rows[0]["CGST_PCNT"]);
                        SGST = Convert.ToDecimal(dsTxnDet.Tables[0].Rows[0]["SGST_PCNT"]);
                        CGSTAmt = ((decimal)1000.00 / CGST);
                        SGSTAmt = ((decimal)1000.00 / SGST);
                        LblTotalAmt.Text = ((decimal)1000.00 + CGSTAmt + SGSTAmt).ToString("0.00");
                        LblCGSTAmt.Text = CGSTAmt.ToString("0.00");
                        LblSGSTAmt.Text = SGSTAmt.ToString("0.00");
                    }
                }
                
                rwGSTPopUp.Visible = true;
            }
        }
        catch (Exception ex)
        {

        }
    }
}