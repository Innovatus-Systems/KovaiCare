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
using Excel = Microsoft.Office.Interop.Excel;
using System.Runtime.InteropServices;
using OfficeOpenXml;
using System.IO;
using System.Data.OleDb;
using System.Text;
using System.Reflection;

public partial class DashBoard : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {

        RWRenewal.VisibleOnPageLoad = true;
        RWRenewal.Visible = false;
        rwVilla.VisibleOnPageLoad = true;
        rwVilla.Visible = false;
        rwDetails.VisibleOnPageLoad = true;
        rwDetails.Visible = false;
        RwOccup.VisibleOnPageLoad = true;
        RwOccup.Visible = false;
        rdwOutStanding.VisibleOnPageLoad = true;
        rdwOutStanding.Visible = false;
        lblshow.Text = "-";
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadTitle();
            LoadGrid();
            LoadStatus();
            LoadOccpStatus();
            LoadEventMsg();
        }
    }
    private void LoadStatus()
    {
        try
        {
            //DataSet dsStatsus = sqlobj.ExecuteSP("SP_GetVillaStatus");

            //if (dsStatsus.Tables[0].Rows.Count > 0)
            //{
            //    lnkOccupiedCnt.Text ="Occupied - " +dsStatsus.Tables[0].Rows[0]["Occupied"].ToString();                              
            //}
            //else
            //{
            //    lnkOccupiedCnt.Text = "0";
            //}
            //if (dsStatsus.Tables[1].Rows.Count > 0)
            //{
            //    lnkLockedCnt.Text ="Locked - "+ dsStatsus.Tables[1].Rows[0]["Locked"].ToString();              
            //}
            //else
            //{
            //    lnkOccupiedCnt.Text = "0";
            //}
            //if (dsStatsus.Tables[2].Rows.Count > 0)
            //{
            //    lnkBlockedCnt.Text ="Blocked - "+dsStatsus.Tables[2].Rows[0]["Blocked"].ToString();               
            //}
            //else
            //{
            //    lnkOccupiedCnt.Text = "0";
            //}
            //if (dsStatsus.Tables[3].Rows.Count > 0)
            //{
            //    lnkVacantCnt.Text ="Vacant - "+ dsStatsus.Tables[3].Rows[0]["Vacant"].ToString();               
            //}
            //else
            //{
            //    lnkOccupiedCnt.Text = "0";
            //}
            //dsStatsus.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadEventMsg()
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_GetTop2Events");
            if (ds.Tables[0].Rows.Count > 0)
            {
                Label2.Visible = true;
                lblMsg.Text = ds.Tables[0].Rows[0]["EventName"].ToString();
            }
            else
            {
                Label2.Visible = false;              
            }
            ds.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadOccpStatus()
    {
        try
        {
            DataSet dsStatsus = sqlobj.ExecuteSP("SP_GetVillaStatus");
            if (dsStatsus.Tables[0].Rows.Count > 0)
            {
                rdOccup.DataSource = dsStatsus.Tables[0];
                rdOccup.DataBind();
                dsStatsus.Dispose();
            }
            else
            {
                rdOccup.DataSource = string.Empty;
                rdOccup.DataBind();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 97 });


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


    protected void LoadGrid()
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_FetchDashboardDet",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 1 });
            rdgResidentDet.DataSource = dsGroup.Tables[0];
            rdgResidentDet.DataBind();
            dsGroup.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    

    protected void rdgResidentDet_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        LoadGrid();
    }


    protected void rdgResidentDet_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        try
        {

            GridDataItem itm = e.Item as GridDataItem;
            if (itm != null)
            {
                if (itm.Cells[12].Text.Equals("Y"))
                {

                    LinkButton linkBtn = (LinkButton)itm.Cells[3].FindControl("lnkDoor");
                    linkBtn.ForeColor = System.Drawing.Color.Maroon;
                    linkBtn.Font.Bold = true;

                    //itm.Cells[3].ForeColor = System.Drawing.Color.Maroon;
                    //itm.Cells[3].Font.Bold = true;
                }
                if (itm.Cells[11].Text.Equals("Y"))
                {
                    itm.Cells[5].ForeColor = System.Drawing.Color.Maroon;
                    itm.Cells[5].Font.Bold = true;
                }
                if (itm.Cells[13].Text.Equals("Y"))
                {
                    itm.Cells[5].BackColor = System.Drawing.Color.Yellow;
                    itm.Cells[5].Font.Bold = true;
                }

                if (itm.Cells[17].Text.Equals("Y"))
                {
                    //itm.Cells[7].Text = "Overdue";
                    itm.Cells[7].ForeColor = System.Drawing.Color.Maroon;
                    itm.Cells[7].Font.Bold = true;
                }


                if (itm.Cells[15].Text.Equals("Y"))
                {
                    //itm.Cells[8].Text = "Overdue";
                    itm.Cells[8].ForeColor = System.Drawing.Color.Maroon;
                    itm.Cells[8].Font.Bold = true;
                }





                //Control ctrl = e.Item.FindControl("lblHK");
                //e.Item.FindControl("lblHK") = "Ram";

                //GridHeaderItem item = (GridHeaderItem)e.Item;
                //Label lbl = (Label)item.FindControl("lblHK");
                //lbl.Text = "Ram";

                //if (e.Item.ItemType == ListItemType.Header)
                //{


                //}


                //else
                //{
                //    //itm.Cells[6].BackColor = System.Drawing.Color.LightSkyBlue;
                //    itm.Cells[6].ForeColor = System.Drawing.Color.Black;
                //}

                //LinkButton lnkInvoice = (LinkButton)itm.Cells[3].FindControl("BtnInvoice");
                //if (!itm.Cells[10].Text.Equals("&nbsp;") && itm.Cells[10].Text.Equals("DONE"))
                //{
                //    itm.Cells[10].BackColor = System.Drawing.Color.Green;
                //    itm.Cells[10].ForeColor = System.Drawing.Color.White;
                //    lnkInvoice.Visible = false;
                //}
                //else if (!itm.Cells[10].Text.Equals("&nbsp;") && (itm.Cells[10].Text.Equals("OPEN") || itm.Cells[10].Text.Equals("PART")))
                //{
                //    itm.Cells[10].BackColor = System.Drawing.Color.Yellow;
                //    itm.Cells[10].ForeColor = System.Drawing.Color.Black;
                //    lnkInvoice.Visible = true;
                //}
                //else
                //{
                //    itm.Cells[10].BackColor = System.Drawing.Color.OrangeRed;
                //    itm.Cells[10].ForeColor = System.Drawing.Color.White;
                //    lnkInvoice.Visible = false;
                //}



                //LinkButton BtnInvRef1 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef1");
                //String[] InvRef = BtnInvRef1.Text.ToString().Replace(",,", ",").Split(',');
                ////ShowMessage(InvRef.Length.ToString(),"Alert");
                //if (InvRef.Length >= 1)
                //{
                //    BtnInvRef1.Text = InvRef[0].ToString();
                //    if (InvRef.Length >= 2)
                //    {

                //        LinkButton BtnInvRef2 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef2");
                //        BtnInvRef2.Text = InvRef[1].ToString();
                //        BtnInvRef2.Visible = true;
                //    }
                //    if (InvRef.Length >= 3)
                //    {

                //        LinkButton BtnInvRef3 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef3");
                //        BtnInvRef3.Text = InvRef[2].ToString();
                //        BtnInvRef3.Visible = true;
                //    }
                //    if (InvRef.Length >= 4)
                //    {
                //        LinkButton BtnInvRef4 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef4");
                //        BtnInvRef4.Text = InvRef[3].ToString();
                //        BtnInvRef4.Visible = true;
                //    }
                //    if (InvRef.Length >= 5)
                //    {
                //        LinkButton BtnInvRef5 = (LinkButton)itm.Cells[13].FindControl("BtnInvRef5");
                //        BtnInvRef5.Text = InvRef[4].ToString();
                //        BtnInvRef5.Visible = true;
                //    }
                //}


            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void rdgResidentDet_PreRender(object sender, EventArgs e)
    {

        try
        {
            GridHeaderItem headerItem = rdgResidentDet.MasterTableView.GetItems(GridItemType.Header)[0] as GridHeaderItem;


            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsHT = null;
            dsHT = sqlobj.ExecuteSP("SP_FetchDashboardDet",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 });

            //headerItem["RTVillaNo"].Text = "Door No. (" + dsHT.Tables[0].Rows[0]["CDV"].ToString() + ")";
            //headerItem["RTName"].Text = "Name (" + dsHT.Tables[1].Rows[0]["RCNT"].ToString() + ")";
            //headerItem["CHK"].Text = "HK (" + dsHT.Tables[2].Rows[0]["CHK"].ToString() + ")";
            //headerItem["CSR"].Text = "Services (" + dsHT.Tables[3].Rows[0]["CSR"].ToString() + ")";


            //headerItem["Dining"].Text = "Regular Diners (" + dsHT.Tables[4].Rows[0]["CRD"].ToString() + ")";
            headerItem["Dining"].Text = "Regular Diners";
            //headerItem["DOB"].Text = "DOB (" + dsHT.Tables[5].Rows[0]["CDOB"].ToString() + ")";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }



    protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridHeaderItem)
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsHT = null;
            dsHT = sqlobj.ExecuteSP("SP_FetchDashboardDet",
                new SqlParameter() { ParameterName = "@IMODE", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 2 });

            GridHeaderItem item = (GridHeaderItem)e.Item;
            Label lblName = (Label)item.FindControl("lblName");

            lblName.Text = "Name (" + dsHT.Tables[1].Rows[0]["RCNT"].ToString() + ")";
            Label lblDoorNo = (Label)item.FindControl("lblDoorNo");
            //lblDoorNo.Text = "Door No. (" + dsHT.Tables[0].Rows[0]["CDV"].ToString() + ")";
            lblDoorNo.Text = "Door No.";

            Label lblHK = (Label)item.FindControl("lblHK");
            //lblHK.Text = "HK (" + dsHT.Tables[2].Rows[0]["CHK"].ToString() + ")";
            lblHK.Text = "HK ";

            Label lblServices = (Label)item.FindControl("lblServices");
            lblServices.Text = "Services (" + dsHT.Tables[3].Rows[0]["CSR"].ToString() + ")";

            Label lblEvents = (Label)item.FindControl("lblEvents");
            //lblEvents.Text = "Events (" + dsHT.Tables[6].Rows[0]["EventCount"].ToString() + ")";
            lblEvents.Text = "Events";

        }
    }

    protected void lnkbutton1_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }


    protected void LnkbtnAddOn_Click(object sender, EventArgs e)
    {


        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ResidentRSN"] = row.Cells[2].Text;
        Session["PrevPageName"] = "DashBoard.aspx";
        Response.Redirect("AttributesAdd.aspx");

    }

    protected void lnkServices_Click(object sender, EventArgs e)
    {


        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["ServiceRSN"] = row.Cells[2].Text;

        //Response.Redirect("TaskList.aspx?Value1=3&Value2=-");
        Response.Redirect("HouseKeepingView.aspx?Val=2");

    }

    protected void lnkHouseKeeping_Click(object sender, EventArgs e)
    {


        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["HouseKeepingRSN"] = row.Cells[2].Text;

        Response.Redirect("HouseKeepingView.aspx?Val=1");

    }

    protected void lnkOutStanding_Click(object sender, EventArgs e)
    {
        try
        {
           
            StringBuilder str = new StringBuilder();
            LinkButton lnkOpenProjBtn = (LinkButton)sender;
            GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
            ViewState["RTRSN"] = row.Cells[2].Text;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "win",
   "<script language='javascript'> var iMyWidth;var iMyHeight;  window.open('OutStandingPopUp.aspx?NO=" + ViewState["RTRSN"] + "','NewWin','status=no,height=250,width=400 ,resizable=No,left=200,top=100,screenX=250,screenY=250,toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no,   NewWin.focus()')</script>", false);
      
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }

    }

    protected void LnkbtnAddOn_Click2(object sender, EventArgs e)
    {
        string CustomerRSN;
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["CustRSN"] = row.Cells[2].Text;
        CustomerRSN = Session["CustRSN"].ToString();

        //Response.Redirect("ResidentEdit.aspx?=" + CustomerRSN);
        string dashboard = "Dashbaord";
        Session["ResidentRSN"] = row.Cells[2].Text;
        Response.Redirect("ResidentView.aspx?=" + CustomerRSN + "&DashboardMsg=" + dashboard);

    }


    protected void rdgResidentDet_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rdgResidentDet.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains" || menu.Items[i].Text == "EqualTo" || menu.Items[i].Text == "GreaterThan" || menu.Items[i].Text == "LessThan")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }
    protected void lnkGoogleCharts_Click(object sender, EventArgs e)
    {
        string URL = "http://bincrm.com/orischarts/";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(URL);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(), "script", sb.ToString());

    }
    protected void lnkLocked_Click(object sender, EventArgs e)
    {
        Session["Click"] = "Locked & Blocked";
        rwVilla.Visible = true;
        lblshow.Text = "Locked & Blocked";
        DataSet dsUsers = sqlobj.ExecuteSP("SP_GetVillaStatusGrid",
            new SqlParameter() { ParameterName = "@status", SqlDbType = SqlDbType.Int, Value = 1 });
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
    }
    protected void lnkBlocked_Click(object sender, EventArgs e)
    {
        Session["Click"] = "Locked & Blocked";
        rwVilla.Visible = true;
        lblshow.Text = "Locked & Blocked";
        DataSet dsUsers = sqlobj.ExecuteSP("SP_GetVillaStatusGrid",
           new SqlParameter() { ParameterName = "@status", SqlDbType = SqlDbType.Int, Value = 1 });
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
    }
    protected void lnkVacant_Click(object sender, EventArgs e)
    {
        Session["Click"] = "Vacant";
        rwVilla.Visible = true;
        lblshow.Text = "Vacant";
        DataSet dsUsers = sqlobj.ExecuteSP("SP_GetVillaStatusGrid",
           new SqlParameter() { ParameterName = "@status", SqlDbType = SqlDbType.Int, Value = 3 });
        gvVilla.DataSource = dsUsers;
        gvVilla.DataBind();


        dsUsers.Dispose();
    }
    protected void lnkOccupied_Click(object sender, EventArgs e)
    {
        Session["Click"] = "Occupied";
        rwVilla.Visible = true;
        lblshow.Text = "Occupied";
        DataSet dsUsers = sqlobj.ExecuteSP("SP_GetVillaStatusGrid",
           new SqlParameter() { ParameterName = "@status", SqlDbType = SqlDbType.Int, Value = 2 });
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
    }

    protected void lnkDoor_Click(object sender, EventArgs e)
    {

        rwDetails.Visible = true;
        LinkButton lnk = (LinkButton)sender;
        string DoorNo = lnk.Text;
        DataSet dsUsers = sqlobj.ExecuteSP("Proc_VillaMaster",
            new SqlParameter() { ParameterName = "@i", SqlDbType = SqlDbType.Int, Value = 7 },
            new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = DoorNo });
        if (dsUsers.Tables[0].Rows.Count > 0)
        {
            lblType.Text = dsUsers.Tables[0].Rows[0]["Type"].ToString();
            lblSqre.Text = dsUsers.Tables[0].Rows[0]["SqrFeet"].ToString();
            lblConsYear.Text = dsUsers.Tables[0].Rows[0]["ConstructionYear"].ToString();
            lblFloor.Text = dsUsers.Tables[0].Rows[0]["Floor"].ToString();
            lbldesc.Text = dsUsers.Tables[0].Rows[0]["Description"].ToString();
            lblDoorNo.Text = dsUsers.Tables[0].Rows[0]["DoorNo"].ToString() + " - " + dsUsers.Tables[0].Rows[0]["status"].ToString();
            lblBlockName.Text = dsUsers.Tables[0].Rows[0]["BlockName"].ToString();
        }
    }
    protected void gvVilla_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (Session["Click"] == "Locked & Blocked")
        {
            rwVilla.Visible = true;
            lblshow.Text = "Locked & Blocked";
            DataSet dsUsers = sqlobj.ExecuteSP("SP_GetVillaStatusGrid",
                new SqlParameter() { ParameterName = "@status", SqlDbType = SqlDbType.Int, Value = 1 });
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
        }
        if (Session["Click"] == "Vacant")
        {
            rwVilla.Visible = true;
            lblshow.Text = "Vacant";
            DataSet dsUsers = sqlobj.ExecuteSP("SP_GetVillaStatusGrid",
               new SqlParameter() { ParameterName = "@status", SqlDbType = SqlDbType.Int, Value = 3 });
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
        }
        if (Session["Click"] == "Occupied")
        {
            rwVilla.Visible = true;
            lblshow.Text = "Occupied";
            DataSet dsUsers = sqlobj.ExecuteSP("SP_GetVillaStatusGrid",
               new SqlParameter() { ParameterName = "@status", SqlDbType = SqlDbType.Int, Value = 2 });
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
        }
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

    protected void lknOccpStatus_Click(object sender, EventArgs e)
    {
        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        string Status = row.Cells[4].Text;
        if (Status == "Occupied")
        {
            lnkOccupied_Click(sender, e);
        }
        if (Status == "Blocked" || Status == "Locked")
        {
            lnkBlocked_Click(sender, e);
        }
        if (Status == "Vacant")
        {
            lnkVacant_Click(sender, e);
        }

    }
    protected void btnOccup_Click(object sender, EventArgs e)
    {
        RwOccup.Visible = true;
    }
    protected void rdOccup_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            if (item["Status"].Text == "Vacant")
            {
                item.ForeColor = System.Drawing.Color.Red;
            }
        }
    }

    protected void lblMsg_Click(object sender, EventArgs e)
    {
        Response.Redirect("NewEvent.aspx");
    }

    protected void btnRenewal_Click(object sender, EventArgs e)
    {
        try {

            RWRenewal.Visible = true;
            LoadRenewal();
        }
        catch(Exception ex) { }
    }
    protected void LoadRenewal()
    {
        try
        {

            DataSet dsRenewal = sqlobj.ExecuteSP("CC_TenantRenewal",
               new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 });
            if (dsRenewal.Tables[0].Rows.Count > 0)
            {                
                rgRenewal.DataSource = dsRenewal.Tables[0];
                rgRenewal.DataBind();
            }
            else
            {
                rgRenewal.DataSource = string.Empty;
                rgRenewal.DataBind();
            }

            dsRenewal.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    protected void rgRenewal_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadRenewal();
    }

    protected void rgRenewal_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgRenewal.FilterMenu;
        int i = 0;
        while (i < menu.Items.Count)
        {
            if (menu.Items[i].Text == "NoFilter" || menu.Items[i].Text == "Contains" || menu.Items[i].Text == "GreaterThan" || menu.Items[i].Text == "LessThan")
            {
                i++;
            }
            else
            {
                menu.Items.RemoveAt(i);
            }
        }
    }

    protected void rgRenewal_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            GridDataItem itm = e.Item as GridDataItem;
            if (itm != null)
            {
                if (itm.Cells[5].Text == "Y")
                {
                    itm.Cells[3].ForeColor = System.Drawing.Color.Maroon;
                    itm.Cells[3].BackColor = System.Drawing.Color.Yellow;
                    itm.Cells[3].Font.Bold = true;
                }                
            }

        }
        catch (Exception ex)
        {

        }
    }
}