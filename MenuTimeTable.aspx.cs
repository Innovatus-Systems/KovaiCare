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
using System.IO;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;

public partial class MenuTimeTable : System.Web.UI.Page
{

    SqlProcsNew sqlobj = new SqlProcsNew();

    static int i = 0;
    static int j = 0;

    DataTable dtRecords = new DataTable();



    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            DataSet dsDT = null;


            if (!Page.IsPostBack)
            {
                dsDT = sqlobj.ExecuteSP("GetServerDateTime");
                DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);

                //dtpmenuforday.MinDate = now.AddDays(1);
                dtpmenuforday.MinDate = now;

                rgSessionMenuForDay.DataSource = string.Empty;
                rgSessionMenuForDay.DataBind();

                panNotSet.Visible = true;
                PanAddMenufordays.Visible = true;


                panEditMenufordays.Visible = false;

                rgMenuforday.DataSource = string.Empty;
                rgMenuforday.DataBind();

                rgEditMenuforday.DataSource = string.Empty;
                rgEditMenuforday.DataBind();

                dvDaily.Visible = false;
                dvWeekly.Visible = false;
                LoadTitle();
                //LoadMenuforday();
                LoadChkSession();
                dsDT.Dispose();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 21 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void dtpmenuforday_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            LoadMenuStatus();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LoadChkSession()
    {
        try
        {

            DataSet dsFetchSE = sqlobj.ExecuteSP("SP_CheckSession",
                      new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 });


            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {
                rdgResidentDet.DataSource = dsFetchSE;
                rdgResidentDet.DataBind();


            }
            else
            {
                rdgResidentDet.DataSource = string.Empty;
                rdgResidentDet.DataBind();


            }


            dsFetchSE.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadMenuStatus()
    {
        try
        {
            DataSet dsFetchSE = sqlobj.ExecuteSP("SP_Menuforday",
                      new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value });

            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {
                rgSessionMenuForDay.DataSource = dsFetchSE;
                rgSessionMenuForDay.DataBind();
            }
            else
            {
                rgSessionMenuForDay.DataSource = string.Empty;
                rgSessionMenuForDay.DataBind();
            }
            dsFetchSE.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadMenuStatus2()
    {
        try
        {
            DataSet dsFetchSE = sqlobj.ExecuteSP("SP_Menuforday",
                      new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value });

            if (dsFetchSE.Tables[0].Rows.Count > 0)
            {
                rgSessionMenuForDay.DataSource = dsFetchSE;
                rgSessionMenuForDay.DataBind();
            }
            else
            {
                rgSessionMenuForDay.DataSource = string.Empty;
                rgSessionMenuForDay.DataBind();
            }
            dsFetchSE.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void lnkSDate_Click(object sender, EventArgs e)
    {
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;

        Session["SDate"] = row.Cells[3].Text;

        dtpmenuforday.SelectedDate = Convert.ToDateTime(Session["SDate"].ToString());

        LoadMenuStatus2();
    }

    protected void chkCopyType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (chkCopyType.SelectedValue == "1")
        {
            dvWeekly.Visible = true;
            dvDaily.Visible = false;
        }
        else if (chkCopyType.SelectedValue == "2")
        {
            dvWeekly.Visible = false;
            dvDaily.Visible = true;
        }
        else
        {
            dvWeekly.Visible = false;
            dvDaily.Visible = false;
        }
    }
    protected void rgLoadMenuforday_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridFilteringItem)
            {
                GridFilteringItem filterItem = (GridFilteringItem)e.Item;

                filterItem["menudate"].HorizontalAlign = HorizontalAlign.Center;


            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void LnkEditMenuforday_Click(object sender, EventArgs e)
    {
        try
        {

            LinkButton lnk = sender as LinkButton;

            GridDataItem item = lnk.NamingContainer as GridDataItem;

            DateTime date = Convert.ToDateTime(item.GetDataKeyValue("filterdate").ToString());
            string strSession = item.GetDataKeyValue("sessioncode").ToString();

            LoadEditMenufordayItems(date, strSession);

            //if (pnlTop.Visible)
            //{
            //    pnlTop.Visible = false;
            //    BtnUp.ImageUrl = "~/Images/DownArrow.png";
            //}
            //else
            //{
            //    pnlTop.Visible = true;
            //    BtnUp.ImageUrl = "~/Images/UpArrow.png";
            //}
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadEditMenufordayItems(DateTime date, string session)
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsmenuitem = null;
            DataTable DT = default(DataTable);


            dsmenuitem = sqlobj.ExecuteSP("SP_GetMenuItemSessionWiseSS",
                        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = date },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = session }
                    );

            DataTable dt2 = dsmenuitem.Tables[0];
            ViewState["UItemDet"] = dt2;

            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {
                //DT = dsmenuitem.Tables[0];

                //ViewState["UItemDet"] = DT;
                rgEditMenuforday.DataSource = dsmenuitem;
                rgEditMenuforday.DataBind();
                rgEditMenuforday.Dispose();

                PanAddMenufordays.Visible = false;
                panEditMenufordays.Visible = true;

                //foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
                //{
                //    item.Selected = true;
                //}

            }
            else
            {
                rgEditMenuforday.DataSource = string.Empty;
                rgEditMenuforday.DataBind();
            }

            dsmenuitem.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    private void LoadEditMenufordayItems2(DateTime date, string session)
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsmenuitem = null;
            DataSet dsGetmenuitem = null;


            // --- Load from which item when -- //

            dsmenuitem = sqlobj.ExecuteSP("SP_GetMenuItemSessionWise",
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = date },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = session }
                    );


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {
                rgEditMenuforday.DataSource = dsmenuitem;
                rgEditMenuforday.DataBind();
                rgEditMenuforday.Dispose();

                // panLoadMenufordays.Visible = false;
                PanAddMenufordays.Visible = false;
                panEditMenufordays.Visible = true;

                //dtpUMenuforday.SelectedDate = date;
                //ddlEditMenuforday.SelectedValue = session.ToString();

            }
            else
            {
                rgEditMenuforday.DataSource = string.Empty;
                rgEditMenuforday.DataBind();

            }


            dsmenuitem.Dispose();

            //-- Load from menuforday table -- //

            dsGetmenuitem = sqlobj.ExecuteSP("SP_GetMenuForDay",
                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = date },
                   new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = session }
                   );


            if (dsGetmenuitem.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < dsGetmenuitem.Tables[0].Rows.Count; i++)
                {

                    string strItemName = dsGetmenuitem.Tables[0].Rows[i]["ItemName"].ToString();

                    foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
                    {

                        //LinkButton lnkitemname = (LinkButton)item.FindControl("lnkitemname");

                        //string strGetItemName = lnkitemname.Text;

                        string strGetItemName = item.Cells[5].Text;

                        if (strGetItemName.Equals(strItemName))
                        {
                            //item.Selected = true;

                            TextBox txtbox = (TextBox)item.FindControl("txtRowNumber");

                            txtbox.Text = dsGetmenuitem.Tables[0].Rows[i]["SNo"].ToString();
                        }

                    }

                }
            }
            else
            {
                rgEditMenuforday.DataSource = string.Empty;

            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void rgMenuforday_ItemCreated(object sender, GridItemEventArgs e)
    {
        //if (e.Item is GridHeaderItem)
        //{
        //    if (e.Item.DataItem is DataRowView)
        //    {
        //        GridHeaderItem hItem = (GridHeaderItem)e.Item;
        //        CheckBox chk1 = (CheckBox)hItem.FindControl("ChkConfirm");
        //        HiddenField2.Value = chk1.ClientID.ToString();
        //    }
        //}
    }
    protected void rgMenuforday_ItemDataBound(object sender, GridItemEventArgs e)
    {


        if (e.Item is GridDataItem)
        {

            // -- set serial No

            int strIndex = rgMenuforday.MasterTableView.CurrentPageIndex;

            TextBox txtrno = e.Item.FindControl("txtRowNumber") as TextBox;

            i = i + 5;

            txtrno.Text = i.ToString();


            // -- set total qty text color

            int idiners = Convert.ToInt32(e.Item.Cells[8].Text);
            double dTotalQty = Convert.ToDouble(e.Item.Cells[9].Text);
            double dQtyAlert = Convert.ToDouble(e.Item.Cells[11].Text);



            if (idiners != 0)
            {
                if (dQtyAlert < dTotalQty)
                {
                    e.Item.Cells[11].ForeColor = Color.Red;
                }
            }





        }
    }

    protected void btnmenufordaysave_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                int count = 0;

                //foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
                //{
                //    if (item.Selected)
                //    {
                //        count = count + 1;
                //    }
                //}

                string cdate = dtpmenuforday.SelectedDate.Value.ToString("dd-MMM-yyyy");

                //if (count > 0)
                {

                    foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
                    {


                        //if (item.Selected)
                        {



                            TextBox lblrownumber = (TextBox)item.FindControl("txtRowNumber");
                            //LinkButton lnkitemname = (LinkButton)item.FindControl("lnkitemname");


                            SqlProcsNew sqlobj = new SqlProcsNew();

                            string strSNo = lblrownumber.Text;
                            //string strItem = lnkitemname.Text;
                            string strItem = item["ItemName"].Text.ToString();
                            string strCategory = item["Category"].Text.ToString();
                            string strUom = item["Uom"].Text.ToString();
                            string strType = item["Type"].Text.ToString();
                            string strFoodType = item["FoodType"].Text.ToString();
                            int iDiners = Convert.ToInt32(item["Diners"].Text.ToString());
                            double dUsualQty = Convert.ToDouble(item["UsualQty"].Text.ToString());
                            double dTotalQty = Convert.ToDouble(item["TotalQty"].Text.ToString());
                            double dQtyAlert = Convert.ToDouble(item["QtyAlert"].Text.ToString());
                            int iLeadTime = Convert.ToInt32(item["LeadTime"].Text.ToString());

                            string stritemcode = "";


                            DataSet dsGetItemCode = sqlobj.ExecuteSP("SP_GetItemCode",
                                       new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() });

                            if (dsGetItemCode.Tables[0].Rows.Count > 0)
                            {
                                stritemcode = dsGetItemCode.Tables[0].Rows[0][0].ToString();

                            }

                            dsGetItemCode.Dispose();


                            sqlobj.ExecuteSQLNonQuery("SP_InsertMenuforday",
                                    new SqlParameter() { ParameterName = "@SNo", SqlDbType = SqlDbType.Int, Value = strSNo.ToString() },
                                    new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = stritemcode.ToString() },
                                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() },
                                    new SqlParameter() { ParameterName = "@Uom", SqlDbType = SqlDbType.NVarChar, Value = strUom.ToString() },
                                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strType.ToString() },
                                    new SqlParameter() { ParameterName = "@FoodType", SqlDbType = SqlDbType.NVarChar, Value = strFoodType.ToString() },
                                    new SqlParameter() { ParameterName = "@Diners", SqlDbType = SqlDbType.Int, Value = iDiners },
                                    new SqlParameter() { ParameterName = "@UsualQty", SqlDbType = SqlDbType.Decimal, Value = dUsualQty },
                                    new SqlParameter() { ParameterName = "@TotalQty", SqlDbType = SqlDbType.Decimal, Value = dTotalQty },
                                    new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Decimal, Value = dQtyAlert },
                                    new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = iLeadTime },
                                    new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strCategory.ToString() },
                                    new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                                    new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                    );

                        }
                    }



                    if (chkCopyType.SelectedValue == "1")
                    {

                        if (chkMenuforday1.Checked == true && dtpMenuforday1.SelectedDate != null)
                        {
                            InsertMenu(Convert.ToDateTime(dtpMenuforday1.SelectedDate));

                            cdate = cdate + "," + dtpMenuforday1.SelectedDate.Value.ToString("dd-MMM-yyyy");
                        }
                        if (chkMenuforday2.Checked == true && dtpmenuforday2.SelectedDate != null)
                        {
                            InsertMenu(Convert.ToDateTime(dtpmenuforday2.SelectedDate));

                            cdate = cdate + "," + dtpmenuforday2.SelectedDate.Value.ToString("dd-MMM-yyyy");
                        }
                        if (chkmenuforday3.Checked == true && dtpMenuforday3.SelectedDate != null)
                        {
                            InsertMenu(Convert.ToDateTime(dtpMenuforday3.SelectedDate));

                            cdate = cdate + "," + dtpMenuforday3.SelectedDate.Value.ToString("dd-MMM-yyyy");
                        }


                        if (chkmenuforday4.Checked == true && dtpmenuforday4.SelectedDate != null)
                        {
                            InsertMenu(Convert.ToDateTime(dtpmenuforday4.SelectedDate));
                            cdate = cdate + "," + dtpmenuforday4.SelectedDate.Value.ToString("dd-MMM-yyyy");
                        }
                    }

                    else if (chkCopyType.SelectedValue == "2")
                    {

                        if (dtpCopyFrom.SelectedDate != null && dtpCopyTo.SelectedDate != null)
                        {
                            InsertMenuDaily(dtpCopyFrom.SelectedDate.Value, dtpCopyTo.SelectedDate.Value);

                            cdate = Session["cdate"].ToString();
                        }


                    }

                    string strsession = Session["SessionCode"].ToString();

                    //LoadMenuforday();
                    LoadMenuStatus();
                    menufordayclear();
                    LoadChkSession();

                    ViewState["ItemDet"] = null;



                    cmbItemName.DataSource = string.Empty;
                    cmbItemName.DataBind();
                    cmbItemName.Text = string.Empty;



                    string strConfirm = "Menu items are inserted for the date " + cdate.ToString() + " (" + Session["SessionName"].ToString() + ")";

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + strConfirm + "');", true);
                }
                //else
                //{
                //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Select atleast one item to save menu for day details.');", true);

                //}
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void InsertMenu(DateTime menudate)
    {
        try
        {
            foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
            {
                //if (item.Selected)
                {

                    TextBox lblrownumber = (TextBox)item.FindControl("txtRowNumber");
                    //LinkButton lnkitemname = (LinkButton)item.FindControl("lnkitemname");

                    string strSNo = lblrownumber.Text;
                    //string strItem = lnkitemname.Text;
                    string strItem = item["ItemName"].Text.ToString();
                    string strCategory = item["Category"].Text.ToString();
                    string strUom = item["Uom"].Text.ToString();
                    string strType = item["Type"].Text.ToString();
                    string strFoodType = item["FoodType"].Text.ToString();
                    int iDiners = Convert.ToInt32(item["Diners"].Text.ToString());
                    double dUsualQty = Convert.ToDouble(item["UsualQty"].Text.ToString());
                    double dTotalQty = Convert.ToDouble(item["TotalQty"].Text.ToString());
                    double dQtyAlert = Convert.ToDouble(item["QtyAlert"].Text.ToString());
                    int iLeadTime = Convert.ToInt32(item["LeadTime"].Text.ToString());

                    SqlProcsNew sqlobj = new SqlProcsNew();


                    string stritemcode = "";


                    DataSet dsGetItemCode = sqlobj.ExecuteSP("SP_GetItemCode",
                               new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() });

                    if (dsGetItemCode.Tables[0].Rows.Count > 0)
                    {
                        stritemcode = dsGetItemCode.Tables[0].Rows[0][0].ToString();

                    }

                    dsGetItemCode.Dispose();

                    sqlobj.ExecuteSQLNonQuery("SP_InsertMenuforday",
                            new SqlParameter() { ParameterName = "@SNo", SqlDbType = SqlDbType.Int, Value = strSNo.ToString() },
                            new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = stritemcode.ToString() },
                            new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() },
                            new SqlParameter() { ParameterName = "@Uom", SqlDbType = SqlDbType.NVarChar, Value = strUom.ToString() },
                            new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strType.ToString() },
                            new SqlParameter() { ParameterName = "@FoodType", SqlDbType = SqlDbType.NVarChar, Value = strFoodType.ToString() },
                            new SqlParameter() { ParameterName = "@Diners", SqlDbType = SqlDbType.Int, Value = iDiners },
                            new SqlParameter() { ParameterName = "@UsualQty", SqlDbType = SqlDbType.Decimal, Value = dUsualQty },
                            new SqlParameter() { ParameterName = "@TotalQty", SqlDbType = SqlDbType.Decimal, Value = dTotalQty },
                            new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Decimal, Value = dQtyAlert },
                            new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = iLeadTime },
                            new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                            new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strCategory.ToString() },
                            new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = menudate },
                            new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                            );


                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    private void InsertMenuDaily(DateTime startdate, DateTime enddate)
    {
        try
        {
            foreach (DateTime date in GetDateRange(startdate, enddate))
            {
                foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
                {
                    //if (item.Selected)
                    {

                        TextBox lblrownumber = (TextBox)item.FindControl("txtRowNumber");
                        //LinkButton lnkitemname = (LinkButton)item.FindControl("lnkitemname");

                        string strSNo = lblrownumber.Text;
                        //string strItem = lnkitemname.Text;
                        string strItem = item["ItemName"].Text.ToString();
                        string strCategory = item["Category"].Text.ToString();
                        string strUom = item["Uom"].Text.ToString();
                        string strType = item["Type"].Text.ToString();
                        string strFoodType = item["FoodType"].Text.ToString();
                        int iDiners = Convert.ToInt32(item["Diners"].Text.ToString());
                        double dUsualQty = Convert.ToDouble(item["UsualQty"].Text.ToString());
                        double dTotalQty = Convert.ToDouble(item["TotalQty"].Text.ToString());
                        double dQtyAlert = Convert.ToDouble(item["QtyAlert"].Text.ToString());
                        int iLeadTime = Convert.ToInt32(item["LeadTime"].Text.ToString());

                        SqlProcsNew sqlobj = new SqlProcsNew();


                        string stritemcode = "";


                        DataSet dsGetItemCode = sqlobj.ExecuteSP("SP_GetItemCode",
                                   new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() });

                        if (dsGetItemCode.Tables[0].Rows.Count > 0)
                        {
                            stritemcode = dsGetItemCode.Tables[0].Rows[0][0].ToString();

                        }

                        dsGetItemCode.Dispose();


                        sqlobj.ExecuteSQLNonQuery("SP_InsertMenuforday",
                                new SqlParameter() { ParameterName = "@SNo", SqlDbType = SqlDbType.Int, Value = strSNo.ToString() },
                                new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = stritemcode.ToString() },
                                new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() },
                                new SqlParameter() { ParameterName = "@Uom", SqlDbType = SqlDbType.NVarChar, Value = strUom.ToString() },
                                new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strType.ToString() },
                                new SqlParameter() { ParameterName = "@FoodType", SqlDbType = SqlDbType.NVarChar, Value = strFoodType.ToString() },
                                new SqlParameter() { ParameterName = "@Diners", SqlDbType = SqlDbType.Int, Value = iDiners },
                                new SqlParameter() { ParameterName = "@UsualQty", SqlDbType = SqlDbType.Decimal, Value = dUsualQty },
                                new SqlParameter() { ParameterName = "@TotalQty", SqlDbType = SqlDbType.Decimal, Value = dTotalQty },
                                new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Decimal, Value = dQtyAlert },
                                new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = iLeadTime },
                                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                                new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strCategory.ToString() },
                                new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = date },
                                new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                );

                        Session["cdate"] = dtpmenuforday.SelectedDate.Value.ToString("dd-MMM-yyyy");

                        if (Session["cdate"] == null)
                        {
                            Session["cdate"] = date.ToString("dd-MMM-yyyy");
                        }
                        else
                        {
                            Session["cdate"] = Session["cdate"] + "," + date.ToString("dd-MMM-yyyy");
                        }

                    }
                }

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    //private void LoadMenuforday()
    //{
    //    try
    //    {
    //        SqlProcsNew sqlobj = new SqlProcsNew();

    //        DataSet dsmenuitem = null;
    //        dsmenuitem = sqlobj.ExecuteSP("SP_LoadMenuForDay");


    //        if (dsmenuitem.Tables[0].Rows.Count > 0)
    //        {
    //            rgLoadMenuforday.DataSource = dsmenuitem;
    //            rgLoadMenuforday.DataBind();
    //            rgLoadMenuforday.Dispose();
    //        }
    //        else
    //        {

    //            rgLoadMenuforday.DataSource = string.Empty;
    //            rgLoadMenuforday.DataBind();

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);
    //    }
    //}

    private void menufordayclear()
    {
        //dtpmenuforday.SelectedDate = null;


        rgSessionMenuForDay.DataSource = string.Empty;
        rgSessionMenuForDay.DataBind();


        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsFetchSE = new DataSet();

        dsFetchSE = sqlobj.ExecuteSP("SP_FetchDropDown",
             new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 });




        chkMenuforday1.Checked = false;
        chkMenuforday2.Checked = false;
        chkmenuforday3.Checked = false;
        chkmenuforday4.Checked = false;

        dtpMenuforday1.SelectedDate = null;
        dtpmenuforday2.SelectedDate = null;
        dtpMenuforday3.SelectedDate = null;
        dtpmenuforday4.SelectedDate = null;


        LoadMenuStatus();



        rgMenuforday.DataSource = string.Empty;
        rgMenuforday.DataBind();



    }

    private List<DateTime> GetDateRange(DateTime StartingDate, DateTime EndingDate)
    {
        if (StartingDate > EndingDate)
        {
            return null;
        }
        List<DateTime> rv = new List<DateTime>();
        DateTime tmpDate = StartingDate;
        do
        {
            rv.Add(tmpDate);
            tmpDate = tmpDate.AddDays(1);
        } while (tmpDate <= EndingDate);
        return rv;
    }

    protected void btnmenufordayclear_Click(object sender, EventArgs e)
    {
        try
        {

            menufordayclear();

            lblATotalDiners.Text = "";
            lblAMainItem.Text = "";
            lblASubItem.Text = "";


            cmbItemName.DataSource = string.Empty;
            cmbItemName.DataBind();
            cmbItemName.Text = string.Empty;

            ViewState["ItemDet"] = null;

            cmbUItemName.DataSource = string.Empty;
            cmbUItemName.DataBind();
            cmbUItemName.Text = string.Empty;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnmenufordayclose_Click(object sender, EventArgs e)
    {
        try
        {

            dtpmenuforday.SelectedDate = null;

            rgSessionMenuForDay.DataSource = string.Empty;
            rgSessionMenuForDay.DataBind();

            // panLoadMenufordays.Visible = true;
            PanAddMenufordays.Visible = false;
            panEditMenufordays.Visible = false;

            rgMenuforday.DataSource = string.Empty;
            rgMenuforday.DataBind();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnUpdateMenuforday_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                int count = 0;

                //foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
                //{
                //    if (item.Selected)
                //    {
                //        count = count + 1;
                //    }
                //}

                //if (count > 0)
                {


                    SqlProcsNew sqlobj = new SqlProcsNew();

                    //-- Delete Existing Menu --//

                    sqlobj.ExecuteSQLNonQuery("SP_DeleteMenuForDay",
                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate },
                   new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() }
                   );


                    // -- Insert New Menu -- //





                    foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
                    {
                        //if (item.Selected)
                        {

                            TextBox lblrownumber = (TextBox)item.FindControl("txtRowNumber");
                            //LinkButton lnkitemname = (LinkButton)item.FindControl("lnkitemname");


                            string strSNo = lblrownumber.Text;
                            //string strItem = lnkitemname.Text;
                            string strItem = item["ItemName"].Text.ToString();
                            string strCategory = item["Category"].Text.ToString();
                            string strUom = item["Uom"].Text.ToString();
                            string strType = item["Type"].Text.ToString();
                            string strFoodType = item["FoodType"].Text.ToString();
                            int iDiners = Convert.ToInt32(item["Diners"].Text.ToString());
                            double dUsualQty = Convert.ToDouble(item["UsualQty"].Text.ToString());
                            double dTotalQty = Convert.ToDouble(item["TotalQty"].Text.ToString());
                            double dQtyAlert = Convert.ToDouble(item["QtyAlert"].Text.ToString());
                            int iLeadTime = Convert.ToInt32(item["LeadTime"].Text.ToString());


                            string stritemcode = "";


                            DataSet dsGetItemCode = sqlobj.ExecuteSP("SP_GetItemCode",
                                       new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() });

                            if (dsGetItemCode.Tables[0].Rows.Count > 0)
                            {
                                stritemcode = dsGetItemCode.Tables[0].Rows[0][0].ToString();

                            }

                            dsGetItemCode.Dispose();



                            sqlobj.ExecuteSQLNonQuery("SP_InsertMenuforday",
                                    new SqlParameter() { ParameterName = "@SNo", SqlDbType = SqlDbType.Int, Value = strSNo.ToString() },
                                     new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = stritemcode.ToString() },
                                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = strItem.ToString() },
                                    new SqlParameter() { ParameterName = "@Uom", SqlDbType = SqlDbType.NVarChar, Value = strUom.ToString() },
                                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = strType.ToString() },
                                    new SqlParameter() { ParameterName = "@FoodType", SqlDbType = SqlDbType.NVarChar, Value = strFoodType.ToString() },
                                    new SqlParameter() { ParameterName = "@Diners", SqlDbType = SqlDbType.Int, Value = iDiners },
                                    new SqlParameter() { ParameterName = "@UsualQty", SqlDbType = SqlDbType.Decimal, Value = dUsualQty },
                                    new SqlParameter() { ParameterName = "@TotalQty", SqlDbType = SqlDbType.Decimal, Value = dTotalQty },
                                    new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Decimal, Value = dQtyAlert },
                                    new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = iLeadTime },
                                    new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() },
                                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strCategory.ToString() },
                                    new SqlParameter() { ParameterName = "@MenuDate", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                                    new SqlParameter() { ParameterName = "@CreatedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                                    );

                        }
                    }

                    string dtpEditMenuforday = dtpmenuforday.SelectedDate.Value.ToString("dd-MMM-yyyy");
                    string strsession = Session["SessionCode"].ToString();

                    //menufordayclear();

                    //panLoadMenufordays.Visible = true;
                    PanAddMenufordays.Visible = false;

                    rgEditMenuforday.DataSource = string.Empty;
                    rgEditMenuforday.DataBind();

                    ViewState["UItemDet"] = null;


                    cmbUItemName.DataSource = string.Empty;
                    cmbUItemName.DataBind();
                    cmbUItemName.Text = string.Empty;



                    string stralert = "Menu items are updated for the date " + dtpEditMenuforday.ToString() + " (" + Session["SessionName"].ToString() + ")";

                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + stralert + "');", true);

                }
                //else
                //{

                //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select atleast one item update the menu for day details.');", true);
                //}
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnCloseMenuforday_Click(object sender, EventArgs e)
    {
        try
        {
            //panLoadMenufordays.Visible = true;
            //PanAddMenufordays.Visible = false;
            //panEditMenufordays.Visible = false;

            dtpmenuforday.SelectedDate = null;


            rgSessionMenuForDay.DataSource = string.Empty;
            rgSessionMenuForDay.DataBind();

            rgEditMenuforday.DataSource = string.Empty;
            rgEditMenuforday.DataBind();

            lblTotalDiners.Text = "";
            lblMainItem.Text = "";
            lblSubItem.Text = "";

             
            ViewState["UItemDet"] = null;

            cmbUItemName.DataSource = string.Empty;
            cmbUItemName.DataBind();
            cmbUItemName.Text = string.Empty;


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnmenufordayexporttoexcel_Click(object sender, EventArgs e)
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsmenuitem = null;


            DateTime cdate = dtpmenuforday.SelectedDate.Value;

            dsmenuitem = sqlobj.ExecuteSP("SP_GetMenufordayExporttoExcel",
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = Session["SessionCode"].ToString() }

                    );


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsmenuitem.Tables[0];
                dg.DataBind();

                // THE EXCEL FILE.
                string sFileName = "Menuforday-" + cdate.ToString("dd-MM-yyyy") + " - " + Session["SessionName"].ToString() + ".xls";
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


                Response.Write("<table><tr><td>MenuForDay</td><td>Menu Date:" + cdate.ToString("dd-MM-yyyy") + "</td><td>Session:" + Session["SessionName"].ToString() + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show("" + dtpmenuforday.SelectedDate.Value + "-" + Session["SessionName"].ToString() + " Menu does not exist");
            }

        }
        catch (Exception ex)
        {
            //WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadMenuItems(string sessioncode, int RSN)
    {
        i = 0;

        if (dtpmenuforday.SelectedDate != null)
        {


            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsmenuitem = null;
            dsmenuitem = sqlobj.ExecuteSP("SP_GetMenuItemSessionWiseSS",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = sessioncode.ToString() },
                     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = cmbItemName.SelectedValue }

                    );


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {
                rgMenuforday.DataSource = dsmenuitem;
                rgMenuforday.DataBind();
                rgMenuforday.Dispose();
            }
            else
            {

                rgMenuforday.DataSource = dsmenuitem;
                rgMenuforday.DataBind();
                rgMenuforday.Dispose();
            }

        }
        else
        {
            WebMsgBox.Show("Please select the date");
        }
    }


    private void LoadDate(string sessioncode)
    {

        try
        {

            DateTime getday = Convert.ToDateTime(dtpmenuforday.SelectedDate);

            string selectedday = getday.ToString("dddd");

            var startDate = getday;
            var first = new DateTime(startDate.Year, startDate.Month, 1);
            List<DateTime> weekends = new List<DateTime>();
            for (int i = 0; i <= DateTime.DaysInMonth(startDate.Year, startDate.Month); i++)
            {
                var nextDay = first.AddDays(i);

                string sday = nextDay.DayOfWeek.ToString();

                if (sday.Equals(selectedday))
                {

                    DateTime ddate = Convert.ToDateTime(nextDay);

                    string sgdate = getday.ToString("dd/MM/yyyy");
                    string ggdate = ddate.ToString("dd/MM/yyyy");

                    if (!sgdate.Equals(ggdate))
                    {

                        if (ddate > getday)
                        {

                            SqlProcsNew obj = new SqlProcsNew();

                            DataSet dscheck = obj.ExecuteSP("SP_CheckMenuDate",
                            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = ddate },
                            new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.Int, Value = sessioncode.ToString() }
                            );



                            if (dscheck.Tables[0].Rows.Count == 0)
                            {


                                if (dtpMenuforday1.SelectedDate == null)
                                {
                                    dtpMenuforday1.SelectedDate = ddate;
                                }
                                else if (dtpmenuforday2.SelectedDate == null)
                                {
                                    dtpmenuforday2.SelectedDate = ddate;
                                }
                                else if (dtpMenuforday3.SelectedDate == null)
                                {
                                    dtpMenuforday3.SelectedDate = ddate;
                                }
                                else if (dtpmenuforday4.SelectedDate == null)
                                {
                                    dtpmenuforday4.SelectedDate = ddate;
                                }


                            }

                            dscheck.Dispose();


                        }
                    }

                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }




    protected void LnkSessionMenuforday_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkEdititemBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdititemBtn.NamingContainer;

            // TableCell cell=(TableCell)row[""]

            LinkButton lnkstatus = (LinkButton)row.FindControl("LnkSessionMenuforday");

            string Status;
            Status = lnkstatus.Text;



            Session["SessionName"] = row.Cells[2].Text;


            string sessioncode = lnkstatus.CommandArgument.ToString();


            Session["SessionCode"] = sessioncode.ToString();
            DateTime date = dtpmenuforday.SelectedDate.Value;

            if (Status == "Click to Set")
            {
                panNotSet.Visible = true;
                PanAddMenufordays.Visible = true;

                panEditMenufordays.Visible = false;

                LoadDate(sessioncode);

                LoadItemDet(sessioncode);

                //LoadMenuItems(sessioncode);



                string strTotalDiners = "0";
                int iMainItem = 0;
                int iSubItem = 0;

                foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
                {

                    strTotalDiners = item["Diners"].Text.ToString();
                    string strCategory = item["Category"].Text.ToString();

                    if (strCategory.ToString() == "Main")
                    {
                        iMainItem = iMainItem + 1;
                    }

                    if (strCategory.ToString() == "Sub")
                    {
                        iSubItem = iSubItem + 1;
                    }



                }


                lblATotalDiners.Text = "(" + date.ToString("dd-MMM-yyyy") + ") - " + Session["SessionName"].ToString();
                //rgMenuforday.Height = 500;
                // lblATotalDiners.Text = "Estimated Diners:" + strTotalDiners.ToString();
                //lblAMainItem.Text = "  Main Items:" + iMainItem.ToString();
                // lblASubItem.Text = "  Sub Items:" + iSubItem.ToString();

            }
            else
            {
                panNotSet.Visible = false;
                PanAddMenufordays.Visible = false;

                panEditMenufordays.Visible = true;


                string strSession = Session["SessionName"].ToString();

                LoadUItemDet(sessioncode);

                LoadEditMenufordayItems(date, sessioncode);

                string strTotalDiners = "0";
                int iMainItem = 0;
                int iSubItem = 0;

                foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
                {
                    //if (item.Selected)
                    //{
                    strTotalDiners = item["Diners"].Text.ToString();
                    string strCategory = item["Category"].Text.ToString();

                    if (strCategory.ToString() == "Main")
                    {
                        iMainItem = iMainItem + 1;
                    }

                    if (strCategory.ToString() == "Sub")
                    {
                        iSubItem = iSubItem + 1;
                    }


                    //}
                }


                lblTotalDiners.Text = "(" + date.ToString("dd-MMM-yyyy") + ") - " + Session["SessionName"].ToString();
                //rgEditMenuforday.Height = 500;
                //lblTotalDiners.Text = "Estimated Diners:" + strTotalDiners.ToString();
                //lblMainItem.Text = " Main Items:" + iMainItem.ToString();
                //lblSubItem.Text = " Sub Items:" + iSubItem.ToString();
            }
            //if (pnlTop.Visible)
            //{
            //    pnlTop.Visible = false;
            //    BtnUp.ImageUrl = "~/Images/DownArrow.png";
            //}
            //else
            //{
            //    pnlTop.Visible = true;
            //    BtnUp.ImageUrl = "~/Images/UpArrow.png";
            //}




        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    //protected void BtnUp_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    //{
    //    try
    //    {

    //        if (pnlTop.Visible)
    //        {
    //            pnlTop.Visible = false;
    //            BtnUp.ImageUrl = "~/Images/DownArrow.png";                
    //        }
    //        else
    //        {
    //            pnlTop.Visible = true;
    //            BtnUp.ImageUrl = "~/Images/UpArrow.png";               
    //        }           
    //    }
    //    catch (System.Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message);
    //    }
    //    finally
    //    {
    //    }
    //}


    protected void LoadItemDet(string sessioncode)
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_GetMenuItemSessionWiseSS",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = sessioncode.ToString() });

            cmbItemName.DataSource = dsResident.Tables[0];
            cmbItemName.DataValueField = "RSN";
            cmbItemName.DataTextField = "ItemName";
            cmbItemName.DataBind();
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbItemName.Items.Add(item2);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void btnAddItem_Click(object sender, EventArgs e)
    {
        ////LoadMenuItems2();              
        AddtoList();       

    }
    protected void cmbItemName_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        AddtoList();
    }
   
    protected void AddtoList()
    {
        try
        {
            if (cmbItemName.Text == string.Empty || cmbItemName.Text == "" || cmbItemName.Text == "Please Select")
            {
                WebMsgBox.Show("Select a session/menu item to add!");
                return;
            }

            foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
            {
                string strItem = item["ItemName"].Text.ToString();
                string strItem2 = cmbItemName.Text;
                if (strItem == strItem2)
                {
                    WebMsgBox.Show("Selected menu item has already been added to the list!");
                    return;
                }
            }



            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsmenuitem = null;
            dsmenuitem = sqlobj.ExecuteSP("SP_GetMenuItemSessionWiseSS",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = cmbItemName.SelectedValue }

                    );


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {

                rgMenuforday.DataSource = dsmenuitem;
                rgMenuforday.DataBind();
                //rgMenuforday.Dispose();
            }

            LoadItem();

            //foreach (GridDataItem item in rgMenuforday.MasterTableView.Items)
            //{

            //    item.Selected = true;  

            //}
        }
        catch (Exception ex)
        {

        }
    }
    protected void LoadItem()
    {
        if (ViewState["ItemDet"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["ItemDet"];


            foreach (GridDataItem row in rgMenuforday.Items) // loops through each rows in RadGrid
            {
                DataRow dr = dtCurrentTable.NewRow();
                foreach (GridColumn col in rgMenuforday.Columns) //loops through each column in RadGrid
                    dr[col.UniqueName] = row[col.UniqueName].Text;
                dtCurrentTable.Rows.Add(dr);
            }


            ViewState["ItemDet"] = dtCurrentTable;


            //DataSet ds2 = new DataSet();
            //ds2.Tables.Add(dtCurrentTable);

            rgMenuforday.DataSource = dtCurrentTable;
            rgMenuforday.DataBind();


        }

        else
        {
            DataTable dtCurrentTable2 = new DataTable();

            foreach (GridColumn col in rgMenuforday.Columns)
            {
                DataColumn colString = new DataColumn(col.UniqueName);
                dtCurrentTable2.Columns.Add(colString);

            }
            foreach (GridDataItem row in rgMenuforday.Items) // loops through each rows in RadGrid
            {
                DataRow dr = dtCurrentTable2.NewRow();
                foreach (GridColumn col in rgMenuforday.Columns) //loops through each column in RadGrid
                    dr[col.UniqueName] = row[col.UniqueName].Text;
                dtCurrentTable2.Rows.Add(dr);
            }


            ViewState["ItemDet"] = dtCurrentTable2;


        }


    }


    protected void LoadUItemDet(string sessioncode)
    {
        try
        {
            DataSet dsResident = new DataSet();
            dsResident = sqlobj.ExecuteSP("SP_GetMenuItemSessionWiseSS",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = sessioncode.ToString() });

            cmbUItemName.DataSource = dsResident.Tables[0];
            cmbUItemName.DataValueField = "RSN";
            cmbUItemName.DataTextField = "ItemName";
            cmbUItemName.DataBind();
            RadComboBoxItem item2 = new RadComboBoxItem();
            item2.Text = "Please Select";
            item2.Value = "0";
            item2.Selected = true;
            cmbUItemName.Items.Add(item2);
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void btnUAddItem_Click(object sender, EventArgs e)
    {
        AddtoList1();      
    }

    protected void cmbUItemName_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        AddtoList1();
    }
    protected void AddtoList1()
    {
        try
        {
            ViewState["UItemDet"] = null;

            if (cmbUItemName.Text == string.Empty || cmbUItemName.Text == "" || cmbUItemName.Text == "Please Select")
            {
                WebMsgBox.Show("Select a session/menu item to add");
                return;
            }

            foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
            {
                string strItem = item["ItemName"].Text.ToString();
                string strItem2 = cmbUItemName.Text;
                if (strItem == strItem2)
                {
                    WebMsgBox.Show("Selected menu item has already been added to the list!");
                    return;
                }
            }

            DataTable dtCurrentTable2 = new DataTable();

            foreach (GridColumn col in rgEditMenuforday.Columns)
            {
                DataColumn colString = new DataColumn(col.UniqueName);
                dtCurrentTable2.Columns.Add(colString);

            }
            foreach (GridDataItem row in rgEditMenuforday.Items) // loops through each rows in RadGrid
            {
                DataRow dr = dtCurrentTable2.NewRow();
                foreach (GridColumn col in rgEditMenuforday.Columns) //loops through each column in RadGrid
                    dr[col.UniqueName] = row[col.UniqueName].Text;
                dtCurrentTable2.Rows.Add(dr);
            }


            ViewState["UItemDet"] = dtCurrentTable2;


            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsmenuitem = null;
            dsmenuitem = sqlobj.ExecuteSP("SP_GetMenuItemSessionWiseSS",
                     new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpmenuforday.SelectedDate.Value },
                     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = cmbUItemName.SelectedValue }

                    );


            if (dsmenuitem.Tables[0].Rows.Count > 0)
            {

                rgEditMenuforday.DataSource = dsmenuitem;
                rgEditMenuforday.DataBind();
                //rgMenuforday.Dispose();
            }


            DataTable dtCurrentTable = (DataTable)ViewState["UItemDet"];


            foreach (GridDataItem row in rgEditMenuforday.Items) // loops through each rows in RadGrid
            {
                DataRow dr = dtCurrentTable.NewRow();
                foreach (GridColumn col in rgEditMenuforday.Columns) //loops through each column in RadGrid
                    dr[col.UniqueName] = row[col.UniqueName].Text;
                dtCurrentTable.Rows.Add(dr);
            }


            ViewState["UItemDet"] = dtCurrentTable;


            //DataSet ds2 = new DataSet();
            //ds2.Tables.Add(dtCurrentTable);

            rgEditMenuforday.DataSource = ViewState["UItemDet"];
            rgEditMenuforday.DataBind();


            //foreach (GridDataItem item in rgEditMenuforday.MasterTableView.Items)
            //{


            //        item.Selected = true;


            //}
        }
        catch (Exception ex)
        {

        }
    }
    protected void rgEditMenuforday_ItemDataBound(object sender, GridItemEventArgs e)
    {


        if (e.Item is GridDataItem)
        {

            // -- set serial No

            int strIndex = rgMenuforday.MasterTableView.CurrentPageIndex;

            TextBox txtrno = e.Item.FindControl("txtRowNumber") as TextBox;

            j = j + 5;

            txtrno.Text = j.ToString();


            // -- set total qty text color

            int idiners = Convert.ToInt32(e.Item.Cells[8].Text);
            //double dTotalQty = Convert.ToDouble(e.Item.Cells[9].Text);
            //double dQtyAlert = Convert.ToDouble(e.Item.Cells[11].Text);



            //if (idiners != 0)
            //{
            //    if (dQtyAlert < dTotalQty)
            //    {
            //        e.Item.Cells[11].ForeColor = Color.Red;
            //    }
            //}



        }
    }


    protected void rgMenuforday_DeleteCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Session["DataSource"] = ViewState["ItemDet"];
        string ID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ItemCode"].ToString();
        DataTable table = (DataTable)ViewState["ItemDet"];

        DataColumn[] keyColumns = new DataColumn[1];
        keyColumns[0] = table.Columns["ItemCode"];
        table.PrimaryKey = keyColumns;

        if (table.Rows.Find(ID) != null)
        {
            table.Rows.Find(ID).Delete();
            table.AcceptChanges();
            ViewState["ItemDet"] = table;
        }

        rgMenuforday.DataSource = ViewState["ItemDet"];
        rgMenuforday.DataBind();
    }


    protected void rgEditMenuforday_DeleteCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Session["DataSource"] = ViewState["UItemDet"];
        string ID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["ItemCode"].ToString();
        DataTable table = (DataTable)ViewState["UItemDet"];

        DataColumn[] keyColumns = new DataColumn[1];
        keyColumns[0] = table.Columns["ItemCode"];
        table.PrimaryKey = keyColumns;

        if (table.Rows.Find(ID) != null)
        {
            table.Rows.Find(ID).Delete();
            table.AcceptChanges();
            ViewState["UItemDet"] = table;
        }

        rgEditMenuforday.DataSource = ViewState["UItemDet"];
        rgEditMenuforday.DataBind();
    }
   
}