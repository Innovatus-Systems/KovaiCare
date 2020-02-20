<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/CovaiSoft.master" CodeFile="DinersActualSummary.aspx.cs" Inherits="DinersActualSummary" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="font-family: Verdana; font-size: small; min-height: 400px; width: 100%;">
                        <table cellspacing="5" cellpadding="5" style="width: 100%;">
                            <tr style="width: 100%;">
                                <td align="left">
                                    
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblDate" runat="server" Font-Names="Verdana" Font-Size="Small" ForeColor="DarkGray"></asp:Label>
                                </td>
                            </tr>
                            <tr style="width: 100%;">
                              
                                    <td style="width: 700px;" colspan="2">Session : &nbsp;
                                         <asp:DropDownList ID="ddlSession" ToolTip="Choose the session where you wish to include the Menu Item." Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>
                                        From Date : &nbsp;  
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
                                    Until Date : &nbsp;
                                     <telerik:RadDatePicker ID="radtilldate" Width="130px" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select till date."
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
                                     </telerik:RadDatePicker>
                                   
                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search" ToolTip="Click here to search." Width="120px" ForeColor="White" BackColor="DarkGreen" Font-Names="Verdana" Font-Size="Small" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblhelp" runat="server" Text="Shows the count of  diners who dined - for a session or for a range of dates."></asp:Label>
                                </td>
                                <td align="right" colspan="2">
                                    <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="DarkBlue" ToolTip="Click here to export grid data in excel." />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadGrid ID="gvDiners"  ShowFooter="true" MasterTableView-FooterStyle-HorizontalAlign="Center"  GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"  AllowFilteringByColumn="true">
                                        <MasterTableView FooterStyle-ForeColor="DarkBlue">
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Date" AllowFiltering="false" DataField="Date" ReadOnly="true" ItemStyle-Width="150px" HeaderStyle-Width="150px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Day" AllowFiltering="false" DataField="Day" ReadOnly="true" ItemStyle-Width="150px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Session" AllowFiltering="false" DataField="Session" ReadOnly="true" ItemStyle-Width="150px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Regular"  AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Regular" ReadOnly="true" ItemStyle-Width="150px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Casual"  AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Casual" ReadOnly="true" ItemStyle-Width="150px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Guests" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Guests" ReadOnly="true" ItemStyle-Width="150px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Home Service" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="HomeService" ReadOnly="true" ItemStyle-Width="150px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Total" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Total" ReadOnly="true" ItemStyle-Width="150px"></telerik:GridBoundColumn>
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
                    <asp:PostBackTrigger ControlID="btnSearch" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
