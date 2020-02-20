<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="BulkUpdate.aspx.cs" Inherits="BulkUpdate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

   <link href="Content/bootstrap.css" rel="stylesheet" />

   

   <%-- <style type="text/css">
        .Myheader {
            background-color: DarkGreen !important;
            background-image: none !important;
        }
    </style>--%>

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

     <style type="text/css">
        
.Loadingdiv {
     position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 0.6;
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
    opacity: 1;
    -moz-opacity: 1;
}
.centerdiv img
{
    height: 128px;
    width: 128px;
}

    </style>

     <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt" >

             <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upnlMain">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                             <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="Images/Loader.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
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
                                    
                                    <asp:DropDownList ID="ddlType" ToolTip="(x,y,z)  -  x =  No.of residential diners – regular or casual,   y = Guests, z = Home delivery" CssClass="ddl" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" Width="100px">
                                        <asp:ListItem Text="Regular" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Casual" Value="3"></asp:ListItem>
                                       </asp:DropDownList>
                                </td>
                                <td>
                                     <asp:Label ID="Label1" runat="Server" Text="Dining AT" ForeColor="Black" Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    <asp:DropDownList ID="ddlDiningAT" ToolTip="Select ." CssClass="ddl" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlDiningAT_SelectedIndexChanged" Width="160px">
                                        <asp:ListItem Text ="--Select--" Value="--Select--"></asp:ListItem>
                                        <asp:ListItem Text ="Hall1" Value="Hall1"></asp:ListItem>                                        
                                       </asp:DropDownList>
                                </td>

                                <td>

                                    <asp:Button ID="btnUpdate" runat="Server" Width="70px" Text="Update" ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnUpdate_Click" OnClientClick="javascript:return Validate()" />
                                    <asp:Button ID="btnClear" runat="Server" Width="60px" Text="Clear" ToolTip=" Click here to close Diners upate." ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnClear_Click" />
                                    <asp:Button ID="btnExit" runat="Server" Width="60px" Text="Exit" ToolTip=" Click here to show home page." ForeColor="White" BackColor="DarkBlue" Font-Names="Calibri" Font-Size="Medium" OnClick="btnExit_Click" />
                                </td>

                                <td>
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="small" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>

                            </tr>

                        </table>

                        <table style="width: 80%">
                            <tr>
                                <td style="width: 37%">
                                    <asp:Label ID="lblTotalResident" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="width: 18%">
                                    <asp:Label ID="lblTotalBooked" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="width: 45%">
                                    <asp:Label ID="lblTotalGuestBooked" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                        </table>

                        <table style="width: 100%">
                            
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lnkBookingtoConfirm" runat="server" Text="Booking To Confirm" OnClick="lnkBookingtoConfirm_Click" ForeColor="#000066" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                            
                             <tr>
                                <td style="width: 70%; vertical-align: top">
                                    <telerik:RadGrid ID="rgCasualBulkUpdate" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                        Height="600px" Width="100%" AllowSorting="true" OnItemCreated="rgCasualBulkUpdate_ItemCreated" OnItemDataBound="rgCasualBulkUpdate_ItemDataBound" 
                                        OnItemCommand="rgCasualBulkUpdate_ItemCommand" AllowMultiRowSelection="true" AllowFilteringByColumn="true" OnInit="rgCasualBulkUpdate_Init">
                                        <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>

                                        <HeaderStyle CssClass="Myheader" />
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
                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true" DataKeyNames="RTRSN" AllowSorting="true" AllowFilteringByColumn="true">
                                            <PagerStyle Mode="NumericPages" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </ExpandCollapseColumn>

                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderText="Door No" HeaderStyle-Font-Names="" UniqueName="DoorNo" DataField="rtvillano" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" SortExpression="DoorNo" AllowFiltering="true"
                                                    HeaderTooltip=" Only door numbers of regular diners (those who have opted for monthly payments for regular meals) are displayed.">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkdoorno" runat="server" Text='<%# Eval("rtvillano") %>' ToolTip=" By clicking on the name or Door No, the count is automatically copied to the confirmation fields. Any exceptions, you can always correct the value.  Press Update to apply the changes.  This is applicable only for Regular Not Confirmed and Casual Not Confirmed."></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="" HeaderStyle-Font-Names="" UniqueName="Name" ItemStyle-Width="35%" HeaderStyle-Width="35%" FilterControlWidth="50%" SortExpression="Name" AllowFiltering="true" HeaderTooltip="The nos. indicate the original booking count  (Regular,Guest)">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkBooktoConfirm" runat="server" OnCheckedChanged="chkBooktoConfirm_CheckedChanged" Text="Name" AutoPostBack="true"  />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkname" runat="server" Text='<%# Eval("rtname") %>' CommandArgument='<%# Eval("RTRSN") %>' CommandName="setdiners" ToolTip=" By clicking on the name or Door No, the count is automatically copied to the confirmation fields. Any exceptions, you can always correct the value.  Press Update to apply the changes.  This is applicable only for Regular Not Confirmed and Casual Not Confirmed."></asp:LinkButton>
                                                        
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>


                                                <telerik:GridTemplateColumn HeaderText="R/C" HeaderStyle-Font-Names="" UniqueName="Type" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" SortExpression="Type" AllowFiltering="true" HeaderTooltip="TR indicates regular diner.  C indicates a casual diner.  Different rates may apply.">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnktype" runat="server" Text='<%# Eval("Type") %>' ToolTip="  By clicking on the name or Door No, the count is automatically copied to the confirmation fields. Any exceptions, you can always correct the value.  Press Update to apply the changes.  This is applicable only for Regular Not Confirmed and Casual Not Confirmed."></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="BCount" HeaderStyle-Font-Names="" UniqueName="BCount" ItemStyle-Width="10%" HeaderStyle-Width="10%" SortExpression="BCount" AllowFiltering="false" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkbcount" runat="server" Text='<%# Eval("Booked") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="GCount" HeaderStyle-Font-Names="" UniqueName="GCount" SortExpression="GCount" ItemStyle-Width="10%" HeaderStyle-Width="10%" AllowFiltering="false" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkdcount" runat="server" Text='<%# Eval("GuestBooked") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Diners" UniqueName="Booked" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip="By default shows the number of bookings for a regular diner. Change it if needed , when confirming." AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlBooked" runat="server" SelectedValue='<%# Bind("Actual") %>' AutoPostBack="true" OnSelectedIndexChanged="ddlBooked_SelectedIndexChanged">
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

                                                <telerik:GridTemplateColumn HeaderText="Guests" UniqueName="Guest" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip=" By default shows the number of guest bookings made by a regular diner. Change it if needed , when confirming." AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlGuest" runat="server" SelectedValue='<%# Bind("GuestActual") %>' OnSelectedIndexChanged="ddlGuest_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                             <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                            <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                            <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                            <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                            <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                                            <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                                            <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
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
                                                             <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                            <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                            <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                            <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                            <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                                            <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                                            <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Home Delivery" UniqueName="HomeService" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip=" By default shows the number of guest bookings made by a regular diner. Change it if needed , when confirming." AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlHomeService" runat="server" SelectedValue='<%# Bind("HomeServiceActual") %>' OnSelectedIndexChanged="ddlHomeService_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                             <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                            <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                            <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                            <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                            <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                                            <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                                            <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
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
                                                             <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                            <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                            <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                            <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                            <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                                            <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                                            <asp:ListItem Text="13" Value="13"></asp:ListItem>
                                                            <asp:ListItem Text="14" Value="14"></asp:ListItem>
                                                            <asp:ListItem Text="15" Value="15"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip="Click here if you wish to update all. Uncheck whichever you do not want to update.">
                                                </telerik:GridClientSelectColumn>


                                            </Columns>

                                        </MasterTableView>
                                        <ClientSettings>

                                            <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                            <Selecting AllowRowSelect="true"></Selecting>

                                        </ClientSettings>
                                    </telerik:RadGrid>

                                    <%--  <br />

                                    <asp:LinkButton ID="lnkDinersTotal" runat="server" Text ="Diners Total" ToolTip="Click here to show diners total for selected date,session and type." OnClick="lnkDinersTotal_Click"></asp:LinkButton>

                                    <br />--%>


                                </td>

                                <td style="vertical-align: top; width: 30%">
                                    <table>
                                            
                                        <tr>
                                            <td>

                                                <asp:Label ID="ConfirmationPending" runat="server" Text="Confirmation Pending" Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ForeColor="Red"></asp:Label>

                                                <telerik:RadGrid ID="rgConfirmationPending" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                    Height="250px" Width="100%" AllowSorting="true" AllowMultiRowSelection="true" OnItemCommand="rgConfirmationPending_ItemCommand">
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

                                                            <telerik:GridTemplateColumn HeaderText="Date" HeaderStyle-Font-Names="" UniqueName="Date" DataField="Date" SortExpression="Date" AllowFiltering="true"
                                                                HeaderTooltip="">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkdate" runat="server" Text='<%# Eval("Date") %>' ToolTip="" CommandName="setdiners"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>


                                                            <telerik:GridBoundColumn DataField="sessioncode" HeaderText="sessioncode" UniqueName="sessioncode" Display="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">

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

                                                             <telerik:GridBoundColumn DataField="Value" HeaderText="Value" UniqueName="Value" Display="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">

                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
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
                                            <td align="Center">

                                                <asp:Label ID="lblshotcut" runat="server" Text="Shortcut To" Font-Names="verdana" Font-Bold="true" ForeColor="#000066"></asp:Label>
                                                <br />
                                                <asp:Button ID="btnDiningBooking" runat="Server" Width="145px" Text="Dining-Booking" CssClass="btn btn-success" BackColor="DarkOrange"
                                                    ToolTip="Click here to update the actual diner count." ForeColor="White"  Font-Names="Verdana" BorderColor="Gray"  Font-Size="Medium" OnClick="btnDiningBooking_Click"  />
                                                <%--<asp:Button ID="btnOneTouchUpdate" runat="Server" Width="150px" Text="Dining-Confirmation"
                                                    ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnOneTouchUpdate_Click" />--%>
                                            </td>
                                            </tr>
                                    </table>
                            </tr>

                           
                        </table>

                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <asp:AsyncPostBackTrigger ControlID="btnClear" />
                    <asp:AsyncPostBackTrigger ControlID="ddlDinersSession" />
                    <asp:PostBackTrigger ControlID="btnExit" />
                    <asp:PostBackTrigger ControlID="btnDiningBooking" />
                    <%--<asp:PostBackTrigger ControlID="btnOneTouchUpdate" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
