<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ResidentTxnSummary.aspx.cs" Inherits="ResidentTxnSummary" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">


        function NavigateDir() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (350 + 50);
            iMyHeight = (window.screen.height / 2) - (125 + 25);
            var Y = 'BPTransSummary.aspx?SRSN=' + document.getElementById('<%= hdnSRTRSN.ClientID %>').value;
            //var Y = 'BPTransSummary.aspx';
            var win = window.open(Y, "", "status=no,height=300,width=800,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");

            win.focus();
        }

    </script>
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 99%;">
                <table>
                    <tr>
                        <td>
                            <asp:Panel ID="pnlThird" runat="server" BackColor="White" Visible="true" Height="450px">

                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnRetBillRec" runat="server" Text="Return" CssClass="btn btn-info" Visible="false"
                                                OnClick="btnRetBillRec_Click" ToolTip="Click here to return Billing & Receipts" />
                                            <asp:Button ID="btnRetReport" runat="server" Text="Return" CssClass="btn btn-info" Visible="false"
                                                OnClick="btnRetReport_Click" ToolTip="Click here to return Reports" />
                                        </td>
                                        <td style="width: 600px">
                                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                            &nbsp; &nbsp;&nbsp;
                                             <asp:Label ID="lblCurrBillPeriod" Visible="true" Font-Bold="false" Font-Names="Calibri" ForeColor="lightGray" Font-Size="Medium" runat="server" />
                                            &nbsp; &nbsp;&nbsp;
                                             <asp:Label ID="lblBilledPeriod" Visible="true" Font-Bold="false" Font-Names="Calibri" ForeColor="lightGray" Font-Size="Medium" runat="server" />
                                            <asp:HiddenField ID="hdnSRTRSN" runat="server" />
                                        </td>
                                    </tr>
                                    <tr style="background-color: white; border-bottom-color: white; border-top-color: white; border-left-color: white; border-right-color: white; border-style: inset">
                                        <td>&nbsp; &nbsp;&nbsp;                                            
                                            <asp:LinkButton ID="lnkShowDet" runat="server" Text="More >>>" Font-Names="Calibri" ForeColor="Gray" Font-Size="Medium" Font-Underline="false" OnClick="lnkShowDet_Click"></asp:LinkButton>
                                        </td>

                                        <td style="width: 370px"></td>
                                        <td>
                                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="btnExpProject_Click" ForeColor="White" ToolTip="Click here to export grid data in excel." />
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text="One line summary per resident per billing period.  The latest billed period is shown by default. Click More >> to view for all billing periods." ForeColor="Gray" Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td style="width: 1300px">
                                            <telerik:RadGrid ID="rdgTxnSummary" runat="server" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true" PageSize="10" AutoGenerateColumns="False" CssClass="table table-bordered table-hover" 
                                                Height="320px" OnItemCommand="rdgTxnSummary_ItemCommand" 
                                                OnItemDataBound="rdgTxnSummary_ItemDataBound" Width="1200px" OnInit="rdgTxnSummary_Init">
                                                <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
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
                                                        <telerik:GridBoundColumn DataField="RSN" HeaderStyle-HorizontalAlign="Left" HeaderText="RSN" ItemStyle-HorizontalAlign="Left" UniqueName="RSN" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Left" Width="0px" />
                                                            <ItemStyle HorizontalAlign="Left" Width="0px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="RTRSN" HeaderStyle-HorizontalAlign="Left" HeaderText="RTRSN" ItemStyle-HorizontalAlign="Left" UniqueName="RTRSN" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Left" Width="0px" />
                                                            <ItemStyle HorizontalAlign="Left" Width="0px" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn AllowFiltering="true" SortExpression="BillPeriod" DataField="BillPeriod" HeaderStyle-HorizontalAlign="Left" HeaderText="Period" ItemStyle-HorizontalAlign="Left" UniqueName="TemplateColumn2" Visible="True">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lblBillPeriod" runat="server" CausesValidation="false" CssClass="TextBox" Font-Underline="true" ForeColor="#00008B" OnClick="lbBillPeriod_Click" Text='<%# Eval("BillPeriod")%>' ToolTip="Click here to view monthly bill payment in detail">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn DataField="VillaNo" HeaderStyle-HorizontalAlign="Left" HeaderText="Villa No." ItemStyle-HorizontalAlign="Left" UniqueName="VillaNo" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign="Left" Wrap="False" />
                                                            <FooterStyle HorizontalAlign="Left" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Status" HeaderStyle-HorizontalAlign="Left" HeaderText="Status" ItemStyle-HorizontalAlign="Left" UniqueName="Status" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                                            <ItemStyle HorizontalAlign="Left" Wrap="False" />
                                                            <FooterStyle HorizontalAlign="Left" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" DataField="Name" SortExpression="Name" HeaderText="Name" ItemStyle-HorizontalAlign="Left" UniqueName="TemplateColumn1" Visible="True">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lblEdit" runat="server" CausesValidation="false" CssClass="TextBox" Font-Underline="true" ForeColor="#00008B" OnClick="lbtnName_Click" Text='<%# Eval("Name")%>' ToolTip="Click here to view profile">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                            <FooterStyle HorizontalAlign="Left" />
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn DataField="LastMonthCO" HeaderStyle-HorizontalAlign="Right" HeaderText="Previous Balance" HeaderTooltip="Shows the amount remaining unpaid at the end of the previous billing period and carried forward to the next period." ItemStyle-HorizontalAlign="Right" UniqueName="LastMonthCO" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                            <FooterStyle HorizontalAlign="Right" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="BPAmount" HeaderStyle-HorizontalAlign="Right" HeaderText="Billed" HeaderTooltip="Shows the amount billed for the biling period." ItemStyle-HorizontalAlign="Right" UniqueName="BPAmount" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                            <FooterStyle HorizontalAlign="Right" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="TotOutstand" HeaderStyle-HorizontalAlign="Right" HeaderText="Outstanding" HeaderTooltip="Shows the sum of 'Carried forward outstanding and the amount billed for the period'" ItemStyle-HorizontalAlign="Right" UniqueName="TotOutstand" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                            <FooterStyle HorizontalAlign="Right" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="AmtRecd" HeaderStyle-HorizontalAlign="Right" HeaderText="Received" HeaderTooltip="Shows the amount received against the monthly statement. Any outstanding is carried forward." ItemStyle-HorizontalAlign="Right" UniqueName="AmtRecd" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                            <FooterStyle HorizontalAlign="Right" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Outstanding" HeaderStyle-HorizontalAlign="Right" HeaderText="Balance" HeaderTooltip="Final Outstanding Amount" ItemStyle-HorizontalAlign="Right" UniqueName="Outstanding" Visible="true">
                                                            <HeaderStyle HorizontalAlign="Right" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="RecDate" HeaderStyle-HorizontalAlign="Center" HeaderText="Received Date" HeaderTooltip="Last Received Date" ItemStyle-HorizontalAlign="Center" UniqueName="RecDate" Visible="false">
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" />
                                                            <FooterStyle HorizontalAlign="Center" />
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" SaveScrollPosition="True" />
                                                </ClientSettings>
                                            </telerik:RadGrid>
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

