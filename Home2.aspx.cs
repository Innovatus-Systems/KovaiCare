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

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //LoadTile();
        if(!IsPostBack)
        {
            FetchOutCount();
        }
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
                lblRCHOUT.Text = "Resident CheckedOut :   " + dsOutCount.Tables[0].Rows[0]["InOutCount"].ToString();

            }
        }

        catch (Exception ex)
        {
            WebMsgBox.Show(ex.ToString());
        }
    }

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
}