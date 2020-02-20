using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using Telerik.Web.UI;
using System.Data;
using System.Data;
using System.Data.SqlClient;


public partial class SearchMenu : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            gvMenu.Visible = false;
        }
        
    }

    [WebMethod]
    public static string[] GetMenu(string prefix)
    {
        List<string> customers = new List<string>();
        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select Title,[Description] from tblmenus where [Description] like '%'+ @SearchText + '%'";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}-{1}", sdr["Title"], sdr["Description"]));
                    }
                }
                conn.Close();
            }
        }
        return customers.ToArray();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            gvMenu.Visible = true;
            LoadMenus();
        }
        catch(Exception ex)
        {

        }
    }
    private void LoadMenus()
    {
        try
        {
            DataSet dsmenus = sqlobj.ExecuteSP("SP_ProgMenus",
                  new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 6 },
                  new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtsearch.Text.ToString()});

            if (dsmenus.Tables[0].Rows.Count > 0)
            {
                gvMenu.DataSource = dsmenus;
                gvMenu.DataBind();
            }
            else
            {
                gvMenu.DataSource = string.Empty;
                gvMenu.DataBind();
            }

            dsmenus.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void gvMenu_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadMenus();
    }

    protected void gvMenu_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvMenu.FilterMenu;
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