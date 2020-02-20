<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="HomeMenu.aspx.cs" Inherits="HomeMenu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

  <style>
        .newtile {
            height: 150px;
            width: 290px;
            display: inline-block;
            margin-right: 4px;
            margin-bottom: 8px;
        }

        .inside {
            text-align: center;
            font-family: Arial;
            margin-top: 60px;
        }


        .ButtonInfi {
            background-color: #38ACEC;
            width: 75px;
            height: 27px;
            padding: 5px;
            color: white;
            cursor: pointer;
            text-align: center;
            align-self: flex-start;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            -khtml-border-radius: 5px;
            behavior: url(/border-radius.htc);
            border-radius: 5px;
        }

        .lblStyle1 {
            color: Black;
            font-family: Verdana;
            font-size: 13px;
        }
    </style>


    <style type="text/css">
        .preference .rwWindowContent {
            background-color: beige !important;
        }


        .availability .rwWindowContent {
            background-color: Yellow !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  


        <div>

            <asp:Panel ID="Panel1" runat="server" Width="100%" HorizontalAlign="Center" BackColor="#F0F0F0" DefaultButton="btnSearch">

                <asp:Label ID="Label6" runat="server" Font-Size="Small" Text="Resident name search" Font-Names="Verdana" ForeColor="Black" Visible="true"></asp:Label>
                &nbsp;
                <asp:TextBox ID="txtNSearch" runat="server" Font-Size="Small" Font-Names="Calibri" Style="width: 300px; background-color: palegoldenrod" BorderStyle="Outset" BorderWidth=".1px" Font-Bold="false" ForeColor="Black" ToolTip="Press Enter key or Search button to Search"></asp:TextBox>
                &nbsp;&nbsp;                    
                <asp:Button ID="btnSearch" runat="server" Text="Search" Font-Size="Small" CssClass="ButtonRC" OnClick="BtnSearch_Click" ToolTip="Enter minimum of four letters of resident name to view a list of residents matching the criteria." />
                <asp:Button ID="btnScoreboard" runat="server" Text="Snapshot" Visible="false" Font-Size="Small" CssClass="ButtonInfi" OnClick="btnScoreboard_Click" ToolTip="Get a summary snapshot about the community" />
                <asp:Button ID="btnEvents" runat="server" Text="Events" Font-Size="Small" CssClass="ButtonInfi" OnClick="btnEvents_Click" ToolTip="Click here to view a snapshot of the events planned" />
                <asp:Button ID="btnDinersUpdate" runat="server" Text="Confirm Dining" Visible="true" Font-Size="Small" CssClass="ButtonInfi" Width="100px" OnClick="btnDinersUpdate_Click" ToolTip=" Click here to open the Diners Update window.  Use this during a breakfast or lunch or dinner session to mark the arrival of a resident or a guest. You can also use other Menu options available for updating the  Diners count." />
                <asp:Button ID="btnDinersBooking" runat="server" Text="Confirm Dining - R" Visible="true" Font-Size="Small" CssClass="ButtonInfi" Width="125px" OnClick="btnDinersBooking_Click" ToolTip=" Click here to open the Diners Booking window.  Use this during a breakfast or lunch or dinner session to mark the arrival of a resident or a guest. You can also use other Menu options available for updating the  Diners count." />
            </asp:Panel>
        </div>

        <div style="margin-top: 30px; width: 100%;" align="center">
            <div>
                <%-- #4D94DB--%>
                <a href="ResidentAdd.aspx">
                    <div id="dvresident" class="newtile" style="background-color: #002060" title="Store the personal profiles, health records, details of next-of-kin and important contacts, qualifications, achievements, hobbies, important dates to remember and more.  A profile can be for all types of residents - Owners, their dependents, tenants and also the staff.">
                        <div class="inside">
                            <h4 style="font-family: Arial; color: white">Residents</h4>
                        </div>
                    </div>
                </a>

                <a href="FoodMenu.aspx">
                    <div class="newtile" style="background-color: #002060" title="Click here to set the daily menu well in advance for residents. Know how much to cook and therefore avoid wastage.">
                        <div class="inside">
                            <h4 style="font-family: Arial; color: white">Dining</h4>
                        </div>
                    </div>
                </a>
                <a href="TransactionLevelInd.aspx">
                    <div class="newtile" style="background-color: #002060" title="Click here to post financial transactions – debits and credits to a resident account either one by one or in one –shot in the group-billing option.">
                        <div class="inside">
                            <h4 style="font-family: Arial; color: white">Billing & Receipts</h4>
                        </div>
                    </div>
                </a>
                <%--<a href="ExitEntry.aspx">--%>
                <a href="CheckINOUT.aspx">
                    <div class="newtile" style="background-color: #002060" title="Click here to maintain the CheckOut Register for the residents.  System will alert if a resident is away for more than a specified time.">
                        <div class="inside">
                            <h4 style="font-family: Arial; color: white">Care & Safety</h4>
                        </div>
                    </div>
                </a>
            </div>
            <div>

                <a href="DayCalendar.aspx">
                    <div class="newtile" style="background-color: #00B050" title="Complaints and service requests by residents, are posted here and tracked to completion.  Events planned in the community, are also recorded here.">
                        <div class="inside">
                            <h4 style="font-family: Arial; color: white">Services & Events</h4>
                        </div>
                    </div>
                </a>

                <a href="DailyFoodBillReport.aspx">
                    <div class="newtile" style="background-color: #00B050" title="Click here to view various reports including monthly billing summary.">
                        <div class="inside">
                            <h4 style="font-family: Arial; color: white">Reports</h4>
                        </div>
                    </div>
                </a>
                <a href="Charts.aspx">
                    <div class="newtile" style="background-color: #00B050" title="Click here to view various types of statistical data (Ex: Resident’s occupancy) as graphs.">
                        <div class="inside">
                            <h4 style="font-family: Arial; color: white">Charts</h4>
                        </div>
                    </div>
                </a>

                <a href="Admin.aspx">
                    <div class="newtile" style="background-color: #00B050" title="Click here to manage different operational parameters (Ex:  Maintain the Profile++ key words)">
                        <div class="inside">
                            <h4 style="font-family: Arial; color: white">Settings</h4>
                        </div>
                    </div>

                </a>
            </div>

        </div>

        <br />
        <div style="width: 100%; display: none">
            <table border="1" style="width: 100%">
                <tr style="background-color: yellow">
                    <td style="width: 25%; height: 5px; align-items: center">
                        <asp:Label ID="lblResidentCnt" runat="server" ForeColor="Black" CssClass="lblStyle1" ToolTip="Shows count of residents in the community as of now."></asp:Label></td>

                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblVacantCnt" runat="server" ForeColor="Black" Text="" CssClass="lblStyle1"></asp:Label></td>
                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblCheckedOutCnt" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label>
                        <asp:Label ID="Label4" Text="/" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label>
                        <asp:LinkButton ID="lblAlerts" runat="server" ForeColor="Black" CssClass="lblStyle1" OnClick="lblAlerts_Click" ToolTip=" Shows no. of residents who are away from the community for more than four hours. Check if they need any assistance." Font-Underline="false"></asp:LinkButton>
                    </td>
                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblLivingAloneCnt" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label></td>
                </tr>
                <tr style="background-color: yellow">
                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblBilled" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label></td>

                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblOutstanding" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label>

                    </td>
                    <td style="width: 25%; height: 5px">
                        <asp:Label ID="lblUnBilled" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label></td>
                    <td style="width: 25%; height: 5px">
                        <asp:LinkButton ID="lblTasks" runat="server" ForeColor="Black" CssClass="lblStyle1" OnClick="lblTasks_Click" ToolTip="Shows count of tasks which are still to be completed." Font-Underline="false"></asp:LinkButton>
                        <asp:Label ID="Label5" Text="/" runat="server" ForeColor="Black" CssClass="lblStyle1"></asp:Label>

                        <asp:LinkButton ID="lblOverduetasks" runat="server" ForeColor="Black" CssClass="lblStyle1" OnClick="lblTasks_Click" ToolTip="Shows count of tasks which are in Overdue." Font-Underline="false"></asp:LinkButton>

                    </td>
                </tr>
            </table>
        </div>
        <div style="width: 100%; display: none">
            <asp:Panel ID="Panel2" runat="server" Width="100%" HorizontalAlign="left" BorderColor="Wheat" BorderStyle="Inset" BorderWidth=".5px">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblRecentCr" Height="10px" Font-Size="X-Small" ForeColor="Gray" runat="server"></asp:Label>
                            <asp:Label ID="lblRecentDr" Height="10px" Font-Size="X-Small" ForeColor="Gray" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <div>
            <asp:Panel ID="Panel4" runat="server" Width="100%" HorizontalAlign="Center" BackColor="White">
                <marquee>
                         <asp:Label ID="lblDayMsg" Height="10px" Font-Size="Medium"  ForeColor="#002060" runat="server"  Text="" Font-Names="Calibri" ></asp:Label>
                </marquee>
            </asp:Panel>

        </div>

        <div style="width: 100%;">
            <telerik:RadWindowManager ID="rwmgr" runat="server">
                <Windows>
                    <telerik:RadWindow ID="rwPopUp" Title="OnComing Events" BackColor="LightGreen" runat="server" VisibleOnPageLoad="false" Visible="false" Modal="true" Height="350px" Width="550px">
                        <ContentTemplate>
                            <table align="left" style="width: 100%;">
                                <tr>
                                    <td align="left">
                                        <text style="color: darkgray; font-family: Verdana; font-size: small; text-align: left;">
                                            Showing OnComing events only
                                        </text>
                                    </td>
                                    <td align="right">
                                        <asp:LinkButton ID="lbtnEvents" PostBackUrl="~/Events.aspx" Font-Names="Verdana" Font-Size="Small" runat="server" ToolTip="Click here view all events" Text="All Events"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:DataList ID="dlistEvents" runat="server" BackColor="#FFFF99" BorderColor="#666666"
                                            BorderStyle="None" BorderWidth="2px" CellPadding="3" CellSpacing="2"
                                            Font-Names="Verdana" Font-Size="Small" GridLines="Both" RepeatColumns="1" RepeatDirection="Vertical"
                                            Width="500px">
                                            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                                            <HeaderStyle Font-Names="Verdana" Font-Bold="true" ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <HeaderTemplate>OnComing Events</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lbldate" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" runat="server" Text='<%# Eval("TillDate") %>'></asp:Label>
                                                &nbsp;&nbsp;
                                                <asp:Label ID="lblevent" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkBlue" runat="server" Text='<%# Eval("EventName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:Button ID="btnClose" CssClass="ButtonInfi" runat="server" OnClick="btnClose_Click" Text="Close" ToolTip="Click here to close" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        </div>

        <div>
            <telerik:RadWindow ID="rwDinersUpdate" Title="Diners Update" CssClass="preference" runat="server" VisibleOnPageLoad="false" Visible="false" Modal="true" Height="500px" Width="750px">
                <ContentTemplate>
                    <div style="width: 100%;">
                        <table style="width: 100%">
                            <tr>
                                <td style="text-align: center">
                                    <asp:Label ID="Label2" runat="server" Text="Booking & Actual Count Update for a Resident" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                </td>

                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr style="width: 100%;">
                                <td style="width: 55%;">
                                    <table>
                                        <tr>
                                            <td style="text-align: center">
                                                <asp:Label ID="Label47" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                                <telerik:RadDatePicker ID="dtpDiners" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="175px" CssClass="TextBox" ReadOnly="true" ToolTip="You can update ony for todays sessions." AutoPostBack="true" OnSelectedDateChanged="dtpDiners_SelectedDateChanged">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>

                                            <td style="text-align: center">
                                                <asp:Label ID="Label49" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>

                                                <asp:DropDownList ID="ddlDinersSession" ToolTip="Choose the session where you wish to include the Menu Item." Width="100px" Height="25px" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlDinersSession_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">
                                                <asp:CheckBox ID="chkByDoorNo" runat="server" Text="By DoorNo" OnCheckedChanged="chkByDoorNo_CheckedChanged" AutoPostBack="true" /><br />
                                                <asp:DropDownList ID="ddlByDoorNo" ToolTip="Names of those who are booked for the sessions." Width="150px" Height="25px" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlByDoorNo_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="text-align: center">
                                                <asp:CheckBox ID="chkByName" runat="server" Text="By Name" OnCheckedChanged="chkByName_CheckedChanged" AutoPostBack="true" /><br />
                                                <asp:DropDownList ID="ddlByName" ToolTip="Names of those who are booked for the sessions." Width="150px" Height="25px" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlByName_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center">

                                                <asp:Label ID="lblDiner" runat="Server" Text="Resident " ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>

                                                <asp:DropDownList ID="ddlDiner" ToolTip="By default, the original booking count (which could be same as the no.of residents) is displayed.  Change if needed." Width="50px" Height="25px" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small">
                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                </asp:DropDownList>

                                            </td>

                                            <td style="text-align: center">
                                                <asp:Label ID="lblGuest" runat="Server" Text="Guest   " ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                <asp:DropDownList ID="ddlGuest" ToolTip=" Did the resident have a guest today?  If so, enter it here.  By default the booking count is displayed." Width="50px" Height="25px" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small">
                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                </asp:DropDownList>

                                            </td>

                                        </tr>
                                        <tr>
                                            <td colspan="2" style="text-align: center">
                                                <asp:Button ID="btnDinersSave" runat="Server" Width="70px" Text="Update" ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnDinersSave_Click" OnClientClick="javascript:return TaskConfirmMsgET()" />
                                                <asp:Button ID="btnDinersClose" runat="Server" Width="70px" Text="Close" ToolTip=" Click here to close Diners upate." ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnDinersClose_Click" />
                                            </td>
                                        </tr>

                                    </table>
                                </td>
                                <td style="vertical-align: top; text-align: left; width: 45%;" align="left">
                                    <asp:Label ID="Label1" runat="server" Text="Update the count here for each session.  Default count are displayed and if the actual is different, simply change it.
                                     Remember the Door No or Name will appear here only if the resident has made a booking first."></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td style="width: 45%">
                                                <asp:Panel ID="pandiners" Height="250px" runat="server">
                                                    <telerik:RadGrid ID="rgDiners" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                        Width="400px" Height="250px" AllowSorting="true" AllowMultiRowSelection="true">
                                                        <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true" />
                                                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true">
                                                            <PagerStyle Mode="NumericPages" />
                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                            <RowIndicatorColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </RowIndicatorColumn>
                                                            <ExpandCollapseColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </ExpandCollapseColumn>

                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="DoorNo" HeaderText="DoorNo" UniqueName="DoorNo"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Name" HeaderText="Name" UniqueName="Name"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="RegularA" HeaderText="Regular" UniqueName="RegularA"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="CasualA" HeaderText="Casual" UniqueName="CasualA"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="GuestA" HeaderText="Guest" UniqueName="GuestA"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="TotalA" HeaderText="Total" UniqueName="TotalA"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                            <Selecting AllowRowSelect="true"></Selecting>

                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </asp:Panel>
                                            </td>
                                            <td style="vertical-align: top; width: 55%;">
                                                <table border="1" align="left" style="width: 100%;">
                                                    <tr style="width: 100%;">
                                                        <td></td>
                                                        <td style="width: 200px;" align="center">
                                                            <asp:Label ID="Label3" Font-Bold="true" runat="Server" Text="Booked" ForeColor="Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                        </td>
                                                        <td style="width: 200px;" align="center">
                                                            <asp:Label ID="Label7" Font-Bold="true" runat="Server" Text="Actual" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <text style="font-family: Verdana; font-weight: bold;">Resident</text>
                                                        </td>
                                                        <td align="center">
                                                            <asp:Label ID="lblbooked" runat="Server" Text="" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                        </td>
                                                        <td align="center">
                                                            <asp:Label ID="lblactualbooked" runat="Server" Text="" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <text style="font-family: Verdana; font-weight: bold;">Guest</text>
                                                        </td>
                                                        <td align="center">
                                                            <asp:Label ID="lblguestbooked" runat="Server" Text="" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                        </td>
                                                        <td align="center">
                                                            <asp:Label ID="lblactualguest" runat="Server" Text="" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>

                                            </td>

                                        </tr>
                                    </table>




                                </td>

                            </tr>
                        </table>
                    </div>

                </ContentTemplate>
            </telerik:RadWindow>

            <telerik:RadWindow ID="rwDinersBooking" Title="DinersUpdate" CssClass="preference" runat="server" VisibleOnPageLoad="false" Visible="false" Modal="true" Height="500px" Width="750px">
                <ContentTemplate>
                    <div style="width: 100%;">
                        <table style="width: 100%">
                            <tr>
                                <td style="text-align: center" colspan="2">
                                    <asp:Label ID="Label8" runat="server" Text="Diners Booking" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label9" runat="server" Text="Happy Seniors" Font-Names="Verdana" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblcsession" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="lblcbirthday" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                </td>

                            </tr>
                        </table>
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:Label ID="Label10" runat="server" Text="Please confirm your arrival here" Font-Names="Verdana" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                </td>
                            </tr>
                           <%-- <tr>
                                <td style="text-align: center">
                                    <asp:CheckBox ID="chkRByDoorNo" runat="server" Text="By DoorNo" OnCheckedChanged="chkRByDoorNo_CheckedChanged" AutoPostBack="true" /><br />
                                    <asp:DropDownList ID="ddlRByDoorNo" ToolTip="Names of those who are booked for the sessions." Width="150px" Height="25px" runat="server"
                                        Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlRByDoorNo_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                                <td style="text-align: center">
                                    <asp:CheckBox ID="chkRByName" runat="server" Text="By Name" OnCheckedChanged="chkRByName_CheckedChanged" AutoPostBack="true" /><br />
                                    <asp:DropDownList ID="ddlRByName" ToolTip="Names of those who are booked for the sessions." Width="150px" Height="25px" runat="server"
                                        Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlRByName_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                            </tr>--%>
                            <tr>
                                <td>
                                    <asp:Label ID="Label12" runat="server" Text="Pl. enter your 4 digit PIN" Font-Names="Verdana" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPinNumber" runat="server"></asp:TextBox>
                                </td>
                            </tr>

                        </table>
                    </div>
                </ContentTemplate>
            </telerik:RadWindow>


        </div>

    
</asp:Content>

