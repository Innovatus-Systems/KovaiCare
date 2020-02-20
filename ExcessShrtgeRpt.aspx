<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ExcessShrtgeRpt.aspx.cs" Inherits="ExcessShrtgeRpt" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
           <link href="CSS/bootstrap.css" rel="stylesheet" />
     <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }        
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

            <div class="main_cnt">
                <div class="first_cnt">                       
                   <table style="width: 100%">
                        <tr>
                            <td align="center">
                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>

                    <table align="Center" style="width: 90%">

                        <tr>
                            <td>&nbsp; &nbsp;
                                <asp:Label ID="lblFrom" runat="server" Text="From :" ></asp:Label>
                                <telerik:RadDatePicker ID="rdtFrom" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                    Width="175px" CssClass="TextBox" ReadOnly="true"  ToolTip="Select date in future to enter the booking.Select date in the past to enter the Actual counts.">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                        CssClass="TextBox" Font-Names="Calibri">
                                    </Calendar>
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                        ForeColor="Black" ReadOnly="true">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                &nbsp; &nbsp; &nbsp; &nbsp;
                                 <asp:Label ID="lblTill" runat="server" Text="Till :" ></asp:Label>
                                <telerik:RadDatePicker ID="rdtTill" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                    Width="175px" CssClass="TextBox" ReadOnly="true"  ToolTip="Select date in future to enter the booking.Select date in the past to enter the Actual counts.">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                        CssClass="TextBox" Font-Names="Calibri">
                                    </Calendar>
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                        ForeColor="Black" ReadOnly="true">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                &nbsp; &nbsp; &nbsp; &nbsp;
                         
                                <asp:Label ID="lblSession" runat="server" Text="Session :" ></asp:Label>
                               
                                &nbsp; &nbsp;
                                <asp:DropDownList ID="drpSession" runat="server" ToolTip="Make sure you are selecting the right session which is yet to happen." OnSelectedIndexChanged="drpSession_SelectedIndexChanged"></asp:DropDownList>
                               
                                  &nbsp; &nbsp;
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success"  OnClick="btnSearch_Click" OnClientClick="return Chart();" ToolTip="To search particular date and session for booking and actual counts." />
                                 &nbsp; &nbsp;
                                <asp:Button ID="btnReturn" runat="server" Text="Return" CssClass="btn btn-primary"   BackColor="#ff6600" BorderColor="#ff6600"  OnClick="btnReturn_Click" ToolTip="Retrun to Dining Bookings" />
                                
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td align="center" colspan="5">
                                <telerik:RadGrid ID="rgDinBkng" runat="server" AutoPostBack="true"
                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="true" 
                                     Width="98%" OnInit="rgDinBkng_Init"
                                    MasterTableView-HierarchyDefaultExpanded="true">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                    </ClientSettings>
                                    <HeaderContextMenu CssClass="table table-bordered table-hover">
                                    </HeaderContextMenu>
                                    <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                    <MasterTableView AllowCustomPaging="false">
                                        <NoRecordsTemplate>
                                            No Records Found.
                                        </NoRecordsTemplate>
                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                        <RowIndicatorColumn>
                                            <HeaderStyle Width="10px"></HeaderStyle>
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn>
                                            <HeaderStyle Width="10px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>
                                            <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="150px" FilterControlWidth="100px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="100px" DataField="Session" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                             <telerik:GridBoundColumn HeaderText="Regular" HeaderStyle-Width="80px" DataField="Regular" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="55px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Casual" HeaderStyle-Width="80px" DataField="Casual" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="55px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="HomeDly." HeaderStyle-Width="80px" DataField="HS" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="55px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Res.Guests" HeaderStyle-Width="80px" DataField="Guests" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="55px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="G.House" HeaderStyle-Width="80px" DataField="GH" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="55px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Staff" HeaderStyle-Width="80px" DataField="Staff" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="55px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Total" HeaderStyle-Width="80px" DataField="Total" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="55px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Actual" HeaderStyle-Width="80px" DataField="Actual" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="55px"></telerik:GridBoundColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                        <PagerStyle AlwaysVisible="True"></PagerStyle>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                    <FilterMenu Skin="WebBlue" EnableTheming="True">
                                        <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                    </FilterMenu>
                                </telerik:RadGrid>
                            </td>
                            
                        </tr>
                    </table>
                   <div align="Center" style="width:90%;">
                       <script type="text/javascript" src="https://www.google.com/jsapi"></script>
                       <asp:Literal ID="ltrscr" runat="server"></asp:Literal>
                       <div id="chart_div" style="width:95%; height: 370px"/>
                   </div>
                </div>
            </div>
      

</asp:Content>

