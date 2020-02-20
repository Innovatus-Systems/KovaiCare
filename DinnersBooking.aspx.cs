using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Telerik.Web.UI;
using System.Globalization;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
//using System.Security.Cryptography.Xml;
using System.Net;
using System.Net.Security;
using System.Diagnostics;
using System.IO;
using System.ComponentModel;

public partial class DinnersBooking : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            rgDinBkng.DataSource = string.Empty;
            rgDinBkng.DataBind();
            rdPrevBkng.DataSource = string.Empty;
            rdPrevBkng.DataBind();
            //dtDate.MinDate = DateTime.Now.Date;
            dtDate.SelectedDate = DateTime.Now;
            LoadTitle();
            LoadSession();
            LoadData1();
            rdPrevBkng.Visible = false;
            lblprevbkng.Visible = false;
        }
    }
    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 147 });
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
    private void LoadData()
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_DiningBooking",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                     new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                     new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = drpSession.SelectedValue }
                    );
            if (ds.Tables[0].Rows.Count > 0)
            {
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Confirm", "PopUp1();", true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadPrevBkng()
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_DiningBooking",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                     new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                     new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = drpSession.SelectedValue }
                    );
            if (ds.Tables[1].Rows.Count > 0)
            {
                rdPrevBkng.DataSource = ds.Tables[1];
                rdPrevBkng.DataBind();
            }
            else
            {
                rdPrevBkng.DataSource = string.Empty;
                rdPrevBkng.DataBind();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadData1()
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_DinersNotes",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 }
                    );
            if (ds.Tables[0].Rows.Count > 0)
            {
                rgDinNts.DataSource = ds.Tables[0];
                rgDinNts.DataBind();
            }
            else
            {
                rgDinNts.DataSource = string.Empty;
                rgDinNts.DataBind();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void LoadSession()
    {
        DataSet dsFetchSE = new DataSet();
        try
        {
            if (chkAll.Checked == true)
            {
                dsFetchSE = sqlobj.ExecuteSP("SP_GetSessionforDining",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
                drpSession.DataSource = dsFetchSE.Tables[0];
                drpSession.DataValueField = "SessionCode";
                drpSession.DataTextField = "SessionName";
                drpSession.DataBind();
                drpSession.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));
                dsFetchSE.Dispose();
            }
            else
            {
                dsFetchSE = sqlobj.ExecuteSP("SP_GetSessionforDining",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 });
                drpSession.DataSource = dsFetchSE.Tables[0];
                drpSession.DataValueField = "SessionCode";
                drpSession.DataTextField = "SessionName";
                drpSession.DataBind();
                drpSession.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));
                dsFetchSE.Dispose();
            }
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void chkAll_CheckedChanged(object sender, System.EventArgs e)
    {
        LoadSession();
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
       
        try
        {
            int i = rgDinBkng.Items.Count;
           
        
            if (i == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please do booking for any of the session and try again.');", true);
                return;
            }
            else { 
            GridDataItem item = (GridDataItem)rgDinBkng.MasterTableView.Items[0];
            if (i > 0)
            {
                DateTime Date = Convert.ToDateTime(dtDate.SelectedDate);
                string Session = drpSession.SelectedValue.ToString();
                TextBox Regular = item.FindControl("txtRegular") as TextBox;
                TextBox Casual = item.FindControl("txtCasual") as TextBox;
                TextBox HS = item.FindControl("txtHS") as TextBox;
                TextBox Guests = item.FindControl("txtGuests") as TextBox;
                TextBox GH = item.FindControl("txtGH") as TextBox;
                TextBox Staff = item.FindControl("txtStaff") as TextBox;
                TextBox Actual = item.FindControl("txtActual") as TextBox;
                TextBox Total = item.FindControl("txtTotal") as TextBox;
                Label RSN = item.FindControl("txtRSN") as Label;
                sqlobj.ExecuteSQLNonQuery("SP_UpdateDiningBooking",
                        new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                        new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = Date },
                        new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = Session },
                        new SqlParameter() { ParameterName = "@Regular", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Regular.Text) },
                        new SqlParameter() { ParameterName = "@Casual", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Casual.Text) },
                        new SqlParameter() { ParameterName = "@HS", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(HS.Text) },
                        new SqlParameter() { ParameterName = "@Guests", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Guests.Text) },
                        new SqlParameter() { ParameterName = "@GH", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(GH.Text) },
                        new SqlParameter() { ParameterName = "@Staff", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Staff.Text) },
                        new SqlParameter() { ParameterName = "@Actual", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(Actual.Text) },
                         new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(RSN.Text) }
                        );
            }
        }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
        LoadData();
        LoadPrevBkng();
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Detail Updated successfully.');", true);

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (drpSession.SelectedValue == "0")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Seesion and try again.');", true);
                return;
            }
            else
            {
                //if (dtDate.SelectedDate < DateTime.Now.Date || drpSession.SelectedValue||)
                rdPrevBkng.Visible = true;
                lblprevbkng.Visible = true;
                CheckValidations();
                LoadPrevBkng();

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    private void CheckValidations()
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_DiningBooking",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 },
                     new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                     new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = drpSession.SelectedValue }
                    );
            DataSet ds1 = sqlobj.ExecuteSP("SP_DiningBooking",
                   new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 5 });

            if (dtDate.SelectedDate == DateTime.Now.Date && drpSession.SelectedValue != ds1.Tables[0].Rows[0]["SessionCode"].ToString() && ds.Tables[0].Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Confirm", "PopUp2();", true);
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
            }
            else if (dtDate.SelectedDate == DateTime.Now.Date && drpSession.SelectedValue != ds1.Tables[0].Rows[0]["SessionCode"].ToString() && ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Confirm", "PopUp3();", true);
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
                GridDataItem item = (GridDataItem)rgDinBkng.MasterTableView.Items[0];
                TextBox Regular = item.FindControl("txtRegular") as TextBox;
                TextBox Casual = item.FindControl("txtCasual") as TextBox;
                TextBox HS = item.FindControl("txtHS") as TextBox;
                TextBox Guests = item.FindControl("txtGuests") as TextBox;
                TextBox GH = item.FindControl("txtGH") as TextBox;
                TextBox Staff = item.FindControl("txtStaff") as TextBox;
                TextBox Actual = item.FindControl("txtActual") as TextBox;
                TextBox Total = item.FindControl("txtTotal") as TextBox;
                Regular.Enabled = false;
                Casual.Enabled = false;
                HS.Enabled = false;
                Guests.Enabled = false;
                GH.Enabled = false;
                Staff.Enabled = false;
                Total.Enabled = false;
            }
            else if (dtDate.SelectedDate < DateTime.Now.Date && ds.Tables[0].Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Confirm", "PopUp2();", true);
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
            }
            else if (dtDate.SelectedDate < DateTime.Now.Date && ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Confirm", "PopUp3();", true);
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
                GridDataItem item = (GridDataItem)rgDinBkng.MasterTableView.Items[0];
                TextBox Regular = item.FindControl("txtRegular") as TextBox;
                TextBox Casual = item.FindControl("txtCasual") as TextBox;
                TextBox HS = item.FindControl("txtHS") as TextBox;
                TextBox Guests = item.FindControl("txtGuests") as TextBox;
                TextBox GH = item.FindControl("txtGH") as TextBox;
                TextBox Staff = item.FindControl("txtStaff") as TextBox;
                TextBox Actual = item.FindControl("txtActual") as TextBox;
                TextBox Total = item.FindControl("txtTotal") as TextBox;
                Regular.Enabled = false;
                Casual.Enabled = false;
                HS.Enabled = false;
                Guests.Enabled = false;
                GH.Enabled = false;
                Staff.Enabled = false;
                Total.Enabled = false;
            }
            else if (dtDate.SelectedDate > DateTime.Now.Date && ds.Tables[0].Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Confirm", "PopUp();", true);
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
            }
            else if (dtDate.SelectedDate > DateTime.Now.Date && ds.Tables[0].Rows.Count > 0)
            {
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Confirm", "PopUp();", true);
                rgDinBkng.DataSource = ds.Tables[0];
                rgDinBkng.DataBind();
                GridDataItem item = (GridDataItem)rgDinBkng.MasterTableView.Items[0];
                TextBox Actual = item.FindControl("txtActual") as TextBox;
                Actual.Enabled = false;
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_DiningBooking",
                      new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 },
                       new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                       new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = drpSession.SelectedValue }
                      );
            LoadData();
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void drpSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (drpSession.SelectedValue == "0")
            {

            }
            else
            {
                DataSet ds = sqlobj.ExecuteSP("SP_DiningBooking",
                  new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue.ToString() }
                  );
                DataSet dsHexCd = sqlobj.ExecuteSP("SP_HexCodeCalc",
                  new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Char, Value = drpSession.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate }
                  );
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lbltiming.Visible = true;
                    lblTime.Visible = true;
                    lblTime.Text = ds.Tables[0].Rows[0]["Time"].ToString() + " / ";
                }
                else
                {
                    lbltiming.Visible = false;
                    lblTime.Visible = false;
                    lblTime.Text = "";
                }
                if (dsHexCd.Tables[0].Rows.Count > 0)
                {
                    lblhexcode.Visible = true;
                    lblhexcode.Text = dsHexCd.Tables[0].Rows[0]["Code"].ToString();
                }
                else
                {
                    lblhexcode.Visible = false;
                    lblhexcode.Text = "";
                }
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void btnExShRpt_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ExcessShrtgeRpt.aspx");
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
}