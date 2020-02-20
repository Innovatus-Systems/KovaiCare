using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Web.Services;

public partial class MessBilling : System.Web.UI.Page
{
    static SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            lbldate.SelectedDate = DateTime.Today;
            LoadSession();
        }

    }
    public void LoadSession()
    {
        DataSet dsSession = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand("Get_Sessions", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter dap = new SqlDataAdapter(cmd);
            dap.Fill(dsSession, "temp");
            if(dsSession.Tables[0].Rows.Count > 0)
            {
                ddlSession.DataSource = dsSession;
                ddlSession.DataTextField = "SessionName";
                ddlSession.DataValueField = "SessionCode";
                ddlSession.DataBind();
            }
        }
        catch (Exception ex)
        {
           
        }
    }
    [WebMethod]
    public static string GetDependents(string resvalue)
    {
        string flag ="";
        string[] strVal = resvalue.Split('-');
        try
        {
            SqlCommand cmd = new SqlCommand("Get_dependents", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@doorno", strVal[0].Trim().ToString());
            cmd.Parameters.AddWithValue("@Name", strVal[1].Trim().ToString());
            
            if(con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            
            if(dr.HasRows)
            {
                while(dr.Read())
                {
                    flag = dr["RTName"].ToString();
                }
            }
            else
            {
                flag = "false";
            }
            
        }
        catch (Exception ex)
        {
            flag = "false";
        }
        return flag;
    }
    [WebMethod]
    public static List<string> GetDinersCount(string date,string session,string doorno,string details)
    {
        string flag = "";
        List<string> strList = new List<string>();
        try
        {
            SqlCommand cmd = new SqlCommand("Get_DinersCount", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@details", details);
            cmd.Parameters.AddWithValue("@Door", doorno);
            cmd.Parameters.AddWithValue("@session", session);
            cmd.Parameters.AddWithValue("@Date", date);  
            if(con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if(dr.HasRows)
            {
                while(dr.Read())
                {
                    strList.Add(dr["Booked"].ToString());
                    strList.Add(dr["GuestBooked"].ToString());
                }
            }
            else
            {
                strList.Add("false");
            }
            dr.Close();
            con.Close();
        }
        catch (Exception ex)
        {
            flag = "false";
        }
        return strList;
    }

    [WebMethod]
    public static string[] GetResidents(string keyword)
    {
        List<string> retList = new List<string>();
        try
        {
            using (SqlCommand cmd = new SqlCommand("GetCustomerAuto"))
            {
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@term", keyword);
                if(con.State.Equals(ConnectionState.Open))
                {
                    con.Close();
                }
                con.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        //retList.Add(dr["RSN"].ToString());
                        //retList.Add(dr["Name"].ToString());
                        retList.Add(string.Format("{0}|{1}", dr["Name"], dr["RTRSN"]));
                    }
                }
                con.Close();
            }
        }
        catch (Exception ex)
        {
        }
        return retList.ToArray();
    }
}