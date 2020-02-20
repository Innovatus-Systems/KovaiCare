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

public partial class BCodesEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int BRSN = Convert.ToInt32(Session["BillRSN"]);
           if(!IsPostBack)
        {

            LoadBillCodeDetails();

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {

      
         SqlProcsNew sqlobj = new SqlProcsNew();

        if (HResult.Value == "true")
       
        {
            int BRSN = Convert.ToInt32(Session["BillRSN"]);

              if (TxtBCode.Text != "0" && TxtBCR.Text != String.Empty )
            {
            try
            {
               
                              sqlobj.ExecuteSQLNonQuery("SP_UpdateBillingCodes",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                     new SqlParameter() { ParameterName = "@BRSN", SqlDbType = SqlDbType.Int, Value = BRSN.ToString() },
                  new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = TxtBCode.Text },
                  new SqlParameter() { ParameterName = "@BCodeDescription", SqlDbType = SqlDbType.NVarChar, Value = TxtBCD.Text },
                                   new SqlParameter() { ParameterName = "@MaxPerDay", SqlDbType = SqlDbType.Int, Value = ddlMPD.SelectedValue },
                                     new SqlParameter() { ParameterName = "@BCodeRate", SqlDbType = SqlDbType.Decimal, Value = TxtBCR.Text },
                                  new SqlParameter() { ParameterName = "@BCodeHelp", SqlDbType = SqlDbType.NVarChar, Value = TxtBCH.Text },
                                  new SqlParameter() { ParameterName = "@BCodeCategory", SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.SelectedValue });
                                  

                WebMsgBox.Show("Billing Code detail's Updated successfully.");
                ClearScr();
                    }                                    

          
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message.ToString());
            }
        }
        else
        {
            WebMsgBox.Show("Please enter mandatory field");
        }


    }
        else
        {


        }
    }
  
protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("BCodesAdd.aspx");
    }
    protected void ClearScr()
    {
        TxtBCode.Text = String.Empty;
        TxtBCD.Text = String.Empty;
        ddlMPD.SelectedIndex = 0;
        TxtBCR.Text = String.Empty;
        TxtBCH.Text = String.Empty;
        ddlCategory.SelectedIndex = 0;
        this.TxtBCode.Focus();



    }
    protected void LoadBillCodeDetails()
    {
        if (Session["BRSN"] != "") 
        {

            try
            {
                int BRSN = Convert.ToInt32(Session["BillRSN"]);

                DataSet dsBill = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsBill = proc.ExecuteSP("SP_FetchBillingCodesDtls",
                    new SqlParameter()
                    {
                     ParameterName = "@BRSN",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = BRSN});
               
                TxtBCode.Text = dsBill.Tables[0].Rows[0]["BCode"].ToString();
                TxtBCD.Text = dsBill.Tables[0].Rows[0]["BCodeDescription"].ToString();
                ddlMPD.SelectedValue = dsBill.Tables[0].Rows[0]["MaxPerDay"].ToString();
                TxtBCR.Text = dsBill.Tables[0].Rows[0]["BCodeRate"].ToString();
                TxtBCH.Text = dsBill.Tables[0].Rows[0]["BCodeHelp"].ToString();
                ddlCategory.SelectedValue = dsBill.Tables[0].Rows[0]["BCodeCategory"].ToString();
                




            }
            catch (Exception ex)
            {



            }



        }




    }

}