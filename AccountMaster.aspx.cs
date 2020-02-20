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

public partial class AccountMaster : System.Web.UI.Page
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
            rwAccountGroup.VisibleOnPageLoad = true;
            rwAccountGroup.Visible = false;           
            if (!IsPostBack)
            {
                LoadTitle();
                LoadAccountGroup();
                LoadAccountMaster();
                loaddrpsubgroup();
                btnUpdate.Visible = false;
                btnSave.Visible = true;
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void loaddrpsubgroup()
    {
        DataSet dssubGroup = sqlobj.ExecuteSP("SP_AccountMaster",
               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 12 });
        if (dssubGroup.Tables[0].Rows.Count>0)
        {
            drpSubgroup.DataSource = dssubGroup.Tables[0];            
            drpSubgroup.DataTextField = "SubGroup";
            drpSubgroup.DataValueField = "SubGroup";
            drpSubgroup.DataBind();
        }
        drpSubgroup.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));
        
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 121 });


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

    private void Clear()
    {
        try
        {
            txtAccountCode.Text ="";
            txtAccountName.Text ="";
            ddlAccountGroup.SelectedIndex = 0;
            //ddlAccountType.SelectedIndex = 0;
            txtRemarks.Text ="";
            drpSubgroup.SelectedIndex = 0;
             LoadAccountMaster();

             ddlAccountGroup.Enabled = true;
             txtAccountName.Enabled = true;

             btnUpdate.Visible = false;
             btnSave.Visible = true;

             txtAccountCode.Enabled = true;
            
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadAccountGroup()
    {
        try
        {
             DataSet dsCategory = sqlobj.ExecuteSP("SP_AccountMaster",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 7 });

             ddlAccountGroup.Items.Clear();

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                rgAcccountGroup.DataSource = dsCategory;
                rgAcccountGroup.DataBind();

                ddlAccountGroup.DataSource = dsCategory;
                ddlAccountGroup.DataTextField = "AccountGroup";
                ddlAccountGroup.DataValueField = "AccountGroup";
                ddlAccountGroup.DataBind();
            }
            else
            {
                rgAcccountGroup.DataSource = string.Empty;
                rgAcccountGroup.DataBind();
            }

            dsCategory.Dispose();
            ddlAccountGroup.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));           

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
       
    }

    private void LoadAccountMaster()
    {
        try
        {
            DataSet dsCategory = sqlobj.ExecuteSP("SP_AccountMaster",
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 });      

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                gvAccountMaster.DataSource = dsCategory;
                gvAccountMaster.DataBind();
                //lblCount.Text = "Count :" + dsCategory.Tables[0].Rows.Count.ToString();
            }
            else
            {
                gvAccountMaster.DataSource = string.Empty;
                gvAccountMaster.DataBind();
            }
            dsCategory.Dispose();          

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
   

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                if (drpSubgroup.SelectedValue == "0" || ddlAccountGroup.SelectedValue == "0")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Account Group and Sub Group.');", true);
                    return;
                }

               string sAccountCode = "G1" + txtAccountCode.Text;

               DataSet dsCategory = sqlobj.ExecuteSP("SP_AccountMaster",
               new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = sAccountCode.ToString() },
               new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 5 });

                if (dsCategory.Tables[0].Rows.Count > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Account Code already exists, Please try different Account code');", true);
                }
                else
                {

                    sqlobj.ExecuteSQLNonQuery("SP_AccountMaster",
                           new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                           new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = sAccountCode.ToString() },
                           new SqlParameter() { ParameterName = "@AccountName", SqlDbType = SqlDbType.NVarChar, Value = txtAccountName.Text },
                           new SqlParameter() { ParameterName = "@AccountGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlAccountGroup.SelectedValue },
                           new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "G"},
                            new SqlParameter() { ParameterName = "@SubGrp", SqlDbType = SqlDbType.NVarChar, Value = drpSubgroup.SelectedValue },
                           new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                           new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                           );
                    Clear();
                    LoadAccountMaster();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Accounts master details saved');", true);
                }               
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {
                if (drpSubgroup.SelectedValue == "0" || ddlAccountGroup.SelectedValue == "0")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Account Group and Sub Group.');", true);
                    return;
                }
                sqlobj.ExecuteSQLNonQuery("SP_AccountMaster",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = txtAccountCode.Text },
                       new SqlParameter() { ParameterName = "@AccountName", SqlDbType = SqlDbType.NVarChar, Value = txtAccountName.Text },
                       new SqlParameter() { ParameterName = "@AccountGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlAccountGroup.SelectedValue },
                       new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "G" },
                       new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = txtRemarks.Text },
                       new SqlParameter(){ParameterName="@SubGrp",SqlDbType=SqlDbType.NVarChar,Value=drpSubgroup.SelectedValue},
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                       new SqlParameter() { ParameterName = "@AccountsMRSN", SqlDbType = SqlDbType.NVarChar, Value = Session["RSN"].ToString() }
                       );

                Clear();
                LnkSH.Text = "Add Account Code";
                LoadAccountMaster();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Account Master details updated');", true);
            }



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
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
        Response.Redirect("Dashboard.aspx", false);
    }
    protected void gvAccountMaster_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "UpdateRow")
            {
                LnkSH.Text = "Update Account.";
                hbtnRSN.Value = e.CommandArgument.ToString();
                if (e.Item is GridDataItem)
                {
                    GridDataItem ditem = (GridDataItem)e.Item;
                    LinkButton lnkRSN = (LinkButton)e.Item.FindControl("lnkRSN");
                    Session["RSN"] = lnkRSN.Text;
                    DataSet dsRes = sqlobj.ExecuteSP("SP_AccountMaster",
                        new SqlParameter() { ParameterName = "@AccountsMRSN", SqlDbType = SqlDbType.BigInt, Value = lnkRSN.Text },
                        new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.BigInt, Value = 4 }
                        );

                    if (dsRes.Tables[0].Rows.Count > 0)
                    {
                        txtAccountCode.Text  = dsRes.Tables[0].Rows[0]["AccountCode"].ToString();
                        txtAccountName.Text = dsRes.Tables[0].Rows[0]["AccountName"].ToString();
                        if (dsRes.Tables[0].Rows[0]["AccountGroup"].ToString() == "")
                        {
                            ddlAccountGroup.SelectedIndex = 0;
                        }
                        else
                        {
                            ddlAccountGroup.SelectedValue = dsRes.Tables[0].Rows[0]["AccountGroup"].ToString();
                        }                        
                        if (dsRes.Tables[0].Rows[0]["SubGroup1"].ToString()=="")
                        {
                            drpSubgroup.SelectedIndex = 0;
                        }
                        else
                        {
                            drpSubgroup.SelectedValue = dsRes.Tables[0].Rows[0]["SubGroup1"].ToString();
                        }                       
                        //ddlAccountType.SelectedValue = dsRes.Tables[0].Rows[0]["RAccountType"].ToString();
                        txtRemarks.Text = dsRes.Tables[0].Rows[0]["Remarks"].ToString();
                        txtAccountCode.Enabled = false;
                        //ddlAccountGroup.Enabled = false;                       
                        btnSave.Visible = false;
                        btnUpdate.Visible = true;                                              
                        txtAccountCode.Enabled = false;
                    }
                    dsRes.Dispose();
                }
            }
            else
            {
                LoadAccountMaster();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex .ToString()+ "');", true);
        }
    }
    protected void gvAccountMaster_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvAccountMaster.FilterMenu;
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
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsStatementRPT = new DataSet();
            DataSet dsCategory = sqlobj.ExecuteSP("SP_AccountMaster",
                  new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 11 });
            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                DataGrid dg = new DataGrid();
                dg.DataSource = dsCategory.Tables[0];
                dg.DataBind();
                string sFileName = "Chart Of Account.xls";
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


                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                //WebMsgBox.Show(" From" + dtpfordate.SelectedDate.Value + " To " + dtpuntildate.SelectedDate.Value + " statement does not exist");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }
    protected void btnGroupSave_Click(object sender, EventArgs e)
    {

        try
        {
            //if (CnfResult.Value == "true")
            //{


                sqlobj.ExecuteSQLNonQuery("SP_AccountMaster",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 6 },
                       new SqlParameter() { ParameterName = "@AccountGroup", SqlDbType = SqlDbType.NVarChar, Value = txtAccountGroup.Text },
                       new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                       );

                ClearGroup();

                rwAccountGroup.Visible = true;

                WebMsgBox.Show("New Account Group added.");

            //}
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void ClearGroup()
    {
        txtAccountGroup.Text = "";
        LoadAccountGroup();
    }

    protected void btnGroupClear_Click(object sender, EventArgs e)
    {
        ClearGroup();
    }
    protected void btnShowAccountGroup_Click(object sender, EventArgs e)
    {
        try
        {
            rwAccountGroup.Visible = true;
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnSubgroup_Click(object sender, EventArgs e)
    {

    }
}