<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MonthlyBilling.aspx.cs" Inherits="MonthlyBilling" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">


        function NavigateDir() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (540 + 50);
            iMyHeight = (window.screen.height / 2) - (275 + 25);
            var Y = 'BillingSummaryHelp.aspx';
            var win = window.open(Y, "Construction Status - Block Level", "status=no,height=450,width=1150,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");

            win.focus();
        }
        function NavigateDir2() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (250 + 25);
            iMyHeight = (window.screen.height / 2) - (70 + 20);
            var Y = 'EditBPMessage.aspx?MsgRSN=' + document.getElementById('<%= hdnRSNMsg.ClientID %>').value;
            var win = window.open(Y, "Edit Billing Period Message", "status=no,height=180,width=550,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");

            win.focus();
        }



    </script>
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 99%;">
                <table>
                    <tr>
                        <td>
                            <asp:Panel ID="pnlThird" runat="server" BackColor="White" Visible="true" Height="550px">

                                <table>
                                    <tr>
                                        <td style="padding-left:30px">
                                            <asp:Button ID="btnRetBillRec" runat="server" Text="Return" CssClass="btn btn-info" Visible="false"
                                                OnClick="btnRetBillRec_Click" ToolTip="Click here to return Billing & Receipts" />
                                              <asp:Button ID="btnRetReport" runat="server" Text="Return" CssClass="btn btn-info" Visible="false"
                                                OnClick="btnRetReport_Click" ToolTip="Click here to return Reports" />
                                        </td>
                                        <td style="width: 600px;padding-left:400px">
                                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                            &nbsp; &nbsp;&nbsp;
                                             <asp:Label ID="lblCurrBillPeriod" Visible="true" Font-Bold="false" Font-Names="Calibri" ForeColor="lightGray" Font-Size="Medium" runat="server" />
                                            &nbsp; &nbsp;&nbsp;
                                             <asp:Label ID="lblBilledPeriod" Visible="true" Font-Bold="false" Font-Names="Calibri" ForeColor="lightGray" Font-Size="Medium" runat="server" />
                                        </td>
                                         <td style="padding-left:300px">
                                            <%--<asp:Button ID="btnGenMonthlyBill" runat="server" Text="Generate Monthly Bill" CssClass="btn btn-success" Font-Size="Small" Font-Names="Verdana" OnClick="btnGenMonthlyBill_Click" Enabled="false" />--%>
                                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="btnExpProject_Click" ForeColor="White" ToolTip="Click here to export grid data in excel." />
                                            &nbsp; &nbsp;
                                            <asp:LinkButton ID="lnkbtnHelp" runat="server" Text="Help" Font-Names="Calibri" ForeColor="Gray" Font-Size="Medium" Font-Underline="true" OnClick="lnkbtnHelp_Click"></asp:LinkButton>
                                            <asp:HiddenField ID="hdnRSNMsg" runat="server" />
                                        </td>
                                    </tr>
                                  <%--  <tr style="background-color: white; border-bottom-color: white; border-top-color: white; border-left-color: white; border-right-color: white; border-style: inset">

                                      


                                        <td style="width: 400px"></td>
                                       
                                    </tr>--%>
                                </table>

                                <table>
                                    <tr>
                                        <td style="width: 100%;padding-left:30px">

                                            <telerik:RadGrid 
                                                ID="rdgMonthBill" runat="server" AllowPaging="true" PageSize="12" AutoPostBack="true" OnItemCommand="rdgMonthBill_ItemCommand" 
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true" OnItemDataBound="rdgMonthBill_ItemDataBound"
                                CellSpacing="5" Width="98%"
                                MasterTableView-HierarchyDefaultExpanded="true">
                                                
                                                <%--ID="rdgMonthBill" runat="server" AllowFilteringByColumn="false" AllowSorting="true" AutoGenerateColumns="False" CssClass="table table-bordered table-hover" AllowPaging="true" PageSize="12" Height="320px"  Width="100%" >--%>
                                                 <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                </HeaderContextMenu>
                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                </HeaderContextMenu>
                                                <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                <ClientSettings>
                                                    <Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
                                                    <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                </ClientSettings>
                                                <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                    <PagerStyle Mode="NumericPages" />
                                                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                                                    <RowIndicatorColumn>
                                                        <HeaderStyle Width="20px" />
                                                    </RowIndicatorColumn>
                                                    <ExpandCollapseColumn>
                                                        <HeaderStyle Width="20px" />
                                                    </ExpandCollapseColumn>
                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="RSN" HeaderStyle-HorizontalAlign="Left" HeaderText="" ItemStyle-HorizontalAlign="Left" UniqueName="RSN" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Left" Width="0px" />
                                                            <ItemStyle HorizontalAlign="Left" Width="0px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn AllowFiltering="true" DataField="BPName"  HeaderText="Month" UniqueName="TemplateColumn1" Visible="True" SortExpression="BPName">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lblEdit" runat="server" CausesValidation="false" CssClass="TextBox" Font-Underline="true" ForeColor="#00008B" OnClick="lbtnName_Click" Text='<%# Eval("BPName")%>' ToolTip="Click here to view monthly billing per resident.">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <%-- <telerik:GridBoundColumn DataField="BPFromDT" HeaderText="From" UniqueName="BPFromDT"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" >
                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" ></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="BPTill" HeaderText="Till" UniqueName="BPTill"
                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                            <ItemStyle HorizontalAlign="Center" ></ItemStyle>
                                                        </telerik:GridBoundColumn>                      --%>
                                                        <telerik:GridBoundColumn DataField="BStatus" HeaderStyle-HorizontalAlign="Left" HeaderText="Status" ItemStyle-HorizontalAlign="Left" UniqueName="BStatus" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Left" />
                                                            <ItemStyle HorizontalAlign="Left" Width="100px" />
                                                             <HeaderStyle Wrap="False"></HeaderStyle>
                                                             <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="BDate" HeaderStyle-HorizontalAlign="Center" HeaderText="Billed On" ItemStyle-HorizontalAlign="Center" UniqueName="BDate" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" />
                                                             <HeaderStyle Wrap="False"></HeaderStyle>
                                                         <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="NoPeopleBilled" HeaderStyle-HorizontalAlign="Center" HeaderText="Count" ItemStyle-HorizontalAlign="Center" UniqueName="NoPeopleBilled" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" />
                                                             <HeaderStyle Wrap="False"></HeaderStyle>
                                                           <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="AmountCarriedOver" HeaderStyle-HorizontalAlign="Right" HeaderText="Previous Balance" HeaderTooltip="Amount Carried Forward" ItemStyle-HorizontalAlign="Right" UniqueName="AmountCarriedOver" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                             <HeaderStyle Wrap="False"></HeaderStyle>
                                                             <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="BAmount" HeaderStyle-HorizontalAlign="Right" HeaderText="Billed" HeaderTooltip="Amount Billed" ItemStyle-HorizontalAlign="Right" UniqueName="BAmount" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                             <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Outstanding" HeaderStyle-HorizontalAlign="Right" HeaderText="Outstanding" HeaderTooltip="Outstanding Amount" ItemStyle-HorizontalAlign="Right" UniqueName="Outstanding" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                             <HeaderStyle Wrap="False"></HeaderStyle>
                                                              <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="AmountReceived" HeaderStyle-HorizontalAlign="Right" HeaderText="Received" HeaderTooltip="Amount Received" ItemStyle-HorizontalAlign="Right" UniqueName="AmountReceived" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                              <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Balance" HeaderStyle-HorizontalAlign="Right" HeaderText="Balance" HeaderTooltip="Balance Amount" ItemStyle-HorizontalAlign="Right" UniqueName="Balance" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                             <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="LastDate" HeaderStyle-HorizontalAlign="Center" HeaderText="To Pay By" ItemStyle-HorizontalAlign="Center" UniqueName="LastDate" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" />
                                                             <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn AllowFiltering="true" DataField="BPSpecialMsg" SortExpression="BPSpecialMsg" HeaderText="Message" UniqueName="TemplateColumn2" Visible="True">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lblMsgEdit" runat="server" CausesValidation="false" CssClass="TextBox" Font-Underline="true" ForeColor="#00008B" OnClick="lbtnMessage_Click" Text='<%# Eval("BPSpecialMsg")%>' ToolTip="Click here to edit the message.">
                                                                </asp:LinkButton>
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















                                            <%--<telerik:RadGrid ID="rdgMonthBill" runat="server" AllowFilteringByColumn="false" AllowSorting="true" AutoGenerateColumns="False" CssClass="table table-bordered table-hover" AllowPaging="true" PageSize="12" Height="320px" OnItemDataBound="rdgMonthBill_ItemDataBound" Width="100%" OnItemCommand="rdgMonthBill_ItemCommand">
                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                </HeaderContextMenu>
                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                </HeaderContextMenu>
                                                <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                <ClientSettings>
                                                    <Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
                                                    <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                </ClientSettings>
                                                <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                    <PagerStyle Mode="NumericPages" />
                                                    <CommandItemSettings ExportToPdfText="Export to PDF" />
                                                    <RowIndicatorColumn>
                                                        <HeaderStyle Width="20px" />
                                                    </RowIndicatorColumn>
                                                    <ExpandCollapseColumn>
                                                        <HeaderStyle Width="20px" />
                                                    </ExpandCollapseColumn>
                                                    
                                                </MasterTableView>
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" />
                                                </ClientSettings>
                                            </telerik:RadGrid>--%>
                                        </td>
                                    </tr>

                                   
                                </table>
                                <table>
                                     <tr>
                                        <td style="padding-left:30px">
                                               <asp:Label ID="Label6" runat="server" Text="Shows one line summary for the entire community, per billing period.  Press HELP for more information." ForeColor="Gray" Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                        </td>
                                          <td style="padding-left:480px">                                          
                                            <asp:LinkButton ID="lnkShowDet" runat="server" Text="More >>>" ToolTip="Click to view 'Yet to Open' period also" Font-Names="Calibri" ForeColor="Gray" Font-Size="Medium" Font-Underline="false" OnClick="lnkShowDet_Click"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                                <%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
    </div>
</asp:Content>

