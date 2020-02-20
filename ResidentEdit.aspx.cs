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
using System.Text;

public partial class ResidentEdit : System.Web.UI.Page
{

    SqlProcsNew sqlobj = new SqlProcsNew();
    protected void Page_Load(object sender, EventArgs e)
    {


        rwDoorNoDet.VisibleOnPageLoad = false;
        if (!IsPostBack)
        {

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            string CustomerRSN = Session["CustRSN"].ToString();
            ScrClear();
            loadCustDet();
            LoadKeyInfoGrid();
            LoadAddInfoGrid();
            LoadDiningRule();
            LoadGrid2();

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



    public void loadCustDet()
    {
        if (Session["CustRSN"] != "")
        {

            try
            {              

                int CustomerRSN = Convert.ToInt32(Session["CustRSN"]);

                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsSection = proc.ExecuteSP("SP_ResidentProfile", new SqlParameter()
                {
                    ParameterName = "@RTRSN",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = CustomerRSN
                });               

                lblPhone.Text = dsSection.Tables[0].Rows[0]["Contactno"].ToString();
                lblMobileNo.Text = dsSection.Tables[0].Rows[0]["Contactcellno"].ToString();
                lblEmailID.Text = dsSection.Tables[0].Rows[0]["Contactmail"].ToString();
                lblEmailID2.Text = dsSection.Tables[0].Rows[0]["AlternateEMAILID"].ToString();
                lblAddress1.Text = dsSection.Tables[0].Rows[0]["RTAddress1"].ToString();
                lblAddress2.Text = dsSection.Tables[0].Rows[0]["RTAddress2"].ToString();
                lblCity.Text = dsSection.Tables[0].Rows[0]["CityName"].ToString();
                lblPinCode.Text = dsSection.Tables[0].Rows[0]["Pincode"].ToString();
                lblCountry.Text = dsSection.Tables[0].Rows[0]["Country"].ToString();               
                lblOccupants.Text = dsSection.Tables[3].Rows[0]["Occupants"].ToString(); 
                lblBloodGroup.Text = dsSection.Tables[0].Rows[0]["BloodGroup"].ToString();
                lblGender.Text = dsSection.Tables[0].Rows[0]["Gender"].ToString();               
                lblMStatus.Text = dsSection.Tables[0].Rows[0]["Marital_Status"].ToString();
                lblForDining.Text = dsSection.Tables[0].Rows[0]["DiningAd"].ToString();
                lblForHousKeeping.Text = dsSection.Tables[0].Rows[0]["ServiceAD"].ToString();
                lblRemarks.Text = dsSection.Tables[0].Rows[0]["Remarks"].ToString();
                Custrimage.ImageUrl = @dsSection.Tables[0].Rows[0]["Images"].ToString();

                lblDoorNo.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                lblDoorNo2.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                lblDoorNo3.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                lblName.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                lblName2.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                lblName3.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                lblInternalID.Text = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();
                lblInternalID2.Text = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();
                lblInternalID3.Text = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();
                lblDoorNoStatus.Text = dsSection.Tables[0].Rows[0]["VMStatus"].ToString();
                lblDoorNoStatus2.Text = dsSection.Tables[0].Rows[0]["VMStatus"].ToString();
                lblDoorNoStatus3.Text = dsSection.Tables[0].Rows[0]["VMStatus"].ToString();
                lblResidentType.Text = dsSection.Tables[0].Rows[0]["RType"].ToString();
                lblResidentType2.Text = dsSection.Tables[0].Rows[0]["RType"].ToString();
                lblResidentType3.Text = dsSection.Tables[0].Rows[0]["RType"].ToString();


                if (dsSection.Tables[0].Rows[0]["DOB"].ToString() != string.Empty && dsSection.Tables[0].Rows[0]["DOB"].ToString() != "" && dsSection.Tables[0].Rows[0]["DOB"].ToString() != null)
                    lblDOB.Text = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"].ToString()).ToString("ddd") + "   " + Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"].ToString()).ToString("dd-MMM-yyyy") + " (" + dsSection.Tables[0].Rows[0]["Age"].ToString() + ")"; ;

                if ((dsSection.Tables[0].Rows[0]["Country"].ToString()).ToLower() != "india")
                {
                    lblCountry.ForeColor = Color.Red;
                }
                else
                {
                    lblCountry.ForeColor = Color.DarkBlue;
                }

                if (dsSection.Tables[0].Rows[0]["WatsApp"].ToString() == string.Empty || dsSection.Tables[0].Rows[0]["WatsApp"].ToString() == "NULL")
                {
                    lblHWhatsApp.Text = string.Empty;
                    lblWhatsApp.Text = string.Empty;
                }
                else
                {
                    lblHWhatsApp.Text = "WhatsApp";
                    lblWhatsApp.Text = dsSection.Tables[0].Rows[0]["WatsApp"].ToString();
                }

                if (dsSection.Tables[0].Rows[0]["Facebook"].ToString() == string.Empty || dsSection.Tables[0].Rows[0]["Facebook"].ToString() == "NULL")
                {
                    lblHFaceBook.Text = string.Empty;
                    lblFaceBook.Text = string.Empty;
                }
                else
                {
                    lblHFaceBook.Text = "Facebook";
                    lblFaceBook.Text = dsSection.Tables[0].Rows[0]["Facebook"].ToString();
                }

                if (dsSection.Tables[0].Rows[0]["Skype"].ToString() == string.Empty || dsSection.Tables[0].Rows[0]["Skype"].ToString() == "NULL")
                {
                    lblHSkype.Text = string.Empty;
                    lblSkype.Text = string.Empty;
                }
                else
                {
                    lblHSkype.Text = "Skype";
                    lblSkype.Text = dsSection.Tables[0].Rows[0]["Skype"].ToString();
                }

                if (dsSection.Tables[0].Rows[0]["VMStatus"].ToString() == "Occupied")
                {
                    lblHDoorNoStatus.Text = string.Empty;
                    lblDoorNoStatus.Text = string.Empty;
                }
                else
                {
                    lblHDoorNoStatus.Text = "Status";
                    lblDoorNoStatus.Text = dsSection.Tables[0].Rows[0]["VMStatus"].ToString();
                }

                if (Convert.ToInt16(dsSection.Tables[1].Rows[0]["RCount"].ToString()) > 0)
                {
                    //tblOtherResident.Visible = true;
                    lblStat1.Visible = true;
                    rdgResidentView.Visible = true;
                    LoadGrid();
                }
                else
                {
                    lblStat1.Visible = false;
                    rdgResidentView.Visible = false;
                    //tblOtherResident.Visible = false;
                }

                if (Convert.ToInt16(dsSection.Tables[3].Rows[0]["Occupants"].ToString()) > 1)
                {
                    lblOccupants.ForeColor = Color.DarkBlue;
                }
                else
                {
                    lblOccupants.ForeColor = Color.Red;
                }

                Color Fclr;
                if (dsSection.Tables[0].Rows[0]["RType"].ToString() == "Resident")
                {
                    Fclr = ColorTranslator.FromHtml("#d7ddea");                   
                    VProfile.BackColor = Fclr;
                    KeyInfo.BackColor = Fclr;
                    AddInfo.BackColor = Fclr;                    
                }
                else
                {
                    Fclr = ColorTranslator.FromHtml("#ffffb3");  
                    VProfile.BackColor = Fclr;
                    KeyInfo.BackColor = Fclr;
                    AddInfo.BackColor = Fclr;
                }
                


                //lbStatus.Text = dsSection.Tables[0].Rows[0]["SDescription"].ToString();
                //lbGender.Text = dsSection.Tables[0].Rows[0]["Gender"].ToString();
                //lbMarital.Text = dsSection.Tables[0].Rows[0]["Marital_Status"].ToString();      
                //lbDOB.Text = Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"].ToString()).ToString("ddd") + "   " + Convert.ToDateTime(dsSection.Tables[0].Rows[0]["DOB"].ToString()).ToString("dd-MMM-yyyy") + " (" + dsSection.Tables[0].Rows[0]["Age"].ToString() + ")"; ;
                ////lbDOB.Text = dsSection.Tables[0].Rows[0]["DOB"].ToString();
                //lbBloodGroup.Text = dsSection.Tables[0].Rows[0]["BloodGroup"].ToString();
                //lbsmsalt.Text = dsSection.Tables[0].Rows[0]["SMSAlert"].ToString();
                //lbemailalt.Text = dsSection.Tables[0].Rows[0]["EMAILAlert"].ToString();
                //lbOccupants.Text = dsSection.Tables[0].Rows[0]["Occupants"].ToString();               
                //
                ////Custrimage.ImageUrl =Server.MapPath(@dsSection.Tables[0].Rows[0]["Images"].ToString());
                //Custrimage.ImageUrl = @dsSection.Tables[0].Rows[0]["Images"].ToString();
            }
            catch (Exception ex)
            {
                WebMsgBox.Show("There are some error in View process.Try again!");
            }
        }
        else
        {
        }


    }

    protected void  ScrClear()
    {
        lblPhone.Text = string.Empty;
        lblMobileNo.Text = string.Empty;
        lblEmailID.Text = string.Empty;
        lblEmailID2.Text = string.Empty;
        lblAddress1.Text = string.Empty;
        lblAddress2.Text = string.Empty;
        lblCity.Text = string.Empty;
        lblPinCode.Text = string.Empty;
        lblCountry.Text = string.Empty;
        lblOccupants.Text = string.Empty;
        lblBloodGroup.Text = string.Empty;
        lblGender.Text = string.Empty;
        lblDOB.Text = string.Empty;
        lblMStatus.Text = string.Empty;
        lblForDining.Text = string.Empty;
        lblForHousKeeping.Text = string.Empty;
        lblRemarks.Text = string.Empty;
        Custrimage.ImageUrl = string.Empty;

        lblDoorNo.Text = string.Empty;
        lblDoorNo2.Text = string.Empty;
        lblDoorNo3.Text = string.Empty;
        lblName.Text = string.Empty;
        lblName2.Text = string.Empty;
        lblName3.Text = string.Empty;
        lblInternalID.Text = string.Empty;
        lblInternalID2.Text = string.Empty;
        lblInternalID3.Text = string.Empty;
        lblDoorNoStatus.Text = string.Empty;
        lblDoorNoStatus2.Text = string.Empty;
        lblDoorNoStatus3.Text = string.Empty;
        lblResidentType.Text = string.Empty;
        lblResidentType2.Text = string.Empty;
        lblResidentType3.Text = string.Empty;
    
    }

    protected void LoadGrid()
    {
        try
        {
            int CustRSN = Convert.ToInt32(Session["CustRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsGroup = null;
            dsGroup = sqlobj.ExecuteSP("SP_ResidentProfile",
                new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CustRSN });
            rdgResidentView.DataSource = dsGroup.Tables[2];
            rdgResidentView.DataBind();
            dsGroup.Dispose();

            lblStat1.Text = dsGroup.Tables[2].Rows[0]["Statement"].ToString();

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }


    }

    protected void LoadKeyInfoGrid()
    {
        try
        {
            int CustRSN = Convert.ToInt32(Session["CustRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsKI = null;
            dsKI = sqlobj.ExecuteSP("SP_LoadKeyInfo",
                new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CustRSN });
            gvKeyInfo.DataSource = dsKI.Tables[0];
            gvKeyInfo.DataBind();
            dsKI.Dispose();

           

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }


    }

    protected void LoadAddInfoGrid()
    {
        try
        {
            int CustRSN = Convert.ToInt32(Session["CustRSN"]);

            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsKI = null;
            dsKI = sqlobj.ExecuteSP("SP_LoadKeyInfo",
                new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Int, Value = CustRSN });
            gvAddInfo.DataSource = dsKI.Tables[1];
            gvAddInfo.DataBind();
            dsKI.Dispose();



        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }


    }

    protected void Lnkbtnview_Click(object sender, EventArgs e)
    {

        LinkButton lnkOpenProjBtn = (LinkButton)sender;
        GridDataItem row = (GridDataItem)lnkOpenProjBtn.NamingContainer;
        Session["CustRSN"] = row.Cells[2].Text;
        ScrClear();
        loadCustDet();
        LoadKeyInfoGrid();
        LoadAddInfoGrid();

    }

    protected void btnShowDet_Click(object sender, EventArgs e)
    {

        if (DdlUhid.Text != string.Empty || DdlUhid.Text != "")
        {
            DataSet ds = null;

            string strrsnfilter = DdlUhid.Text;
            string[] custrsn = strrsnfilter.Split(',');
            strrsnfilter = custrsn[2].ToString();
            custrsn = strrsnfilter.Split(';');

            string Dstrrsnfilter = DdlUhid.Text;
            string[] Dcustrsn = Dstrrsnfilter.Split(',');
            string DNo = Dcustrsn[0].ToString();
           

            ds = sqlobj.ExecuteSP("[SP_CheckVillaStaus]",
                        new SqlParameter() { ParameterName = "@DoorNo", SqlDbType = SqlDbType.NVarChar, Value = DNo });

            if (ds.Tables[0].Rows.Count > 0)
            {
                lblErrorMsg.Visible = false;
                Session["CustRSN"] = Convert.ToInt32(custrsn[0].ToString());
                ScrClear();
                loadCustDet();                
            }
            else
            {
                lblErrorMsg.Visible = true;
                lblErrorMsg.Text = "This house is in " + ds.Tables[1].Rows[0]["Status"].ToString() + " state.";
                //WebMsgBox.Show("This house is in "+ds.Tables[1].Rows[0]["Status"].ToString()+" state.");
            }
            LoadKeyInfoGrid();
            LoadAddInfoGrid();

            DdlUhid.Entries.Clear();
            DdlUhid.Focus();

        }
    }

    protected void gvKeyInfo_PreRender(object sender, EventArgs e)
    {
        for (int rowIndex = gvKeyInfo.Items.Count - 2; rowIndex >= 0; rowIndex--)
        {
            GridDataItem row = gvKeyInfo.Items[rowIndex];
            GridDataItem previousRow = gvKeyInfo.Items[rowIndex + 1];
            if (row["GRP"].Text == previousRow["GRP"].Text)
            {
                row["GRP"].RowSpan = previousRow["GRP"].RowSpan < 2 ? 2 : previousRow["GRP"].RowSpan + 1;
                previousRow["GRP"].Visible = false;
            }
        }
    }

    protected void gvAddInfo_PreRender(object sender, EventArgs e)
    {
        for (int rowIndex = gvAddInfo.Items.Count - 2; rowIndex >= 0; rowIndex--)
        {
            GridDataItem row = gvAddInfo.Items[rowIndex];
            GridDataItem previousRow = gvAddInfo.Items[rowIndex + 1];
            if (row["GRP"].Text == previousRow["GRP"].Text)
            {
                row["GRP"].RowSpan = previousRow["GRP"].RowSpan < 2 ? 2 : previousRow["GRP"].RowSpan + 1;
                previousRow["GRP"].Visible = false;
            }
        }
    }

  

    protected void lbtnAdd_Click(object sender, EventArgs e)
    {
        //string TRSN;
        //LinkButton lnkOpenProjBtn = (LinkButton)sender;
        //GridDataItem row = (GridDataItem)lblDoorNo.NamingContainer;
        //Session["TestRSN"] = row.Cells[3].Text;
        //Session["TestRSN"] = row.Cells[4].Text;
        //Session["TestRSN"] = row.Cells[5].Text;

       

        Session["DoorNo"] = lblDoorNo.Text.ToString();
        rwDoorNoDet.VisibleOnPageLoad = true;
        LoadHouseDet();

    }

    protected void LoadHouseDet()
    {
        try
        {     
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet dsDN = null;
            dsDN = sqlobj.ExecuteSP("SP_FetchHouseDet",
                new SqlParameter() { ParameterName = "@DoorNo", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.NVarChar, Value = Session["DoorNo"].ToString() });

            txtDoorNo.Text=dsDN.Tables[0].Rows[0]["DoorNo"].ToString();
            txtType.Text = dsDN.Tables[0].Rows[0]["Type"].ToString();
            txtFloor.Text = dsDN.Tables[0].Rows[0]["Floor"].ToString();
            txtBlock.Text = dsDN.Tables[0].Rows[0]["Block"].ToString();
            txtConstruction.Text = dsDN.Tables[0].Rows[0]["Construction"].ToString();
            txtDescription.Text = dsDN.Tables[0].Rows[0]["Description"].ToString();
        }
        catch (Exception ex)
        {
            
        }
    
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx");
    }

    protected void ImgBtnHelp_Click(object sender, EventArgs e)
    {
        rwPopup.VisibleOnPageLoad = true;
        rwPopup.Visible = true;
        rwPopup2.VisibleOnPageLoad = false;
        rwPopup2.Visible = false;
    }
    protected void ImgBtnHelp2_Click(object sender, EventArgs e)
    {
        rwPopup.VisibleOnPageLoad = false;
        rwPopup.Visible = false;
        rwPopup2.VisibleOnPageLoad = true;
        rwPopup2.Visible = true;
    }
    public void LoadGrid2()
    {
        try
        {
            DataSet dsUsers = sqlobj.ExecuteSP("SP_FetchBillingDays",
               new SqlParameter() { ParameterName = "@iMode", SqlDbType = SqlDbType.Int, Value = 1 },
               new SqlParameter() { ParameterName = "@RSN", SqlDbType = SqlDbType.Int, Value = 1 });


            if (dsUsers.Tables[0].Rows.Count > 0)
            {
                grdBillingDays.DataSource = dsUsers;
                grdBillingDays.DataBind();
            }
            else
            {
                grdBillingDays.DataSource = null;
                grdBillingDays.DataBind();
            }

            dsUsers.Dispose();


        }
        catch (Exception ex)
        {
        }
    }
}