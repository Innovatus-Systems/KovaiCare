using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class BillingDays : System.Web.UI.Page
{
    //SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        
        DataSet dsDT = null;
        dsDT = sqlobj.ExecuteSP("GetServerDateTime");
        DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);

        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadTitle();
            LoadResident();
            LoadBillingMonth();
            LoadGrid();
            LoadMinMaxDT();
            

            //dtpFromDate.SelectedDate = now;
            //dtpTillDate.SelectedDate = now;

            //DateTime d1 = Convert.ToDateTime(dtpFromDate.SelectedDate);
            //DateTime d2 = Convert.ToDateTime(dtpTillDate.SelectedDate);                                
            
            //DateTime firstOfNextMonth = new DateTime(now.Year, now.Month, 1).AddMonths(1);
            //DateTime lastOfThisMonth = firstOfNextMonth.AddDays(-1);

            //dtpFromDate.MinDate = new DateTime(now.Year, now.Month, 1);
            //dtpFromDate.MaxDate = lastOfThisMonth;
            //dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.SelectedDate);
            //dtpTillDate.MaxDate = Convert.ToDateTime(dtpFromDate.MaxDate);

            //TimeSpan t = d2 - d1;
            //double NrOfDays = t.TotalDays;
            //txtNoDaysDinned.Text = NrOfDays.ToString();
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 92 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lbltitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lbltitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    public void LoadGrid()
    {
        try
        {
            DataSet dsUsers = sqlobj.ExecuteSP("SP_FetchBillingDays",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = 1 });


            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                grdBillingDays.DataSource = dsUsers;
                grdBillingDays.DataBind();
            }
            else
            {
                grdBillingDays.DataSource = string.Empty;
                grdBillingDays.DataBind();
            }

            dsUsers.Dispose();


        }
        catch (Exception ex)
        {
        }
    }


    protected void LoadResident()
    {
        try
        {

            DataSet dsResident = sqlobj.ExecuteSP("SP_General",
             new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 21 },
             new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = 1 });




            if (dsResident.Tables[0].Rows.Count > 0)
            {

                ddlResident.DataSource = dsResident.Tables[0];
                ddlResident.DataValueField = "rtrsn";
                ddlResident.DataTextField = "Name";
                ddlResident.DataBind();

                ddlResident.Items.Insert(0, new ListItem("--Select--", "0"));
            }



            dsResident.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    public void LoadBillingMonth()
    {
        try
        {
            DataSet dsBilling = sqlobj.ExecuteSP("SP_General",
            new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 22 },
            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = 1 });

            if (dsBilling.Tables[0].Rows.Count > 0)
            {
                ddlBillingMonth.DataSource = dsBilling.Tables[0];
                ddlBillingMonth.DataValueField = "CurrentMonth";
                ddlBillingMonth.DataTextField = "CurrentMonth";
                ddlBillingMonth.DataBind();

            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void LoadMinMaxDT()
    {
        try
        {
            DataSet dsDt = sqlobj.ExecuteSP("SP_FetchMinMaxDate",
            new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
            new SqlParameter() { ParameterName = "@BPName", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingMonth.SelectedValue.ToString() });

            if (dsDt.Tables[0].Rows.Count > 0)
            {

                RadDatePicker minValDate = new RadDatePicker();
                minValDate.MinDate = new System.DateTime();
                minValDate.SelectedDate = new System.DateTime();

                dtpFromDate.Clear();
                dtpTillDate.Clear();

               

                dtpFromDate.MinDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPFrom"].ToString());
                dtpFromDate.MaxDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPTill"].ToString());

                dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.MinDate);
                dtpTillDate.MaxDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPTill"].ToString());

                dtpFromDate.SelectedDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPFrom"].ToString());
                dtpTillDate.SelectedDate = Convert.ToDateTime(dsDt.Tables[0].Rows[0]["BPFrom"].ToString());

                DateTime d1 = Convert.ToDateTime(dtpFromDate.SelectedDate);
                DateTime d2 = Convert.ToDateTime(dtpTillDate.SelectedDate);   

                TimeSpan t = d2 - d1;
                double NrOfDays = t.TotalDays;
                txtNoDaysDinned.Text = NrOfDays.ToString();


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

            if (CnfResult.Value == "true")
            {

                if (ddlResident.SelectedIndex != 0 && txtNoDaysDinned.Text != "")
                {

                    sqlobj.ExecuteSP("SP_InsertBillingDays",
                        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = 1 },
                        new SqlParameter() { ParameterName = "@ResidentID", SqlDbType = SqlDbType.Decimal, Value = ddlResident.Text },
                        new SqlParameter() { ParameterName = "@FromDt", SqlDbType = SqlDbType.DateTime, Value = dtpFromDate.SelectedDate },
                        new SqlParameter() { ParameterName = "@TillDt", SqlDbType = SqlDbType.DateTime, Value = dtpTillDate.SelectedDate },
                        new SqlParameter() { ParameterName = "@BillingMonth", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingMonth.SelectedValue.ToString() },
                        new SqlParameter() { ParameterName = "@NoOfDays", SqlDbType = SqlDbType.Int, Value = txtNoDaysDinned.Text == "" ? null : txtNoDaysDinned.Text },
                        new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text });



                    LoadGrid();
                    ClearScr();
                    WebMsgBox.Show("Non-dining day detail saved successfully.'");
                }
                else
                {
                    WebMsgBox.Show("Please select/enter mandatory field(s) ");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }




    

    public void ClearScr()
    {
        ddlResident.SelectedIndex = 0;
        ddlBillingMonth.SelectedIndex = 0;
        txtNoDaysDinned.Text = string.Empty;
        txtRemarks.Text = string.Empty;

        //DataSet dsDT = null;
        //dsDT = sqlobj.ExecuteSP("GetServerDateTime");
        //DateTime now = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0]);
        //dtpFromDate.SelectedDate = now;
        //dtpTillDate.SelectedDate = now;

        LoadBillingMonth();
        ddlResident.Focus();
        LoadMinMaxDT();

        btnUpdate.Visible = false;
        btnSave.Visible = true;
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
        btnSave.Visible = true;
        btnUpdate.Visible = false;
    }

    protected void LnkEditItem_Click(object sender, EventArgs e)
    {
        try
        {


            btnUpdate.Visible = true;
            btnSave.Visible = false;
            LinkButton lnkEdititemBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkEdititemBtn.NamingContainer;
            string RSN;
            RSN = row.Cells[3].Text;

            //ViewState["MenuRSN"] = RSN.ToString();
            hdnRSN.Value = RSN.ToString();
            SqlProcsNew proc = new SqlProcsNew();
            //DataSet dsDT = null;


            DataSet dsDT = sqlobj.ExecuteSP("SP_FetchBillingDays",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = RSN });

            ddlResident.SelectedValue = dsDT.Tables[0].Rows[0]["RTRSN"].ToString();
            dtpFromDate.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0]["FromDt"].ToString());
            dtpTillDate.SelectedDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0]["TillDt"].ToString());
            ddlBillingMonth.SelectedValue = dsDT.Tables[0].Rows[0]["BillingMonth"].ToString();
            txtNoDaysDinned.Text = dsDT.Tables[0].Rows[0]["DNNoDays"].ToString();
            txtRemarks.Text = dsDT.Tables[0].Rows[0]["Remarks"].ToString();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
         

            if (CnfResult.Value == "true")
            {

                if (ddlResident.SelectedIndex != 0 && txtNoDaysDinned.Text != "")
                {

                    sqlobj.ExecuteSP("SP_InsertBillingDays",
                        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                        new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(hdnRSN.Value.ToString()) },
                        new SqlParameter() { ParameterName = "@ResidentID", SqlDbType = SqlDbType.Decimal, Value = ddlResident.Text },
                        new SqlParameter() { ParameterName = "@FromDt", SqlDbType = SqlDbType.DateTime, Value = dtpFromDate.SelectedDate },
                        new SqlParameter() { ParameterName = "@TillDt", SqlDbType = SqlDbType.DateTime, Value = dtpTillDate.SelectedDate },
                        new SqlParameter() { ParameterName = "@BillingMonth", SqlDbType = SqlDbType.NVarChar, Value = ddlBillingMonth.SelectedValue.ToString() },
                        new SqlParameter() { ParameterName = "@NoOfDays", SqlDbType = SqlDbType.Int, Value = txtNoDaysDinned.Text == "" ? null : txtNoDaysDinned.Text },
                        new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text });

                    LoadGrid();
                    ClearScr();
                    WebMsgBox.Show("Non-dining day detail updated successfully.'");
                }
                else
                {
                    WebMsgBox.Show("Please select/enter mandatory field(s) ");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);

        }
    }


    protected void grdBillingDays_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid();
    }
    //protected void grdBillingDays_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    //{
    //    LoadGrid();
    //}
    //protected void grdBillingDays_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    //{
    //    LoadGrid();
    //}
    //protected void grdBillingDays_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    //{
    //    LoadGrid();
    //}
    //protected void grdBillingDays_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    //{
    //    LoadGrid();
    //}

    protected void dtpFromDate_Changed(object sender, EventArgs e)
    {
        double NrOfDays;

        dtpTillDate.MinDate = Convert.ToDateTime(dtpFromDate.SelectedDate);

        DateTime d1 = Convert.ToDateTime(dtpFromDate.SelectedDate);
        DateTime d2 = Convert.ToDateTime(dtpTillDate.SelectedDate);      
        
        TimeSpan t = d2- d1;
        if (d1 == d2)
        {
            NrOfDays = t.TotalDays;
        }
        else
        {
            NrOfDays = t.TotalDays + 1;
        }
       
        txtNoDaysDinned.Text = NrOfDays.ToString();
    }

    protected void ddlBillingMonth_Changed(object sender, EventArgs e)
    {
        LoadMinMaxDT(); 
    }
    protected void grdBillingDays_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = grdBillingDays.FilterMenu;
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