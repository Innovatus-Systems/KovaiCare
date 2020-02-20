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
using System.Security.Cryptography;
using System.Data.Common;
using System.Text;



public partial class AttributesAdd : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    public static DataTable DtNew = new DataTable();

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
        //scriptManager.RegisterPostBackControl(BtnnExcelExport);
        //pnladdnewtask.Visible = false;

        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }


        if (!IsPostBack)
        {
            lnkaddnewtask.Text = "+ Add More";
            Status();
            loadCustDetails();
            //RADate.DbSelectedDate = DateTime.Now;
            //FromDate.DbSelectedDate = DateTime.Now;
            //AttbtsgrdView.DataSource = new String[] { };
            //AttbtsgrdView.DataBind();
            //LoadResident();
            //LoadAttribLookup();
            LoadGrid();
            LoadGrid2();
            LoadGrid3();
            LoadGrid4();
            LoadGrid5();
            LoadGrid6();
            LoadGrid7();
            LoadGrid8();
            LoadDocUpload();
            BindGeneralInfrm();
            //LoadEEGrid();
            //Group();
            //Priority();
            DateTime MinimumDate = Convert.ToDateTime(("01 / 01 / 1800").ToString());
            //DateTime EndDay = Convert.ToDateTime(("01 / 01 / 2020").ToString());
            FromDate.MinDate = MinimumDate;

            //GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
            //CheckBox Checkall = (CheckBox)HeaderItem.FindControl("chkSelectAll");
            //Checkall.Checked = false;

            //LoadDependDet();
            ddlstatus.Enabled = false;

        }
        RadItemadd.VisibleOnPageLoad = true;
        RadItemadd.Visible = false;
        RWHelpmessageAttributeadd.VisibleOnPageLoad = true;
        RWHelpmessageAttributeadd.Visible = false;


        //RADate.DbSelectedDate = DateTime.Now;
        //FromDate.DbSelectedDate = DateTime.Now;
    }
    #region Load customer Details

    //protected void LoadDependDet()
    //{
    //    try
    //    {
    //        SqlProcsNew sqlobj = new SqlProcsNew();
    //        DataSet dsDependDet = new DataSet();

    //        dsDependDet = sqlobj.ExecuteSP("SP_FecthDependDet",
    //             new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Session["ResidentRSN"].ToString() )});
    //        ddlDependDet.DataSource = dsDependDet.Tables[0];
    //        ddlDependDet.DataValueField = "RTRSN";
    //        ddlDependDet.DataTextField = "RTName";
    //        ddlDependDet.DataBind();
    //        ddlDependDet.Dispose();
    //        ddlDependDet.Items.Insert(0, new ListItem("--Select--", "0"));


    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }
    //}

    //protected void ddlDependDet_SelectedIndexChanged(object sender, EventArgs e)
    //{
      
    //    Session["ResidentRSN"] = ddlDependDet.SelectedValue.ToString();
    //    Response.Redirect(Request.Url.AbsoluteUri);
    //}

    public void loadCustDetails()
    {
        if (Session["ResidentRSN"] != "")
        {

            try
            {
                int RSN = Convert.ToInt32(Session["ResidentRSN"]);

                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsSection = proc.ExecuteSP("SP_ResidentEdit", new SqlParameter()
                {
                    ParameterName = "@RTRSN",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = RSN
                });


                TxtRTRSN.Text = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();
                TxtRTName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                TxtRTVILLANO.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                ddlstatus.SelectedValue = dsSection.Tables[0].Rows[0]["SCode"].ToString();



            }


            catch (Exception ex)
            {

                WebMsgBox.Show("There are some error in Occupant loading process.Try again!");


            }

        }

        else
        {

            WebMsgBox.Show("There are some error in Occupant loading process.Try again!");

        }


    }
    #endregion

    #region Status dropdown
    protected void Status()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistStatus = new DataSet();

            ddlistStatus = sqlobj.ExecuteSP("SP_FetchStatusDropDown",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
            ddlstatus.DataSource = ddlistStatus.Tables[0];
            ddlstatus.DataValueField = "SCode";
            ddlstatus.DataTextField = "SDescription";
            ddlstatus.DataBind();
            ddlstatus.Dispose();
            ddlstatus.Items.Insert(0, new ListItem("--Select--", "0"));

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    #endregion

    #region Button Save Click Event
    protected void btnSave_Click1(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();

        if (TxtRTName.Text != String.Empty && ddlstatus.SelectedValue != "0" && TxtRTVILLANO.Text != String.Empty && ddlGroup.SelectedValue!="0")
        {
            try
            {
                if(ddlRACode.SelectedValue=="SDATE"|| ddlRACode.SelectedValue == "EDATE")
                {
                    if(RADate.SelectedDate==null||Convert.ToString(RADate.SelectedDate)=="")
                    {
                        RADate.Focus();
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Date');", true);
                        return;
                    }
                }
                sqlobj.ExecuteSQLNonQuery("SP_InsertAttributesDtls",
                                  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = TxtRTRSN.Text },
                                  new SqlParameter() { ParameterName = "@RTVIILANO", SqlDbType = SqlDbType.NVarChar, Value = TxtRTVILLANO.Text },
                                   new SqlParameter() { ParameterName = "@RTSTATUS", SqlDbType = SqlDbType.NVarChar, Value = ddlstatus.SelectedValue.ToString() },
                                   new SqlParameter() { ParameterName = "@RTName", SqlDbType = SqlDbType.NVarChar, Value = TxtRTName.Text },
                                   new SqlParameter() { ParameterName = "@RACode", SqlDbType = SqlDbType.NVarChar, Value = ddlRACode.SelectedValue.ToString() },
                                   new SqlParameter() { ParameterName = "@RAText", SqlDbType = SqlDbType.NVarChar, Value = RAText.Text },
                                   new SqlParameter() { ParameterName = "@RAValue", SqlDbType = SqlDbType.Int, Value = Convert.ToInt32(RAValue.Text.ToString() == "" ? null : RAValue.Text.ToString()) },
                                   new SqlParameter() { ParameterName = "@RADOB", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = FromDate.SelectedDate.ToString() == "" ? null : FromDate.SelectedDate.ToString() },
                                   new SqlParameter() { ParameterName = "@RADate", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = RADate.SelectedDate.ToString() == "" ? null : RADate.SelectedDate.ToString() },
                                   new SqlParameter() { ParameterName = "@RAContactNo", SqlDbType = SqlDbType.NVarChar, Value = RAContactNo.Text },
                                   new SqlParameter() { ParameterName = "@RAEmailId", SqlDbType = SqlDbType.NVarChar, Value = RAEmailId.Text },
                                   new SqlParameter() { ParameterName = "@RARemarks", SqlDbType = SqlDbType.NVarChar, Value = RARemarks.Text },
                                   new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = "Y" },
                                   new SqlParameter() { ParameterName = "@RAGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue.ToString() },
                                   new SqlParameter() { ParameterName = "@IsPopupflag", SqlDbType = SqlDbType.NVarChar, Value = "No" }
                                   );


                //DataSet dsChkAttr = new DataSet();
                //dsChkAttr = sqlobj.ExecuteSP("SP_CheckAttributes",
                //new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = TxtRTRSN.Text });
                //if (dsChkAttr.Tables[0].Rows.Count == 0)
                //{
                //    sqlobj.ExecuteSQLNonQuery("SP_InsertPriorityAttributes",
                //                              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = TxtRTRSN.Text });
                //}

                WebMsgBox.Show("Additional Detail Saved Successfully.");
                ClearScr();
                LoadGrid();
                LoadGrid2();
                LoadGrid3();
                LoadGrid4();
                LoadGrid5();
                LoadGrid6();
                LoadGrid7();
                LoadGrid8();

                
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", "alert("+ex.Message+");", true);
                //WebMsgBox.Show(ex.Message.ToString());
            }
        }
        else
        {
            WebMsgBox.Show("Please enter mandatory field");
        }
    }
    #endregion

   

    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }
    protected void rdgListView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        //LoadGrid();
    }
    protected void rdgListView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        //LoadGrid();
    }
    protected void rdgListView_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        //LoadGrid();
    }
    #region Grid load
    protected void LoadGrid()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("SP_AttributeGridLoad", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RSN;
                DataSet dsGrid = new DataSet();
                AttbtsgrdView.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {

                    AttbtsgrdView.DataSource = dsGrid.Tables[0];
                    AttbtsgrdView.DataBind();
                    GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = false;
                    AttbtsgrdView.AllowPaging = true;
                }
                else
                {
                    AttbtsgrdView.DataSource = new String[] { };
                    AttbtsgrdView.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }

    protected void LoadGrid2()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("SP_AttributeGridLoad", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 2;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RSN;
                DataSet dsGrid = new DataSet();
                rdgPersonal.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {

                    rdgPersonal.DataSource = dsGrid.Tables[0];
                    rdgPersonal.DataBind();
                    GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = false;
                    rdgPersonal.AllowPaging = true;
                }
                else
                {
                    rdgPersonal.DataSource = new String[] { };
                    rdgPersonal.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }

    protected void LoadGrid3()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("SP_AttributeGridLoad", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 3;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RSN;
                DataSet dsGrid = new DataSet();
                rdgHealth.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {

                    rdgHealth.DataSource = dsGrid.Tables[0];
                    rdgHealth.DataBind(); 
                     GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = false;
                    rdgHealth.AllowPaging = true;
                }
                else
                {
                    rdgHealth.DataSource = new String[] { };
                    rdgHealth.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }

    protected void LoadGrid4()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("SP_AttributeGridLoad", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 4;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RSN;
                DataSet dsGrid = new DataSet();
                rdgNOK.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {

                    rdgNOK.DataSource = dsGrid.Tables[0];
                    rdgNOK.DataBind();
                    GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = false;
                    rdgNOK.AllowPaging = true;
                }
                else
                {
                    rdgNOK.DataSource = new String[] { };
                    rdgNOK.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }

    protected void LoadGrid5()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("SP_AttributeGridLoad", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 5;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RSN;
                DataSet dsGrid = new DataSet();
                rdgSpecial.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {

                    rdgSpecial.DataSource = dsGrid.Tables[0];
                    rdgSpecial.DataBind();
                    GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = false;
                    rdgSpecial.AllowPaging = true;
                }
                else
                {
                    rdgSpecial.DataSource = new String[] { };
                    rdgSpecial.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }



    protected void LoadGrid6()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("SP_AttributeGridLoad", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 6;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RSN;
                DataSet dsGrid = new DataSet();
                rdgInterest.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {

                    rdgInterest.DataSource = dsGrid.Tables[0];
                    rdgInterest.DataBind();
                    GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = false;
                    rdgInterest.AllowPaging = true;
                }
                else
                {
                    rdgInterest.DataSource = new String[] { };
                    rdgInterest.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }


    protected void LoadGrid7()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("SP_AttributeGridLoad", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 7;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RSN;
                DataSet dsGrid = new DataSet();
                rdgIdentity.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {

                    rdgIdentity.DataSource = dsGrid.Tables[0];
                    rdgIdentity.DataBind();
                    GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = false;
                    rdgIdentity.AllowPaging = true;
                }
                else
                {
                    rdgIdentity.DataSource = new String[] { };
                    rdgIdentity.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }


    protected void LoadGrid8()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("SP_AttributeGridLoad", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 8;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RSN;
                DataSet dsGrid = new DataSet();
                //rdgHwatch.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {

                    rdgHwatch.DataSource = dsGrid.Tables[0];
                    rdgHwatch.DataBind();
                    GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = false;
                    rdgHwatch.AllowPaging = true;
                }
                else
                {
                    rdgHwatch.DataSource = new String[] { };
                    rdgHwatch.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }
    protected void LoadDocUpload()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RTRSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("PROC_CC_ResDocUpload", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 6;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RTRSN;
                DataSet dsGrid = new DataSet();
                //rdgHwatch.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {
                    rdDoc.DataSource= dsGrid.Tables[0];
                    rdDoc.DataBind();
                    GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = false;
                    rdgHwatch.AllowPaging = true;
                }
                else
                {
                    rdDoc.DataSource = new String[] { };
                    rdDoc.DataBind();
                }
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());

            }
        }
        else
        {

        }
    }


    #endregion
    #region Clear Screen
    protected void ClearScr()
    {

        //Group();
        //Priority();     
        RAText.Text = string.Empty;
        RAValue.Text = string.Empty;
        RAContactNo.Text = string.Empty;
        RAEmailId.Text = string.Empty;
        RARemarks.Text = string.Empty;
        ddlGroup.SelectedIndex = 0;
        ddlRACode.SelectedIndex = 0;
        //ddlpriority.SelectedIndex = 0;
        FromDate.SelectedDate = null;

    }
    #endregion
    #region LoadResident (ie) Load the resident details in dropdown
    //protected void LoadResident()
    //{
    //    try
    //    {
    //        ddlRTRSN.Items.Clear();
    //        SqlCommand cmd = new SqlCommand("SP_AttributesLookup", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 2;

    //        DataSet dsGrid = new DataSet();
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        da.Fill(dsGrid);


    //        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
    //        {
    //            ddlRTRSN.DataValueField = "RTRSN";
    //            ddlRTRSN.DataTextField = "RTName";
    //            ddlRTRSN.DataSource = dsGrid.Tables[0];
    //            ddlRTRSN.DataBind();
    //        }

    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}
    #endregion

    protected void Cmb_DataBound(object sender, EventArgs e)
    {
        var combo = (DropDownList)sender;
        combo.Items.Insert(0, "-- Select --");
    }
    #region Group dropdown selected index changed
    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if (ddlGroup.SelectedValue != "0" && ddlGroup.SelectedValue != "")
            {
                SqlCommand cmd = new SqlCommand("SP_GetLKUPOne", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@GroupCode", SqlDbType.NVarChar).Value = ddlGroup.SelectedValue;
                SqlDataAdapter ad = new SqlDataAdapter(cmd);
                DataSet dsGrid = new DataSet();
                ad.Fill(dsGrid);
                ddlRACode.DataSource = dsGrid;
                ddlRACode.DataValueField = "RACode";
                ddlRACode.DataTextField = "RACode";
                ddlRACode.DataBind();
            }

        }
        catch (Exception ex)
        {

        }


    }
    #endregion
    protected void Lnkbtnnedit_Click1(object sender, EventArgs e)
    {
        string AdditionalsRSN;
        LinkButton LnkEditAdditionalsBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)LnkEditAdditionalsBtn.NamingContainer;        
        Session["RARSN"] = row.Cells[3].Text;
        AdditionalsRSN = Session["RARSN"].ToString();
        Response.Redirect("AttributeEdit.aspx");
    }
    protected void BindGeneralInfrm()
    {
        int RSN = Convert.ToInt32(Session["ResidentRSN"]);
        try
        {
            DataSet dsProfile = new DataSet();
            DataSet dsKTSection = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            dsProfile = proc.ExecuteSP("[SP_FetchVSNDet]", new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = RSN });
            //string TotAmount2;

            if (dsProfile.Tables[0].Rows.Count > 0)
            {
                Session["VName"] = dsProfile.Tables[0].Rows[0]["Name"].ToString();
                lblheading.Text = " Profile++ of " + ": " + dsProfile.Tables[0].Rows[0]["Name"].ToString() + "-" + dsProfile.Tables[0].Rows[0]["RTVILLANO"].ToString();

            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }


    //protected void LoadEEGrid()
    //{
    //    try
    //    {
    //        int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());

    //        Int16 IMode;
    //        if (ddlAttribGroup.SelectedValue.ToString() == "0")
    //        {
    //            IMode = 1;
    //        }
    //        else
    //        {
    //            IMode = 2;
    //        }

    //        SqlProcsNew sqlobj = new SqlProcsNew();
    //        DataSet dsGroup = null;
    //        dsGroup = sqlobj.ExecuteSP("SP_AttributeDet",
    //            new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = IMode },
    //            new SqlParameter() { ParameterName = "@Group", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = ddlAttribGroup.SelectedValue.ToString() },
    //            new SqlParameter() { ParameterName = "@RName", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "A" });
    //        rdgAttribute.DataSource = dsGroup.Tables[0];
    //        rdgAttribute.DataBind();
    //        dsGroup.Dispose();
    //    }
    //    catch (Exception ex)
    //    {
    //        WebMsgBox.Show(ex.Message.ToString());
    //    }
    //}

    protected void ddlAttribGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        //LoadEEGrid();
    }

    //protected void btnExpProject_Click(object sender, EventArgs e)
    //{

    //    if ((rdgAttribute.Visible == true) && (rdgAttribute.Items.Count > 0))
    //    {
    //        SqlProcsNew proc = new SqlProcsNew();
    //        DataSet dsDT = null;

    //        dsDT = proc.ExecuteSP("GetServerDateTime");
    //        string CDate = Convert.ToDateTime(dsDT.Tables[0].Rows[0][0].ToString()).ToString("ddMMyyyyhhmmtt");
    //        string FileName = "Additional_Particulars_" + CDate;

    //        rdgAttribute.ExportSettings.ExportOnlyData = true;
    //        rdgAttribute.ExportSettings.FileName = FileName;
    //        rdgAttribute.ExportSettings.IgnorePaging = true;
    //        rdgAttribute.ExportSettings.OpenInNewWindow = true;
    //        rdgAttribute.MasterTableView.ExportToExcel();

    //    }
    //    else
    //    {
    //        WebMsgBox.Show("There are no records to Export");
    //    }
    //}
    protected void lnkaddnewtask_Click(object sender, EventArgs e)
    {
        if (lnkaddnewtask.Text == "+ Add More")
        {
            lnkaddnewtask.Text = "Close";
            lnkaddnewtask.ToolTip = "Click here to close.";
            pnladdnewtask.Visible = true;
            pnlbtns.Visible = true;
            lblHeading2.Visible = true;
        }
        else
            if (lnkaddnewtask.Text == "Close")
            {
                lnkaddnewtask.Text = "+ Add More";
                lnkaddnewtask.ToolTip = "Click to add more profile++ data for the resident.";
                pnladdnewtask.Visible = false;
                pnlbtns.Visible = false;
                lblHeading2.Visible = false;
            }
    }
    protected void btnhelptext_Click(object sender, EventArgs e)
    {
        RWHelpmessageAttributeadd.Visible = true;
        RWHelpmessageAttributeadd.CssClass = "availability";
    }

    protected void AttbtsgrdView_PreRender(object sender, EventArgs e)
    {
        if (AttbtsgrdView.Items.Count > 0)
        {
            //Format first row of grid
            //AttbtsgrdView.Items[0].BackColor = Color.Yellow;
        }
    }
    protected void imgbtnAdditemDetails_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "win",
    "<script language='javascript'> var iMyWidth;var iMyHeight;  window.open('AttribLkUpAdd.aspx?value=1','NewWin','status=no,height=550,width=1000 ,resizable=No,left=200,top=100,screenX=100,screenY=200,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no,   NewWin.focus()')</script>", false);




        //RadItemadd.Visible = true;
        //LoadGrid1();
        ////Group();
        //    string url = "AttribLkUpAdd.aspx";
        //    string s = "window.open('" + url + "', 'popup_window', 'width=300,height=100,left=100,top=100,resizable=yes');";

        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "MyAction", "s();", true);
        //ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
    }
    protected void ddlRACode_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlRACode.SelectedValue != "0" && ddlRACode.SelectedValue != "")
        {
            SqlCommand cmd = new SqlCommand("proc_getpriority", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
            cmd.Parameters.Add("@RACode", SqlDbType.NVarChar).Value = ddlRACode.SelectedValue;
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            DataSet dsGrid = new DataSet();
            ad.Fill(dsGrid);
            string sts = dsGrid.Tables[0].Rows[0]["Priority"].ToString();
            string stdtls = dsGrid.Tables[0].Rows[0]["prioritydet"].ToString();
            lbldescription.Text = dsGrid.Tables[0].Rows[0]["RAdescription"].ToString();
            //ddlpriority.SelectedValue = sts.ToString();
            
           

        }
    }


    protected void AttbtsLkUpgrdView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

    }
    protected void AttbtsLkUpgrdView_ItemCommand(object sender, GridCommandEventArgs e)
    {

    }
    protected void AttbtsLkUpgrdView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {

    }
    protected void AttbtsLkUpgrdView_SortCommand(object sender, GridSortCommandEventArgs e)
    {

    }
    protected void ClearScr1()
    {

        //Group();
        RACode.Text = string.Empty;
        RADescription.Text = string.Empty;
        RARemarks.Text = string.Empty;
        //EntryBy.Text = string.Empty;
        //EntryDate.Text = string.Empty;
        //ModifiedBy.Text = string.Empty;
        //ModifiedDate.Text = string.Empty;
        this.RACode.Focus();
    }


    protected void LoadGrid1()
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
    //    ddlItemGroup.DataSource = dt;
    //    ddlItemGroup.DataTextField = dt.Columns["Text"].ToString();
    //    ddlItemGroup.DataValueField = dt.Columns["Code"].ToString();
    //    ddlItemGroup.DataBind();
    //}
    protected void BNSAVE_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();

        //ScriptManager.RegisterStartupScript(UPNLGrid, this.GetType(), "MyAction", "ConfirmMsg();", true);

        ////if (Confirm.Value == "true")
        ////{
        ////    if (RACode.Text != String.Empty & ddlItemGroup.SelectedIndex != 0)
        ////    {
        ////        try
        ////        {
        ////            sqlobj.ExecuteSQLNonQuery("SP_insertAttributesLkUpDtls",
        ////                               new SqlParameter() { ParameterName = "@RACode", SqlDbType = SqlDbType.NVarChar, Value = RACode.Text },
        ////                               new SqlParameter() { ParameterName = "@RADescription", SqlDbType = SqlDbType.NVarChar, Value = RADescription.Text },
        ////                               new SqlParameter() { ParameterName = "@RARemarks", SqlDbType = SqlDbType.NVarChar, Value = RARemarks.Text },
        ////                                new SqlParameter() { ParameterName = "@RAGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlItemGroup.SelectedValue.ToString() },
        ////                                new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlpriority.SelectedValue.ToString() });

        ////            WebMsgBox.Show("Additional particular's Master Detail Saved.");
        ////            ClearScr1();
        ////            LoadGrid1();
        ////            PnlItemadd.Visible = true;
        ////            //LoadCustDet();
        ////        }
        ////        catch (Exception ex)
        ////        {
        ////            WebMsgBox.Show(ex.Message.ToString());
        ////        }
        ////    }
        ////    else
        ////    {
        ////        WebMsgBox.Show("Please select Group / Enter a Subgroup. ");
        ////    }
        ////}
        ////else
        ////{
        ////    // WebMsgBox.Show("Test ");
        ////}
    }
    protected void BNCLEAR_Click(object sender, EventArgs e)
    {
        ClearScr1();
    }
    protected void BNEXIT_Click(object sender, EventArgs e)
    {
        RadItemadd.Visible = false;
    }
    protected void Lnkbtnedit_Click(object sender, EventArgs e)
    {

    }
    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
        CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
        if (chkSelectAll.Checked)
        {
            LoadGridCheckfalse();
            //chkSelectAll.Checked = true;
        }
        else
        {
            LoadGrid();
            LoadGrid2();
            LoadGrid3();
            LoadGrid4();
            LoadGrid5();
            //chkSelectAll.Checked = false;
        }
    }


    #region Grid load for Check box check false
    protected void LoadGridCheckfalse()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
            try
            {

                int RSN = Convert.ToInt32(Session["ResidentRSN"].ToString());
                SqlCommand cmd = new SqlCommand("SP_AttributeGridLoad1", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
                cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = RSN;
                DataSet dsGrid = new DataSet();
                AttbtsgrdView.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dsGrid);
                if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
                {

                    AttbtsgrdView.DataSource = dsGrid.Tables[0];
                    AttbtsgrdView.DataBind();
                    GridHeaderItem HeaderItem = (GridHeaderItem)AttbtsgrdView.MasterTableView.GetItems(GridItemType.Header)[0];
                    CheckBox chkSelectAll = (CheckBox)HeaderItem.FindControl("chkSelectAll");
                    chkSelectAll.Checked = true;
                    AttbtsgrdView.AllowPaging = true;

                }
                else
                {
                    AttbtsgrdView.DataSource = new String[] { };
                    AttbtsgrdView.DataBind();
                }
            }
            catch
            {


            }
        }
        else
        {

        }
    }

    #endregion
    protected void AttbtsgrdView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadGrid();
        LoadGrid2();
        LoadGrid3();
        LoadGrid4();
        LoadGrid5();
    }
    protected void AttbtsgrdView_PreRender1(object sender, EventArgs e)
    {
        //LoadGrid();

        if (AttbtsgrdView.Items.Count > 0)
        {
            //Format first row of grid
            //AttbtsgrdView.Items[0].BackColor = Color.Yellow;
        }
    }
    protected void AttbtsgrdView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadGrid();
        LoadGrid2();
        LoadGrid3();
        LoadGrid4();
        LoadGrid5();
        LoadGrid6();
        LoadGrid7();
        LoadGrid8();
    }
    protected void AttbtsgrdView_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadGrid();
        LoadGrid2();
        LoadGrid3();
        LoadGrid4();
        LoadGrid5();
        LoadGrid6();
        LoadGrid7();
        LoadGrid8();
    }    



    protected void btnreturnfromlevelAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect(Convert.ToString(Session["PrevPageName"]));
    }
    protected void Lnkbtndelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (CnfResult.Value == "true")
            {

                LinkButton ltndelete = (LinkButton)sender;

                string strrarsn = ltndelete.CommandName.ToString();

                sqlobj.ExecuteNonQuery("SP_DeleteAttributes",
                   new SqlParameter { ParameterName = "@RARSN", SqlDbType = SqlDbType.BigInt, Value = strrarsn.ToString() });

                LoadGrid();
                LoadGrid2();
                LoadGrid3();
                LoadGrid4();
                LoadGrid5();
                LoadGrid6();
                LoadGrid7();
                LoadGrid8();
                LoadDocUpload();
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Successfully deleted');", true);
                //WebMsgBox.Show(" ");
            }


        }
        catch(Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('"+ex.Message.ToString()+"');", true);
        }
    }

    protected void rdgPersonal_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid2();
    }

    protected void rdgHealth_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid3();
    }

    protected void rdgNOK_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid4();
    }
    protected void rdgSpecial_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid5();
    }
    protected void rdgInterest_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid6();
    }
    
    protected void rdgIdentity_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid7();
    }
    protected void rdgHwatch_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid8();
    }
    protected void lnkProfile_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ResidentAdd.aspx");
    }

    protected void rdDoc_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadDocUpload();
    }

    protected void lnkAddDoc_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/UploadDoc.aspx");
    }

    protected void LnkDocEdit_Click(object sender, EventArgs e)
    {
        string AdditionalsRSN;
        LinkButton LnkEditAdditionalsBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)LnkEditAdditionalsBtn.NamingContainer;
        AdditionalsRSN = row.Cells[2].Text;
        //AdditionalsRSN = Session["RSN"].ToString();
        Response.Redirect("~/UploadDoc.aspx?MD=Ed&N="+ AdditionalsRSN);
    }

    protected void LnkDocDelete_Click(object sender, EventArgs e)
    {
        string URSN;
        LinkButton LnkEditAdditionalsBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)LnkEditAdditionalsBtn.NamingContainer;
        URSN = row.Cells[2].Text;
        string URTRSN = Session["ResidentRSN"].ToString();
        DataSet dsGrid = sqlobj.ExecuteSP("PROC_CC_ResDocUpload",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = URTRSN },
                     new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = URSN }
                 );
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            LoadDocUpload();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('"+ dsGrid.Tables[0].Rows[0]["Msg"].ToString()+"');", true);
        }
    }
}