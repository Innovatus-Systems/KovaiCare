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

public partial class RMMenu : System.Web.UI.Page
{
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {

        rwAddIngredients.VisibleOnPageLoad = true;
        rwAddIngredients.Visible = false;

        if (!IsPostBack)
        {

            LoadTitle();
            LoadUserGrid();
            btnUpdate.Visible = false;
            //btnDelete.Visible = false;
            //txtmnucode.Text = RMMenuID();
            LoadRMCode();
            LoadItem();
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 19 });


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
            Response.Redirect("FoodMenu.aspx?MenuName=Help");
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
    public void LoadUserGrid()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_RMMenu", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 4);
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet dsUsers = new DataSet();
            dap.Fill(dsUsers, "temp");
            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                gvMenu.DataSource = dsUsers;
                gvMenu.DataBind();
            }
            else
            {
                gvMenu.DataSource = new string[] { };
                gvMenu.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void LoadItem()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsFetchAT = new DataSet();
            ddlMenuItem.Items.Clear();
            dsFetchAT = sqlobj.ExecuteSP("Load_ItemMenu");
            ddlMenuItem.DataSource = dsFetchAT.Tables[0];
            ddlMenuItem.DataValueField = "ItmCode";
            ddlMenuItem.DataTextField = "Item";
            ddlMenuItem.DataBind();
            ddlMenuItem.Dispose();
            ddlMenuItem.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    public void LoadRMCode()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Load_RMCode", con);
            cmd.CommandType = CommandType.StoredProcedure;          
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            DataSet dsUsers = new DataSet();
            dap.Fill(dsUsers, "temp");
            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                ddlRMCode.DataSource = dsUsers.Tables[0];
                ddlRMCode.DataTextField = "RMName";
                ddlRMCode.DataValueField = "RMCode";
                ddlRMCode.DataBind();
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
            SqlCommand cmd = new SqlCommand("Proc_RMMenu", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 1);
            cmd.Parameters.AddWithValue("@MenuCode", ddlMenuItem.SelectedValue );
            cmd.Parameters.AddWithValue("@RMCode", ddlRMCode.SelectedValue);
            cmd.Parameters.AddWithValue("@InputQty", txtinputqty.Text);
            cmd.Parameters.AddWithValue("@InputUOM", ddlInputuom.SelectedValue);
            cmd.Parameters.AddWithValue("@OutputQty", txtoutputqty.Text);
            cmd.Parameters.AddWithValue("@OutputUOM", ddloutuom.SelectedValue);
            cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            LoadUserGrid();
            Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Recipes details added successfully');", true);
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_RMMenu", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 2);
            cmd.Parameters.AddWithValue("@RSN", hbtnRSN.Value);
            cmd.Parameters.AddWithValue("@MenuCode", ddlMenuItem.SelectedValue);
            cmd.Parameters.AddWithValue("@RMCode", ddlRMCode.SelectedValue);
            cmd.Parameters.AddWithValue("@InputQty", txtinputqty.Text);
            cmd.Parameters.AddWithValue("@InputUOM", ddlInputuom.SelectedValue);
            cmd.Parameters.AddWithValue("@OutputQty", txtoutputqty.Text);
            cmd.Parameters.AddWithValue("@OutputUOM", ddloutuom.SelectedValue);
            cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
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
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Recipes details updated successfully');", true);
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_RMMenu", con);
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
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Recipes details deleted successfully');", true);
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
    public string RMMenuID()
    {
        string strID = "";
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_RMMenuID", con);
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
                    strID = dr["Menucode"].ToString();
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
    public void Clear()
    {       
        txtinputqty.Text = string.Empty;
        //txtmnucode.Text = string.Empty;
        txtoutputqty.Text = string.Empty;
        txtRemarks.Text = string.Empty;
       // txtmnucode.Text = RMMenuID();
        //ddlMenuItem.select.Tex = "--Select--";
        LoadItem();
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ResidentAdd.aspx");
    }
    protected void RMCare_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        if (e.Item.Text == "Checkout register")
        {
            Response.Redirect("CheckINOUT.aspx");
        }
        else if (e.Item.Text == "Living alone")
        {
            Response.Redirect("SAlone.aspx?Value=" + 1);
        }
        else if (e.Item.Text == "Birthdays in 7 days")
        {
            Response.Redirect("BirthdayGrid.aspx");
        }
        else if (e.Item.Text == "Raw material master")
        {
            Response.Redirect("RawMaterial.aspx");
        }
        else if (e.Item.Text == "Raw material menu")
        {
            Response.Redirect("RMMenu.aspx");
        }
        else if (e.Item.Text == "Help")
        {

        }
    }
    protected void gvMenu_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            string[] commandargs = e.CommandArgument.ToString().Split(',');
            hbtnRSN.Value = commandargs[0].ToString();
            //hbtnRSN.Value = e.CommandArgument.ToString();


            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_GetFoodIngredients",
                new SqlParameter() { ParameterName = "@RSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = hbtnRSN.Value });           
           
 
           if (dsGroup.Tables[0].Rows.Count >0)
           {
               ddlRMCode.SelectedValue = dsGroup.Tables[0].Rows[0]["RMCode"].ToString();

               ddlMenuItem.SelectedValue = dsGroup.Tables[0].Rows[0]["MenuCode"].ToString();


               txtinputqty.Text = dsGroup.Tables[0].Rows[0]["InputQty"].ToString();
               ddlInputuom.SelectedValue = dsGroup.Tables[0].Rows[0]["InputUom"].ToString();
               txtoutputqty.Text = dsGroup.Tables[0].Rows[0]["OutputQty"].ToString();
               ddloutuom.SelectedValue = dsGroup.Tables[0].Rows[0]["OutputUom"].ToString();

               txtRemarks.Text = dsGroup.Tables[0].Rows[0]["Remarks"].ToString();

               btnSave.Visible = false;
               //btnDelete.Visible = true;
               btnUpdate.Visible = true;

           }

                
           
        }
        else
        {
            LoadUserGrid();
        }
    }
    protected void btnISave_Click(object sender, EventArgs e)
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
            if (dsCheck.Tables[0].Rows.Count > 0)
            {
                if (dsCheck.Tables[0].Rows[0][0].ToString() == "1")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('RM Code already exists');", true);
                    return;
                }
                else
                {
                    SqlCommand cmd = new SqlCommand("Proc_RawMaterial", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@i", 1);
                    cmd.Parameters.AddWithValue("@RMCode", txtRMCode.Text);
                    cmd.Parameters.AddWithValue("@RMName", txtRMName.Text);
                    cmd.Parameters.AddWithValue("@Supplier", txtSupp.Text);
                    //cmd.Parameters.AddWithValue("@Category", ddlStatus.SelectedValue);
                    if (con.State.Equals(ConnectionState.Open))
                    {
                        con.Close();
                    }
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    LoadRMCode();
                    IClear();
                    rwAddIngredients.Visible = true;
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Raw materials added successfully');", true);
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnIClear_Click(object sender, EventArgs e)
    {
        try
        {
            IClear();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    public void IClear()
    {
        txtRMCode.Text = string.Empty;
        txtRMName.Text = string.Empty;
        txtSupp.Text = string.Empty;
        //txtRMCode.Text = RawMaterialID();
        txtRMCode.Enabled = true;
    }
    protected void btnIExit_Click(object sender, EventArgs e)
    {
        try
        {
            rwAddIngredients.Visible = false;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void lnkaddingredient_Click(object sender, EventArgs e)
    {
        try
        {
            rwAddIngredients.Visible = true;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvMenu_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvMenu.FilterMenu;
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