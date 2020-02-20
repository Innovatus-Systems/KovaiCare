using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class DepositDiningTally : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadDepDinTally();
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 156 });


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
    private void LoadDepDinTally()
    {
        try
        {
            DataSet dsData = sqlobj.ExecuteSP("SP_DEPOSITACCTALLY", new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 });


            if (dsData.Tables[0].Rows.Count > 0)
            {
                radgvEvents.DataSource = dsData.Tables[0];
                radgvEvents.DataBind();
            }
            else
            {
                radgvEvents.DataSource = string.Empty;
                radgvEvents.DataBind();
            }
            dsData.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    //protected void radgvEvents_Init(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    //{
    //    LoadDepDinTally();
    //}
    protected void radgvEvents_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = radgvEvents.FilterMenu;
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

    protected void radgvEvents_ItemDataBound(object sender, GridItemEventArgs e)
    {
        GridDataItem itm = e.Item as GridDataItem;
        if (itm != null)
        {
            if (itm.Cells[8].Text.Equals("*"))
            {
               
                itm.Cells[1].BackColor = System.Drawing.Color.Red;
                
                itm.Cells[2].ForeColor = System.Drawing.Color.Red;
                
                itm.Cells[3].ForeColor = System.Drawing.Color.Red;
               
                itm.Cells[4].ForeColor = System.Drawing.Color.Red;
               
                itm.Cells[5].ForeColor = System.Drawing.Color.Red;
               
                itm.Cells[6].ForeColor = System.Drawing.Color.Red;
               
                itm.Cells[7].ForeColor = System.Drawing.Color.Red;
               
                itm.Cells[8].ForeColor = System.Drawing.Color.Red;
               
            }
        }
    }

    protected void radgvEvents_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadDepDinTally();
    }
}