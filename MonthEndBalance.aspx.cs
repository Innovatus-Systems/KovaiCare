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

public partial class MonthEndBalance : System.Web.UI.Page
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
                rbTxnSel.SelectedValue = "Sel1";
                LoadYYMMDrp();
                LoadAccountMaster();
                LoadResidentDet();
                


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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 166 });


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

    private void Clear()
    {
        try
        {

            LoadAccountMaster();



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    private void LoadAccountMaster()
    {
        try
        {
            Decimal SalValue = 0, ClsValue = 0, NExist =0;


            DataSet dsCategory = sqlobj.ExecuteSP("SP_MonthEndBalance",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@YYMM", SqlDbType = SqlDbType.NVarChar, Value = drpYYMM.SelectedValue.ToString() },
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue.ToString() == "" ? "0" : cmbResident.SelectedValue },
                new SqlParameter() { ParameterName = "@TxnSel", SqlDbType = SqlDbType.NVarChar, Value = rbTxnSel.SelectedValue.ToString() });

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                gvMonthEndBal.DataSource = dsCategory;
                gvMonthEndBal.DataBind();
                //lblCount.Text = "Count :" + dsCategory.Tables[0].Rows.Count.ToString();
            }
            else
            {
                gvMonthEndBal.DataSource = string.Empty;
                gvMonthEndBal.DataBind();
            }





            foreach (DataTable table in dsCategory.Tables)
            {
                foreach (DataRow dr in table.Rows)
                {
                    if (!dr.IsNull("OpeningBalance"))
                        SalValue = SalValue + Convert.ToDecimal(dr["OpeningBalance"]);

                    if (!dr.IsNull("ClosingBalance"))
                        ClsValue = ClsValue + Convert.ToDecimal(dr["ClosingBalance"]);

                }
            }

            foreach (DataTable table in dsCategory.Tables)
            {
                foreach (DataRow dr in table.Rows)
                {
                    if (!dr.IsNull("ClosingBalance"))
                        if (Convert.ToDecimal(dr["ClosingBalance"]) < 0)
                            NExist = NExist + 1;                                
                }
            }

            dsCategory.Dispose();

            //lblCnt.Text = dsCategory.Tables[1].Rows[0]["CNT"].ToString();
            //lblOBTot.Text = dsCategory.Tables[2].Rows[0]["SOBal"].ToString();
            //lblCBTot.Text = dsCategory.Tables[2].Rows[0]["SCBal"].ToString();

            lblCnt.Text = dsCategory.Tables[0].Rows.Count.ToString();
            lblOBTot.Text = SalValue.ToString();
            lblCBTot.Text = ClsValue.ToString();

            if (NExist > 0)
                lblNegExist.Visible = true;
            else
                lblNegExist.Visible = false;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            Clear();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx", false);
    }

    //protected void gvAccountMaster_Init(object sender, EventArgs e)
    //{
    //    GridFilterMenu menu = gvMonthEndBal.FilterMenu;
    //    int i = 0;
    //    while (i < menu.Items.Count)
    //    {
    //        if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains")
    //        {
    //            i++;
    //        }
    //        else
    //        {
    //            menu.Items.RemoveAt(i);
    //        }
    //    }
    //}



    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsStatementRPT = new DataSet();

            string sDate;

            DataSet dsCategory = sqlobj.ExecuteSP("SP_MonthEndBalance",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
               new SqlParameter() { ParameterName = "@YYMM", SqlDbType = SqlDbType.NVarChar, Value = drpYYMM.SelectedValue.ToString() },
               new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = cmbResident.SelectedValue.ToString() == "" ? "0" : cmbResident.SelectedValue },
               new SqlParameter() { ParameterName = "@TxnSel", SqlDbType = SqlDbType.NVarChar, Value = rbTxnSel.SelectedValue.ToString() });

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                DataGrid dg = new DataGrid();
                dg.DataSource = dsCategory.Tables[0];
                dg.DataBind();

                if(drpYYMM.SelectedItem.ToString() != "All")
                    sDate = drpYYMM.SelectedItem.ToString();
                else
                    sDate = string.Empty;

                string sLedger = rbTxnSel.SelectedItem.ToString();

                DataSet dsDT = null;
                SqlProcsNew proc = new SqlProcsNew();
                dsDT = proc.ExecuteSP("GetServerDateTime");


                //string CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddd") + "   " + Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd-MMM-yyyy HH:mm 'Hrs'"); ;
                string CDate =  Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("dd-MMM-yyyy HH:mm 'Hrs'"); ;





                string sFileName = "MonthEndBalance_" + sLedger.ToString() + "_" + sDate + ".xls";
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

                Response.Write("<table><tr bgcolor=\"#EEE8AA\" color=\"#8B4513\" bordercolor=black><td>CovaiSmart</td><td> Date : " + CDate.ToString() + "</td></tr><tr bgcolor=\"#EEE8AA\" color=\"#8B4513\" bordercolor=black><td>Month End Balance - </td><td> " + sLedger.ToString() + " </td><td> For the month of : " + sDate.ToString() + "</td></tr></table>");

                //+ "</td><td>" + lbltotoutstanding.Text + " " + lbltotdebitcredit.Text + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:left } </style>");
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

    private void LoadYYMMDrp()
    {
        try
        {
            DataSet dsTxn = sqlobj.ExecuteSP("SP_MonthEndBalance",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 });
            if (dsTxn.Tables[0].Rows.Count > 0)
            {
                drpYYMM.DataSource = dsTxn.Tables[0];
                drpYYMM.DataValueField = "YearMonth";
                drpYYMM.DataTextField = "YearMonth";
                drpYYMM.DataBind();
                drpYYMM.Items.Insert(0, "All");
            }


            DataSet dsTxn2 = sqlobj.ExecuteSP("SP_MonthEndBalance",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 });
            if (dsTxn2.Tables[0].Rows.Count > 0)
            {
                drpYYMM.SelectedValue = dsTxn2.Tables[0].Rows[0]["YYMM"].ToString();
            }
            else
            {
                drpYYMM.SelectedValue = "All";
            }


            dsTxn.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }



    protected void LoadResidentDet()
    {
        try
        {

            DataSet dsResident = new DataSet();

            if (rbTxnSel.SelectedValue == "Sel1")
            {

                dsResident = sqlobj.ExecuteSP("SP_MonthEndBalDD",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 });
                cmbResident.DataSource = dsResident.Tables[0];
                cmbResident.DataValueField = "RTRSN";
                cmbResident.DataTextField = "RName";
                cmbResident.DataBind();

                RadComboBoxItem item2 = new RadComboBoxItem();
                item2.Text = "All";
                item2.Value = "0";
                item2.Selected = true;
                cmbResident.Items.Add(item2);

            }
            else if (rbTxnSel.SelectedValue == "Sel2")
            {

                dsResident = sqlobj.ExecuteSP("SP_MonthEndBalDD",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 });
                cmbResident.DataSource = dsResident.Tables[0];
                cmbResident.DataValueField = "RTRSN";
                cmbResident.DataTextField = "RName";
                cmbResident.DataBind();

                RadComboBoxItem item2 = new RadComboBoxItem();
                item2.Text = "All";
                item2.Value = "0";
                item2.Selected = true;
                cmbResident.Items.Add(item2);

            }
            else if (rbTxnSel.SelectedValue == "Sel3")
            {

                dsResident = sqlobj.ExecuteSP("SP_MonthEndBalDD",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 });
                cmbResident.DataSource = dsResident.Tables[0];
                cmbResident.DataValueField = "RTRSN";
                cmbResident.DataTextField = "RName";
                cmbResident.DataBind();

                RadComboBoxItem item2 = new RadComboBoxItem();
                item2.Text = "All";
                item2.Value = "0";
                item2.Selected = true;
                cmbResident.Items.Add(item2);

            }



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadAccountMaster();
    }

    protected void cmbResident_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        try
        {
            LoadAccountMaster();

        }
        catch (Exception ex)
        {

        }
    }

    protected void rbTxnSel_SelectedIndexChanged(object sender, EventArgs e)
    {

        LoadResidentDet();
        LoadAccountMaster();


    }

    protected void drpYYMM_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            DataSet dstxnCode = sqlobj.ExecuteSP("SP_MonthEndBalance",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@YYMM", SqlDbType = SqlDbType.NVarChar, Value = drpYYMM.SelectedValue.ToString() });




            if (dstxnCode.Tables[0].Rows.Count > 0)
            {
                LoadAccountMaster();
            }
            else
            {
                LoadAccountMaster();
            }

            dstxnCode.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }




}