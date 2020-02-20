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


public partial class VerifyBilling : System.Web.UI.Page
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
            LoadBMonth();
            LoadAMOUNT();
            
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 163 });


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
    private void LoadBMonth()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("CC_VerifyBilling",
               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                drpBMonth.DataSource = dsCategory.Tables[0];
                drpBMonth.DataValueField = "BPNAME";
                drpBMonth.DataTextField = "BPNAME";
                drpBMonth.DataBind();               
            }
            else
            {
               
            }
            dsCategory.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadAMOUNT()
    {
        try
        {

            lblBMonth.Text = drpBMonth.SelectedValue.ToString();
            DataSet dsCategory = sqlobj.ExecuteSP("CC_VerifyBilling",
               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                new SqlParameter() { ParameterName = "@BMnth", SqlDbType = SqlDbType.NVarChar, Value = lblBMonth.Text }
               );
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                gvAccountMaster.DataSource = dsCategory;
                gvAccountMaster.DataBind();
            }
            else
            {
                gvAccountMaster.DataSource = string.Empty;
                gvAccountMaster.DataBind();
            }
            dsCategory.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
   
    protected void gvAccountMaster_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "View")
            {              
                
                if (e.Item is GridDataItem)
                {
                    string AccCd = string.Empty;
                    string DInAmt = string.Empty;
                    GridDataItem ditem = (GridDataItem)e.Item;
                    LinkButton lnkRSN = (LinkButton)e.Item.FindControl("lnkDinChr");
                    //LinkButton lnkOpenProjBtn = (LinkButton)sender;
                    //GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
                    AccCd = ditem.Cells[3].Text;
                    DInAmt = lnkRSN.Text.ToString();
                    DataSet dsCount = sqlobj.ExecuteSP("CC_VerifyBilling",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@AccCd", SqlDbType = SqlDbType.NVarChar, Value = AccCd },
                       new SqlParameter() { ParameterName = "@BMnth", SqlDbType = SqlDbType.NVarChar, Value = lblBMonth.Text }
                       );
                    if (dsCount.Tables[0].Rows.Count > 0)
                    {
                        //gvAccountMaster.Visible = false;
                        rdDinCount.Visible = true;
                        lblResName.Visible = true;
                        lblRes.Visible = true;
                        //btnReturn.Visible = true;
                        lblMsg.Visible = true;
                        lblDinAmt.Visible = true;
                        lblDinAmt.Text = "Dining Charges - Rs." + DInAmt +" for the month of "+drpBMonth.SelectedItem.Text;
                        lblResName.Text = dsCount.Tables[0].Rows[0]["Name"].ToString();
                        rdDinCount.DataSource = dsCount;
                        rdDinCount.DataBind();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No Data for selected Resident.');", true);
                    }
                }                   
                
            }
            else
            {
                LoadAMOUNT();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.ToString() + "');", true);
        }

      
    }

    protected void gvAccountMaster_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvAccountMaster.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains" || menu.Items[i].Text == "EqualTo"
                || menu.Items[i].Text == "NotEqualTo" || menu.Items[i].Text == "GreaterThan" || menu.Items[i].Text == "LessThan")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }

    protected void lnkRSN_Click(object sender, EventArgs e)
    {
        try
        {
            string AccCd = string.Empty;
            string DInAmt = string.Empty;
            LinkButton lnkOpenProjBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
            AccCd = row.Cells[4].Text;
            DInAmt= row.Cells[5].Text;
            DataSet dsCount = sqlobj.ExecuteSP("CC_VerifyBilling",
               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@AccCd", SqlDbType = SqlDbType.NVarChar, Value = AccCd });
            if(dsCount.Tables[0].Rows.Count>0)
            {
                gvAccountMaster.Visible = false;
                rdDinCount.Visible = true;
                lblResName.Visible = true;
                lblRes.Visible = true;
                //btnReturn.Visible = true;
                lblMsg.Visible = true;
                lblDinAmt.Visible = true;
                lblDinAmt.Text ="/ Dining Charges - Rs."+ DInAmt;
                lblResName.Text = dsCount.Tables[0].Rows[0]["Name"].ToString();
                rdDinCount.DataSource = dsCount;
                rdDinCount.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No Data for selected Resident.');", true);
                btnReturn_Click(sender, e);
            }

        }
        catch(Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('"+ex.Message.ToString()+"');", true);
        }
    }



    protected void btnReturn_Click(object sender, EventArgs e)
    {
        LoadAMOUNT();
        gvAccountMaster.Visible = true;
        rdDinCount.Visible = false;
        lblResName.Visible = false;
        lblRes.Visible = false;
        //btnReturn.Visible = false;
        lblMsg.Visible = false;
        lblDinAmt.Visible = false;
    }

    protected void rdDinCount_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try {
            GridDataItem itm = e.Item as GridDataItem;
            if (itm != null)
            {
                if (itm.Cells[3].Text != "0")
                {
                    itm.Cells[3].ForeColor = System.Drawing.Color.Maroon;
                    itm.Cells[3].BackColor = System.Drawing.Color.Yellow;
                    itm.Cells[3].Font.Bold = true;
                }
                if (itm.Cells[4].Text != "0")
                {
                    itm.Cells[4].ForeColor = System.Drawing.Color.Maroon;
                    itm.Cells[4].BackColor = System.Drawing.Color.Yellow;
                    itm.Cells[4].Font.Bold = true;
                }
                if (itm.Cells[5].Text != "0")
                {
                    itm.Cells[5].ForeColor = System.Drawing.Color.Maroon;
                    itm.Cells[5].BackColor = System.Drawing.Color.Yellow;
                    itm.Cells[5].Font.Bold = true;
                }
            }

            }
        catch (Exception ex)
        {

        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            gvAccountMaster.Visible = true;
            rdDinCount.Visible = false;
            lblResName.Visible = false;
            lblRes.Visible = false;
            //btnReturn.Visible = false;
            lblMsg.Visible = false;
            lblDinAmt.Visible = false;
            LoadAMOUNT();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}
