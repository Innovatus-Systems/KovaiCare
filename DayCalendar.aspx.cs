using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Net.Mail;
using System.Drawing;


public partial class DayCalendar : System.Web.UI.Page
{

    SqlProcsNew sqlobj = new SqlProcsNew();

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {

            LoadTitle();

            CheckPermission();

           
            calendar.Visible = false;
            lnktype.Text = "Events & Activities";
            TaskClose.Visible = false;
            dvevents.Visible = true;
            dvNotices.Visible = false;
        }


    }

    private void LoadTitle()
    {
        try
        {
            DataSet dsTitle = sqlobj.ExecuteSP("SP_GetTitleMenus", new SqlParameter() { ParameterName = "@MenuId", SqlDbType = SqlDbType.Int, Value = 37 });


            if (dsTitle.Tables[0].Rows.Count > 0)
            {
                //lnktitle.Text = dsTitle.Tables[0].Rows[0]["Title"].ToString();
                //lnktitle.ToolTip = dsTitle.Tables[0].Rows[0]["Description"].ToString();
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
    public static List<Event> GetEvents()
    {      

            List<Event> events;
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_GetCalenderTasks", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", 1);
            if (con.State.Equals(ConnectionState.Open))
            {
                con.Close();
            }
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();


            events = new List<Event>();
            if (dr.HasRows)
            {
                int i = 0;
                int tot = 0;
                int open = 0;
                int close = 0;

                while (dr.Read())
                {
                    i = i + 1;
                    Event _Event = new Event();
                    DateTime startdate = Convert.ToDateTime(dr["StatusDate"].ToString());
                    DateTime targetdate = Convert.ToDateTime(dr["StatusDate"].ToString());

                    string actualtdate = targetdate.ToString("MM/dd/yyyy hh:mm");
                    String actualsdate = startdate.ToString("MM/dd/yyyy hh:mm");
                    string newactualtdate = targetdate.ToString("MMM dd yyyy");
                    String newactualsdate = startdate.ToString("MMM dd yyyy");


                    DateTime cdate = DateTime.Now;
                    string actualcdate = cdate.ToString("MM/dd/yyyy");
                    string formatedtdate = targetdate.ToString("MM/dd/yyyy");
                    string mobileno = dr["contactcellno"].ToString();
                    _Event.EventID = Convert.ToInt64(dr["RSN"].ToString());
                    _Event.StartDate = startdate.DayOfWeek + "," + actualsdate;
                    _Event.EndDate = targetdate.DayOfWeek + "," + actualtdate;
                    String status = dr["taskstatus"].ToString();
                    String status1 = dr["Status1"].ToString();
                    String task = dr["Task"].ToString();
                    string action = dr["statusremarks"].ToString();

                    if (status1 == "Overdue")
                    {
                        _Event.EventName = dr["Task"].ToString() + "(" + dr["RTVillano"] + ")";
                        _Event.url = dr["AssignedTo"].ToString() + "\n" + mobileno + "\n" + task + "\n" + "ACTION: " + action;
                        _Event.Color = "#FF6633";//Red
                        //_Event.imageurl = "Images/overdue.jpg";
                    }
                    if (actualcdate == formatedtdate)
                    {
                        _Event.EventName = dr["Task"].ToString() + "(" + dr["RTVillano"] + ")";
                        _Event.url = dr["AssignedTo"].ToString() + "\n" + mobileno + "\n" + task + "\n" + "ACTION: " + action;
                        _Event.Color = "";

                    }
                    if (status1 == "Inprogress")
                    {
                        _Event.EventName = dr["Task"].ToString() + "(" + dr["RTVillano"] + ")";
                        _Event.url = dr["AssignedTo"].ToString() + "\n" + mobileno + "\n" + task + "\n" + "ACTION: " + action;
                        _Event.Color = "";//blue
                        //_Event.imageurl = "Images/add.png";
                    }
                    else if (status1 == "Close")
                    {
                        _Event.EventName = dr["Task"].ToString() + "(" + dr["RTVillano"] + ")";
                        _Event.url = dr["AssignedTo"].ToString() + "\n" + mobileno + "\n" + task + "\n" + "ACTION: " + action;
                        _Event.Color = "#ddf6dd";//green
                        //_Event.imageurl = "Images/ok.png";
                    }

                    events.Add(_Event);

                }
            }
            dr.Close();
            con.Close();
            return events;
        }


    [WebMethod]
    public static List<Event> GetTaskClose()
    {
        List<Event> tclose;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_GetCalenderTasks", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Mode", 2);
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
            int tot = 0;
            int open = 0;
            int close = 0;

            while (dr.Read())
            {
                i = i + 1;
                Event _CloseEvent = new Event();
                DateTime startdate = Convert.ToDateTime(dr["StatusDate"].ToString());
                DateTime targetdate = Convert.ToDateTime(dr["StatusDate"].ToString());

                string actualtdate = targetdate.ToString("MM/dd/yyyy hh:mm");
                String actualsdate = startdate.ToString("MM/dd/yyyy hh:mm");
                string newactualtdate = targetdate.ToString("MMM dd yyyy");
                String newactualsdate = startdate.ToString("MMM dd yyyy");


                DateTime cdate = DateTime.Now;
                string actualcdate = cdate.ToString("MM/dd/yyyy");
                string formatedtdate = targetdate.ToString("MM/dd/yyyy");
                string mobileno = dr["contactcellno"].ToString();
                _CloseEvent.EventID = Convert.ToInt64(dr["RSN"].ToString());
                _CloseEvent.StartDate = startdate.DayOfWeek + "," + actualsdate;
                _CloseEvent.EndDate = targetdate.DayOfWeek + "," + actualtdate;
                String status = dr["taskstatus"].ToString();
                String status1 = dr["Status1"].ToString();
                String task = dr["Task"].ToString();
                string action = dr["statusremarks"].ToString();

                //if (status1 == "Overdue")
                //{
                    _CloseEvent.EventName = dr["Task"].ToString() + "(" + dr["RTVillano"] + ")";
                    _CloseEvent.url = dr["AssignedTo"].ToString() + "\n" + mobileno + "\n" + task + "\n" + "ACTION: " + action;
                    _CloseEvent.Color = "#FF6633";//Red
                    //_Event.imageurl = "Images/overdue.jpg";
                //}
                //if (actualcdate == formatedtdate)
                //{
                //    _CloseEvent.EventName = dr["Task"].ToString() + "(" + dr["RTVillano"] + ")";
                //    _CloseEvent.url = dr["AssignedTo"].ToString() + "\n" + mobileno + "\n" + task + "\n" + "ACTION: " + action;
                //    _CloseEvent.Color = "";

                //}
                //if (status1 == "Inprogress")
                //{
                //    _CloseEvent.EventName = dr["Task"].ToString() + "(" + dr["RTVillano"] + ")";
                //    _CloseEvent.url = dr["AssignedTo"].ToString() + "\n" + mobileno + "\n" + task + "\n" + "ACTION: " + action;
                //    _CloseEvent.Color = "";//blue
                //    //_Event.imageurl = "Images/add.png";
                //}
                //else if (status1 == "Done")
                //{
                //    _CloseEvent.EventName = dr["Task"].ToString() + "(" + dr["RTVillano"] + ")";
                //    _CloseEvent.url = dr["AssignedTo"].ToString() + "\n" + mobileno + "\n" + task + "\n" + "ACTION: " + action;
                //    _CloseEvent.Color = "#ddf6dd";//green
                //    //_Event.imageurl = "Images/ok.png";
                //}
                tclose.Add(_CloseEvent);
            }
        }
        dr.Close();
        con.Close();
        return tclose;
    }

    [WebMethod]
    public static List<Event> CalEvents()
    {
        List<Event> tclose;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_GetCalenderTasks", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Mode", 3);
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
                Event _CloseEvent = new Event();
                DateTime startdate = Convert.ToDateTime(dr["FromDate"].ToString());
                DateTime targetdate = Convert.ToDateTime(dr["TillDate"].ToString());

                string actualtdate = targetdate.ToString("MM/dd/yyyy hh:mm");
                String actualsdate = startdate.ToString("MM/dd/yyyy hh:mm");
                string newactualtdate = targetdate.ToString("MMM dd yyyy");
                String newactualsdate = startdate.ToString("MMM dd yyyy");


                DateTime cdate = DateTime.Now;
                string actualcdate = cdate.ToString("MM/dd/yyyy");
                string formatedtdate = targetdate.ToString("MM/dd/yyyy");               
                _CloseEvent.EventID = Convert.ToInt64(dr["RSN"].ToString());
                _CloseEvent.StartDate = startdate.DayOfWeek + "," + actualsdate;
                _CloseEvent.EndDate = targetdate.DayOfWeek + "," + actualtdate;               
                String status1 = dr["Status1"].ToString();
                String task = dr["EventName"].ToString();
                string action = dr["Remarks"].ToString();

                _CloseEvent.EventName = dr["EventName"].ToString();
                
                //if(status1 == "Conducted")
                //{
                    _CloseEvent.Color = "#79C897";
                    _CloseEvent.url = dr["Description"].ToString() + "\n" + action;
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
                _CloseEvent.allDay = "true";
                tclose.Add(_CloseEvent);
            }
        }
        dr.Close();
        con.Close();
        return tclose;
    }

    [WebMethod]
    public static List<Event> CalCalendar()
    {
        List<Event> tclose;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_GetCalenderTasks", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Mode", 4);
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

    [WebMethod]
    public static List<Event> CalNotices()
    {
        List<Event> tclose;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CovaiSoft"].ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_GetCalenderTasks", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Mode", 3);
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
                Event _CloseEvent = new Event();
                DateTime startdate = Convert.ToDateTime(dr["FromDate"].ToString());
                DateTime targetdate = Convert.ToDateTime(dr["TillDate"].ToString());

                string actualtdate = targetdate.ToString("MM/dd/yyyy hh:mm");
                String actualsdate = startdate.ToString("MM/dd/yyyy hh:mm");
                string newactualtdate = targetdate.ToString("MMM dd yyyy");
                String newactualsdate = startdate.ToString("MMM dd yyyy");


                DateTime cdate = DateTime.Now;
                string actualcdate = cdate.ToString("MM/dd/yyyy");
                string formatedtdate = targetdate.ToString("MM/dd/yyyy");
                _CloseEvent.EventID = Convert.ToInt64(dr["RSN"].ToString());
                _CloseEvent.StartDate = startdate.DayOfWeek + "," + actualsdate;
                _CloseEvent.EndDate = targetdate.DayOfWeek + "," + actualtdate;
                String status1 = dr["Status1"].ToString();
                String task = dr["EventName"].ToString();
                string action = dr["Remarks"].ToString();

                _CloseEvent.EventName = dr["EventName"].ToString();

                //if(status1 == "Conducted")
                //{
                _CloseEvent.Color = "#79C897";
                _CloseEvent.url = dr["Description"].ToString() + "\n" + action;
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
                _CloseEvent.allDay = "true";
                tclose.Add(_CloseEvent);
            }
        }
        dr.Close();
        con.Close();
        return tclose;
    }

   
    protected void btncalender_Click(object sender, EventArgs e)
    {
        try
        {
            calendar.Visible = true;            
            TaskClose.Visible = false;
            dvevents.Visible = false;
            dvNotices.Visible = false;
            lnktype.Text = "Calendar";
        }
        catch(Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnevents_Click(object sender, EventArgs e)
    {
        try
        {
            calendar.Visible = false;
            TaskClose.Visible = false;
            dvevents.Visible = true;
            dvNotices.Visible = false;
            lnktype.Text = "Events & Activities";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
    protected void btnservicerequest_Click(object sender, EventArgs e)
    {
        try
        {
            dvevents.Visible = false;
            calendar.Visible = false;
            TaskClose.Visible = true;
            dvNotices.Visible = false;
            lnktype.Text = "Service Requests";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }

    protected void btnNotice_Click(object sender, EventArgs e)
    {
        try
        {
            dvevents.Visible = false;
            calendar.Visible = false;
            TaskClose.Visible = false;
            dvNotices.Visible = true;
            lnktype.Text = "Notices";
        }
        catch (Exception ex)
        {
            WebMsgBox.Show(ex.Message);
        }
    }
}
    
