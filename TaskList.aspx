<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="TaskList.aspx.cs" Inherits="TaskList" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<link href="CSS/MenuCSS.css" rel="stylesheet" />--%>

    <script src="Calendar/jquery-1.10.2.js"></script>
    <script src="Calendar/jquery.validate.js" type="text/javascript"></script>
    <script src="Calendar/moment.js" type="text/javascript"></script>

    <%--<link href="Calendar/jquery-ui-1.8.16.custom.css" rel="stylesheet" />--%>

    <script src="Calendar/jquery.timepicker.js" type="text/javascript"></script>
    <link href="Calendar/jquery.timepicker.css" rel="Stylesheet" />

    <script src="Calendar/lib/site.js" type="text/javascript"></script>
    <link href="Calendar/lib/site.css" rel="stylesheet" />
    <%-- <script src="Calendar/Auto/jquery-ui.min.js" type="text/javascript"></script>--%>

    <script type="text/javascript">
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function () {
            //$(document).ready(function () {
            $("[id*='txtMTime']").timepicker({});
        });
    </script>
     <style>
        .ddlstyle {
            color: rgb(33,33,00);
            Font-Family: Verdana;
            font-size: 12px;
            /*vertical-align: middle;*/
        }
    </style>
    <script language="javascript" type="text/javascript">

        function TaskConfirmMsg() {

            var result = confirm('Do you want add this request/complaint?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }

        function TaskConfirmMsg2() {

            var result = confirm('Do you want to update?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return true;
            }

        }

    </script>
    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += Phno();
            summ += Email();
            summ += Task();

            if (summ == "") {
                var msg = "";
                msg = 'Are you sure, you want to save?';
                var result = confirm(msg, "Check");
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
                alert(summ);
                return false;
            }

        }

        function Task() {
            var Name = document.getElementById('<%=txtTask.ClientID%>').value;
            var requstby = document.getElementById('<%=cmbResident.ClientID%>').value;


            if (Name == "" || requstby == "0" || task == "Please Select") {
                return "Kindly select Requested By/ Enter a Description." + "\n";
            }
            else {
                return "";
            }
        }

        <%--function Phno() {
            var Name = document.getElementById('<%=txtMobile.ClientID%>').value;
            var chk = /^[-+]?[0-9]+$/
            if (Name == "") {
                return "";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Enter valid Mobile no" + "\n";
            }
        }

        function Email() {
            var Name = document.getElementById('<%=txtEmail.ClientID%>').value;
            var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
            if (Name == "") {
                return "";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Enter valid email id" + "\n";
            }
        }--%>
        function CloseWindow() {
            window.close();
            window.opener.location.reload();
        }


    </script>



    <telerik:RadWindowManager runat="server" ID="RadWindowManager1"></telerik:RadWindowManager>

    <script type="text/javascript">
        function confirmCallbackFn(arg) {
            if (arg) //the user clicked OK
            {
                __doPostBack("<%=HiddenButton.UniqueID %>", "");
            }
        }
    </script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 99%;">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 100%">


                            <div id="dvHelp" style="width: 100%; float: right" runat="server">
                                <div style="float: right">
                                    <telerik:RadMenu ID="rmHelp" runat="server" Skin="" Width="50px" OnItemClick="rmHelp_ItemClick">
                                        <Items>
                                            <telerik:RadMenuItem runat="server" Text="Help" ToolTip="Click here to view help details." CssClass="main_menu">
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>

                                    <asp:ImageButton ID="btncalendarimg" runat="server" Visible="false" ImageAlign="Middle" ImageUrl="~//images/Calendar.png" OnClientClick="return CloseWindow();" ToolTip="Click here to go to calendar." Width="50px" Height="25px" />
                                    <asp:ImageButton ID="btncalendarimg2" runat="server" Visible="false" ImageAlign="Middle" ImageUrl="~//images/Calendar.png" ToolTip="Click here to go to calendar." OnClick="btncalendarimg2_Click" Width="50px" Height="25px" />
                                    <telerik:RadWindow ID="rwHelp" VisibleOnPageLoad="false" Width="600px" Height="190px" Modal="true" runat="server">
                                        <ContentTemplate>
                                            <div>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblHelp" runat="server" Width="560px" Font-Names="Verdana" ToolTip="Click here to view help details." Text="Tasks to be carried out for the residents, are registered here and their status monitored.  Also helps to keep track of delayed tasks. Examples of tasks:  Plumbing work to be done in Villa 120,  Ticket to be booked for Mr.Gupta for his travel, Doctor Appointment due for Mr.Johnson in Villa 120 etc.etc.  With the Tasks List, now there will be no more forgotten work or delays or unscheduled work creeping in.  You can also send a broadcast message to all. When a task is Done, remember to mark it as Done."></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%">
                    <tr>
                        <td style="text-align: center">
                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%">
                    <tr>
                        <td>
                            <telerik:RadWindow ID="rwSpecialReport" Width="700" Height="280" VisibleOnPageLoad="false" runat="server" Title="Profile++" Modal="true">
                                <ContentTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblCRName" runat="server" Text="Name:" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="lblRName" runat="server" Text="" Font-Names="verdana"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:Label ID="lblCRStatus" runat="server" Text="Status:" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="lblRStatus" runat="server" Text="" Font-Names="verdana"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:Label ID="lblCRDoorNo" runat="server" Text="Door No:" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="lblRDoorNo" runat="server" Text="" Font-Names="verdana"></asp:Label>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <telerik:RadGrid ID="rgSpecialReport" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                    Height="250px" Width="600px" AllowFilteringByColumn="false" AllowSorting="true" AllowPaging="false" PageSize="5" Skin="Sunset">
                                                    <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                    </HeaderContextMenu>
                                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                    </HeaderContextMenu>
                                                    <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                    <ClientSettings>
                                                        <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                            ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                    </ClientSettings>
                                                    <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                        <PagerStyle Mode="NumericPages" />
                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                        <RowIndicatorColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </ExpandCollapseColumn>
                                                        <Columns>

                                                            <telerik:GridBoundColumn DataField="RARSN" HeaderText="RARSN" UniqueName="RARSN"
                                                                Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="RTRSN" HeaderText="RTRSN" UniqueName="RTRSN"
                                                                Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="Code" HeaderText="Code" UniqueName="Code"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="Details" HeaderText="Details" UniqueName="Details"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="ContactNo" HeaderText="ContactNo" UniqueName="ContactNo"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center" Width="100px"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="Emailid" HeaderText="Emailid" UniqueName="Emailid"
                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </telerik:RadWindow>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            <asp:HiddenField ID="CnfResult" runat="server" />
                            <asp:Panel ID="pnlSecond" runat="server" BackColor="White" Visible="false">

                                <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Always" ChildrenAsTriggers="true">
                                    <ContentTemplate>
                                        <table>

                                            <tr>

                                                <td style="width: 100%">

                                                    <table>

                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblRTSTATUS" runat="Server" Text="Resident Name" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                <asp:Label ID="Label1" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                            <td>

                                                                <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                                    AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                                                    Width="350px" ToolTip="" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged"
                                                                    RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                                                </telerik:RadComboBox>



                                                                <%--<tr>
                                                                        <td>
                                                                            <asp:CheckBox ID="chkByName" runat="server" Text="Resident By Name" OnCheckedChanged="chkByName_CheckedChanged" AutoPostBack="true" /><br />
                                                                            <asp:DropDownList ID="ddlAssignedTo" ToolTip=" Select the name of the resident who has made the request. " Width="200px" Height="25px" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAssignedTo_Click"
                                                                                Font-Names="Verdana" Font-Size="Small">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td>
                                                                            <asp:CheckBox ID="chkByDoorNo" runat="server" Text="Resident By DoorNo" OnCheckedChanged="chkByDoorNo_CheckedChanged" AutoPostBack="true" /><br />
                                                                            <asp:DropDownList ID="ddlDoorNo" ToolTip=" Select the name of the resident who has made the request. " Width="200px" Height="25px" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAssignedTo_Click"
                                                                                Font-Names="Verdana" Font-Size="Small">
                                                                            </asp:DropDownList>

                                                                        </td>




                                                                    </tr>--%>

                                                                <%--<tr>
                                                                        <td colspan="2">
                                                                            <asp:LinkButton ID="lnkprofile" runat="server" Text="Profile++" OnClick="lnkprofile_Click" Font-Names="verdana" Font-Bold="true"></asp:LinkButton>
                                                                        </td>
                                                                    </tr>--%>
                                                                
                                                            </td>
                                                        </tr>
                                                        <%--<tr>
                                                            <td>
                                                                <asp:Label ID="lblRTVILLANO" runat="Server" Text="Mobile" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
    
                                                                                                                    </td>
                                                            <td>
                                                                <asp:TextBox ID="txtMobile" runat="Server" MaxLength="13" ToolTip="" BackColor="Gray" Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                <br />
                                                                <asp:Label ID="lbltaskcount" runat="Server" Text="" ForeColor="Gray" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label4" runat="Server" Text="Email" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtEmail" runat="Server" MaxLength="12" ToolTip="" BackColor="Gray" Width="300px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                            </td>
                                                        </tr>--%>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label2" runat="Server" Visible="false" Text="Need" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                <asp:Label ID="Label3" runat="Server" Visible="false" Text="*" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlTask" Visible="false" runat="server" AutoPostBack="true" Font-Names="Verdana" Font-Size="Small" ToolTip="Select the Request or Complaint which you need to Register." OnSelectedIndexChanged="ddlTask_SelectedIndexChanged"></asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <%--<tr>
                                                            <td>
                                                                <text style="font-family: Verdana; font-size: small;">Service Category :</text>
                                                                <text style="color: red;">*</text>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlSerCategory" ToolTip="Select the major category where the service request is grouped" Width="200" Font-Size="Small" Font-Names="verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlSerCategory_SelectedIndexChanged" runat="server"></asp:DropDownList>
                                                                &nbsp;&nbsp;
                                                                <asp:Label ID="lblPriority" Visible="false" Font-Bold="true" Font-Names="verdana" Font-Size="Small" Text="Priority : " runat="server"></asp:Label>
                                                                <asp:Label ID="lblPriorityMsg" Font-Names="verdana" ForeColor="DarkBlue" Font-Size="Small" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>--%>
                                                        <tr>
                                                            <td style="vertical-align: top">
                                                                <text style="font-family: Verdana; font-size: small;">Service Type :</text>
                                                                <text style="color: red;">*</text>

                                                            </td>
                                                            <td>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlSerType" ToolTip="Select the Service Type appropriate to the request or complaint. If no matches found add new service type." Width="415px" Font-Size="Small" Font-Names="verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlSerType_SelectedIndexChanged" runat="server"></asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:LinkButton ID="lnkAddnewservicetype" ForeColor="#048080" runat="server" AutoPostback="true" Text="+ Add New Service Type" Font-Size="Medium" Font-Bold="true" ToolTip="Click here to add new service type" OnClick="lnkAddnewservicetype_Click" Font-Underline="true"></asp:LinkButton>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <%--<tr>
                                                            <td>
                                                                <text style="font-family: Verdana; font-size: small;">Department Name :</text>
                                                                <text style="color: red;">*</text>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddldept" ToolTip="What is the service type being requested?" Width="200" Font-Size="Small" Font-Names="verdana" runat="server"></asp:DropDownList>
                                                            </td>
                                                        </tr>--%>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label8" runat="Server" Text="Frequently Used Description :" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlstdtext" AutoPostBack="true" OnSelectedIndexChanged="ddlstdtext_SelectedIndexChanged" ToolTip="Select description that matches the request or complaint. If no matches found enter the description below." Font-Size="Small" runat="server" Width="415px" Font-Names="verdana"></asp:DropDownList>
                                                                <asp:ImageButton ID="ibtnAddtext" Visible="false" OnClick="ibtnAddtext_Click" runat="server" ImageUrl="~/Calendar/addicon.png" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label6" runat="Server" Text="Description" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                <asp:Label ID="Label7" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtTask" runat="Server" MaxLength="2400" ToolTip="Write in detail what is to be done.  Ex: Plumbing work, Ticket Booking for travel on 29th July , etc." Width="415px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Height="60px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lbltasksts" Visible="false" runat="Server" Text="Status" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlStatus" Visible="false" Width="200px" Height="25px" runat="server" ToolTip="Select the status of the request or complaint. Open means not yet completed. Done means Completed."
                                                                    Font-Names="Verdana" Font-Size="Small">
                                                                    <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                                                                    <asp:ListItem Text="Done" Value="Done"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label5" runat="Server" Visible="false" Text="Received Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <telerik:RadDatePicker ID="dtpStatusDt" Visible="false" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Set the date when the request was received."
                                                                    Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                                                    <DatePopupButton></DatePopupButton>
                                                                    <DateInput ID="DateInput2" DateFormat="dd/MMM/yy" DisplayDateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                                    </DateInput>
                                                                    <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                        <SpecialDays>
                                                                            <telerik:RadCalendarDay Repeatable="Today">
                                                                                <ItemStyle BackColor="Pink" />
                                                                            </telerik:RadCalendarDay>
                                                                        </SpecialDays>
                                                                    </Calendar>
                                                                </telerik:RadDatePicker>
                                                            </td>
                                                        </tr>
                                                        <%--<tr>
                                                            <td>
                                                                <asp:Label ID="lblMRate" Visible="true" runat="server" Font-Names="verdana" Font-Size="Small" Text="Rate :"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtMRate" Width="75" Text="0" Visible="true" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>--%>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblMDate" Visible="true" runat="server" Font-Names="verdana" Font-Size="Small" Text="Date :"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <telerik:RadDatePicker ID="txtMDate" Visible="true" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Set the date when the request was received."
                                                                    Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                                                    <DatePopupButton></DatePopupButton>
                                                                    <DateInput ID="DateInput4" DateFormat="dd/MMM/yy" DisplayDateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                                    </DateInput>
                                                                    <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                        <SpecialDays>
                                                                            <telerik:RadCalendarDay Repeatable="Today">
                                                                                <ItemStyle BackColor="Pink" />
                                                                            </telerik:RadCalendarDay>
                                                                        </SpecialDays>
                                                                    </Calendar>
                                                                </telerik:RadDatePicker>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblMtime" Visible="true" runat="server" Font-Names="verdana" Font-Size="Small" Text="Time :"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtMTime" Width="80" Visible="true" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblMCount" Visible="true" runat="server" Font-Names="verdana" Font-Size="Small" Text="Count :"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtMCount" Visible="true" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label13" Visible="false" runat="Server" Text="Priority" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlUrgency" Visible="false" AutoPostBack="true" Width="200px" Height="25px" runat="server" ToolTip="Helps you schedule the tasks more effectively."
                                                                    Font-Names="Verdana" Font-Size="Small">
                                                                    <asp:ListItem Text="Medium" Value="M"></asp:ListItem>
                                                                    <asp:ListItem Text="Low" Value="L"></asp:ListItem>
                                                                    <asp:ListItem Text="High" Value="H"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label15" runat="Server" Text="Target Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <telerik:RadDatePicker ID="dtpTargetDt" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select target date of the task"
                                                                    Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                                                    <DatePopupButton></DatePopupButton>
                                                                    <DateInput ID="DateInput1" DateFormat="dd/MMM/yy" runat="server" DisplayDateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                                    </DateInput>
                                                                    <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                        <SpecialDays>
                                                                            <telerik:RadCalendarDay Repeatable="Today">
                                                                                <ItemStyle BackColor="Pink" />
                                                                            </telerik:RadCalendarDay>
                                                                        </SpecialDays>
                                                                    </Calendar>
                                                                </telerik:RadDatePicker>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label11" runat="Server" Text="Remarks" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtStatusRemarks" runat="Server" MaxLength="2400" ToolTip=" Write here any remarks after completion of a task. It can also be some additional information that will help." Width="300px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Height="60px"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblnetamount" runat="server" Text="Net Amount" CssClass="Font_lbl2" Visible="true"></asp:Label>
                                                               </td>
                                                            <td>
                                                            <asp:TextBox ID="txtNetAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="Net amount billed for this service request." Width="200px" Enabled="true" Visible="false" onkeypress="return isNumberKey(event);" OnTextChanged="txtNetAmount_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lbltaxamount" runat="server"  Text="CGST Amount" CssClass="Font_lbl2" Visible="false" Enabled="false"></asp:Label>
                                                               </td>
                                                            <td>
                                                                <asp:TextBox ID="txtTaxAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="Central GST amount." Width="200px" Enabled="false" Visible="true"></asp:TextBox>
                                                                  <asp:Label ID="lbltaxpercentage" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                        </tr>
                                                          <tr>
                                                            <td>
                                                                <asp:Label ID="lblsgstamount" runat="server"  Text="SGST Amount" CssClass="Font_lbl2" Visible="false" Enabled="false"></asp:Label>
                                                               </td>
                                                            <td>
                                                                <asp:TextBox ID="txtSGSTAmouont" runat="server" CssClass="TextBox" Height="25px" ToolTip="State GST amount." Width="200px" Enabled="false" Visible="false"></asp:TextBox>
                                                                  <asp:Label ID="lblsgstpercentage" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblgrossamount" runat="server" Text="Gross Amount" CssClass="Font_lbl2" Visible="false" Enabled="false"></asp:Label>
                                                              </td>
                                                            <td> 
                                                                <asp:TextBox ID="txtGrossAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="Total Amount" Width="200px" Enabled="false" Visible="false"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">

                                                                <asp:Label ID="lblcservicelist" runat="Server" Text="Other open service request from the same residence." Font-Bold="true" Font-Underline="true" ForeColor="DarkGreen"
                                                                    Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                <br />

                                                                <telerik:RadGrid ID="rgServiceList" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                                    Height="250px" Width="85%" AllowSorting="true" PageSize="10" OnInit="rgServiceList_Init" AllowPaging="false">

                                                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                    </HeaderContextMenu>
                                                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                    </HeaderContextMenu>
                                                                   <%-- <PagerStyle AlwaysVisible="true" Mode="NumericPages" />--%>
                                                                    <ClientSettings>
                                                                        <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                            ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                                    </ClientSettings>
                                                                    <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                        <PagerStyle Mode="NumericPages" />
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn>
                                                                            <HeaderStyle Width="10px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn>
                                                                            <HeaderStyle Width="10px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>

                                                                            <telerik:GridBoundColumn DataField="statusdate" HeaderText="Date" UniqueName="statusdate" SortExpression="statusdate"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Center">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="name" HeaderText="Name" UniqueName="Name" SortExpression="Name"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Left">
                                                                                <HeaderStyle HorizontalAlign="Left" Width="60px"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Left" Width="60px"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="servicetype" HeaderText="Type" UniqueName="servicetype" SortExpression="servicetype"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="left" FilterControlWidth="40px" ItemStyle-HorizontalAlign="left">
                                                                                <HeaderStyle HorizontalAlign="left" Width="80px"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="left" Width="80px"></ItemStyle>
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="Task" HeaderText="Description" UniqueName="Task" SortExpression="Task"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Left">
                                                                                <HeaderStyle HorizontalAlign="Left" Width="80px"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Left" Width="80px"></ItemStyle>
                                                                            </telerik:GridBoundColumn>




                                                                        </Columns>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                                    </ClientSettings>
                                                                </telerik:RadGrid>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td style="vertical-align: bottom;">
                                                                <asp:Button ID="HiddenButton" Text="" Style="display: none;" OnClick="HiddenButton_Click" runat="server" />
                                                                <asp:Button ID="btnSave" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Add" ForeColor="White" OnClick="btnSave_Click" OnClientClick="javascript:return TaskConfirmMsg()" ToolTip="Click here to save the details" />
                                                                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Update" ForeColor="White" Visible="false" OnClick="btnUpdate_Click" OnClientClick="javascript:return TaskConfirmMsg2()" ToolTip="Click here to Update the details" />
                                                                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Clear" ForeColor="White" BackColor="Blue" OnClick="btnClear_Click" ToolTip=" Click here to clear entered details" />
                                                                <asp:Button ID="btnClose" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Return" ForeColor="White" BackColor="Goldenrod" OnClick="btnClose_Click" ToolTip="Click to Return back to the View Grid" />

                                                                <telerik:RadWindow ID="rwDebitAmount" VisibleOnPageLoad="false" Width="600px" Height="190px" Modal="true" runat="server">
                                                                    <ContentTemplate>
                                                                        <div>
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="Label4" runat="server" Width="560px" Font-Names="Verdana" ToolTip="Click here to view help details." Text="Service Charges"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblcref" runat="server" Width="560px" Font-Names="Verdana" ToolTip="" Text=""></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblref" runat="server" Width="560px" Font-Names="Verdana" ToolTip="" Text=""></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblcDoorNo" runat="server" Width="560px" Font-Names="Verdana" ToolTip="" Text=""></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblDoorNo" runat="server" Width="560px" Font-Names="Verdana" ToolTip="" Text=""></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblcservicetype" runat="server" Width="560px" Font-Names="Verdana" ToolTip="" Text=""></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblservicetype" runat="server" Width="560px" Font-Names="Verdana" ToolTip="" Text=""></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblcremarks" runat="server" Width="560px" Font-Names="Verdana" ToolTip="" Text=""></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Label ID="lblremarks" runat="server" Width="560px" Font-Names="Verdana" ToolTip="" Text=""></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblcamount" runat="server" Width="560px" Font-Names="Verdana" ToolTip="" Text="Amount to be debited"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtamount" runat="server"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Button ID="btnOK" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="OK" ForeColor="White" OnClick="btnSave_Click" ToolTip="" />
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Cancel" ForeColor="White" ToolTip="" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>

                                                                        </div>
                                                                    </ContentTemplate>
                                                                </telerik:RadWindow>

                                                            </td>
                                                        </tr>

                                                    </table>

                                                </td>
                                                <td style="width: 500px; vertical-align: top">
                                                    <table>
                                                        <tr>
                                                            <td style="vertical-align: top">
                                                                <asp:Label ID="lblcprofile" runat="server" Text="" Font-Names="Verdana" Font-Underline="true" Font-Size="X-Small"></asp:Label><br />
                                                                <asp:Label ID="lblstatus" runat="server" Text="" Font-Names="Verdana" Font-Size="X-Small"></asp:Label><br />
                                                                <asp:Label ID="lblMobileNo" runat="server" Text="" Font-Names="Verdana" Font-Size="X-Small"></asp:Label><br />
                                                                <asp:Label ID="lblEmailID" runat="server" Text="" Font-Names="Verdana" Font-Size="X-Small"></asp:Label><br />
                                                                <br />
                                                                <br />
                                                                <asp:Label ID="lblcservice" runat="server" Text="" Font-Names="Verdana" ForeColor="Maroon" Font-Underline="true" Font-Size="X-Small"></asp:Label><br />
                                                                <asp:Label ID="lblCategory" runat="server" Text="" Font-Names="Verdana" ForeColor="Maroon" Font-Size="X-Small"></asp:Label><br />
                                                                <asp:Label ID="lblDepartment" runat="server" Text="" Font-Names="Verdana" ForeColor="Maroon" Font-Size="X-Small"></asp:Label><br />
                                                                <asp:Label ID="lbldescription" runat="server" Text="" Font-Names="Verdana" ForeColor="Maroon" Font-Size="X-Small"></asp:Label><br />
                                                                <asp:Label ID="lblRate" runat="server" Text="" Font-Names="Verdana" ForeColor="Maroon" Font-Size="X-Small"></asp:Label>
                                                                <%-- <asp:Label ID="lblAutoDebit" runat="server" Text="" Font-Names="Verdana" ForeColor="Blue" Font-Size="X-Small"></asp:Label><br />
                                                                <asp:Label ID="lblsms" runat="server" Text="" Font-Names="Verdana" ForeColor="Blue" Font-Size="X-Small"></asp:Label>--%>
                                                                <br />
                                                                <br />


                                                                <asp:Label ID="lblcSendsms" runat="Server" Text="SMS To Resident" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                <br />
                                                                <asp:TextBox ID="txtSendsms" runat="Server" MaxLength="150" ToolTip="" Width="300px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Height="60px"></asp:TextBox>
                                                                <br />
                                                                <asp:Button ID="btnSendsms" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Send SMS" ForeColor="White" OnClick="btnSendsms_Click" ToolTip="Click here send sms to selected residence." />



                                                            </td>
                                                        </tr>
                                                    </table>

                                                </td>

                                            </tr>

                                        </table>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="txtMTime" />
                                        <asp:PostBackTrigger ControlID="btnClose" />

                                        <asp:PostBackTrigger ControlID="btnSave" />
                                        <asp:PostBackTrigger ControlID="btnUpdate" />
                                        <asp:PostBackTrigger ControlID="btnSendsms" />

                                    </Triggers>
                                </asp:UpdatePanel>

                            </asp:Panel>

                            <asp:Panel ID="pnlThird" runat="server" BackColor="white"
                                Visible="true" Height="430px" Width="90%" HorizontalAlign="Center" align="center">

                                <table align="center">

                                    <tr style="background-color: white; border-bottom-color: lightgray; border-top-color: lightgray; border-left-color: lightgray; border-right-color: lightgray; border-style: inset; width: 100%">
                                        <td>
                                            <asp:Label ID="lblVillaNo" runat="Server" Text="Status" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; 
                                            <asp:DropDownList ID="ddlSStatus" Width="150px" ToolTip="" runat="server"
                                                Font-Names="Verdana" AutoPostBack="true" Font-Size="Small" OnSelectedIndexChanged="ddlSStatus_SelectedIndexChanged">
                                                <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                                                <asp:ListItem Text="Overdue" Value="Overdue"></asp:ListItem>
                                                <asp:ListItem Text="Completed" Value="Done"></asp:ListItem>
                                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                                  <asp:ListItem Text="Cancelled" Value="Cncld"></asp:ListItem>
                                            </asp:DropDownList>
                                            <%-- &nbsp; 
                                            <asp:Label ID="Label8" runat="Server" Text="Category :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            &nbsp;  &nbsp;  &nbsp; 
                                            <asp:DropDownList ID="ddlCategory" Width="150px" ToolTip="" runat="server" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"
                                                Font-Names="Verdana" AutoPostBack="true" Font-Size="Small">
                                            </asp:DropDownList>--%>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                              <asp:Label ID="lblopentasks" runat="Server" Text="Open:" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            &nbsp;&nbsp; 
                                            <asp:Label ID="lbldispopentasks" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                             <asp:Label ID="lbloverdue" runat="Server" Text="Overdue:" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            &nbsp;&nbsp; 
                                            <asp:Label ID="lbldispoverdue" runat="Server" Text="" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                                          <asp:Button ID="BtnnExcelExport" runat="server" Height="25px" BackColor="Green" BorderStyle="Solid" Font-Names="Verdana" Font-Size="Small" Visible="false" Font-Bold="true" Text="Export to Excel" OnClick="btnExpProject_Click" ForeColor="White" ToolTip="Click here to export grid data in excel." />

                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <asp:Label ID="LblFromDate" Visible="false" runat="Server" Text="From" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                            <telerik:RadDatePicker ID="FromDate" Visible="false" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="" AutoPostBack="true">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                    CssClass="TextBox" Font-Names="Calibri">
                                                </Calendar>
                                                <DatePopupButton></DatePopupButton>
                                                <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                    ForeColor="Black" ReadOnly="true">
                                                </DateInput>
                                            </telerik:RadDatePicker>

                                            &nbsp; 

                                            <asp:Label ID="LblToDate" runat="Server" Visible="false" Text="To" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                            <telerik:RadDatePicker ID="ToDate" Visible="false" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="" AutoPostBack="true">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                    CssClass="TextBox" Font-Names="Calibri">
                                                </Calendar>
                                                <DatePopupButton></DatePopupButton>
                                                <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                    ForeColor="Black" ReadOnly="true">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                            &nbsp;&nbsp;
                                            <asp:Button ID="btnCompsearch" Visible="false" OnClick="btnCompsearch_Click" runat="server" Text="Search" ForeColor="White" BackColor="DarkGreen" />
                                        </td>
                                    </tr>
                                    <tr style="width: 100%">
                                        <td>

                                            <telerik:RadGrid ID="rdgTaskList" runat="server" CssClass="table table-bordered table-hover" Skin="WebBlue" AutoGenerateColumns="False"
                                                Height="350px" Width="100%" AllowFilteringByColumn="true" AllowPaging="false" AllowSorting="true"
                                                OnItemDataBound="rdgTaskList_ItemDataBound" PageSize="10" OnInit="rdgTaskList_Init" ShowFooter="false">
                                                <%-- --%>
                                                <HeaderContextMenu >
                                                </HeaderContextMenu>
                                                <HeaderContextMenu >
                                                </HeaderContextMenu>
                                                <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                <ClientSettings>
                                                    <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                        ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                </ClientSettings>
                                                <GroupingSettings CaseSensitive="false" />
                                                <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">

                                                    <PagerStyle Mode="NumericPages" />
                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                    <RowIndicatorColumn>
                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                    </RowIndicatorColumn>
                                                    <ExpandCollapseColumn>
                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                    </ExpandCollapseColumn>
                                                    <Columns>

                                                        <telerik:GridTemplateColumn UniqueName="TemplateColumn1" AllowFiltering="False" Visible="True"
                                                            HeaderStyle-Width="30px" ItemStyle-Width="30px">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lblEdit" runat="server" CausesValidation="false" CssClass="TextBox"
                                                                    Text="Edit" Font-Underline="true" ForeColor="#00008B" OnClick="rdgCSEdit_Click" ToolTip="Click Edit to change task status.">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn DataField="RSN" HeaderText="Ref" UniqueName="RSN" DataType="System.Int32"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="35%">
                                                            <HeaderStyle HorizontalAlign="Left" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="AssignedTo" ItemStyle-ForeColor="Blue" HeaderText="Name" UniqueName="AssignedTo" SortExpression="AssignedTo"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="50%" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Left" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="DoorNo" HeaderText="Door No." UniqueName="DoorNo" SortExpression="DoorNo"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="35%" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="TaskDate" HeaderText="Date" UniqueName="TaskDate" SortExpression="TaskDate"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="40%" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Center" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" SortExpression="Category"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40%" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Need" HeaderText="Service Type" UniqueName="Need" HeaderTooltip="Request or Complaint you Registered." SortExpression="Need"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="40%" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Left" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Task" HeaderText="Description" UniqueName="Task" SortExpression="Task"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="40%" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Left" Width="20%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="TargetDate" HeaderText="Target Date" UniqueName="TargetDate" SortExpression="TargetDate"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40%" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="10%"></ItemStyle>
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn DataField="AssignedBy" HeaderText="Assigned By" UniqueName="AssignedBy" SortExpression="AssignedBy"
                                                            Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridBoundColumn>

                                                        <%--<telerik:GridBoundColumn DataField="Urgency" HeaderText="Urgency" UniqueName="Urgency" SortExpression="Urgency"
                                                            Visible="false" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="50px"></ItemStyle>
                                                        </telerik:GridBoundColumn>--%>
                                                        <telerik:GridBoundColumn DataField="StatusRemarks" HeaderText="Remarks" UniqueName="StatusRemarks" SortExpression="StatusRemarks"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="40%" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Left" Width="20%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="TStatus" HeaderText="Status" UniqueName="TStatus" SortExpression="TStatus"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="35%" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Left" Width="10%"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left" Width="10%"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <%-- <telerik:GridBoundColumn DataField="Dependant" HeaderText="Dependant" UniqueName="Dependant" SortExpression="Dependant"
                                                            Display="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="DMobile" HeaderText="DMobile" UniqueName="DMobile" SortExpression="DMobile"
                                                            Display="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Mobile" HeaderText="Mobile" UniqueName="Mobile" SortExpression="Category"
                                                            Display="false" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="deptname" HeaderText="deptname" UniqueName="deptname" SortExpression="deptname"
                                                            Display="false" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Rate" HeaderText="Rate" UniqueName="Rate" SortExpression="Rate"
                                                            Display="false" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="MSMS" HeaderText="MSMS" UniqueName="MSMS" SortExpression="MSMS"
                                                            Display="false" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="RSMS" HeaderText="RSMS" UniqueName="RSMS" SortExpression="RSMS"
                                                            Display="false" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="DSMS" HeaderText="DSMS" UniqueName="DSMS" SortExpression="DSMS"
                                                            Display="false" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
                                                        </telerik:GridBoundColumn>--%>
                                                    </Columns>
                                                </MasterTableView>
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                </table>
                                <%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
    </div>
</asp:Content>

