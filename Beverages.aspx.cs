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

public partial class Beverages : System.Web.UI.Page
{
    decimal i = 0;
    decimal j = 0;


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

                GetCurrentBillingPeriod();

                LoadSession();

                LoadDinerspersessiondetailsTotal();

                LoadTotalCount();


                rgCasualBulkUpdate.DataSource = string.Empty;
                rgCasualBulkUpdate.DataBind();



            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    private void GetCurrentBillingPeriod()
    {
        try
        {
            DataSet dsCBP = null;
            dsCBP = sqlobj.ExecuteSP("SP_GetCurrentBillingPeriod");

            if (dsCBP.Tables[0].Rows.Count > 0)
            {
                Session["MinDate"] = Convert.ToDateTime(dsCBP.Tables[0].Rows[0]["bpfrom"].ToString());
                dtpDiners.MaxDate = DateTime.Now;
            }

            dtpDiners.SelectedDate = DateTime.Now;


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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 124 });


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


    private void LoadSession()
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsFetchSE = new DataSet();

            dsFetchSE = sqlobj.ExecuteSP("SP_ConfirmBeveragesDinersSessionFilter");

            ddlDinersSession.DataSource = dsFetchSE.Tables[0];
            ddlDinersSession.DataValueField = "SCode";
            ddlDinersSession.DataTextField = "SName";
            ddlDinersSession.DataBind();

            ddlDinersSession.Items.Insert(0, new ListItem("--Select--", "0"));

            dsFetchSE.Dispose();

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

            DateTime mindate = Convert.ToDateTime(Session["MinDate"].ToString());

            if (dtpDiners.SelectedDate >= mindate)
            {

                if (CnfResult.Value == "true")
                {

                    int count = 0;

                    foreach (GridDataItem item in rgCasualBulkUpdate.MasterTableView.Items)
                    {
                        if (item.Selected)
                        {
                            count = count + 1;
                        }
                    }


                    if (count > 0)
                    {

                        foreach (GridDataItem rw in rgCasualBulkUpdate.MasterTableView.Items)
                        {

                            if (rw.Selected)
                            {

                                DropDownList ddlTea = (DropDownList)rw.FindControl("ddlTea");

                                DropDownList ddlCoffee = (DropDownList)rw.FindControl("ddlCoffee");

                                DropDownList ddlMilk = (DropDownList)rw.FindControl("ddlMilk");

                                DropDownList ddlHomeService = (DropDownList)rw.FindControl("ddlHomeService");


                                Int64 irtrsn = Convert.ToInt64(rw.GetDataKeyValue("RTRSN").ToString());

                                sqlobj.ExecuteSP("SP_TCM",
                                            new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 1 },
                                            new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                                            new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.BigInt, Value = irtrsn.ToString() },
                                            new SqlParameter() { ParameterName = "@Tea", SqlDbType = SqlDbType.NVarChar, Value = ddlTea.SelectedValue },
                                            new SqlParameter() { ParameterName = "@Coffee", SqlDbType = SqlDbType.NVarChar, Value = ddlCoffee.SelectedValue },
                                            new SqlParameter() { ParameterName = "@Milk", SqlDbType = SqlDbType.NVarChar, Value = ddlMilk.SelectedValue },
                                            new SqlParameter() { ParameterName = "@HomeService", SqlDbType = SqlDbType.NVarChar, Value = ddlHomeService.SelectedValue },
                                            new SqlParameter() { ParameterName = "@UserID", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() }
                                            );

                            }


                        }

                        Clear();

                        WebMsgBox.Show("Beverages confirmation successfully updated");
                    }

                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select atleast one Door No to update the actual dining details.');", true);
                    }

                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Beverages confirmation only allowed for within the billing period.');", true);
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void dtpDiners_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            LoadSession();

            
            DateTime mindate = Convert.ToDateTime(Session["MinDate"].ToString());

            if (dtpDiners.SelectedDate >= mindate)
            {
                btnUpdate.Visible = true;
            }
            else
            {
                btnUpdate.Visible = false;
            }


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlDinersSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadDiners();

            LoadDinerspersessiondetailsTotal();

            LoadTotalCount();


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadDiners()
    {
        try
        {
            if (ddlDinersSession.SelectedItem.Text != "--Select--")
            {
                DataSet dsGetDiners = sqlobj.ExecuteSP("SP_TCM",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 2 },
                new SqlParameter() { ParameterName = "@DiningAT", SqlDbType = SqlDbType.NVarChar, Value = ddlDiningAT.SelectedValue == "--Select--" ? null : ddlDiningAT.SelectedValue }
                 );

                if (dsGetDiners.Tables[0].Rows.Count > 0)
                {
                    rgCasualBulkUpdate.DataSource = dsGetDiners;
                    rgCasualBulkUpdate.DataBind();
                }
                else
                {
                    rgCasualBulkUpdate.DataSource = string.Empty;
                    rgCasualBulkUpdate.DataBind();
                }

                // lblTotalResident.Text = "Houses:" + dsGetDiners.Tables[0].Rows.Count;

                dsGetDiners.Dispose();
            }
            else
            {
                rgCasualBulkUpdate.DataSource = string.Empty;
                rgCasualBulkUpdate.DataBind();


                lblTotalBooked.Text = "";
                lblTotalGuestBooked.Text = "";
                lblTotalResident.Text = "";

            }
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
            dtpDiners.SelectedDate = DateTime.Now;

            ddlDinersSession.SelectedIndex = 0;

            rgCasualBulkUpdate.DataSource = string.Empty;
            rgCasualBulkUpdate.DataBind();

            lblTotalResident.Text = "";
            lblTotalBooked.Text = "";
            lblTotalGuestBooked.Text = "";

            LoadDinerspersessiondetailsTotal();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlTea_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            foreach (GridDataItem rw in rgCasualBulkUpdate.MasterTableView.Items)
            {

                DropDownList ddl1 = (DropDownList)rw["Tea"].FindControl("ddlTea");



                int c1 = Convert.ToInt32(ddl1.SelectedValue);



                if (c1 > 0)
                {
                    ddl1.Attributes.Add("style", "background-color:#ED7011;color:#fff");
                }
                else
                {
                    ddl1.Attributes.Add("style", "background-color:white;color:black");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlCoffee_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            foreach (GridDataItem rw in rgCasualBulkUpdate.MasterTableView.Items)
            {

                DropDownList ddl1 = (DropDownList)rw["Coffee"].FindControl("ddlCoffee");



                int c1 = Convert.ToInt32(ddl1.SelectedValue);



                if (c1 > 0)
                {
                    ddl1.Attributes.Add("style", "background-color:#ED7011;color:#fff");
                }
                else
                {
                    ddl1.Attributes.Add("style", "background-color:white;color:black");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlMilk_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            foreach (GridDataItem rw in rgCasualBulkUpdate.MasterTableView.Items)
            {

                DropDownList ddl1 = (DropDownList)rw["Milk"].FindControl("ddlMilk");



                int c1 = Convert.ToInt32(ddl1.SelectedValue);



                if (c1 > 0)
                {
                    ddl1.Attributes.Add("style", "background-color:#ED7011;color:#fff");
                }
                else
                {
                    ddl1.Attributes.Add("style", "background-color:white;color:black");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
   
    protected void ddlHomeService_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            foreach (GridDataItem rw in rgCasualBulkUpdate.MasterTableView.Items)
            {

                DropDownList ddl1 = (DropDownList)rw["HomeService"].FindControl("ddlHomeService");
              


                int c1 = Convert.ToInt32(ddl1.SelectedValue);
               


                if (c1 > 0)
                {
                    ddl1.Attributes.Add("style", "background-color:#ED7011;color:#fff");
                }
                else
                {
                    ddl1.Attributes.Add("style", "background-color:white;color:black");
                }
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void rgCasualBulkUpdate_Init(object sender, EventArgs e)
    {
        GridFilterMenu menu = rgCasualBulkUpdate.FilterMenu;
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

    protected void rgCasualBulkUpdate_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {

        try
        {


            if (e.Item is GridDataItem)
            {
                GridDataItem dataItem = e.Item as GridDataItem;


                LinkButton lnktype = (LinkButton)dataItem["Type"].FindControl("lnktype");
                LinkButton lnkname = (LinkButton)dataItem["Name"].FindControl("lnkname");

                string strtype = lnktype.Text;



                if (strtype == "C")
                {

                    lnkname.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lnkname.ForeColor = System.Drawing.Color.Maroon;
                }


                DropDownList ddl2 = (DropDownList)dataItem["Tea"].FindControl("ddlTea");
                DropDownList ddl1 = (DropDownList)dataItem["Milk"].FindControl("ddlMilk");
                DropDownList ddl3 = (DropDownList)dataItem["Coffee"].FindControl("ddlCoffee");
                DropDownList ddl4 = (DropDownList)dataItem["HomeService"].FindControl("ddlHomeService");


                int c1 = Convert.ToInt32(ddl1.SelectedValue);
                int c2 = Convert.ToInt32(ddl2.SelectedValue);
                int c3 = Convert.ToInt32(ddl3.SelectedValue);
                int c4 = Convert.ToInt32(ddl4.SelectedValue);



                if (c1 > 0)
                {
                    ddl1.Attributes.Add("style", "background-color:#ED7011;color:#fff");
                }
                else
                {
                    ddl1.Attributes.Add("style", "background-color:white;color:black");
                }


                if (c2 > 0)
                {
                    ddl2.Attributes.Add("style", "background-color:#ED7011;color:#fff");
                }
                else
                {
                    ddl2.Attributes.Add("style", "background-color:white;color:black");
                }


                if (c3 > 0)
                {
                    ddl3.Attributes.Add("style", "background-color:#ED7011;color:#fff");
                }
                else
                {
                    ddl3.Attributes.Add("style", "background-color:white;color:black");
                }

                if (c4 > 0)
                {
                    ddl4.Attributes.Add("style", "background-color:#ED7011;color:#fff");
                }
                else
                {
                    ddl4.Attributes.Add("style", "background-color:white;color:black");
                }


            }

            if ((e.Item is GridEditableItem && e.Item.IsInEditMode))
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                DropDownList ddlTea = (DropDownList)item.FindControl("ddlEditTea");
                ddlTea.SelectedValue = (string)DataBinder.Eval(e.Item.DataItem, "Tea").ToString();

            }

            if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem || e.Item.ItemType == Telerik.Web.UI.GridItemType.Footer)
            {
                try
                {
                    //Telerik.Web.UI.GridDataItem dataItem = e.Item as Telerik.Web.UI.GridDataItem;   

                    if (e.Item is GridDataItem)
                    {
                        GridDataItem dataItem = e.Item as GridDataItem;
                        DropDownList ddl1 = (DropDownList)dataItem["Tea"].FindControl("ddlTea");



                        //  DropDownList ddl2 = (DropDownList)dataItem["Guest"].FindControl("ddlGuest");




                        //GridEditableItem item = (GridEditableItem)e.Item;
                        //DropDownList ddlBooked = (DropDownList)item.FindControl("ddlEditBooked");
                        //ddlBooked.SelectedValue = (string)DataBinder.Eval(e.Item.DataItem, "Booked").ToString();




                        i += Decimal.Parse(ddl1.SelectedItem.Text);
                        //j += decimal.Parse(ddl2.SelectedItem.Text);





                    }

                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message);
                }

            }
        }
        catch(Exception ex)
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
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnDiningBooking_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("DiningBookingNew.aspx");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnExit_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Dashboard.aspx");

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void rgCasualBulkUpdate_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void rgCasualBulkUpdate_ItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
         
          LoadDiners();
         
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadDiners();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadDinerspersessiondetailsTotal()
    {
        try
        {

            string stimeandrate = "";

            DataSet dsdinersTotal = sqlobj.ExecuteSP("SP_TotalBeverages",
                       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                       new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }

                       );


            if (dsdinersTotal != null)
            {

            if (dsdinersTotal.Tables[0].Rows.Count > 0)
            {
                rgDinersTotal.DataSource = dsdinersTotal.Tables[0];
                rgDinersTotal.DataBind();

            }
            else
            {
                rgDinersTotal.DataSource = string.Empty;
                rgDinersTotal.DataBind();
            }
        }

            dsdinersTotal.Dispose();

          

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTotalCount()
    {
        try
        {

            string stimeandrate = "";

            DataSet dsdinersTotal = sqlobj.ExecuteSP("SP_TCM",
                       new SqlParameter() { ParameterName = "@IMode", SqlDbType = SqlDbType.Int, Value = 3 }
                      
                       );


            if (dsdinersTotal != null)
            {

            if (dsdinersTotal.Tables[0].Rows.Count > 0)
            {
                rgTotalCount.DataSource = dsdinersTotal.Tables[0];
                rgTotalCount.DataBind();

            }
            else
            {
                rgTotalCount.DataSource = string.Empty;
                rgTotalCount.DataBind();
            }

            }
            dsdinersTotal.Dispose();



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void BtnnExcelExport_Click(object sender, EventArgs e)
    {
        try
        {

            SqlProcsNew sqlobj = new SqlProcsNew();

            DataSet dsStockTransaction = sqlobj.ExecuteSP("SP_TCM",
                new SqlParameter() { ParameterName = "@IMode", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = 4 },
                new SqlParameter() { ParameterName = "@Date", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate}
                );


            if (dsStockTransaction.Tables[0].Rows.Count > 0)
            {

                DataGrid dg = new DataGrid();

                dg.DataSource = dsStockTransaction.Tables[0];
                dg.DataBind();

                DateTime sdate = dtpDiners.SelectedDate.Value;


                // THE EXCEL FILE.
                string sFileName = "Beverages confirmation on " + sdate.ToString("dd/MM/yyyy") + ".xls";
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


                DateTime dates = DateTime.Now;

                string times = DateTime.Now.ToString("hh:mm:ss tt");

                Response.Write("<table><tr><td>Beverages confirmation on " + sdate.ToString("dd/MM/yyyy") + "</td><td> Printed on:" + DateTime.Today.ToString("dd/MM/yyyy") + "-" + times.ToString() + "</td></tr></table>");


                // STYLE THE SHEET AND WRITE DATA TO IT.
                Response.Write("<style> TABLE { border:dotted 1px #999; } " +
                    "TD { border:dotted 1px #D5D5D5; text-align:center } </style>");
                Response.Write(objSW.ToString());


                Response.End();
                dg = null;


            }
            else
            {
                WebMsgBox.Show(" From" + dtpDiners.SelectedDate.Value + " stock summary does not exist");
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlDiningAT_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            LoadDiners();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void lnkbtnHelp_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Function", "NavigateDir();", true);

    }

}