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
using System.IO;

public partial class BillingPeriods : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadBillingPeriodGrid();
            ddlBStatus.Items.Insert(0, new ListItem("--SELECT--", "99"));
        }

    }
    private void Clear()
    {
        try
        {
            txtBMonth.Text = "";
            txtSplMsg.Text = "";
            ddlBStatus.SelectedValue = "99";
            dtBDATE.SelectedDate = DateTime.Now;
            BPFrom.SelectedDate = null;
            BPTill.SelectedDate = null;
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 150 });
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
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
    }

    protected void btnnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (string.IsNullOrEmpty(txtBMonth.Text) || string.IsNullOrEmpty(txtSplMsg.Text) || ddlBStatus.SelectedValue == "99" || BPFrom.SelectedDate == null || BPTill.SelectedDate == null)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please provide all details');", true);
            }
            else
            {
                sqlobj.ExecuteSQLNonQuery("SP_InsertBPeriodDtls",
                            new SqlParameter() { ParameterName = "@BPName", SqlDbType = SqlDbType.NVarChar, Value = txtBMonth.Text.ToString() },
                            new SqlParameter() { ParameterName = "@BPFrom", SqlDbType = SqlDbType.DateTime, Value = BPFrom.SelectedDate },
                            new SqlParameter() { ParameterName = "@BPTill", SqlDbType = SqlDbType.DateTime, Value = BPTill.SelectedDate },
                            new SqlParameter() { ParameterName = "@SplMsg", SqlDbType = SqlDbType.NVarChar, Value = txtSplMsg.Text.ToString() },
                            new SqlParameter() { ParameterName = "@BStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlBStatus.SelectedValue.ToString() },
                            new SqlParameter() { ParameterName = "@BDate", SqlDbType = SqlDbType.DateTime, Value = dtBDATE.SelectedDate },
                            new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["BPRSN"] }
                    );
                LoadBillingPeriodGrid();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Billing Period Detail Updated Successfully.');", true);
                Clear();
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('divtext').style.display = 'none';", true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void LoadBillingPeriodGrid()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("[SP_FetchBPDtls]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
            DataSet dsGrid = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dsGrid);
            if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
            {
                BPgrdView.DataSource = dsGrid.Tables[0];
                BPgrdView.DataBind();
            }
            else
            {
                BPgrdView.DataSource = new String[] { };
                BPgrdView.DataBind();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void Lnkbtnedit_Click(object sender, EventArgs e)
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('divtext').style.display = '';", true);
            string BPRSN;
            LinkButton LnkEditBPBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)LnkEditBPBtn.NamingContainer;
            Session["BPRSN"] = row.Cells[2].Text;
            BPRSN = Session["BPRSN"].ToString();
            DataSet ds = sqlobj.ExecuteSP("SP_FetchBPDtls",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 },
                  new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = Session["BPRSN"] }
                );
            if(ds.Tables[0].Rows.Count>0)
            {
                txtBMonth.Text = ds.Tables[0].Rows[0]["BPName"].ToString();
                txtSplMsg.Text = ds.Tables[0].Rows[0]["BPSpecialMsg"].ToString();
                ddlBStatus.SelectedValue = ds.Tables[0].Rows[0]["BStatus"].ToString();
                BPFrom.SelectedDate = DateTime.Parse(ds.Tables[0].Rows[0]["BPFrom"].ToString());
                BPTill.SelectedDate = DateTime.Parse(ds.Tables[0].Rows[0]["BPTill"].ToString());
                if (ds.Tables[0].Rows[0]["BDate"].ToString() == "-")
                {
                    dtBDATE.SelectedDate = null;
                }
                else
                {
                    dtBDATE.SelectedDate = DateTime.Parse(ds.Tables[0].Rows[0]["BDate"].ToString());
                }      
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Nerwork Error, Please try again later.');", true);
            }

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
}