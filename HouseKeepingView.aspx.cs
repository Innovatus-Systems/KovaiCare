using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Telerik.Web.UI; 

public partial class HouseKeepingView : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }         



            if (!IsPostBack)
            {

                if (Request.QueryString["Val"].ToString() == "1")
                {                   
                    PnlSR.Visible = false;
                    PnlHK.Visible = true;

                    //LoadTitle();
                    LoadViewIndTaskList();
                    LoadViewTaskList();

                    dvhk.Visible = false;
                    dvsr.Visible = true;          
         
                
                }

                if (Request.QueryString["Val"].ToString() == "2")
                {                   
                    PnlHK.Visible = false;
                    PnlSR.Visible = true;

                    //LoadTitle2();
                    LoadViewIndService();
                    LoadViewService();

                    dvhk.Visible = true;
                    dvsr.Visible = false;

                }

               // grdHouseKeeping.Visible = false;
               
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 40 });


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

    private void LoadTitle2()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 36 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                lnktitle2.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                lnktitle2.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadViewIndTaskList()
    {
        try
        {
            DataSet dsWorkSchedule = sqlobj.ExecuteSP("SP_ViewHouseKeepingService",
                       new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Session["HouseKeepingRSN"].ToString())});


            if (dsWorkSchedule.Tables[0].Rows.Count > 0)
            {
                grdIndHouseKeeping.DataSource = dsWorkSchedule;
                grdIndHouseKeeping.DataBind();
            }
            else
            {
                grdIndHouseKeeping.DataSource = string.Empty;
                grdIndHouseKeeping.DataBind();
            }

            dsWorkSchedule.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadViewTaskList()
    {
        try
        {
            DataSet dsWorkSchedule = sqlobj.ExecuteSP("SP_ViewHouseKeepingService",
                       new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value =2 },
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Session["HouseKeepingRSN"].ToString()) });


            if (dsWorkSchedule.Tables[0].Rows.Count > 0)
            {
                grdHouseKeeping.DataSource = dsWorkSchedule;
                grdHouseKeeping.DataBind();
            }
            else
            {
                grdHouseKeeping.DataSource = string.Empty;
                grdHouseKeeping.DataBind();
            }

            dsWorkSchedule.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
  

    private void LoadViewIndService ()
    {
        try
        {
            DataSet dsWorkSchedule = sqlobj.ExecuteSP("SP_ViewHouseKeepingService",
                       new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Session["ServiceRSN"].ToString()) });


            if (dsWorkSchedule.Tables[0].Rows.Count > 0)
            {
                grdIndTaskList.DataSource = dsWorkSchedule;
                grdIndTaskList.DataBind();
            }
            else
            {
                grdIndTaskList.DataSource = string.Empty;
                grdIndTaskList.DataBind();
            }

            dsWorkSchedule.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadViewService()
    {
        try
        {
            DataSet dsWorkSchedule = sqlobj.ExecuteSP("SP_ViewHouseKeepingService",
                       new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 4 },
                       new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Session["ServiceRSN"].ToString()) });


            if (dsWorkSchedule.Tables[0].Rows.Count > 0)
            {
                grdTaskList.DataSource = dsWorkSchedule;
                grdTaskList.DataBind();
            }
            else
            {
                grdTaskList.DataSource = string.Empty;
                grdTaskList.DataBind();
            }

            dsWorkSchedule.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnAdd_Click(object sender,EventArgs e)
    {
        Response.Redirect("WorkSchedule.aspx");
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("DashBoard.aspx");
    }

    protected void btnAdd2_Click(object sender, EventArgs e)
    {
        Response.Redirect("TaskList.aspx?Value1=3&Value2=-");
    }

    protected void btnReturn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("DashBoard.aspx");
    }

    protected void grdIndHouseKeeping_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadViewIndTaskList();
    }
    protected void grdHouseKeeping_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadViewTaskList();
    }
    protected void grdIndTaskList_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadViewIndService();
    }
    protected void grdTaskList_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadViewService();
    }

    protected void lnkshowall_Click(object sender, EventArgs e)
    {
        if (dvhk.Visible == true)
        {
            dvhk.Visible = false;
        }
        else
        {
            dvhk.Visible = true;
        }
    }
    protected void lnksrshowall_Click(object sender, EventArgs e)
    {
        if (dvsr.Visible == true)
        {
            dvsr.Visible = false;
        }
        else
        {
            dvsr.Visible = true;
        }
    }
}