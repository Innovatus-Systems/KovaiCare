using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;


public partial class PhysicalStock : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {
                LoadTitle();

                LoadGroup();

                LoadPhysicalStock();

                //dtpDate.SelectedDate = DateTime.Today;

                rgPhysicalStock.DataSource = string.Empty;
                rgPhysicalStock.DataBind();

                dvNewBatchCode.Visible = false;
                dvUpdatePhysicalStock.Visible = false;
                dvUpdateStock.Visible = false;
            }
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 96 });


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

    private void LoadPhysicalStock()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_PhsicalStock");

            if (dsTitle.Tables[0].Rows.Count >0)
            {
                rgUpdatePhysicalStock.DataSource = dsTitle;
                rgUpdatePhysicalStock.DataBind();
            }
            else
            {
                rgUpdatePhysicalStock.DataSource = string.Empty;
                rgUpdatePhysicalStock.DataBind();
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadGroup()
    {
        try
        {
            DataSet dsGroup = sqlobj.ExecuteSP("SP_LoadGroupRM");

            ddlGroup.Items.Clear();

            if (dsGroup.Tables[0].Rows.Count > 0)
            {

                ddlGroup.DataSource = dsGroup;
                ddlGroup.DataTextField = "Name";
                ddlGroup.DataValueField = "Value";
                ddlGroup.DataBind();

            }

            ddlGroup.Items.Insert(0, "--Select--");

            dsGroup.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadRawMaterial()
    {
        try
        {
            DataSet dsRawMaterial = sqlobj.ExecuteSP("SP_GetRawMaterial",
                new SqlParameter() { ParameterName = "@StockGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue == "--Select--" ? null:ddlGroup.SelectedValue },
                new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.Char, Value = ddlCategory.SelectedValue}
                );


            if (dsRawMaterial.Tables[0].Rows.Count > 0)
            {
                rgPhysicalStock.DataSource = dsRawMaterial;
                rgPhysicalStock.DataBind();

            }
            else
            {
                rgPhysicalStock.DataSource = string.Empty;
                rgPhysicalStock.DataBind();


            }

            dsRawMaterial.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void rgPhysicalStock_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
          
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadRawMaterial();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadRawMaterial();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            try
            {

                // GetMax Code

                string strpscode = "";

                DataSet dsGetMax = sqlobj.ExecuteSP("SP_GetMaxCodeforPS");

                if (dsGetMax.Tables[0].Rows.Count>0)
                {
                    string code = dsGetMax.Tables[0].Rows[0]["PSCode"].ToString();
                    string[] strgetcode = code.Split('/');

                    int iIncrement = Convert.ToInt32(strgetcode[1].ToString()) + 1;

                    strpscode = "PS/" + iIncrement.ToString("000"); 
                }
                else
                {
                    strpscode = "PS/001";
                }

                int count = 0;

                foreach (GridDataItem item in rgPhysicalStock.MasterTableView.Items)
                {
                    if (item.Selected)
                    {
                        count = count + 1;
                    }
                }

                if (count > 0)
                {
                    foreach (GridDataItem item in rgPhysicalStock.MasterTableView.Items)
                    {
                        if (item.Selected)
                        {   
                            string strcategory = item["Category"].Text.ToString();
                            string stritemcode = item["RMCode"].Text.ToString();
                            string strgroup = item["StockGroup"].Text.ToString();
                            string struom = item["IssueUOM"].Text.ToString();

                            sqlobj.ExecuteSQLNonQuery("SP_InsertPhysicalStock",
                                 new SqlParameter() { ParameterName = "@PSCode", SqlDbType = SqlDbType.NVarChar, Value = strpscode.ToString() },
                                 new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = DateTime.Today },
                                 new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = strcategory.ToString() == "All" ? "" : strcategory.ToString() },
                                 new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = struom.ToString() },
                                 new SqlParameter() { ParameterName = "@StockGroup", SqlDbType = SqlDbType.NVarChar, Value = strgroup.ToString() },
                                 new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = stritemcode.ToString() },
                                 new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });

                          
                        }
                    }

                    Clear();

                    LoadPhysicalStock();

                    WebMsgBox.Show("Physical stock details saved");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Select atleast one item to save physical stock details.');", true);
                }
            }
            catch(Exception ex)
            {
                WebMsgBox.Show(ex.Message);
            }
        }
    }

    private void Clear()
    {   
       // dtpDate.SelectedDate = DateTime.Today;

        ddlCategory.SelectedIndex = 0;
        ddlGroup.SelectedIndex = 0; 

        rgPhysicalStock.DataSource = string.Empty;
        rgPhysicalStock.DataBind();
        
    }
    protected void btnNewBatchCode_Click(object sender, EventArgs e)
    {
        try
        {
            dvNewBatchCode.Visible = true;
            dvUpdatePhysicalStock.Visible = false;
            dvUpdateStock.Visible = false; 
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            LoadPhysicalStock();

            dvNewBatchCode.Visible = false;
            dvUpdatePhysicalStock.Visible = true;
            dvUpdateStock.Visible = false;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgUpdatePhysicalStock_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "UpdateRow")
            {

                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    //LinkButton lblpscode = (LinkButton)e.Item.FindControl("lbtnUpdate");

                    string strpscode = e.CommandArgument.ToString();

                    string batchdate = ditem["Date"].Text;

                    Session["PSCode"] = strpscode.ToString();
                    Session["BatchDate"] = batchdate.ToString();

                    DataSet dsRes = sqlobj.ExecuteSP("SP_GetPhysicalStock",
                        new SqlParameter() { ParameterName = "@PSCode", SqlDbType = SqlDbType.NVarChar, Value = strpscode.ToString() });

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {

                        rgUpdateStock.DataSource = dsRes;
                        rgUpdateStock.DataBind();

                        dvUpdatePhysicalStock.Visible = false;
                        dvUpdateStock.Visible = true;

                        lblPSCode.Text = Session["PSCode"].ToString();
                        lblDate.Text = Session["BatchDate"].ToString();

                    }
                    else
                    {
                        rgUpdateStock.DataSource = string.Empty;
                        rgUpdateStock.DataBind();

                        dvUpdatePhysicalStock.Visible = true;
                        dvUpdateStock.Visible = false;

                        lblPSCode.Text = "";

                        //dvUpdatePhysicalStock.Visible = ; 
                    }
                }
            }
            else if (e.CommandName=="PSVR1")
            {

                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    //LinkButton lblpscode = (LinkButton)e.Item.FindControl("lbtnUpdate");

                    string strpscode = e.CommandArgument.ToString();

                    string batchdate = ditem["Date"].Text;

                    Session["PSCode"] = strpscode.ToString();
                    Session["BatchDate"] = batchdate.ToString();

                }
                
                string pscode = e.CommandArgument.ToString();

                PSVR1(pscode);
            }
            else if (e.CommandName=="PSVR2")
            {
                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;

                    //LinkButton lblpscode = (LinkButton)e.Item.FindControl("lbtnUpdate");

                    string strpscode = e.CommandArgument.ToString();

                    string batchdate = ditem["Date"].Text;

                    Session["PSCode"] = strpscode.ToString();
                    Session["BatchDate"] = batchdate.ToString();

                }

                string pscode = e.CommandArgument.ToString();

                PSVR2(pscode);
            }
            else
            {
                LoadPhysicalStock();
            }
            
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void PSVR1(string pscode)
    {
        try
        {


            //DataSet dscheck = sqlobj.ExecuteSP("SP_CheckNotUpdatedItems",
            //    new SqlParameter() { ParameterName = "@PSCode", SqlDbType = SqlDbType.NVarChar, Value = pscode.ToString() }
               
            //    );

            //int icount = 0;


            //if (dscheck.Tables[0].Rows.Count > 0)
            //{
            //    icount = Convert.ToInt32(dscheck.Tables[0].Rows[0]["Count"].ToString());
            //}

            //dscheck.Dispose();


            //if (icount == 0)
            //{

                DataSet dsExporttoexcel = sqlobj.ExecuteSP("SP_GetExcelforPhysicalStock",
                    new SqlParameter() { ParameterName = "@PSCode", SqlDbType = SqlDbType.NVarChar, Value = pscode.ToString() },
                     new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 1 }
                    );

                if (dsExporttoexcel.Tables[0].Rows.Count > 0)
                {
                    DataTable dt = dsExporttoexcel.Tables[0];

                    string filename = "PSVR1- Working Sheet for physical stock verification _ " + DateTime.Today.ToString("dd-MM-yyyy") + ".xls";
                    System.IO.StringWriter tw = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
                    hw.Write("<table style='width:100%'><tr><td colspan='10'>PSVR1- Working Sheet for physical stock verification</td></tr>");
                    hw.Write("<tr><td colspan='10'>Use this as a working sheet to post stock transactions.</td></tr>");
                    hw.Write("<tr><td colspan='10'>BatchCode:" + pscode.ToString() + " Date:" + Session["BatchDate"].ToString() + "&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;Printed On:" + DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") + "</td></tr></table>");

                    DataGrid dgGrid = new DataGrid();
                    dgGrid.DataSource = dt;
                    dgGrid.DataBind();
                    dgGrid.RenderControl(hw);

                    Response.ContentType = "application/vnd.ms-excel";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
                    Response.Write(tw.ToString());
                    Response.End();

                }

                dsExporttoexcel.Dispose();
           // }
            //else
            //{
            //    WebMsgBox.Show("Please check! Have you updated all items in this batch.");
            //}

        }
        catch (Exception ex)
        {

        }
    }

    private void PSVR2(string pscode)
    {
        try
        {


            DataSet dscheck = sqlobj.ExecuteSP("SP_CheckNotUpdatedItems",
                new SqlParameter() { ParameterName = "@PSCode", SqlDbType = SqlDbType.NVarChar, Value = pscode.ToString() });

            int icount = 0;


            if (dscheck.Tables[0].Rows.Count > 0)
            {
                icount = Convert.ToInt32(dscheck.Tables[0].Rows[0]["Count"].ToString());
            }

            dscheck.Dispose();


            if (icount == 0)
            {

                DataSet dsExporttoexcel = sqlobj.ExecuteSP("SP_GetExcelforPhysicalStock",
                    new SqlParameter() { ParameterName = "@PSCode", SqlDbType = SqlDbType.NVarChar, Value = pscode.ToString() },

                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 2 });

                if (dsExporttoexcel.Tables[0].Rows.Count > 0)
                {
                    DataTable dt = dsExporttoexcel.Tables[0];

                    string filename = "PSVR2- Report after stock verification _ " + DateTime.Today.ToString("dd-MM-yyyy") + ".xls";
                    System.IO.StringWriter tw = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
                    hw.Write("<table style='width:100%'><tr><td colspan='10'>PSVR2- Report after stock verification</td></tr>");
                    hw.Write("<tr><td colspan='10'>For posting stock adjustment transactions</td></tr>");
                    hw.Write("<tr><td colspan='10'>BatchCode:" + pscode.ToString() + " Date:" + Session["BatchDate"].ToString() + "&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;Printed On:" + DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") + "</td></tr></table>");

                    DataGrid dgGrid = new DataGrid();
                    dgGrid.DataSource = dt;
                    dgGrid.DataBind();
                    dgGrid.RenderControl(hw);

                    Response.ContentType = "application/vnd.ms-excel";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
                    Response.Write(tw.ToString());
                    Response.End();

                }

                dsExporttoexcel.Dispose();
            }
            else
            {
                WebMsgBox.Show("Please check! Have you update all items in this batch.");
            }

        }
        catch (Exception ex)
        {

        }
    }

    protected void btnUpdate_Click1(object sender, EventArgs e)
    {
        try
        {
            int count = 0;



            foreach (GridDataItem item in rgUpdateStock.MasterTableView.Items)
            {
                TextBox txtphysicalstock = (TextBox)item.FindControl("txtphysicalstock");

                if (txtphysicalstock.Text == "-1.00")
                {
                    count = count + 1;
                }
            
            }


            if (count == 0)
            {

                foreach (GridDataItem item in rgUpdateStock.MasterTableView.Items)
                {
                    string stritemcode = item["RMCode"].Text.ToString();
                    string strrsn = item["RSN"].Text.ToString();

                    TextBox txtphysicalstock = (TextBox)item.FindControl("txtphysicalstock");

                    decimal strphysicalstock = Convert.ToDecimal(txtphysicalstock.Text);

                    if (strphysicalstock >= 0)
                    {

                        sqlobj.ExecuteSQLNonQuery("SP_UpdatePhysicalStock",
                             new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = strrsn.ToString() },
                             new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = stritemcode.ToString() },
                             new SqlParameter() { ParameterName = "@PhysicalStock", SqlDbType = SqlDbType.Decimal, Value = strphysicalstock.ToString() },
                             new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                           );
                    }



                }


                LoadPhysicalStock();


                rgUpdateStock.DataSource = string.Empty;
                rgUpdateStock.DataBind();

                dvUpdatePhysicalStock.Visible = true;
                dvUpdateStock.Visible = false;

                WebMsgBox.Show("Physical stock verification details updated successfully");
            }
            else
            {
                WebMsgBox.Show("Please check! Have you update all items in this batch.");
            }


        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        try
        {
            dvUpdatePhysicalStock.Visible = true;
            dvUpdateStock.Visible = false;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }
    protected void rgUpdateStock_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem )
        {
            
            
            GridDataItem dataItem = (GridDataItem)e.Item;

            TextBox txtphysicalstock = (TextBox)e.Item.FindControl("txtphysicalstock");

            decimal dps = Convert.ToDecimal(txtphysicalstock.Text);

            if (dps >= 0)
            {
                txtphysicalstock.Enabled = false;
            }
            else
            {
               
                txtphysicalstock.Enabled = true;
                txtphysicalstock.ForeColor = System.Drawing.Color.Red;
            }

        }
    }
    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {


            DataSet dscheck = sqlobj.ExecuteSP("SP_CheckNotUpdatedItems",
                new SqlParameter() { ParameterName = "@PSCode", SqlDbType = SqlDbType.NVarChar, Value = Session["PSCode"].ToString() });

            int icount = 0;


            if (dscheck.Tables[0].Rows.Count >0)
            {
                icount = Convert.ToInt32(dscheck.Tables[0].Rows[0]["Count"].ToString());
            }

            dscheck.Dispose();


            if (icount == 0)
            {

                DataSet dsExporttoexcel = sqlobj.ExecuteSP("SP_GetExcelforPhysicalStock",
                    new SqlParameter() { ParameterName = "@PSCode", SqlDbType = SqlDbType.NVarChar, Value = Session["PSCode"].ToString() });

                if (dsExporttoexcel.Tables[0].Rows.Count > 0)
                {
                    DataTable dt = dsExporttoexcel.Tables[0];

                    string filename = "Physical Stock Verification _ " + DateTime.Today.ToString("dd-MM-yyyy") + ".xls";
                    System.IO.StringWriter tw = new System.IO.StringWriter();
                    System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
                    hw.Write("<table style='width:100%'><tr><td colspan='10'>Physical Stock Verification Update Sheet.</td></tr>");
                    hw.Write("<tr><td colspan='10'>Use this as a working sheet to post stock transactions.</td></tr>");
                    hw.Write("<tr><td colspan='10'>BatchCode:" + Session["PSCode"].ToString() + " Date:" + Session["BatchDate"].ToString() + "&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp&nbsp;&nbsp;&nbsp;&nbsp;Printed On:" + DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") + "</td></tr></table>");
                    
                    DataGrid dgGrid = new DataGrid();
                    dgGrid.DataSource = dt;
                    dgGrid.DataBind();
                    dgGrid.RenderControl(hw);
                    
                    Response.ContentType = "application/vnd.ms-excel";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
                    Response.Write(tw.ToString());
                    Response.End();

                }

                dsExporttoexcel.Dispose();
            }
            else
            {
                WebMsgBox.Show("Please check! Have you update all items in this batch.");
            }
           
        }
        catch(Exception ex)
        {

        }
    }
    protected void rgUpdatePhysicalStock_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = e.Item as GridDataItem;

            //string svi = dataItem["VerificationItem"].Text;

            Int32 ibatchcount = Convert.ToInt32(dataItem["VerificationItem"].Text);
            Int32 Verifiedcount = Convert.ToInt32(dataItem["Verified"].Text);

            LinkButton lnkpsvr2 = e.Item.FindControl("lnkpsvr2") as LinkButton;

            LinkButton lnkpsvr1 = e.Item.FindControl("lnkpsvr1") as LinkButton;

            LinkButton  lbtnUpdate = e.Item.FindControl("lbtnUpdate") as LinkButton;


            if (ibatchcount != Verifiedcount)
            {
                dataItem["pscode"].ForeColor = System.Drawing.Color.Red;

                lnkpsvr2.Enabled = true;

                lnkpsvr2.ForeColor = System.Drawing.Color.White;

                lbtnUpdate.ForeColor = System.Drawing.Color.Red;
            }

            else
            {
                lnkpsvr2.Enabled = true;

                lbtnUpdate.Text = "Verified";
                lbtnUpdate.Enabled = false;

                lnkpsvr1.ForeColor = System.Drawing.Color.White;

               
            }


         
           

        }
    }
    protected void rgPhysicalStock_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgPhysicalStock.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains" 
            || menu.Items[i].Text == "GreaterThanOrEqualTo" || menu.Items[i].Text == "LessThanOrEqualTo" )
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
    protected void rgUpdatePhysicalStock_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgUpdatePhysicalStock.FilterMenu;
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
}