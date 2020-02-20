using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Net.Mail;
using System.Drawing;
using System.Web.Services;

public partial class Calendar : System.Web.UI.Page
{
    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadTitle();

            CheckPermission();


            calendar.Visible = true;
            lnktype.Text = "Calendar";
           
        }
    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 37 });


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

    private void CheckPermission()
    {
        try
        {
            if (Session["UserID"] != null)
            {

                Permission p = new Permission();

                string result = p.GetPermission(Session["UserID"].ToString(), "Tasks");
                string result2 = p.GetPermission(Session["UserID"].ToString(), "Tasks");

                result = result.Trim();
                result2 = result.Trim();

                if ((result.ToString() == "Y"))
                {

                    Session["UserPermission"] = result.ToString();
                    //Response.Redirect("ResidentAdd.aspx");
                }
                else
                {
                    Response.Redirect("Homemenu.aspx");
                    WebMsgBox.Show("You have not permission to view resident module");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    public class Event
    {
        public Int64? EventID { get; set; }
        public String EventName { get; set; }
        public String StartDate { get; set; }
        public String EndDate { get; set; }
        public String Color { get; set; }
        public String url { get; set; }
        public string allDay { get; set; }
        public String imageurl { get; set; }

    }

    [WebMethod]
    public static List<Event> CalCalendar()
    {
        List<Event> tclose;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_GetCalendar", con);
        cmd.CommandType = CommandType.StoredProcedure;
       
        if (con.State.Equals(ConnectionState.Open))
        {
            con.Close();
        }
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();

        tclose = new List<Event>();
        if (dr.HasRows)
        {
            int i = 0;

            while (dr.Read())
            {
                i = i + 1;
                Event _CalendarEvent = new Event();
                DateTime startdate = Convert.ToDateTime(dr["FromDate"].ToString());
                DateTime targetdate = Convert.ToDateTime(dr["TillDate"].ToString());

                string actualtdate = targetdate.ToString("MM/dd/yyyy hh:mm");
                String actualsdate = startdate.ToString("MM/dd/yyyy hh:mm");
                string newactualtdate = targetdate.ToString("MMM dd yyyy");
                String newactualsdate = startdate.ToString("MMM dd yyyy");


                DateTime cdate = DateTime.Now;
                string actualcdate = cdate.ToString("MM/dd/yyyy");
                string formatedtdate = targetdate.ToString("MM/dd/yyyy");
                _CalendarEvent.EventID = Convert.ToInt64(dr["RSN"].ToString());
                _CalendarEvent.StartDate = startdate.DayOfWeek + "," + actualsdate;
                _CalendarEvent.EndDate = targetdate.DayOfWeek + "," + actualtdate;
                String status1 = dr["Status1"].ToString();
                String task = dr["EventName"].ToString();
                string action = dr["Remarks"].ToString();

                _CalendarEvent.EventName = dr["EventName"].ToString();

                //if(status1 == "Conducted")
                //{
                _CalendarEvent.Color = "#79C897";
                _CalendarEvent.url = dr["Description"].ToString() + "\n" + action;
                // }
                //else if (status1 == "Scheduled")
                //{
                //    _CloseEvent.Color = "#FF6633";
                //    _CloseEvent.url = dr["Description"].ToString();
                //}
                //else if (status1 == "Cancelled")
                //{
                //    _CloseEvent.Color = "#FF0000";
                //    _CloseEvent.url = dr["Description"].ToString() + "\n" + action;
                //}
                _CalendarEvent.allDay = "true";
                tclose.Add(_CalendarEvent);
            }
        }
        dr.Close();
        con.Close();
        return tclose;
    }

}