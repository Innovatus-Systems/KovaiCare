using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Web.Services;
using System.ComponentModel.Design;
using System.Collections.Generic;

public partial class HomeScr : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["constring"].ToString());
    protected void Page_Load(object sender, EventArgs e)
    {
        RW1CEGridView.VisibleOnPageLoad = true;
        RW1CEGridView.Visible = false;
        if (!IsPostBack)
        {
            FetchOutCount();
            LoadBirthdayGrid();
            //LoadGridLevelP();

        }
    }

    protected void FetchOutCount()
    {
        try
        {
            SqlProcsNew proc = new SqlProcsNew();

            DataSet dsOutCount = new DataSet();
            DataSet dsResidCnt = new DataSet();
            DataSet dsStayAlone = new DataSet();
            DataSet dsOwnersAway = new DataSet();
            DataSet dsStaffList = new DataSet();



            dsOutCount = proc.ExecuteSP("SP_FetchOutCountData", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.NVarChar,
                Value = 1
            });

            if (dsOutCount.Tables[0].Rows.Count > 0)
            {
                //lblRCHOUT.Text = "Resident CheckedOut :   " + dsOutCount.Tables[0].Rows[0]["InOutCount"].ToString();
                lblRCHOUT.Text = " :   " + dsOutCount.Tables[0].Rows[0]["InOutCount"].ToString();
            }

            dsResidCnt = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 13
            });

            if (dsResidCnt.Tables[0].Rows.Count > 0)
            {
                //lblRCHOUT.Text = "Resident CheckedOut :   " + dsOutCount.Tables[0].Rows[0]["InOutCount"].ToString();
                lblResidentsCNT.Text = " :   " + dsResidCnt.Tables[0].Rows[0]["ResCnt"].ToString();
            }

            dsStayAlone = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 14
            });

            if (dsStayAlone.Tables[0].Rows.Count > 0)
            {

                lblStayAlone.Text = " :   " + dsStayAlone.Tables[0].Rows[0]["StayAlone"].ToString();
            }

            dsOwnersAway = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 15
            });

            if (dsOwnersAway.Tables[0].Rows.Count > 0)
            {

                lblOwnersAway.Text = " :   " + dsOwnersAway.Tables[0].Rows[0]["OwnersAway"].ToString();
            }

            dsStaffList = proc.ExecuteSP("SP_General", new SqlParameter()
            {
                ParameterName = "@IMODE",
                Direction = ParameterDirection.Input,
                SqlDbType = SqlDbType.Int,
                Value = 16
            });

            if (dsStaffList.Tables[0].Rows.Count > 0)
            {

                lblStaffList.Text = " :   " + dsStaffList.Tables[0].Rows[0]["StaffList"].ToString();
            }
        }

        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }
    protected void LoadBirthdayGrid()
    {
        SqlCommand Cmd = new SqlCommand("SP_General", con);
        Cmd.CommandType = CommandType.StoredProcedure;
        Cmd.Parameters.Add("@IMODE", SqlDbType.Int).Value = 4;
        DataSet dsGrid = new DataSet();
        //BirthdaygrdView.DataBind();    
        SqlDataAdapter da = new SqlDataAdapter(Cmd);
        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {
            //lbldispbirthdays.Text = "Upcoming birthdays  :" + dsGrid.Tables[0].Rows.Count;
            lbldispbirthdays.Text = "  :" + dsGrid.Tables[0].Rows.Count;
        }

        else
        {

            //lbldispbirthdays.Text = "No upcoming birthdays ";

        }

    }

    #region Grid load function for all(OUR WORLD)
    protected void LoadGridLevelP()
    {
        SqlCommand cmd = new SqlCommand("SP_Fetch1CEDetails", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@IMODE", SqlDbType.NVarChar).Value = 1;
        DataSet dsGrid = new DataSet();
        AllGridView1CE.DataBind();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dsGrid);
        if (dsGrid != null && dsGrid.Tables.Count > 0 && dsGrid.Tables[0].Rows.Count > 0)
        {


            AllGridView1CE.DataSource = dsGrid.Tables[0];
            AllGridView1CE.DataBind();

        }
        else
        {
            AllGridView1CE.DataSource = new String[] { };
            AllGridView1CE.DataBind();
        }
    }

    #endregion

    //public void LoadTile()
    //{
    //    try
    //    {
    //        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["COMPANIONConString"].ConnectionString))
    //        {
    //            cn.Open();
    //            SqlCommand cmd = new SqlCommand("Sp_LoadTile", cn);
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@IMODE", "1");

    //            SqlDataAdapter da = new SqlDataAdapter(cmd);
    //            DataTable dt = new DataTable();
    //            cmd.ExecuteNonQuery();

    //            da.Fill(dt);
    //            if (dt.Rows.Count > 0)
    //            {

    //                for (int i = 0; i < dt.Rows.Count; i++)
    //                {
    //                    string tileno = dt.Rows[i][1].ToString();
    //                    if (tileno == "1")
    //                    {
    //                        lbldipT1.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc1.Text = dt.Rows[i]["TileHelp"].ToString();
    //                        //lblT1Desc1.Text = dt.Rows[i]["TileLink"].ToString();
    //                    }
    //                    if (tileno == "2")
    //                    {
    //                        lbldipT2.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc2.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    if (tileno == "3")
    //                    {
    //                        lbldipT3.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc3.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    if (tileno == "4")
    //                    {
    //                        lbldipT4.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc4.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    if (tileno == "5")
    //                    {
    //                        lbldipT5.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc5.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    if (tileno == "6")
    //                    {
    //                        lbldipT6.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc6.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    if (tileno == "7")
    //                    {
    //                        lbldipT7.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc7.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    if (tileno == "8")
    //                    {
    //                        lbldipT8.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc8.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    if (tileno == "9")
    //                    {
    //                        lbldipT9.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc9.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    if (tileno == "10")
    //                    {
    //                        lbldipT10.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc10.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    if (tileno == "11")
    //                    {
    //                        lbldipT11.Text = dt.Rows[i]["TileTitle"].ToString();
    //                        lblT1Desc11.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }
    //                    //if (tileno == "12")
    //                    //{
    //                    //    lbldipT12.Text = dt.Rows[i]["TileTitle"].ToString();
    //                    //    lblT1Desc12.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    //}

    //                    //if (tileno == "13")
    //                    //{
    //                    //    lbldipT13.Text = dt.Rows[i]["TileTitle"].ToString();
    //                    //    lblT1Desc13.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    //}

    //                    //if (tileno == "14")
    //                    //{
    //                    //    lbldipT14.Text = dt.Rows[i]["TileTitle"].ToString();
    //                    //    lblT1Desc14.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    //}

    //                    //if (tileno == "15")
    //                    //{
    //                    //    lbldipT15.Text = dt.Rows[i]["TileTitle"].ToString();
    //                    //    lblT1Desc15.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    //}

    //                    //if (tileno == "16")
    //                    //{
    //                    //    lbldipT16.Text = dt.Rows[i]["TileTitle"].ToString();
    //                    //    lblT1Desc16.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    //}

    //                    tileno = "";
    //                }


    //            }
    //        }

    //     using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["COMPANIONConString"].ConnectionString))
    //        {
    //            cn.Open();
    //            SqlCommand cmd = new SqlCommand("Sp_LoadTile", cn);
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            cmd.Parameters.AddWithValue("@IMODE", "2");

    //            SqlDataAdapter da = new SqlDataAdapter(cmd);
    //            DataTable dt = new DataTable();
    //            cmd.ExecuteNonQuery();

    //            da.Fill(dt);
    //            if (dt.Rows.Count > 0)
    //            {

    //                for (int i = 0; i < dt.Rows.Count; i++)
    //                {
    //                    string tileno = dt.Rows[i][1].ToString();

    //                    if(tileno=="17")
    //                    {
    //                        lbldispScollTopTXT.Text = dt.Rows[i]["TileHelp"].ToString();
    //                    }

    //                }


    //            }

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //    }

    //}
    protected void btntest_Click(object sender, EventArgs e)
    {
        return;
    }
    protected void btnyes_Click(object sender, EventArgs e)
    {
        //Button1_Click(Button1, new EventArgs());
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

    }
    protected void ImgBHome_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx?id=" + 1, true);

    }
    protected void imagestaff_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("ResidentAdd.aspx?id1=" + 2, true);
    }
    protected void ImgebtnGlobe_Click(object sender, ImageClickEventArgs e)
    {
        if (txtsearch.Text == string.Empty || txtsearch.Text == "- Search -")
        {

            Response.Redirect("ResidentAdd.aspx?id2=" + 3, true);
        }
        if (txtsearch.Text.Length >= 4)
        {
            RW1CEGridView.Visible = true;
            LoadGridLevelP();
            txtsearch.Text = string.Empty;
        }
        else
        {

            WebMsgBox.Show("Please enter atleast 4 characters");
            txtsearch.Text = string.Empty;
        }
    }
}