<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="WorkSchedule.aspx.cs" Inherits="WorkSchedule" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
     <style type="text/css">
        
.Loadingdiv {
     position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 2;
    -moz-opacity: 0.8;
}

.centerdiv
{
    z-index: 1000;
    margin: 300px auto;
    padding: 10px;
    width: 130px;
    background-color: White;
    border-radius: 10px;
    filter: alpha(opacity=100);
    opacity: 2;
    -moz-opacity: 1;
}
.centerdiv img
{
    height: 128px;
    width: 110px;
}

    </style>
    <style type="text/css">
        .HkLabel {
            display: inline-block;
            font-size: small;
            font-family: Verdana;
            background-color: limegreen;
            border: 2px solid inset;
            font-weight: bold;
        }
    </style>

    <style type="text/css">
        .button_example {
            border: 1px solid #25729a;
            -webkit-border-radius: 3px;
            font-stretch: normal;
            -moz-border-radius: 3px;
            border-radius: 3px;
            font-size: 12px;
            font-family: verdana, sans-serif;
            padding: 5px 5px 5px 5px;
            text-decoration: none;
            display: inline-block;
            text-shadow: -1px -1px 0 rgba(0,0,0,0.3);
            font-weight: bold;
            color: #FFFFFF;
            background-color: #3093c7;
            background-image: -webkit-gradient(linear, left top, left bottom, from(#3093c7), to(#1c5a85));
            background-image: -webkit-linear-gradient(top, #3093c7, #1c5a85);
            background-image: -moz-linear-gradient(top, #3093c7, #1c5a85);
            background-image: -ms-linear-gradient(top, #3093c7, #1c5a85);
            background-image: -o-linear-gradient(top, #3093c7, #1c5a85);
            background-image: linear-gradient(to bottom, #3093c7, #1c5a85);
            filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr=#3093c7, endColorstr=#1c5a85);
        }

            .button_example:hover {
                border: 1px solid #1c5675;
                background-color: #26759e;
                background-image: -webkit-gradient(linear, left top, left bottom, from(#26759e), to(#133d5b));
                background-image: -webkit-linear-gradient(top, #26759e, #133d5b);
                background-image: -moz-linear-gradient(top, #26759e, #133d5b);
                background-image: -ms-linear-gradient(top, #26759e, #133d5b);
                background-image: -o-linear-gradient(top, #26759e, #133d5b);
                background-image: linear-gradient(to bottom, #26759e, #133d5b);
                filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr=#26759e, endColorstr=#133d5b);
            }
    </style>


    <script type="text/javascript">

        function BulkClick() {
            document.getElementById('<%=Button3.ClientID%>').click();
        }
        function PendingBulkClick() {
            document.getElementById('<%=Button1.ClientID%>').click();
        }
        function PendingBulkUpdateClick() {
            document.getElementById('<%=btnPendingBulkupdate.ClientID%>').click();
        }
    </script>

    <script type="text/javascript">
        function chkvalue() {
            var starttime = $find("<%=dtpfromTime.ClientID %>").get_dateInput().get_value();
            var endtime = $find("<%=dtptoTime.ClientID %>").get_dateInput().get_value();
            if (starttime != null && endtime != null && starttime != "" && endtime != "") {
                var startDate = new Date("1/1/1900 " + starttime);
                var endDate = new Date("1/1/1900 " + endtime);
                var difftime = endDate.getTime() - startDate.getTime();
                difftime /= 1000;
                var hrstomins = difftime / 60;
                var hours = parseFloat(difftime / 3600);
                //var mins = parseInt((difftime % 3600) / 60);
                var mins = parseFloat(hours * 60);

                document.getElementById('<%=txtestimatedmins.ClientID %>').value = mins;

                if (startDate >= endDate) {
                    alert("To Time must be greater than From time");
                    endtime.set_selectedDate(null);
                }
                else {
                    //alert(hours);
                }
            }
            else {
                //alert("No need to Check Any Conditions")
            }
        }
    </script>

    <script type="text/javascript">


        function alertmsg() {
            var x = confirm('You are about to change the status of activities you have selected.This may be irreversible confirm.', "Alert");
            if (x) {
                BulkClick();
                //return true;
            }
            else {
                //return false;
            }
        }

        function alertmsgPending() {
            var x = confirm('You are about to change the status of activities you have selected.This may be irreversible confirm.', "Alert");
            if (x) {
                PendingBulkClick();
                //return true;
            }
            else {
                //return false;
            }
        }

        function alertmsg1() {
            alert('Do you wish to write a common remark and/or update status for more than one activity? If so, Select two or more activities first');
        }
        function confirmbulk(count, update) {
            //alert(count);
            var len = count;
            var lupdate = update;
            alert('Total number of selected tasks : ' + len + '\n' + 'Total number of updated tasks : ' + lupdate);
        }
        function BulkValidate() {
            var summ = "";
            summ += comments();


            if (summ != "") {
                alert(summ);
                return false;
            } else {
                var x = confirm('Do you want to save?');
                if (x)
                    return true;
                else
                    return false;
            }
        }


        function PendingBulkValidate() {
            var summ = "";
            summ += Pendingcomments();


            if (summ != "") {
                alert(summ);
                return false;
            } else {
                var x = confirm('Do you want to save?');
                if (x)
                    return true;
                else
                    return false;
            }
        }


        function comments() {
            var comm = document.getElementById('<%=txtbulktext.ClientID%>').value;
            if (comm == "") {
                return "Please enter comments";
            } else {
                return "";
            }
        }


        function Pendingcomments() {
            var Pendingcomments = document.getElementById('<%=txtPendingRemarks.ClientID%>').value;
            if (Pendingcomments == "") {
                return "Please enter remarks";
            } else {
                return "";
            }
        }


        function SaveValidate() {
            var vali = "";

            vali += Task();
            vali += AssignedTo();
            vali += Site();
            vali += Location();


            if (vali == "") {
                var result = confirm('Do you want to add?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            }
            else {
                alert(vali);
                return false;
            }

        }

        function Task() {
            var Task = document.getElementById('<%= ddlTask.ClientID %>').value;

            if (Task == "--Select--") {
                return "Please select a task" + "\n";
            }
            else {
                return "";
            }
        }

        function AssignedTo() {
            var AssignedTo = document.getElementById('<%= ddlAssignedTo.ClientID %>').value;


            if (AssignedTo == "--Select--") {
                return "Please select a Staff name" + "\n";
            }
            else {
                return "";
            }

        }

        function Site() {
            var Site = document.getElementById('<%= ddlSite.ClientID %>').value;

            if (Site == "0") {
                return "Please select a site" + "\n";
            }
            else {
                return "";
            }

        }

        function Location() {
            var isvisible = document.getElementById('<%= txtLocation.ClientID %>');


             if (isvisible) {
                 var location = document.getElementById('<%= txtLocation.ClientID %>').value;

                 if (location == "") {
                     return "Please enter the location"
                 }
                 else {
                     return "";
                 }
             }
             else {

                 var location = document.getElementById('<%= cmbResident.ClientID %>').value;

                 if (location == "0") {
                     return "Please select a location"
                 }
                 else {
                     return "";
                 }


             }

         }



         function TaskConfirmMsg2() {

             var result = confirm('Do you want to update?');

             if (result) {

                 document.getElementById('<%=CnfResult.ClientID%>').value = "true";
             }
             else {
                 document.getElementById('<%=CnfResult.ClientID%>').value = "false";
             }

         }

         function TaskConfirmCopy() {

             var from = document.getElementById('<%= dtpFrom.ClientID %>').value;
             var to = document.getElementById('<%= dtpTo.ClientID %>').value;


             var result = confirm('Do you want to Copy this House keeping Schedule ?');

             if (result) {

                 document.getElementById('<%=CnfResult.ClientID%>').value = "true";
             }
             else {
                 document.getElementById('<%=CnfResult.ClientID%>').value = "false";
             }

         }

    </script>
    <style>
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <div class="main_cnt">
                <div class="first_cnt" style="min-height: 450px">
                    <div style="font-family: Verdana; font-size: small;">
                        <asp:HiddenField ID="hbtnRSN" runat="server" />
                        <asp:HiddenField ID="CnfResult" runat="server" />
                        <asp:Button ID="btnHelp" runat="server" Text="Help?" CssClass="Button" Visible="false" ToolTip="" />

                        <table style="width: 100%;">

                            <tr>
                                <td align="center">
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>



                            </tr>

                            <tr>
                                <td>
                                    <asp:Button ID="Button3" runat="server" Text="WS Get Latest" OnClick="Button3_Click" CssClass="hidden" CausesValidation="false" />
                                    <asp:Button ID="Button1" runat="server" Text="WS Get Latest" OnClick="Button1_Click" CssClass="hidden" CausesValidation="false" />
                                    <asp:UpdatePanel ID="upnlbulk" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <telerik:RadWindow ID="rwBulkUpdate" Skin="Default" CssClass="preference" ReloadOnShow="true" Behaviors="None" Animation="None" CenterIfModal="true" BackColor="Gray" BorderColor="Blue" Title="Bulk Update" runat="server" BorderStyle="Solid" Modal="true" Height="380" Width="500">
                                                <ContentTemplate>
                                                    <table style="width: 100%; font-family: Verdana; font-size: small;">
                                                        <%--<tr>
                                                    <td colspan="2" align="center">
                                                        <asp:Label ID="lblbulkhead" CssClass="style2" runat="server" Font-Size="Large" Text="Bulk Update"></asp:Label>
                                                    </td>
                                                </tr>--%>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID="lblbulktext" CssClass="style3" Text="Enter Remarks for all selected activities :" runat="server" Font-Size="Medium"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtbulktext" ToolTip="Write here notes about the progress of the task in detail. Do not be cryptic. It will save time later" runat="server" TextMode="MultiLine" Height="75px" Width="250px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Label ID="Label17" CssClass="style3" Text="New status for all selected taks :" runat="server" Font-Size="Medium"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlbulkstatus" runat="server" Width="250px" CssClass="style3" ToolTip="Set status to Completed if this work is now done. Caution! You cannot undo the action.">
                                                                    <asp:ListItem Text="Scheduled" Value="00"></asp:ListItem>
                                                                    <asp:ListItem Text="Done" Value="20"></asp:ListItem>
                                                                    <asp:ListItem Text="Cancelled" Value="90"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <asp:Button ID="btnbulksubmit" ToolTip="Click here to update status and details to you have selected tasks." OnClientClick="return BulkValidate()" runat="server" Text="Save" CssClass="btnMainpage" OnClick="btnbulksubmit_Click" />
                                                                <asp:Button ID="btnbulkclose" ToolTip="click here to close the screen and return back to home." OnClientClick="ConfirmClick()" runat="server" Text="Close" CssClass="btnMainpage" OnClick="btnbulkclose_Click" />
                                                            </td>
                                                        </tr>
                                                        <tr align="center">
                                                            <td colspan="2">
                                                                <asp:Label ID="lbl1" runat="server" Text="You can write one common remark for all selected tasks." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label><br />
                                                                <asp:Label ID="Label18" runat="server" Text="You can also update status of all the selected tasks." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label><br />
                                                                <asp:Label ID="Label22" runat="server" Text="Use this option only if the remarks to be entered are the same or if you wish to mark as 'Done' several tasks in one-shot." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </telerik:RadWindow>

                                        </ContentTemplate>

                                    </asp:UpdatePanel>



                                </td>
                            </tr>
                            <tr>
                                <td>

                                    <telerik:RadWindow ID="rwPendingBulk" Skin="Default" CssClass="preference" ReloadOnShow="true" Behaviors="None" Animation="None" CenterIfModal="true" BackColor="Gray" BorderColor="Blue" 
                                        Title="Pending Bulk Update" runat="server" BorderStyle="Solid" Modal="true" Height="380" Width="500">
                                        <ContentTemplate>
                                            <table style="width: 100%; font-family: Verdana; font-size: small;">
                                                <%--<tr>
                                                    <td colspan="2" align="center">
                                                        <asp:Label ID="lblbulkhead" CssClass="style2" runat="server" Font-Size="Large" Text="Bulk Update"></asp:Label>
                                                    </td>
                                                </tr>--%>
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="Label25" CssClass="style3" Text="Enter Remarks for all selected activities :" runat="server" Font-Size="Medium"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPendingRemarks" ToolTip="Write here notes about the progress of the task in detail. Do not be cryptic. It will save time later" runat="server" TextMode="MultiLine" Height="75px" Width="250px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <asp:Label ID="Label26" CssClass="style3" Text="New status for all selected taks :" runat="server" Font-Size="Medium"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlPendingstatus" runat="server" Width="250px" CssClass="style3" ToolTip="Set status to Completed if this work is now done. Caution! You cannot undo the action.">
                                                            <asp:ListItem Text="Scheduled" Value="00"></asp:ListItem>
                                                            <asp:ListItem Text="Done" Value="20"></asp:ListItem>
                                                            <asp:ListItem Text="Cancelled" Value="90"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td>
                                                        <asp:Button ID="Button2" runat="server" Text="Update" OnClick="btnPendingBulkupdate_Click" />

                                                        <asp:Button ID="btnPendingUpdate" ToolTip="Click here to update status and details to you have selected tasks." OnClientClick="return PendingBulkValidate()" runat="server" Text="Save" CssClass="btnMainpage" OnClick="btnPendingUpdate_Click" />
                                                        <asp:Button ID="btnPendingClose" ToolTip="click here to close the screen and return back to home." OnClientClick="ConfirmClick()" runat="server" Text="Close" CssClass="btnMainpage" OnClick="btnPendingClose_Click" />
                                                    </td>
                                                </tr>
                                                <tr align="center">
                                                    <td colspan="2">
                                                        <asp:Label ID="Label27" runat="server" Text="You can write one common remark for all selected tasks." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label><br />
                                                        <asp:Label ID="Label28" runat="server" Text="You can also update status of all the selected tasks." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label><br />
                                                        <asp:Label ID="Label31" runat="server" Text="Use this option only if the remarks to be entered are the same or if you wish to mark as 'Done' several tasks in one-shot." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadWindow ID="rwEditWorkSchedule" Width="450" Height="425px" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnHelp.ClientID  %>" Title="Update Schedule" Modal="true">
                                        <ContentTemplate>

                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>

                                                    <div>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label1" runat="Server" Text="Date:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblDate" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label4" runat="Server" Text="Task:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblTask" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label5" runat="Server" Text="Person Name:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblPersonName" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label9" runat="Server" Text="Location:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbllocation" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label11" runat="Server" Text="Location Desc:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbllocationdesc" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label44" runat="Server" Text="Start Time:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadTimePicker ID="dtpfromTime" runat="server" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                                                        <TimeView ID="TimeView6" runat="server">
                                                                        </TimeView>
                                                                        <ClientEvents OnDateSelected="chkvalue" />
                                                                    </telerik:RadTimePicker>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label45" runat="Server" Text="End Time:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadTimePicker ID="dtptoTime" runat="server" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                                                        <TimeView ID="TimeView1" runat="server">
                                                                        </TimeView>
                                                                        <ClientEvents OnDateSelected="chkvalue" />
                                                                    </telerik:RadTimePicker>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label16" runat="Server" Text="Completed(mins):" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtestimatedmins" runat="server" Width="220px" MaxLength="40" ToolTip=""></asp:TextBox>
                                                                </td>
                                                            </tr>


                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label13" runat="Server" Text="Remarks:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtUpdateRemarks" runat="server" TextMode="MultiLine" Height="80px" Width="220px" MaxLength="40" ToolTip=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label14" runat="Server" Text="Status:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlStatus" runat="server" ToolTip="Select the status of the task" Height="23px" Width="150px">
                                                                        <asp:ListItem Text="Scheduled" Value="00"></asp:ListItem>
                                                                        <asp:ListItem Text="Done" Value="20"></asp:ListItem>
                                                                         <asp:ListItem Text="Not Done" Value="30"></asp:ListItem>
                                                                        <asp:ListItem Text="Cancelled" Value="90"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Button ID="btnUpdate" OnClientClick="javascript:return TaskConfirmMsg2()" ToolTip="Click here to update the house keeping status" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnUpdate" />
                                                </Triggers>
                                            </asp:UpdatePanel>

                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>

                        </table>

                        <table style="width: 50%;">

                            <tr>
                                <td>
                                    <%--<asp:Label ID="Label23" runat="server" Text="Daily Schedule" Font-Underline="true"  CssClass="HkLabel" ></asp:Label>--%>
                                    <asp:Button ID="btnDailySchedule" runat="server" Text="Daily Schedule" ToolTip="Assign new tasks for a day" CssClass="button_example" OnClick="btnDailySchedule_Click" />
                                </td>
                                <td>
                                    <%--<asp:Label ID="Label24" runat="server" Text="Schedule for a month" Font-Underline="true"  CssClass="HkLabel" ></asp:Label>--%>
                                    <asp:Button ID="btnSchedule" runat="server" Text="Schedule for a month" ToolTip="Assign new routine tasks for a range of dates" CssClass="button_example" OnClick="btnSchedule_Click" />
                                </td>
                                <td>
                                    <%--<asp:Label ID="Label26" runat="server" Text="Pending" Font-Underline="true" ToolTip="View pending tasks from previous days" CssClass="HkLabel"></asp:Label>--%>
                                    <asp:Button ID="btnPending" runat="server" Text="View All Tasks" ToolTip="" Font-Names="Verdana" CssClass="button_example" B OnClick="btnPending_Click" />
                                </td>

                                <td>
                                    <%--<asp:Label ID="Label26" runat="server" Text="Pending" Font-Underline="true" ToolTip="View pending tasks from previous days" CssClass="HkLabel"></asp:Label>--%>
                                    <asp:Button ID="btnViewTaskList" runat="server" Text="View Scheduled Task" ToolTip="" Font-Names="Verdana" CssClass="button_example" OnClick="btnViewTaskList_Click" />
                                </td>

                                <td>
                                    <%--<asp:Label ID="Label26" runat="server" Text="Pending" Font-Underline="true" ToolTip="View pending tasks from previous days" CssClass="HkLabel"></asp:Label>--%>
                                    <asp:Button ID="btnCalendar" runat="server" Text="Calendar of Pending Tasks" ToolTip="" Font-Names="Verdana" CssClass="button_example" OnClick="btnCalendar_Click" />
                                </td>

                            </tr>

                        </table>


                        <table style="width: 100%;">

                            <tr>
                                <td>
                                    <div id="dvDailySchedule" runat="server">

                                        <table cellpadding="5">

                                            <tr>
                                                <td colspan="7" align="center">
                                                    <asp:Label ID="Label39" runat="Server" Text="Daily Schedule" ForeColor="DarkGreen" Font-Names="verdana" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="7">
                                                    <asp:Label ID="Label8" runat="Server" Text="Date" ForeColor="Black" Font-Names="verdana"></asp:Label>

                                                    <telerik:RadDatePicker ID="dtpdate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select a date for which you wish to set a Work Schedule.  If you wish to set a schedule for a whole month / week, use the Copy option." AutoPostBack="true" OnSelectedDateChanged="dtpdate_SelectedDateChanged">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>




                                                    <%-- <telerik:RadDatePicker ID="dtpCopyfrom" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date for which you wish to view the Diners Count." AutoPostBack="true" OnSelectedDateChanged="dtpdate_SelectedDateChanged" >
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>--%>

                                                </td>

                                            </tr>

                                            <tr>
                                                <td>

                                                    <table>

                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label6" runat="Server" Text="Category" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                                <asp:DropDownList ID="ddlCategory" runat="server" ToolTip="Select the Appropriate Category of the task." Height="23px" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                                                                </asp:DropDownList><br />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label2" runat="Server" Text="Task" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                                <asp:DropDownList ID="ddlTask" runat="server" ToolTip="Select the task to be done" Height="23px" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="ddlTask_SelectedIndexChanged">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label3" runat="Server" Text="Assigned To" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                                <asp:DropDownList ID="ddlAssignedTo" runat="server" ToolTip="Select a staff for whom the task to be assigned" Height="23px" Width="150px">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label7" runat="Server" Text="Site" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                                <asp:DropDownList ID="ddlSite" runat="server" Height="23px" Width="150px" ToolTip="Select the site where the task is done" AutoPostBack="true" OnSelectedIndexChanged="ddlSite_SelectedIndexChanged">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label20" runat="Server" Text="Location" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                                <asp:TextBox ID="txtLocation" runat="server" Height="20px" Width="150px" MaxLength="40" ToolTip="Enter the location."></asp:TextBox>
                                                              <%--  <telerik:RadAutoCompleteBox ID="racHKResident" Font-Names="verdana" Width="250px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource3" runat="server" DataTextField="DoorNo" DataValueField="DoorNo" InputType="Text" MinFilterLength="1"
                                                                    EmptyMessage="Choose ResidentID / DoorNo / Name " ToolTip="Choose the ResidentID / DoorNo / Name to view the customer details" AutoPostBack="true" TextSettings-SelectionMode="Single">
                                                                    <TextSettings SelectionMode="Single" />
                                                                </telerik:RadAutoCompleteBox>--%>

                                                                <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                                                                        Width="250px" ToolTip="" 
                                                                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                                                                    </telerik:RadComboBox>

                                                                <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select  DoorNo + ',' +  Type + ',' + Status as DoorNo from tblvillamaster order by DoorNo asc"></asp:SqlDataSource>
                                                            </td>
                                                            <td>

                                                                <asp:Label ID="Label10" runat="Server" Text="Remarks" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                                <asp:TextBox ID="txtRemarks" runat="server" Height="20px" Width="150px" MaxLength="40" ToolTip="Enter if there is any remarks."></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <br />
                                                                <asp:Button ID="btnAdd" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to add the assigned task" OnClick="btnAdd_Click" runat="server" Text="Add" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                                            </td>

                                                        </tr>

                                                    </table>

                                                </td>

                                            </tr>

                                            <tr>
                                                <td colspan="7">
                                                    <asp:Label ID="lbldepartment" runat="server" Text="" BackColor="Yellow" ForeColor="Red"></asp:Label>

                                                </td>

                                            </tr>

                                            <tr>
                                                <td colspan="7">
                                                    <asp:Label ID="Label29" runat="server" Text="Staff" Font-Names="verdana"></asp:Label>
                                                    <asp:DropDownList ID="ddlStaff" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStaff_SelectedIndexChanged" ToolTip="Select the staff for the task to be assigned."></asp:DropDownList>
                                                    <asp:Label ID="Label30" runat="server" Text="Work Type" Font-Names="verdana"></asp:Label>

                                                    <asp:DropDownList ID="ddlWorkType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlWorkType_SelectedIndexChanged" ToolTip="Select type of work.">
                                                    </asp:DropDownList>


                                                    <asp:Button ID="btnMainbulkupdate" runat="server" Text="Bulk Update" CssClass="btnMainpage" BackColor="#6CA5BC" ToolTip="Select one or more tasks, and write progress of work in each task ." OnClick="btnMainbulkupdate_Click" />

                                                    <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="gvWorkSchedule" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" 
                                                        OnItemCommand="gvWorkSchedule_ItemCommand" Width="96%" AllowFilteringByColumn="true"
                                                         AllowPaging="false" PageSize="10" OnItemDataBound="gvWorkSchedule_ItemDataBound" OnInit="gvWorkSchedule_Init">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                        </ClientSettings>
                                                        <MasterTableView>
                                                            <Columns>
                                                                <telerik:GridTemplateColumn HeaderText="Select & Update"   HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  Exportable="false" AllowFiltering="false">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="ToggleSelectedState" AutoPostBack="True"  />
                                                                        </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkJSel" runat="server" />
                                                                        
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false"  >
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the house keeping task details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RSN") %>' CommandArgument='<%# Eval("RSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                             

                                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" ReadOnly="true" AllowFiltering="false" HeaderTooltip="Click here to sort for date." ItemStyle-Width="7%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Department" DataField="deptname" ReadOnly="true" HeaderTooltip="Click here to sort for catgory." FilterControlWidth="65%" ItemStyle-Width="10%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Category" DataField="Category" ReadOnly="true" HeaderTooltip="Click here to sort for catgory." FilterControlWidth="65%" ItemStyle-Width="10%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Task" DataField="taskid" ReadOnly="true" HeaderTooltip="Click here to sort for task." FilterControlWidth="65%" ItemStyle-Width="10%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Assigned To" DataField="wfid" ReadOnly="true" HeaderTooltip="Click here to sort for staff." FilterControlWidth="65%" ItemStyle-Width="10%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Location" DataField="Location" ReadOnly="true" HeaderTooltip="Click here to sort for location." FilterControlWidth="65%" ItemStyle-Width="10%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="LocationDesc" DataField="LocationDesc" ReadOnly="true" HeaderTooltip="Click here to sort for Location." FilterControlWidth="65%" ItemStyle-Width="10%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Start Time" DataField="FromTime" ReadOnly="true" HeaderTooltip="" AllowFiltering="false" ItemStyle-Width="6%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="End Time" DataField="ToTime" ReadOnly="true" HeaderTooltip="" AllowFiltering="false" ItemStyle-Width="6%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Minutes" DataField="UsualTime" ReadOnly="true" HeaderTooltip="Scheduled - Estimated(mins), Done - Completed(mins)" FilterControlWidth="65%" ItemStyle-Width="10%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" ReadOnly="true" HeaderTooltip="Click here to sort for remarks." FilterControlWidth="65%" ItemStyle-Width="10%"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Status" DataField="Status" ReadOnly="true" HeaderTooltip="Click here to sort for status." UniqueName="Status" FilterControlWidth="65%" ItemStyle-Width="10%"></telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>

                                        </table>

                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <div id="dvcopy" runat="server">

                                        <table>

                                            <tr>
                                                <td align="center">

                                                    <asp:Label ID="Label40" runat="Server" Text="Schedule for a month" ForeColor="DarkGreen" Font-Names="verdana" Font-Bold="true" Font-Size="Small"></asp:Label>

                                                </td>
                                            </tr>

                                            <tr>

                                                <td>

                                                    <asp:Label ID="Label12" runat="Server" Text="Copy From" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                    <telerik:RadDatePicker ID="dtpCopy" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select a date to schedule work on that day" AutoPostBack="true" OnSelectedDateChanged="dtpCopy_SelectedDateChanged">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>

                                                    <asp:DropDownList ID="ddlCopyFrom" runat="server" ToolTip="Select the date that has a schedule to copy" Height="23px" Width="150px" OnSelectedIndexChanged="ddlCopyFrom_SelectedIndexChanged" AutoPostBack="true" Visible="false">
                                                    </asp:DropDownList>


                                                    <asp:Label ID="Label19" runat="Server" Text="To" ForeColor="Black" Font-Names="verdana"></asp:Label>

                                                    <telerik:RadDatePicker ID="dtpFrom" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select a date to schedule work on that day" AutoPostBack="true">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>

                                                    <asp:Label ID="Label21" runat="Server" Text="Till" ForeColor="Black" Font-Names="verdana"></asp:Label>

                                                    <telerik:RadDatePicker ID="dtpTo" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select a date to schedule work on that day" AutoPostBack="true" OnSelectedDateChanged="dtpTo_SelectedDateChanged">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>


                                                    <asp:Button ID="btnCopy" OnClientClick="javascript:return TaskConfirmCopy()" ToolTip="Click here to copy from the existing work schedule." OnClick="btnCopy_Click" runat="server" Text="Copy" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />

                                                </td>

                                            </tr>

                                            <tr>

                                                <td>

                                                    <asp:Label ID="Label15" runat="Server" Text="(Use “copy” option to copy any existing work schedules to another date.)" ForeColor="DarkGray" Font-Names="verdana" Font-Size="Smaller" Visible="false"></asp:Label>

                                                    <asp:Label ID="lbltotalnotupdated" runat="server" Text=""></asp:Label>
                                                    <asp:Label ID="lbltotalupdated" runat="server" Text=""></asp:Label>


                                                </td>
                                            </tr>

                                        </table>

                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <div id="dvPending" runat="server">

                                        <table>

                                            <tr>
                                                <td align="center">
                                                    <asp:Label ID="Label41" runat="Server" Text="View All Tasks" ForeColor="DarkGreen" Font-Names="verdana" Font-Bold="true" Font-Size="Small"></asp:Label>

                                                </td>

                                            </tr>

                                            <tr>

                                                <td>

                                                    <asp:Label ID="Label23" runat="server" Text="Staff" Font-Names="verdana"></asp:Label>
                                                    <asp:DropDownList ID="ddlPendingStaff" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPendingStaff_SelectedIndexChanged" Height="23px" Width="150px"></asp:DropDownList>
                                                    <asp:Label ID="Label24" runat="server" Text="Work Type" Font-Names="verdana"></asp:Label>

                                                    <asp:DropDownList ID="ddlPendingWorkType" runat="server" Height="23px" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="ddlPendingWorkType_SelectedIndexChanged">
                                                    </asp:DropDownList>


                                                    <asp:Label ID="Label43" runat="Server" Text="Status" ForeColor="Black" Font-Names="verdana"></asp:Label>

                                                    <asp:DropDownList ID="ddlPenStatus" runat="server" ToolTip="Select the status of the task" Height="23px" Width="150px" OnSelectedIndexChanged="ddlPenStatus_SelectedIndexChanged" AutoPostBack="true">
                                                        <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                                        <asp:ListItem Text="Done" Value="20"></asp:ListItem>
                                                        <asp:ListItem Text="Scheduled" Value="00"></asp:ListItem>
                                                    </asp:DropDownList>

                                                    <asp:Button ID="btnPendingBulkupdate" runat="server" Text="Bulk Update" CssClass="btnMainpage" BackColor="#6CA5BC" ToolTip="Select one or more tasks, and write progress of work in each task ." OnClick="btnPendingBulkupdate_Click" />

                                                </td>

                                            </tr>

                                            <tr>

                                                <td>



                                                    <telerik:RadGrid ID="gvWorkSchedulePending" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"
                                                         OnItemCommand="gvWorkSchedulePending_ItemCommand" Width="100%" AllowFilteringByColumn="false" OnInit="gvWorkSchedulePending_Init">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" />
                                                        </ClientSettings>
                                                        <MasterTableView>
                                                            <Columns>

                                                                <telerik:GridTemplateColumn HeaderText="Select & Update" ItemStyle-Width="25px" HeaderStyle-Width="25px" Exportable="false" AllowFiltering="false">
                                                                    <HeaderTemplate>

                                                                        <asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="TogglePendingSelectedState" AutoPostBack="True" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkJSel" runat="server" />
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>


                                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the house keeping task details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RSN") %>' CommandArgument='<%# Eval("RSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <%--<telerik:GridBoundColumn HeaderStyle-Width="200px" HeaderText="Door No" DataField="DoorNo" ReadOnly="true"></telerik:GridBoundColumn>--%>

                                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Department" DataField="deptname" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Category" DataField="Category" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Task" DataField="taskid" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Assigned To" FilterControlWidth="60px" DataField="wfid" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Location" FilterControlWidth="50px" DataField="Location" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="LocationDesc" FilterControlWidth="60px" DataField="LocationDesc" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Minutes" FilterControlWidth="30px" DataField="UsualTime" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Status" FilterControlWidth="60px" DataField="Status" ReadOnly="true"></telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>

                                                </td>

                                            </tr>

                                        </table>

                                    </div>
                                </td>
                            </tr>


                            <tr>
                                <td>

                                    <div id="dvViewTaskList" runat="server">

                                        <table style="width: 90%">


                                            <tr>
                                                <td colspan="8" align="center">
                                                    <asp:Label ID="Label42" runat="Server" Text="View Scheduled Tasks" ForeColor="DarkGreen" Font-Names="verdana" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                </td>
                                            </tr>

                                            <tr>

                                                <td>


                                                    <asp:Label ID="Label32" runat="Server" Text="From" ForeColor="Black" Font-Names="verdana"></asp:Label>

                                                    <telerik:RadDatePicker ID="dtpFromDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select a date to schedule work on that day" AutoPostBack="true">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                                <td>

                                                    <asp:Label ID="Label33" runat="Server" Text="To" ForeColor="Black" Font-Names="verdana"></asp:Label>

                                                    <telerik:RadDatePicker ID="dtpToDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select a date to schedule work on that day" AutoPostBack="true" OnSelectedDateChanged="dtpTo_SelectedDateChanged">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>

                                                </td>

                                                <td>

                                                    <asp:Label ID="Label34" runat="Server" Text="Category" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlViewCategory" runat="server" ToolTip="Select the task to be done" Height="23px" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="ddlViewCategory_SelectedIndexChanged">
                                                    </asp:DropDownList><br />
                                                </td>

                                                <td>

                                                    <asp:Label ID="Label35" runat="Server" Text="Task" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlViewTask" runat="server" ToolTip="Select the task to be done" Height="23px" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="ddlViewTask_SelectedIndexChanged">
                                                    </asp:DropDownList>

                                                </td>

                                                <td>

                                                    <asp:Label ID="Label36" runat="Server" Text="Staff" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlViewStaff" runat="server" ToolTip="Select a staff for whom the task is assigned" Height="23px" Width="150px">
                                                    </asp:DropDownList>

                                                </td>

                                                <td>

                                                    <asp:Label ID="Label37" runat="Server" Text="Site" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlViewSite" runat="server" Height="23px" Width="150px" ToolTip="Select the site where the task is done">
                                                    </asp:DropDownList>

                                                </td>

                                                <td>

                                                    <asp:Label ID="Label38" runat="Server" Text="WorkType" ForeColor="Black" Font-Names="verdana"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlViewWorkType" runat="server" Height="23px" Width="100px" ToolTip="Select the site where the task is done">
                                                    </asp:DropDownList>

                                                </td>

                                                <td>
                                                    <br />
                                                    <asp:Button ID="btnSearch" ToolTip="Click here to copy from the existing work schedule." OnClick="btnSearch_Click" runat="server" Text="Search" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />

                                                </td>
                                            </tr>



                                        </table>

                                        <table style="width: 90%">
                                            <tr>

                                                <td>


                                                    <telerik:RadGrid ID="rgViewTaskList" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                                        AutoGenerateColumns="false" OnItemCommand="gvWorkSchedulePending_ItemCommand" Width="100%" 
                                                        AllowFilteringByColumn="false" OnInit="rgViewTaskList_Init">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" />
                                                        </ClientSettings>
                                                        <MasterTableView>
                                                            <Columns>

                                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RSN") %>' CommandArgument='<%# Eval("RSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>


                                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Department" DataField="deptname" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Category" DataField="Category" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Task" DataField="taskid" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Assigned To" FilterControlWidth="60px" DataField="wfid" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Location" FilterControlWidth="50px" DataField="Location" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="LocationDesc" FilterControlWidth="60px" DataField="LocationDesc" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Minutes" FilterControlWidth="30px" DataField="UsualTime" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Status" FilterControlWidth="60px" DataField="Status" ReadOnly="true"></telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </td>

                                            </tr>
                                        </table>



                                    </div>

                                </td>
                            </tr>




                            <tr>

                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lnkworkload" Text="Click here to view staff work load" runat="server" OnClick="lnkworkload_Click"></asp:LinkButton>
                                                <asp:LinkButton ID="lnkhide" runat="server" Text="Hide" OnClick="lnkhide_Click"></asp:LinkButton>
                                            </td>
                                        </tr>

                                        <tr>


                                            <td>

                                                <div id="dvStaffWorkLoad" runat="server">

                                                    <table>

                                                        <tr>
                                                            <td style="vertical-align: top">
                                                                <asp:Label ID="lblstaffworkloadchart" runat="server" Text="Staff workload chart" ToolTip="Shows how many tasks are assigned and how much time these may take approximately."></asp:Label>
                                                                <telerik:RadGrid ID="rgStaffWorkLoadChart" GroupingSettings-CaseSensitive="false" Skin="Sunset" runat="server" AutoGenerateColumns="false" Width="500px" ToolTip="Staff – Name of the regular / contract staff.
Tasks -   Count of tasks assigned today
Backlog -  Tasks assigned earlier and yet to be completed.
Hours -   Shows the approximate estimated time in hours for all the tasks including backlog. if blank estimated time is not available for the tasks.">
                                                                    <MasterTableView>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn HeaderText="Staff" DataField="PersonName" ReadOnly="true" ItemStyle-HorizontalAlign="Left"></telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Department" DataField="deptname" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="All Tasks" DataField="CountofTasks" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Backlog" DataField="CountPendingTasks" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Estimated Hours" DataField="Totaltimeestimate" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                            <%--<telerik:GridBoundColumn HeaderText="Total time pending estimate(Hours) " DataField="Totaltimeestimate" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>--%>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                </telerik:RadGrid>
                                                            </td>
                                                            <td style="vertical-align: top">
                                                                <asp:Label ID="lblpendingser" runat="server" Text="Pending Service Requests as of now" ToolTip="You may like to add some of these requests in the daily tasks schedule."></asp:Label>
                                                                <telerik:RadGrid ID="rgServiceRequestPending" GroupingSettings-CaseSensitive="false" Skin="Sunset" runat="server" AutoGenerateColumns="false" Width="500px">
                                                                    <MasterTableView>
                                                                        <Columns>
                                                                            <%--<telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the service task details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>--%>
                                                                            <telerik:GridBoundColumn HeaderText="DoorNo" DataField="DoorNo" ReadOnly="true" ItemStyle-HorizontalAlign="Left"></telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Name" DataField="Name" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Category" DataField="Category" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Request" DataField="Request" ReadOnly="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                </telerik:RadGrid>

                                                            </td>
                                                        </tr>


                                                    </table>

                                                </div>

                                            </td>

                                        </tr>

                                    </table>
                                </td>



                            </tr>

                        </table>
                    </div>
                </div>
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="BtnnExcelExport" />
            <asp:PostBackTrigger ControlID="gvWorkSchedule" />
            <asp:PostBackTrigger ControlID="dtpTo" />
            <asp:PostBackTrigger ControlID="btnSearch" />
            <asp:PostBackTrigger ControlID="btnCalendar" />
            <asp:PostBackTrigger ControlID="btnDailySchedule" />
            <asp:PostBackTrigger ControlID="btnSchedule" />
            <asp:PostBackTrigger ControlID="btnPending" />
            <asp:PostBackTrigger ControlID="btnCopy" />
             <asp:AsyncPostBackTrigger ControlID="ddlCategory" />
            <asp:AsyncPostBackTrigger ControlID="btnViewTaskList" />
        </Triggers>
    </asp:UpdatePanel>

     <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upnlMain">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                             <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="loading3.gif" width="80%" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
   


</asp:Content>
