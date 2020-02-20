<%@ Page Title="Calendar" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DayCalendar.aspx.cs" Inherits="DayCalendar" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="Calendar/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="Calendar/fullcalendar.js" type="text/javascript"></script>
    <link href="Calendar/fullcalendar.css" rel="stylesheet" />
    <script src="Calendar/jquery.validate.js" type="text/javascript"></script>
    <script src="Calendar/moment.js" type="text/javascript"></script>
    <link href="Calendar/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <script src="Calendar/jquery-ui.js" type="text/javascript"></script>
    <script src="Calendar/jquery.timepicker.js" type="text/javascript"></script>
    <link href="Calendar/jquery.timepicker.css" rel="Stylesheet" />
    <script src="Calendar/lib/site.js" type="text/javascript"></script>
    <link href="Calendar/lib/site.css" rel="stylesheet" />

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <%--//-----------------------------------------------------------------------------------------------//--%>
    <%-- <script type="text/javascript">
        $(document).ready(function () {
            DisplayCalendarByUsers();
        });
       
       
        function DisplayCalendarByUsers() {
            $.ajax({
                url: '<%= ResolveUrl("DayCalendar.aspx/GetEvents") %>',
                  type: "POST",
                  data: "{}",
                  contentType: "application/json",
                  dataType: "json",
                  success: function (data) {
                      //alert(data.d);
                      $('div[id*=calendar]').fullCalendar({
                          header: {
                              left: 'prev,next today',
                              center: 'title',
                              right: 'month,agendaWeek,agendaDay'
                          },
                          height: 600,
                          selectable: true,
                          theme: true,
                          editable: true,
                          droppable: true,
                          draggable: true,
                          selectable: true,
                          selectHelper: true,
                          events:
                          $.map(data.d, function (item, i) {

                              var event = new Object();
                              event.id = item.EventID;
                              event.start = item.StartDate;
                              event.end = item.StartDate;
                              event.title = item.EventName;
                              event.description = item.url;
                              event.color = item.Color;
                              event.allDay = item.allDay;
                              event.imageurl = item.imageurl;
                              return event;
                          }),
                          select: function (calEvent, start, allday) {
                              //alert(calEvent.title);
                              if (calEvent.title != 'Holiday' || calEvent.title != 'undefined') {
                                  var check = $.fullCalendar.formatDate(start, 'yyyy-MM-dd');
                                  var today = $.fullCalendar.formatDate(new Date(), 'yyyy-MM-dd');
                                  var startformat = $.fullCalendar.formatDate(start, 'MM/dd/yyyy hh:mm')
                                  var url = "TaskList.aspx?Value1=1&Value2=" + startformat;
                                  var Passdate = $.fullCalendar.formatDate(start, 'dd-MMM-yyyy');
                                  //alert(check);
                                  //alert(today);

                                  if (check < today) {
                                      alert('Please select future date');
                                      return;
                                  } else {
                                      OpenTaskList(start, url);
                                      //Navigate(Passdate);  
                                      //GetApptCounts(check);
                                      //OpenModelPopup(check);
                                  }
                              }
                          },
                          eventMouseover: function (event, jsEvent) {
                              //alert(event.title);  
                              var sdate = $.fullCalendar.formatDate(event.start, 'hh:mm');
                              $(jsEvent.target).attr('title', event.description);
                          },
                          eventRender: function (event, element) {
                              if (event.imageurl) {
                                  element.find(".fc-event-time").before($("<span class=\"fc-event-icons\"></span>").html("<img src='" + event.imageurl + "' height='12px' width='12px'>"));
                              }
                          }
                      });
                  },
                  error: function (XMLHttpRequest, textStatus, errorThrown) {
                      debugger;
                  }
              });
              function OpenTaskList(start, url) {
                  newwindow = window.open(url, 'name', 'height=650,width=1150,left=80,right=50,bottom=50,top=20,toolbar=no,menubar=no,scrollbars=no,location=center,directories=no');
                  if (window.focus) { newwindow.focus() }
                  return false;
              }
          }
    </script>--%>


    <%--//-----------------------------------------------------------------------------------------------//--%>

    <script type="text/javascript">
        $(document).ready(function () {
            LoadCalendar();
        });
        function LoadCalendar() {
            $.ajax({
                url: '<%= ResolveUrl("DayCalendar.aspx/CalCalendar") %>',
                type: "POST",
                data: "{}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    //alert(data.d);
                    $('div[id*=calendar]').fullCalendar({
                        header: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'month,agendaWeek'
                        },
                        height: 600,
                        selectable: true,
                        theme: true,
                        editable: true,
                        droppable: true,
                        draggable: true,
                        selectable: true,
                        selectHelper: true,
                        events:
                        $.map(data.d, function (item, i) {
                            var event = new Object();
                            event.id = item.EventID;
                            event.start = item.StartDate;
                            event.end = item.StartDate;
                            event.title = item.EventName;
                            event.description = item.url;
                            event.color = item.Color;
                            event.allDay = item.allDay;
                            return event;
                        }),
                        select: function (calEvent, start, allday) {
                        },
                        eventMouseover: function (event, jsEvent) {
                            var sdate = $.fullCalendar.formatDate(event.start, 'hh:mm');
                            $(jsEvent.target).attr('title', event.description);
                        },
                        eventRender: function (event, element) {
                        }
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    debugger;
                }
            });

        }
    </script>

    <%//--------------------// %>
    <script type="text/javascript">
        $(document).ready(function () {
            LoadEvents();
        });
        function LoadEvents() {
            $.ajax({
                url: '<%= ResolveUrl("DayCalendar.aspx/CalEvents") %>',
                type: "POST",
                data: "{}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    //alert(data.d);
                    $('div[id*=dvevents]').fullCalendar({
                        header: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'month,agendaWeek'
                        },
                        height: 600,
                        selectable: true,
                        theme: true,
                        editable: true,
                        droppable: true,
                        draggable: true,
                        selectable: true,
                        selectHelper: true,
                        events:
                        $.map(data.d, function (item, i) {
                            var event = new Object();
                            event.id = item.EventID;
                            event.start = item.StartDate;
                            event.end = item.StartDate;
                            event.title = item.EventName;
                            event.description = item.url;
                            event.color = item.Color;
                            event.allDay = item.allDay;
                            return event;
                        }),
                        select: function (calEvent, start, allday) {
                        },
                        eventMouseover: function (event, jsEvent) {
                            var sdate = $.fullCalendar.formatDate(event.start, 'hh:mm');
                            $(jsEvent.target).attr('title', event.description);
                        },
                        eventRender: function (event, element) {
                        }
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    debugger;
                }
            });

        }
    </script>

    <%//--------------------------------// %>

    <script type="text/javascript">
        $(document).ready(function () {
            DisplayCalendarTaskClose();
        });
        function DisplayCalendarTaskClose() {
            $.ajax({
                url: '<%= ResolveUrl("DayCalendar.aspx/GetTaskClose") %>',
                type: "POST",
                data: "{}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    //alert(data.d);
                    $('div[id*=TaskClose]').fullCalendar({
                        header: {
                            left: 'prev,next today',
                            center: 'title',
                            right: 'month,agendaWeek,agendaDay'
                        },
                        height: 600,
                        selectable: true,
                        theme: true,
                        editable: true,
                        droppable: true,
                        draggable: true,
                        selectable: true,
                        selectHelper: true,
                        events:
                        $.map(data.d, function (item, i) {

                            var event = new Object();
                            event.id = item.EventID;
                            event.start = item.StartDate;
                            event.end = item.StartDate;
                            event.title = item.EventName;
                            event.description = item.url;
                            event.color = item.Color;
                            event.allDay = item.allDay;
                            event.imageurl = item.imageurl;
                            return event;
                        }),
                        select: function (calEvent, start, allday) {
                            //alert(calEvent.title);
                            if (calEvent.title != 'Holiday' || calEvent.title != 'undefined') {
                                var check = $.fullCalendar.formatDate(start, 'yyyy-MM-dd');
                                var today = $.fullCalendar.formatDate(new Date(), 'yyyy-MM-dd');
                                var startformat = $.fullCalendar.formatDate(start, 'MM/dd/yyyy hh:mm')
                                var url = "TaskList.aspx?Value1=1&Value2=" + startformat;
                                var Passdate = $.fullCalendar.formatDate(start, 'dd-MMM-yyyy');
                                //alert(check);
                                //alert(today);

                                if (check < today) {
                                    alert('Please select future date');
                                    return;
                                } else {
                                    OpenTaskList(start, url);
                                    //Navigate(Passdate);  
                                    //GetApptCounts(check);
                                    //OpenModelPopup(check);
                                }
                            }
                        },
                        eventMouseover: function (event, jsEvent) {
                            //alert(event.title);  
                            var sdate = $.fullCalendar.formatDate(event.start, 'hh:mm');
                            $(jsEvent.target).attr('title', event.description);
                        },
                        eventRender: function (event, element) {
                            if (event.imageurl) {
                                element.find(".fc-event-time").before($("<span class=\"fc-event-icons\"></span>").html("<img src='" + event.imageurl + "' height='12px' width='12px'>"));
                            }
                        }
                    });
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    debugger;
                }
            });
            function OpenTaskList(start, url) {
                newwindow = window.open(url, 'name', 'height=650,width=1150,left=80,right=50,bottom=50,top=20,toolbar=no,menubar=no,scrollbars=no,location=center,directories=no');
                if (window.focus) { newwindow.focus() }
                return false;
            }
        }
    </script>

    <%//--------------------------------// %>

    <script type="text/javascript">
        $(document).ready(function () {
            LoadNotices();
        });
        function LoadNotices() {
            $.ajax({
                url: '<%= ResolveUrl("DayCalendar.aspx/CalNotices") %>',
                 type: "POST",
                 data: "{}",
                 contentType: "application/json",
                 dataType: "json",
                 success: function (data) {
                     //alert(data.d);
                     $('div[id*=dvNotices]').fullCalendar({
                         header: {
                             left: 'prev,next today',
                             center: 'title',
                             right: 'month,agendaWeek'
                         },
                         height: 600,
                         selectable: true,
                         theme: true,
                         editable: true,
                         droppable: true,
                         draggable: true,
                         selectable: true,
                         selectHelper: true,
                         events:
                         $.map(data.d, function (item, i) {
                             var event = new Object();
                             event.id = item.EventID;
                             event.start = item.StartDate;
                             event.end = item.StartDate;
                             event.title = item.EventName;
                             event.description = item.url;
                             event.color = item.Color;
                             event.allDay = item.allDay;
                             return event;
                         }),
                         select: function (CalNotices, start, allday) {
                         },
                         eventMouseover: function (event, jsEvent) {
                             var sdate = $.fullCalendar.formatDate(event.start, 'hh:mm');
                             $(jsEvent.target).attr('title', event.description);
                         },
                         eventRender: function (event, element) {
                         }
                     });
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     debugger;
                 }
             });

         }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <table style="width: 100%">
                <%--<tr>
                    <td align="center">
                       <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </td>
                </tr>--%>
                <tr>

                    <td>
                        <asp:Button ID="btnevents" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" ToolTip="Click to view the calendar of events & activities for the present month. Click the arrow keys below, to view calendar for different months." runat="server" Text="Events" Width="100px" OnClick="btnevents_Click" />
                        <asp:Button ID="btnNotice" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" ToolTip="Click to view the notices for the present month. Click the arrow keys below, to view calendar for different months." runat="server" Text="Notice" Width="100px" OnClick="btnNotice_Click" />
                        <asp:Button ID="btncalender" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" ToolTip="Click here to view the social, religious, commercial or administrative information for the present month. Click the arrow keys below, to view calendar for different months." runat="server" Text="Calendar" Width="100px" OnClick="btncalender_Click" />
                        <asp:Button ID="btnservicerequest" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" ToolTip="Click to view the registered service requests and their status for the present month. Click the arrow keys below, to view for different months." runat="server" Text="Service Requests" Width="110px" OnClick="btnservicerequest_Click" />


                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <%--<asp:LinkButton ID="lnktype" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>--%>
                        <asp:Label ID="lnktype" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
            </table>
            <div id="calendar" runat="server"></div>
            <div id="TaskClose" runat="server"></div>
            <div id="dvevents" runat="server"></div>
            <div id="dvNotices" runat="server"></div>
        </div>
    </div>

</asp:Content>

