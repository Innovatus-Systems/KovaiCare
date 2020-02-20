<%@ Page Title="DinersSummary" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DinerssummRep.aspx.cs" Inherits="DinerssummRep" %>

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

                            <tr>
                                <td colspan="2" style="font-family:Verdana; color:darkgray; font-size:small">
                                    This is a summary of how many dined each day or over a given period. This report will be useful for quantity estimation, the demand, the kitchen work load etc. If you have WalkIns and Non residing staff who also dine, these will be in the Regular count. Guests are those invited by the residents. Please note that a report for a future date may not give correct information.
                                </td>
                            </tr>

                            <tr style="width: 100%;">
                                <td style="width: 700px;" colspan="2">From Date : &nbsp;  
                                    <telerik:RadDatePicker ID="radfromdate" Width="130px" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Enter a start date from which you wish to have a report."
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
                                     <telerik:RadDatePicker ID="radtilldate" Width="130px" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Enter a date upto which you wish to have a report."
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
                                    <asp:RadioButtonList ID="rbtnlist" Width="210px" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" ToolTip="Summary:Click Summary if you wish to have a consolidated report for the given date range. Detailed:Click Detailed if you wish to have the counts per day of the given date range.">
                                        <asp:ListItem Text="Summary" Value="2" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Detailed" Value="1"></asp:ListItem>
                                    </asp:RadioButtonList>
                                    &nbsp;
                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search" ToolTip="Click here to search." Width="120px" ForeColor="White" BackColor="DarkGreen" Font-Names="Verdana" Font-Size="Small" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="DarkBlue" ToolTip="Click here to export grid data in excel." />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadGrid ID="gvDiners" OnPreRender="gvDiners_PreRender" ShowFooter="true" MasterTableView-FooterStyle-HorizontalAlign="Center" OnItemDataBound="gvDiners_ItemDataBound" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="gvDiners_ItemCommand" Width="100%" AllowFilteringByColumn="true" AllowPaging="false">
                                        <MasterTableView FooterStyle-ForeColor="DarkBlue">
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Date" AllowFiltering="true" DataField="Date" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Day" AllowFiltering="false" DataField="Day" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Session" AllowFiltering="true" DataField="Session" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Regular"  AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Regular" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="R_Dined" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="R_Dined" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Casual"  AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Casual" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="C_Dined" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="C_Dined" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Guests" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Guests" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="G_Dined" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="G_Dined" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Total" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Total" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="T_Dined" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="T_Dined" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Hservice" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Hservice" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="HS_Served" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="HS_Served" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" />
                                        </ClientSettings>
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

