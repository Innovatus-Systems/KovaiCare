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

public partial class AttributeEdit : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        //string RSN = Session["RARSN"].ToString();
        int RSN = Convert.ToInt32(Session["RARSN"]);
        if (!IsPostBack)
        {
            Status();
            loadCustDet();
            RAGroupDropdown();
            RACodeDropdown();
            ddlstatus.Enabled = false;
        }
    }
    public void loadCustDet()
    {
        if (Session["RARSN"].ToString() != "")
        {
            try
            {
                int RSN = Convert.ToInt32(Session["RARSN"]);
                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();
                dsSection = proc.ExecuteSP("SP_AttributeEdit", new SqlParameter()
                {
                    ParameterName = "@RARSN",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = RSN
                });
                //DateTime Dtime= Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"]);
                string DOB = dsSection.Tables[0].Rows[0]["DOB"].ToString();
                if (DOB != null && DOB != "")
                {
                    FromDate.SelectedDate = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"].ToString());
                }
                else
                {
                    FromDate.SelectedDate = null;
                }
                string Date = dsSection.Tables[0].Rows[0]["RADate"].ToString();
                if (Date != null && Date != "")
                {
                    RADate.SelectedDate = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["RADate"].ToString());
                }
                else
                {
                    RADate.SelectedDate = null;
                }
                string grp = dsSection.Tables[0].Rows[0]["RAGroup"].ToString();
                TxtRTRSN.Text = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();
                TxtRTVILLANO.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                ddlstatus.SelectedValue = dsSection.Tables[0].Rows[0]["RTStatus"].ToString();
                TxtRTName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                ddlGroup.SelectedValue = dsSection.Tables[0].Rows[0]["RAGroup"].ToString();
                //ddlpriority.SelectedValue = dsSection.Tables[0].Rows[0]["Priority"].ToString();
                ddlRACode.SelectedValue = dsSection.Tables[0].Rows[0]["RACode"].ToString();
                RAText.Text = dsSection.Tables[0].Rows[0]["RAText"].ToString();
                ddlpriority.SelectedValue = dsSection.Tables[0].Rows[0]["Priority"].ToString();
                //FromDate.SelectedDate = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"].ToString());
                RAValue.Text = dsSection.Tables[0].Rows[0]["RAValue"].ToString();
                //RADate.SelectedDate = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["RADate"].ToString());
                RAContactNo.Text = dsSection.Tables[0].Rows[0]["RAContactNo"].ToString();
                RAEmailId.Text = dsSection.Tables[0].Rows[0]["RAEmailId"].ToString();
                RARemarks.Text = dsSection.Tables[0].Rows[0]["RARemarks"].ToString();
                ddlPopup.SelectedValue = dsSection.Tables[0].Rows[0]["IsPopupFlag"].ToString();

            }


            catch (Exception ex)
            {
                WebMsgBox.Show("There are some error in edit process.Try again!");
            }

        }

        else
        {
            WebMsgBox.Show("There are some error in edit process.Try again!");
        }

    }
    //#region LoadResident (ie) Load the resident details in dropdown
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
    //#endregion

    //#region Group
    //protected void Group()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Clear();
    //    dt.Columns.Add("Code");
    //    dt.Columns.Add("Text");
    //    DataRow drow = dt.NewRow();
    //    drow["Code"] = "Family";
    //    drow["Text"] = "Family";
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
    //    drow["Code"] = "ICE";
    //    drow["Text"] = "Incase of emergency";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "OCPNCY";
    //    drow["Text"] = "Occupancy";
    //    dt.Rows.Add(drow);
    //    ddlGroup.DataSource = dt;
    //    ddlGroup.DataTextField = dt.Columns["Text"].ToString();
    //    ddlGroup.DataValueField = dt.Columns["Code"].ToString();
    //    ddlGroup.DataBind();
    //}
    //#endregion
    //#region Priority
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
    //#endregion

    //Load Group for Group Dropdown
    protected void RAGroupDropdown()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SP_GetLKUPOne", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 2;
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            DataSet dsGrid = new DataSet();
            ad.Fill(dsGrid);
            ddlGroup.DataSource = dsGrid;
            ddlGroup.DataValueField = "RAGROUP";
            ddlGroup.DataTextField = "RAGROUP";
            ddlGroup.DataBind();
            //ddlGroup.Items.Insert(0, new ListItem("--Select Group--", "0"));
        }
        catch (Exception ex)
        {

        }



    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        SqlProcsNew sqlobj = new SqlProcsNew();

        if (TxtRTVILLANO.Text != "0" && TxtRTVILLANO.Text != String.Empty && ddlGroup.SelectedValue != "0")
        {
            int RSN = Convert.ToInt32(Session["RARSN"]);
            try
            {
                //string DOB = FromDate.SelectedDate.ToString();
                ////DateTime frdate;

                //if (DOB != null && DOB != "")
                //{
                //    DOB = FromDate.SelectedDate.ToString();

                //}
                //else
                //{
                //    DOB = null;
                //} 
                //string Date = RADate.SelectedDate.ToString();


                //if (Date != null && Date != "")
                //{
                //    Date = RADate.SelectedDate.ToString();

                //}
                //else
                //{
                //    Date = null;
                //}


                sqlobj.ExecuteSQLNonQuery("SP_UpdateAttributesDtls",
                                   new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                                   new SqlParameter() { ParameterName = "@RARSN", SqlDbType = SqlDbType.Int, Value = RSN },
                                   new SqlParameter() { ParameterName = "@RTVILLANO", SqlDbType = SqlDbType.NVarChar, Value = TxtRTVILLANO.Text },
                                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = TxtRTRSN.Text },
                                   new SqlParameter() { ParameterName = "@RTSTATUS", SqlDbType = SqlDbType.NVarChar, Value = ddlstatus.SelectedValue.ToString() },
                                   new SqlParameter() { ParameterName = "@RTName", SqlDbType = SqlDbType.NVarChar, Value = TxtRTName.Text },
                                   new SqlParameter() { ParameterName = "@RACode", SqlDbType = SqlDbType.NVarChar, Value = ddlRACode.SelectedValue.ToString() },
                                   new SqlParameter() { ParameterName = "@RAText", SqlDbType = SqlDbType.NVarChar, Value = RAText.Text },
                                   new SqlParameter() { ParameterName = "@RAValue", SqlDbType = SqlDbType.Decimal, Value = Convert.ToDecimal(RAValue.Text.ToString() == "" ? null : RAValue.Text.ToString()) },
                                   new SqlParameter() { ParameterName = "@RADOB", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = FromDate.SelectedDate.ToString() == "" ? null : FromDate.SelectedDate.ToString() },
                                   new SqlParameter() { ParameterName = "@RADate", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = RADate.SelectedDate.ToString() == "" ? null : RADate.SelectedDate.ToString() },
                                   new SqlParameter() { ParameterName = "@RAContactNo", SqlDbType = SqlDbType.NVarChar, Value = RAContactNo.Text },
                                   new SqlParameter() { ParameterName = "@RAEmailId", SqlDbType = SqlDbType.NVarChar, Value = RAEmailId.Text },
                                   new SqlParameter() { ParameterName = "@RARemarks", SqlDbType = SqlDbType.NVarChar, Value = RARemarks.Text },
                                   new SqlParameter() { ParameterName = "@Priority", SqlDbType = SqlDbType.NVarChar, Value = ddlpriority.SelectedValue.ToString() },
                                   new SqlParameter() { ParameterName = "@RAGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlGroup.SelectedValue.ToString() },
                                   new SqlParameter() { ParameterName = "@IsPopupFlag", SqlDbType = SqlDbType.NVarChar, Value = ddlPopup.SelectedValue }
                                   );


                WebMsgBox.Show("Additional detail's Updated successfully.");
                ClearScr();
                Response.Redirect("AttributesAdd.aspx");
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.Message.ToString());
            }
        }
        else
        {
            WebMsgBox.Show("Please enter mandatory field");
        }

    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("AttributesAdd.aspx");
    }
    protected void Cmb_DataBound(object sender, EventArgs e)
    {
        var combo = (DropDownList)sender;
        combo.Items.Insert(0, "-- Select --");
    }


    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if (ddlGroup.SelectedValue != "0" && ddlGroup.SelectedValue != "")
            {

                SqlCommand cmd = new SqlCommand("SP_GetLKUPOne", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 3;
                cmd.Parameters.Add("@GroupCode", SqlDbType.NVarChar).Value = ddlGroup.SelectedValue;
                SqlDataAdapter ad = new SqlDataAdapter(cmd);
                DataSet dsGrid = new DataSet();
                ad.Fill(dsGrid);
                ddlRACode.DataSource = dsGrid;
                ddlRACode.DataValueField = "RACode";
                ddlRACode.DataTextField = "RADROPDOWN";
                ddlRACode.DataBind();
            }

        }
        catch (Exception ex)
        {

        }

    }


    protected void RACodeDropdown()
    {
        try
        {
            if (ddlGroup.SelectedItem.Text != "0" && ddlGroup.SelectedItem.Text != "")
            {
                SqlCommand cmd = new SqlCommand("SP_GetLKUPOne", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 3;
                cmd.Parameters.Add("@GroupCode", SqlDbType.NVarChar).Value = ddlGroup.SelectedValue;
                SqlDataAdapter ad = new SqlDataAdapter(cmd);
                DataSet dsGrid = new DataSet();
                ad.Fill(dsGrid);
                ddlRACode.DataSource = dsGrid;
                ddlRACode.DataValueField = "RACode";
                ddlRACode.DataTextField = "RADROPDOWN";
                ddlRACode.DataBind();
            }
        }
        catch (Exception ex)
        {

        }



    }
    #region Clear Screen
    protected void ClearScr()
    {
        //LoadAttribLookup();
        //LoadResident();
        //Group();
        //Priority();
        //RACode.Text = string.Empty;
        RAText.Text = string.Empty;
        RAValue.Text = string.Empty;
        RAContactNo.Text = string.Empty;
        RAEmailId.Text = string.Empty;
        RARemarks.Text = string.Empty;
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
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 3 });
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

}