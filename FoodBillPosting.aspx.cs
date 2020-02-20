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

public partial class Account_FoodBillPosting : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());


    protected void Page_Load(object sender, EventArgs e)
    {

        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;
        if (!IsPostBack)
        {

            dsDT = proc.ExecuteSP("GetServerDateTime");                
            
            var startDate = new DateTime(Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]).Year, Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]).Month, 1);
            BillingDate.MinDate = Convert.ToDateTime(startDate);

            BillingDate.MaxDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);

            BillingDate.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);       

            Session["TotAmnt"] = "0";           
           
            LoadSession();
            LoadGrid();
            

                   
        }
        
    }

    protected void LoadGrid1()
    {

        SqlCommand cmd = new SqlCommand("[SP_FetchGBilledTransaction]", con);
        cmd.CommandType = CommandType.StoredProcedure;       
        cmd.Parameters.Add("@BCode ", SqlDbType.NVarChar).Value = ddlSession.SelectedValue;
        cmd.Parameters.Add("@TxnDate", SqlDbType.DateTime).Value = BillingDate.SelectedDate;       
        DataSet dsGrid = new DataSet();
        ReportList.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            ReportList.DataSource = dsGrid.Tables[0];
            ReportList.DataBind();

            ReportList.AllowPaging = true;
            lblTotalAmt.Text = "Total Amount : " + dsGrid.Tables[1].Rows[0]["TotAmount"].ToString();

        }
        else
        {
            ReportList.DataSource = new String[] { };
            ReportList.DataBind();
        }
        
    }

    protected void ReportList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid1();
    }

    protected void rbBilled_OnCheckedChange(object sender, EventArgs e)
    {
        LoadSession();
        LoadGrid();

        if (rbBilled.Checked == true)
        {
            pnlBilled.Visible = true;
            pnlYetToBill.Visible = false;
            LoadGrid1();
        }
        else if (rbYetToBill.Checked == true)
        {
            pnlBilled.Visible = false;
            pnlYetToBill.Visible = true;
        }

        lblSessionRate.Text = string.Empty;
        lblTotalAmt.Text = string.Empty;
       
    }

    protected void BillingDate_Changed(object sender, EventArgs e)
    {
        LoadSession();
        LoadGrid();
        LoadGrid1();
    }

    protected void LoadSession()
    {         
        try
        {           
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistBCode = new DataSet();

            if(rbYetToBill.Checked == true)
            {
                ddlistBCode = sqlobj.ExecuteSP("SP_FetchSessionCode",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@FBDate", SqlDbType = SqlDbType.DateTime, Value = BillingDate.SelectedDate });
            }
            else if(rbBilled.Checked == true)
            {
                ddlistBCode = sqlobj.ExecuteSP("SP_FetchSessionCode",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@FBDate", SqlDbType = SqlDbType.DateTime, Value = BillingDate.SelectedDate });
            }

           
            ddlSession.DataSource = ddlistBCode.Tables[0];
            ddlSession.DataValueField = "BCode";
            ddlSession.DataTextField = "BCodeDescription";
            ddlSession.DataBind();
            ddlSession.Dispose();
            ddlSession.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void ddlSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsSessionRT = new DataSet();
        Decimal GrandTotal = 0;
        int PCount = 0;

        dsSessionRT = sqlobj.ExecuteSP("[SP_FetchBillingRatetotextbox]",
             new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
             new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue });

        if (dsSessionRT.Tables[0].Rows.Count > 0)
        {
            lblSessionRate.Text = dsSessionRT.Tables[0].Rows[0]["Rate"].ToString();            
            foreach (GridDataItem Item in FoodBillingListView.Items)
            {
                RadNumericTextBox TxtBillfor = (RadNumericTextBox)Item.FindControl("TxtBillFor");
                Decimal BillingRate = Convert.ToDecimal(lblSessionRate.Text.ToString());
                Decimal Billfor = Decimal.Parse(TxtBillfor.Text.ToString());
                RadNumericTextBox Amount = (RadNumericTextBox)Item.FindControl("TxtAmnt");
                Amount.Text = Convert.ToString(Billfor * BillingRate);
                GrandTotal = GrandTotal + Convert.ToDecimal(Amount.Text.ToString());

                RadNumericTextBox rtbPCount = (RadNumericTextBox)Item.FindControl("TxtBillFor");
                PCount = PCount + Convert.ToInt16(rtbPCount.Text.ToString());
            }
            GridFooterItem footeritem = (GridFooterItem)FoodBillingListView.MasterTableView.GetItems(GridItemType.Footer)[0];
            RadNumericTextBox Total = (RadNumericTextBox)footeritem.FindControl("lblTotalAmnt");
            Total.Text = GrandTotal.ToString();
            RadNumericTextBox PCTotal = (RadNumericTextBox)footeritem.FindControl("lblPCount");
            PCTotal.Text = PCount.ToString();
        }

        else
        {
            lblSessionRate.Text = string.Empty;
            foreach (GridDataItem Item in FoodBillingListView.Items)
            {
                RadNumericTextBox Amount = (RadNumericTextBox)Item.FindControl("TxtAmnt");
                Amount.Text = string.Empty;
            }
            GridFooterItem footeritem = (GridFooterItem)FoodBillingListView.MasterTableView.GetItems(GridItemType.Footer)[0];
            RadNumericTextBox Total = (RadNumericTextBox)footeritem.FindControl("lblTotalAmnt");
            Total.Text = string.Empty;
        }
        LoadGrid1();
    
    }

    

   
   
   
    protected void LoadGrid()
    {


        SqlCommand cmd = new SqlCommand("SP_General", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 9;
        DataSet dsGrid = new DataSet();
        

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            FoodBillingListView.DataSource = dsGrid.Tables[0];
            FoodBillingListView.DataBind();

            FoodBillingListView.AllowPaging = true;

        }
        else
        {
            FoodBillingListView.DataSource = new String[] { };
            FoodBillingListView.DataBind();
        }
       

    }   

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        string Uname = Session["UserID"].ToString();
        if (HResult.Value == "true")
        {
            GridFooterItem footeritem2 = (GridFooterItem)FoodBillingListView.MasterTableView.GetItems(GridItemType.Footer)[0];
            RadNumericTextBox Total2 = (RadNumericTextBox)footeritem2.FindControl("lblTotalAmnt");
            RadNumericTextBox PCount2 = (RadNumericTextBox)footeritem2.FindControl("lblPCount");
            if (Total2.Text != string.Empty)
            {
                foreach (GridItem rw in FoodBillingListView.Items)
                {
                    //DropDownList dlist = (DropDownList)rw.FindControl("ddlBillingCode");
                    //RadNumericTextBox BRate = (RadNumericTextBox)rw.FindControl("TxtBillCodeRate");
                    //var Total = (RadNumericTextBox)footeritem.FindControl("lblTotalAmnt");
                    //Decimal DailyTotal = Decimal.Parse(Total.Text.ToString());

                    int RTRSN = Convert.ToInt32(rw.Cells[3].Text);
                    RadNumericTextBox Bill = (RadNumericTextBox)rw.FindControl("TxtBillFor");
                    int Billfor = Convert.ToInt32(Bill.Text.ToString());
                    RadNumericTextBox Amount = (RadNumericTextBox)rw.FindControl("TxtAmnt");                    
                    Decimal BillingRate = Convert.ToDecimal(lblSessionRate.Text.ToString());
                    GridFooterItem footeritem = (GridFooterItem)FoodBillingListView.MasterTableView.GetItems(GridItemType.Footer)[0];                  
                    Decimal TAmount = Decimal.Parse(Amount.Text.ToString());

                    try
                    {
                        

                        CheckBox Check = (CheckBox)rw.FindControl("ChkConfirm");
                        if (Check.Checked == true)
                        {
                          
                            sqlobj.ExecuteSQLNonQuery("[SP_InsertFoodBillPostingDtls]",
                                        new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RTRSN },
                                        new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue },
                                        new SqlParameter() { ParameterName = "@BRate", SqlDbType = SqlDbType.Decimal, Value = BillingRate },
                                        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = BillingDate.SelectedDate.ToString() },
                                        new SqlParameter() { ParameterName = "@Bcount", SqlDbType = SqlDbType.Int, Value = Billfor },
                                        new SqlParameter() { ParameterName = "@BAmount", SqlDbType = SqlDbType.Decimal, Value = TAmount },
                                        new SqlParameter() { ParameterName = "@DTotAmount", SqlDbType = SqlDbType.Decimal, Value =Convert.ToDecimal(Total2.Text.ToString()) },
                                        new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Uname });

                           
                        }
                        else
                        {

                        }
                    }

                    catch (Exception ex)
                    {
                        WebMsgBox.Show(ex.Message.ToString());
                    }
                }

                sqlobj.ExecuteSQLNonQuery("[SP_InsertGrpFoodBillLog]",                           
                            new SqlParameter() { ParameterName = "@BDate", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = Convert.ToDateTime(BillingDate.SelectedDate.ToString()) },
                            new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = ddlSession.SelectedValue.ToString() },
                            new SqlParameter() { ParameterName = "@Dcount", SqlDbType = SqlDbType.Int, Value = Convert.ToInt16(PCount2.Text.ToString()) },
                            new SqlParameter() { ParameterName = "@DTotAmount", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Total2.Text.ToString()) },  
                            new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Uname });

                WebMsgBox.Show("Bill Detail Saved.");
                LoadSession();
                LoadGrid();
                LoadGrid1();
            }

            else
            {
                WebMsgBox.Show("Please select the session.");
            }

            

        }



        else
        {

        }
    }

    protected void FoodBillingListView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid();
    }

    protected void TxtBillFor_TextChanged(object sender, EventArgs e)
    {
        if (lblSessionRate.Text.ToString() != string.Empty || lblSessionRate.Text.ToString() != "")
        {
            Decimal GrandTotal2 = 0;
            int PCount2 = 0;
            foreach (GridDataItem Item in FoodBillingListView.Items)
            {
                RadNumericTextBox TxtBillfor = (RadNumericTextBox)Item.FindControl("TxtBillFor");
                Decimal BillingRate = Convert.ToDecimal(lblSessionRate.Text.ToString());
                Decimal Billfor = Decimal.Parse(TxtBillfor.Text.ToString());
                RadNumericTextBox Amount = (RadNumericTextBox)Item.FindControl("TxtAmnt");
                Amount.Text = Convert.ToString(Billfor * BillingRate);
                GrandTotal2 = GrandTotal2 + Convert.ToDecimal(Amount.Text.ToString());
                RadNumericTextBox rtbPCount = (RadNumericTextBox)Item.FindControl("TxtBillFor");
                PCount2 = PCount2 + Convert.ToInt16(rtbPCount.Text.ToString());   
            }
            GridFooterItem footeritem = (GridFooterItem)FoodBillingListView.MasterTableView.GetItems(GridItemType.Footer)[0];
            RadNumericTextBox Total = (RadNumericTextBox)footeritem.FindControl("lblTotalAmnt");
            Total.Text = GrandTotal2.ToString();
            RadNumericTextBox PCTotal2 = (RadNumericTextBox)footeritem.FindControl("lblPCount");
            PCTotal2.Text = PCount2.ToString();
            LoadGrid1();
        }

        else
        {
            foreach (GridDataItem Item in FoodBillingListView.Items)
            {
                RadNumericTextBox Amount = (RadNumericTextBox)Item.FindControl("TxtAmnt");
                Amount.Text = string.Empty;
            }
            GridFooterItem footeritem = (GridFooterItem)FoodBillingListView.MasterTableView.GetItems(GridItemType.Footer)[0];
            RadNumericTextBox Total = (RadNumericTextBox)footeritem.FindControl("lblTotalAmnt");
            Total.Text = string.Empty;
        }

       


        //Decimal GrandTotal2 = 0;
        //foreach (GridItem Item in FoodBillingListView.Items)
       
        //{

        //    SqlProcsNew sqlobj = new SqlProcsNew();
        //    DataSet TxtRate = new DataSet();
            
        //    DropDownList ddlist = (DropDownList)Item.FindControl("ddlBillingCode");


        //    TxtRate = sqlobj.ExecuteSP("[SP_FetchBillingRatetotextbox]",
        //         new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
        //         new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = ddlist.SelectedValue });
        //    if (TxtRate.Tables[0].Rows.Count > 0)
        //    {
                
        //        RadNumericTextBox TxtBillfor = (RadNumericTextBox)Item.FindControl("TxtBillFor");
        //        RadNumericTextBox BRate = (RadNumericTextBox)Item.FindControl("TxtBillCodeRate");
        //        BRate.Text = TxtRate.Tables[0].Rows[0]["Rate"].ToString();
        //        Decimal BillingRate = Convert.ToDecimal(TxtRate.Tables[0].Rows[0]["Rate"].ToString());
        //        Decimal Billfor = Decimal.Parse(TxtBillfor.Text.ToString());
                
        //        RadNumericTextBox Amount = (RadNumericTextBox)Item.FindControl("TxtAmnt");
        //        Amount.Text = Convert.ToString(Billfor * BillingRate);
        //        GrandTotal2 = GrandTotal2 + Convert.ToDecimal(Amount.Text.ToString());
        //    }
        //    else
        //    {
        //        WebMsgBox.Show("Select Billing Code and Billing Date.");
        //        return;
        //    }

        //}

        //GridFooterItem footeritem = (GridFooterItem)FoodBillingListView.MasterTableView.GetItems(GridItemType.Footer)[0];
        //RadNumericTextBox Total = (RadNumericTextBox)footeritem.FindControl("lblTotalAmnt");
        //Total.Text = GrandTotal2.ToString();


        

    }

    protected void ClearScr()
    {

        BillingDate.SelectedDate = DateTime.Now;
        
        this.BillingDate.Focus();


    }

    

    //protected void ddlBillingCode_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    DropDownList list = (DropDownList)sender;
    //    GridDataItem item = (GridDataItem)list.NamingContainer;
    //    int ChkSI = item.RowIndex;
    //    Decimal GrandTotal = 0;
    //    string str = list.SelectedValue;
    //    if (ChkSI == 2)
    //    {
    //        foreach (GridDataItem Itm in FoodBillingListView.Items)
    //        {
    //            DropDownList dlist = (DropDownList)Itm.FindControl("ddlBillingCode");
    //            dlist.SelectedValue = str;
    //        }

    //    }

    //    foreach (GridDataItem Item in FoodBillingListView.Items)
    //    {

    //        SqlProcsNew sqlobj = new SqlProcsNew();
    //        DataSet TxtRate = new DataSet();
    //        DropDownList ddlist = (DropDownList)Item.FindControl("ddlBillingCode");

    //        TxtRate = sqlobj.ExecuteSP("[SP_FetchBillingRatetotextbox]",
    //             new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
    //             new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = ddlist.SelectedValue });
    //        if (TxtRate.Tables[0].Rows.Count > 0)
    //        {                
    //            RadNumericTextBox TxtBillfor = (RadNumericTextBox)Item.FindControl("TxtBillFor");
    //            RadNumericTextBox BRate = (RadNumericTextBox)Item.FindControl("TxtBillCodeRate");
    //            BRate.Text = TxtRate.Tables[0].Rows[0]["Rate"].ToString();
    //            Decimal BillingRate = Convert.ToDecimal(TxtRate.Tables[0].Rows[0]["Rate"].ToString());
    //            Decimal Billfor = Decimal.Parse(TxtBillfor.Text.ToString());                
    //            RadNumericTextBox Amount = (RadNumericTextBox)Item.FindControl("TxtAmnt");
    //            Amount.Text = Convert.ToString(Billfor * BillingRate);
    //            GrandTotal = GrandTotal + Convert.ToDecimal(Amount.Text.ToString());
    //        }
    //        else
    //        {
    //            WebMsgBox.Show("Select Billing Code and Billing Date.");
    //            return;
    //        }

    //    }

    //    GridFooterItem footeritem = (GridFooterItem)FoodBillingListView.MasterTableView.GetItems(GridItemType.Footer)[0];
    //    RadNumericTextBox Total = (RadNumericTextBox)footeritem.FindControl("lblTotalAmnt");
    //    Total.Text = GrandTotal.ToString();

        
    //}    

    protected void FoodBillingListView_ItemDataBound(object sender, GridItemEventArgs e)
    {
        
      
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;
            DropDownList dropdownlist = (DropDownList)dataItem.FindControl("ddlBillingCode");
            RadNumericTextBox TxtBillCodeRate = (RadNumericTextBox)dataItem.FindControl("TxtBillCodeRate");

            try
            {
               
                SqlProcsNew sqlobj = new SqlProcsNew();
                DataSet ddlBCode = new DataSet();

                ddlBCode = sqlobj.ExecuteSP("SP_FetchBillingCodeDropDown",
                     new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
                dropdownlist.DataSource = ddlBCode.Tables[0];
                dropdownlist.DataValueField = "BCode";
                dropdownlist.DataTextField = "BCodeDescription";
                dropdownlist.DataBind();
                dropdownlist.Dispose();
                dropdownlist.Items.Insert(0, new ListItem("--Select--", "0"));            

            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message.ToString());
            }
        }
      
    }

    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridDataItem item in FoodBillingListView.MasterTableView.Items)
        {
            CheckBox chkbx = (CheckBox)item["All"].FindControl("ChkConfirm");
            chkbx.Checked = !chkbx.Checked;
        }
    }

    protected void btnreturnfromGrpBill_Click(object sender, EventArgs e)
    {
        Response.Redirect("TransactionLevelInd.aspx");
    }
}