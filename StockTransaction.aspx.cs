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
using System.Drawing;

public partial class StockTransaction : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }


        rwSaveTime.VisibleOnPageLoad = true;
        rwSaveTime.Visible = false;

        if (!IsPostBack)
        {

            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString()); 
            
            LoadTitle();
            LoadItem();
            LoadSession();
            LoadProvisionGroup();
            //LoadTransType();

            LoadSaveTime();

            dtpInoviceDt.SelectedDate = DateTime.Today;
            dtpTransDate.SelectedDate = DateTime.Today;

           // LoadRecentTransaction();

            LoadGrid(Convert.ToDateTime(dtpTransDate.SelectedDate));

            dtpdate.MinDate = DateTime.Today;

            rgRecentTransaction.DataSource = string.Empty;
            rgRecentTransaction.DataBind();
           
            lblpurchaseprice.Visible = false;
            txtPurchaseprice.Visible = false;
            lbldate.Visible = false;
            dtpdate.Visible = false;
            lblSessionCode.Visible = false;
            ddlSession.Visible = false;
            lblmenuitem.Visible = false;
            ddlMenuItem.Visible = false;
            
            
        }
    }

    protected void LoadSaveTime()
    {
        DataSet dsSaveTime = new DataSet();
        dsSaveTime = sqlobj.ExecuteSP("SP_GetSaveTimeEntry");

        if (dsSaveTime.Tables[0].Rows.Count != 0)
        {
            gvSaveTime.DataSource = dsSaveTime;
            gvSaveTime.DataBind();

            ddlsavetime.DataSource = dsSaveTime;
            ddlsavetime.DataTextField = "Savetimeentry";
            ddlsavetime.DataValueField = "Savetimeentry";
            ddlsavetime.DataBind();
        }

        ddlsavetime.Items.Insert(0, "");


        //ddlTrackon.SelectedIndex = 4;
        dsSaveTime.Dispose();
    }

    private void LoadRecentTransaction()
    {
        try
        {
            DataSet dsLoadRecentTransaction = sqlobj.ExecuteSP("SP_RecentTransactionItem",                
                 new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(ddlItemCode.SelectedValue) },
                 new SqlParameter() { ParameterName = "@TransType", SqlDbType = SqlDbType.NVarChar, Value = ddlTransactionType.SelectedValue }                
                 );       

            if (dsLoadRecentTransaction.Tables[0].Rows.Count > 0)
            {
                rgRecentTransaction.DataSource = dsLoadRecentTransaction;
                rgRecentTransaction.DataBind();
                if (ddlTransactionType.SelectedValue == "02" || ddlTransactionType.SelectedValue == "01" )
                {
                    string strsb = "Shown below";
                    lblrecenttransaction.Text =  dsLoadRecentTransaction.Tables[0].Rows[0]["RMCode"].ToString() + ',' + dsLoadRecentTransaction.Tables[0].Rows[0]["Item"].ToString() + ' ' + dsLoadRecentTransaction.Tables[0].Rows[0]["TransType"].ToString() + ' ' + strsb.ToString();
                }
                else
                {
                    lblrecenttransaction.Text = "Recent transactions-" + dsLoadRecentTransaction.Tables[0].Rows[0]["RMCode"].ToString() + ',' + dsLoadRecentTransaction.Tables[0].Rows[0]["Item"].ToString(); 
                }
            }
            else
            {
                rgRecentTransaction.DataSource = string.Empty;
                rgRecentTransaction.DataBind();
            }
            dsLoadRecentTransaction.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadProvisionGroup()
    {
        try
        {
            DataSet dsLoadProvisionType = sqlobj.ExecuteSP("SP_ProvisionType", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 }
                );
            ddlItemGroup.Items.Clear();
            if (dsLoadProvisionType.Tables[0].Rows.Count > 0)
            {
                ddlItemGroup.DataSource = dsLoadProvisionType;
                ddlItemGroup.DataTextField = "PCode";
                ddlItemGroup.DataValueField = "PCode";
                ddlItemGroup.DataBind();
            }
            ddlItemGroup.Items.Insert(0, "--Select--");
            dsLoadProvisionType.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
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


            ddlSession.Items.Clear();

            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {

                ddlSession.DataSource = dsFetchSE.Tables[0];
                ddlSession.DataValueField = "SCode";
                ddlSession.DataTextField = "SName";
                ddlSession.DataBind();
            }

            ddlSession.Items.Insert(0, "--Select--");

            dsFetchSE.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadMenuItem()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_GetMenuItem",
                 new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue },
                 new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate == null ? null : dtpdate.SelectedDate }
                 );

            ddlMenuItem.Items.Clear();

            if (dsFetchSE.Tables[0].Rows.Count >0)
            {
                ddlMenuItem.DataSource = dsFetchSE.Tables[0];
                ddlMenuItem.DataValueField = "ItemCode";
                ddlMenuItem.DataTextField = "ItemName";
                ddlMenuItem.DataBind();
            }

            ddlMenuItem.Items.Insert(0,"--Select--");

            dsFetchSE.Dispose();

           
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 93 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lbltitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lbltitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadItem()
    {
        try
        {
            DataSet dsItm = sqlobj.ExecuteSP("SP_General",
             new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 23 },
             new SqlParameter() { ParameterName = "@StockGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlItemGroup.SelectedValue }
             );

            ddlItemCode.Items.Clear();

            if (dsItm.Tables[0].Rows.Count > 0)
            {
                ddlItemCode.DataSource = dsItm.Tables[0];
                ddlItemCode.DataValueField = "RSN";
                ddlItemCode.DataTextField = "Item";
                ddlItemCode.DataBind();

            }

            ddlItemCode.Items.Insert(0, new ListItem("-- Select --", "0"));

            dsItm.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadTransType()
    {
        try
        {
            DataSet dsTT = sqlobj.ExecuteSP("SP_General",
            new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 27 },
            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = hdnItem.Value });

             if (dsTT.Tables[0].Rows.Count > 0)
             {
                 DataSet dsTT2 = sqlobj.ExecuteSP("SP_General",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 28 });

                 if (dsTT2.Tables[0].Rows.Count > 0)
                 {
                     ddlTransactionType.DataSource = dsTT2.Tables[0];
                     ddlTransactionType.DataValueField = "Value";
                     ddlTransactionType.DataTextField = "Name";
                     ddlTransactionType.DataBind();

                     ddlTransactionType.Items.Insert(0, new ListItem("-- Select --", "0"));
                 }
                 dsTT2.Dispose();
             }
             else
             {
                 DataSet dsTT3 = sqlobj.ExecuteSP("SP_General",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 29 });

                 if (dsTT3.Tables[0].Rows.Count > 0)
                 {
                     ddlTransactionType.DataSource = dsTT3.Tables[0];
                     ddlTransactionType.DataValueField = "Value";
                     ddlTransactionType.DataTextField = "Name";
                     ddlTransactionType.DataBind();

                     ddlTransactionType.Items.Insert(0, new ListItem("-- Select --", "0"));
                 }
                 dsTT3.Dispose();
             }

           
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlItemCode_Changed(object sender, EventArgs e)
    {
        if (ddlItemCode.SelectedIndex != 0)
        {
            DataSet dsSIC = sqlobj.ExecuteSP("SP_General",
              new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 25 },
              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = ddlItemCode.SelectedValue });

            if (dsSIC.Tables[0].Rows.Count > 0)
            {
                txtIUOM.Text = dsSIC.Tables[0].Rows[0]["IssueUOM"].ToString();
                txtClosingStk.Text = dsSIC.Tables[0].Rows[0]["ClosingStock"].ToString();
            }
           ddlTransactionType.Focus();
           hdnItem.Value = ddlItemCode.SelectedValue;
           LoadTransType();



        }
        else
        {
            txtIUOM.Text = string.Empty;
            txtClosingStk.Text = string.Empty;
            ddlItemCode.Focus();
        }
    }

    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        ViewState["update"] = Session["update"];
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {

                if (Session["update"].ToString() == ViewState["update"].ToString())
                {


                    if (ddlItemCode.SelectedIndex != 0 && ddlTransactionType.SelectedIndex != 0 && txtQty.Text != string.Empty)
                    {


                        // RadWindowManager1.RadConfirm("Current price is greater then the Previous purchase price. Are you sure do you want save?", "confirmStatusCallbackFn", 400, 200, null, "Confirm");


                        string strloc = "";

                        if (ddlTransactionType.SelectedValue == "01")
                        {
                            decimal iavailableqty = Convert.ToDecimal(txtClosingStk.Text);

                            decimal iqty = Convert.ToDecimal(txtQty.Text);


                            if (iqty > iavailableqty)
                            {
                                WebMsgBox.Show("Please check! Issue Qty is greater than Available qty");
                                return;
                            }

                            strloc = "2";
                        }
                        else
                        {
                            strloc = "1";
                        }

                        

                        sqlobj.ExecuteSP("SP_InsertStockTransaction",
                            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                            new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.Int, Value = Convert.ToInt64(ddlItemCode.SelectedValue) },
                            new SqlParameter() { ParameterName = "@IUOM", SqlDbType = SqlDbType.NVarChar, Value = txtIUOM.Text.ToString() },
                            new SqlParameter() { ParameterName = "@ClosingStk", SqlDbType = SqlDbType.Decimal, Value = txtClosingStk.Text.ToString() },
                            new SqlParameter() { ParameterName = "@TransType", SqlDbType = SqlDbType.NVarChar, Value = ddlTransactionType.SelectedValue },
                            new SqlParameter() { ParameterName = "@Qty", SqlDbType = SqlDbType.Decimal, Value = txtQty.Text.ToString() },
                            new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                            new SqlParameter() { ParameterName = "@Location", SqlDbType = SqlDbType.Int, Value = strloc.ToString() },
                            new SqlParameter() { ParameterName = "@PurchasePrice", SqlDbType = SqlDbType.Decimal, Value = txtPurchaseprice.Text == "" ? "0.00" : txtPurchaseprice.Text },
                            new SqlParameter() { ParameterName = "@ForDate", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate == null ? null : dtpdate.SelectedDate },
                            new SqlParameter() { ParameterName = "@ForSession", SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue == "--Select--" ? null : ddlSession.SelectedValue },
                            new SqlParameter() { ParameterName = "@ForMenuItem", SqlDbType = SqlDbType.NVarChar, Value = ddlMenuItem.SelectedValue == "--Select--" ? null : ddlMenuItem.SelectedValue },

                            new SqlParameter() { ParameterName = "@SupplierName", SqlDbType = SqlDbType.NVarChar, Value = txtSupplierName.Text },
                            new SqlParameter() { ParameterName = "@InvoiceNo", SqlDbType = SqlDbType.NVarChar, Value = txtInvoiceNo.Text },
                            new SqlParameter() { ParameterName = "@InoviceDt", SqlDbType = SqlDbType.DateTime, Value = dtpInoviceDt.SelectedDate}
                            );

                        LoadGrid(Convert.ToDateTime(dtpTransDate.SelectedDate));
                        SClearScr();

                        Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString()); 

                        WebMsgBox.Show("Transaction detail saved successfully.");
                    }
                    else
                    {
                        WebMsgBox.Show("Please select/enter mandatory field(s). ");
                    }
                }

                else
                {
                    SClearScr();
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }

    public void LoadGrid(DateTime fdate)
    {
        try
        {
            DataSet dsUsers = sqlobj.ExecuteSP("SP_General",
               new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 26 },
               new SqlParameter() { ParameterName = "@TDate", SqlDbType = SqlDbType.DateTime, Value = fdate }
               );

            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                grdTransDet.DataSource = dsUsers;
                grdTransDet.DataBind();
            }
            else
            {
                grdTransDet.DataSource = string.Empty;
                grdTransDet.DataBind();
            }

            dsUsers.Dispose();
        }
        catch (Exception ex)
        {
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    
    }

    public void ClearScr()
    {

        ddlItemGroup.SelectedIndex = 0;
        ddlItemCode.SelectedIndex = 0;
        txtIUOM.Text = string.Empty;
        txtClosingStk.Text = string.Empty;
        ddlTransactionType.SelectedIndex = 0;
        txtQty.Text = string.Empty;
        txtRemarks.Text = string.Empty;

        lblpurchaseprice.Visible = false;

        txtPurchaseprice.Text = "";
        txtPurchaseprice.Visible = false ;

        dtpdate.SelectedDate = null;

        lbldate.Visible = false;
        dtpdate.Visible = false;

        ddlSession.SelectedIndex = 0;

        lblSessionCode.Visible = false;
        ddlSession.Visible = false;


        if (ddlMenuItem.Visible == true)
        {
            ddlMenuItem.SelectedIndex = 0;
        }

        lblmenuitem.Visible = false;
        ddlMenuItem.Visible = false;
       
        ddlItemCode.Focus();        
        btnSave.Visible = true;

        txtSupplierName.Text = string.Empty;
        txtInvoiceNo.Text = string.Empty;
        dtpInoviceDt.SelectedDate = null;
    }

    public void SClearScr()
    {

        //ddlItemGroup.SelectedIndex = 0;
        ddlItemCode.SelectedIndex = 0;
        txtIUOM.Text = string.Empty;
        txtClosingStk.Text = string.Empty;
        //ddlTransactionType.SelectedIndex = 0;
        txtQty.Text = string.Empty;

        //txtSupplierName.Text = string.Empty;
        //txtInvoiceNo.Text = string.Empty;
        //dtpInoviceDt.SelectedDate = null;

        txtRemarks.Text = string.Empty;

        lblpurchaseprice.Visible = false;

        txtPurchaseprice.Text = "";
        txtPurchaseprice.Visible = false;

        dtpdate.SelectedDate = null;

        lbldate.Visible = false;
        dtpdate.Visible = false;

        ddlSession.SelectedIndex = 0;

        lblSessionCode.Visible = false;
        ddlSession.Visible = false;


        if (ddlMenuItem.Visible == true)
        {
            ddlMenuItem.SelectedIndex = 0;
        }

        lblmenuitem.Visible = false;
        ddlMenuItem.Visible = false;

        ddlItemCode.Focus();
        btnSave.Visible = true;
    }

    protected void lnkView_Click(object sender, EventArgs e)
    {
        try
        {            
            btnSave.Visible = false;
            LinkButton lnkEdititemBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdititemBtn.NamingContainer;
            string RSN;
            RSN = row.Cells[3].Text;
            
            hdnRSN.Value = RSN.ToString();
            SqlProcsNew proc = new SqlProcsNew();          

            DataSet dsSTR = sqlobj.ExecuteSP("SP_FetchStockTransaction",
              new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
              new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN });

            ddlItemCode.SelectedValue = dsSTR.Tables[0].Rows[0]["ItemCode"].ToString();
            txtIUOM.Text = dsSTR.Tables[0].Rows[0]["IssueUOM"].ToString();
            txtClosingStk.Text = dsSTR.Tables[0].Rows[0]["ClosingStock"].ToString();
            hdnItem.Value = ddlItemCode.SelectedValue;
            LoadTransType();
            ddlTransactionType.SelectedValue = dsSTR.Tables[0].Rows[0]["TransactionCode"].ToString();
            txtQty.Text = dsSTR.Tables[0].Rows[0]["Qty"].ToString();
            txtRemarks.Text = dsSTR.Tables[0].Rows[0]["Reference"].ToString();

            txtSupplierName.Text = dsSTR.Tables[0].Rows[0]["SupplierName"].ToString();
            txtInvoiceNo.Text = dsSTR.Tables[0].Rows[0]["InvoiceNo"].ToString();
            dtpInoviceDt.SelectedDate = Convert.ToDateTime(dsSTR.Tables[0].Rows[0]["InvoiceDt"].ToString());

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void grdTransDet_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid(Convert.ToDateTime(dtpTransDate.SelectedDate));
    }

    protected void ddlTransactionType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlTransactionType.SelectedValue == "02" || ddlTransactionType.SelectedValue == "06")
        {   
          
            lblpurchaseprice.Visible = true;
            txtPurchaseprice.Visible = true;
            lbldate.Visible = false;
            dtpdate.Visible = false;
            lblSessionCode.Visible = false;
            ddlSession.Visible = false;
            lblmenuitem.Visible = false;
            ddlMenuItem.Visible = false;
        }
        else if (ddlTransactionType.SelectedValue == "01" || ddlTransactionType.SelectedValue == "04" || ddlTransactionType.SelectedValue == "05")
        {
            lblpurchaseprice.Visible = false;
            txtPurchaseprice.Visible = false;
            lbldate.Visible = true;
            dtpdate.Visible = true;
            //lblSessionCode.Visible = true;
            // ddlSession.Visible = true;
            // lblmenuitem.Visible = true;
            // ddlMenuItem.Visible = true;
        }
        
        else
        {
            lblpurchaseprice.Visible = false;
            txtPurchaseprice.Visible = false;
            lbldate.Visible = false;
            dtpdate.Visible = false;
            lblSessionCode.Visible = false;
            ddlSession.Visible = false;
            lblmenuitem.Visible = false;
            ddlMenuItem.Visible = false;
        }

        LoadRecentTransaction();
    }
    protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlSession.SelectedValue != "--Select--")
            {
                LoadMenuItem();

                lblmenuitem.Visible = true;
                ddlMenuItem.Visible = true;
            }
            else
            {
                lblmenuitem.Visible = false;
                ddlMenuItem.Visible = false;

            }

            
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        grdTransDet.ExportSettings.ExportOnlyData = true;
        grdTransDet.ExportSettings.FileName = "Kitchen Stock Transaction";
        grdTransDet.ExportSettings.IgnorePaging = true;
        grdTransDet.ExportSettings.OpenInNewWindow = true;
        grdTransDet.MasterTableView.ExportToExcel();
    }
    protected void dtpdate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        if (dtpdate.SelectedDate != null)
        {
            lblSessionCode.Visible = true;
            ddlSession.Visible = true; 


           
        }
        else
        {
            lblSessionCode.Visible = true;
            ddlSession.Visible = true; 
        }
    }
    protected void dtpTransDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            LoadGrid(Convert.ToDateTime(dtpTransDate.SelectedDate));
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlItemGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadItem();
    }
    protected void lnkvegetableprice_Click(object sender, EventArgs e)
    {
        Page.ClientScript.RegisterStartupScript(
        this.GetType(), "OpenWindow", "window.open('http://www.door2door.co.in/394-vegetables','_newtab');", true);
    }

    protected void ddlsavetime_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsavetime.SelectedItem.ToString() != "")
        {
            string strAppend = ddlsavetime.SelectedItem.ToString();
            txtRemarks.Text = txtRemarks.Text + " " + strAppend + " ";
        }
    }

    protected void btnSTSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtInfo.Text.ToString() == "")
            {
                WebMsgBox.Show("Pick list cannot be blank!!!");
                return;
            }
            sqlobj.ExecuteSQLNonQuery("SP_InsertSaveTimeEntry",
                                           new SqlParameter() { ParameterName = "@SaveTimeEntry", SqlDbType = SqlDbType.NVarChar, Value = txtInfo.Text },
                                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = null }
                                           );

            LoadSaveTime();
            STClear();
            WebMsgBox.Show("Your details are saved");
            rwSaveTime.Visible = true;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSTClear_Click(object sender, EventArgs e)
    {
        STClear();
        rwSaveTime.Visible = true;
    }
    protected void gvSaveTime_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);

                ImageButton imgbtn = (ImageButton)e.CommandSource;
                GridViewRow myrow = (GridViewRow)imgbtn.Parent.Parent;
                GridView mygrid = (GridView)sender;

                string st = mygrid.Rows[index].Cells[1].Text;

                if (txtRemarks.Text != "")
                {
                    txtRemarks.Text = txtRemarks.Text + " " + st.ToString();
                }
                else
                {
                    txtRemarks.Text = txtRemarks.Text + st.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnSaveTime_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = true;
    }

    protected void btnSTClose_Click(object sender, EventArgs e)
    {
        rwSaveTime.Visible = false;
    }

    private void STClear()
    {
        txtInfo.Text = "";
        //txtstremarks.Text = "";
    }
    protected void HiddenButton_Click(object sender, EventArgs e)
    {

    }
    protected void grdTransDet_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = grdTransDet.FilterMenu;
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
    protected void rgRecentTransaction_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgRecentTransaction.FilterMenu;
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
    protected void grdTransDet_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;

            if (item["VPCNT"].Text == "&nbsp;")
            {
                item["VPCNT"].Text = "";

            }


            if (item["VPCNT"].Text != "")
            {

                double dvpcnt = Convert.ToDouble(item["VPCNT"].Text);

                if (dvpcnt > 20.00)
                {
                    item["VPCNT"].ForeColor = Color.Red;
                }
            }

            
        }
    }
    protected void rgRecentTransaction_ItemDataBound(object sender, GridItemEventArgs e)
    {

        try {

            if (e.Item is GridDataItem)
            {
                GridDataItem item = e.Item as GridDataItem;


                if (item["VPCNT"].Text == "&nbsp;")
                {
                    item["VPCNT"].Text = "";
                    
                }


                if (item["VPCNT"].Text != "" )
                {

                    double dvpcnt = Convert.ToDouble(item["VPCNT"].Text);

                    if (dvpcnt > 20.00)
                    {
                        item["VPCNT"].ForeColor = Color.Red;
                    }
                }

            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
        

       
    }
}