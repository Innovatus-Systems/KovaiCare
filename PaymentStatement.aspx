<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="PaymentStatement.aspx.cs" Inherits="PaymentStatement" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/PayStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>--%>
    <div class="divHead" align="center">
        <p style="color: #ffffff;">Recharge History</p>
    </div>
    <div class="divBtns" align="right">
        <asp:Button ID="BtnHome" runat="server" Text="Home" CssClass="btn" ToolTip="Click here to return to you Home page" OnClick="BtnHome_Click" />
        <asp:Button ID="BtnPayDetails" runat="server" Text="Recharge" CssClass="btn" ToolTip="Click here to make your recharge" OnClick="BtnPayDetails_Click" />
        <asp:Button ID="BtnHistory" runat="server" Text="History" CssClass="btn" ToolTip="Click here to view the recharge history" OnClick="BtnHistory_Click" Visible="False" />
        <asp:Button ID="BtnStatement" runat="server" Text="History" CssClass="btn" ToolTip="Click here to view the recharge Statement" OnClick="BtnStatement_Click" />
    </div>
    <asp:Panel ID="pnlsam" runat="server">
    <div>
        <%--<asp:Label ID="Label3" runat="server" Text="Shows recharge histories "
                                Font-Names="Verdana" Font-Size="8" Font-Bold="false" ForeColor="DarkBlue"></asp:Label><br />--%>
        <table style="width: 100%; table-layout: fixed; font-family: Verdana; font-size: 12px;">
            <tr>
                <td>
                    <table>
                        <tr style="color: darkblue;">
                            <td>
                                <asp:Label ID="Label1" runat="server" Visible="false" Text="Month"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlmonth" runat="server" Visible="false" CssClass="txtBox" Width="150px" OnSelectedIndexChanged="ddlmonth_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </td>
                            <td>
                                <asp:ImageButton ID="BtnPrint" runat="server" ImageUrl="~/Images/excel-xls-icon1.png" ToolTip="Export to Excel"
                                    OnClick="BtnPrint_Click" Height="25px" Width="100px" AlternateText="Export to Excel" Style="margin-top: 5px;" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                        <ContentTemplate>
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always">
                                <ContentTemplate>
                                    <telerik:RadGrid ID="rdgTxns" runat="server" AllowSorting="true" AllowFilteringByColumn="true"
                                        AllowPaging="True" AutoGenerateColumns="False" GridLines="Both" Skin="Vista"
                                        OnPageIndexChanged="rdgTxns_PageIndexChanged" AlternatingItemStyle-BackColor="Beige"
                                        OnPageSizeChanged="rdgTxns_PageSizeChanged" PageSize="10"
                                        SelectedItemStyle-BackColor="#99ccff"
                                        OnItemCommand="rdgTxns_ItemCommand"
                                        Font-Names="Verdana" Font-Size="Small" OnGridExporting="rdgTxns_GridExporting" >
                                        <HeaderContextMenu></HeaderContextMenu>
                                        <HeaderStyle Font-Names="Verdana" Font-Size="9" Font-Bold="false" ForeColor="darkBlue" />
                                        <GroupingSettings CaseSensitive="false" />
                                        <FilterMenu EnableImageSprites="false" CssClass=""></FilterMenu>
                                        <FilterItemStyle HorizontalAlign="Center" CssClass="" />
                                        <PagerStyle AlwaysVisible="true" Font-Names="Verdana" Font-Size="Small" Font-Bold="true" ForeColor="darkBlue"
                                            Mode="Slider" HorizontalAlign="Center" />
                                        <MasterTableView>
                                            <NoRecordsTemplate>
                                                <span style="font-family: Verdana; font-size: small; background-color: yellow;">No Records Found.</span>
                                            </NoRecordsTemplate>
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Transaction ID" DataField="InvoiceNo" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                    <HeaderStyle Width="150px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Date" DataField="TxnDate" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Amount(Rs)" DataField="Amount" Display="false" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Debit(Rs)" DataField="Debit" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Credit(Rs)" DataField="Credit" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Balance(Rs)" DataField="Balance" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="RechargedBy" DataField="C_ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                                    ItemStyle-Wrap="false">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" DataField="Description" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                    ItemStyle-Wrap="true">
                                                    <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" FrozenColumnsCount="0" SaveScrollPosition="true" />
                                            <Selecting AllowRowSelect="True" />
                                        </ClientSettings>
                                        <FilterMenu EnableTheming="True">
                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                        </FilterMenu>
                                    </telerik:RadGrid>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="BtnTest2" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:Button ID="BtnTest2" runat="server" Visible="false" OnClick="BtnTest2_Click" />
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="BtnTests" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <asp:Button ID="BtnTests" runat="server" Visible="false" OnClick="BtnTest2_Click" />
                </td>
            </tr>
        </table>
        <table style="width: 100%;display:none">
            <tr>
                <td style="width:50%;vertical-align:top;">
                    <table align="left" cellpadding="5px" style="font-family: Verdana; font-size: 12px; width: 98%;">
                        <caption style="background-color: #0094ff; color: #ffffff; font-size: 13px; font-weight:800; padding: 5px;">
                            <asp:Label ID="LblBillHead" runat="server" Text="Recharge Details"></asp:Label></caption>
                         <tr>
                            <td>Invoice To
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblInvoiceTo" runat="server" Text="-"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Billing Address
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblBillingAddress" runat="server" Text="-"></asp:Label>
                            </td>
                        </tr>
                         <tr>
                             <td></td>
                         </tr>
                    </table>
                </td>
                <td style="width:50%; vertical-align:top;" >
                     
                    <table align="left" cellpadding="5px" style="font-family: Verdana; font-size: 12px; width: 98%;">
                        <caption style="background-color: #0094ff; color: #ffffff; font-size: 13px; font-weight:800; padding: 5px;">
                            <asp:Label ID="LblAmountHead" runat="server" Text="Amount and Tax Breakup"></asp:Label></caption>
                            
                        <tr>
                            <td width="40%">Opening Balance(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblOldBalance" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Total Amount(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblTotAmt" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Service Tax(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblServiceTax" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Swahh Bharat Cess(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblSBCess" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Net Amount(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblFinalAmt" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Debited Amount(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblDebitAmt" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Closing Balance(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblNewBalance" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <hr />
    </div>
        </asp:Panel>
   
</asp:Content>

