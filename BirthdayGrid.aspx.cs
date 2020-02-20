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


public partial class BirthdayGrid : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlProcsNew proc = new SqlProcsNew();
        DataSet dsDT = null;


        rwSpecialReport.VisibleOnPageLoad = true;
        rwSpecialReport.Visible = false;


        if(!IsPostBack)
        {

            LoadTitle();


            dsDT = proc.ExecuteSP("GetServerDateTime");


            DateTime date = DateTime.Now;

            DateTime firstOfNextMonth = new DateTime(date.Year, date.Month, 1).AddMonths(1);
            DateTime lastOfThisMonth = firstOfNextMonth.AddDays(-1);


            FromBday.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
            TillBday.SelectedDate = Convert.ToDateTime(lastOfThisMonth);
            
            
            if(TillBday.SelectedDate >= FromBday.SelectedDate)
            {
                //LoadBirthdayGrid7days(); 
            }
            else
            {
               
            }

       

          
        }

        LoadBirthdayGrid7days();
        RwBirthday.VisibleOnPageLoad = true;
        RwBirthday.Visible = false;
       
       
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 34 });


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
  
    protected void LoadBirthdayGrid7days()
    {       

        //if(TillBday.SelectedDate >= FromBday.SelectedDate)
        //{ 
        SqlCommand Cmd = new SqlCommand("[SP_FetchBirthdays]", con);
        Cmd.CommandType = CommandType.StoredProcedure;
        Cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        Cmd.Parameters.Add("@startdate", SqlDbType.DateTime).Value = FromBday.SelectedDate;
        Cmd.Parameters.Add("@enddate", SqlDbType.DateTime).Value = TillBday.SelectedDate;
        DataSet dsGrid = new DataSet();
        BirthdaygrdView.DataBind();
        SqlDataAdapter da = new SqlDataAdapter(Cmd);
        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            BirthdaygrdView.DataSource = dsGrid.Tables[0];
            BirthdaygrdView.DataBind();
            BirthdaygrdView.AllowPaging = true;
            //btnSendMail.Visible = true;
        }

        else
        {
            BirthdaygrdView.DataSource = new String[] { };
            BirthdaygrdView.DataBind();
            //btnSendMail.Visible = false;
        }
        //}
        //else
        //{
           
           
        //}

    }
   

    protected void BirthListView_PageIndexChanged(object sender, EventArgs e)
    {
        LoadBirthdayGrid7days();
    }
    protected void BirthListView_PageSizeChanged(object sender, EventArgs e)
    {
        LoadBirthdayGrid7days();
    }

    protected void BirthListView_SortCommand(object sender, EventArgs e)
    {
        LoadBirthdayGrid7days();
    }
    protected void lbtnContactMail_Click(object sender, EventArgs e)
    {
        try
        {

            string CustomerName;
            LinkButton Lnkmail = (LinkButton)sender;
            GridDataItem row = (GridDataItem)Lnkmail.NamingContainer;
            CustomerName = row.Cells[5].Text;
            String RTRSN = row.Cells[2].Text;
            HDRTRSN.Value = RTRSN;
            LblTitle.Text = "Greet          " + CustomerName+"            here";
            LblTitle.Visible = true;
            txtsub.Enabled = true;
            txtBody.Enabled = true;

            //txttext.Text = "";
            //txtvalue.Text = "0";
            //txtdescription.Text = "";

            //btnMIUpdate.Visible = false;
            btnMISave.Visible = true;
            RwBirthday.Visible = true;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
  //try
  //{
  //    if(CnfResult.Value == "true")
  //    {
  //        LinkButton lnkOpenProjBtn = (LinkButton)sender;
  //        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
  //        SqlProcsNew sqlobj = new SqlProcsNew();
  //        String RTRSN = row.Cells[2].Text;
  //        sqlobj.ExecuteSQLNonQuery("SP_CovaiSoftMail",
  //                                           new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
  //                                           new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RTRSN }
  //                                           );
  //        WebMsgBox.Show("Greetings sent successfully.");
  //    }
  //    else
  //    {

  //    }
  //    }
      
      
  //catch
  //{

  //    WebMsgBox.Show("There is a problem to send greetings.Try again!");
  //}

    }

    //protected void Btnshow_Click(object sender, EventArgs e)
    //{
    //    LoadBirthdayGrid7days();
    //}




    protected void btnMISave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
          
                SqlProcsNew sqlobj = new SqlProcsNew();               
                sqlobj.ExecuteSQLNonQuery("SP_CovaiSoftMail",
                                                   new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                                                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(HDRTRSN.Value) },
                                                   new SqlParameter() { ParameterName = "@Subject", SqlDbType = SqlDbType.NVarChar, Value = txtsub.Text},
                                                   new SqlParameter() { ParameterName = "@Message", SqlDbType = SqlDbType.NVarChar, Value = txtBody.Text}
                                                   );
                WebMsgBox.Show("Greetings sent successfully.");
                txtBody.Text = string.Empty;
                txtsub.Text = string.Empty;
            }
            else
            {

            }
        }


        catch
        {

            WebMsgBox.Show("There is a problem to send greetings.Try again!");
        }
    }
    //protected void btnMIUpdate_Click(object sender, EventArgs e)
    //{

    //}
    protected void btnMIClear_Click(object sender, EventArgs e)
    {
        txtBody.Text = string.Empty;
        txtsub.Text = string.Empty;
    }
    protected void btnMIExit_Click(object sender, EventArgs e)
    {
        RwBirthday.Visible = false;
    }
    protected void btnreturnfromlevelX_Click(object sender, EventArgs e)
    {
        //Response.Redirect("ExitEntry.aspx");
        Response.Redirect("CheckINOUT.aspx");
    }

    protected void lbtnName_Click(object sender, EventArgs e)
    {

        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = lnkOpenProjBtn.CommandName.ToString();
        CustomerRSN = Session["ResidentRSN"].ToString();

        DataSet dsSpecialReport = sqlobj.ExecuteSP("SP_ResidentSpecialReport",
                new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = CustomerRSN.ToString() });

        if (dsSpecialReport.Tables[0].Rows.Count > 0)
        {
            rgSpecialReport.DataSource = dsSpecialReport;
            rgSpecialReport.DataBind();

            rwSpecialReport.Visible = true;
        }
        else
        {
            rgSpecialReport.DataSource = string.Empty;
            rwSpecialReport.DataBind();


            rwSpecialReport.Visible = false;
        }

        dsSpecialReport.Dispose();


        //Response.Redirect("TransactionLevel.aspx");
    }


    protected void BirthdaygrdView_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = BirthdaygrdView.FilterMenu;
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











  




    
