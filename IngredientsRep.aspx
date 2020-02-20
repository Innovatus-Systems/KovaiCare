<%@ Page Title="Ingredients Report" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="IngredientsRep.aspx.cs" Inherits="Default2" %>

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
                         <table cellspacing="5" cellpadding="5">
                           
                            <tr style="vertical-align:middle;">
                                <td>
                                    <text style="font-family: Verdana;">Name :</text>
                                    &nbsp;
                                    <asp:DropDownList ID="ddlName" Width="150px" runat="server" ToolTip="Select the ingredient to view its usage details."></asp:DropDownList>
                                    &nbsp;
                                    <text style="font-family: Verdana;">Group :</text>
                                    &nbsp;
                                     <asp:DropDownList ID="ddlGroup" ToolTip="Provisions  - Also refers to Groceries . Ex: Rice, Oil,  Wheat, Pulses etc.
                                                 Fruits & Vegetables -    Also refers to Vegetables, Fruits, Milk, Egg etc    
                                                 Consumables -   Refers to items such as Paper cups, paper plates,  Plastic spoons, tissue box,  Plantain leaf , Cooking Gas  etc."
                                                    Width="150px" Height="25px" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small">
                                                </asp:DropDownList>
                                    &nbsp;

                                    From Date : &nbsp;  
                                    <telerik:RadDatePicker ID="radfromdate" Width="130px" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select a date from which you have to view the ingredient usage details."
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
                                     <telerik:RadDatePicker ID="radtilldate" Width="130px" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select a date till which you have to view the ingredient usage details."
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
                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Width="120px" ForeColor="White" BackColor="DarkGreen" Text="Search" ToolTip="Click here to search." Font-Names="Verdana" Font-Size="Small" />
                                    <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="DarkBlue" ToolTip="Click here to export grid data in excel." />
                                </td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <asp:Label ID="Label1" runat="server" Text="Lists all Raw material items (Ingredients), for which Menu Item they are needed and for which day and which session. 
                                         Helps in advance planning in procuring / stocking these items." Font-Names="Verdana" ForeColor="DarkGray" Font-Size="Small" Width="75%"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td  >
                                    <telerik:RadGrid ID="gvIngredients" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"
                                         OnItemCommand="gvIngredients_ItemCommand" Width="95%" AllowFilteringByColumn="true" ShowFooter="true" OnInit="gvIngredients_Init"  >
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <MasterTableView AllowFilteringByColumn="true">

                                                        <ColumnGroups>
                                                                <telerik:GridColumnGroup HeaderText="Diners" Name="Diners" HeaderStyle-HorizontalAlign="Center" >
                                                                </telerik:GridColumnGroup>
                                                                <telerik:GridColumnGroup HeaderText="Estimate" Name="Estimate" HeaderStyle-HorizontalAlign="Center" >
                                                                </telerik:GridColumnGroup>
                                                            </ColumnGroups>

                                            <Columns>
                                                
                                                <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Date" ReadOnly="true" AllowFiltering="false" ></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Session" DataField="Session" ReadOnly="true" AllowFiltering="true"  ></telerik:GridBoundColumn>
                                                
                                                <telerik:GridBoundColumn HeaderText="Menu" DataField="Menu" ReadOnly="true" AllowFiltering="true"   ></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Group" DataField="StockGroup" ReadOnly="true" AllowFiltering="true"   ></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Provision" DataField="Provision" ReadOnly="true" AllowFiltering="true"   ></telerik:GridBoundColumn>
                                                
                                                <telerik:GridBoundColumn HeaderText="Qty to issue" DataField="Qtytoissue" ReadOnly="true" AllowFiltering="false" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="right" ></telerik:GridBoundColumn>
                                                
                                                <telerik:GridBoundColumn HeaderText="UOM" Visible="true" DataField="UOM" ReadOnly="true" AllowFiltering="false"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Booked" DataField="TotalBooking" ReadOnly="true" AllowFiltering="false"   HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ></telerik:GridBoundColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="Qty" Visible="true" DataField="TotalQty" ReadOnly="true" AllowFiltering="false"   HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="right"></telerik:GridBoundColumn>--%>
                                                
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                             <tr>
                                <td align="left">
                                    <asp:Label ID="Label2" runat="server" Text="Note: The estimates are approximate and actual quantities required may vary depending on several on the ground factors." Font-Names="Verdana" ForeColor="DarkGray" Font-Size="Small"></asp:Label>
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

