using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class VegCheckList : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblyesterday.Visible = false;
            yesterdaySearch.Visible = false;
            rdYesterdayVegList.Visible = false;
            rgVegList.Width = Unit.Pixel(1190);
            string yy = DateTime.Now.ToString("yy");
            string mm = DateTime.Now.ToString("MMM");
            string yymm = mm + yy;

            DataSet dsmonth = new DataSet();
            SqlCommand cmdmonth = new SqlCommand("select BPName,BStatus from tblbillingperiods", con);
            cmdmonth.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter(cmdmonth);
            da.Fill(dsmonth);

            if (dsmonth.Tables[0].Rows.Count > 0)
            {
                drpMonth.DataSource = dsmonth.Tables[0];
                drpMonth.DataTextField = "BPName";
                drpMonth.DataValueField = "BPName";
                drpMonth.DataBind();
                drpMonth.SelectedValue = yymm;
            }


            LoadTitle();
            LoadDrpGroup();
            LoadGrid();
            LoadDrpItem();
            DataSet dsDetails = new DataSet();
            SqlCommand cmd = new SqlCommand("Get_ValidAsOf", con);
            cmd.CommandType = CommandType.StoredProcedure;
            DataSet dsValidAsOf = new DataSet();
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsValidAsOf);
            if (dsValidAsOf.Tables[0].Rows.Count > 0)
            {
                DataTable dt = dsValidAsOf.Tables[0];
                lblvalid.Text = Convert.ToString(dt.Rows[0]["ValidAsOf"]);
            }
            else
            {
                //WebMsgBox.Show("There is No Record ");
                lblvalid.Text = "-";
            }


            //SqlCommand cmd = new SqlCommand("Get_VegList", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@IMODE", 1);
            //cmd.Parameters.AddWithValue("@month", yymm);
            //SqlDataAdapter dap = new SqlDataAdapter(cmd);
            //dap.Fill(dsDetails);
            //if (dsDetails.Tables[0].Rows.Count > 0)
            //{
            //    rgVegList.DataSource = dsDetails.Tables[0];
            //    rgVegList.DataBind();
            //    //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
            //}
            //else
            //{
            //    //WebMsgBox.Show("There is No Record ");
            //    rgVegList.DataSource = string.Empty;
            //    rgVegList.DataBind();
            //}

        }
    }

    private void LoadDrpGroup()
    {

        DataSet dsGroup = sqlobj.ExecuteSP("SP_GetVegListGroup",
            new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 1 });
        if (dsGroup.Tables[0].Rows.Count > 0)
        {

            drpGroup.DataSource = dsGroup.Tables[0];
            drpGroup.DataValueField = "Group";
            drpGroup.DataTextField = "Group";
            drpGroup.DataBind();
            drpGroup.SelectedValue = "Fruits & Vegetables";
            //drpGroup.Items.Insert(0, new ListItem("All", "All"));

        }
        else
        {
            WebMsgBox.Show("There Is No Record For Load Group.");
        }

    }

    private void LoadDrpItem()
    {
        //if(drpGroup.SelectedValue=="All")
        //{
        //    DataSet dsItem = sqlobj.ExecuteSP("SP_GetVegListGroup",
        //  new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 3 }
        //  );
        //    if (dsItem.Tables[0].Rows.Count > 0)
        //    {

        //        drpItem.DataSource = dsItem.Tables[0];
        //        drpItem.DataValueField = "ItemCode";
        //        drpItem.DataTextField = "ItemCode";
        //        drpItem.DataBind();
        //        drpItem.Items.Insert(0, new ListItem("All", "All"));

        //    }
        //    else
        //    {
        //        WebMsgBox.Show("There Is No Record For Load Item.");
        //    }
        //}
        //else { 
        DataSet dsItem = sqlobj.ExecuteSP("SP_GetVegListGroup",
           new SqlParameter() { ParameterName = "@Imode", SqlDbType = SqlDbType.Int, Value = 2 },
           new SqlParameter() { ParameterName = "@SelectedGrp", SqlDbType = SqlDbType.NVarChar, Value = drpGroup.SelectedItem.ToString() });
        if (dsItem.Tables[0].Rows.Count > 0)
        {

            drpItem.DataSource = dsItem.Tables[0];
            drpItem.DataValueField = "ItemCode";
            drpItem.DataTextField = "ItemCode";
            drpItem.DataBind();
            drpItem.Items.Insert(0, new ListItem("All", "All"));

        }
        else
        {
            WebMsgBox.Show("There Is No Record For Load Item.");
        }
        //}
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 137 });


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
    private void LoadGrid()
    {

        DataSet dsDetails = new DataSet();
        SqlCommand cmd = new SqlCommand("Get_VegList", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@IMODE", 1);
        cmd.Parameters.AddWithValue("@month", drpMonth.SelectedValue.ToString());
        SqlDataAdapter dap = new SqlDataAdapter(cmd);
        dap.Fill(dsDetails);
        if (dsDetails.Tables[0].Rows.Count > 0)
        {
            rgVegList.DataSource = dsDetails.Tables[0];
            rgVegList.DataBind();
            //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
        }
        else
        {
            //WebMsgBox.Show("There is No Record ");
            rgVegList.DataSource = string.Empty;
            rgVegList.DataBind();
        }
        Session["GridData"] = dsDetails.Tables[0];
    }

    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsGrid = new DataSet();
        //string yy = DateTime.Now.ToString("yy");
        //string mm = DateTime.Now.ToString("MM");
        //string yymm = yy + mm;


        //dsGrid = sqlobj.ExecuteSP("Get_VegList",
        //      new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 },
        //      new SqlParameter() { ParameterName = "@month", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = yymm }
        //     );
        //DataTable dt = dsGrid.Tables[0];

        if (Session["GridData"] != null)
        {

            DataGrid dg = new DataGrid();

            dg.DataSource = Session["GridData"];
            dg.DataBind();

            // THE EXCEL FILE.
            string date = DateTime.Now.ToString("dd-MM-yyyy-hh-mm");
            string dateasof = DateTime.Now.ToString("dd-MMM-yyyy hh:mm");
            dateasof = dateasof + " Hrs";
            string sFileName = date;
            sFileName = sFileName.Replace("-", "");
            sFileName = "Veg List-" + sFileName;



            // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=" + sFileName + ".xls");
            Response.ContentType = "application/vnd.ms-excel";
            EnableViewState = false;

            System.IO.StringWriter objSW = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

            dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
            dg.RenderControl(objHTW);


            Response.Write("<table style='font-weight:bold;font-size:16px;font-family:Verdana;'><tr><td>Vegetable Price List</td><td> as of  :" + dateasof + "</td></tr><tr><td></td></tr></table>");
            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:soild 1px #999; } " +
                "TD { border:soild 1px #D5D5D5; text-align:center } </style>");
            Response.Write("<table><tr><td>");
            Response.Write(objSW.ToString());
            Response.Write("</td></tr></table>");
            Response.End();
            dg = null;


            //HttpContext.Current.Response.Clear();
            //HttpContext.Current.Response.ClearContent();
            //HttpContext.Current.Response.ClearHeaders();
            //HttpContext.Current.Response.Buffer = true;
            //string attachment = sFileName + ".xls";
            //HttpContext.Current.Response.Clear();
            //HttpContext.Current.Response.Write(@"<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">");
            //HttpContext.Current.Response.AddHeader("content-disposition", attachment);
            //HttpContext.Current.Response.Charset = "utf-8";
            //HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.GetEncoding("windows-1250");
            //HttpContext.Current.Response.Write("<font style='font-size:10.0pt; font-family:Calibri;'>");

            //HttpContext.Current.Response.Write("<BR><BR><BR>");
            //HttpContext.Current.Response.Write("<Table border='1' bgColor='#ffffff' borderColor='#000000' cellSpacing='0' cellPadding='0' style='font-size:10.0pt; font-family:Calibri; background:white;'> <TR>");

            //HttpContext.Current.Response.Write("<Td colspan='10' cellSpacing='0' cellPadding='0' style='font-size:12.0pt; font-family:Calibri; background:yellow;'>");
            //HttpContext.Current.Response.Write("<B>");
            //HttpContext.Current.Response.Write("Vegitable Price List -&nbsp;&nbsp;" + "as on " + dateasof + "&nbsp;&nbsp;");
            //HttpContext.Current.Response.Write("</B>");
            //HttpContext.Current.Response.Write("</Td>");
            //HttpContext.Current.Response.Write("</TR>");
            //HttpContext.Current.Response.Write("<TR>");
            //HttpContext.Current.Response.Write("<Td>");
            //HttpContext.Current.Response.Write("");
            //HttpContext.Current.Response.Write("</Td>");
            //HttpContext.Current.Response.Write("</TR>");

            ////int columnscount = rdgLdMangReport.Columns.Count;
            //HttpContext.Current.Response.Write("<TR>");
            //foreach (DataColumn dc in dt.Columns)
            //{
            //    HttpContext.Current.Response.Write("<Td cellSpacing='0' cellPadding='0' style='font-size:12.0pt; font-family:Calibri; background:yellow;'>");
            //    HttpContext.Current.Response.Write("<B>");
            //    HttpContext.Current.Response.Write(dc.ColumnName);
            //    HttpContext.Current.Response.Write("</B>");
            //    HttpContext.Current.Response.Write("</Td>");

            //}
            ////for (int j = 0; j < columnscount; j++)
            ////{
            ////    HttpContext.Current.Response.Write("<Td>");
            ////    HttpContext.Current.Response.Write("<B>");
            ////    HttpContext.Current.Response.Write(rdgLdMangReport.Columns[j].HeaderText.ToString());
            ////    HttpContext.Current.Response.Write("</B>");
            ////    HttpContext.Current.Response.Write("</Td>");
            ////}
            //HttpContext.Current.Response.Write("</TR>");
            //foreach (DataRow row in dt.Rows)
            //{
            //    HttpContext.Current.Response.Write("<TR>");
            //    for (int i = 0; i < dt.Columns.Count; i++)
            //    {
            //        HttpContext.Current.Response.Write("<Td>");
            //        HttpContext.Current.Response.Write(row[i].ToString());
            //        HttpContext.Current.Response.Write("</Td>");
            //    }

            //    HttpContext.Current.Response.Write("</TR>");
            //}
            //HttpContext.Current.Response.Write("</Table>");
            //HttpContext.Current.Response.Write("</font>");
            //HttpContext.Current.Response.Flush();
            //HttpContext.Current.Response.End();




        }

        else
        {
            WebMsgBox.Show("Cannot Export Please Try Again Later.");
        }
        Session["GridData"] = null;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (ChkDontShow.Checked == false)
        {

            DataSet dsDetails = new DataSet();
            SqlCommand cmd = new SqlCommand("Get_VegList", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IMODE", 2);
            cmd.Parameters.AddWithValue("@month", drpMonth.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@SelGroup", drpGroup.SelectedValue);
            cmd.Parameters.AddWithValue("@SelItem", drpItem.SelectedValue);

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsDetails);
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                rgVegList.DataSource = dsDetails.Tables[0];
                rgVegList.DataBind();
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
            }
            else
            {
                //WebMsgBox.Show("There is No Record ");
                rgVegList.DataSource = string.Empty;
                rgVegList.DataBind();
            }
            Session["GridData"] = dsDetails.Tables[0];
        }
        if (ChkDontShow.Checked == true)
        {

            DataSet dsDetails = new DataSet();
            SqlCommand cmd = new SqlCommand("Get_VegList", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IMODE", 3);
            cmd.Parameters.AddWithValue("@month", drpMonth.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@SelGroup", drpGroup.SelectedValue);
            cmd.Parameters.AddWithValue("@SelItem", drpItem.SelectedValue);

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsDetails);
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                rgVegList.DataSource = dsDetails.Tables[0];
                rgVegList.DataBind();
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
            }
            else
            {
                //WebMsgBox.Show("There is No Record ");
                rgVegList.DataSource = string.Empty;
                rgVegList.DataBind();
            }
            Session["GridData"] = dsDetails.Tables[0];
        }
    }
    protected void drpGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadDrpItem();
    }
    protected void drpItem_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void ChkDontShow_CheckedChanged(object sender, EventArgs e)
    {

        if (ChkDontShow.Checked == true)
        {

            DataSet dsDetails = new DataSet();
            SqlCommand cmd = new SqlCommand("Get_VegListDontShowAllNull", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IMODE", 2);
            cmd.Parameters.AddWithValue("@month", drpMonth.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@SelGroup", drpGroup.SelectedValue);
            cmd.Parameters.AddWithValue("@SelItem", drpItem.SelectedValue);

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsDetails);
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                rgVegList.DataSource = dsDetails.Tables[0];
                rgVegList.DataBind();
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
            }
            else
            {
                //WebMsgBox.Show("There is No Record ");
                rgVegList.DataSource = string.Empty;
                rgVegList.DataBind();
                //rgVegList.Width = Unit.Pixel(1200);
            }
            Session["GridData"] = dsDetails.Tables[0];

        }
        if (ChkDontShow.Checked == false)
        {

            DataSet dsDetails = new DataSet();
            SqlCommand cmd = new SqlCommand("Get_VegListDontShowAllNull", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IMODE", 1);
            cmd.Parameters.AddWithValue("@month", drpMonth.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@SelGroup", drpGroup.SelectedValue);
            cmd.Parameters.AddWithValue("@SelItem", drpItem.SelectedValue);

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsDetails);
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                rgVegList.DataSource = dsDetails.Tables[0];
                rgVegList.DataBind();
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
            }
            else
            {
                //WebMsgBox.Show("There is No Record ");
                rgVegList.DataSource = string.Empty;
                rgVegList.DataBind();
            }
            Session["GridData"] = dsDetails.Tables[0];
        }

    }
    protected void ChkYeterday_CheckedChanged(object sender, EventArgs e)
    {
        if (ChkYeterday.Checked == true)
        {
            lblyesterday.Visible = true;
            yesterdaySearch.Visible = true;
            rdYesterdayVegList.Visible = true;
            rgVegList.Width = Unit.Pixel(900);
            rdYesterdayVegList.Height = Unit.Pixel(310);

            rdYesterdayVegList.Width = Unit.Pixel(250);//Get_VegListYesterday

            DataSet dsDetails = new DataSet();
            SqlCommand cmd = new SqlCommand("Get_VegListYesterday", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IMODE", 1);
            cmd.Parameters.AddWithValue("@month", drpMonth.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@SelGroup", drpGroup.SelectedValue);
            cmd.Parameters.AddWithValue("@SelItem", drpItem.SelectedValue);

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsDetails);
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                rdYesterdayVegList.DataSource = dsDetails.Tables[0];
                rdYesterdayVegList.DataBind();
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
            }
            else
            {
                //WebMsgBox.Show("There is No Record ");
                rdYesterdayVegList.DataSource = string.Empty;
                rdYesterdayVegList.DataBind();
            }
            // Session["GridData"] = dsDetails.Tables[0];
        }
        if (ChkYeterday.Checked == false)
        {
            lblyesterday.Visible = false;
            yesterdaySearch.Visible = false;
            rdYesterdayVegList.Visible = false;
            rgVegList.Width = Unit.Pixel(1190);
            rdYesterdayVegList.Width = Unit.Pixel(0);
            rdYesterdayVegList.Height = Unit.Pixel(0);
        }
    }

    protected void yesterdaySearch_Click1(object sender, EventArgs e)
    {
        if (ChkYeterday.Checked == true)
        {
            lblyesterday.Visible = true;
            yesterdaySearch.Visible = true;
            rdYesterdayVegList.Visible = true;
            rgVegList.Width = Unit.Pixel(900);
            rdYesterdayVegList.Height = Unit.Pixel(310);
            rdYesterdayVegList.Width = Unit.Pixel(250);//Get_VegListYesterday

            DataSet dsDetails = new DataSet();
            SqlCommand cmd = new SqlCommand("Get_VegListYesterday", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IMODE", 1);
            cmd.Parameters.AddWithValue("@month", drpMonth.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@SelGroup", drpGroup.SelectedValue);
            cmd.Parameters.AddWithValue("@SelItem", drpItem.SelectedValue);

            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsDetails);
            if (dsDetails.Tables[0].Rows.Count > 0)
            {
                rdYesterdayVegList.DataSource = dsDetails.Tables[0];
                rdYesterdayVegList.DataBind();
                //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
            }
            else
            {
                //WebMsgBox.Show("There is No Record ");
                rdYesterdayVegList.DataSource = string.Empty;
                rdYesterdayVegList.DataBind();
            }
            //Session["GridData"] = dsDetails.Tables[0];
        }
        if (ChkYeterday.Checked == false)
        {
            lblyesterday.Visible = true;
            yesterdaySearch.Visible = true;
            rdYesterdayVegList.Visible = false;
            rgVegList.Width = Unit.Pixel(1190);
            rdYesterdayVegList.Width = Unit.Pixel(0);
            rdYesterdayVegList.Height = Unit.Pixel(0);
        }
    }
    protected void lnlLink_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        string ItemType = lnk.Text;
        string url = "KitchenCharts.aspx?Item=" + ItemType + "&month=" + drpMonth.SelectedValue.ToString() + "";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(url);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),"script", sb.ToString());
       
       
    }
}