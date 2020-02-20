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

public partial class BCodesAdd : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        RWBillingCodeView.VisibleOnPageLoad = true;
        RWBillingCodeView.Visible = false;
        //LoadBillingDtls();
     
        if (!IsPostBack)
        {
            LoadGrid();

        }
    }
   
    protected void btnnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void btnnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }

    protected void ClearScr()
    {
        TxtBCode.Text = String.Empty;
        TxtBCD.Text = String.Empty;
        ddlCategory.SelectedIndex = 0;
        ddlMPD.SelectedIndex = 0;
        //TxtMPD.Text = String.Empty;
        TxtBCR.Text = String.Empty;
        TxtBCH.Text = String.Empty;
        //TxtBCC.Text = String.Empty;
        this.TxtBCode.Focus();



    }
    protected void btnnSave_Click1(object sender, EventArgs e)
    {
        if (HResult.Value == "true")
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            if (TxtBCode.Text != String.Empty && TxtBCD.Text != String.Empty)
            {

                try
                {
                    sqlobj.ExecuteSP("SP_InsertBillingCodeDtls",

                                       new SqlParameter() { ParameterName = "@BCode", SqlDbType = SqlDbType.NVarChar, Value = TxtBCode.Text },
                                       new SqlParameter() { ParameterName = "@BDescription", SqlDbType = SqlDbType.NVarChar, Value = TxtBCD.Text },
                                       new SqlParameter() { ParameterName = "@MaxPerday", SqlDbType = SqlDbType.Int, Value = ddlMPD.SelectedValue },
                                        new SqlParameter() { ParameterName = "@BcodeRate", SqlDbType = SqlDbType.Decimal, Value = TxtBCR.Text },
                                       new SqlParameter() { ParameterName = "@BCodeHelp", SqlDbType = SqlDbType.NVarChar, Value = TxtBCH.Text },
                                       new SqlParameter() { ParameterName = "@BCodeCategory", SqlDbType = SqlDbType.NVarChar, Value = ddlCategory.SelectedValue });


                    WebMsgBox.Show("Code Detail Saved Successfully.");
                    ClearScr();
                    LoadGrid();
                    //LoadCustDet();
                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());
                }
            }
            else
            {
                WebMsgBox.Show("Please enter Mandatory field(s) ");
            }
        }
        else 
        { 
        }
    }
    protected void Lnkbtnnview_Click(object sender, EventArgs e)
    {
        String RSN;
        LinkButton LnkEdit = (LinkButton)sender;
        GridDataItem row = (GridDataItem)LnkEdit.NamingContainer;
        Session["BillRSN"] = row.Cells[4].Text;
        RSN = Session["BillRSN"].ToString();
        RWBillingCodeView.Visible = true;
        LoadBillingDtls();
    }
    protected void Lnkbtnnedit_Click(object sender, EventArgs e)
    {
        String BRSN;
        LinkButton LnkEdit = (LinkButton)sender;
        GridDataItem row = (GridDataItem)LnkEdit.NamingContainer;
        Session["BillRSN"] = row.Cells[4].Text;
        BRSN = Session["BillRSN"].ToString();
        Response.Redirect("BCodesEdit.aspx");


    }


        protected void BillingCodeListView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
                           
        {
            LoadGrid();
        }
       protected void BillingCodeListView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
       {

           LoadGrid();
       }
     protected void BillingCodeListView_SortCommand(object sender, GridSortCommandEventArgs e)
     {
         LoadGrid();

     }

     #region Grid load
     protected void LoadGrid()
     {
       
             try
             {

                 SqlCommand cmd = new SqlCommand("SP_BillingGridLoad", con);
                 cmd.CommandType = CommandType.StoredProcedure;
                 cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;               
                 DataSet dsGrid = new DataSet();
                 BillingCodeListView.DataBind();

                 SqlDataAdapter da = new SqlDataAdapter(cmd);

                 da.Fill(dsGrid);
                 if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                 {

                     BillingCodeListView.DataSource = dsGrid.Tables[0];
                     BillingCodeListView.DataBind();

                     BillingCodeListView.AllowPaging = true;

                 }
                 else
                 {
                     BillingCodeListView.DataSource = new String[] { };
                     BillingCodeListView.DataBind();
                 }
             }
             catch
             {


             }
         
        
     }

     #endregion


     protected void LoadBillingDtls()
     {
       

         DataSet dsSection = new DataSet();
         SqlProcsNew proc = new SqlProcsNew();

         int RSN = Convert.ToInt32(Session["BillRSN"]);
         dsSection = proc.ExecuteSP("SP_FetchBillingCodesDtls", new SqlParameter()
         {
             ParameterName = "@BRSN",
             Direction = ParameterDirection.Input,
             SqlDbType = SqlDbType.Int,
             Value = RSN 
         });



         LblBCode1.Text = dsSection.Tables[0].Rows[0]["BCode"].ToString();
         LblDESC1.Text = dsSection.Tables[0].Rows[0]["BCodeDescription"].ToString();
         LblMPD1.Text = dsSection.Tables[0].Rows[0]["MaxPerDay"].ToString();
         LblBCR1.Text = dsSection.Tables[0].Rows[0]["BCodeRate"].ToString();
         LblBCH1.Text = dsSection.Tables[0].Rows[0]["BCodeHelp"].ToString();
         LblBCC1.Text = dsSection.Tables[0].Rows[0]["BCodeCategory"].ToString();
         




     }

     protected void BillingCodeListView_ItemCommand(object sender, GridCommandEventArgs e)
     {
         LoadGrid();
     }
}