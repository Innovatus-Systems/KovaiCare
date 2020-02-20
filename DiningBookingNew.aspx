<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="DiningBookingNew.aspx.cs" Inherits="DiningBookingNew" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />


    <style type="text/css">
        .ddl {
            font-size: small;
            font-family: Verdana;
            display: block;
            padding: 6px;
            width: 214px;
            line-height: 1.42857143;
            color: #000000;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            -ms-border-radius: 4px;
            -o-border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            -o-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            -ms-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            -moz-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            -ms-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
        }
    </style>

    <script type="text/javascript">
        function Validate() {

            var summ = "";
            summ += Dates();
            summ += Session();
            summ += DoorNo();
            summ += Count();


            if (summ == "") {

                var result = confirm('Do you want to save?');

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


        function Dates() {
            var Dates = document.getElementById('<%=dtpDiners.ClientID%>').value;
            if (Dates == "") {
                return "Please Select the date for Booking" + "\n";
            }
            else {
                return "";
            }
        }

        function Session() {
            var Session = document.getElementById('<%=ddlDinersSession.ClientID%>').value;
            if (Session == "0") {
                return "Please Select Dining Session" + "\n";
            }
            else {
                return "";
            }
        }

        function DoorNo() {
            var DoorNo = document.getElementById('<%=ddlByDoorNo.ClientID%>').value;
            if (DoorNo == "0") {
                return "Please Select DoorNo (or) Name" + "\n";
            }
            else {
                return "";
            }
        }

        function Count() {
            var Count = document.getElementById('<%=ddlDinerDined.ClientID%>').value;

            if (Count == "0") {
                return "Please Select Actual Count of Regular (or) Guests for Confirmation." + "\n";
            }
            else {
                return "";
            }
        }


    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt" style="background-color: #FFD47F; height: 500px">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>

                    <div style="width: 100%">

                        <table style="width: 100%">
                            <tr>
                                <td style="text-align: center">
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>

                                </td>
                                <td>
                                    <telerik:RadWindow ID="rwMenuItems" Width="550px" Height="500px" VisibleOnPageLoad="false"
                                        runat="server" Title="Menu Card" Modal="true">
                                        <ContentTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadGrid ID="rgMenuItem" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                            Height="400px" Width="500px" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="false" PageSize="10" OnItemCommand="rgMenuItem_ItemCommand" Skin="Sunset">
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

                                                                    <telerik:GridBoundColumn DataField="RSN" HeaderText="RSN" UniqueName="RSN"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Type" HeaderText="Group" UniqueName="Type"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="ItemName" HeaderText="Item Name" UniqueName="ItemName"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Rate" HeaderText="Price" UniqueName="Rate"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
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

                         <table style="width:100%">
                        <tr>
                            <td>
                                <telerik:RadWindow ID="rwSpecialReport" Width="700" Height="280" VisibleOnPageLoad="false" runat="server"  Title="Profile++" Modal="true">
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
                                                            Height="250px" Width="600px" AllowFilteringByColumn="false" AllowSorting="true" AllowPaging="false" PageSize="5"  Skin="Sunset">
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
                                                                        <HeaderStyle HorizontalAlign="Center"  Width="100px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"  Width="100px"></ItemStyle>
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

                    </div>

                    <div style="width: 100%; float: left;">
                        <div style="width: 50%; float: left;">

                            <table style="border-collapse: collapse; padding: 20px" cellpadding="10px">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label47" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>

                                    <td>
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

                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label49" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlDinersSession" CssClass="ddl" ToolTip="Choose the session where you wish to include the Menu Item." runat="server"
                                                        AutoPostBack="true" OnSelectedIndexChanged="ddlDinersSession_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <tr>

                                    <td>
                                        <asp:Label ID="Label1" runat="Server" Text="For Whom" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>

                                    </td>

                                    <td colspan="2">
                                        <asp:DropDownList ID="ddlforwhom" ToolTip="Is the booking being done for a resident/tenant/office staff/a walkin. Default: Resident" CssClass="ddl" runat="server"
                                            OnSelectedIndexChanged="ddlforwhom_SelectedIndexChanged" AutoPostBack="true" Enabled="false">
                                            <asp:ListItem Text="Resident" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Staff " Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Walkin" Value="2"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>

                                    <td style="vertical-align:top">
                                        <asp:Label ID="Label2" runat="Server" Text="DoorNo/Name" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                        <br />
                                        <br />
                                    </td>

                                    <td>
                                        <asp:DropDownList ID="ddlByDoorNo" ToolTip="Names of those who are booked for the sessions." CssClass="ddl" runat="server"
                                            OnSelectedIndexChanged="ddlByDoorNo_SelectedIndexChanged" AutoPostBack="true">
                                        </asp:DropDownList>
                                        <asp:LinkButton ID="lnkprofile" runat="server" Text ="Profile++" OnClick="lnkprofile_Click" Font-Names="verdana" Font-Bold="true"></asp:LinkButton>
                                    </td>

                                    <td>
                                        <asp:CheckBox ID="chkDoorNo" runat="server" OnCheckedChanged="chkDoorNo_CheckedChanged" AutoPostBack="true" Text="All" ToolTip="Click here to show both regular and casual diners else shows only casual diners." />
                                        &nbsp;&nbsp;&nbsp;
                                         <asp:CheckBox ID="chkRegular" runat="server" OnCheckedChanged="chkRegular_CheckedChanged" AutoPostBack="true" Text="Regular" ToolTip="Click here to show regular diners only." />
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <br />
                                        <asp:Label ID="lblDiner" runat="Server" Text="Diners ?" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium"></asp:Label>

                                    </td>

                                    <td style="text-align: center; vertical-align: central">
                                        <br />
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label7" runat="Server" Text="" ForeColor=" Black" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbldiners" runat="server" Text="Label" Font-Names="verdana" Font-Bold="true" align="center"></asp:Label>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="lbldinerswarning" runat="server" Text="" Font-Names="verdana" Font-Bold="true" align="center" ForeColor="Brown"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>

                                    <td>
                                        <table>
                                            <tr>

                                                <td>
                                                    <br />
                                                    <asp:Label ID="Label3" runat="Server" Text="Booked" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                </td>
                                                <td>
                                                    <br />
                                                    <asp:DropDownList ID="ddlDinerDined" ToolTip="By default, the original booking count (which could be same as the no.of residents) is displayed.  Change if needed." CssClass="ddl" runat="server"
                                                        OnSelectedIndexChanged="ddlDinerDined_SelectedIndexChanged" AutoPostBack="true" Width="50px">
                                                        <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="text-align: center; width: 100px">
                                                    <asp:Label ID="Label5" runat="server" Text="Rs" ForeColor="Brown" Font-Size="Medium" Font-Bold="true"></asp:Label><br />
                                                    <asp:Label ID="lbldineramount" runat="server" Text="" ForeColor="Brown" Font-Size="Medium" Font-Bold="true"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblGuest" runat="Server" Text="Guests?" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    </td>
                                    <td style="text-align: center">

                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="Server" Text="" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblGuests" runat="server" Text="Label" Font-Names="verdana" Font-Bold="true" align="center"></asp:Label>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    <asp:Label ID="lblguestwarning" runat="server" Text="" Font-Names="verdana" Font-Bold="true" align="center" ForeColor="Brown"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>

                                        <table>
                                            <tr>

                                                <td>
                                                    <asp:Label ID="Label4" runat="Server" Text="Booked" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlGuestDined" ToolTip="By default, the original booking count (which could be same as the no.of residents) is displayed.  Change if needed." CssClass="ddl" runat="server"
                                                        OnSelectedIndexChanged="ddlGuestDined_SelectedIndexChanged" AutoPostBack="true" Width="50px">
                                                        <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="text-align: center; width: 100px">
                                                    <asp:Label ID="lblguestamount" runat="server" Text="" ForeColor="Brown" Font-Size="Medium" Font-Bold="true"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>

                                </tr>


                                <tr>
                                    <td colspan="3" align="center">
                                        <asp:Button ID="btnBookNow" runat="Server" Width="100px" Text="Confirm Now"
                                            ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnBookNow_Click" OnClientClick="javascript:return Validate()" />
                                        <asp:Button ID="btnNotNow" runat="Server" Width="100px" Text="Not Now" ToolTip="Click here to close Diners upate." ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnNotNow_Click" />
                                    </td>
                                </tr>
                                <tr>

                                    <td colspan="3" align="center">
                                        <asp:Label ID="lbldiningmsg" runat="server" Text="(The amount will be charged at month end)" ForeColor="Brown" Font-Size="Small" Font-Bold="true"></asp:Label>
                                        <%--<asp:Label ID="lblamtcharged" runat="server" Text="" ForeColor="Brown" Font-Size="Medium" Font-Bold="true"></asp:Label>--%>
                                    </td>

                                </tr>

                                <tr>
                                    <td colspan="3" align="center">
                                        <br />
                                        <asp:Label ID="lblhelp" runat="server" Text=" Booking is needed only for casual diners. Regular diners are automatically booked.
                                        Booking can be done for future sessions or for a session in progress. This can be changed as per your business rules.
                                        One has to confirm the actual dining, after the session is over. Only then , the billing will be done for casual diners.
                                        In case a regular diner skips a session, the count can be updated as zero.
                                        Use 1Touch Confirm to update the diner count for all residents in one stroke." Font-Names="verdana" Font-Size="X-Small" ForeColor="Gray" ></asp:Label>

                                       

                                    </td>
                                </tr>


                            </table>

                        </div>

                        <div style="width: 50%; float: left">
                            <table style="width: 100%">

                                <tr>
                                    <td>
                                        <table>

                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label ID="lblsessionandtime" runat="server" Text="" Font-Bold="true"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="rgDinersTotal" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="Web20"
                                                        Height="100px" Width="400px" AllowSorting="true" AllowMultiRowSelection="true">
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
                                                                <telerik:GridBoundColumn DataField="Type" HeaderText="" UniqueName="Type" Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">

                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Residents" HeaderText="Residents" UniqueName="Residents"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="RegularBooking" HeaderText="Regular" UniqueName="Regular"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="CasualBooking" HeaderText="Casual" UniqueName="Casual"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="GuestBooking" HeaderText="Guest" UniqueName="Guest"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="TotalBooking" HeaderText="Total" UniqueName="HomeService"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
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
                                                </td>

                                            </tr>

                                            <tr>
                                                <td colspan="2">
                                                    <table>
                                                        <tr>
                                                            <td>

                                                                <asp:DropDownList ID="ddlDates" ToolTip="" CssClass="ddl" runat="server" OnSelectedIndexChanged="ddlDates_SelectedIndexChanged" AutoPostBack="true">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <telerik:RadGrid ID="rgDinersSessionDetails" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="Sunset"
                                                                    Height="225px" Width="400px" AllowSorting="true" AllowMultiRowSelection="true" ShowFooter="true">
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
                                                                            <telerik:GridBoundColumn DataField="Date" HeaderText="Date" UniqueName="Date" Visible="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="SessionName" HeaderText="SessionName" UniqueName="SessionName"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="Booked" HeaderText="Booked" UniqueName="Booked"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="Actual" HeaderText="Actual" UniqueName="Actual"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
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
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>

                                        </table>

                                    </td>
                                    <td style="vertical-align: top">
                                        <table>
                                            <tr>
                                                <td align="center">
                                                    <asp:Label ID="lblshotcut" runat="server" Text="Shortcut to" Font-Names="verdana" Font-Bold="true" ForeColor="#6699ff"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnDiningBooking" runat="Server" Width="140px" Text="Confirmation" ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" CssClass="Button" Font-Size="Small" OnClick="btnDiningBooking_Click" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnOneTouchUpdate" runat="Server" Width="140px" Text="One Touch Confirm" ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" CssClass="Button" Font-Size="Small" OnClick="btnOneTouchUpdate_Click" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="btnMenuItems" runat="server" BackColor="DarkGreen" Width="140px" ForeColor="White" Text="Menu Items" ToolTip="Click here to view all Menu Items." CssClass="Button" OnClick="btnMenuItems_Click" />
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

                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnBookNow" />
                    <asp:PostBackTrigger ControlID="btnNotNow" />
                    <asp:PostBackTrigger ControlID="ddlDinersSession" />
                    <asp:PostBackTrigger ControlID="ddlDinerDined" />
                    <asp:PostBackTrigger ControlID="btnDiningBooking" />
                    <asp:PostBackTrigger ControlID="btnOneTouchUpdate" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
