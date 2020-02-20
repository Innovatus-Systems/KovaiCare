using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PostMMTEdit : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                Button1.Visible = false;
               StringBuilder str = new StringBuilder();
               ViewState["RTRSN"] = Convert.ToInt32(Request.QueryString["NO"]);
               Status();
                
               DataSet dsRes = sqlobj.ExecuteSP("SP_GetResidentAutoDebits",
                   new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = ViewState["RTRSN"] });
               if (dsRes.Tables[0].Rows.Count > 0)
               {
                   lblDoorNo.Text = dsRes.Tables[0].Rows[0]["doorno"].ToString();
                   lblName.Text = dsRes.Tables[0].Rows[0]["name"].ToString();
                   lblaccountno.Text = dsRes.Tables[0].Rows[0]["accountno"].ToString();
                   lbldob.Text = dsRes.Tables[0].Rows[0]["dob"].ToString();
                   ddlStatus.SelectedValue = dsRes.Tables[0].Rows[0]["status"].ToString();
                   txtMCharge.Text = dsRes.Tables[0].Rows[0]["Maintenancecharge"].ToString();
                   txtkoc.Text = dsRes.Tables[0].Rows[0]["koc"].ToString();
                    txtNC.Text = dsRes.Tables[0].Rows[0]["NursingAD"].ToString();
                    if (dsRes.Tables[0].Rows[0]["DType"].ToString() == "Regular")
                   {
                       ddlDType.SelectedValue = "Y";
                   }
                   else
                   {
                       ddlDType.SelectedValue = "N";
                   }                 
               }
               dsRes.Dispose();
               this.Button1.Attributes.Add("OnClick", "self.close()");
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
            }
        }
    }
    
    protected void Status()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistStatus = new DataSet();
            ddlistStatus = sqlobj.ExecuteSP("SP_FetchStatusDropDown",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
            ddlStatus.DataSource = ddlistStatus.Tables[0];
            ddlStatus.DataValueField = "SCode";
            ddlStatus.DataTextField = "SDescription";
            ddlStatus.DataBind();
            ddlStatus.Dispose();
            ddlStatus.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    
        protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
                sqlobj.ExecuteNonQuery("SP_UpdateAutoDebitDetails",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = ViewState["RTRSN"] },
                new SqlParameter() { ParameterName = "@MMC", SqlDbType = SqlDbType.Decimal, Value = txtMCharge.Text },
                new SqlParameter() { ParameterName = "@KOC", SqlDbType = SqlDbType.Decimal, Value = txtkoc.Text },
                new SqlParameter() { ParameterName = "@NursingAD", SqlDbType = SqlDbType.Decimal, Value = txtNC.Text },
                new SqlParameter() { ParameterName = "@DType", SqlDbType = SqlDbType.NVarChar, Value =ddlDType.SelectedValue.ToString() },
                //new SqlParameter() { ParameterName = "@StartDate", SqlDbType = SqlDbType.DateTime, Value = dtpstartdate.SelectedDate == null ? null : dtpstartdate.SelectedDate },
                //new SqlParameter() { ParameterName = "@EndDate", SqlDbType = SqlDbType.DateTime, Value = dtpenddate.SelectedDate == null ? null : dtpenddate.SelectedDate },
                new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue }
                ); 
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Resident auto debit details successfully updated.');", true);
                //WebMsgBox.Show("Resident auto debit details successfully updated.");   
            Button1_Click(sender, e);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message + "');", true);
            
        }
    
    }
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Write("<script language='javascript'> { self.close() }</script>");
        }
}