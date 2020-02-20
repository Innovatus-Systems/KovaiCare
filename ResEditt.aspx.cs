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

public partial class ResEditt : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());  
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }       
        string RSN = Session["ResidentRSN"].ToString();
        if (!IsPostBack)
        {
            FileUpload fileUpload = new FileUpload();
            fileUpload = FileUpload1;
            //FileUpload1.Width = Unit.Pixel(15);
            DateTime Bday = Convert.ToDateTime(("01 / 01 / 1900").ToString());
            FromDate.MinDate = Bday;
            LoadVillaNo();         
            ddlvillano.Visible = false;
            Bloodgroup();
            //SMSAlert();
            //EmailAlert();
            Occupants();
            Gender();         
            Status();
            loadCustDet();
            LoadDiningRule();
            
            //LoadVillaStatus();
        }        
    }
    private void LoadVillaNo()
    {
        try
        {
            DataSet dsvillano = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            dsvillano = proc.ExecuteSP("SP_GetVillaNo",
                 new SqlParameter() { ParameterName = "@Mode", SqlDbType = SqlDbType.Int, Value = 1 });
            if (dsvillano.Tables[0].Rows.Count > 0)
            {
                ddlvillano.DataSource = dsvillano.Tables[0];
                ddlvillano.DataTextField = "status";
                ddlvillano.DataValueField = "DoorNo";
                ddlvillano.DataBind();
            }
            ddlvillano.Items.Insert(0, "--Select--");
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }  
    protected void LoadDiningRule()
    {
        try
        {
            DataSet dsDRule = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();
            dsDRule = proc.ExecuteSP("SP_General",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 31 });
            if (Convert.ToDecimal(dsDRule.Tables[0].Rows[0]["RatePerMeal"].ToString()) > 0)
            {
                //ImgBtnHelp.Visible = true;
                if (dsDRule.Tables[0].Rows.Count > 0)
                {
                    lblMealRate.Text = dsDRule.Tables[0].Rows[0]["RatePerMeal"].ToString();
                    lblNoMeals.Text = dsDRule.Tables[0].Rows[0]["NoofMealsPerDay"].ToString();
                    lblMinMeals.Text = dsDRule.Tables[0].Rows[0]["MinNoofMeals"].ToString();
                    lblRateExcep.Text = dsDRule.Tables[0].Rows[0]["RateException"].ToString();
                }
            }
            else
            {
                //ImgBtnHelp.Visible = false;
            }           
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }    
    }

    #region Load customer Details
    public void loadCustDet()
    {
        if (Session["ResidentRSN"].ToString() != "")
        {
           
            try
            {
                int RSN = Convert.ToInt32(Session["ResidentRSN"]);

                LoadVillaStatus(RSN); 
            
                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsSection = proc.ExecuteSP("SP_ResidentEditLink", new SqlParameter()
                {
                    ParameterName = "@RTRSN",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = RSN
                });

               

                RTName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                
                
                
                RTVILLANO.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();

                if (RTVILLANO.Text == "UnAsgnd")
                {
                    ddlvillano.SelectedValue = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                    RTVILLANO.Visible = false;
                    ddlvillano.Visible = true;
                    Session["PreviousDoorNo"] = "UnAsgnd";
                }
                else
                {
                    Session["PreviousDoorNo"] = RTVILLANO.Text;
                }


                ddlstatus.SelectedValue = dsSection.Tables[0].Rows[0]["RTStatus"].ToString();
                ddlgender.SelectedValue = dsSection.Tables[0].Rows[0]["Gender"].ToString();
                ddlMarital.SelectedValue = dsSection.Tables[0].Rows[0]["Marital_Status"].ToString();
                RTAddress1.Text = dsSection.Tables[0].Rows[0]["RTAddress1"].ToString();
                RTAddress2.Text = dsSection.Tables[0].Rows[0]["RTAddress2"].ToString();
                CityName.Text = dsSection.Tables[0].Rows[0]["CityName"].ToString();
                Pincode.Text = dsSection.Tables[0].Rows[0]["Pincode"].ToString();
                Country.Text = dsSection.Tables[0].Rows[0]["Country"].ToString();
                Contactno.Text = dsSection.Tables[0].Rows[0]["Contactno"].ToString();
                Contactcellno.Text = dsSection.Tables[0].Rows[0]["Contactcellno"].ToString();
                Contactmail.Text = dsSection.Tables[0].Rows[0]["Contactmail"].ToString();
                AlternateEMAILID.Text = dsSection.Tables[0].Rows[0]["AlternateEMAILID"].ToString();
                FromDate.SelectedDate = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"].ToString());
                ddlBloodgroup.SelectedValue = dsSection.Tables[0].Rows[0]["BloodGroup"].ToString();
                //ddlsmsalt.SelectedValue = dsSection.Tables[0].Rows[0]["SMSAlert"].ToString();
                //ddlemailalt.SelectedValue = dsSection.Tables[0].Rows[0]["EMAILAlert"].ToString();
                ddloccupants.SelectedValue = dsSection.Tables[0].Rows[0]["Occupants"].ToString();
                WatsApp.Text = dsSection.Tables[0].Rows[0]["WatsApp"].ToString();
                Facebook.Text = dsSection.Tables[0].Rows[0]["Facebook"].ToString();
                Skype.Text = dsSection.Tables[0].Rows[0]["Skype"].ToString();
                Remarks.Text = dsSection.Tables[0].Rows[0]["Remarks"].ToString();
                Cusimage.ImageUrl = dsSection.Tables[0].Rows[0]["Images"].ToString();
                TxtImge.Text = dsSection.Tables[0].Rows[0]["Images"].ToString();
                txtresidnetid.Text = RSN.ToString();
                txtDiningAutoDebit.Text = dsSection.Tables[0].Rows[0]["DiningAD"].ToString();
                txtServiceAutoDebit.Text = dsSection.Tables[0].Rows[0]["ServiceAD"].ToString();
                txtNC.Text = dsSection.Tables[0].Rows[0]["NursingAD"].ToString();

                ddlDAutoDebit.SelectedValue = dsSection.Tables[0].Rows[0]["DiningADFlag"].ToString();
                ddlSAutoDebit.SelectedValue = dsSection.Tables[0].Rows[0]["ServiceADFlag"].ToString();
                ddlNCAutoDebit.SelectedValue = dsSection.Tables[0].Rows[0]["NursingADFlag"].ToString();

                txtDepositAccNo.Text = dsSection.Tables[0].Rows[0]["GLDepositAccount"].ToString();
                txtGeneralAccNo.Text = dsSection.Tables[0].Rows[0]["GLAccount"].ToString();
                txtOffEmailId.Text= dsSection.Tables[0].Rows[0]["Off_Email"].ToString();
                txtOffMobNo.Text= dsSection.Tables[0].Rows[0]["Off_ContactNo"].ToString();
                RdOffDOB.SelectedDate=DateTime.Parse(dsSection.Tables[0].Rows[0]["Off_DOB"].ToString());
                if (txtOffMobNo.Text!=null && txtOffMobNo.Text!="" && txtOffEmailId.Text!=null && txtOffEmailId.Text!="" && RdOffDOB.SelectedDate!=null)
                {
                    chkSameDetails.Checked = true;
                }
                else
                {
                    chkSameDetails.Checked = false;
                }
                              
            }             
            catch( Exception ex)                
            {
               WebMsgBox.Show(ex.ToString());
            }
        }
        else
        {
            WebMsgBox.Show("There are some error in edit process.Try again!");
        }
    }
    #endregion

    private void LoadVillaStatus(int RSN)
    {
        try
        {
            

            DataSet dsDRule = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();

            dsDRule = proc.ExecuteSP("SP_FetchDoorNoStatus",
                 new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
                  new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = RSN });



            ddlDoorNoStatus.DataSource = dsDRule.Tables[0];
            ddlDoorNoStatus.DataValueField = "Value";
            ddlDoorNoStatus.DataTextField = "Value";
            ddlDoorNoStatus.DataBind();

            //if (dsDRule.Tables[1].Rows[0]["RTStatus"].ToString() == "OR" || dsDRule.Tables[1].Rows[0]["RTStatus"].ToString() == "T")
            //{
            //    ddlDoorNoStatus.Enabled = true;
            //}
            //else
            //{
            //    ddlDoorNoStatus.Enabled = false;
            //}
            ddlDoorNoStatus.Enabled = true;
            //if (dsDRule.Tables[1].Rows[0]["RTStatus"].ToString() == "TD" || dsDRule.Tables[1].Rows[0]["RTStatus"].ToString() == "ORD" || dsDRule.Tables[1].Rows[0]["RTStatus"].ToString() == "PTD" || dsDRule.Tables[1].Rows[0]["RTStatus"].ToString() == "OAD" || dsDRule.Tables[1].Rows[0]["RTStatus"].ToString() == "RSD" || dsDRule.Tables[1].Rows[0]["RTStatus"].ToString() == "TDA")
            //{
            //    ddlDoorNoStatus.Enabled = false;
            //}
            //else
            //{
            //    ddlDoorNoStatus.Enabled = true;
            //}

            //ddlDoorNoStatus.Items.Insert(0, new ListItem("--Select--", "0"));
            //ddlDoorNoStatus.SelectedIndex = 4;
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }


    #region Update Resident details(btnnUpdateRsnt_Click)

    protected void btnnUpdateRsnt_Click(object sender, EventArgs e)
    {
            {

                //string strPermission = Session["UserPermission"].ToString();

                //if (strPermission.ToString() == "Y")
                //{


                    SqlProcsNew sqlobj = new SqlProcsNew();

                    if (RTName.Text != String.Empty && (ddlgender.SelectedValue.ToString() != "0" || ddlgender.SelectedValue.ToString() != string.Empty) && (ddlMarital.SelectedValue.ToString() != "0" || ddlMarital.SelectedValue.ToString() != string.Empty)
                        && RTVILLANO.Text != string.Empty &&
                        (ddlstatus.SelectedValue.ToString() != "0" || ddlstatus.SelectedValue.ToString() != string.Empty) &&
                        RTAddress1.Text != string.Empty && CityName.Text != string.Empty && Pincode.Text != string.Empty &&
                        Country.Text != string.Empty &&
                        Contactcellno.Text != string.Empty  &&
                        (ddloccupants.SelectedValue.ToString() != "0" || ddloccupants.SelectedValue.ToString() != string.Empty))
                    {
                        try
                        {
                            string filename = Path.GetFileName(FileUpload1.FileName);
                            FileUpload1.SaveAs(Server.MapPath(@"~//Uploads/") + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename);

                            String File;
                            if (FileUpload1.PostedFile.FileName == String.Empty)
                            {
                                File = TxtImge.Text;

                            }
                            else
                            {
                                File = (@"~//Uploads/") + DateTime.Now.ToString("ddmmyyhhmmsss") + "_" + filename;
                            }

                            //FileUpd.SaveAs(Server.MapPath(@"~//Uploads") + "//" + filename);


                            string villano="";

                            if (RTVILLANO.Visible == true)
                            {
                                villano = RTVILLANO.Text;
                            }
                            else
                            {
                                villano = ddlvillano.SelectedValue.ToString();
                            }


                            int RSN = Convert.ToInt32(Session["ResidentRSN"]);

                            sqlobj.ExecuteSQLNonQuery("SP_UpdateResidentDtls",
                                   new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                                   new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = RSN },
                                               new SqlParameter() { ParameterName = "@RTName", SqlDbType = SqlDbType.NVarChar, Value = RTName.Text },
                                               new SqlParameter() { ParameterName = "@Gender", SqlDbType = SqlDbType.NVarChar, Value = ddlgender.SelectedValue.ToString() },
                                               new SqlParameter() { ParameterName = "@Marital", SqlDbType = SqlDbType.NVarChar, Value = ddlMarital.SelectedValue.ToString() },
                                               new SqlParameter() { ParameterName = "@RTVILLANO", SqlDbType = SqlDbType.NVarChar, Value = villano.ToString() },
                                               new SqlParameter() { ParameterName = "@PreviousDoorNo", SqlDbType = SqlDbType.NVarChar, Value = Session["PreviousDoorNo"].ToString() },
                                               new SqlParameter() { ParameterName = "@RTSTATUS", SqlDbType = SqlDbType.NVarChar, Value = ddlstatus.SelectedValue.ToString() },
                                               new SqlParameter() { ParameterName = "@RTAddress1", SqlDbType = SqlDbType.NVarChar, Value = RTAddress1.Text },
                                               new SqlParameter() { ParameterName = "@RTAddress2", SqlDbType = SqlDbType.NVarChar, Value = RTAddress2.Text },
                                               new SqlParameter() { ParameterName = "@CityName", SqlDbType = SqlDbType.NVarChar, Value = CityName.Text },
                                               new SqlParameter() { ParameterName = "@Pincode", SqlDbType = SqlDbType.NVarChar, Value = Pincode.Text },
                                               new SqlParameter() { ParameterName = "@Country", SqlDbType = SqlDbType.NVarChar, Value = Country.Text },
                                               new SqlParameter() { ParameterName = "@Contactno", SqlDbType = SqlDbType.NVarChar, Value = Contactno.Text },
                                               new SqlParameter() { ParameterName = "@Contactcellno", SqlDbType = SqlDbType.NVarChar, Value = Contactcellno.Text },
                                               new SqlParameter() { ParameterName = "@Contactmail", SqlDbType = SqlDbType.NVarChar, Value = Contactmail.Text },
                                               new SqlParameter() { ParameterName = "@AlternateEMAILID", SqlDbType = SqlDbType.NVarChar, Value = AlternateEMAILID.Text },
                                               new SqlParameter() { ParameterName = "@DOB", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = FromDate.SelectedDate.ToString() == "" ? null : FromDate.SelectedDate.ToString() },
                                               new SqlParameter() { ParameterName = "@BloodGroup", SqlDbType = SqlDbType.NVarChar, Value = ddlBloodgroup.SelectedValue.ToString() },
                                               new SqlParameter() { ParameterName = "@SMSAlert", SqlDbType = SqlDbType.NVarChar, Value = "y" },
                                               new SqlParameter() { ParameterName = "@EMAILAlert", SqlDbType = SqlDbType.NVarChar, Value = "y" },
                                               new SqlParameter() { ParameterName = "@Occupants", SqlDbType = SqlDbType.Decimal, Value = "0" },
                                               new SqlParameter() { ParameterName = "@DiningAD", SqlDbType = SqlDbType.Decimal, Value = txtDiningAutoDebit.Text == "" ? null : txtDiningAutoDebit.Text },
                                               new SqlParameter() { ParameterName = "@ServiceAD", SqlDbType = SqlDbType.Decimal, Value = txtServiceAutoDebit.Text == "" ? null : txtServiceAutoDebit.Text },
                                               new SqlParameter() { ParameterName = "@NursingAD", SqlDbType = SqlDbType.Decimal, Value = txtNC.Text == "" ? null : txtNC.Text },
                                               new SqlParameter() { ParameterName = "@WatsApp", SqlDbType = SqlDbType.NVarChar, Value = WatsApp.Text },
                                               new SqlParameter() { ParameterName = "@Facebook", SqlDbType = SqlDbType.NVarChar, Value = Facebook.Text },
                                               new SqlParameter() { ParameterName = "@Skype", SqlDbType = SqlDbType.NVarChar, Value = Skype.Text },
                                               new SqlParameter() { ParameterName = "@Remarks", SqlDbType = SqlDbType.NVarChar, Value = Remarks.Text },
                                               new SqlParameter() { ParameterName = "@Images", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = File },
                                               new SqlParameter() { ParameterName = "@ImagePath", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = "NULL" },                                                 
                                               new SqlParameter() { ParameterName = "@DiningADFlag", SqlDbType = SqlDbType.NVarChar, Value = ddlDAutoDebit.SelectedValue},                                             
                                               new SqlParameter() { ParameterName = "@ServiceADFlag", SqlDbType = SqlDbType.NVarChar, Value = ddlSAutoDebit.SelectedValue },
                                               new SqlParameter() { ParameterName = "@NursingADFlag", SqlDbType = SqlDbType.NVarChar, Value = ddlNCAutoDebit.SelectedValue },
                                               new SqlParameter() { ParameterName = "@DoorNoStatus", SqlDbType = SqlDbType.NVarChar, Value = ddlDoorNoStatus.SelectedValue },
                                               new SqlParameter() { ParameterName = "@OffDOB", SqlDbType = SqlDbType.DateTime, Direction = ParameterDirection.Input, Value = RdOffDOB.SelectedDate },
                                               new SqlParameter() { ParameterName = "@OffMobNo", SqlDbType = SqlDbType.NVarChar, Value = txtOffMobNo.Text },
                                               new SqlParameter() { ParameterName = "@OffEmailID", SqlDbType = SqlDbType.NVarChar, Value = txtOffEmailId.Text });
                                                
                            ClearScr();

                            
                        
                            
                            ClientScript.RegisterStartupScript(this.GetType(),"alert", " alert('Profile details Updated successfully.'); window.location='ResidentAdd.aspx';", true);


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
                //}
                //else
                //{
                //    WebMsgBox.Show("You have not permission to update the resident details");
                //}

            }
        }
        //else { 
        
        //}
   
        



    

    #endregion

   






    protected void btnnClear_Click(object sender, EventArgs e)
    {
        ClearScr();
    }
    protected void btnnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }

     #region Clear Screen

    protected void ClearScr()
    {
        Gender();
        Status();
        //SMSAlert();
        //EmailAlert();
        Occupants();
        Bloodgroup();
        RTName.Text = string.Empty;
        RTVILLANO.Text = string.Empty;
        RTAddress1.Text = string.Empty;
        RTAddress2.Text = string.Empty;
        CityName.Text = string.Empty;
        Pincode.Text = string.Empty;
        Country.Text = string.Empty;
        Contactno.Text = string.Empty;
        Contactcellno.Text = string.Empty;
        Contactmail.Text = string.Empty;
        AlternateEMAILID.Text = string.Empty;
        //BloodGroup.Text = string.Empty;
        WatsApp.Text = string.Empty;
        Facebook.Text = string.Empty;
        Skype.Text = string.Empty;
        Remarks.Text = string.Empty;
        Cusimage.ImageUrl = String.Empty;
        txtDiningAutoDebit.Text = "";
        txtServiceAutoDebit.Text = "";
        txtNC.Text = "";
        chkSameDetails.Checked = false;
        txtOffEmailId.Text = string.Empty;
        txtOffMobNo.Text = string.Empty;
        RdOffDOB.SelectedDate = null;

        this.RTVILLANO.Focus();

    }
    #endregion

     #region Cmb_DataBound
    protected void Cmb_DataBound(object sender, EventArgs e)
    {
        //var combo = (DropDownList)sender;
        //combo.Items.Insert(0, "-- Select --");
     
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
       
 


     #region Blood group Dropdown
    protected void Bloodgroup()
    {
        DataTable dt = new DataTable();
        dt.Clear();
        dt.Columns.Add("Code");
        dt.Columns.Add("Text");
        DataRow drow = dt.NewRow();
        drow["Code"] = "O +ve";
        drow["Text"] = "O +ve";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "O -ve";
        drow["Text"] = "O -ve";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "A +ve";
        drow["Text"] = "A +ve";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "A -ve";
        drow["Text"] = "A -ve";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "B +ve";
        drow["Text"] = "B +ve";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "B -ve";
        drow["Text"] = "B -ve";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "AB +ve";
        drow["Text"] = "AB +ve";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "AB -ve";
        drow["Text"] = "AB -ve";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "Rh";
        drow["Text"] = "Rh";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "ABO";
        drow["Text"] = "ABO";
        dt.Rows.Add(drow);
        ddlBloodgroup.DataSource = dt;
        ddlBloodgroup.DataTextField = dt.Columns["Text"].ToString();
        ddlBloodgroup.DataValueField = dt.Columns["Code"].ToString();
        ddlBloodgroup.DataBind();
    }
    #endregion

     #region SMS alert Dropdown
    //protected void SMSAlert()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Clear();
    //    dt.Columns.Add("Code");
    //    dt.Columns.Add("Text");
    //    DataRow drow = dt.NewRow();
    //    drow["Code"] = "y";
    //    drow["Text"] = "Yes";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "N";
    //    drow["Text"] = "No";
    //    dt.Rows.Add(drow);
    //    ddlsmsalt.DataSource = dt;
    //    ddlsmsalt.DataTextField = dt.Columns["Text"].ToString();
    //    ddlsmsalt.DataValueField = dt.Columns["Code"].ToString();
    //    ddlsmsalt.DataBind();
    //}
    #endregion
     #region Email alert dropdown

    //protected void EmailAlert()
    //{
    //    DataTable dt = new DataTable();
    //    dt.Clear();
    //    dt.Columns.Add("Code");
    //    dt.Columns.Add("Text");
    //    DataRow drow = dt.NewRow();
    //    drow["Code"] = "y";
    //    drow["Text"] = "Yes";
    //    dt.Rows.Add(drow);
    //    drow = dt.NewRow();
    //    drow["Code"] = "N";
    //    drow["Text"] = "No";
    //    dt.Rows.Add(drow);
    //    ddlemailalt.DataSource = dt;
    //    ddlemailalt.DataTextField = dt.Columns["Text"].ToString();
    //    ddlemailalt.DataValueField = dt.Columns["Code"].ToString();
    //    ddlemailalt.DataBind();
    //}
    #endregion
     #region Occupants Ddl

    protected void Occupants()
   {
       DataTable dt = new DataTable();
       dt.Clear();
       dt.Columns.Add("Code");
       dt.Columns.Add("Text");
       DataRow drow = dt.NewRow();
       drow["Code"] = "0";
       drow["Text"] = "0";
       dt.Rows.Add(drow);
       drow = dt.NewRow();
       drow["Code"] = "1";
       drow["Text"] = "1";
       dt.Rows.Add(drow);
       drow = dt.NewRow();
       drow["Code"] = "2";
       drow["Text"] = "2";
       dt.Rows.Add(drow);
       drow = dt.NewRow();
       drow["Code"] = "3";
       drow["Text"] = "3";
       dt.Rows.Add(drow);
       drow = dt.NewRow();
       drow["Code"] = "4";
       drow["Text"] = "4";
       dt.Rows.Add(drow);
       drow = dt.NewRow();
       drow["Code"] = "5";
       drow["Text"] = "5";
       dt.Rows.Add(drow);
       ddloccupants.DataSource = dt;
       ddloccupants.DataTextField = dt.Columns["Text"].ToString();
       ddloccupants.DataValueField = dt.Columns["Code"].ToString();
       ddloccupants.DataBind();
   }
   #endregion

    #region Gender dropdown
    protected void Gender()
    {
        DataTable dt = new DataTable();
        dt.Clear();
        dt.Columns.Add("Code");
        dt.Columns.Add("Text");
        DataRow drow = dt.NewRow();
        drow["Code"] = "Male";
        drow["Text"] = "Male";
        dt.Rows.Add(drow);
        drow = dt.NewRow();
        drow["Code"] = "Female";
        drow["Text"] = "Female";
        dt.Rows.Add(drow);

        ddlgender.DataSource = dt;
        ddlgender.DataTextField = dt.Columns["Text"].ToString();
        ddlgender.DataValueField = dt.Columns["Code"].ToString();
        ddlgender.DataBind();
    }
    #endregion

  

    protected void ImgBtnHelp_Click(object sender,EventArgs e)
    {
        rwPopup.VisibleOnPageLoad = true;
        rwPopup.Visible = true;
    }



    protected void chkSameDetails_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkSameDetails.Checked == true)
            {
                txtOffEmailId.Text = Contactmail.Text;
                txtOffMobNo.Text = Contactcellno.Text;
                RdOffDOB.SelectedDate = FromDate.SelectedDate;
            }
            else
            {
                txtOffEmailId.Text = "";
                txtOffMobNo.Text = "";
                RdOffDOB.SelectedDate = null;
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void lnkClear_Click(object sender, EventArgs e)
    {
        try { RdOffDOB.SelectedDate = null; }
        catch(Exception ex) { WebMsgBox.Show(ex.Message); }
    }
}