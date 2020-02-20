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

public partial class ExitEntry : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadGridGeneral();
            FetchOutCount();
            LoadVillaNo();
            LoadResidentName();
            LoadGridDummy();
            //ShowButtons();       

        }
    }
    protected void BtnShow_Click(object sender, EventArgs e)
    {
        DataSet dsRadGrid = new DataSet();
        if (ddlVillaNo.SelectedValue != String.Empty)
        {         
               
            try
            {              
                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsSection = proc.ExecuteSP("[SP_FetchRDtls]", new SqlParameter()
                {
                    ParameterName = "@RTVillaNo",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = ddlVillaNo.SelectedValue
                });

                if (dsSection.Tables[0].Rows.Count > 0)
                {

                    string FRTVNo = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();
                    lblVilla1.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                    lblStatus1.Text = dsSection.Tables[0].Rows[0]["SDescription"].ToString();
                    lblName1.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                    lblCNo1.Text = dsSection.Tables[0].Rows[0]["Contactcellno"].ToString();
                    lblLNO1.Text = dsSection.Tables[0].Rows[0]["Contactno"].ToString();
                    RImage.ImageUrl = dsSection.Tables[0].Rows[0]["Images"].ToString();
                    LBlRTRSN.Text = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();                 
                   

                    LoadGrid();
                    RImage.Visible = true;
                    CheckFBnt(FRTVNo);                   
                }                
            }
            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());
            }
            try
            {

                DataSet dsDependent = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsDependent = proc.ExecuteSP("[SP_FetchDependentDtls]", new SqlParameter()
                {
                    ParameterName = "@RTVillaNo",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = ddlVillaNo.SelectedValue
                });

                if (dsDependent.Tables[0].Rows.Count > 0)
                {
                    string SRTVNo = dsDependent.Tables[0].Rows[0]["RTRSN"].ToString();
                    lblVilla11.Text = dsDependent.Tables[0].Rows[0]["RTVILLANO"].ToString();
                    lblStatus11.Text = dsDependent.Tables[0].Rows[0]["SDescription"].ToString();
                    lblName11.Text = dsDependent.Tables[0].Rows[0]["RTName"].ToString();
                    lblCNo11.Text = dsDependent.Tables[0].Rows[0]["Contactcellno"].ToString();
                    lblLNO11.Text = dsDependent.Tables[0].Rows[0]["Contactno"].ToString();
                    DepndntImage.ImageUrl = dsDependent.Tables[0].Rows[0]["Images"].ToString();
                    LblRTRSN1.Text = dsDependent.Tables[0].Rows[0]["RTRSN"].ToString();
                    LoadGridDept();
                    DepndntImage.Visible = true;
                    CheckSBnt(SRTVNo);
                   
                    //LblGnrlInformDpnt.Text = dsDependent.Tables[0].Rows[0]["RTVILLANO"].ToString() 
                    //    + " || " + dsDependent.Tables[0].Rows[0]["RTStatus"].ToString() + " || " +
                    //    dsDependent.Tables[0].Rows[0]["RTName"].ToString() + "||" + dsDependent.Tables[0].Rows[0]["Contactcellno"] + 
                    //    "||" + dsDependent.Tables[0].Rows[0]["Contactno"];
                    //DepndntImage.ImageUrl = dsDependent.Tables[0].Rows[0]["Images"].ToString();
                    //LBlRTRSN.Text = dsDependent.Tables[0].Rows[0]["RTRSN"].ToString();

                }

                dsRadGrid = proc.ExecuteSP("Proc_GetResident_Checkin", new SqlParameter()
                {
                    ParameterName = "@DoorNo",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = ddlVillaNo.SelectedValue
                });
                radgrdCheckout.DataSource = dsRadGrid;
                radgrdCheckout.DataBind();
                
            }

            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());
            }

        }
    }

    protected void CheckFBnt(string FRTVNo)
    { 
        DataSet dsDependent = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsDependent = proc.ExecuteSP("[SP_FetchIOStatus]", new SqlParameter()
                {
                    ParameterName = "@RTRSN",Direction = ParameterDirection.Input,SqlDbType = SqlDbType.Decimal,Value = FRTVNo
                });

                if (dsDependent.Tables[0].Rows.Count > 0)
                {
                    string RSLTStatus = dsDependent.Tables[0].Rows[0]["Status"].ToString();
                    if (RSLTStatus == "CheckIn")
                    {
                        BtnExit.Visible = true;
                        BtnEntry.Visible = false;
                        BtnReset.Visible = false;
                    }
                    else if (RSLTStatus == "CheckOut")
                    {
                        BtnExit.Visible = false;
                        BtnEntry.Visible = true;
                        BtnReset.Visible = true;
                    }
                }
                else
                {
                    BtnExit.Visible = true;
                    BtnEntry.Visible = false;
                    BtnReset.Visible = false;
                
                }
    
    }

    protected void CheckSBnt(string SRTVNo)
    {
        DataSet dsDependent = new DataSet();
        SqlProcsNew proc = new SqlProcsNew();

        dsDependent = proc.ExecuteSP("[SP_FetchIOStatus]", new SqlParameter()
        {
            ParameterName = "@RTRSN",
            Direction = ParameterDirection.Input,
            SqlDbType = SqlDbType.Decimal,
            Value = SRTVNo
        });

        if (dsDependent.Tables[0].Rows.Count > 0)
        {
            string RSLTStatus = dsDependent.Tables[0].Rows[0]["Status"].ToString();
            if (RSLTStatus == "CheckIn")
            {
                BtnExit1.Visible = true;
                BtnEntry1.Visible = false;
                BtnReset1.Visible = false;
            }
            else if (RSLTStatus == "CheckOut")
            {
                BtnExit1.Visible = false;
                BtnEntry1.Visible = true;
                BtnReset1.Visible = true;
            }
        }
        else
        {
            BtnExit1.Visible = true;
            BtnEntry1.Visible = false;
            BtnReset1.Visible = false;

        }

    }

    protected void BtnShowName_Click(object sender, EventArgs e)
    { 
      
        
        if (ddlName.SelectedValue != String.Empty)
        {           
            try
            {
                DataSet dsSection = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsSection = proc.ExecuteSP("[SP_FetchRDtls]", new SqlParameter()
                {
                    ParameterName = "@RTVillaNo",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = ddlName.SelectedValue
                });

                if (dsSection.Tables[0].Rows.Count > 0)
                {

                    string FRTVNo = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();
                    lblVilla1.Text = dsSection.Tables[0].Rows[0]["RTVILLANO"].ToString();
                    lblStatus1.Text = dsSection.Tables[0].Rows[0]["SDescription"].ToString();
                    lblName1.Text = dsSection.Tables[0].Rows[0]["RTName"].ToString();
                    lblCNo1.Text = dsSection.Tables[0].Rows[0]["Contactcellno"].ToString();
                    lblLNO1.Text = dsSection.Tables[0].Rows[0]["Contactno"].ToString();
                    RImage.ImageUrl = dsSection.Tables[0].Rows[0]["Images"].ToString();
                    LBlRTRSN.Text = dsSection.Tables[0].Rows[0]["RTRSN"].ToString();
                    LoadGrid();
                    RImage.Visible = true;
                    CheckFBnt(FRTVNo);
                }


                ;
            }

            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());
            }
            try
            {

                DataSet dsDependent = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                dsDependent = proc.ExecuteSP("[SP_FetchDependentDtls]", new SqlParameter()
                {
                    ParameterName = "@RTVillaNo",
                    Direction = ParameterDirection.Input,
                    SqlDbType = SqlDbType.NVarChar,
                    Value = ddlName.SelectedValue
                });

                if (dsDependent.Tables[0].Rows.Count > 0)
                {
                    string SRTVNo = dsDependent.Tables[0].Rows[0]["RTRSN"].ToString();
                    lblVilla11.Text = dsDependent.Tables[0].Rows[0]["RTVILLANO"].ToString();
                    lblStatus11.Text = dsDependent.Tables[0].Rows[0]["SDescription"].ToString();
                    lblName11.Text = dsDependent.Tables[0].Rows[0]["RTName"].ToString();
                    lblCNo11.Text = dsDependent.Tables[0].Rows[0]["Contactcellno"].ToString();
                    lblLNO11.Text = dsDependent.Tables[0].Rows[0]["Contactno"].ToString();
                    DepndntImage.ImageUrl = dsDependent.Tables[0].Rows[0]["Images"].ToString();
                    LblRTRSN1.Text = dsDependent.Tables[0].Rows[0]["RTRSN"].ToString();
                    LoadGridDept();
                    DepndntImage.Visible = true;
                    CheckSBnt(SRTVNo);
                   

                    //LblGnrlInformDpnt.Text = dsDependent.Tables[0].Rows[0]["RTVILLANO"].ToString() 
                    //    + " || " + dsDependent.Tables[0].Rows[0]["RTStatus"].ToString() + " || " +
                    //    dsDependent.Tables[0].Rows[0]["RTName"].ToString() + "||" + dsDependent.Tables[0].Rows[0]["Contactcellno"] + 
                    //    "||" + dsDependent.Tables[0].Rows[0]["Contactno"];
                    //DepndntImage.ImageUrl = dsDependent.Tables[0].Rows[0]["Images"].ToString();
                    //LBlRTRSN.Text = dsDependent.Tables[0].Rows[0]["RTRSN"].ToString();

                }


                ;
            }

            catch (Exception ex)
            {
                WebMsgBox.Show(ex.ToString());
            }

        }
    }

    protected void ShowButtons()
    {
        RImage.Visible = false;
        BtnExit.Visible = false;
        BtnEntry.Visible = false;
        BtnReset.Visible = false;

        DepndntImage.Visible = false;
        BtnExit1.Visible = false;
        BtnEntry1.Visible = false;
        BtnReset1.Visible = false;


        LblGridHeading.Visible = false;
        OutInListView.Visible = false;
    
    }

    protected void OutInListView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadGrid();
        LoadGridDept();
    }
    protected void OutInListView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGrid();
        LoadGridDept();
    }
    protected void OutInListView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadGrid();
        LoadGridDept();
    }
    protected void OutInListView_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadGrid();
        LoadGridDept();
    }
    protected void BtnExit_Click(object sender, EventArgs e)
    {
        if (HResult.Value == "true")
        {
            if (ddlVillaNo.SelectedValue != String.Empty && LBlRTRSN.Text != string.Empty)
            {
                try
                {
                    DataSet dsChkCO = new DataSet();
                    SqlProcsNew proc = new SqlProcsNew();

                    string RTRSN = LBlRTRSN.Text.ToString();

                    dsChkCO = proc.ExecuteSP("[SP_CheckCheckOut]",
                    new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = LBlRTRSN.Text });

                    if (dsChkCO.Tables[0].Rows.Count == 0)
                    {
                        SqlProcsNew sqlobj = new SqlProcsNew();
                        sqlobj.ExecuteSQLNonQuery("[SP_InsertInOutDtls]",
                                        new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = LBlRTRSN.Text },
                                           new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckOut" },
                                           new SqlParameter() { ParameterName = "@DateTime", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now }
                                          );


                        WebMsgBox.Show("Resident Checked Out. Remember to Check In when he/she returns.");
                        LoadGrid();
                        LoadGridGeneral();
                        FetchOutCount();                       
                        CheckFBnt(RTRSN);
                        //ClearScr();
                    }
                    else
                    {
                        SqlProcsNew sqlobj = new SqlProcsNew();
                        sqlobj.ExecuteSQLNonQuery("[SP_InsertInOutDtls]",
                                        new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 },
                                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = LBlRTRSN.Text },
                                           new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckOut" },
                                           new SqlParameter() { ParameterName = "@DateTime", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now }
                                          );


                        WebMsgBox.Show("Resident Checked Out. Remember to Check In when he/she returns.");
                        LoadGrid();
                        LoadGridGeneral();
                        FetchOutCount();                       
                        CheckFBnt(RTRSN);
                    }

                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());
                }


            }
            else
            {
                WebMsgBox.Show("Enter Villa Number and click Show .");
            }


        }

    }
    protected void BtnEntry_Click(object sender, EventArgs e)
    {
       
        if (HResult.Value == "true")
        {
            if (ddlVillaNo.SelectedValue != String.Empty && LBlRTRSN.Text != string.Empty)
            {
                try
                {

                    SqlProcsNew sqlobj = new SqlProcsNew();
                    sqlobj.ExecuteSQLNonQuery("[SP_InsertInOutDtls]",
                                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 },
                                    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = LBlRTRSN.Text },
                                       new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckIn" },
                                       new SqlParameter() { ParameterName = "@DateTime", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now }
                                      );


                    WebMsgBox.Show("Resident Checked In.");
                    LoadGrid();
                    LoadGridGeneral();
                    FetchOutCount();
                    CheckFBnt(LBlRTRSN.Text.ToString());
                    //ClearScr();


                }

                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());

                }


            }
            else
            {
                WebMsgBox.Show("Enter Villa Number and click Show.");
            }


        }
    }
    protected void BtnReset_Click(object sender, EventArgs e)
    {
        if (HResult.Value == "true")
        {
            if (ddlVillaNo.SelectedValue != String.Empty && LBlRTRSN.Text != string.Empty)
            {
                try
                {

                    SqlProcsNew sqlobj = new SqlProcsNew();
                    sqlobj.ExecuteSQLNonQuery("[SP_InsertInOutDtls]",
                                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 },
                                    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = LBlRTRSN.Text },
                                       new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckIn" },
                                       new SqlParameter() { ParameterName = "@DateTime", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now }


                                      );


                    WebMsgBox.Show("Resident’s Checked Out Status now RESET.");
                    LoadGrid();
                    LoadGridGeneral();
                    FetchOutCount();
                    CheckFBnt(LBlRTRSN.Text.ToString());



                    //ClearScr(); 

                }

                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());

                }


            }
            else
            {
                WebMsgBox.Show("Enter Villa Number and click Show.");
            }

        }
    }

    #region Grid load function
    protected void LoadGrid()
    {

        SqlCommand cmd = new SqlCommand("[SP_LoadInOutPersonalGrid]", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;
        cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = LBlRTRSN.Text;
        cmd.Parameters.Add("@RTVILLANO", SqlDbType.NVarChar).Value = lblVilla1.Text;
        DataSet dsGrid = new DataSet();
        OutInListView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            
            OutInListView.DataSource = dsGrid.Tables[0];
            OutInListView.DataBind();
            LblGridHeading.Visible=true;
            OutInListView.Visible = true;


            //OutInListView.AllowPaging = true;

        }
        else
        {
            OutInListView.DataSource = new String[] { };
            OutInListView.DataBind();
            LblGridHeading.Visible = false;
            OutInListView.Visible = false;
        }

    }

    #endregion
    #region Grid load function for Dependent
    protected void LoadGridDept()
    {

        SqlCommand cmd = new SqlCommand("[SP_LoadInOutPersonalGrid]", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 2;
        cmd.Parameters.Add("@RTRSN", SqlDbType.Int).Value = LblRTRSN1.Text;
        cmd.Parameters.Add("@RTVILLANO", SqlDbType.NVarChar).Value = lblVilla11.Text;
        DataSet dsGrid = new DataSet();
        OutInListView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            OutInListView.DataSource = dsGrid.Tables[0];
            OutInListView.DataBind();
            LblGridHeading.Visible = true;
            OutInListView.Visible = true;




            //OutInListView.AllowPaging = true;

        }
        else
        {
            OutInListView.DataSource = new String[] { };
            OutInListView.DataBind();
            LblGridHeading.Visible = false;
            OutInListView.Visible = false;
        }

    }

    #endregion

    #region Grid load function for Fetch general Villa Entry details
    protected void LoadGridGeneral()
    {

        SqlCommand cmd = new SqlCommand("[SP_LoadInOutPersonalGrid]", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 3;
        DataSet dsGrid = new DataSet();
        GeneralOutInListView.DataBind();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            GeneralOutInListView.DataSource = dsGrid.Tables[0];
            GeneralOutInListView.DataBind();

            //OutInListView.AllowPaging = true;

        }
        else
        {
            GeneralOutInListView.DataSource = new String[] { };
            GeneralOutInListView.DataBind();
        }
        for (int i = 0; i < dsGrid.Tables[0].Rows.Count; i++)
        {

            DateTime Today = new DateTime();
            Today = Convert.ToDateTime(DateTime.Now);
            //int i = 0;
            foreach (GridItem rw in GeneralOutInListView.Items)
            {


                DateTime DT = new DateTime();
                DT = Convert.ToDateTime(dsGrid.Tables[0].Rows[i]["TimeDate"].ToString()).AddHours(6);


                //if (DT >= Today)
                //{
                //    rw.Cells[5].ForeColor = System.Drawing.Color.Red;
                //}
                //i = i + 1;
            }
        }



    }

    #endregion
    protected void BtnExit1_Click(object sender, EventArgs e)
    {
        if (HResult.Value == "true")
        {
            if (ddlVillaNo.SelectedValue != String.Empty && LblRTRSN1.Text != string.Empty)
            {
                try
                {

                DataSet dsChkCO = new DataSet();
                SqlProcsNew proc = new SqlProcsNew();

                string RTRSN2 = LblRTRSN1.Text.ToString();

                dsChkCO = proc.ExecuteSP("[SP_CheckCheckOut]",
                new SqlParameter() { ParameterName = "@RTRSN", Direction = ParameterDirection.Input, SqlDbType = SqlDbType.Decimal, Value = LblRTRSN1.Text });

                if (dsChkCO.Tables[0].Rows.Count == 0)
                {

                    SqlProcsNew sqlobj = new SqlProcsNew();
                    sqlobj.ExecuteSQLNonQuery("[SP_InsertInOutDtls]",
                                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 },
                                    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = LblRTRSN1.Text },
                                       new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckOut" },
                                       new SqlParameter() { ParameterName = "@DateTime", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now }
                                      );


                    WebMsgBox.Show("Resident Checked Out. Remember to Check In when he/she returns.");
                    LoadGridDept();
                    LoadGridGeneral();
                    FetchOutCount();
                    CheckSBnt(RTRSN2);
                }
                else
                {
                    SqlProcsNew sqlobj = new SqlProcsNew();
                    sqlobj.ExecuteSQLNonQuery("[SP_InsertInOutDtls]",
                                        new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 4 },
                                        new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = LblRTRSN1.Text },
                                           new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckOut" },
                                           new SqlParameter() { ParameterName = "@DateTime", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now }
                                          );
                        WebMsgBox.Show("Resident Checked Out. Remember to Check In when he/she returns.");
                        LoadGrid();
                        LoadGridGeneral();
                        FetchOutCount();
                        CheckSBnt(RTRSN2);
                }

                }

                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());

                }

            }
            else
            {
                WebMsgBox.Show("Select Villa Number and click Show .");
            }
        }
    }
    protected void BtnEntry1_Click(object sender, EventArgs e)
    {
        if (HResult.Value == "true")
        {
            if (ddlVillaNo.SelectedValue != String.Empty && LblRTRSN1.Text != string.Empty)
            {
                try
                {

                    SqlProcsNew sqlobj = new SqlProcsNew();
                    sqlobj.ExecuteSQLNonQuery("[SP_InsertInOutDtls]",
                                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 },
                                    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = LblRTRSN1.Text },
                                       new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckIn" },
                                       new SqlParameter() { ParameterName = "@DateTime", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now }
                                      );

                    WebMsgBox.Show("Resident Checked In.");
                    LoadGridDept();
                    LoadGridGeneral();
                    FetchOutCount();
                    CheckSBnt(LblRTRSN1.Text.ToString());
                    //ClearScr();
                }
                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());

                }
            }
            else
            {
                WebMsgBox.Show("Enter Villa Number and click Show.");
            }
        }

    }
    protected void BtnReset1_Click(object sender, EventArgs e)
    {
        if (HResult.Value == "true")
        {
            if (ddlVillaNo.SelectedValue != String.Empty && LblRTRSN1.Text != string.Empty)
            {
                try
                {

                    SqlProcsNew sqlobj = new SqlProcsNew();
                    sqlobj.ExecuteSQLNonQuery("[SP_InsertInOutDtls]",
                                    new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 },
                                    new SqlParameter() { ParameterName = "@RTRSN", SqlDbType = SqlDbType.Int, Value = LblRTRSN1.Text },
                                       new SqlParameter() { ParameterName = "@AStatus", SqlDbType = SqlDbType.NVarChar, Value = "CheckIn" },
                                       new SqlParameter() { ParameterName = "@DateTime", SqlDbType = SqlDbType.DateTime, Value = DateTime.Now }


                                      );


                    WebMsgBox.Show("Resident’s Checked Out Status now RESET.");
                    LoadGridDept();
                    LoadGridGeneral();
                    FetchOutCount();
                    CheckSBnt(LblRTRSN1.Text.ToString());
                    //ClearScr();

                }

                catch (Exception ex)
                {
                    WebMsgBox.Show(ex.Message.ToString());

                }


            }
            else
            {
                WebMsgBox.Show("Enter Villa Number and click Show.");
            }

        }
    }
    protected void GeneralOutInListView_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        LoadGridGeneral();
    }
    protected void GeneralOutInListView_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadGridGeneral();
    }

    protected void GeneralOutInListView_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        LoadGridGeneral();
    }
    protected void GeneralOutInListView_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        LoadGridGeneral();
    }
    protected void FetchOutCount()
    {
        try
        {
            DataSet dsOutCount = new DataSet();
            SqlProcsNew proc = new SqlProcsNew();

            dsOutCount = proc.ExecuteSP("SP_FetchOutCountData", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = 1
            });

            if (dsOutCount.Tables[0].Rows.Count > 0)
            {
                LblOutCount.Text = "Residents Checked Out as of now :   " + dsOutCount.Tables[0].Rows[0]["InOutCount"].ToString();     
            }

            if (dsOutCount.Tables[1].Rows.Count > 0)
            {
                lblCOTime.Text = "Alert :" + dsOutCount.Tables[1].Rows[0]["COTime"].ToString();             
            }
        }

        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    //protected void ddlVillaNo_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //}
    protected void ddlVillaNo_SelectedIndexChanged(object sender, EventArgs e)
    {

        lblVilla1.Text = String.Empty;
        lblStatus1.Text = String.Empty;
        lblName1.Text = String.Empty;
        lblCNo1.Text = String.Empty;
        lblLNO1.Text = String.Empty;
        RImage.ImageUrl = String.Empty;
        LBlRTRSN.Text = String.Empty;
        lblVilla11.Text = String.Empty;
        lblStatus11.Text = String.Empty;
        lblName11.Text = String.Empty;
        lblCNo11.Text = String.Empty;
        lblLNO11.Text = String.Empty;
        DepndntImage.ImageUrl = String.Empty;
        LblRTRSN1.Text = String.Empty;

        LblGridHeading.Visible = false;
        OutInListView.Visible = false;

        BtnExit.Visible = false;
        BtnEntry.Visible = false;
        BtnReset.Visible = false;


        BtnExit1.Visible = false;
        BtnEntry1.Visible = false;
        BtnReset1.Visible = false;


    }
    #region Load Villa Number drop down
    protected void LoadVillaNo()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistVilla = new DataSet();

            ddlistVilla = sqlobj.ExecuteSP("SP_FecthVillaNO1",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 1 });
            ddlVillaNo.DataSource = ddlistVilla.Tables[0];
            ddlVillaNo.DataValueField = "VillaNo";
            ddlVillaNo.DataTextField = "VillaText";
            ddlVillaNo.DataBind();
            ddlVillaNo.Dispose();
            ddlVillaNo.Items.Insert(0, new ListItem("--Select--", "0"));


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }

    protected void LoadResidentName()
    {
        try
        {
            SqlProcsNew sqlobj = new SqlProcsNew();
            DataSet ddlistVilla = new DataSet();

            ddlistVilla = sqlobj.ExecuteSP("SP_FecthVillaNO1",
                 new SqlParameter() { ParameterName = "@IMODE", SqlDbType = SqlDbType.Int, Value = 2 });
            ddlName.DataSource = ddlistVilla.Tables[0];
            ddlName.DataValueField = "VillaNo";
            ddlName.DataTextField = "VillaText";
            ddlName.DataBind();
            ddlName.Dispose();
            ddlName.Items.Insert(0, new ListItem("--Select--", "0"));


        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message.ToString());
        }
    }
    #endregion
    protected void GeneralOutInListView_ItemDataBound(object sender, GridItemEventArgs e)
    {
    }
    protected void LoadGridDummy()
    {

        SqlCommand cmd = new SqlCommand("[SP_LoadInOutPersonalGrid]", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 1;

        DataSet dsGrid = new DataSet();
        OutInListView.DataBind();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {

            OutInListView.DataSource = dsGrid.Tables[0];
            OutInListView.DataBind();


            //OutInListView.AllowPaging = true;

        }
        else
        {
            OutInListView.DataSource = new String[] { };
            OutInListView.DataBind();


        }
    }
    protected void RMCare_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (e.Item.Text == "Checkout register")
        {
            Response.Redirect("ExitEntry.aspx");
        }
        else if (e.Item.Text == "Living alone")
        {           
            Response.Redirect("SAlone.aspx?Value=" + 1);            
        }
        else if (e.Item.Text == "Birthdays in 7 days")
        {
            Response.Redirect("BirthdayGrid.aspx");
        }
        else if (e.Item.Text == "Daily messages")
        {
            
        }
        else if (e.Item.Text == "Help")
        {

        }
    }
    protected void radgrdCheckout_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            GridDataItem item = e.Item as GridDataItem;
            Button lbtnupdate = (Button)e.Item.FindControl("btngrdchkout");
            string test = lbtnupdate.Text;
            if (test == "CheckOut")
            {
                test = "CheckIn";
            }
            else if (test == "CheckIn")
            {
                test = "CheckOut";
            }
            string RTRSN = e.CommandArgument.ToString();
            SqlCommand cmd = new SqlCommand("Proc_CheckinandoutAll", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 1);
            cmd.Parameters.AddWithValue("@RTRSN", RTRSN);
            cmd.Parameters.AddWithValue("@AStatus", lbtnupdate.Text);
            if(con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //lbtnupdate.Text = test;
            lbtnupdate.Enabled = false;
        }
    }
    protected void radgrdCheckin_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "UpdateRow")
        {
            GridDataItem item = e.Item as GridDataItem;
            Button lbtnupdate = (Button)e.Item.FindControl("btngrdchkin");
            string test = lbtnupdate.Text;
            if (test == "CheckOut")
            {
                test = "CheckIn";
            }
            else if (test == "CheckIn")
            {
                test = "CheckOut";
            }
            string RTRSN = e.CommandArgument.ToString();
            SqlCommand cmd = new SqlCommand("Proc_CheckinandoutAll", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@i", 1);
            cmd.Parameters.AddWithValue("@RTRSN", RTRSN);
            cmd.Parameters.AddWithValue("@AStatus", lbtnupdate.Text);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            //lbtnupdate.Text = test;
            lbtnupdate.Enabled = false;
        }
    }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           