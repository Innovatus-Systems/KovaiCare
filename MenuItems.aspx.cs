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

public partial class MenuItems : System.Web.UI.Page
{

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                LoadTitle(18);


                GetMaxItemCode();
                LoadSession();
                LoadUOM();
                LoadItemGroup();
                LoadItemList();

               

                btnSaveItm.Visible = true;
                btnUpteItm.Visible = false;
                
            }
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadTitle(int id)
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = id.ToString() });


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

    protected void LoadUOM()
    {
        try
        {
            DataTable dt = new DataTable();
            dt.Clear();
            dt.Columns.Add("Code");
            dt.Columns.Add("Text");
            DataRow drow = dt.NewRow();

            drow["Code"] = "Nos";
            drow["Text"] = "Nos";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Grms";
            drow["Text"] = "Grms";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Ml";
            drow["Text"] = "Ml";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "None";
            drow["Text"] = "None";
            dt.Rows.Add(drow);


            ddlUOM.DataSource = dt;
            ddlUOM.DataTextField = dt.Columns["Text"].ToString();
            ddlUOM.DataValueField = dt.Columns["Code"].ToString();
            ddlUOM.DataBind();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadItemList()
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsMenu = null;
            dsMenu = sqlobj.ExecuteSP("SP_FetchItem",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });

            if (dsMenu.Tables[0].Rows.Count > 0)
            {
                rdgItemList.DataSource = dsMenu.Tables[0];
                rdgItemList.DataBind();
            }
            else
            {
                rdgItemList.DataSource = string.Empty;
                rdgItemList.DataBind();
            }


            dsMenu.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
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
           

            ddlMISession.DataSource = dsFetchSE.Tables[0];
            ddlMISession.DataValueField = "SCode";
            ddlMISession.DataTextField = "SName";
            ddlMISession.DataBind();
            ddlMISession.Dispose();


            ddlMISession.Items.Insert(0, "--Select--");


            //ddlSession.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadItemGroup()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchAT = new DataSet();

            dsFetchAT = sqlobj.ExecuteSP("SP_LoadGroup");

            if (dsFetchAT.Tables[0].Rows.Count > 0)
            {

                ddlitmType.DataSource = dsFetchAT.Tables[0];
                ddlitmType.DataValueField = "GroupName";
                ddlitmType.DataTextField = "GroupName";
                ddlitmType.DataBind();
                ddlitmType.Dispose();

            }

            dsFetchAT.Dispose();

            //ddlitmType.Items.Insert(0, "--Select--");



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    //protected void LoadItem()
    //{
    //    try
    //    {
    //        SqlProcsNew sqlobj = new SqlProcsNew();
    //        DataSet dsFetchAT = new DataSet();

    //        dsFetchAT = sqlobj.ExecuteSP("SP_FetchDropDown",
    //             new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 });

    //        ddlItemCode.DataSource = dsFetchAT.Tables[0];
    //        ddlItemCode.DataValueField = "ItmCode";
    //        ddlItemCode.DataTextField = "Item";
    //        ddlItemCode.DataBind();
    //        ddlItemCode.Dispose();



    //        ddlItemCode.Items.Insert(0, "--Select--");



    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }
    //}

   

    protected void GetMaxItemCode()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsmaxcode = null;
            dsmaxcode = sqlobj.ExecuteSP("SP_MaxItemCode");

           // string stritemcode = dsmaxcode.Tables[0].Rows[0]["ItemCode"]

            if (dsmaxcode.Tables[0].Rows.Count > 0)
            {
                ItemCode.Text = dsmaxcode.Tables[0].Rows[0]["ItemCode"].ToString();
            }
            else
            {
                ItemCode.Text = "IT100";
            }

            dsmaxcode.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }

    protected void btnSaveItem_Click(object sender, EventArgs e)
    {
        if (CnfResult.Value == "true")
        {
            try
            {
                sqlobj.ExecuteSP("SP_InsertItem",
                    new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = ItemCode.Text.ToString() },
                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = ItemName.Text.ToString() },
                    new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = ddlUOM.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = ddlitmCategory.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlitmType.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Int, Value = txtQtyAlert.Text },
                    new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = txtLeadTime.Text },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = ddlMISession.SelectedValue },
                    new SqlParameter() { ParameterName = "@ServQty ", SqlDbType = SqlDbType.BigInt, Value = txtMIServeQty.Text },
                    new SqlParameter() { ParameterName = "@Rate", SqlDbType = SqlDbType.Decimal, Value = txtRate.Text },
                    new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text.ToString() },
                    new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() });


                ItemCode.Text = string.Empty;
                ItemName.Text = string.Empty;
                txtRemarks.Text = String.Empty;
                txtQtyAlert.Text = "0";
                txtLeadTime.Text = "0";
                txtRate.Text = "0";

                LoadItemList();
                //LoadItem();
                GetMaxItemCode();


                //WebMsgBox.Show("New item added");

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('New item added');", true);
                btnClearItm_Click(sender, e);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.ToString() + "');", true);

                //WebMsgBox.Show(ex.ToString());
            }
        }
    }

    protected void LnkEditItemMaster_Click(object sender, EventArgs e)
    {

      

    }

    protected void btnUpteItm_Click(object sender, EventArgs e)
    {

        try
        {
            if (CnfResult.Value == "true")
            {

                sqlobj.ExecuteSP("SP_UpdateItem",
                    new SqlParameter() { ParameterName = "@ItemCode", SqlDbType = SqlDbType.NVarChar, Value = ItemCode.Text.ToString() },
                    new SqlParameter() { ParameterName = "@ItemName", SqlDbType = SqlDbType.NVarChar, Value = ItemName.Text.ToString() },
                    new SqlParameter() { ParameterName = "@UOM", SqlDbType = SqlDbType.NVarChar, Value = ddlUOM.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Category", SqlDbType = SqlDbType.NVarChar, Value = ddlitmCategory.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlitmType.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@QtyAlert", SqlDbType = SqlDbType.Int, Value = txtQtyAlert.Text },
                    new SqlParameter() { ParameterName = "@LeadTime", SqlDbType = SqlDbType.Int, Value = txtLeadTime.Text },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = ddlMISession.SelectedValue },
                     new SqlParameter() { ParameterName = "@ServQty ", SqlDbType = SqlDbType.Decimal, Value = txtMIServeQty.Text },
                    new SqlParameter() { ParameterName = "@Rate", SqlDbType = SqlDbType.Decimal, Value = txtRate.Text },
                    new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text.ToString() },
                    new SqlParameter() { ParameterName = "@ModifiedBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = ViewState["ItemRSN"].ToString() }
                    );

                //WebMsgBox.Show("Existing item updated");

                ItemCode.Text = string.Empty;
                ItemName.Text = string.Empty;
                txtRemarks.Text = String.Empty;
                txtQtyAlert.Text = string.Empty;
                txtLeadTime.Text = string.Empty;
                txtRate.Text = string.Empty;
                //txtstaff.Text = "";
                ddlMISession.SelectedIndex = 0;
                txtMIServeQty.Text = "";
                LoadItemList();
                GetMaxItemCode();

                btnSaveItm.Visible = true;
                btnUpteItm.Visible = false;

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Existing item updated');", true);


            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }

    }

    protected void btnClearItm_Click(object sender, EventArgs e)
    {
        ItemCode.Text = string.Empty;
        ItemName.Text = string.Empty;
        txtRemarks.Text = string.Empty;
        txtQtyAlert.Text = string.Empty;
        txtLeadTime.Text = string.Empty;
        ddlUOM.SelectedValue = "Nos";
        ddlitmCategory.SelectedIndex = 0;
        ddlitmType.SelectedIndex = 0;
        txtMIServeQty.Text = string.Empty;
        GetMaxItemCode();
    }

    protected void btnCloseItm_Click(object sender, EventArgs e)
    {
        pnlMenuItem.Visible = false;
    }

    protected void rdgItemList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadItemList();
    }


    protected void lnkMenuItem_Click(object sender, EventArgs e)
    {
        pnlMenuItem.Visible = true;
    }
    protected void LnkEditItemMaster_Click1(object sender, EventArgs e)
    {
        try
        {

            LinkButton lnkEdititemBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdititemBtn.NamingContainer;
            string RSN;
            RSN = row.Cells[2].Text;
            ViewState["ItemRSN"] = RSN.ToString();
            SqlProcsNew proc = new SqlProcsNew();
            DataSet dsIT = null;

            dsIT = proc.ExecuteSP("SP_GetItem",
                new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN });


            if (dsIT.Tables[0].Rows.Count > 0)
            {

                ItemCode.Text = dsIT.Tables[0].Rows[0]["ItemCode"].ToString();
                ItemName.Text = dsIT.Tables[0].Rows[0]["ItemName"].ToString();
                ddlUOM.Text = dsIT.Tables[0].Rows[0]["UOM"].ToString();
                ddlitmCategory.SelectedValue = dsIT.Tables[0].Rows[0]["Category"].ToString();
                string strserveqty = dsIT.Tables[0].Rows[0]["Session"].ToString();

                if (strserveqty != "")
                {
                    ddlMISession.SelectedValue = dsIT.Tables[0].Rows[0]["Session"].ToString();
                }


                txtMIServeQty.Text = dsIT.Tables[0].Rows[0]["ServeQty"].ToString();
                ddlitmType.SelectedValue = dsIT.Tables[0].Rows[0]["Type"].ToString();
                txtQtyAlert.Text = dsIT.Tables[0].Rows[0]["QtyAlert"].ToString();
                txtLeadTime.Text = dsIT.Tables[0].Rows[0]["LeadTime"].ToString();
                txtRate.Text = dsIT.Tables[0].Rows[0]["Rate"].ToString();
                txtRemarks.Text = dsIT.Tables[0].Rows[0]["Remarks"].ToString();


                btnUpteItm.Visible = true;
                btnSaveItm.Visible = false;

                pnlMenuItem.Visible = true;
            }


            dsIT.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rdgItemList_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rdgItemList.FilterMenu;
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
}