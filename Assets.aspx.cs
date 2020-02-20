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

public partial class Assets : System.Web.UI.Page
{
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTitle();
            LoadDepartment();
            LoadUserGrid();
            txtAssetcode.Text = AssetID();
            txtAcqon.SelectedDate = DateTime.Today;
            //txtAMCend.SelectedDate = DateTime.Today;
            //txtdispon.SelectedDate = DateTime.Today;
            //txtwarrantyend.SelectedDate = DateTime.Today;

            txtAMCend.MinDate = txtAcqon.SelectedDate.Value;
            txtdispon.MinDate = txtAcqon.SelectedDate.Value;
            txtwarrantyend.MinDate = txtAcqon.SelectedDate.Value;
           
            btnUpdate.Visible = false;
            btnDelete.Visible = false;

            gvAssets2.Visible = false;
            //txtAssetcode.Focus();
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 67 });


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

    public string AssetID()
    {
        string strID = "";
        try
        {
            SqlCommand cmd = new SqlCommand("GetAssetCode", con);
            if(con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if(dr.HasRows)
            {
                while(dr.Read())
                {
                    strID = dr["Assetcode"].ToString();
                }
            }
            dr.Close();
            con.Close();
        }
        catch (Exception ex)
        {
           
        }
        return strID;
    }

    private void LoadDepartment()
    {
        try
        {
            DataSet dsDept = sqlobj.ExecuteSP("Proc_LoadServiceConfig",
              new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 5 });

            ddlDepartment.Items.Clear();
            
            if (dsDept.Tables[0].Rows.Count > 0)
            {

                ddlDepartment.DataSource = dsDept.Tables[0];
                ddlDepartment.DataTextField = "DeptName";
                ddlDepartment.DataValueField = "Code";
                ddlDepartment.DataBind();
            }

            ddlDepartment.Items.Insert(0, "--Select--");

            dsDept.Dispose();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    public void LoadUserGrid()
    {
        try
        {
            DataSet dsUsers;

            if (btnSold.Text == "Sold")
            {
                dsUsers = sqlobj.ExecuteSP("Proc_Assets", new SqlParameter() { ParameterName = "@i", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = 4 });                
            }
            else
            {
                dsUsers = sqlobj.ExecuteSP("Proc_Assets", new SqlParameter() { ParameterName = "@i", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = 6 });
            }
            
            
            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                gvAssets.DataSource = dsUsers;
                gvAssets.DataBind();
            }
            else
            {
                gvAssets.DataSource = string.Empty;
                gvAssets.DataBind();
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
            SqlCommand cmd = new SqlCommand("Proc_Assets", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 1);
            cmd.Parameters.AddWithValue("@Assetcode", txtAssetcode.Text);
            cmd.Parameters.AddWithValue("@Assetname", txtAssetName.Text);
            cmd.Parameters.AddWithValue("@Description", txtdesc.Text);
            cmd.Parameters.AddWithValue("@Vendor", txtvendor.Text);
            cmd.Parameters.AddWithValue("@Vendorcontactno", txtvencno.Text);
            cmd.Parameters.AddWithValue("@vendoremailid", txtvenemail.Text);
            cmd.Parameters.AddWithValue("@Assetmode", ddlAssetmode.SelectedValue);
            cmd.Parameters.AddWithValue("@Assettype", ddlAssettype.Text);
            cmd.Parameters.AddWithValue("@Acquiredon", txtAcqon.SelectedDate.ToString() == string.Empty ? null : txtAcqon.SelectedDate);
            cmd.Parameters.AddWithValue("@Disposedon", txtdispon.SelectedDate.ToString() == string.Empty ? null : txtdispon.SelectedDate);
            cmd.Parameters.AddWithValue("@Assetstatus", ddlAssetsts.SelectedValue);
            cmd.Parameters.AddWithValue("@Warrantyend", txtwarrantyend.SelectedDate.ToString() == string.Empty ? null : txtwarrantyend.SelectedDate);
            cmd.Parameters.AddWithValue("@AMCEnd", txtAMCend.SelectedDate.ToString() == string.Empty ? null : txtAMCend.SelectedDate);
            cmd.Parameters.AddWithValue("@InsuranceEnd", dtpInsuranceEnd.SelectedDate.ToString() == string.Empty ? null : dtpInsuranceEnd.SelectedDate);
            cmd.Parameters.AddWithValue("@AMCRemarks", txtAMCRemarks.Text);
            cmd.Parameters.AddWithValue("@EngineerContactno", txtEnggContNo.Text);
            cmd.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue == "--Select--" ? null : ddlDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@AssetValue", txtValue.Text);
            cmd.Parameters.AddWithValue("@Count", txtCount.Text);

            
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            LoadUserGrid();
            Clear();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Assets Information saved successfully');", true);
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_Assets", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 2);
            cmd.Parameters.AddWithValue("@RSN", hbtnRSN.Value);
            cmd.Parameters.AddWithValue("@Assetcode", txtAssetcode.Text);
            cmd.Parameters.AddWithValue("@Assetname", txtAssetName.Text);
            cmd.Parameters.AddWithValue("@Description", txtdesc.Text);
            cmd.Parameters.AddWithValue("@Vendor", txtvendor.Text);
            cmd.Parameters.AddWithValue("@Vendorcontactno", txtvencno.Text);
            cmd.Parameters.AddWithValue("@vendoremailid", txtvenemail.Text);
            cmd.Parameters.AddWithValue("@Assetmode", ddlAssetmode.SelectedValue);
            cmd.Parameters.AddWithValue("@Assettype", ddlAssettype.Text);
            cmd.Parameters.AddWithValue("@Acquiredon", txtAcqon.SelectedDate.ToString() == string.Empty ? null : txtAcqon.SelectedDate);
            cmd.Parameters.AddWithValue("@Disposedon", txtdispon.SelectedDate.ToString() == string.Empty ? null : txtdispon.SelectedDate);  
            cmd.Parameters.AddWithValue("@Assetstatus", ddlAssetsts.SelectedValue);
            cmd.Parameters.AddWithValue("@Warrantyend", txtwarrantyend.SelectedDate.ToString() == string.Empty ? null : txtwarrantyend.SelectedDate);
            cmd.Parameters.AddWithValue("@AMCEnd", txtAMCend.SelectedDate.ToString() == string.Empty ? null : txtAMCend.SelectedDate);
            cmd.Parameters.AddWithValue("@InsuranceEnd", dtpInsuranceEnd.SelectedDate.ToString() == string.Empty ? null : dtpInsuranceEnd.SelectedDate);
            cmd.Parameters.AddWithValue("@AMCRemarks", txtAMCRemarks.Text);
            cmd.Parameters.AddWithValue("@EngineerContactno", txtEnggContNo.Text);
            cmd.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue == "--Select--" ? null : ddlDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@AssetValue", txtValue.Text);
            cmd.Parameters.AddWithValue("@Count", txtCount.Text);
           
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Clear();
            LoadUserGrid();
           
            btnSave.Visible = true;
            btnDelete.Visible = false;
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Asset informations updated successfully');", true);
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Proc_Assets", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 3);
            cmd.Parameters.AddWithValue("@RSN", hbtnRSN.Value);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Clear();
            LoadUserGrid();
            btnSave.Visible = true;
            btnDelete.Visible = false;
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Alert", "alert('Asset information deleted successfully');", true);
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Dashboard.aspx");
    }
    public void Clear()
    {
        txtdesc.Text = string.Empty;
        txtAcqon.SelectedDate = DateTime.Today;       
        txtAMCend.SelectedDate = null;
        txtAMCRemarks.Text = string.Empty;
        txtAssetcode.Text = AssetID();
        txtAssetName.Text = string.Empty;
        txtdesc.Text = string.Empty;
        txtdispon.SelectedDate = null;
        txtEnggContNo.Text = string.Empty;
        txtvencno.Text = string.Empty;
        txtvendor.Text = string.Empty;
        txtvenemail.Text = string.Empty;
        txtwarrantyend.SelectedDate = null;
        dtpInsuranceEnd.SelectedDate = null;
        ddlDepartment.SelectedIndex = 0;
        txtCount.Text = "1";
        txtValue.Text = "0.00";
        
        txtAMCend.MinDate = txtAcqon.SelectedDate.Value;
        txtdispon.MinDate = txtAcqon.SelectedDate.Value;
        txtwarrantyend.MinDate = txtAcqon.SelectedDate.Value;

        btnSold.Text = "Sold";
        btnSold.ToolTip = "Click here to show the sold out assets";
        lblSold.Text = "Assets - In Use:";
        LoadUserGrid();
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        Clear();
        btnSave.Visible = true;
        btnDelete.Visible = false;
        btnUpdate.Visible = false;
    }
    protected void gvTaskLkup_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            hbtnRSN.Value = e.CommandArgument.ToString();
            DataSet dsEdit = new DataSet();
            if (e.Item is GridDataItem)
            {
                //GridDataItem ditem = (GridDataItem)e.Item;
                //ddlCategory.SelectedValue = ditem["Category"].Text.ToString();
                //txtTaskTitle.Text = ditem["TaskTittle"].Text.ToString();
                //txtdesc.Text = ditem["Message"].Text.ToString();

                SqlCommand cmd = new SqlCommand("Proc_Assets", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@i", 5);
                cmd.Parameters.AddWithValue("@RSN", hbtnRSN.Value);
                SqlDataAdapter dap = new SqlDataAdapter(cmd);
                dap.Fill(dsEdit, "temp");
                if(dsEdit.Tables[0].Rows.Count > 0)
                {
                    txtAssetcode.Text = dsEdit.Tables[0].Rows[0]["Assetcode"].ToString();
                    txtAssetName.Text = dsEdit.Tables[0].Rows[0]["Assetname"].ToString();
                    txtdesc.Text = dsEdit.Tables[0].Rows[0]["Description"].ToString();
                    txtvendor.Text = dsEdit.Tables[0].Rows[0]["Vendor"].ToString();
                    txtvencno.Text = dsEdit.Tables[0].Rows[0]["Vendorcontactno"].ToString();
                    txtvenemail.Text = dsEdit.Tables[0].Rows[0]["VendorEmailID"].ToString();
                    ddlAssetmode.SelectedValue = dsEdit.Tables[0].Rows[0]["Assetmode"].ToString();
                    ddlAssettype.SelectedValue = dsEdit.Tables[0].Rows[0]["Assettype"].ToString();
                    if (dsEdit.Tables[0].Rows[0]["AcquiredOn"].ToString() != null && dsEdit.Tables[0].Rows[0]["AcquiredOn"].ToString() != "")
                        txtAcqon.SelectedDate = Convert.ToDateTime(dsEdit.Tables[0].Rows[0]["AcquiredOn"]);
                    
                    txtAMCend.MinDate = txtAcqon.SelectedDate.Value;
                    txtdispon.MinDate = txtAcqon.SelectedDate.Value;
                    txtwarrantyend.MinDate = txtAcqon.SelectedDate.Value;

                    if (dsEdit.Tables[0].Rows[0]["DisposedOn"].ToString() != null && dsEdit.Tables[0].Rows[0]["DisposedOn"].ToString() != "")
                        txtdispon.SelectedDate = Convert.ToDateTime(dsEdit.Tables[0].Rows[0]["DisposedOn"]);
                    ddlAssetsts.SelectedValue = dsEdit.Tables[0].Rows[0]["Assetstatus"].ToString();
                    if (dsEdit.Tables[0].Rows[0]["Warrantyend"].ToString() != null && dsEdit.Tables[0].Rows[0]["Warrantyend"].ToString() != "")
                        txtwarrantyend.SelectedDate = Convert.ToDateTime(dsEdit.Tables[0].Rows[0]["Warrantyend"]);
                    if (dsEdit.Tables[0].Rows[0]["AMCEnd"].ToString() != null && dsEdit.Tables[0].Rows[0]["AMCEnd"].ToString() != "")
                        txtAMCend.SelectedDate = Convert.ToDateTime(dsEdit.Tables[0].Rows[0]["AMCEnd"]);

                    if (dsEdit.Tables[0].Rows[0]["Insuranceend"].ToString() != null && dsEdit.Tables[0].Rows[0]["Insuranceend"].ToString() != "")
                        dtpInsuranceEnd.SelectedDate = Convert.ToDateTime(dsEdit.Tables[0].Rows[0]["Insuranceend"]);
                    txtAMCRemarks.Text = dsEdit.Tables[0].Rows[0]["AMCRemarks"].ToString();
                    txtEnggContNo.Text = dsEdit.Tables[0].Rows[0]["Assigneecontactno"].ToString();
                    if (dsEdit.Tables[0].Rows[0]["DeptCode"].ToString() != "")
                    {
                        ddlDepartment.SelectedValue = dsEdit.Tables[0].Rows[0]["DeptCode"].ToString();
                    }
                    txtValue.Text = dsEdit.Tables[0].Rows[0]["AssetValue"].ToString();
                    txtCount.Text = dsEdit.Tables[0].Rows[0]["Count"].ToString();

                }

                btnSave.Visible = false;
                btnDelete.Visible = true;
                btnUpdate.Visible = true;
            }
        }
        else
        {
            LoadUserGrid();
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
        if (e.Item.Text == "Task List Lookup")
        {
            Response.Redirect("~/TaskLkup.aspx");
        }
        if (e.Item.Text == "Assets")
        {
            Response.Redirect("~/Assets.aspx");
        }
    }
    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        
        //if (gvAssets.Visible == true && gvAssets.Items.Count > 0)
        //{
           
        //    gvAssets.MasterTableView.Caption = "List of Assets";
        //    gvAssets.ExportSettings.ExportOnlyData = true;
        //    gvAssets.ExportSettings.FileName = "Assets";
        //    gvAssets.ExportSettings.IgnorePaging = true;
        //    gvAssets.ExportSettings.OpenInNewWindow = true;
        //    gvAssets.MasterTableView.ExportToExcel();
        //}


         SqlProcsNew sqlobj = new SqlProcsNew();

         DataSet dsAssets;

         if (btnSold.Text == "Sold")
         {
             dsAssets = sqlobj.ExecuteSP("Proc_Assets", new SqlParameter() { ParameterName = "@i", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = 7 });             
         }
         else
         {
             dsAssets = sqlobj.ExecuteSP("Proc_Assets", new SqlParameter() { ParameterName = "@i", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = 8 });
         }

         //DataSet dsAssets = sqlobj.ExecuteSP("Proc_Assets", new SqlParameter() { ParameterName = "@i", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.BigInt, Value = 4 });


            if (dsAssets.Tables[0].Rows.Count > 0)
            {
                DataGrid dg = new DataGrid();

                dg.DataSource = dsAssets.Tables[0];
                dg.DataBind();

              

                // THE EXCEL FILE.
                string sFileName = "List of Assets.xls";
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


                //"," + strdesc.ToString() +

                Response.Write("<table><tr><td>List of Assets<td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;
            }
    }

    protected void chkSold_Changed(object sender,EventArgs e)
    {
        LoadUserGrid();
    }

    protected void txtAcqon_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        txtAMCend.MinDate = txtAcqon.SelectedDate.Value;
        txtdispon.MinDate = txtAcqon.SelectedDate.Value;
        txtwarrantyend.MinDate = txtAcqon.SelectedDate.Value;
    }

    protected void btnSold_Click(object sender,EventArgs e)
    {
        if (btnSold.Text == "Sold")
        {
            btnSold.Text = "In Use";
            btnSold.ToolTip = "Click here to show the assets in use";
            lblSold.Text = "Assets - Sold Out :";
            LoadUserGrid();
           
        }
        else if (btnSold.Text == "In Use")
        {
            btnSold.Text = "Sold";
            btnSold.ToolTip = "Click here to show the sold out assets";
            lblSold.Text = "Assets - In Use :";
            LoadUserGrid();
           
        }
    }

    //protected void rdgListView_ItemDataBound(object sender, GridItemEventArgs e)
    //{
    //    try
    //    {
    //        Telerik.Web.UI.GridDataItem itm = e.Item as Telerik.Web.UI.GridDataItem;
    //        if (itm != null)
    //        {
    //            LinkButton lnkInvoice = (LinkButton)itm.Cells[3].FindControl("BtnInvoice");
    //            if (!itm.Cells[10].Text.Equals("&nbsp;") && itm.Cells[10].Text.Equals("DONE"))
    //            {
    //                itm.Cells[10].BackColor = System.Drawing.Color.Green;
    //                itm.Cells[10].ForeColor = System.Drawing.Color.White;
    //                lnkInvoice.Visible = false;
    //            }
    //            else if (!itm.Cells[10].Text.Equals("&nbsp;") && (itm.Cells[10].Text.Equals("OPEN") || itm.Cells[10].Text.Equals("PART")))
    //            {
    //                itm.Cells[10].BackColor = System.Drawing.Color.Yellow;
    //                itm.Cells[10].ForeColor = System.Drawing.Color.Black;
    //                lnkInvoice.Visible = true;
    //            }
    //            else
    //            {
    //                itm.Cells[10].BackColor = System.Drawing.Color.OrangeRed;
    //                itm.Cells[10].ForeColor = System.Drawing.Color.White;
    //                lnkInvoice.Visible = false;
    //            }



    //            LinkButton BtnInvRef1 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef1");
    //            String[] InvRef = BtnInvRef1.Text.ToString().Replace(",,", ",").Split(',');
    //            //ShowMessage(InvRef.Length.ToString(),"Alert");
    //            if (InvRef.Length >= 1)
    //            {
    //                BtnInvRef1.Text = InvRef[0].ToString();
    //                if (InvRef.Length >= 2)
    //                {

    //                    LinkButton BtnInvRef2 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef2");
    //                    BtnInvRef2.Text = InvRef[1].ToString();
    //                    BtnInvRef2.Visible = true;
    //                }
    //                if (InvRef.Length >= 3)
    //                {

    //                    LinkButton BtnInvRef3 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef3");
    //                    BtnInvRef3.Text = InvRef[2].ToString();
    //                    BtnInvRef3.Visible = true;
    //                }
    //                if (InvRef.Length >= 4)
    //                {
    //                    LinkButton BtnInvRef4 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef4");
    //                    BtnInvRef4.Text = InvRef[3].ToString();
    //                    BtnInvRef4.Visible = true;
    //                }
    //                if (InvRef.Length >= 5)
    //                {
    //                    LinkButton BtnInvRef5 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef5");
    //                    BtnInvRef5.Text = InvRef[4].ToString();
    //                    BtnInvRef5.Visible = true;
    //                }
    //            }

    //            if (itm.Cells[22].Text.Equals("N"))
    //            {
    //                itm.Cells[12].BackColor = System.Drawing.Color.LightSkyBlue;
    //                itm.Cells[12].ForeColor = System.Drawing.Color.Black;
    //            }
    //            else
    //            {
    //                itm.Cells[12].BackColor = System.Drawing.Color.White;
    //                itm.Cells[12].ForeColor = System.Drawing.Color.Black;
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}
    protected void btnWDateClear_Click(object sender, EventArgs e)
    {
        txtwarrantyend.Clear();
    }
    protected void btnADateClear_Click(object sender, EventArgs e)
    {
        txtAMCend.Clear();
    }
    protected void btnDClear_Click(object sender, EventArgs e)
    {
        txtdispon.Clear();
    }
    protected void btnIDateClear_Click(object sender, EventArgs e)
    {
        dtpInsuranceEnd.Clear();
    }
    protected void gvAssets_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = gvAssets.FilterMenu;
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