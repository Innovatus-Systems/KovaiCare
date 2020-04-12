using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Confirmation : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();
    public DataTable dt;
    public DataTable dtct;
    public string HexCode = "";
    public string DRate = "";
    public string GRate = "";
    public string HRate = "";
    static string SessCd = "";
    public decimal DCTax;
    public decimal DSTax;
    public decimal GCTax;
    public decimal GSTax;
    public decimal HCTax;
    public decimal HSTax;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (IsPostBack && ViewState["dt"] == null)
        {
            ViewState["Count"] = 0;
            dt = new DataTable();
            dt.Columns.Add(new DataColumn("RSN", typeof(Int32)));
            dt.Columns.Add(new DataColumn("Date", typeof(string)));
            dt.Columns.Add(new DataColumn("DoorNo", typeof(string)));
            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Narration", typeof(string)));
            dt.Columns.Add(new DataColumn("Diners", typeof(Int32)));
            dt.Columns.Add(new DataColumn("Guests", typeof(Int32)));
            dt.Columns.Add(new DataColumn("HomeDly", typeof(Int32)));
            dt.Columns.Add(new DataColumn("Total", typeof(Int32)));
            dt.Columns.Add(new DataColumn("Amount", typeof(string)));
            dt.Columns.Add(new DataColumn("TXAmount", typeof(decimal)));
            dt.Columns.Add(new DataColumn("CGST", typeof(decimal)));
            dt.Columns.Add(new DataColumn("SGST", typeof(decimal)));
            dt.Columns.Add(new DataColumn("Account", typeof(string)));
            dt.Columns.Add(new DataColumn("RTRSN", typeof(string)));
            dt.Columns.Add(new DataColumn("HexCode", typeof(string)));
            dt.Columns.Add(new DataColumn("DEVICE", typeof(string)));
            glTransactions.DataSource = string.Empty;
            glTransactions.DataBind();
        }
        else
        {
            dt = (DataTable)ViewState["dt"];
        }
        if (!IsPostBack)
        {
            dtDate.SelectedDate = DateTime.Now;
            dtDate.MaxDate = DateTime.Now;
            //LoadSession();
            chkSplSess_CheckedChanged(sender, e);
            LoadResident();
            LoadDinNts();
            LoadTitle();
            LoadHelp();
            btnPost.Visible = false;
            rgConfir.DataSource = string.Empty;
            rgConfir.DataBind();
            glTransactions.DataSource = string.Empty;
            glTransactions.DataBind();
            rdCount.DataSource = string.Empty;
            rdCount.DataBind();
        }
    }
    private void LoadHelp()
    {
        try
        {
            lblMsg.Visible = true;
            DataSet dsTxn = sqlobj.ExecuteSP("SP_TxnDropDownList",
                new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
               new SqlParameter() { ParameterName = "@TxnCode", SqlDbType = SqlDbType.NVarChar, Value = "DI" });
            if (dsTxn.Tables[0].Rows.Count > 0)
            {
                string msg = dsTxn.Tables[0].Rows[0]["StdDescription"].ToString();
                string CGST = dsTxn.Tables[0].Rows[0]["CGST"].ToString();
                string SGST = dsTxn.Tables[0].Rows[0]["SGST"].ToString();
                string code = dsTxn.Tables[0].Rows[0]["TxnCode"].ToString();
                string All = msg + " - " + code + "  - " + "CGST %:- " + CGST + "  - " + "SGST %:- " + SGST;
                lblMsg.Text = All;
            }
            dsTxn.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadSession()
    {

        DataSet dsFetchSE = new DataSet();
        try
        {
            dsFetchSE = sqlobj.ExecuteSP("SP_ConfirmDinersSessionFilter",
                new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate.Value });
            drpSession.DataSource = dsFetchSE.Tables[0];
            drpSession.DataValueField = "SCode";
            drpSession.DataTextField = "SName";
            drpSession.DataBind();
            drpSession.Items.Insert(0, new ListItem("--Select--", "0"));
            dsFetchSE.Dispose();

            //dsFetchSE = sqlobj.ExecuteSP("SP_GetSessionforDining",
            //    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2});
            //drpSession.DataSource = dsFetchSE.Tables[0];
            //drpSession.DataValueField = "SessionCode";
            //drpSession.DataTextField = "SessionName";
            //drpSession.DataBind();
            //drpSession.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", "0"));
            //dsFetchSE.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    private void LoadsplSession()
    {

        DataSet dsFetchSE = new DataSet();
        try
        {
            dsFetchSE = sqlobj.ExecuteSP("SP_ConfirmDinersSessionFilter");
            drpSession.DataSource = dsFetchSE.Tables[0];
            drpSession.DataValueField = "SCode";
            drpSession.DataTextField = "SName";
            drpSession.DataBind();
            drpSession.Items.Insert(0, new ListItem("--Select--", "0"));
            dsFetchSE.Dispose();
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
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 153 });
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
    private void LoadPrevBkng()
    {
        try
        {
            DataSet ds = sqlobj.ExecuteSP("SP_DiningBooking",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 6 },
                     new SqlParameter() { ParameterName = "@Date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                     new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Decimal, Value = drpSession.SelectedValue }
                    );
            if (ds.Tables[0].Rows.Count > 0)
            {
                rdCount.DataSource = ds.Tables[0];
                rdCount.DataBind();
            }
            else
            {
                rdCount.DataSource = string.Empty;
                rdCount.DataBind();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }

    private void LoadResident()
    {
        DataSet dsResd = new DataSet();
        try
        {
            if (chkFrmApp.Checked == true)
            {

                dtDate.SelectedDate = DateTime.Now;
                dtDate.Enabled = false;
                rgConfir.Visible = false;
                rdCount.Visible = false;
                rgDinNts.Visible = false;
                drpName.Enabled = false;
                ViewState["DEVICE"] = "M";
                //LoadSession();


                dsResd = sqlobj.ExecuteSP("SP_GenDropDownList",
                new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 18 },
                new SqlParameter() { ParameterName = "@DinedDate", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                new SqlParameter() { ParameterName = "@DinedSession", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue.ToString() });
            }
            else
            {
                dtDate.Enabled = true;
                rgConfir.Visible = true;
                rdCount.Visible = true;
                rgDinNts.Visible = true;
                drpName.Enabled = true;
                ViewState["DEVICE"] = "W";


                dsResd = sqlobj.ExecuteSP("SP_GenDropDownList",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 16 });
            }
            drpName.DataSource = dsResd.Tables[0];
            drpName.DataValueField = "RTRSN";
            drpName.DataTextField = "RName";
            drpName.DataBind();
            RadComboBoxItem item3 = new RadComboBoxItem();
            item3.Text = "--Select Resident--";
            item3.Value = "0";
            item3.Selected = true;
            drpName.Items.Add(item3);
            //drpName.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select Resident--", "0"));
            dsResd.Dispose();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    private void LoadResident2()
    {
        DataSet dsResd = new DataSet();
        try
        {
            if (chkFrmApp.Checked == true)
            {

                //************
                //dsResd = sqlobj.ExecuteSP("SP_GenDropDownList",
                //new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 17 },
                //new SqlParameter() { ParameterName = "@HEXCODE", SqlDbType = SqlDbType.NVarChar, Value = ViewState["HexCd"] });

                dsResd = sqlobj.ExecuteSP("SP_GenDropDownList",
                new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 18 },
                //new SqlParameter() { ParameterName = "@HEXCODE", SqlDbType = SqlDbType.NVarChar, Value = ViewState["HexCd"] },
                new SqlParameter() { ParameterName = "@DinedDate", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                new SqlParameter() { ParameterName = "@DinedSession", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue.ToString() });
            }
            else
            {
                dsResd = sqlobj.ExecuteSP("SP_GenDropDownList",
                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 16 });
            }
            drpName.DataSource = dsResd.Tables[0];
            drpName.DataValueField = "RTRSN";
            drpName.DataTextField = "RName";
            drpName.DataBind();
            RadComboBoxItem item3 = new RadComboBoxItem();
            item3.Text = "--Select Resident--";
            item3.Value = "0";
            item3.Selected = true;
            drpName.Items.Add(item3);
            //drpName.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select Resident--", "0"));
            dsResd.Dispose();
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }




    private void LoadDinNts()
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

    protected void drpSession_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if (drpSession.SelectedValue == "0")
            {
                lbltiming.Visible = false;
                lblTime.Visible = false;
                lblhexcode.Visible = false;
                drpName.SelectedValue = "0";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Session and select Resident.');", true);
                return;
            }
            else
            {
                glTransactions.DataSource = string.Empty;
                glTransactions.DataBind();

                btnPost.Visible = false;
                LoadResident();

                LoadPrevBkng();
                //chkFrmApp.Checked = false;
                drpName.SelectedValue = "0";
                lblRDetails.Visible = false;
                rgConfir.DataSource = string.Empty;
                rgConfir.DataBind();
                DataSet ds = sqlobj.ExecuteSP("SP_DiningBooking",
                  new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 },
                    new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue.ToString() }
                  );
                DataSet dsHexCd = sqlobj.ExecuteSP("SP_HexCodeCalc",
                  new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Char, Value = drpSession.SelectedValue.ToString() },
                    new SqlParameter() { ParameterName = "@date", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate }
                  );
                if (ds.Tables[1].Rows.Count > 0)
                {
                    ViewState["SessCd"] = ds.Tables[1].Rows[0]["SName"].ToString();
                }
                else
                {
                    ViewState["SessCd"] = "";
                }
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
                    ViewState["HexCd"] = dsHexCd.Tables[0].Rows[0]["Code"].ToString();
                    HexCode = dsHexCd.Tables[0].Rows[0]["Code"].ToString();
                    lblhexcode.Text = dsHexCd.Tables[0].Rows[0]["Code"].ToString();
                }
                else
                {
                    lblhexcode.Visible = false;
                    lblhexcode.Text = "";
                }
                DataSet dsRate = sqlobj.ExecuteSP("DConfirmation",
                                  new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 },
                                    new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Char, Value = drpSession.SelectedValue.ToString() });

                if (dsRate.Tables[0].Rows.Count > 0)
                {
                    lblDRate.Text = dsRate.Tables[0].Rows[0]["RegularRate"].ToString();
                    DRate = dsRate.Tables[0].Rows[0]["RegularRate"].ToString();
                    lblGRate.Text = dsRate.Tables[0].Rows[0]["GuestRate"].ToString();
                    GRate = dsRate.Tables[0].Rows[0]["GuestRate"].ToString();
                    lblHRate.Text = dsRate.Tables[0].Rows[0]["HomeService"].ToString();
                    HRate = dsRate.Tables[0].Rows[0]["HomeService"].ToString();
                    //DTax = Convert.ToDecimal(dsRate.Tables[0].Rows[0]["RegularRate"].ToString());
                }
                else
                {
                    lblDRate.Text = "0.00";
                    lblGRate.Text = "0.00";
                    lblHRate.Text = "0.00";
                }

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void drpName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if (drpName.SelectedValue == "0")
            {
                lbltiming.Visible = false;
                lblTime.Visible = false;
                lblhexcode.Visible = false;
                lblRDetails.Visible = false;
                drpName.SelectedValue = "0";
                rgConfir.DataSource = string.Empty;
                rgConfir.DataBind();
                return;
            }
            StringBuilder str = new StringBuilder();
            if (drpSession.SelectedValue == "0")
            {
                lbltiming.Visible = false;
                lblTime.Visible = false;
                lblhexcode.Visible = false;
                drpName.SelectedValue = "0";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Session and select Resident.');", true);
                return;
            }
            else
            {
                rgConfir.DataSource = string.Empty;
                rgConfir.DataBind();
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (dt.Rows[i]["RTRSN"].ToString() == drpName.SelectedValue && dt.Rows[i]["HexCode"].ToString() == lblhexcode.Text)
                        {
                            drpName.SelectedValue = "0";
                            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('You have already saved the information in the grid for this particular date and session for the selected resident.');", true);
                            return;
                        }
                    }

                }

                DataSet ds = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 2 },
                      new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() },
                      new SqlParameter() { ParameterName = "@TXREFNO", SqlDbType = SqlDbType.NVarChar, Value = lblhexcode.Text });
                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    btnPost.Visible = true;
                    drpName.SelectedValue = "0";
                    lblRDetails.Visible = false;
                    rgConfir.DataSource = string.Empty;
                    rgConfir.DataBind();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('You have already done the confirmation for this particular date and session for the selected resident.');", true);
                    return;
                }
                else
                {
                    DataSet dsGrid = new DataSet();
                    if (chkFrmApp.Checked == true)
                    {
                        //***************
                        //dsGrid = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 8 },
                        // new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() },
                        // new SqlParameter() { ParameterName = "@TXREFNO", SqlDbType = SqlDbType.NVarChar, Value = lblhexcode.Text });
                        //ViewState["DEVICE"] = "M";

                        dsGrid = sqlobj.ExecuteSP("DConfirmation",
                             new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 10 },
                             new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() },
                             new SqlParameter() { ParameterName = "@DinedDate", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                             new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Char, Value = drpSession.SelectedValue.ToString() });

                        ViewState["DEVICE"] = "M";
                    }
                    else
                    {
                        dsGrid = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
                         new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() });
                        ViewState["DEVICE"] = "W";
                    }

                    if (dsGrid.Tables[0].Rows.Count > 0)
                    {
                        dtct = dsGrid.Tables[0];
                        btnPost.Visible = false;
                        rgConfir.DataSource = dsGrid.Tables[0];
                        rgConfir.DataBind();
                        ddlDiners_TextChanged(sender, e);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('No Data.');", true);
                        return;
                    }
                }
                string diff;
                GridDataItem item = (GridDataItem)rgConfir.MasterTableView.Items[0];
                TextBox ddlBooked = (TextBox)item.FindControl("ddlDiners");
                TextBox ddlGuestBooked = (TextBox)item.FindControl("ddlGuest");
                TextBox ddlHomeService = (TextBox)item.FindControl("ddlHomeDly");
                if (Convert.ToInt32(dtct.Rows[0]["Diners"].ToString()) < Convert.ToInt32(ddlBooked.Text))
                {
                    diff = (Convert.ToInt32(ddlBooked.Text) - Convert.ToInt32(dtct.Rows[0]["Diners"].ToString())).ToString();
                    ddlGuestBooked.Text = (Convert.ToInt32(diff) + Convert.ToInt32(ddlGuestBooked.Text)).ToString();
                }
                ddlBooked.Focus();
                if (drpSession.SelectedValue == "0")
                {
                    drpName.SelectedValue = "0";
                    lblRDetails.Visible = false;
                    rgConfir.DataSource = string.Empty;
                    rgConfir.DataBind();
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Session.');", true);
                    return;
                }

                if (drpName.SelectedValue != "0")
                {
                    DataSet dsDetails = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() });

                    if (dsDetails.Tables[0].Rows.Count > 0)
                    {
                        if (dsDetails.Tables[1].Rows.Count > 0)
                        {
                            foreach (DataRow row in dsDetails.Tables[1].Rows)
                            {
                                str.Append("" + row["RTNAME"] + " , ");
                            }
                            str.Remove(str.Length - 2, 2);
                        }
                        lblRDetails.Visible = true;
                        Session["Account"] = dsDetails.Tables[0].Rows[0]["GLAccount"].ToString();
                        int CntRegl = Convert.ToInt32(dsDetails.Tables[2].Rows[0]["Dflag"].ToString());
                        if (dsDetails.Tables[0].Rows[0]["DinStatus"].ToString() == "Regular")
                        {
                            ddlBooked.Enabled = true;
                            lblRDetails.Text = dsDetails.Tables[0].Rows[0]["DinStatus"].ToString() + " - " + dsDetails.Tables[0].Rows[0]["GLAccount"].ToString() + " - " + str.ToString();
                        }
                        else
                        {
                            ddlBooked.Enabled = false;
                            //ddlGuestBooked.Text =(Convert.ToInt32(ddlGuestBooked.Text) + Convert.ToInt32(ddlBooked.Text)).ToString();
                            //ddlBooked.Text = "0";
                            ddlDiners_TextChanged(sender, e);
                            lblRDetails.Text = dsDetails.Tables[0].Rows[0]["GLAccount"].ToString() + " - " + str.ToString();
                        }

                    }
                    else
                    {
                        lblRDetails.Visible = false;
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Resident, And Try Again.');", true);
                        return;
                    }
                }

            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            if (chkFrmApp.Checked == true)
            {
                DataSet dsResd = new DataSet();
                dsResd = sqlobj.ExecuteSP("SP_GenDropDownList",
                new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 18 },
                new SqlParameter() { ParameterName = "@DinedDate", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                new SqlParameter() { ParameterName = "@DinedSession", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue.ToString() });


                //glTransactions.DataSource = string.Empty;
                //glTransactions.DataBind();

                //ViewState["dt"] = string.Empty;

                if (dsResd.Tables[0].Rows.Count > 0)
                {


                    for (int i = 0; i < dsResd.Tables[0].Rows.Count; i++)
                    {
                        DataSet dsGrid = new DataSet();
                        //DRate = lblDRate.Text;
                        //GRate = lblGRate.Text;
                        //HRate = lblHRate.Text;
                        //GridDataItem item = (GridDataItem)rgConfir.MasterTableView.Items[0];

                        dsGrid = sqlobj.ExecuteSP("DConfirmation",
                            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 10 },
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = dsResd.Tables[0].Rows[i]["RTRSN"].ToString() },
                            new SqlParameter() { ParameterName = "@DinedDate", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
                            new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Char, Value = drpSession.SelectedValue.ToString() });

                        string MAddlBooked = dsGrid.Tables[0].Rows[0]["Diners"].ToString();
                        string MAlGuestBooked = dsGrid.Tables[0].Rows[0]["Guest"].ToString();
                        string MAddlHomeService = dsGrid.Tables[0].Rows[0]["HS"].ToString();

                        DRate = dsGrid.Tables[1].Rows[0]["RegularRate"].ToString();
                        GRate = dsGrid.Tables[1].Rows[0]["GuestRate"].ToString();
                        HRate = dsGrid.Tables[1].Rows[0]["HomeService"].ToString();

                        if (MAddlBooked == "" || MAddlBooked == null)
                            MAddlBooked = "0";
                        if (MAlGuestBooked == "" || MAlGuestBooked == null)
                            MAlGuestBooked = "0";
                        if (MAddlHomeService == "" || MAddlHomeService == null)
                            MAddlHomeService = "0";


                        decimal Gt = Convert.ToDecimal(MAlGuestBooked);
                        decimal Bk = Convert.ToDecimal(MAddlBooked);
                        decimal Hd = Convert.ToDecimal(MAddlHomeService);
                        decimal BkGt = Convert.ToDecimal(Convert.ToDecimal(MAddlBooked) + Convert.ToDecimal(MAlGuestBooked));


                        DataSet ds = sqlobj.ExecuteSP("DConfirmation",
                            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 5 },
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = dsResd.Tables[0].Rows[i]["RTRSN"].ToString() });
                        DataSet dsTxnCd = sqlobj.ExecuteSP("DConfirmation",
                            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 6 },
                            new SqlParameter() { ParameterName = "@TxnCd", SqlDbType = SqlDbType.NVarChar, Value = "DI" });


                        if (dsTxnCd.Tables[0].Rows.Count > 0)
                        {
                            decimal CGST = Convert.ToDecimal(dsTxnCd.Tables[0].Rows[0]["CGST_PCNT"].ToString());
                            decimal SGST = Convert.ToDecimal(dsTxnCd.Tables[0].Rows[0]["SGST_PCNT"].ToString());

                            DCTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (CGST / 100)).ToString("F"));
                            GCTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (CGST / 100)).ToString("F"));
                            HCTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (CGST / 100)).ToString("F"));

                            DSTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (SGST / 100)).ToString("F"));
                            GSTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (SGST / 100)).ToString("F"));
                            HSTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (SGST / 100)).ToString("F"));

                        }

                        decimal amount = Convert.ToDecimal((Convert.ToDecimal(MAddlBooked) * Convert.ToDecimal(DRate)) + (Convert.ToDecimal(MAlGuestBooked) * Convert.ToDecimal(GRate)) + (Convert.ToDecimal(MAddlHomeService) * (Convert.ToDecimal(HRate) + Convert.ToDecimal(DRate))));
                        decimal CGSTPCNT = Convert.ToDecimal((Convert.ToDecimal(MAddlBooked) * Convert.ToDecimal(DCTax)) + (Convert.ToDecimal(MAlGuestBooked) * Convert.ToDecimal(GCTax)) + (Convert.ToDecimal(MAddlHomeService) * Convert.ToDecimal(HCTax)));
                        decimal SGSTPCNT = Convert.ToDecimal((Convert.ToDecimal(MAddlBooked) * Convert.ToDecimal(DSTax)) + (Convert.ToDecimal(MAlGuestBooked) * Convert.ToDecimal(GSTax)) + (Convert.ToDecimal(MAddlHomeService) * Convert.ToDecimal(HSTax)));
                        decimal amount2 = amount + CGSTPCNT + SGSTPCNT;

                        ViewState["RTRSN"] = dsResd.Tables[0].Rows[i]["RTRSN"].ToString();
                        DataRow dr = dt.NewRow();
                        ViewState["Count"] = Convert.ToInt32(ViewState["Count"]) + 1;
                        string date = Convert.ToString(Convert.ToDateTime(dtDate.SelectedDate).ToString("dd"));
                        string Sess = ViewState["SessCd"].ToString();


                        int rowcount = Convert.ToInt32(ViewState["Count"]);
                        dr["RSN"] = rowcount;
                        dr["Date"] = Convert.ToDateTime(dtDate.SelectedDate).ToString("dd-MMM-yyyy");
                        dr["DoorNo"] = ds.Tables[0].Rows[0]["RTVillaNo"].ToString();
                        dr["Name"] = ds.Tables[0].Rows[0]["RTNAME"].ToString();
                        dr["Narration"] = date + "-" + Sess + "#" + "R" + MAddlBooked + "/" + "G" + MAlGuestBooked + "/" + "H" + MAddlHomeService;
                        dr["Diners"] = Convert.ToDecimal(MAddlBooked);
                        dr["Guests"] = Convert.ToDecimal(MAlGuestBooked);
                        dr["HomeDly"] = Convert.ToDecimal(MAddlHomeService);
                        dr["Total"] = (Convert.ToDecimal(MAddlBooked) + Convert.ToDecimal(MAlGuestBooked) + Convert.ToDecimal(MAddlHomeService));
                        //dr["Amount"] = lblTotal.Text;
                        dr["Amount"] = amount2;
                        dr["TXAmount"] = amount;
                        dr["CGST"] = CGSTPCNT;
                        dr["SGST"] = SGSTPCNT;
                        dr["Account"] = Session["Account"];
                        dr["RTRSN"] = ViewState["RTRSN"];
                        dr["HexCode"] = ViewState["HexCd"];
                        ViewState["DEVICE"] = "M";
                        dr["DEVICE"] = ViewState["DEVICE"];

                        dt.Rows.Add(dr);
                        ViewState["dt"] = dt;



                    }

                    glTransactions.DataSource = ViewState["dt"];
                    glTransactions.DataBind();


                    if (glTransactions.Items.Count > 0)
                    {
                        btnPost.Visible = true;
                        btnSave.Enabled = false;
                    }
                    else
                    {
                        btnPost.Visible = false;
                        btnSave.Enabled = true;
                    }

                    WebMsgBox.Show("Confirmation details saved in grid, Don't forget to post the transaction.");

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('There are no diners for the selected session and date.');", true);
                    return;
                }

            }
            else
            {
                if (lblTotal.Text == "-")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please check entries.');", true);
                    return;
                }
                if (drpSession.SelectedValue == "0" || dtDate.SelectedDate == null)
                {
                    lbltiming.Visible = false;
                    lblTime.Visible = false;
                    lblhexcode.Visible = false;
                    drpName.SelectedValue = "0";
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Date and Session.');", true);
                    return;
                }
                if (drpName.SelectedValue == "0")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please Select Resident.');", true);
                    return;
                }
                DRate = lblDRate.Text;
                GRate = lblGRate.Text;
                HRate = lblHRate.Text;
                GridDataItem item = (GridDataItem)rgConfir.MasterTableView.Items[0];
                TextBox ddlBooked = (TextBox)item.FindControl("ddlDiners");
                TextBox ddlGuestBooked = (TextBox)item.FindControl("ddlGuest");
                TextBox ddlHomeService = (TextBox)item.FindControl("ddlHomeDly");

                decimal Gt = Convert.ToDecimal(ddlGuestBooked.Text);
                decimal Bk = Convert.ToDecimal(ddlBooked.Text);
                decimal Hd = Convert.ToDecimal(ddlHomeService.Text);
                decimal BkGt = Convert.ToDecimal(Convert.ToDecimal(ddlBooked.Text) + Convert.ToDecimal(ddlGuestBooked.Text));
                if (Bk == 0 && Gt == 0 && Hd == 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('All Zeros??');", true);
                    return;
                }
                if (Bk == 0 && Gt == 0 && Hd > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Oops! How many diner?');", true);
                    return;
                }
                if (Bk == 0 && Gt > 0)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Only Guest ?? No resident?');", true);
                }
                if (BkGt < Hd)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Check home delivery count!!');", true);
                    return;
                }
                if ((Bk + Gt) < Hd)
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Home delivery count is greater then the count of (Diners + Casuals/Guests).');", true);
                    return;
                }
                DataSet ds = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 5 },
                                    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() });
                DataSet dsTxnCd = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 6 },
                                            new SqlParameter() { ParameterName = "@TxnCd", SqlDbType = SqlDbType.NVarChar, Value = "DI" });
                //DataSet dsSess= sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 9 },
                //                           new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue.ToString() });
                if (dsTxnCd.Tables[0].Rows.Count > 0)
                {
                    decimal CGST = Convert.ToDecimal(dsTxnCd.Tables[0].Rows[0]["CGST_PCNT"].ToString());
                    decimal SGST = Convert.ToDecimal(dsTxnCd.Tables[0].Rows[0]["SGST_PCNT"].ToString());

                    DCTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (CGST / 100)).ToString("F"));
                    GCTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (CGST / 100)).ToString("F"));
                    HCTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (CGST / 100)).ToString("F"));

                    DSTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (SGST / 100)).ToString("F"));
                    GSTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (SGST / 100)).ToString("F"));
                    HSTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (SGST / 100)).ToString("F"));

                }

                decimal amount = Convert.ToDecimal((Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DRate)) + (Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GRate)) + (Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HRate)));
                decimal CGSTPCNT = Convert.ToDecimal((Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DCTax)) + (Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GCTax)) + (Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HCTax)));
                decimal SGSTPCNT = Convert.ToDecimal((Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DSTax)) + (Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GSTax)) + (Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HSTax)));
                ViewState["RTRSN"] = drpName.SelectedValue.ToString();
                DataRow dr = dt.NewRow();
                ViewState["Count"] = Convert.ToInt32(ViewState["Count"]) + 1;
                string date = Convert.ToString(Convert.ToDateTime(dtDate.SelectedDate).ToString("dd"));
                string Sess = ViewState["SessCd"].ToString();
                //if (dsSess.Tables[0].Rows.Count>0)
                //{ Sess = dsSess.Tables[0].Rows[0]["SName"].ToString(); }       

                int rowcount = Convert.ToInt32(ViewState["Count"]);
                dr["RSN"] = rowcount;
                dr["Date"] = Convert.ToDateTime(dtDate.SelectedDate).ToString("dd-MMM-yyyy");
                dr["DoorNo"] = ds.Tables[0].Rows[0]["RTVillaNo"].ToString();
                dr["Name"] = ds.Tables[0].Rows[0]["RTNAME"].ToString();
                dr["Narration"] = date + "-" + Sess + "#" + "R" + ddlBooked.Text + "/" + "G" + ddlGuestBooked.Text + "/" + "H" + ddlHomeService.Text;
                dr["Diners"] = Convert.ToDecimal(ddlBooked.Text);
                dr["Guests"] = Convert.ToDecimal(ddlGuestBooked.Text);
                dr["HomeDly"] = Convert.ToDecimal(ddlHomeService.Text);
                dr["Total"] = (Convert.ToDecimal(ddlBooked.Text) + Convert.ToDecimal(ddlGuestBooked.Text));
                dr["Amount"] = lblTotal.Text;
                dr["TXAmount"] = amount;
                dr["CGST"] = CGSTPCNT;
                dr["SGST"] = SGSTPCNT;
                dr["Account"] = Session["Account"];
                dr["RTRSN"] = ViewState["RTRSN"];
                dr["HexCode"] = ViewState["HexCd"];
                dr["DEVICE"] = ViewState["DEVICE"];

                dt.Rows.Add(dr);
                ViewState["dt"] = dt;
                glTransactions.DataSource = dt;
                glTransactions.DataBind();
                WebMsgBox.Show("Confirmation details saved in grid, Don't forget to post the transaction.");
                //dtDate.SelectedDate = DateTime.Now;
                //drpSession.SelectedValue = "0";
                drpName.SelectedValue = "0";
                dtDate.Enabled = false;
                drpSession.Enabled = false;
                lblRDetails.Visible = false;
                //lblhexcode.Visible = false;
                //lblDRate.Text = "-";
                lblDCalc.Text = "-";
                lblDTol.Text = "-";
                //lblGRate.Text = "-";
                lblGCalc.Text = "-";
                lblGTol.Text = "-";
                //lblHRate.Text = "-";
                lblHCalc.Text = "-";
                lblHTol.Text = "-";
                lblTotal.Text = "-";
                //lbltiming.Visible = false;
                //lblTime.Visible = false;
                //lblhexcode.Visible = false;
                rgConfir.DataSource = string.Empty;
                rgConfir.DataBind();
                if (glTransactions.Items.Count > 0 && rgConfir.Items.Count == 0)
                {
                    btnPost.Visible = true;
                }
                else
                {
                    btnPost.Visible = false;
                }
            }



        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        drpName.SelectedValue = "0";
        lblRDetails.Visible = false;
        // lblDRate.Text = "-";
        lblDCalc.Text = "-";
        lblDTol.Text = "-";
        //lblGRate.Text = "-";
        lblGCalc.Text = "-";
        lblGTol.Text = "-";
        // lblHRate.Text = "-";
        lblHCalc.Text = "-";
        lblHTol.Text = "-";
        lblTotal.Text = "-";
        rgConfir.DataSource = string.Empty;
        rgConfir.DataBind();
        //LoadSession();
        //dtDate.SelectedDate = DateTime.Now;
        //drpSession.SelectedValue = "0";
        //lbltiming.Visible = false;
        //lblTime.Visible = false;
        //lblhexcode.Visible = false;
        //dtDate.Enabled = true;
        //drpSession.Enabled = true;      

        rgConfir.Visible = true;
        rdCount.Visible = true;
        rgDinNts.Visible = true;
        drpName.Enabled = true;
        btnSave.Enabled = true;


    }
    protected void btnPost_Click(object sender, EventArgs e)
    {
        try
        {
            if (dt.Rows.Count == 0)
            {
                WebMsgBox.Show("Please post some transaction and try again.");
                return;
            }
            string Count = Convert.ToString(dt.Rows.Count);
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DateTime bdate = DateTime.Now;
                    string strday = bdate.ToString("dd");
                    string strmonth = bdate.ToString("MM");
                    string stryear = bdate.ToString("yyyy");
                    string strhour = bdate.ToString("HH");
                    string strmin = bdate.ToString("mm");
                    string strsec = bdate.ToString("ss");
                    string strBillNo = stryear.ToString() + strmonth.ToString() + strday.ToString() + strhour.ToString() + strmin.ToString() + strsec.ToString();
                    string billwtCnt = strBillNo + "_" + Count + (i + 1);
                    string Accountcode = dt.Rows[i]["Account"].ToString();
                    string Name = dt.Rows[i]["Name"].ToString();
                    string DoorNo = dt.Rows[i]["DoorNo"].ToString();
                    string Date = dt.Rows[i]["Date"].ToString();
                    string Amount = dt.Rows[i]["TXAmount"].ToString();
                    string CGST = dt.Rows[i]["CGST"].ToString();
                    string SGST = dt.Rows[i]["SGST"].ToString();
                    string narration = dt.Rows[i]["Narration"].ToString();
                    string RTRSN = dt.Rows[i]["RTRSN"].ToString();
                    string HexCode = dt.Rows[i]["HexCode"].ToString();
                    string device = dt.Rows[i]["DEVICE"].ToString();
                    string reg = dt.Rows[i]["Diners"].ToString();
                    string gst = dt.Rows[i]["Guests"].ToString();
                    string hd = dt.Rows[i]["HomeDly"].ToString();
                    DataSet dsRSN = sqlobj.ExecuteSP("SP_InsertDiningTxnPosting",
                            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(RTRSN) },
                            new SqlParameter() { ParameterName = "@BGroup", SqlDbType = SqlDbType.NVarChar, Value = "DI" },
                            new SqlParameter() { ParameterName = "@BCategory", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                            new SqlParameter() { ParameterName = "@TAmount", SqlDbType = SqlDbType.Decimal, Value = Amount },
                            new SqlParameter() { ParameterName = "@CGST", SqlDbType = SqlDbType.Decimal, Value = CGST },
                            new SqlParameter() { ParameterName = "@SGST", SqlDbType = SqlDbType.Decimal, Value = SGST },
                            new SqlParameter() { ParameterName = "@TNarration", SqlDbType = SqlDbType.NVarChar, Value = narration },
                            new SqlParameter() { ParameterName = "@BillNo", SqlDbType = SqlDbType.NVarChar, Value = strBillNo.ToString() },
                            new SqlParameter() { ParameterName = "@Status", SqlDbType = SqlDbType.NVarChar, Value = "N" },
                            new SqlParameter() { ParameterName = "@AccountType", SqlDbType = SqlDbType.NVarChar, Value = "R" },
                            new SqlParameter() { ParameterName = "@BillingPeriod", SqlDbType = SqlDbType.NVarChar, Value = Session["CurrentBillingPeriod"].ToString() },
                            new SqlParameter() { ParameterName = "@EntryBy", SqlDbType = SqlDbType.NVarChar, Value = Session["UserID"].ToString() },
                            new SqlParameter() { ParameterName = "@AccountCode", SqlDbType = SqlDbType.NVarChar, Value = Accountcode },
                            new SqlParameter() { ParameterName = "@TXRefNo", SqlDbType = SqlDbType.NVarChar, Value = HexCode.ToString() },
                            new SqlParameter() { ParameterName = "@DEVICE", SqlDbType = SqlDbType.NVarChar, Value = device.ToString() },
                            new SqlParameter() { ParameterName = "@REG", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(reg) },
                           new SqlParameter() { ParameterName = "@GST", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(gst) },
                           new SqlParameter() { ParameterName = "@HD", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(hd) },
                           new SqlParameter() { ParameterName = "@DATE", SqlDbType = SqlDbType.Date, Value = dtDate.SelectedDate },
                           new SqlParameter() { ParameterName = "@DinedSession", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue }
                            );

                    DataSet dsUpdateTotalCount = sqlobj.ExecuteSP("SP_UPDATEDINERSCOUNT",
                           new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Decimal, Value = 1 },
                           new SqlParameter() { ParameterName = "@DATE", SqlDbType = SqlDbType.Date, Value = dtDate.SelectedDate },
                           new SqlParameter() { ParameterName = "@SESSION", SqlDbType = SqlDbType.NVarChar, Value = drpSession.SelectedValue },
                           new SqlParameter() { ParameterName = "@REG", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(reg) },
                           new SqlParameter() { ParameterName = "@GST", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(gst) },
                           new SqlParameter() { ParameterName = "@HD", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(hd) }
                           );
                }
                chkFrmApp.Checked = false;
                btnPost.Visible = false;
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Confirmation Done.');", true);
                LoadPrevBkng();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please post some transaction and try again.');", true);
                return;
            }
            drpName.SelectedValue = "0";
            lblRDetails.Visible = false;
            lblDRate.Text = "-";
            lblGRate.Text = "-";
            lblHRate.Text = "-";
            lblDCalc.Text = "-";
            lblDTol.Text = "-";
            lblGCalc.Text = "-";
            lblGTol.Text = "-";
            lblHCalc.Text = "-";
            lblHTol.Text = "-";
            lblTotal.Text = "-";
            lbltiming.Visible = false;
            lblTime.Visible = false;
            lblhexcode.Visible = false;
            dtDate.Enabled = true;
            drpSession.Enabled = true;
            drpSession.SelectedValue = "0";
            dtDate.SelectedDate = DateTime.Now;
            rgConfir.DataSource = string.Empty;
            rgConfir.DataBind();
            glTransactions.DataSource = string.Empty;
            glTransactions.DataBind();

            btnSave.Enabled = true;
            btnPost.Visible = false;

            dt.Clear();

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);

        }
    }
    protected void lblEdit_Click(object sender, EventArgs e)
    {

        try
        {
            LinkButton lkBtn = (LinkButton)sender;
            GridDataItem grditm = (GridDataItem)lkBtn.NamingContainer;
            string RSN = grditm.Cells[3].Text.ToString();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["RSN"].ToString() == RSN)
                {
                    dt.Rows[i].Delete();
                    dt.AcceptChanges();
                }
            }
            glTransactions.DataSource = dt;
            glTransactions.DataBind();

        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('" + ex.Message.ToString() + "');", true);
        }
    }
    protected void dtDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        string date = DateTime.Now.Date.ToString();
        if (dtDate.SelectedDate < Convert.ToDateTime(date))
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('You have selected past date.');", true);
        }
        drpName.SelectedValue = "0";
        lblRDetails.Visible = false;
        rgConfir.DataSource = string.Empty;
        rgConfir.DataBind();
        LoadSession();
    }
    protected void ddlDiners_TextChanged(object sender, EventArgs e)
    {
        DRate = lblDRate.Text;
        GRate = lblGRate.Text;
        HRate = lblHRate.Text;
        DataSet dsTax = sqlobj.ExecuteSP("DConfirmation",
                               new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 6 },
                                 new SqlParameter() { ParameterName = "@TxnCd", SqlDbType = SqlDbType.Char, Value = "DI" });
        if (dsTax.Tables[0].Rows.Count > 0)
        {
            decimal CGST = Convert.ToDecimal(dsTax.Tables[0].Rows[0]["CGST_PCNT"].ToString());
            decimal SGST = Convert.ToDecimal(dsTax.Tables[0].Rows[0]["SGST_PCNT"].ToString());

            DCTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (CGST / 100)).ToString("F"));
            GCTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (CGST / 100)).ToString("F"));
            HCTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (CGST / 100)).ToString("F"));

            DSTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (SGST / 100)).ToString("F"));
            GSTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (SGST / 100)).ToString("F"));
            HSTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (SGST / 100)).ToString("F"));

        }

        GridDataItem item = (GridDataItem)rgConfir.MasterTableView.Items[0];
        TextBox ddlBooked = (TextBox)item.FindControl("ddlDiners");
        TextBox ddlGuestBooked = (TextBox)item.FindControl("ddlGuest");
        TextBox ddlHomeService = (TextBox)item.FindControl("ddlHomeDly");
        if (ddlBooked.Text == "")
        {
            ddlBooked.Text = "0";
        }
        if (ddlGuestBooked.Text == "")
        {
            ddlGuestBooked.Text = "0";
        }
        if (ddlHomeService.Text == "")
        {
            ddlHomeService.Text = "0";
        }
        DataSet dsGrid;
        if (chkFrmApp.Checked == true)
        {
            //***************
            //dsGrid = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 8 },
            //  new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() },
            //  new SqlParameter() { ParameterName = "@TXREFNO", SqlDbType = SqlDbType.NVarChar, Value = lblhexcode.Text });
            // ViewState["DEVICE"] = "M";

            dsGrid = sqlobj.ExecuteSP("DConfirmation",
            new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 10 },
            new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() },
            new SqlParameter() { ParameterName = "@DinedDate", SqlDbType = SqlDbType.DateTime, Value = dtDate.SelectedDate },
            new SqlParameter() { ParameterName = "@Session", SqlDbType = SqlDbType.Char, Value = drpSession.SelectedValue.ToString() });
            ViewState["DEVICE"] = "M";
        }
        else
        {
            dsGrid = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
             new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() });
            ViewState["DEVICE"] = "W";
        }
        string diff;
        if (Convert.ToInt32(dsGrid.Tables[0].Rows[0]["Diners"].ToString()) < Convert.ToInt32(ddlBooked.Text))
        {
            diff = (Convert.ToInt32(ddlBooked.Text) - Convert.ToInt32(dsGrid.Tables[0].Rows[0]["Diners"].ToString())).ToString();
            ddlBooked.Text = Convert.ToString(dsGrid.Tables[0].Rows[0]["Diners"].ToString());
            ddlGuestBooked.Text = (Convert.ToInt32(diff) + Convert.ToInt32(ddlGuestBooked.Text)).ToString();
        }
        //lblDCalc.Text = ddlBooked.Text + " X " + DRate + " = ";
        //lblGCalc.Text = ddlGuestBooked.Text + " X " + GRate + " = ";
        //lblHCalc.Text = ddlHomeService.Text + " X " + HRate + " = ";
        lblDTol.Text = Convert.ToString((Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DRate)) + (Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DCTax)) + (Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DSTax)));
        lblGTol.Text = Convert.ToString((Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GRate)) + (Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GCTax)) + (Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GSTax)));
        lblHTol.Text = Convert.ToString((Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HRate)) + (Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HCTax)) + (Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HSTax)));
        lblTotal.Text = Convert.ToString(Convert.ToDecimal(lblDTol.Text) + Convert.ToDecimal(lblGTol.Text) + Convert.ToDecimal(lblHTol.Text));
        ddlGuestBooked.Focus();
    }

    protected void ddlGuest_TextChanged(object sender, EventArgs e)
    {
        DRate = lblDRate.Text;
        GRate = lblGRate.Text;
        HRate = lblHRate.Text;
        DataSet dsTax = sqlobj.ExecuteSP("DConfirmation",
                               new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 6 },
                                 new SqlParameter() { ParameterName = "@TxnCd", SqlDbType = SqlDbType.Char, Value = "DI" });
        if (dsTax.Tables[0].Rows.Count > 0)
        {
            decimal CGST = Convert.ToDecimal(dsTax.Tables[0].Rows[0]["CGST_PCNT"].ToString());
            decimal SGST = Convert.ToDecimal(dsTax.Tables[0].Rows[0]["SGST_PCNT"].ToString());

            DCTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (CGST / 100)).ToString("F"));
            GCTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (CGST / 100)).ToString("F"));
            HCTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (CGST / 100)).ToString("F"));

            DSTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (SGST / 100)).ToString("F"));
            GSTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (SGST / 100)).ToString("F"));
            HSTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (SGST / 100)).ToString("F"));

        }
        GridDataItem item = (GridDataItem)rgConfir.MasterTableView.Items[0];
        TextBox ddlBooked = (TextBox)item.FindControl("ddlDiners");
        TextBox ddlGuestBooked = (TextBox)item.FindControl("ddlGuest");
        TextBox ddlHomeService = (TextBox)item.FindControl("ddlHomeDly");
        if (ddlBooked.Text == "")
        {
            ddlBooked.Text = "0";
        }
        if (ddlGuestBooked.Text == "")
        {
            ddlGuestBooked.Text = "0";
        }
        if (ddlHomeService.Text == "")
        {
            ddlHomeService.Text = "0";
        }
        if (Convert.ToDecimal(ddlGuestBooked.Text) > 10)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Guest count is more then 10.Please Check the count.Not allow to enter more then 10 count.');", true);
            ddlGuestBooked.Text = "0";
            return;
        }
        DataSet dsGrid;
        if (chkFrmApp.Checked == true)
        {

            dsGrid = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 8 },
              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() },
              new SqlParameter() { ParameterName = "@TXREFNO", SqlDbType = SqlDbType.NVarChar, Value = lblhexcode.Text });
            ViewState["DEVICE"] = "M";
        }
        else
        {
            dsGrid = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
             new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() });
            ViewState["DEVICE"] = "W";
        }
        string diff;
        if (Convert.ToInt32(dsGrid.Tables[0].Rows[0]["Diners"].ToString()) < Convert.ToInt32(ddlBooked.Text))
        {
            diff = (Convert.ToInt32(ddlBooked.Text) - Convert.ToInt32(dsGrid.Tables[0].Rows[0]["Diners"].ToString())).ToString();
            ddlGuestBooked.Text = (Convert.ToInt32(diff) + Convert.ToInt32(ddlGuestBooked.Text)).ToString();
        }

        //lblDCalc.Text = ddlBooked.Text + " X " + DRate + " = ";
        //lblGCalc.Text = ddlGuestBooked.Text + " X " + GRate + " = ";
        //lblHCalc.Text = ddlHomeService.Text + " X " + HRate + " = ";
        lblDTol.Text = Convert.ToString((Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DRate)) + (Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DCTax)) + (Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DSTax)));
        lblGTol.Text = Convert.ToString((Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GRate)) + (Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GCTax)) + (Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GSTax)));
        lblHTol.Text = Convert.ToString((Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HRate)) + (Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HCTax)) + (Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HSTax)));
        lblTotal.Text = Convert.ToString(Convert.ToDecimal(lblDTol.Text) + Convert.ToDecimal(lblGTol.Text) + Convert.ToDecimal(lblHTol.Text));
        decimal Gt = Convert.ToDecimal(ddlGuestBooked.Text);
        decimal Bk = Convert.ToDecimal(ddlBooked.Text);
        if (Bk == 0 && Gt > 0)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Only Guest ?? No diners!!');", true);
            return;
        }
        ddlHomeService.Focus();
    }
    protected void ddlHomeDly_TextChanged(object sender, EventArgs e)
    {
        DRate = lblDRate.Text;
        GRate = lblGRate.Text;
        HRate = lblHRate.Text;
        DataSet dsTax = sqlobj.ExecuteSP("DConfirmation",
                               new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 6 },
                                 new SqlParameter() { ParameterName = "@TxnCd", SqlDbType = SqlDbType.Char, Value = "DI" });
        if (dsTax.Tables[0].Rows.Count > 0)
        {
            decimal CGST = Convert.ToDecimal(dsTax.Tables[0].Rows[0]["CGST_PCNT"].ToString());
            decimal SGST = Convert.ToDecimal(dsTax.Tables[0].Rows[0]["SGST_PCNT"].ToString());

            DCTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (CGST / 100)).ToString("F"));
            GCTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (CGST / 100)).ToString("F"));
            HCTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (CGST / 100)).ToString("F"));

            DSTax = Convert.ToDecimal((Convert.ToDecimal(DRate) * (SGST / 100)).ToString("F"));
            GSTax = Convert.ToDecimal((Convert.ToDecimal(GRate) * (SGST / 100)).ToString("F"));
            HSTax = Convert.ToDecimal((Convert.ToDecimal(HRate) * (SGST / 100)).ToString("F"));

        }
        GridDataItem item = (GridDataItem)rgConfir.MasterTableView.Items[0];
        TextBox ddlBooked = (TextBox)item.FindControl("ddlDiners");
        TextBox ddlGuestBooked = (TextBox)item.FindControl("ddlGuest");
        TextBox ddlHomeService = (TextBox)item.FindControl("ddlHomeDly");
        if (ddlBooked.Text == "")
        {
            ddlBooked.Text = "0";
        }
        if (ddlGuestBooked.Text == "")
        {
            ddlGuestBooked.Text = "0";
        }
        if (ddlHomeService.Text == "")
        {
            ddlHomeService.Text = "0";
        }
        DataSet dsGrid;
        if (chkFrmApp.Checked == true)
        {

            dsGrid = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 8 },
              new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() },
              new SqlParameter() { ParameterName = "@TXREFNO", SqlDbType = SqlDbType.NVarChar, Value = lblhexcode.Text });
            ViewState["DEVICE"] = "M";
        }
        else
        {
            dsGrid = sqlobj.ExecuteSP("DConfirmation", new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 3 },
             new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.NVarChar, Value = drpName.SelectedValue.ToString() });
            ViewState["DEVICE"] = "W";
        }
        string diff;
        if (Convert.ToInt32(dsGrid.Tables[0].Rows[0]["Diners"].ToString()) < Convert.ToInt32(ddlBooked.Text))
        {
            diff = (Convert.ToInt32(ddlBooked.Text) - Convert.ToInt32(dsGrid.Tables[0].Rows[0]["Diners"].ToString())).ToString();
            ddlGuestBooked.Text = (Convert.ToInt32(diff) + Convert.ToInt32(ddlGuestBooked.Text)).ToString();
        }
        //lblDCalc.Text = ddlBooked.Text + " X " + DRate + " = ";
        //lblGCalc.Text = ddlGuestBooked.Text + " X " + GRate + " = ";
        //lblHCalc.Text = ddlHomeService.Text + " X " + HRate + " = ";
        lblDTol.Text = Convert.ToString((Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DRate)) + (Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DCTax)) + (Convert.ToDecimal(ddlBooked.Text) * Convert.ToDecimal(DSTax)));
        lblGTol.Text = Convert.ToString((Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GRate)) + (Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GCTax)) + (Convert.ToDecimal(ddlGuestBooked.Text) * Convert.ToDecimal(GSTax)));
        lblHTol.Text = Convert.ToString((Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HRate)) + (Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HCTax)) + (Convert.ToDecimal(ddlHomeService.Text) * Convert.ToDecimal(HSTax)));
        lblTotal.Text = Convert.ToString(Convert.ToDecimal(lblDTol.Text) + Convert.ToDecimal(lblGTol.Text) + Convert.ToDecimal(lblHTol.Text));
        decimal Gt = Convert.ToDecimal(ddlGuestBooked.Text);
        decimal Bk = Convert.ToDecimal(ddlBooked.Text);
        decimal Hd = Convert.ToDecimal(ddlHomeService.Text);
        if (Bk == 0 && Gt == 0 && Hd > 0)
        {
            lblTotal.Text = "0.00";
            ddlHomeService.Text = "0";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Oops! How many diner?');", true);
            return;
        }
    }
    protected void chkFrmApp_CheckedChanged(object sender, EventArgs e)
    {
        if (drpSession.SelectedValue == "0")
        {
            chkFrmApp.Checked = false;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Please select Session and select resident.');", true);
            return;
        }
        else
        {
            LoadResident();
        }

    }

    protected void chkSplSess_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkSplSess.Checked == true)
            {
                LoadsplSession();
            }
            if (chkSplSess.Checked == false)
            {
                LoadSession();
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "alert", "alert('Something went wong with SPL. Session.');", true);
        }
    }

    protected void lnkFandB_Click(object sender, EventArgs e)
    {
        Response.Redirect("FandBLedger.aspx");
    }

    protected void lnkDinersList_Click(object sender, EventArgs e)
    {
        Response.Redirect("MobAppDinersList.aspx");
    }
}