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

public partial class StaffBooking : System.Web.UI.Page
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

                dtpDiners.MinDate = DateTime.Now;

                dtpDiners.SelectedDate = DateTime.Now;

                LoadSession();

                LoadDinerspersessiondetailsTotal();

                LoadPendingDetails();


                rgCasualBulkUpdate.DataSource = string.Empty;
                rgCasualBulkUpdate.DataBind();

               

            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }

    }

    private void LoadDiningType()
    {
        try
        {
            DataSet dsdiningtype = sqlobj.ExecuteSP("SP_GetStaffDiningBookingType",
                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                   new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }

                   );



            if (dsdiningtype.Tables[0].Rows.Count > 0)
            {
                ddlType.Items.Clear();

                ddlType.DataSource = dsdiningtype;
                ddlType.DataTextField = "Type";
                ddlType.DataValueField = "Value";
                ddlType.DataBind();
            }

            dsdiningtype.Dispose();




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

            DataSet dsdinersTotal = sqlobj.ExecuteSP("SP_TotalDiners",
                       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                       new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }

                       );


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

            dsdinersTotal.Dispose();


            dsdinersTotal = sqlobj.ExecuteSP("SP_TotalStaffDiners",
                    new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                    new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue }

                    );

            if (dsdinersTotal.Tables[0].Rows.Count > 0)
            {
                rgTotalStaffDiners.DataSource = dsdinersTotal.Tables[0];
                rgTotalStaffDiners.DataBind();

            }
            else
            {
                rgTotalStaffDiners.DataSource = string.Empty;
                rgTotalStaffDiners.DataBind();
            }

            dsdinersTotal.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadPendingDetails()
    {
        try
        {
            DataSet dsConfirmationpending = sqlobj.ExecuteSP("sp_ConfimationPending");


            if (dsConfirmationpending.Tables[0].Rows.Count > 0)
            {
                rgConfirmationPending.DataSource = dsConfirmationpending.Tables[0];
                rgConfirmationPending.DataBind();

            }
            else
            {
                rgConfirmationPending.DataSource = string.Empty;
                rgConfirmationPending.DataBind();
            }

            dsConfirmationpending.Dispose();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 117 });


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

            dsFetchSE = sqlobj.ExecuteSP("SP_DinersSessionFilter",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value });

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

                            DropDownList ddlBooked = (DropDownList)rw.FindControl("ddlBooked");

                            DropDownList ddlGuestBooked = (DropDownList)rw.FindControl("ddlGuest");

                            DropDownList ddlHomeService = (DropDownList)rw.FindControl("ddlHomeService");


                            Int64 irtrsn = Convert.ToInt64(rw.GetDataKeyValue("rsn").ToString());

                            sqlobj.ExecuteSP("SP_UpdateStaffBookedDiners",
                                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                                   new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                                   new SqlParameter() { ParameterName = "@STRSN", SqlDbType = SqlDbType.BigInt, Value = irtrsn.ToString() },
                                   new SqlParameter() { ParameterName = "@StaffB", SqlDbType = SqlDbType.NVarChar, Value = ddlBooked.SelectedValue },
                                   new SqlParameter() { ParameterName = "@StaffGB", SqlDbType = SqlDbType.NVarChar, Value = ddlGuestBooked.SelectedValue },
                                   new SqlParameter() { ParameterName = "@StaffHB", SqlDbType = SqlDbType.NVarChar, Value = ddlHomeService.SelectedValue }
                                   );
                        }


                    }

                    Clear();

                    WebMsgBox.Show("Dining Booking successfully updated");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select atleast one staff name to update the dining details.');", true);
                }
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void Clear()
    {
        dtpDiners.SelectedDate = DateTime.Now;

        ddlDinersSession.SelectedIndex = 0;

        rgCasualBulkUpdate.DataSource = string.Empty;
        rgCasualBulkUpdate.DataBind();

        lblTotalResident.Text = "";
        lblTotalBooked.Text = "";
        lblTotalGuestBooked.Text = "";

        LoadDinerspersessiondetailsTotal();
        LoadPendingDetails();
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
    protected void dtpDiners_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        try
        {
            LoadSession();

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

            LoadDiningType();

            LoadDiners();

            LoadDinerspersessiondetailsTotal();

            LoadPendingDetails();



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlByDoorNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

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
    protected void rgCasualBulkUpdate_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {


        //if (e.Item is GridDataItem) //Your condition goes here 
        //{
        //    GridEditableItem item = (GridEditableItem)e.Item;

        //    DropDownList ddlBooked = (DropDownList)item.FindControl("ddlEditBooked");
        //    ddlBooked.SelectedValue = (string)DataBinder.Eval(e.Item.DataItem, "Booked").ToString();

        //    DropDownList ddlGuestBooked = (DropDownList)item.FindControl("ddlEditGuestBooked");
        //    ddlGuestBooked.SelectedValue = (string)DataBinder.Eval(e.Item.DataItem, "GuestBooked").ToString();


        //    int ia = Convert.ToInt32(ddlBooked.SelectedValue);
        //    int ig = Convert.ToInt32(ddlGuestBooked.SelectedValue);


        //    if (ia > 0 || ig > 0)
        //    {
        //        ((e.Item as GridDataItem)["Select"].Controls[1] as CheckBox).Enabled = false;
        //    }



        //} 


        if ((e.Item is GridEditableItem && e.Item.IsInEditMode))
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            DropDownList ddlBooked = (DropDownList)item.FindControl("ddlEditBooked");
            ddlBooked.SelectedValue = (string)DataBinder.Eval(e.Item.DataItem, "Booked").ToString();

            DropDownList ddlGuestBooked = (DropDownList)item.FindControl("ddlEditGuestBooked");
            ddlGuestBooked.SelectedValue = (string)DataBinder.Eval(e.Item.DataItem, "GuestBooked").ToString();


            //int ia = Convert.ToInt32(ddlBooked.SelectedValue);
            //int ig = Convert.ToInt32(ddlGuestBooked.SelectedValue);


            //if (ia > 0 || ig >0)
            //{

            //}

        }

        if (e.Item.ItemType == Telerik.Web.UI.GridItemType.Item || e.Item.ItemType == Telerik.Web.UI.GridItemType.AlternatingItem || e.Item.ItemType == Telerik.Web.UI.GridItemType.Footer)
        {
            try
            {
                //Telerik.Web.UI.GridDataItem dataItem = e.Item as Telerik.Web.UI.GridDataItem;   

                if (e.Item is GridDataItem)
                {
                    GridDataItem dataItem = e.Item as GridDataItem;
                    DropDownList ddl1 = (DropDownList)dataItem["Booked"].FindControl("ddlBooked");



                    DropDownList ddl2 = (DropDownList)dataItem["Guest"].FindControl("ddlGuest");




                    //GridEditableItem item = (GridEditableItem)e.Item;
                    //DropDownList ddlBooked = (DropDownList)item.FindControl("ddlEditBooked");
                    //ddlBooked.SelectedValue = (string)DataBinder.Eval(e.Item.DataItem, "Booked").ToString();




                    i += Decimal.Parse(ddl1.SelectedItem.Text);
                    j += decimal.Parse(ddl2.SelectedItem.Text);



                    if (ddlType.SelectedValue == "1")
                    {
                        lblTotalBooked.Text = "Diners:" + i.ToString();
                    }
                    else if (ddlType.SelectedValue == "2")
                    {
                        //lblTotalBooked.Text = "Regular Diners:" + i.ToString();
                    }
                    else
                    {
                        //lblTotalBooked.Text = "Casual Diners:" + i.ToString();
                    }




                    //lblTotalGuestBooked.Text = "Guests:" + j.ToString();


                }
                //else if (e.Item is GridFooterItem)
                //{
                //    GridFooterItem footerItem = e.Item as GridFooterItem;
                //    (footerItem["Booked"].FindControl("LblBookedTotal") as Label).Text = "Total:" + i.ToString();
                //    //(footerItem["Balance"].FindControl("LblInvBalTotal") as Label).Text = invbal.ToString();

                //}
            }
            catch (Exception ex)
            {
            }

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

    protected void ddlBooked_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            //foreach (GridDataItem rw in rgCasualBulkUpdate.MasterTableView.Items)
            //{
                //DropDownList ddl1 = (DropDownList)rw["Booked"].FindControl("ddlBooked");
               // LinkButton lnkbcount = (LinkButton)rw["BCount"].FindControl("lnkbcount");
            //    Label lblbcount = (Label)rw["BCount"].FindControl("lblbwarning");

            //    int c1 = Convert.ToInt32(ddl1.SelectedValue);
            //    int c2 = Convert.ToInt32(lnkbcount.Text);


            //    if (c1 != c2)
            //    {

            //        //lblbcount.Text = "(Not Equal)";
            //    }
            //    else
            //    {
            //        lblbcount.Text = "";

            //    }


            //    i += Decimal.Parse(ddl1.SelectedItem.Text);


            //    DropDownList ddl2 = (DropDownList)rw["Guest"].FindControl("ddlGuest");
            //    //Label lbltotal = (Label)rw["Booked"].FindControl("LblBookedTotal");

            //    j += Decimal.Parse(ddl2.SelectedItem.Text);

            //}




            //if (ddlType.SelectedValue == "1")
            //{
            //    lblTotalBooked.Text = "Diners:" + i.ToString();
            //}
            //else if (ddlType.SelectedValue == "2")
            //{
            //    //lblTotalBooked.Text = "Regular Diners:" + i.ToString();
            //}
            //else
            //{
            //    // lblTotalBooked.Text = "Casual Diners:" + i.ToString();
            //}

            //lblTotalGuestBooked.Text = "Guest:" + j.ToString();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void ddlGuest_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            //foreach (GridDataItem rw in rgCasualBulkUpdate.MasterTableView.Items)
            //{
            //    DropDownList ddl1 = (DropDownList)rw["Guest"].FindControl("ddlGuest");
            //    LinkButton lnkgcount = (LinkButton)rw["GCount"].FindControl("lnkdcount");
            //    Label lblgwarning = (Label)rw["Guest"].FindControl("lblgwarning");


            //    int c1 = Convert.ToInt32(ddl1.SelectedValue);
            //    int c2 = Convert.ToInt32(lnkgcount.Text);


            //    if (c1 != c2)
            //    {
            //        //lblgwarning.Text = "(Not Equal)";
            //    }
            //    else
            //    {
            //        lblgwarning.Text = "";
            //    }


            //    DropDownList ddl2 = (DropDownList)rw["Guest"].FindControl("ddlGuest");
            //    //Label lbltotal = (Label)rw["Booked"].FindControl("LblBookedTotal");

            //    j += Decimal.Parse(ddl2.SelectedItem.Text);

            //}

            //if (ddlType.SelectedValue == "1")
            //{
            //    lblTotalBooked.Text = "Diners:" + i.ToString();
            //}
            //else if (ddlType.SelectedValue == "2")
            //{
            //    //lblTotalBooked.Text = "Regular Diners:" + i.ToString();
            //}
            //else
            //{
            //    // lblTotalBooked.Text = "Casual Diners:" + i.ToString();
            //}

            // lblTotalGuestBooked.Text = "Guest:" + j.ToString();

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
    protected void btnOneTouchUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            try
            {
                Response.Redirect("BulkUpdate.aspx");
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message);
            }
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
    private void LoadDiners()
    {
        try
        {
            if (ddlDinersSession.SelectedItem.Text != "--Select--")
            {
                DataSet dsGetDiners = sqlobj.ExecuteSP("SP_StaffBulkUpdate",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.Int, Value = ddlType.SelectedValue }
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
    protected void ddlHomeService_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void lnkDinersTotal_Click(object sender, EventArgs e)
    {
        rgDinersTotal.Visible = true;
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
}