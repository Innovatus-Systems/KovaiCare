<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="DiningReport.aspx.cs" Inherits="DiningReport" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
               
                    <table style="width:100%">
                        <tr>
                        <td align="center">
                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                        </td>
                    </tr>
                    </table>
                     <table>
                    

                    <tr>
                        
                            <td style="width: 700px;" colspan="2">Select Date : &nbsp;  
                                    <telerik:RadDatePicker ID="radfromdate" Width="130px" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select from date."
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

                                <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Search" ToolTip="Click here to show dining report details." Width="90px" ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                        <asp:Label ID="Label1" runat="server" Text="Diners Count" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>
                             <asp:Label ID="lblcdate" runat="server" Text="" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadGrid ID="gvCount" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Width="100%" >
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Session" DataField="SessionName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Regular" DataField="Regular"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Regular Actual" DataField="RegularActual"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Guest" DataField="Guest" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Guest Actual" DataField="GuestActual" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Total" DataField="Total" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Total Actual" DataField="TotalActual" ReadOnly="true" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                            </td>
                        <td style="vertical-align:top">
                             <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="DarkBlue" ToolTip="Click here to export grid data in excel." />
                        </td>
                    </tr>
                     <tr>
                        <td>
                        <asp:Label ID="Label2" runat="server" Text="Menu" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>
                            <asp:Label ID="lblmdate" runat="server" Text="" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>
                              
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadGrid ID="gvMenu" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"  Width="100%" >
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Session" DataField="SessionName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Item" DataField="ItemName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Contains" DataField="[Contains]" ReadOnly="true"></telerik:GridBoundColumn>
                                               
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                            </td>
                        <td style="vertical-align:top">
                            <asp:Button ID="btnMenuExport" runat="server" CssClass="btn-success" Font-Bold="true" Text="Export to Excel" OnClick="btnMenuExport_Click" ForeColor="DarkBlue" ToolTip="Click here to export grid data in excel." />
                        </td>
                    </tr>
                     <tr>
                        <td>
                        <asp:Label ID="Label3" runat="server" Text="A la carte Menu Booking - Sorted by Session , Name" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>
                            <asp:Label ID="lblb1date" runat="server" Text="" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>
                              
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <telerik:RadGrid ID="gvBooking" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"  Width="100%"  >
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Session" DataField="SessionName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DoorNo" DataField="DoorNo"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" DataField="Name" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Item" DataField="ItemName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Count" DataField="Count" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Qty" DataField="Qty" ReadOnly="true"></telerik:GridBoundColumn>
                                                
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                            </td>
                        <td style="vertical-align:top">
                            <asp:Button ID="btnSWExport" runat="server" CssClass="btn-success" Font-Bold="true" Text="Export to Excel" OnClick="btnSWExport_Click" ForeColor="DarkBlue" ToolTip="Click here to export grid data in excel." />
                        </td>
                    </tr>
                    <tr>
                         <td style="vertical-align:top">
                        <asp:Label ID="Label4" runat="server" Text="A la carte Menu Booking - Sorted by Session , MenuItem" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>
                        <asp:Label ID="lblb2date" runat="server" Text="" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>
                               
                        </td>
                        </tr>
                    <tr>
                        <td>
                             <telerik:RadGrid ID="gvBooking2" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"  Width="100%"  >
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Session" DataField="SessionName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Item" DataField="ItemName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DoorNo" DataField="DoorNo"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" DataField="Name" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Count" DataField="Count" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Qty" DataField="Qty" ReadOnly="true"></telerik:GridBoundColumn>
                                                
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                            
                        </td>
                        <td style="vertical-align:top">
                            <asp:Button ID="btnIWExport" runat="server" CssClass="btn-success" Font-Bold="true" Text="Export to Excel" OnClick="btnIWExport_Click" ForeColor="DarkBlue" ToolTip="Click here to export grid data in excel." />
                        </td>
                    </tr>
                </table>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="BtnnExcelExport" />
                     <asp:PostBackTrigger ControlID="btnMenuExport" />
                    <asp:PostBackTrigger ControlID="btnSWExport" />
                    <asp:PostBackTrigger ControlID="btnIWExport" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
