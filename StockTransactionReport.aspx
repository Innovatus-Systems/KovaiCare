<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockTransactionReport.aspx.cs" Inherits="StockTransactionReport" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>


                    <div style="width: 98%;">

                        <table>
                            <tr>
                                <td></td>
                            </tr>
                        </table>
                        <table style="width: 100%">
                            <tr>
                                <td align="center">
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%">

                            <tr>

                                <td>
                                    <asp:Label ID="lblfordate" runat="Server" Text="From Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    <telerik:RadDatePicker ID="dtpfordate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="170px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date from which you wish to view the transaction details of selected resident." AutoPostBack="true">
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
                                    <asp:Label ID="lbluntildate" runat="Server" Text="To Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                    <telerik:RadDatePicker ID="dtpuntildate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="170px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date till which you wish to view the transaction details of selected resident." AutoPostBack="true">
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
                                    <asp:Label ID="Label3" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    <asp:DropDownList ID="ddlGroup" runat="server" ToolTip="Select the transaction type" Height="23px" Width="150px">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="Server" Text="Type" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    <asp:DropDownList ID="ddlTransactionType" runat="server" ToolTip="Select the transaction type" Height="23px" Width="150px">
                                    </asp:DropDownList>
                                </td>                           

                                <td align="right">

                                    <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the transaction details within the selected date range." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                                    <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export the stock transactions in excel." />

                                </td>

                            </tr>



                        </table>
                        <table style="width: 100%">
                             <tr>
                                 <td>
                                    <asp:Label ID="Label5" runat="Server" Text="Transaction ledger:" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                    
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label4" runat="Server" Text="* Scroll down to see the summary for the selected period" ForeColor="Green" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    
                                </td>
                                
                            </tr>
                            <tr>

                                <td style="width: 90%; height: 185px; vertical-align: top;" colspan="2">
                                    <telerik:RadGrid ID="ReportList" runat="server" AllowPaging="false" AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                        Width="90%"
                                        MasterTableView-HierarchyDefaultExpanded="true" OnInit="ReportList_Init">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
                                        <MasterTableView AllowCustomPaging="false" AllowFilteringByColumn="true">
                                            <NoRecordsTemplate>
                                                No Transactions Found.
                                            </NoRecordsTemplate>
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>

                                                <telerik:GridBoundColumn HeaderText="RefNo" DataField="RefNo" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" FilterControlWidth="50%"
                                                    HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Wrap="false" Visible="true"
                                                    ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" AllowFiltering="true" FilterControlWidth="50%" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="false"></HeaderStyle>
                                                    <ItemStyle Wrap="false"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Group" DataField="Group" HeaderStyle-Wrap="false" Visible="true"
                                                    ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" FilterControlWidth="50%" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ItemCode" DataField="ItemCode" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ItemName" DataField="ItemName" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" DataField="Type" HeaderStyle-Wrap="false" ItemStyle-Width="10%"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="true"></ItemStyle>
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Qty" DataField="Qty" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="UOM" DataField="UOM" HeaderStyle-Wrap="false" ItemStyle-Width="10%"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Rate" DataField="Rate" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Value" DataField="purchaseprice" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ClosingStock" DataField="ClosingStock" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ForDate" DataField="ForDate" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ForSession" DataField="ForSession" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ForItem" DataField="ForItem" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
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
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="Server" Text="Summary:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                    
                                </td>
                                <td align="right">
                                    <asp:Button ID="BtnExcelExportSummary" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExportSummary_Click" ForeColor="White" ToolTip="Click here to export the transaction summary in excel." />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 90%; height: 185px; vertical-align: top;" colspan="2">
                                    <telerik:RadGrid ID="ReportSummary" runat="server" AllowPaging="false" AutoPostBack="true" OnItemCommand="ReportSummary_ItemCommand"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                        Width="90%"
                                        MasterTableView-HierarchyDefaultExpanded="true" OnInit="ReportList_Init">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
                                        <MasterTableView AllowCustomPaging="false" AllowFilteringByColumn="true">
                                            <NoRecordsTemplate>
                                                No Transactions Found.
                                            </NoRecordsTemplate>
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                
                                                <telerik:GridBoundColumn HeaderText="Group" DataField="Group" HeaderStyle-Wrap="false" Visible="true"
                                                    ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" FilterControlWidth="50%" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ItemCode" DataField="ItemCode" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ItemName" DataField="ItemName" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" DataField="Type" HeaderStyle-Wrap="false" ItemStyle-Width="10%"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="true"></ItemStyle>
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Qty" DataField="Qty" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Right"
                                                    HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="10%"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="UOM" DataField="UOM" HeaderStyle-Wrap="false" ItemStyle-Width="10%"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" FilterControlWidth="50%"
                                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>                                                                                                                                             
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


                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="BtnnExcelExport" />
                    <asp:PostBackTrigger ControlID="BtnExcelExportSummary" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>

</asp:Content>
