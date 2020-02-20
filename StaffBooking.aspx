<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StaffBooking.aspx.cs" Inherits="StaffBooking" MasterPageFile="~/CovaiSoft.master"  %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

 <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />


    <script type="text/javascript">
        function Validate() {

            var summ = "";
            summ += Dates();
            summ += Session();


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


    </script>

    <style type="text/css">
        .selectedrow {
            /*background-color:#D4FFD4 !important;*/
            background: #D4FFD4 !important;
        }
    </style>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt" style="background-color: #FDF184">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>

                    <asp:HiddenField ID="hfregularcount" runat="server" />

                    <div style="width: 100%">


                        <%--<table style="width: 100%">
                            <tr>
                                <td style="text-align: center">
                                   

                                </td>
                            </tr>
                        </table>--%>

                        <table style="width: 100%">
                            <tr>

                                <td>
                                    <asp:Label ID="Label47" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                    <telerik:RadDatePicker ID="dtpDiners" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Shows only today and previous days within this billing month." AutoPostBack="true" OnSelectedDateChanged="dtpDiners_SelectedDateChanged">
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
                                    <asp:Label ID="Label49" runat="Server" Text="Session" ForeColor="Black" Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    <asp:DropDownList ID="ddlDinersSession" ToolTip="Shows only completed sessions or a session in progress." CssClass="ddl" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlDinersSession_SelectedIndexChanged" Width="130px">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                     <asp:Label ID="Label2" runat="Server" Text="Type" ForeColor="Black" Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    <asp:DropDownList ID="ddlType" ToolTip="Select Casual or regular diners else both." CssClass="ddl" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" Width="160px">
                                        <asp:ListItem Text ="Staff-Not Booked" Value="1"></asp:ListItem>
                                        <asp:ListItem Text ="Staff-Booked" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>

                                <td>

                                    <asp:Button ID="btnUpdate" runat="Server" Width="100px" Text="Update" ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnUpdate_Click" OnClientClick="javascript:return Validate()" />
                                    <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Click here to close Diners upate." ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnClear_Click" />
                                    <asp:Button ID="btnExit" runat="Server" Width="100px" Text="Exit" ToolTip=" Click here to show home page." ForeColor="White" BackColor="DarkBlue" Font-Names="Calibri" Font-Size="Medium" OnClick="btnExit_Click" />
                                </td>

                                <td>
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>

                            </tr>

                        </table>

                        <table style="width: 80%">
                            <tr>
                                <td style="width:37%">
                                    <asp:Label ID="lblTotalResident" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="width:18%">
                                    <asp:Label ID="lblTotalBooked" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="width:45%">
                                    <asp:Label ID="lblTotalGuestBooked" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                        </table>

                        <table style="width:100%">

                            <tr>
                                <td style="width:70%; vertical-align:top">
                                    <telerik:RadGrid ID="rgCasualBulkUpdate" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                        Height="600px" Width="100%" AllowSorting="true" OnItemCreated="rgCasualBulkUpdate_ItemCreated" OnItemDataBound="rgCasualBulkUpdate_ItemDataBound"
                                         OnItemCommand="rgCasualBulkUpdate_ItemCommand" AllowMultiRowSelection="true" AllowFilteringByColumn="true" OnInit="rgCasualBulkUpdate_Init"  >
                                        <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                        </HeaderContextMenu>
                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings>
                                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                        </ClientSettings>
                                        <SelectedItemStyle CssClass="selectedrow" />
                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true" DataKeyNames="rsn"  AllowSorting="true" AllowFilteringByColumn="true">
                                            <PagerStyle Mode="NumericPages" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </ExpandCollapseColumn>

                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderText="Name" ItemStyle-Width="35%" HeaderStyle-Width="35%" FilterControlWidth="50%" HeaderStyle-Font-Names="" UniqueName="Name" SortExpression="Name" DataField="name" AllowFiltering="true" HeaderTooltip="The nos. indicate the original booking count  (Regular,Guest)">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkname" runat="server" Text='<%# Eval("name") %>' ></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                 <telerik:GridTemplateColumn HeaderText="Designaion" ItemStyle-Width="35%" HeaderStyle-Width="35%" FilterControlWidth="50%" HeaderStyle-Font-Names="" UniqueName="Designation" SortExpression="Designation" DataField="Designation" AllowFiltering="true" HeaderTooltip="The nos. indicate the original booking count  (Regular,Guest)">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkdesignation" runat="server" Text='<%# Eval("designation") %>' ></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>


                                                <telerik:GridTemplateColumn HeaderText="Department" ItemStyle-Width="35%" HeaderStyle-Width="35%" FilterControlWidth="50%" HeaderStyle-Font-Names="" UniqueName="Department" SortExpression="Department" DataField="deptname" AllowFiltering="true" HeaderTooltip="The nos. indicate the original booking count  (Regular,Guest)">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkdepartment" runat="server" Text='<%# Eval("deptname") %>' ></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Diners" UniqueName="Booked" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip="By default shows the number of bookings for a regular diner. Change it if needed , when confirming." AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlBooked" runat="server" SelectedValue='<%# Bind("Booked") %>' AutoPostBack="true" OnSelectedIndexChanged="ddlBooked_SelectedIndexChanged">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblbwarning" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="ddlEditBooked" runat="server" AutoPostBack="true">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>

                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Guests" UniqueName="Guest"  ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip=" By default shows the number of guest bookings made by a regular diner. Change it if needed , when confirming." AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlGuest" runat="server" SelectedValue='<%# Bind("GuestBooked") %>' OnSelectedIndexChanged="ddlGuest_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblgwarning" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="ddlEditGuest" runat="server">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                 <telerik:GridTemplateColumn HeaderText="Home Delivery" UniqueName="HomeService" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip=" By default shows the number of guest bookings made by a regular diner. Change it if needed , when confirming." AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlHomeService" runat="server" SelectedValue='<%# Bind("HomeServiceBooked") %>' OnSelectedIndexChanged="ddlHomeService_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblhswarning" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="ddlEditHomeService" runat="server">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridClientSelectColumn  UniqueName="ClientSelectColumn1" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip="Click here if you wish to update all. Uncheck whichever you do not want to update.">
                                                </telerik:GridClientSelectColumn>


                                            </Columns>

                                        </MasterTableView>
                                        <ClientSettings>

                                            <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                            <Selecting AllowRowSelect="true"></Selecting>

                                        </ClientSettings>
                                    </telerik:RadGrid>

                                </td>
                                <td style="vertical-align:top; width:30%">
                                    <table>
                                         <tr>
                                            <td> 
                                                <asp:LinkButton ID="lnksummary" runat="server" Text="Summary" Font-Names="verdana" Font-Size="Small" Font-Bold="true"></asp:LinkButton>
                                                 <telerik:RadGrid ID="rgDinersTotal" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="Web20"
                                                        Height="173px" Width="100%" AllowSorting="true" AllowMultiRowSelection="true">
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
                                                                <telerik:GridBoundColumn DataField="Type" HeaderText="" UniqueName="Type" Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterText="Total" FooterStyle-HorizontalAlign="Left">

                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Booking" HeaderText="Booking" UniqueName="Booking" DataType="System.Int32" Aggregate="Sum" FooterAggregateFormatString="{0}"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Confirm" HeaderText="Dined" UniqueName="Confirm" DataType="System.Int32" Aggregate="Sum" FooterAggregateFormatString="{0}"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small"  FooterStyle-HorizontalAlign="Center">
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

                                                <telerik:RadGrid ID="rgTotalStaffDiners" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="Web20"
                                                        Height="125px" Width="100%" AllowSorting="true" AllowMultiRowSelection="true">
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
                                                                <telerik:GridBoundColumn DataField="Type" HeaderText="Home Delivery" UniqueName="Type" Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterText="Total" FooterStyle-HorizontalAlign="Left">

                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Booking" HeaderText="Booking" UniqueName="Booking" DataType="System.Int32" Aggregate="Sum" FooterAggregateFormatString="{0}" FooterStyle-HorizontalAlign="Center"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Confirm" HeaderText="Confirm" UniqueName="Confirm" DataType="System.Int32" Aggregate="Sum" FooterAggregateFormatString="{0}" FooterStyle-HorizontalAlign="Center"
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
                                                <asp:Label ID="ConfirmationPending" runat="server" Text="Confirmation Pending" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ForeColor="Red"></asp:Label>

                                                 <telerik:RadGrid ID="rgConfirmationPending" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="Web20"
                                                        Height="250px" Width="100%" AllowSorting="true" AllowMultiRowSelection="true">
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
                                                                <telerik:GridBoundColumn DataField="Date" HeaderText="Date" UniqueName="Date" Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">

                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="sessionname" HeaderText="Session" UniqueName="sessionname" DataType="System.Int32" 
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type" 
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
                                            <td align="center">
                                                <asp:Label ID="lblshotcut" runat="server" Text="Shortcut to" Font-Names="verdana" Font-Bold="true" ForeColor="#6699ff"></asp:Label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td align="center">
                                               <%-- <asp:Button ID="btnDiningBooking" runat="Server" Width="125px" Text="Dining-Booking"
                                                    ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnDiningBooking_Click" />--%>
                                                <asp:Button ID="btnOneTouchUpdate" runat="Server" Width="150px" Text="Dining-Confirmation"
                                                    ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnOneTouchUpdate_Click" />
                                            </td>
                                    </table>
                            </tr>

                            </td>
                                
                            </tr>

                            <tr>
                                <td></td>
                            </tr>
                        </table>

                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <asp:PostBackTrigger ControlID="btnClear" />
                    <asp:PostBackTrigger ControlID="ddlDinersSession" />
                    <asp:PostBackTrigger ControlID="btnExit" />
                    <asp:PostBackTrigger ControlID="btnOneTouchUpdate" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>