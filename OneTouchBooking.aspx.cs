using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Net.Mail;
using System.Data.SqlClient;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Configuration;
using System.Text;
using Telerik.Web.UI;

public partial class OneTouchBooking : System.Web.UI.Page
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

               // dtpDiners.MinDate = DateTime.Now;

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
            DataSet dsdiningtype = sqlobj.ExecuteSP("SP_GetDiningBookingType",
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
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 116 });


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

            ddlDinersSession.Items.Insert(0, "--Select--");

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


                            Int64 irtrsn = Convert.ToInt64(rw.GetDataKeyValue("RTRSN").ToString());

                            sqlobj.ExecuteSP("SP_UpdateBookedDiners",
                                   new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate.Value },
                                   new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                                   new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.BigInt, Value = irtrsn.ToString() },
                                   new SqlParameter() { ParameterName = "@Actual", SqlDbType = SqlDbType.NVarChar, Value = ddlBooked.SelectedValue },
                                   new SqlParameter() { ParameterName = "@GuestActual", SqlDbType = SqlDbType.NVarChar, Value = ddlGuestBooked.SelectedValue },
                                   new SqlParameter() { ParameterName = "@HomeService", SqlDbType = SqlDbType.NVarChar, Value = ddlHomeService.SelectedValue },
                                   new SqlParameter() { ParameterName = "@TotalActual", SqlDbType = SqlDbType.NVarChar, Value = Convert.ToInt32(ddlBooked.SelectedValue) + Convert.ToInt32(ddlGuestBooked.SelectedValue) + Convert.ToInt32(ddlHomeService.SelectedValue) }
                                   );
                        }


                    }

                    Clear();

                    WebMsgBox.Show("Dining Booking successfully updated");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select atleast one Door No to update the actual dining details.');", true);
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
        ddlDiningAT.SelectedIndex = 0;

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
                       // lblTotalBooked.Text = "Diners:" + i.ToString();
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
            foreach (GridDataItem rw in rgCasualBulkUpdate.MasterTableView.Items)
            {
                DropDownList ddl1 = (DropDownList)rw["Booked"].FindControl("ddlBooked");
                LinkButton lnkbcount = (LinkButton)rw["BCount"].FindControl("lnkbcount");
                Label lblbcount = (Label)rw["BCount"].FindControl("lblbwarning");

                int c1 = Convert.ToInt32(ddl1.SelectedValue);
                int c2 = Convert.ToInt32(lnkbcount.Text);


                if (c1 != c2)
                {

                    //lblbcount.Text = "(Not Equal)";
                }
                else
                {
                    lblbcount.Text = "";

                }


                i += Decimal.Parse(ddl1.SelectedItem.Text);


                DropDownList ddl2 = (DropDownList)rw["Guest"].FindControl("ddlGuest");
                //Label lbltotal = (Label)rw["Booked"].FindControl("LblBookedTotal");

                j += Decimal.Parse(ddl2.SelectedItem.Text);

            }




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
                // lblTotalBooked.Text = "Casual Diners:" + i.ToString();
            }

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
            foreach (GridDataItem rw in rgCasualBulkUpdate.MasterTableView.Items)
            {
                DropDownList ddl1 = (DropDownList)rw["Guest"].FindControl("ddlGuest");
                LinkButton lnkgcount = (LinkButton)rw["GCount"].FindControl("lnkdcount");
                Label lblgwarning = (Label)rw["Guest"].FindControl("lblgwarning");


                int c1 = Convert.ToInt32(ddl1.SelectedValue);
                int c2 = Convert.ToInt32(lnkgcount.Text);


                if (c1 != c2)
                {
                    //lblgwarning.Text = "(Not Equal)";
                }
                else
                {
                    lblgwarning.Text = "";
                }


                DropDownList ddl2 = (DropDownList)rw["Guest"].FindControl("ddlGuest");
                //Label lbltotal = (Label)rw["Booked"].FindControl("LblBookedTotal");

                j += Decimal.Parse(ddl2.SelectedItem.Text);

            }

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
                // lblTotalBooked.Text = "Casual Diners:" + i.ToString();
            }

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



                string strhomeservice = "";

                if (chkHomeService.Checked == true)
                {
                    strhomeservice = "1";
                }
                else if (chkHomeService.Checked == false)
                {
                    strhomeservice = "0";
                }
                
                
                DataSet dsGetDiners = sqlobj.ExecuteSP("SP_RegularCasualBulkUpdate",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.Int, Value = ddlType.SelectedValue },
                new SqlParameter() { ParameterName = "@DiningAT", SqlDbType = SqlDbType.NVarChar, Value = ddlDiningAT.SelectedValue == "All" ? null:ddlDiningAT.SelectedValue },
                new SqlParameter() { ParameterName = "@HomeService", SqlDbType = SqlDbType.Int, Value =  strhomeservice.ToString() }

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

                lblTotalBooked.Text = "Diners:" + dsGetDiners.Tables[0].Rows.Count;

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
    protected void chkHomeService_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            LoadDiners();
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnDinersList_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlDinersSession.SelectedItem.Text != "--Select--")
            {

                 string commnty ="";


                 DataSet dsAdminDetails = sqlobj.ExecuteSP("SP_AdminEdit");

                    if (dsAdminDetails.Tables[0].Rows.Count >0)
                    {
                        commnty = dsAdminDetails.Tables[0].Rows[0]["CommunityName"].ToString();
                    }

                   dsAdminDetails.Dispose();


                DateTime Odate = DateTime.Now;
                string date = Odate.ToString("dd-MMM-yyyy hh:mm tt");

                DateTime sdate = dtpDiners.SelectedDate.Value;



                string strhomeservice = "";

                if (chkHomeService.Checked == true)
                {
                    strhomeservice = "1";
                }
                else if (chkHomeService.Checked == false)
                {
                    strhomeservice = "0";
                }


                DataSet dsGetDiners = sqlobj.ExecuteSP("SP_RegularCasualBulkUpdate",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtpDiners.SelectedDate },
                new SqlParameter() { ParameterName = "@SessionCode", SqlDbType = SqlDbType.NVarChar, Value = ddlDinersSession.SelectedValue },
                new SqlParameter() { ParameterName = "@Type", SqlDbType = SqlDbType.Int, Value = ddlType.SelectedValue },
                new SqlParameter() { ParameterName = "@DiningAT", SqlDbType = SqlDbType.NVarChar, Value = ddlDiningAT.SelectedValue == "All" ? null : ddlDiningAT.SelectedValue },
                new SqlParameter() { ParameterName = "@HomeService", SqlDbType = SqlDbType.Int, Value = strhomeservice.ToString() }

                 );

                DataTable dtnew = dsGetDiners.Tables[0];


                StringBuilder sb = new StringBuilder();


                sb.Append("<table width='100%' cellspacing='3' cellpadding='3' style='font-family:Verdana;margin-left:15px;'>");
                sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'><b> " + commnty + " </b> </td></tr>");
                sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'></td></tr>");
                sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'></td></tr>");
                sb.Append("<br />");
                sb.Append("</table>");
                sb.Append("<table width='100%' cellspacing='1' cellpadding='1' style='font-family:Verdana;margin-top:15px;'>");
                sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:14px;'></td></tr>");
                sb.Append("<tr><td align='center' colspan='4' style='background-color: #18B5F0;font-size:12px;'><b> Home Delivery List </b> </td></tr>");
                sb.Append("<tr style='font-size:8px;' colspan='4'><td align='RIGHT'>Print : ");
                sb.Append(date);
                sb.Append("</td></tr>");
                sb.Append("<tr style='font-size:8px;' colspan='4'><td align='left'>Date : ");
                sb.Append(sdate.ToString("dd/MM/yyyy"));
                sb.Append("</td><td align='left'>Session : ");
                sb.Append(ddlDinersSession.SelectedItem.Text);
                sb.Append("</td></tr>");
                sb.Append("</table>");


                sb.Append("<table border = '1' width='100%' style='margin-left:15px;'>");
                sb.Append("<tr>");

                dtnew.Columns["rtvillano"].ColumnName = "DoorNo";
               
                dtnew.Columns["Booked"].ColumnName = "Diners";
                dtnew.Columns["GuestBooked"].ColumnName = "Guests";
                dtnew.Columns["HomeServiceBooked"].ColumnName = "HomeDelivery";


                foreach (DataColumn column in dtnew.Columns)
                {
                    
                        if (column.ColumnName == "DoorNo")
                        {
                            sb.Append("<th style = ' background-color: #9dabf9;font-size:11px;font-family:Verdana;' align='left'>");
                        }
                      
                        else if (column.ColumnName == "Name")
                        {
                            sb.Append("<th style = 'background-color: #9dabf9;font-size:11px;font-family:Verdana;' align='left'>");
                        }
                        
                        else if (column.ColumnName == "Diners")
                        {
                            sb.Append("<th style = 'background-color: #9dabf9;font-size:11px;font-family:Verdana;' align='center'>");
                        }
                        else if (column.ColumnName == "Guests")
                        {
                            sb.Append("<th style = 'background-color: #9dabf9;font-size:11px;font-family:Verdana;' align='center'>");
                        }
                        else if (column.ColumnName == "HomeDelivery")
                        {
                            sb.Append("<th style = 'background-color: #9dabf9;font-size:11px;font-family:Verdana;' align='center'>");
                        }

                        sb.Append(column.ColumnName);
                        sb.Append("</th>");
                   
                }
                sb.Append("</tr>");
                foreach (DataRow row in dtnew.Rows)
                {
                    sb.Append("<tr>");
                    foreach (DataColumn column in dtnew.Columns)
                    {
                        if (column.ToString() == "DoorNo")
                        {
                            sb.Append("<th style = ' background-color: #9dabf9;font-size:8px;font-family:Verdana;' align='left'>");
                        }

                        if (column.ToString() == "Name")
                        {
                            sb.Append("<th style = ' background-color: #9dabf9;font-size:8px;font-family:Verdana;' align='left'>");
                        }
                        
                        else if (column.ToString() == "Diners")
                        {
                            sb.Append("<th style = 'background-color: #9dabf9;font-size:8px;font-family:Verdana;' align='center'>");
                        }
                        else if (column.ToString() == "Guests")
                        {
                            sb.Append("<th style = 'background-color: #9dabf9;font-size:8px;font-family:Verdana;' align='center'>");
                        }
                        else if (column.ToString() == "HomeDelivery")
                        {
                            sb.Append("<th style = 'background-color: #9dabf9;font-size:8px;font-family:Verdana;' align='center'>");
                        }

                        sb.Append(row[column]);
                        sb.Append("</td>");
                       
                    }
                    sb.Append("</tr>");
                  }


                sb.Append("</table><br/>");


                StringReader sr = new StringReader(sb.ToString());

                Document pdfDoc = new Document(PageSize.A4, 50f, 20f, 40f, 50f);


               

                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                using (System.IO.MemoryStream memoryStream = new System.IO.MemoryStream())
                {

                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
                    pdfDoc.Open();

                    htmlparser.Parse(sr);
                    pdfDoc.Close();

                    byte[] bytes = memoryStream.ToArray();
                    memoryStream.Close();
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-Disposition", "attachment; filename=DinersList_" + sdate.ToString("dd/Mm/yyyy")  + "_" + ddlDinersSession.SelectedItem.Text + ".pdf" );
                    Response.ContentType = "application/pdf";
                    Response.Buffer = true;
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(bytes);
                    Response.End();
                    Response.Close();

                    //pdfDoc.Add(sr);
                   // pdfDoc.Open();




                }




            }
            else
            {
                WebMsgBox.Show("Please select the session");
            }

               
        }
        catch(Exception ex)
        {
            //WebMsgBox.Show(ex.Message);
        }
    }
}