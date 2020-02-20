<%@ Page Title="" Language="C#" MasterPageFile="~/Mstrpg1.master" AutoEventWireup="true" CodeFile="PaymentHistory.aspx.cs" Inherits="PaymentHistory" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/PayStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <div class="divHead" align="center">
        <p style="color: #ffffff;">Recharge History</p>
    </div>
    <div class="divBtns" align="right">
        <asp:Button ID="BtnHome" runat="server" Text="Home" CssClass="btn" ToolTip="Click here to return to Home Page" OnClick="BtnHome_Click" />
        <asp:Button ID="BtnPayDetails" runat="server" Text="Recharge" CssClass="btn" ToolTip="Click here to make your recharge" OnClick="BtnPayDetails_Click" />
        <asp:Button ID="BtnHistory" runat="server" Text="History" CssClass="btn" ToolTip="Click here to view the recharge history" OnClick="BtnHistory_Click"/>
        <asp:Button ID="BtnStatement" runat="server" Text="Statement" CssClass="btn" ToolTip="Click here to view the recharge Statement" OnClick="BtnStatement_Click"/>
    </div>
    <div>
        <%--<asp:Label ID="Label3" runat="server" Text="Shows recharge histories "
                                Font-Names="Verdana" Font-Size="8" Font-Bold="false" ForeColor="DarkBlue"></asp:Label><br />--%>
            <table style="width: 100%; table-layout: fixed;font-family:Verdana; font-size:12px;">
                <tr>
                    <td>
                        <table style="width: 65%;">
                            <tr style="color: darkblue;">
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text="From Date"></asp:Label>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="TxtFrmDate" CssClass="txtBox" runat="server"  width="130px" ToolTip="Select the from date" PlaceHolder="From Date"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:ImageButton ID="ImgBtnCal" Width="30px" Height="30px" runat="server" ImageUrl="~/Images/calendar.png" />
                                            </td>
                                            <td>
                                                <asp:CalendarExtender ID="cal1" runat="server" format="dd-MMM-yyyy ddd" TargetControlID="TxtFrmDate" PopupButtonID="ImgBtnCal"></asp:CalendarExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="server" Text="Till Date"></asp:Label>
                                </td>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="TxtToDate" runat="server" CssClass="txtBox"  width="130px" ToolTip="Select the till date" PlaceHolder="Till Date"></asp:TextBox></td>
                                            <td>
                                                <asp:ImageButton ID="ImgBtnCal1" Width="30px" Height="30px" runat="server" ImageUrl="~/Images/calendar.png" ToolTip="Click here for choose the date" /></td>
                                            <td>
                                                <asp:CalendarExtender ID="Cal2" runat="server" format="dd-MMM-yyyy ddd" TargetControlID="TxtToDate" PopupButtonID="ImgBtnCal1"></asp:CalendarExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td>
                                    <asp:Button ID="BtnView1" runat="server" Text="View" class="btn" OnClick="BtnView1_Click" ToolTip="Click here to view the amount transactions of CCC IDs" />
                                </td>
                                <td>
                                    <asp:ImageButton ID="BtnPrint" runat="server" ImageUrl="~/Images/excel-xls-icon1.png" ToolTip="Export to Excel"
                        OnClick="BtnPrint_Click" Height="25px" Width="100px" AlternateText="Export to Excel" style=" margin-top:5px;" />
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
                                            Font-Names="Verdana" Font-Size="Small">
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
                                                    <telerik:GridBoundColumn HeaderText="Amount(Rs)" DataField="Amount" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                        ItemStyle-Wrap="false">
                                                        <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Service Tax(Rs)" DataField="ServiceTax" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                        ItemStyle-Wrap="false" HeaderStyle-Wrap="false">
                                                        <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="SBCess(Rs)" DataField="SBCess" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
                                                        ItemStyle-Wrap="false">
                                                        <ItemStyle ForeColor="darkBlue" Font-Names="Verdana" Font-Size="8" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Final Amount(Rs)" DataField="FinalAmount" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"
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
                                                        ItemStyle-Wrap="false">
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
    </div>
</asp:Content>

