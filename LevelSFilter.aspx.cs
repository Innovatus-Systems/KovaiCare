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
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.IO;

public partial class LevelSFilter : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string VALUE = Request.QueryString["id"];
            string RName = Request.QueryString["RName"].ToString();

            LoadGridVillaCount();
            LoadGrid();

        }
    }

    protected void LoadGridVillaCount()
    {

        SqlCommand cmd = new SqlCommand("SP_General", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 8;
        DataSet dsGrid = new DataSet();
        VillaCountListView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            VillaCountListView.DataSource = dsGrid.Tables[0];
            VillaCountListView.DataBind();

            VillaCountListView.AllowPaging = true;


        }
        else
        {
            VillaCountListView.DataSource = new String[] { };
            VillaCountListView.DataBind();
        }
    }

    protected void VillaCountListView_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            //Get the instance of the right type
            GridDataItem dataBoundItem = e.Item as GridDataItem;

            //Check the formatting condition
            if (int.Parse(dataBoundItem["CheckedOutCount"].Text) > 0)
            {
                dataBoundItem["CheckedOutCount"].ForeColor = Color.Red;
                dataBoundItem["CheckedOutCount"].Font.Bold = true;
                //Customize more...
            }
        }
    }


    protected void LoadGrid()
    {

        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsGroup = null;
        dsGroup = sqlobj.ExecuteSP("SP_FetchLevelSByName",
            new SqlParameter() { ParameterName = "@RName", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Request.QueryString["RName"].ToString() });
        rcntgrdView.DataSource = dsGroup.Tables[0];
        rcntgrdView.DataBind();
        dsGroup.Dispose();


        //SqlCommand cmd = new SqlCommand("SP_FetchLevelSByName", con);
        //cmd.CommandType = CommandType.StoredProcedure;
        //cmd.Parameters.Add("@RName", SqlDbType.NVarChar).Value = Request.QueryString["RName"].ToString();
        //DataSet dsGrid = new DataSet();
        //rcntgrdView.DataBind();

        //SqlDataAdapter da = new SqlDataAdapter(cmd);

        //da.Fill(dsGrid);
        //if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        //{

        //    rcntgrdView.DataSource = dsGrid.Tables[0];
        //    rcntgrdView.DataBind();

        //    rcntgrdView.AllowPaging = true;

        //}
        //else
        //{
        //    rcntgrdView.DataSource = new String[] { };
        //    rcntgrdView.DataBind();
        //}


        SqlCommand Cmdd = new SqlCommand("SP_General", con);
        Cmdd.CommandType = CommandType.StoredProcedure;
        Cmdd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 10;
        DataSet dsBday = new DataSet();
        SqlDataAdapter DATR = new SqlDataAdapter(Cmdd);


        DATR.Fill(dsBday);

        for (int i = 0; i < dsBday.Tables[0].Rows.Count; i++)
        {
            string Bday1 = dsBday.Tables[0].Rows[i]["RTRSN"].ToString();


            foreach (GridItem rw
                   in rcntgrdView.Items)
            {
                string strRTRSN = rw.Cells[5].Text;

                if (strRTRSN == Bday1)
                {
                    rw.Cells[17].ForeColor = System.Drawing.Color.Green;
                }

            }



        }





    }

    protected void Lnkbtnview_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["CustRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["CustRSN"].ToString();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "win",
     "<script language='javascript'> var iMyWidth;var iMyHeight;  window.open('ResidentView.aspx?=" + CustomerRSN + "','NewWin','status=no,height=1000,width=1300 ,resizable=No,left=200,top=100,screenX=100,screenY=200,toolbar=no,menubar=no,scrollbars=no,location=no,directories=no,   NewWin.focus()')</script>", false);
    }
    protected void Lnkbtnedit_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();
        Response.Redirect("ResEditt.aspx");

    }
    protected void LnkbtnAddOn_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();
        Response.Redirect("AttributesAdd.aspx");

    }

    protected void lbtnName_Click(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[5].Text;
        CustomerRSN = Session["ResidentRSN"].ToString();
        Response.Redirect("TransactionLevel.aspx");
    }

    protected void rdgListView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadGrid();
        //LoadGridLevelT();
        //LoadGridLevelU();
    }
    protected void rdgListView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadGrid();
        //LoadGridLevelT();
        //LoadGridLevelU();
    }
    protected void rdgListView_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadGrid();
        //LoadGridLevelT();
        //LoadGridLevelU();
    }

    protected void rcntgrdView_ItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            try
            {
                if (item["SDescription"].Text.Equals("Owner Resident Dependent") || item["SDescription"].Text.Equals("Owner Away Dependent") ||
                   item["SDescription"].Text.Equals("Tenant Dependant") || item["SDescription"].Text.Equals("Tenant Dependant Away"))
                {

                    LinkButton lnk = (LinkButton)item.FindControl("lbtnName");
                    lnk.Enabled = false;
                    lnk.ForeColor = System.Drawing.Color.Gray;
                }
                else
                {

                }
            }
            catch (GridException ex) { }

        }
    }

    protected void rcntgrdView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid();
    }
}