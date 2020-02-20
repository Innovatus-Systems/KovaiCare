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

public partial class RawMaterial : System.Web.UI.Page
{
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;

        if (!IsPostBack)
        {
            LoadTitle();
            LoadProvisionGroup();
            LoadUserGrid();           
            btnUpdate.Visible = false;
            //btnDelete.Visible = false;
            //txtRMCode.Text = RawMaterialID();
            LoadUOM();
            dsDT = sqlobj.ExecuteSP("GetServerDateTime");
            //dtpOpeningStk.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
            dtpClosingStk.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 17 });


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

    private void LoadProvisionGroup()
    {
        try
        {
            DataSet dsLoadProvisionType = sqlobj.ExecuteSP("SP_ProvisionType", new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 }
                );


            if (dsLoadProvisionType.Tables[0].Rows.Count > 0)
            {

                ddlGroup.DataSource = dsLoadProvisionType;
                ddlGroup.DataTextField = "PCode";
                ddlGroup.DataValueField = "PCode";
                ddlGroup.DataBind();
               
            }
            
            dsLoadProvisionType.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void RMCare_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        if (e.Item.Text == "Food Items")
        {
            Response.Redirect("RawMaterial.aspx");
        }
        if (e.Item.Text == "Food Ingredients")
        {
            Response.Redirect("RMMenu.aspx");
        }
        if (e.Item.Text == "Sessions")
        {
            Response.Redirect("SessionMaster.aspx");
        }
        if (e.Item.Text == "Which Item When?")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Which Menu When?");
        }
        else if (e.Item.Text == "How many diners?")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=How many diners?");
        }
        else if (e.Item.Text == "Menu for the day")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Menu For Day");
        }
        else if (e.Item.Text == "Menu Items")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Menu Items");
        }

        else if (e.Item.Text == "Help")
        {
            Response.Redirect("FoodMenu.aspx");
        }
        else if (e.Item.Text == "Diners Update")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Diners Update");
        }
        else if (e.Item.Text == "Dining Transactions")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Dining Transactions");
        }
    }
    public string RawMaterialID()
    {
        string strID = "";
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_RawMaterialID", con);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    strID = dr["RawCode"].ToString();
                }
            }
            dr.Close();
            con.Close();
        }
        catch (Exception ex)
        {

        }
        return strID;
    }
    public void LoadUserGrid()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_RawMaterial", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 4);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet dsUsers = new DataSet();
            dap.Fill(dsUsers, "temp");
            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                gvRawMaterial.DataSource = dsUsers;
                gvRawMaterial.DataBind();
            }
            else
            {
                gvRawMaterial.DataSource = new string[] {};
                gvRawMaterial.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand selcmd = new SqlCommand("Proc_RawMaterial", con);
            selcmd.CommandType = CommandType.StoredProcedure;
            selcmd.Parameters.AddWithValue("@i", 5);
            selcmd.Parameters.AddWithValue("@RMCode", txtRMCode.Text);
            SqlDataAdapter dap = new SqlDataAdapter(selcmd);
            DataSet dsCheck = new DataSet();
            dap.Fill(dsCheck, "temp");
            if(dsCheck.Tables[0].Rows.Count > 0)
            {
                if(dsCheck.Tables[0].Rows[0][0].ToString() == "1")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Code already exists');", true);
                    return;
                }
                else
                {
                    SqlCommand cmd = new SqlCommand("Proc_RawMaterial", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@i", 1);
                    cmd.Parameters.AddWithValue("@RSN", 1);
                    cmd.Parameters.AddWithValue("@RMCode", txtRMCode.Text);
                    cmd.Parameters.AddWithValue("@RMName", txtRMName.Text);
                    cmd.Parameters.AddWithValue("@Supplier", txtSupp.Text);

                    cmd.Parameters.AddWithValue("@ReceiptUOM", ddlIUOM.SelectedValue);
                    cmd.Parameters.AddWithValue("@IssueUOM", ddlIUOM.SelectedValue);
                    cmd.Parameters.AddWithValue("@OpeningStock", txtClosingStock.Text);
                    cmd.Parameters.AddWithValue("@OSDate", dtpClosingStk.SelectedDate);
                    cmd.Parameters.AddWithValue("@ClosingStock", 0);
                    cmd.Parameters.AddWithValue("@CSDate", dtpClosingStk.SelectedDate);
                    cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
                    cmd.Parameters.AddWithValue("@StockGroup", ddlGroup.SelectedValue);
                    cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                    cmd.Parameters.AddWithValue("@ReOrderLevel", txtReorderlevel.Text);
                    cmd.Parameters.AddWithValue("@MinStock", txtminstock.Text);
                    
                    if (con.State.Equals(ConnectionState.Open))
                    {
                        con.Close();
                    }
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    LoadUserGrid();
                    Clear();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Raw materials added successfully');", true);
                }
            }            
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_RawMaterial", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 2);
            cmd.Parameters.AddWithValue("@RSN", hdnRSN.Value);
            cmd.Parameters.AddWithValue("@RMCode", txtRMCode.Text);
            cmd.Parameters.AddWithValue("@RMName", txtRMName.Text);
            cmd.Parameters.AddWithValue("@Supplier", txtSupp.Text);

            cmd.Parameters.AddWithValue("@ReceiptUOM", ddlIUOM.SelectedValue);
            cmd.Parameters.AddWithValue("@IssueUOM", ddlIUOM.SelectedValue);
            cmd.Parameters.AddWithValue("@OpeningStock", txtClosingStock.Text);
            cmd.Parameters.AddWithValue("@OSDate", dtpClosingStk.SelectedDate);
            cmd.Parameters.AddWithValue("@ClosingStock", txtClosingStock.Text);
            cmd.Parameters.AddWithValue("@CSDate", dtpClosingStk.SelectedDate);
            cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
            cmd.Parameters.AddWithValue("@StockGroup", ddlGroup.SelectedValue);
            cmd.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@ReOrderLevel", txtReorderlevel.Text);
            cmd.Parameters.AddWithValue("@MinStock", txtminstock.Text);
            
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Clear();
            LoadUserGrid();
            btnSave.Visible = true;
            //btnDelete.Visible = false;
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Raw materials updated successfully');", true);
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_RawMaterial", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 3);
            cmd.Parameters.AddWithValue("@RSN", hbtnRSN.Value);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Clear();
            LoadUserGrid();
            btnSave.Visible = true;
            //btnDelete.Visible = false;
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Raw materials deleted successfully');", true);
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
        btnSave.Visible = true;
        //btnDelete.Visible = false;
        btnUpdate.Visible = false;
    }
    public void Clear()
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsCDT = null;

        txtRMCode.Text = string.Empty;
        txtRMName.Text = string.Empty;
        txtSupp.Text = string.Empty;
        //txtRMCode.Text = RawMaterialID();
        txtRMCode.Enabled = true;

        //ddlIUOM.SelectedIndex = 0;
        ddlIUOM.SelectedIndex = 0;
        ddlGroup.SelectedIndex = 0;
        //txtOpeningStock.Text = string.Empty;
        txtClosingStock.Text = "0";
        txtRemarks.Text = string.Empty;

        ddlCategory.SelectedIndex = 0;
        txtminstock.Text = "0";
        txtReorderlevel.Text = "0";
        txtRate.Text = "0.00";



        dsCDT = sqlobj.ExecuteSP("GetServerDateTime");
        //dtpOpeningStk.SelectedDate = Convert.ToDateTime(dsCDT.Tables[0].Rows[0][0]);
        dtpClosingStk.SelectedDate = Convert.ToDateTime(dsCDT.Tables[0].Rows[0][0]);

        txtRMCode.Focus();

    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }
    protected void gvRawMaterial_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            //hbtnRSN.Value = e.CommandArgument.ToString();
            //if (e.Item is GridDataItem)
            //{
            //    GridDataItem ditem = (GridDataItem)e.Item;
            //    txtRMCode.Text = ditem["RMCode"].Text;
            //    txtRMName.Text = ditem["RMName"].Text;
            //    if (ditem["Supplier"].Text.ToString() != "&nbsp;")
            //    {
            //        txtSupp.Text = Convert.ToString(ditem["Supplier"].Text.ToString()); 
            //    }    
            //    else
            //    {
            //        txtSupp.Text = ""; 
            //    }
            //    //ddlStatus.SelectedValue = ditem["Category"].Text;

            //    txtRMCode.Enabled = false;
            //    btnSave.Visible = false;
            //    //btnDelete.Visible = true;
            //    btnUpdate.Visible = true;
            //}
        }
        else
        {
            LoadUserGrid();
        }
    }
    protected void RMKPlanner_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Food Items")
        {
            Response.Redirect("RawMaterial.aspx");
        }
        if (e.Item.Text == "Food Ingredients")
        {
            Response.Redirect("RMMenu.aspx");
        }
        if (e.Item.Text == "Sessions")
        {
            Response.Redirect("SessionMaster.aspx");
        }
        if (e.Item.Text == "Which Item When?")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Which Menu When?");
        }
        else if (e.Item.Text == "How many diners?")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=How many diners?");
        }
        else if (e.Item.Text == "Menu for the day")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Menu For Day");
        }
        else if (e.Item.Text == "Menu Items")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Menu Items");
        }

        else if (e.Item.Text == "Help")
        {
            Response.Redirect("FoodMenu.aspx");
        }
        else if (e.Item.Text == "Diners Update")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Diners Update");
        }
        else if (e.Item.Text == "Dining Transaction")
        {
            Response.Redirect("FoodMenu.aspx?MenuName=Dining Transaction");
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

            drow = dt.NewRow();
            drow["Code"] = "Kgs";
            drow["Text"] = "Kgs";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Grms";
            drow["Text"] = "Grms";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Ltrs";
            drow["Text"] = "Ltrs";
            dt.Rows.Add(drow);   

            drow = dt.NewRow();
            drow["Code"] = "Ml";
            drow["Text"] = "Ml";
            dt.Rows.Add(drow);   

            drow = dt.NewRow();
            drow["Code"] = "Nos";
            drow["Text"] = "Nos";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Pkt";
            drow["Text"] = "Pkt";
            dt.Rows.Add(drow);

            drow = dt.NewRow();
            drow["Code"] = "Buh";
            drow["Text"] = "Buh";
            dt.Rows.Add(drow); 
  


            //ddlRUOM.DataSource = dt;
            //ddlRUOM.DataTextField = dt.Columns["Text"].ToString();
            //ddlRUOM.DataValueField = dt.Columns["Code"].ToString();
            //ddlRUOM.DataBind();

            ddlIUOM.DataSource = dt;
            ddlIUOM.DataTextField = dt.Columns["Text"].ToString();
            ddlIUOM.DataValueField = dt.Columns["Code"].ToString();
            ddlIUOM.DataBind();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LnkEditItem_Click(object sender, EventArgs e)
    {
        try
        {
            txtRMCode.Enabled = false;
            btnSave.Visible = false;
            //btnDelete.Visible = true;
            btnUpdate.Visible = true;

            btnUpdate.Visible = true;
            btnSave.Visible = false;
            LinkButton lnkEdititemBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdititemBtn.NamingContainer;
            string RSN;
            RSN = row.Cells[3].Text;

           
            hdnRSN.Value = RSN.ToString();
            SqlProcsNew proc = new SqlProcsNew();
            //DataSet dsDT = null;


            DataSet dsDT = sqlobj.ExecuteSP("Proc_RawMaterial",
               new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 6 },
               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = RSN });

          
            txtRMCode.Text = dsDT.Tables[0].Rows[0]["RMCode"].ToString();
            txtRMName.Text = dsDT.Tables[0].Rows[0]["RMName"].ToString();
            ddlIUOM.SelectedValue = dsDT.Tables[0].Rows[0]["ReceiptUOM"].ToString();
            ddlIUOM.SelectedValue = dsDT.Tables[0].Rows[0]["IssueUOM"].ToString();
            //txtOpeningStock.Text = dsDT.Tables[0].Rows[0]["OpeningStock"].ToString();
            //dtpOpeningStk.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0]["OSDate"].ToString());
            txtClosingStock.Text = dsDT.Tables[0].Rows[0]["ClosingStock"].ToString();
            dtpClosingStk.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0]["CSDate"].ToString());
            txtSupp.Text = dsDT.Tables[0].Rows[0]["Supplier"].ToString();
            txtRemarks.Text = dsDT.Tables[0].Rows[0]["Remarks"].ToString();
            ddlGroup.SelectedValue = dsDT.Tables[0].Rows[0]["StockGroup"].ToString();
            ddlCategory.SelectedValue = dsDT.Tables[0].Rows[0]["Category"].ToString().Trim();
            txtReorderlevel.Text = dsDT.Tables[0].Rows[0]["ReOrderLevel"].ToString();
            txtminstock.Text = dsDT.Tables[0].Rows[0]["MinStock"].ToString();
            txtRate.Text = dsDT.Tables[0].Rows[0]["AvgRate"].ToString();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        gvRawMaterial.ExportSettings.ExportOnlyData = true;
        gvRawMaterial.ExportSettings.FileName = "Provisons and Groceries List";
        gvRawMaterial.ExportSettings.IgnorePaging = true;
        gvRawMaterial.ExportSettings.OpenInNewWindow = true;
        gvRawMaterial.MasterTableView.ExportToExcel();
    }
    protected void lnkvegetableprice_Click(object sender, EventArgs e)
    {
        Page.ClientScript.RegisterStartupScript(
        this.GetType(), "OpenWindow", "window.open('http://www.door2door.co.in/394-vegetables','_newtab');", true);
    }
    protected void gvRawMaterial_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvRawMaterial.FilterMenu;
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