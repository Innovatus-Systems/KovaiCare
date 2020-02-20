using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.IO;
using System.Data.OleDb;
using System.Text;
using System.Reflection;

public partial class VillaMaster : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    SqlProcsNew sqlobj = new SqlProcsNew();

    static string strPstatus = "";

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }


        rwImportExcel.VisibleOnPageLoad = true;
        rwImportExcel.Visible = false;

        rwHelpmsg.VisibleOnPageLoad = true;
        rwHelpmsg.Visible = false;

        rwOccupancyHistory.VisibleOnPageLoad = true;
        rwOccupancyHistory.Visible = false;

        if (!IsPostBack)
        {
           
            LoadTitle();
            LoadUserGrid();
            LoadVillaStatus();
            CHECKDOORNOCOUNT();
            btnUpdate.Visible = false;
            // btnDelete.Visible = false;
            lblError.Visible = false;
            txtcstatus.Visible = false;
            //btnBlocked.Visible = false;
            //btnLocked.Visible = false;
            //btnVacant.Visible = false;
            //btnOccupied.Visible = false;
            lblnewstatus.Visible = false;
            txtNewStatus.Visible = false;
        }
        rwDetailsPopup.VisibleOnPageLoad = true;
        rwDetailsPopup.Visible = false;

        rwHelp.VisibleOnPageLoad = true;
        rwHelp.Visible = false;
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 65 });


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
    private void CHECKDOORNOCOUNT()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_CHECKDOORNOCOUNT");


            if (dsTitle.Tables[0].Rows.Count > 0 && dsTitle.Tables[1].Rows.Count >0)
            {
               if(Convert.ToDecimal(dsTitle.Tables[0].Rows[0]["DOORNO"].ToString()) <= Convert.ToDecimal(dsTitle.Tables[1].Rows[0]["COUNTDOORNO"].ToString()))
                {
                    btnSave.Visible = false;
                }
            }

            dsTitle.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadVillaStatus()
    {
        try
        {
            //SqlProcsNew sqlobj = new SqlProcsNew();
            //DataSet dsFetchSE = new DataSet();

            //dsFetchSE = sqlobj.ExecuteSP("sp_fetchvilastatuslkup");
            //ddlStatus.DataSource = dsFetchSE.Tables[0];
            //ddlStatus.DataValueField = "Code";
            //ddlStatus.DataTextField = "Value";
            //ddlStatus.DataBind();

            //ddlStatus.Items.Insert(0, new ListItem("--Select--", "0"));
            //ddlStatus.SelectedIndex = 4;


            DataSet dsFetchSE = new DataSet();
            SqlProcsNew sqlobj = new SqlProcsNew();

            dsFetchSE = sqlobj.ExecuteSP("SP_FetchDoorNoStatus",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 });


            ddlStatus.DataSource = dsFetchSE.Tables[0];
            ddlStatus.DataValueField = "Value";
            ddlStatus.DataTextField = "Value";
            ddlStatus.DataBind();

            ddlStatus.Items.Insert(0, new ListItem("--Select--", "99"));
            ddlStatus.SelectedIndex = 0;

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void gvVilla_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();
            if (e.Item is GridDataItem)
            {
                GridDataItem ditem = (GridDataItem)e.Item;
                LinkButton lnkdoorno = (LinkButton)e.Item.FindControl("lbtnDoorNo");
                DataSet dsRes = sqlobj.ExecuteSP("Proc_VillaMaster",
                    new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 6 },
                 new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = lnkdoorno.Text });
                if (dsRes.Tables[0].Rows.Count > 0)
                {
                    txtDoorno.Text = dsRes.Tables[0].Rows[0]["DoorNo"].ToString();
                    if (txtDoorno.Text == "STAFF" || txtDoorno.Text == "WALKIN" || txtDoorno.Text == "")
                    {
                        txtDoorno.Enabled = false;
                    }
                    ddlType.SelectedValue = dsRes.Tables[0].Rows[0]["Type"].ToString();
                    ddlFloors.SelectedValue = dsRes.Tables[0].Rows[0]["Floor"].ToString();
                    txtdesc.Text = dsRes.Tables[0].Rows[0]["Description"].ToString();
                    if (dsRes.Tables[0].Rows[0]["ConstructionYear"].ToString()=="0")
                    {
                        txtConstructionYear.Text = "";
                    }
                    else
                    {
                        txtConstructionYear.Text = dsRes.Tables[0].Rows[0]["ConstructionYear"].ToString();
                    }
                    
                    txtBlockName.Text = dsRes.Tables[0].Rows[0]["BlockName"].ToString();
                    ddlStatus.SelectedValue = dsRes.Tables[0].Rows[0]["status"].ToString();
                    txtcstatus.Text = dsRes.Tables[0].Rows[0]["status"].ToString();
                    strPstatus = dsRes.Tables[0].Rows[0]["status"].ToString();
                    txtSqure.Text = dsRes.Tables[0].Rows[0]["SqrFeet"].ToString();
                    //txtcstatus.Visible = true;
                    ddlStatus.Visible = true;
                    //btnSave.Visible = true;
                    //lblnewstatus.Visible = true;
                    //txtNewStatus.Visible = true;
                }
                btnSave.Visible = false;
                //btnDelete.Visible = true;
                btnUpdate.Visible = true;
            }
        }
        else if (e.CommandName == "ViewDetails")
        {

            DataSet dsRes = new DataSet();

            dsRes = sqlobj.ExecuteSP("Proc_GetResidents",
                new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = e.CommandArgument.ToString() });


            if (dsRes.Tables[0].Rows.Count > 0)
            {
                dlDoorno.DataSource = dsRes;
                dlDoorno.DataBind();
                rwDetailsPopup.Visible = true;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('No resident available');", true);
            }
        }
        else if (e.CommandName == "ViewHistory")
        {
            string DoorNo = e.CommandArgument.ToString();
            LblDoorNo.Text = "Occupancy History for " + DoorNo;
            Session["RDoorNo"] = DoorNo;
            LoadOccupancyHistory(DoorNo);
            rwOccupancyHistory.Visible = true;
        }
        else
        {
            LoadUserGrid();
        }
    }
    public void LoadUserGrid()
    {
        try
        {

            DataSet dsUsers = sqlobj.ExecuteSP("Proc_VillaMaster",
               new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 4 });


            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                gvVilla.DataSource = dsUsers;
                gvVilla.DataBind();
            }
            else
            {
                gvVilla.DataSource = null;
                gvVilla.DataBind();
            }

            dsUsers.Dispose();

            DataSet dsVillaSummary = sqlobj.ExecuteSP("SP_VillaSummary");

            if (dsVillaSummary.Tables[0].Rows.Count > 0)
            {
                rgvillaSummary.DataSource = dsVillaSummary;
                rgvillaSummary.DataBind();
            }
            else
            {
                rgvillaSummary.DataSource = null;
                rgvillaSummary.DataBind();
            }

            dsVillaSummary.Dispose();


        }
        catch (Exception ex)
        {
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
        CHECKDOORNOCOUNT();
        btnUpdate.Visible = false;
    }
    public void Clear()
    {
        txtdesc.Text = string.Empty;
        txtDoorno.Text = string.Empty;
        txtDoorno.Enabled = true;
        ddlStatus.SelectedIndex = 0;

        txtConstructionYear.Text = "";
        txtBlockName.Text = "";

        txtcstatus.Visible = false;
        ddlStatus.Visible = true;
        txtNewStatus.Text = "";
        txtcstatus.Text = "";
        txtSqure.Text = "";

        // btnBlocked.Visible = false;
        //btnLocked.Visible = false;
        //btnVacant.Visible = false;
        //btnOccupied.Visible = false ;

        lblnewstatus.Visible = false;
        txtNewStatus.Visible = false;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            if (CnfResult.Value == "true")
            {

                if (txtDoorno.Text != "")
                {

                    sqlobj.ExecuteSP("Proc_VillaMaster",
                      new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 1 },
                      new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = txtDoorno.Text },
                      new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue.ToString() },
                      new SqlParameter() { ParameterName = "@Floor", SqlDbType = SqlDbType.NVarChar, Value = ddlFloors.SelectedValue.ToString() },
                      new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text == "" ? null : txtdesc.Text },
                      new SqlParameter() { ParameterName = "@status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedItem.Text },
                      new SqlParameter() { ParameterName = "@ContructionYear", SqlDbType = SqlDbType.BigInt, Value = txtConstructionYear.Text },
                      new SqlParameter() { ParameterName = "@BlockName", SqlDbType = SqlDbType.NVarChar, Value = txtBlockName.Text },
                      new SqlParameter() { ParameterName = "@SqrFt", SqlDbType = SqlDbType.NVarChar, Value = txtSqure.Text }
                      );



                    LoadUserGrid();
                    Clear();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Villa details added successfully');", true);
                }
                else
                {
                    WebMsgBox.Show("Please enter the Door No.");
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

            //if (CnfResult.Value == "true")
            //{
            if(ddlStatus.SelectedValue=="99")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select Status and Try again.');", true);
                return;
            }
            if (string.IsNullOrEmpty(txtDoorno.Text))
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Enter Door Number.');", true);
                return;
            }
                string strCstatus = ddlStatus.SelectedItem.Text;

                string status = "";


                if (txtNewStatus.Text == "")
                {
                    status = txtcstatus.Text;
                }
                else
                {
                    status = txtNewStatus.Text;
                }

              
                sqlobj.ExecuteSP("Proc_VillaMaster",
                 new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 2 },
                 new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.BigInt, Value = hbtnRSN.Value },
                 new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = txtDoorno.Text },
                 new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.NVarChar, Value = ddlType.SelectedValue.ToString() },
                 new SqlParameter() { ParameterName = "@Floor", SqlDbType = SqlDbType.NVarChar, Value = ddlFloors.SelectedValue.ToString() },
                 new SqlParameter() { ParameterName = "@Description", SqlDbType = SqlDbType.NVarChar, Value = txtdesc.Text == "" ? null : txtdesc.Text },
                 new SqlParameter() { ParameterName = "@status", SqlDbType = SqlDbType.NVarChar, Value = ddlStatus.SelectedValue },
                 new SqlParameter() { ParameterName = "@ContructionYear", SqlDbType = SqlDbType.BigInt, Value = txtConstructionYear.Text == "" ? 0 : Convert.ToInt32(txtConstructionYear.Text) },
                 new SqlParameter() { ParameterName = "@BlockName", SqlDbType = SqlDbType.NVarChar, Value = txtBlockName.Text },
                 new SqlParameter() { ParameterName = "@SqrFt", SqlDbType = SqlDbType.NVarChar, Value = txtSqure.Text == "" ? null : txtSqure.Text }
                 );



                // -- UnAssigned

                if (txtcstatus.Text == "Occupied" && ddlStatus.SelectedItem.Text == "Vacant")
                {
                    sqlobj.ExecuteSP("SP_UpdateDoorNo",
                    new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 1 },
                    new SqlParameter() { ParameterName = "@OldStatus", SqlDbType = SqlDbType.NVarChar, Value = txtcstatus.Text },
                    new SqlParameter() { ParameterName = "@NewStatus", SqlDbType = SqlDbType.NVarChar, Value = status.ToString() },
                    new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = txtDoorno.Text }
                 );

                }
                else
                {


                    if (txtNewStatus.Text != "")
                    {

                        if (txtcstatus.Text != txtNewStatus.Text)
                        {

                            sqlobj.ExecuteSP("SP_UpdateDoorNo",
                        new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 2 },
                        new SqlParameter() { ParameterName = "@OldStatus", SqlDbType = SqlDbType.NVarChar, Value = txtcstatus.Text },
                        new SqlParameter() { ParameterName = "@NewStatus", SqlDbType = SqlDbType.NVarChar, Value = status.ToString() },
                        new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = txtDoorno.Text });
                        }
                    }
                }

                Clear();
                LoadUserGrid();
                CHECKDOORNOCOUNT();
                btnUpdate.Visible = false;


                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Villa details updated successfully');", true);

            }
        //}
        catch (Exception ex)
        {

            WebMsgBox.Show(ex.Message);

        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {

            sqlobj.ExecuteSP("Proc_VillaMaster",
            new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 3 },
            new SqlParameter() { ParameterName = "@RSNo", SqlDbType = SqlDbType.BigInt, Value = hbtnRSN.Value }
            );

            Clear();
            LoadUserGrid();
            CHECKDOORNOCOUNT();
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Villa details deleted successfully');", true);
        }
        catch (Exception ex)
        {

        }
    }
    protected void txtDoorno_TextChanged(object sender, EventArgs e)
    {
        try
        {

            DataSet ds = sqlobj.ExecuteSP("porc_ChekDoorNo",
             new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.VarChar, Value = txtDoorno.Text }

             );


            if (ds.Tables[0].Rows.Count > 0)
            {
                Int16 sts = Convert.ToInt16(ds.Tables[0].Rows[0][0].ToString());
                if (sts == 1)
                {
                    txtDoorno.Text = string.Empty;
                    lblError.Visible = true;
                    lblError.Text = "Door No already exists.";
                    //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Door No already exists.');", true);
                }
                else
                {
                    lblError.Visible = false;
                }
            }

        }
        catch (Exception ex)
        {
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
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
        if (e.Item.Text == "Task List Lookup")
        {
            Response.Redirect("~/TaskLkup.aspx");
        }
        if (e.Item.Text == "Assets")
        {
            Response.Redirect("~/Assets.aspx");
        }
    }
    protected void btnHelp_Click(object sender, EventArgs e)
    {
        rwHelp.Visible = true;
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            txtNewStatus.Text = ddlStatus.SelectedValue.ToString();
            //string strCstatus = ddlStatus.SelectedItem.Text;


            //if ((strPstatus == strCstatus) || (strPstatus == "Blocked" && strCstatus == "Vacant") || (strPstatus == "Locked" && strCstatus == "Occupied")
            //     || (strPstatus == "Locked" && strCstatus == "Vacant") || (strPstatus == "Occupied" && strCstatus == "Locked") || (strPstatus == "Occupied" && strCstatus == "Vacant")
            //    || (strPstatus == "Vacant" && strCstatus == "Blocked") || (strPstatus == "Vacant" && strCstatus == "Occupied"))
            //{

            //}
            //else
            //{
            //    string strmsg = "Sorry! You cannot change the DoorNo " + txtDoorno.Text + " Status to " + strCstatus.ToString(); 

            //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('" + strmsg.ToString() +"');", true);
            //}

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnVacant_Click(object sender, EventArgs e)
    {
        try
        {
            txtNewStatus.Text = "Vacant";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnLocked_Click(object sender, EventArgs e)
    {
        try
        {
            txtNewStatus.Text = "Locked";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnBlocked_Click(object sender, EventArgs e)
    {
        try
        {
            txtNewStatus.Text = "Blocked";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnOccupied_Click(object sender, EventArgs e)
    {
        try
        {
            txtNewStatus.Text = "Occupied";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    // Start Import functionality
    protected void lbtnResdownload_Click(object sender, EventArgs e)
    {
        string fileName;
        try
        {
            Response.ContentType = "application/vnd.ms-excel";
            fileName = Server.MapPath("~\\SampleExcel\\DoorNos.xls");
            Response.AppendHeader("Content-Disposition", "attachment; filename=DooNos.xls");
            Response.TransmitFile(fileName);
            Response.End();
        }
        catch (Exception ex)
        {
        }
        rwImportExcel.Visible = true;
    }
    protected void btnImport_Click(object sender, EventArgs e)
    {
        rwImportExcel.Visible = true;
    }
    protected void UpdatePanel_Unload(object sender, EventArgs e)
    {
        MethodInfo methodInfo = typeof(ScriptManager).GetMethods(BindingFlags.NonPublic | BindingFlags.Instance)
            .Where(i => i.Name.Equals("System.Web.UI.IScriptManagerInternal.RegisterUpdatePanel")).First();
        methodInfo.Invoke(ScriptManager.GetCurrent(Page),
            new object[] { sender as UpdatePanel });
    }

    protected void btnexcelimport_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();
        DataSet dsVilla = new DataSet();
        StringBuilder sb = new StringBuilder();

        string connstring = "";
        int i = 0;
        int rows = 0;
        int excelrow = 0;
        int error = 0;
        //return;
        try
        {
            if (!fuExcel.HasFile)
            {
                WebMsgBox.Show("Please select excel file to import");
                rwImportExcel.Visible = true;
                return;
            }
            string strfiletype = Path.GetExtension(fuExcel.FileName).ToLower();
            string strPath = string.Concat(Server.MapPath("~/Excel/" + fuExcel.FileName));
            FileInfo filepath = new FileInfo(strPath);
            //filepath.Delete();
            fuExcel.PostedFile.SaveAs(strPath);

            if (strfiletype == ".xls")
            {
                connstring = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + strPath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (strfiletype == ".xlsx")
            {
                connstring = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + strPath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }
            else
            {
                WebMsgBox.Show("Please upload valid excel file");
                rwImportExcel.Visible = true;
                return;
            }
            string strValidate = "select * from [Sheet1$]";
            OleDbConnection con = new OleDbConnection(connstring);

            if (con.State == ConnectionState.Closed)
            {
                con.Open();
                OleDbCommand cmd = new OleDbCommand(strValidate, con);
                OleDbDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        excelrow += 1;
                        if (excelrow > 1)
                        {
                            string strDoorNo = dr[0].ToString();



                            if (dr[0].ToString() != "")
                            {
                                rows += 1;
                                dsVilla = sqlobj.ExecuteSP("SP_CheckDoorNo",
                                    new SqlParameter { ParameterName = "@DoorNo", SqlDbType = SqlDbType.VarChar, Value = dr[0].ToString() });
                                if (dsVilla.Tables[0].Rows.Count > 0)
                                {
                                    string stsVilla = dsVilla.Tables[0].Rows[0][0].ToString();
                                    if (stsVilla == "0")
                                    {
                                        sb.Append(dr[0].ToString());
                                        sb.Append(" ");
                                        error += 1;
                                    }
                                }
                            }
                            else
                            {
                                WebMsgBox.Show("Please enter the DoorNos to upload.");
                                return;
                            }
                        }
                    }
                }
                dr.Close();
                if (error > 0)
                {
                    WebMsgBox.Show("Total No of DoorNos :" + rows + " " + " Errors found in Door No :" + sb.ToString());
                    return;
                }
                rows = 0;
                excelrow = 0;
                i = 0;
                string strdate;
                if (con.State == ConnectionState.Open)
                {
                    //con.Open();
                    OleDbCommand cmdinsert = new OleDbCommand(strValidate, con);
                    OleDbDataReader drinsert = cmdinsert.ExecuteReader();
                    if (drinsert.HasRows)
                    {
                        while (drinsert.Read())
                        {
                            excelrow += 1;
                            if (excelrow > 1)
                            {

                                if (drinsert[0].ToString() != "")
                                {

                                    rows += 1;
                                    sqlobj.ExecuteNonQuery("SP_InsertDoorNosExcelfile",
                                            new SqlParameter { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = drinsert[0].ToString() }



                                           );
                                    i += 1;
                                }
                            }
                        }
                    }
                    dr.Close();

                    LoadUserGrid();


                    WebMsgBox.Show("Total No of DoorNos :" + rows + " " + " Total No of Records inserted :" + i);
                    rwImportExcel.Visible = true;


                }
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }
    }



    // End Import Functionality

    protected void lnkHelpPopup_Click(object sender, EventArgs e)
    {
        rwHelpmsg.Visible = true;
    }

    protected void btnHelpCancel_Click(object sender, EventArgs e)
    {
        rwHelpmsg.Visible = false;
    }
    protected void gvVilla_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvVilla.FilterMenu;
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
    protected void rgOccupancyHistory_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadOccupancyHistory(Session["RDoorNo"].ToString());
    }
    private void LoadOccupancyHistory(string DoorNo)
    {
        try
        {

            DataSet dsOccupancyHistory = sqlobj.ExecuteSP("SP_GetOccupancyHistory ",
                 new SqlParameter() { ParameterName = "@DoorNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = DoorNo.ToString() });

            if (dsOccupancyHistory.Tables[0].Rows.Count > 0)
            {
                rgOccupancyHistory.DataSource = dsOccupancyHistory;
                rgOccupancyHistory.DataBind();
            }
            else
            {
                rgOccupancyHistory.DataSource = string.Empty;
                rgOccupancyHistory.DataBind();
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {

    }
}