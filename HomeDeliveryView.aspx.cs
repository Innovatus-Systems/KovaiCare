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

public partial class HomeDeliveryView : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           
            LoadTitle();
            string dt = DateTime.Now.ToString("ddd dd-MMM-yyyy");
            dt = "Today : " + dt;
            lbltoday.Text = dt;
            loadGrid("Latest");
            tbl1.Visible = false;


        }
    }
    private void loadGrid(string day)
    {
        Session["BtnClick"] = day;
        lblselect.Text = "Selected : " + Session["BtnClick"].ToString();
        DataSet dsDetails = new DataSet();
        SqlCommand cmd = new SqlCommand("Get_HomeDeliveryList", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@day", day);
        SqlDataAdapter dap = new SqlDataAdapter(cmd);
        dap.Fill(dsDetails);
        if (dsDetails.Tables[0].Rows.Count > 0)
        {
            rgHDview.DataSource = dsDetails.Tables[0];
            rgHDview.DataBind();
            //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
        }
        else
        {
            //WebMsgBox.Show("There is No Record ");
            rgHDview.DataSource = string.Empty;
            rgHDview.DataBind();
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 135 });


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
    protected void btnToday_Click(object sender, EventArgs e)
    {
        loadGrid("Today");
        tbl1.Visible = true;
        DataSet dsDetails = new DataSet();
        SqlCommand cmd = new SqlCommand("Get_HomeDeliveryList", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@day", "Today");
        SqlDataAdapter dap = new SqlDataAdapter(cmd);
        dap.Fill(dsDetails);       
        if (dsDetails.Tables[1].Rows.Count > 0)
        {
            CD.Text = dsDetails.Tables[1].Rows[0]["CDelivered"].ToString();
            CP.Text = dsDetails.Tables[1].Rows[0]["CPickedup"].ToString();

        }
        else
        {
            CD.Text = "-";
            CP.Text = "-";
        }
        if (dsDetails.Tables[2].Rows.Count > 0)
        {
            FD.Text = dsDetails.Tables[2].Rows[0]["FDelivered"].ToString();
            FP.Text = dsDetails.Tables[2].Rows[0]["FPickedup"].ToString();

        }
        else
        {
            FD.Text = "-";
            FP.Text = "-";
        }


    }
    protected void btnYesterday_Click(object sender, EventArgs e)
    {
        loadGrid("Yesterday");
        tbl1.Visible = false;       
    }
    protected void rgHDview_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            GridDataItem dataItem = (GridDataItem)e.Item;
            TableCell Mode = dataItem["Mode"];

            if ((Mode.Text == "CD" || Mode.Text == "FD"))
            {
                //dataItem.BackColor = System.Drawing.Color.Red;  
                //dataItem["Mode"].BackColor = System.Drawing.Color.Red;
                dataItem["Mode"].ForeColor = System.Drawing.Color.Red;
                dataItem["Mode"].Font.Bold = true;
            }
            if ((Mode.Text == "CP" || Mode.Text == "FP"))
            {
                //dataItem.BackColor = System.Drawing.Color.Red;  
                //dataItem["Mode"].BackColor = System.Drawing.Color.Green;
                dataItem["Mode"].ForeColor = System.Drawing.Color.Green;
                dataItem["Mode"].Font.Bold = true;
            }
        }
    }


    protected void btnLatest_Click(object sender, EventArgs e)
    {
        Session["BtnClick"] = "Latest";
        tbl1.Visible = false;
        lblselect.Text = "Selected : " + "Last Action";
        DataSet dsDetails = new DataSet();
        SqlCommand cmd = new SqlCommand("Get_HomeDeliveryList", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@day", "Latest");

        SqlDataAdapter dap = new SqlDataAdapter(cmd);
        dap.Fill(dsDetails);
        if (dsDetails.Tables[0].Rows.Count > 0)
        {
            rgHDview.DataSource = dsDetails.Tables[0];
            rgHDview.DataBind();
            //ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert('Monthly billing statement generated successfully');", true);
        }
        else
        {
            //WebMsgBox.Show("There is No Record ");
            rgHDview.DataSource = string.Empty;
            rgHDview.DataBind();
        }
    }

    protected void rgHDview_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgHDview.FilterMenu;
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

    protected void rgHDview_ItemCommand(object sender, GridCommandEventArgs e)
    {
        loadGrid(Session["BtnClick"].ToString());
    }
}
