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

public partial class AddnlsLkUpEdit : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {

        if(!IsPostBack)
        {

            loadCustDet();
            RACode.Enabled = false;
            //Group();
        }

    }
    public void loadCustDet()
    {
        if (Session["RBRSN"].ToString() != "")
        {

            try
            {
                int RSN = Convert.ToInt32(Session["RBRSN"]);

                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsSection = proc.ExecuteSP("[SP_AttributeLkUpEdit]", new SqlParameter()
                {
                    ParameterName = "@RBRSN",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = RSN
                });

                //DateTime Dtime= Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"]);
                


            

                RBRSN.Text = dsSection.Tables[0].Rows[0]["RBRSN"].ToString();
                
                ddlGroup.SelectedValue = dsSection.Tables[0].Rows[0]["RAGroup"].ToString();
           
                RACode.Text = dsSection.Tables[0].Rows[0]["RACode"].ToString();
                ddlpriority.SelectedValue = dsSection.Tables[0].Rows[0]["Priority"].ToString();
                RADescription.Text = dsSection.Tables[0].Rows[0]["RADescription"].ToString();
                //FromDate.SelectedDate = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"].ToString());
                RARemarks.Text = dsSection.Tables[0].Rows[0]["RARemarks"].ToString();
               



            }


            catch (Exception ex)
            {

                WebMsgBox.Show(ex.ToString());


            }

        }

        else
        {

            WebMsgBox.Show("There are some error in edit process.Try again!");

        }


    }
    protected void Cmb_DataBound(object sender, EventArgs e)
    {
        var combo = (DropDownList)sender;
        combo.Items.Insert(0, "-- Select --");
    }
    //protected void Group()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Clear();
    //    dt.Columns.Add("Code");
    //    dt.Columns.Add("Text");
    //    DataRow drow = dt.NewRow();
    //    drow["Code"] = "NOK";
    //    drow["Text"] = "NextOfKin";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "Personal";
    //    drow["Text"] = "Personal";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "Health";
    //    drow["Text"] = "Health";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "1CE";
    //    drow["Text"] = "Incase of emergency";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "Special";
    //    drow["Text"] = "Special";
    //    dt.Rows.Add(drow);
    //    ddlGroup.DataSource = dt;
    //    ddlGroup.DataTextField = dt.Columns["Text"].ToString();
    //    ddlGroup.DataValueField = dt.Columns["Code"].ToString();
    //    ddlGroup.DataBind();
    //}
    
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("AttribLkUpAdd.aspx");
    }
    protected void btnUpDate_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();


    if (CnfResult.Value == "true")
        {
            int RSN = Convert.ToInt32(Session["RBRSN"]);
            try
            {
                


                sqlobj.ExecuteSQLNonQuery("[SP_UpdateAttributesLkUpDtls]",
                     new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                      new SqlParameter() { ParameterName = "@RBRSN", SqlDbType = SqlDbType.Int, Value = RSN.ToString() },
                   new SqlParameter() { ParameterName = "@RAGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue },
                   new SqlParameter() {ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlpriority.SelectedValue},
                   new SqlParameter() { ParameterName = "@RACode", SqlDbType = SqlDbType.NVarChar, Value = RACode.Text },
                       new SqlParameter() { ParameterName = "@RADescription", SqlDbType = SqlDbType.NVarChar, Value = RADescription.Text },
                       new SqlParameter() { ParameterName = "@RARemarks", SqlDbType = SqlDbType.NVarChar, Value = RARemarks.Text }
                                   );


                WebMsgBox.Show("Additional Look Up detail's Updated successfully.");
                ClearScr();

            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message.ToString());
            }
        }
        else
        {
           
        }
    }
   
    protected void ClearScr()
    {
       
        //Group();
        
        RACode.Text = string.Empty;
        RADescription.Text = string.Empty;
        RARemarks.Text = string.Empty;
        RBRSN.Text = string.Empty;
        this.RACode.Focus();
    }
   
}