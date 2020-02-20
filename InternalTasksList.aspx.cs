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

public partial class InternalTasksList : System.Web.UI.Page
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
                LoadTitle();
                LoadInternalTaskMaster();
                LoadStaff();


                dtpdate.SelectedDate = DateTime.Today;

                LoadInternalTaskList();

                rwEditInternalTaskList.VisibleOnPageLoad = true;
                rwEditInternalTaskList.Visible = false;

                btnSave.Visible = true;
                btnUpdate.Visible = false;

            }
        }
         
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 128 });


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

    protected void LoadInternalTaskMaster()
    {
        try
        {

            DataSet dsResident = new DataSet();

            dsResident = sqlobj.ExecuteSP("SP_InternalTasksMaster",
                 new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 }
                 );


            ddlTask.Items.Clear();

            if (dsResident.Tables[0].Rows.Count > 0)
            {
                ddlTask.DataSource = dsResident.Tables[0];
                ddlTask.DataValueField = "ITRSN";
                ddlTask.DataTextField = "ITaskTitle";
                ddlTask.DataBind();
            }

            ddlTask.Items.Insert(0, "--Select--");

           
            dsResident.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    private void LoadStaff()
    {
        try
        {
            DataSet dsUsers = sqlobj.ExecuteSP("SP_InserttblUserManagement",
             new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 }
            
             );

            ddlStaff.Items.Clear();
            ddlRstaff.Items.Clear();

            if (dsUsers.Tables[0].Rows.Count >0)
            {

                ddlStaff.DataSource = dsUsers;
                ddlStaff.DataTextField = "Name";
                ddlStaff.DataValueField = "RSN";
                ddlStaff.DataBind();

                ddlRstaff.DataSource = dsUsers;
                ddlRstaff.DataTextField = "Name";
                ddlRstaff.DataValueField = "RSN";
                ddlRstaff.DataBind();

                
            }

            ddlStaff.Items.Insert(0,"--Select--");
            ddlRstaff.Items.Insert(0, "All");

            dsUsers.Dispose();



        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadInternalTaskList()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_InternalTasksList",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 4 },
                 new SqlParameter() { ParameterName = "@OpenDate", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate },
                  new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = ddlRstaff.SelectedValue }
                );

            if (dsCategory.Tables[0].Rows.Count > 0)
            {

                rgInternalTaskList.DataSource = dsCategory;
                rgInternalTaskList.DataBind();

                lnkcount.Text = "Count:" + dsCategory.Tables[0].Rows.Count;

            }

            else
            {
                rgInternalTaskList.DataSource = string.Empty;
                rgInternalTaskList.DataBind();


                lnkcount.Text = "Count:0";
            }

            
            dsCategory.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void Clear()
    {

        ddlTask.SelectedIndex = 0;
        ddlStaff.SelectedIndex = 0;
       
        txtRemarks.Text = "";

        lblcjobtype.Text = "";

        LoadInternalTaskList();

        btnSave.Visible = true;
        btnUpdate.Visible = false;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {


                //sqlobj.ExecuteSQLNonQuery("SP_InternalTasksList",
                //      new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                //      new SqlParameter() { ParameterName = "@ITRSN", SqlDbType = SqlDbType.NVarChar, Value = ddlTask.SelectedValue },
                //      new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = ddlStaff.SelectedValue },
                //      new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                //      new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value =  "00" },
                //      new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                //      );


                sqlobj.ExecuteSQLNonQuery("SP_ITaskAssign",
                      new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                      new SqlParameter() { ParameterName = "@ITRSN", SqlDbType = SqlDbType.NVarChar, Value = ddlTask.SelectedValue },
                      new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = ddlStaff.SelectedValue },
                      new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                      new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }

                      );

                Clear();

                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Job responsibility details saved');", true);
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {

    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            Clear();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {

    }
    protected void rgInternalTaskList_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "UpdateRow")
            {

                hdnRSN.Value = e.CommandArgument.ToString();

                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;



                    LinkButton lnkRSN = (LinkButton)e.Item.FindControl("lbtnUpdate");

                    Session["RSN"] = hdnRSN.Value;
                    SqlProcsNew proc = new SqlProcsNew();



                    DataSet dsDT = sqlobj.ExecuteSP("SP_InternalTasksList",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 },
                       new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = Session["RSN"].ToString() },
                        new SqlParameter() { ParameterName = "@OpenDate", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate }
                       );


                    if (dsDT.Tables[0].Rows.Count > 0)
                    {


                        lblstaff.Text = dsDT.Tables[0].Rows[0]["AssignedTo"].ToString();

                        lblTask.Text = dsDT.Tables[0].Rows[0]["ITaskTitle"].ToString();

                        string startdate = dsDT.Tables[0].Rows[0]["Date"].ToString();

                        if (startdate != "")
                        {
                            lblDate.Text = dsDT.Tables[0].Rows[0]["Date"].ToString();
                        }


                        //txtRemarks.Text = dsDT.Tables[0].Rows[0]["Remarks"].ToString();
                        txtUpdateRemarks.Text= dsDT.Tables[0].Rows[0]["Remarks"].ToString();

                        ddlStatus.SelectedValue = dsDT.Tables[0].Rows[0]["Status"].ToString();

                        Session["AssignToValue"] = dsDT.Tables[0].Rows[0]["AValue"].ToString();

                        Session["ITRSN"] = dsDT.Tables[0].Rows[0]["ITRSN"].ToString();
                        

                        rwEditInternalTaskList.Visible = true;


                        btnUpdate.Visible = true;
                        btnSave.Visible = false;

                    }

                    dsDT.Dispose();
                }
            }
            else
            {
                LoadInternalTaskList();

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void rgInternalTaskList_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgInternalTaskList.FilterMenu;
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
    protected void BtnExcelExport_Click(object sender, EventArgs e)
    {
        DataSet dsStatement = sqlobj.ExecuteSP("SP_VMovement",
               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 }

               );

        DateTime sdate = DateTime.Now;


        if (dsStatement.Tables[0].Rows.Count > 0)
        {

            DataGrid dg = new DataGrid();

            dg.DataSource = dsStatement.Tables[0];
            dg.DataBind();




            // THE EXCEL FILE.
            string sFileName = "Vehicle Movement Register on " + sdate.ToString("dd/MM/yyyy") + ".xls";
            sFileName = sFileName.Replace("/", "");

            // SEND OUTPUT TO THE CLIENT MACHINE USING "RESPONSE OBJECT".
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment; filename=" + sFileName);
            Response.ContentType = "application/vnd.ms-excel";
            EnableViewState = false;

            System.IO.StringWriter objSW = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter objHTW = new System.Web.UI.HtmlTextWriter(objSW);

            dg.HeaderStyle.Font.Bold = true;     // SET EXCEL HEADERS AS BOLD.
            dg.RenderControl(objHTW);


            Response.Write("<table><tr><td>Vehicle Movement Register on</td><td>:" + sdate.ToString("dd/MM/yyyy") + "</td></tr></table>");


            // STYLE THE SHEET AND WRITE DATA TO IT.
            Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
            Response.Write(objSW.ToString());


            Response.End();
            dg = null;


        }
        else
        {
            WebMsgBox.Show("Guest Booking details on" + sdate.ToString("dd/MM/yyyy") + " does not exist");
        }
    }
    protected void cmbInternalTasksList_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {

    }
    protected void ddlRstaff_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadInternalTaskList();
    }
    protected void btnStatusUpdate_Click(object sender, EventArgs e)
    {

        try
        {
            if (CnfResult.Value == "true")
            {

                sqlobj.ExecuteSQLNonQuery("SP_InternalTasksList",
                      new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                      new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtUpdateRemarks.Text },
                      new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue },
                      new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                      new SqlParameter() { ParameterName = "@ITRSN", SqlDbType = SqlDbType.NVarChar, Value = Session["ITRSN"].ToString() },
                      new SqlParameter() { ParameterName = "@AssignedTo", SqlDbType = SqlDbType.NVarChar, Value = Session["AssignToValue"].ToString() },
                      new SqlParameter() { ParameterName = "@OpenDate", SqlDbType = SqlDbType.DateTime, Value = dtpdate.SelectedDate }

                      );
                //Clear();

                txtUpdateRemarks.Text = "";
                LoadInternalTaskList();               
                            
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Job Responsibility details updated.');", true);
                
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnStatusClear_Click(object sender, EventArgs e)
    {
        txtUpdateRemarks.Text = "";
    }
    protected void btnStatusClose_Click(object sender, EventArgs e)
    {
        rwEditInternalTaskList.Visible = false;
    }
    protected void dtpdate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            LoadInternalTaskList();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    //protected void ddlTask_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //         //DataSet dsResident = new DataSet();
    //        //dsResident = sqlobj.ExecuteSP("SP_InternalTasksList",
    //        //     new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 },
    //        //     new SqlParameter() { ParameterName = "@ITRSN", SqlDbType = SqlDbType.Int, Value = ddlTask.SelectedValue == "--Select--" ? null : ddlTask.SelectedValue }
    //        //     );
    //        //if (dsResident.Tables[0].Rows.Count > 0)
    //        //{
    //        //    lblcjobtype.Text = dsResident.Tables[0].Rows[0]["JobType"].ToString();
    //        //}
    //        //else
    //        //{
    //        //    lblcjobtype.Text = "";
    //        //}
    //        //dsResident.Dispose();
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }
        
    //}
}