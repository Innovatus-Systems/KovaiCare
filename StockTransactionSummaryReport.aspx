<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockTransactionSummaryReport.aspx.cs" Inherits="StockTransactionSummaryReport"  MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />

       <script type="text/javascript" src="https://www.google.com/jsapi"></script>

     <style type="text/css">

    .RadGrid th.rgHeader
    {
        background-image: none;
        background-color: #196F3D;
        color:white;
        font-weight:bold;
    }
   
    div.RadGridCustomClass  .rgFooter  td  
{  
    border-radius:25px; 
}

</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




     <div class="main_cnt">
        <div class="first_cnt">

              <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>


            <div style="width: 100%;">
               
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
                        <td>
                             <telerik:RadWindow ID="rwItemDetails" Width="450" Height="425px" VisibleOnPageLoad="false" runat="server"  Title="Item Details" Modal="true">
                                        <ContentTemplate>

                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>

                                                    <div>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label1" runat="Server" Text="Item Code:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblitemcode" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label4" runat="Server" Text="ItemName:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblitemname" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label5" runat="Server" Text="Group:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblGroup" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label9" runat="Server" Text="Category:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblCategory" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label11" runat="Server" Text="Reorder Level:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblreorderlevel" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>

                                                           

                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label16" runat="Server" Text="Supplier:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                     <asp:Label ID="lblsupplier" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>

                                                             <tr>
                                                                <td>
                                                                    <asp:Label ID="Label2" runat="Server" Text="Remarks:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                     <asp:Label ID="lblRemarks" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>


                                                            
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Button ID="btnClose"  ToolTip="Click here to close the item details" OnClick="btnClose_Click" runat="server" Text="Close" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnClose" />
                                                </Triggers>
                                            </asp:UpdatePanel>

                                        </ContentTemplate>
                                    </telerik:RadWindow>
                        </td>
                        <td>
                            <telerik:RadWindow ID="rwLatestTransaction" Width="450" Height="425px" VisibleOnPageLoad="false" runat="server"  Title="Latest Transaction" Modal="true">
                                        <ContentTemplate>

                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>

                                                    <div>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label6" runat="Server" Text="Item Code:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLItemCode" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label8" runat="Server" Text="ItemName:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLItemName" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label12" runat="Server" Text="Total Qty:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLQty" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label14" runat="Server" Text="Date:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLDate" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label17" runat="Server" Text="Transaction Type:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblLTransactionType" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Button ID="btnLClose"  ToolTip="Click here to close the item details" OnClick="btnLClose_Click" runat="server" Text="Close" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnLClose" />
                                                </Triggers>
                                            </asp:UpdatePanel>

                                        </ContentTemplate>
                                    </telerik:RadWindow>
                        </td>
                    </tr>
                </table>


                <table style="width:100%">
                    <tr>
                        <td style="width: 100%;padding-left:10px;font-size:small;font-family:Verdana;">
                            <asp:Label ID="Label7" runat="server" Text="Value of stock in each group as of"></asp:Label>&nbsp;<asp:Label ID="lbltitledate" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                        <td style="width: 50%;vertical-align:top">

                             <telerik:RadGrid ID="rgGroupwiseTotal" runat="server" AllowPaging="false" CssClass="RadGridCustomClass"  AutoPostBack="true"
                                AutoGenerateColumns="False"  AllowSorting="True" ShowFooter="true"
                                Width="350px" Height="180px"
                                MasterTableView-HierarchyDefaultExpanded="true" OnInit="ReportList_Init" >
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" FrozenColumnsCount="3" />
                                </ClientSettings>
                                <HeaderContextMenu CssClass="table table-bordered table-hover">
                                </HeaderContextMenu>
                                <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
                                <MasterTableView AllowCustomPaging="false" AllowFilteringByColumn="false" TableLayout="Fixed">
                                    <NoRecordsTemplate>
                                        No Transactions Found.
                                    </NoRecordsTemplate>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>                                   
                                    <Columns>
                                         <telerik:GridBoundColumn DataField="StockGroup" HeaderText="Group" UniqueName="StockGroup" ItemStyle-Width="100px" HeaderStyle-Width="100px"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" HeaderStyle-ForeColor="White" ItemStyle-HorizontalAlign="Left"  FooterStyle-HorizontalAlign="Right" HeaderTooltip="Kitchen provisions are grouped depending on their nature.">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                       
                                         <telerik:GridBoundColumn DataField="ClosingValue" HeaderText="Value in Rs." HeaderStyle-ForeColor="White" FooterStyle-Font-Bold="true" HeaderTooltip="Sum of value of all items in a group.  Item vale is calculated as Stock qty available for an item * average rate of that item." UniqueName="ClosingValue" ItemStyle-Width="100px" HeaderStyle-Width="100px"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterText="Total:" FooterStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                          <telerik:GridBoundColumn DataField="NoofItems" HeaderText="Items" HeaderStyle-ForeColor="White" UniqueName="NoofItems" HeaderTooltip="Number of provisions items included in each group." ItemStyle-Width="70px" HeaderStyle-Width="70px"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"  FooterStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
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
                          <td style="width: 50%;">
                    <asp:Literal ID="ltrscr" runat="server"></asp:Literal>
                    <div id="chart_div" style="width: 600px; height: 250px;">
                    </div>
                </td>
                    </tr>




                </table>

                <table style="width:100%">

                    <tr>

                        <td>
                            <asp:Label ID="lblfordate" runat="Server" Text="As of Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <telerik:RadDatePicker ID="dtpfordate" runat="server" Enabled="false" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="170px" CssClass="TextBox" ReadOnly="true" ToolTip="By default it is today.But you can choose a past date also." AutoPostBack="true">
                               <%-- <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Enabled="false" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>--%>
                               <%-- <DatePopupButton></DatePopupButton>--%>
                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy"  Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>
                             <asp:Label ID="Label3" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                             <asp:DropDownList ID="ddlGroup" runat="server" ToolTip="Kitchen items are grouped according to their nature. Select one of the groups here." Height="23px" Width="150px"  >
                                                  
                             </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;
                              <asp:CheckBox ID="chkshowall" runat="server"  ToolTip="By default only those items which have some movement or have some stock - are displayed.click to include items that have zero movement and zero stock also." />Show all
                      &nbsp;&nbsp;&nbsp;<asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the stock summary details for selected date" AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />

                        </td>
                        
                       <%-- <td>
                            
                        </td>
                        <td>
                              </td>--%>
                       <%-- <td>
                             <asp:Label ID="Label2" runat="Server" Text="Category" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:DropDownList ID="ddlCategory" ToolTip="HL-High Value,NV-Normal Value,LV-Low Value" Width="150px" Height="25px" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small">
                                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                                    <asp:ListItem Text="High Value" Value="High Value"></asp:ListItem>
                                                    <asp:ListItem Text="Average Value" Value="Average Value"></asp:ListItem>
                                                    <asp:ListItem Text="Low Value" Value="Low Value"></asp:ListItem>
                                                </asp:DropDownList>
                        </td>--%>


                       <%-- <td>

                           
                        </td>--%>

                    </tr>

                    <tr>
                        <td colspan="4" >
                            <telerik:RadGrid ID="ReportList" runat="server" AllowPaging="false"  AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
                                AutoGenerateColumns="False"  AllowSorting="True" ShowFooter="true"
                                Width="99%"
                                MasterTableView-HierarchyDefaultExpanded="true" OnInit="ReportList_Init" OnItemDataBound="ReportList_ItemDataBound" >
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" FrozenColumnsCount="3" />
                                </ClientSettings>
                                <HeaderContextMenu CssClass="table table-bordered table-hover">
                                </HeaderContextMenu>
                                <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
                                <MasterTableView AllowCustomPaging="false" AllowFilteringByColumn="true" TableLayout="Fixed">
                                    <NoRecordsTemplate>
                                        No Transactions Found.
                                    </NoRecordsTemplate>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                   
                                    <Columns>

                                        <telerik:GridTemplateColumn HeaderText="Group" ItemStyle-HorizontalAlign="Left" AllowFiltering="true"  DataField="StockGroup" HeaderStyle-HorizontalAlign="Left" Visible="true"  ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkGroup" runat="server" Text='<%# Eval("StockGroup") %>' CommandArgument='<%# Eval("RMCode") %>' ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="ItemName" ItemStyle-HorizontalAlign="Left" AllowFiltering="true" DataField="ItemName" HeaderTooltip="Show in red if stock is below reorder level." HeaderStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="15%" FilterControlWidth="50%" HeaderStyle-Width="15%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkItemName" runat="server" Text='<%# Eval("ItemName") %>' CommandArgument='<%# Eval("RMCode") %>' CommandName="ViewDetails" ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                          <telerik:GridTemplateColumn HeaderText="UOM" ItemStyle-HorizontalAlign="center" AllowFiltering="true" DataField="UOM" HeaderStyle-HorizontalAlign="center" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkuom" runat="server" Text='<%# Eval("UOM") %>' CommandArgument='<%# Eval("RMCode") %>' ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        
                                         <telerik:GridTemplateColumn HeaderText="Op.Bal.Qty" ItemStyle-HorizontalAlign="center" AllowFiltering="true" DataField="OpeningBalance" UniqueName="OpBalQty" HeaderStyle-HorizontalAlign="center" Visible="true" 
                                              ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="Opening balance">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkOpeningBalance" runat="server" Text='<%# Eval("OpeningBalance") %>' CommandArgument='<%# Eval("RMCode") %>' ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                         <telerik:GridTemplateColumn HeaderText="Avg.Rate" ItemStyle-HorizontalAlign="center" AllowFiltering="true" DataField="Rate" HeaderStyle-HorizontalAlign="center" Visible="true" 
                                              ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="Calculated Average Rate">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkAvgRate" runat="server" Text='<%# Eval("Rate") %>' CommandArgument='<%# Eval("RMCode") %>' ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                       
                                         <telerik:GridTemplateColumn HeaderText="Value Rs" ItemStyle-HorizontalAlign="center" AllowFiltering="true" DataField="Amount"  HeaderStyle-HorizontalAlign="center" Visible="true" 
                                              ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="(Averagerate*OpeningBalance)">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkopeningvalue" runat="server" Text='<%# Eval("Amount") %>' CommandArgument='<%# Eval("RMCode") %>' ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="Receipt" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="StockReceipt" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" 
                                            FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="Total receipts for the day.">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkReceipt" runat="server" Text='<%# Eval("StockReceipt") %>' CommandArgument='<%# Eval("RMCode") %>' CommandName="Receipt"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                         <telerik:GridTemplateColumn HeaderText="Rate" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="PurchaseRate" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" 
                                            FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="Total amount spent/Total qty for the day">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkPurchaseRate" runat="server" Text='<%# Eval("PurchaseRate") %>' CommandArgument='<%# Eval("RMCode") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                         <telerik:GridTemplateColumn HeaderText="Value Rs" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="PurchaseAmount" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" 
                                            FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="(PurchaseRate * Receipts)">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkPurchaseAmount" runat="server" Text='<%# Eval("PurchaseAmount") %>' CommandArgument='<%# Eval("RMCode") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                         <telerik:GridTemplateColumn HeaderText="Issue" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="StockIssue" HeaderStyle-HorizontalAlign="right" Visible="true" 
                                             ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="Total issues for the day" >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkIssue" runat="server" Text='<%# Eval("StockIssue") %>' CommandArgument='<%# Eval("RMCode") %>' CommandName="Issue"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                         <telerik:GridTemplateColumn HeaderText="Value Rs" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="StockIssueValue" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" 
                                            FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="(AverageRate * Issue)">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkIssueAmount" runat="server" Text='<%# Eval("StockIssueValue") %>' CommandArgument='<%# Eval("RMCode") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>



                                         <telerik:GridTemplateColumn HeaderText="Returns" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="StockReturn" HeaderStyle-HorizontalAlign="right" Visible="true" 
                                             ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="Total  returns to stores." >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkReturns" runat="server" Text='<%# Eval("StockReturn") %>' CommandArgument='<%# Eval("RMCode") %>' CommandName="Return"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                         <telerik:GridTemplateColumn HeaderText="Adj.plus" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="Adjustmentplus" HeaderStyle-HorizontalAlign="right" Visible="true" 
                                             ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="Adjustment added to stock" >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkAdjPlus" runat="server" Text='<%# Eval("Adjustmentplus") %>' CommandArgument='<%# Eval("RMCode") %>' CommandName="Adjustmentplus"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                         <telerik:GridTemplateColumn HeaderText="Adj.minus" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="Adjustmentminus" HeaderStyle-HorizontalAlign="right" Visible="true" 
                                             ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="Adjustment added to stock" >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkAdjMinus" runat="server" Text='<%# Eval("Adjustmentminus") %>' CommandArgument='<%# Eval("RMCode") %>' CommandName="Adjustmentminus"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                         <telerik:GridTemplateColumn HeaderText="Cl.Bal.Qty" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="ClosingBalance" HeaderStyle-HorizontalAlign="right" Visible="true" 
                                             ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="Closing Balance Qty=(Op.Bal + Receipts - issues + Returns + Adj.Plus - Adj.Minus)" >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkClosingBalance" runat="server" Text='<%# Eval("ClosingBalance") %>' CommandArgument='<%# Eval("RMCode") %>' ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>
   
                                        <telerik:GridTemplateColumn HeaderText="Value Rs" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="CloBalValue" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-ForeColor="DarkBlue"
                                             ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="(Averagerate*ClosingBalance)"  >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkClosingBalanceval" runat="server" Text='<%# Eval("CloBalValue") %>' CommandArgument='<%# Eval("RMCode") %>' ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="RMCode" ItemStyle-HorizontalAlign="right" AllowFiltering="true" DataField="RMCode" HeaderStyle-HorizontalAlign="right" Visible="true" 
                                             ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" HeaderTooltip="(Averagerate*ClosingBalance)"  Display="false" >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkrmcode" runat="server" Text='<%# Eval("RMCode") %>' CommandArgument='<%# Eval("RMCode") %>' ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                       
                                      

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
                          <asp:PostBackTrigger ControlID="BtnShow" />
                       </Triggers>
            </asp:UpdatePanel>

             <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">
             <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

        </div>
    </div>

</asp:Content>
