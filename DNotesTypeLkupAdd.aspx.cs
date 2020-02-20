using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DNotesTypeLkupAdd : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 149 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(txtDNCODE.Text) && string.IsNullOrEmpty(txtDNDESC.Text))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please fill all columns.');", true);
                return;
            }
            else
            {
                DataSet ds = sqlobj.ExecuteSP("SP_DinersNotes",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 6 },
                new SqlParameter() { ParameterName = "@DNCODE", SqlDbType = SqlDbType.NVarChar, Value = txtDNCODE.Text },
                 new SqlParameter() { ParameterName = "@DNDESC", SqlDbType = SqlDbType.NVarChar, Value = txtDNDESC.Text }
               );
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('New Type Inserted Successfully.');", true);
                txtDNCODE.Text = "";
                txtDNDESC.Text = "";
            }

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
}