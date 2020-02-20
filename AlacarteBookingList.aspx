<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="AlacarteBookingList.aspx.cs" Inherits="AlacarteBookingList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="font-family: Verdana; font-size: small; min-height: 400px;">
                        
                        <table style="width:100%">
                            <tr>
                                <td align="center">
                                     <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                              
                                        </tr>

                                    </table>

                               
                            </tr>
                        </table>
                        
                        <table cellspacing="5" cellpadding="5">
                            
                            <tr style="vertical-align:middle;">
                                <td>
                                  
                                    From Date : &nbsp;  
                                    <telerik:RadDatePicker ID="radfromdate" Width="130px" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select the date from which you wish to view the A La Carte Bookings"
                                        Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999">
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput ID="DateInput3" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                        </DateInput>
                                        <Calendar ID="Calendar3" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                            <SpecialDays>
                                                <telerik:RadCalendarDay Repeatable="Today">
                                                    <ItemStyle BackColor="Pink" />
                                                </telerik:RadCalendarDay>
                                            </SpecialDays>
                                        </Calendar>
                                    </telerik:RadDatePicker>
                                    Till Date : &nbsp;
                                     <telerik:RadDatePicker ID="radtilldate" Width="130px" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select the date till which you wish to view the A La Carte Bookings"
                                        Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999">
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput ID="DateInput1" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                        </DateInput>
                                        <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                            <SpecialDays>
                                                <telerik:RadCalendarDay Repeatable="Today">
                                                    <ItemStyle BackColor="Pink" />
                                                </telerik:RadCalendarDay>
                                            </SpecialDays>
                                        </Calendar>
                                    </telerik:RadDatePicker> &nbsp;
                                    Session :  <asp:DropDownList ID="ddlSession" ToolTip="Select a session to view the A La Carte Bookings on that session." Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>&nbsp;
                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Width="120px" ForeColor="White" BackColor="DarkGreen" Text="Search" ToolTip="Click here to search." Font-Names="Verdana" Font-Size="Small" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="DarkBlue" ToolTip="Click here to export grid data in excel." />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="gvBookingameal" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                        AutoGenerateColumns="false" OnItemCommand="gvBookingameal_ItemCommand" Width="100%" 
                                        AllowFilteringByColumn="true" AllowPaging="true" PageSize="10" OnInit="gvBookingameal_Init">
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Session" DataField="Session" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DoorNo" DataField="DoorNo"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" DataField="Name" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Item" DataField="Item" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Qty" DataField="Qty" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="No.of.Persons" DataField="NoofPersons" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="BtnnExcelExport" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
