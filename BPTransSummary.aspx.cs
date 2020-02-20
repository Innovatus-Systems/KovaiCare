using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Web.Services;
using System.ComponentModel.Design;
using System.Collections.Generic;
using Telerik.Web.UI;

public partial class BPTransSummary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadGridLevelP();
    }

    protected void LoadGridLevelP()
    {

        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsGroup = null;
        dsGroup = sqlobj.ExecuteSP("SP_TransSummaryCM",
            new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = Request.QueryString["SRSN"].ToString() });
        rdgTransSum.DataSource = dsGroup.Tables[0];
        rdgTransSum.DataBind();
        dsGroup.Dispose();
    }

    protected void rdgTransSum_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridFilteringItem)
        {
            GridFilteringItem filterItem = (GridFilteringItem)e.Item;

            filterItem["Date"].HorizontalAlign = HorizontalAlign.Center;
            filterItem["TDesc"].HorizontalAlign = HorizontalAlign.Left;
            filterItem["Code"].HorizontalAlign = HorizontalAlign.Left;
            filterItem["Amount"].HorizontalAlign = HorizontalAlign.Right;
            

        }
    }

}