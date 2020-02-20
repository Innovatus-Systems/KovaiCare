<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="CalendarPendingTasks.aspx.cs" Inherits="CalendarPendingTasks" %>

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

    <script type="text/javascript">
        $(document).ready(function () {
            LoadCalendar();
        });
        function LoadCalendar() {
            $.ajax({
                url: '<%= ResolveUrl("CalendarPendingTasks.aspx/CalCalendar") %>',
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

    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <table style="width:100%">
                <tr>
                    <td align="center">
                       <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </td>
                </tr>
                 <tr>
                    <td align="center">
                        <asp:LinkButton ID="lnktype" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </td>
                </tr>
            </table>
            <div id="calendar" runat ="server"></div>
            </div>
    </div>

</asp:Content>
