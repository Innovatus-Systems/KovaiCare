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

public partial class AttribLkUpAdd : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    DataSet dsGrid = new DataSet();
    DataSet dsGrid1 = new DataSet();

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        string ID = Request.QueryString["Value"];
        if (!IsPostBack)
        {

            LoadTitle();

            if(ID == "1")
            {
                //btnreturnfromlevelHSettings.Visible = false;
                btnExit.Visible = false;
            }

            lnkAddnew.Visible = true;
            lnkAddnew.Text = "+ Add New";
            lnkAddnew.ToolTip = "Click here to add a New Profile Code.";
            divAddNewItem.Visible = false;
            LoadGrid();
            Group();
        }

        //Priority();
        //AttbtsLkUpgrdView.DataSource = new String[] { };
        //AttbtsLkUpgrdView.DataBind();
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 63 });


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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();

        //ScriptManager.RegisterStartupScript(UPNLGrid, this.GetType(), "MyAction", "ConfirmMsg();", true);

        if (Confirm.Value == "true")
        {
            if (RACode.Text != String.Empty & ddlGroup.SelectedIndex != 0)
            {
                try
                {
                    sqlobj.ExecuteSQLNonQuery("SP_insertAttributesLkUpDtls",
                                       new SqlParameter() { ParameterName = "@RACode", SqlDbType = SqlDbType.NVarChar, Value = RACode.Text },
                                       new SqlParameter() { ParameterName = "@RADescription", SqlDbType = SqlDbType.NVarChar, Value = RADescription.Text },
                                       new SqlParameter() { ParameterName = "@RARemarks", SqlDbType = SqlDbType.NVarChar, Value = RARemarks.Text },
                                       new SqlParameter() { ParameterName = "@RAGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue.ToString() },
                                        new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlpriority.SelectedValue.ToString() });

                    WebMsgBox.Show("Additional particulars detail Saved.");
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
                WebMsgBox.Show("Please Select a Group/ Enter a Subgroup.");
            }
        }
        else
        {
            // WebMsgBox.Show("Test ");
        }

    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("Dashboard.aspx");
    }
    protected void ClearScr()
    {

        Group();
        RACode.Text = string.Empty;
        RADescription.Text = string.Empty;
        RARemarks.Text = string.Empty;
        //EntryBy.Text = string.Empty;
        //EntryDate.Text = string.Empty;
        //ModifiedBy.Text = string.Empty;
        //ModifiedDate.Text = string.Empty;
        this.RACode.Focus();
    }


    protected void LoadGrid()
    {

        SqlCommand cmd = new SqlCommand("SP_General", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        DataSet dsGrid = new DataSet();
        AttbtsLkUpgrdView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            AttbtsLkUpgrdView.DataSource = dsGrid.Tables[0];
            AttbtsLkUpgrdView.DataBind();

            AttbtsLkUpgrdView.AllowPaging = true;

        }
        else
        {
            AttbtsLkUpgrdView.DataSource = new String[] { };
            AttbtsLkUpgrdView.DataBind();
        }



    }
    protected void Group()
    {
        DataTable dt = new DataTable();
        dt.Clear();
        dt.Columns.Add("Code");
        dt.Columns.Add("Text");
        DataRow drow = dt.NewRow();
        drow["Code"] = "NOK";
        drow["Text"] = "NextOfKin";
        dt.Rows.Add(drow);

        drow = dt.NewRow();
        drow["Code"] = "Personal";
        drow["Text"] = "Personal";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "Health";
        drow["Text"] = "Health";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "1CE";
        drow["Text"] = "Incase of emergency";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "Special";
        drow["Text"] = "Special";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "Interest";
        drow["Text"] = "Interest";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "Identity";
        drow["Text"] = "Identity";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "Hwatch";
        drow["Text"] = "Health watch";
        dt.Rows.Add(drow);

        ddlGroup.DataSource = dt;
        ddlGroup.DataTextField = dt.Columns["Text"].ToString();
        ddlGroup.DataValueField = dt.Columns["Code"].ToString();
        ddlGroup.DataBind();
    }
    //protected void Priority()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Clear();
    //    dt.Columns.Add("Code");
    //    dt.Columns.Add("Text");
    //    DataRow drow = dt.NewRow();
    //    drow["Code"] = "Must";
    //    drow["Text"] = "Must";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "Optional";
    //    drow["Text"] = "Optional";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();

    //    ddlpriority.DataSource = dt;
    //    ddlpriority.DataTextField = dt.Columns["Text"].ToString();
    //    ddlpriority.DataValueField = dt.Columns["Code"].ToString();
    //    ddlpriority.DataBind();
    //}

    protected void Cmb_DataBound(object sender, EventArgs e)
    {
        var combo = (DropDownList)sender;
        combo.Items.Insert(0, "-- Select --");
    }

    //protected void LoadCustDet()
    //{
    //    try
    //    {
    //        SQLProcs sqlobj = new SQLProcs();
    //        DataSet dsProjDet = new DataSet();

    //        dsProjDet = sqlobj.SQLExecuteDataset("SP_FetchCustomer");

    //        RdGrd_CutDet.DataSource = dsProjDet.Tables[0];
    //        dtProjDet = dsProjDet.Tables[0];
    //        int ProjRCount = dsProjDet.Tables[0].Rows.Count;
    //        RdGrd_CutDet.DataBind();
    //        dsProjDet.Dispose();
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }
    protected void AttbtsLkUpgrdView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid();
    }

    protected void AttbtsLkUpgrdView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadGrid();
    }
    protected void AttbtsLkUpgrdView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadGrid();
    }
    protected void AttbtsLkUpgrdView_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadGrid();
    }


    protected void Lnkbtnedit_Click(object sender, EventArgs e)
    {
        string AdditionalsLkUpRSN;
        LinkButton LnkEditAdditionalsBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)LnkEditAdditionalsBtn.NamingContainer;
        Session["RBRSN"] = row.Cells[2].Text;
        AdditionalsLkUpRSN = Session["RBRSN"].ToString();
        Response.Redirect("AddnlsLkUpEdit.aspx");
    }
    //protected void btnreturnfromlevelHSettings_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("Admin.aspx");
    //}
   
    protected void lnkAddnew_Click(object sender, EventArgs e)
    {
        if (lnkAddnew.Text == "+ Add New")
                    {
                        divAddNewItem.Visible = true;
                        lnkAddnew.Text = "Close";
                        lnkAddnew.ToolTip = "Click here to Close";

                     }
          else
              if
                  (lnkAddnew.Text == "Close")

              {


                  lnkAddnew.Text = "+ Add New";
                  divAddNewItem.Visible = false;
                  lnkAddnew.ToolTip = "Click here to Add New Profile Code.";
                
              }
    }
    protected void RMSettings_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Admin")
        {
            Response.Redirect("Admin.aspx");
        }
        if (e.Item.Text == "Profile ++ LookUp")
        {
            Response.Redirect("AttribLkUpAdd.aspx");
        }
        if (e.Item.Text == "Item Master")
        {
            Response.Redirect("ItemMaster.aspx");
        }        
        if (e.Item.Text == "User Management")
        {
            Response.Redirect("~/UserManagement.aspx");
        }
        if (e.Item.Text == "Villa Master")
        {
            Response.Redirect("~/VillaMaster.aspx");
        }
        if (e.Item.Text == "Assets")
        {
            Response.Redirect("~/Assets.aspx");
        }
    }
    protected void AttbtsLkUpgrdView_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = AttbtsLkUpgrdView.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains"
            || menu.Items[i].Text == "GreaterThanOrEqualTo" || menu.Items[i].Text == "LessThanOrEqualTo")
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


