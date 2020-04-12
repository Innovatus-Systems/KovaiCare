using System;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Web;


/// <summary>
/// Summary description for MailClass
/// </summary>
public class MailClass
{
    public MailClass()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public void EventsMail(string _fromuserid, string _frommailname, string _touserid, string _tomailname, string _cutomername, string eventname, string description,
       DateTime _Followupdate, string _Credentialusername, string _Credentailpassword, string AdminName, string AdminContact, string MobileNo, string title)
    {

        MailMessage msg = new MailMessage();

        var smtpclient = new SmtpClient("smtp.gmail.com", 587)
        {
            Credentials = new NetworkCredential(_Credentialusername.ToString(), _Credentailpassword.ToString()),
            EnableSsl = true,
            Timeout = 100000
        };

        //Note Please change it to correct mail-id to use this in your application
        msg.From = new MailAddress(_fromuserid.ToString(), _frommailname);
        msg.To.Add(new MailAddress(_touserid, _tomailname));

        //if (custEmail != "" && _cutomername != "")
        //{
        //    msg.CC.Add(new MailAddress(custEmail, _cutomername));// it is optional, only if required
        //}

        msg.Subject = eventname.ToString() + " on " + _Followupdate.ToString("dd-MMM-yyyy");

        //_Followupdate.ToString("dd-MM-yyyy", CultureInfo.InvariantCulture)

        StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/EventsMail.html"));
        string readFile = reader.ReadToEnd();
        string myString = "";

        myString = readFile;

        myString = myString.Replace("$$Date$$", _Followupdate.ToString("dd-MMM-yyyy"));
        //myString = myString.Replace("$$Time$$", _Followupdate.ToString("HH:mm"));
        myString = myString.Replace("$$title$$", title);

        myString = myString.Replace("$$PhoneNo$$", MobileNo);
        myString = myString.Replace("$$Description$$", description);

        myString = myString.Replace("$$CompName$$", AdminName.ToString());
        myString = myString.Replace("$$AdminPhoneNo$$", AdminContact.ToString());

        myString = myString.Replace("$$Customer$$", _cutomername.ToString());


        msg.Body = myString.ToString();

        TimeSpan time = new TimeSpan(08, 00, 00);
        TimeSpan endtime = new TimeSpan(00, 30, 00);
        _Followupdate = _Followupdate.Add(time);

        DateTime _enddate = _Followupdate;
        _enddate = _enddate.Add(endtime);


        string strdate = _Followupdate.ToString("yyyyMMdd\\THHmmss");

        String[] contents = { "BEGIN:VCALENDAR",
                              "PRODID:-//Flo Inc.//FloSoft//EN",
                              "BEGIN:VEVENT",
                              "DTSTART:" + _Followupdate.ToString("yyyyMMdd\\THHmmss"),
                              "DTEND:" +  _enddate.ToString("yyyyMMdd\\THHmmss"),
                             "LOCATION:CGI",
                         "DESCRIPTION;ENCODING=QUOTED-PRINTABLE:" ,
                              "SUMMARY:" + msg.Subject, "PRIORITY:3",
                         "END:VEVENT", "END:VCALENDAR" };


        System.IO.File.WriteAllLines(HttpContext.Current.Server.MapPath("EventsMail.ics"), contents);

        Attachment mailAttachment = new Attachment(HttpContext.Current.Server.MapPath("EventsMail.ics"));

        msg.Attachments.Add(mailAttachment);

        //System.Net.Mime.ContentType contype = new System.Net.Mime.ContentType("text/calendar");
        //contype.Parameters.Add("method", "REQUEST");
        //contype.Parameters.Add("name", "Meeting.ics");
        //AlternateView avCal = AlternateView.CreateAlternateViewFromString(str.ToString(), contype);
        //msg.AlternateViews.Add(avCal);

        msg.IsBodyHtml = true;
        smtpclient.Send(msg);

        mailAttachment.Dispose();
    }

    public void SendMail(string _fromuserid, string _frommailname, string _touserid, string _tomailname, string _cutomername, string _reference, string _Comments,
        DateTime _Followupdate, string _Credentialusername, string _Credentailpassword)
    {

        MailMessage msg = new MailMessage();

        var smtpclient = new SmtpClient("smtp.gmail.com", 587)
        {
            Credentials = new NetworkCredential(_Credentialusername.ToString(), _Credentailpassword.ToString()),
            EnableSsl = true,
            Timeout = 100000
        };

        //Note Please change it to correct mail-id to use this in your application
        msg.From = new MailAddress(_fromuserid.ToString(), _frommailname);
        msg.To.Add(new MailAddress(_touserid, _tomailname));
        //msg.CC.Add(new MailAddress("sridhar@innovatussystems.com", "Sridhar"));// it is optional, only if required
        msg.Subject = "Followup scheduled for " + _cutomername;

        //_Followupdate.ToString("dd-MM-yyyy", CultureInfo.InvariantCulture)

        StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("~/Followup.html"));
        string readFile = reader.ReadToEnd();
        string myString = "";

        myString = readFile;
        myString = myString.Replace("$$Customer$$", _cutomername.ToString());
        myString = myString.Replace("$$Reference$$", _reference.ToString());
        myString = myString.Replace("$$Activity$$", _Comments.ToString());


        msg.Body = myString.ToString();

        TimeSpan time = new TimeSpan(08, 00, 00);
        TimeSpan endtime = new TimeSpan(00, 30, 00);
        _Followupdate = _Followupdate.Add(time);

        DateTime _enddate = _Followupdate;
        _enddate = _enddate.Add(endtime);


        string strdate = _Followupdate.ToString("yyyyMMdd\\THHmmss");

        String[] contents = { "BEGIN:VCALENDAR",
                              "PRODID:-//Flo Inc.//FloSoft//EN",
                              "BEGIN:VEVENT",
                              "DTSTART:" + _Followupdate.ToString("yyyyMMdd\\THHmmss"),
                              "DTEND:" +  _enddate.ToString("yyyyMMdd\\THHmmss"),
                             "LOCATION:CGI",
                         "DESCRIPTION;ENCODING=QUOTED-PRINTABLE:" ,
                              "SUMMARY:" + msg.Subject, "PRIORITY:3",
                         "END:VEVENT", "END:VCALENDAR" };


        System.IO.File.WriteAllLines(HttpContext.Current.Server.MapPath("CRMFollowup.ics"), contents);

        Attachment mailAttachment = new Attachment(HttpContext.Current.Server.MapPath("CRMFollowup.ics"));

        msg.Attachments.Add(mailAttachment);

        //System.Net.Mime.ContentType contype = new System.Net.Mime.ContentType("text/calendar");
        //contype.Parameters.Add("method", "REQUEST");
        //contype.Parameters.Add("name", "Meeting.ics");
        //AlternateView avCal = AlternateView.CreateAlternateViewFromString(str.ToString(), contype);
        //msg.AlternateViews.Add(avCal);

        msg.IsBodyHtml = true;
        smtpclient.Send(msg);

        mailAttachment.Dispose();
    }


}