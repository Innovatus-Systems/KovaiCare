<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="CheckINOUT.aspx.cs" Inherits="CheckINOUT" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="width: 100%; min-height: 450px;">
                        <table style="width: 100%;">
                            <tr>
                                <td>
                                   <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                                <td style="width: 115px"></td>
                                <td>
                                    <asp:Label ID="LblOutCount" runat="server" Autopostback="true" ForeColor="Blue" Visible="true" Font-Names="verdana" Font-Bold="true" Font-Size="Small" />
                                </td>
                                <td style="width: 50px"></td>
                                <td>
                                    <asp:Label ID="lblCOTime" runat="server" BackColor="Yellow" Autopostback="true" ForeColor="Blue" Visible="true" Font-Names="verdana" Font-Bold="true" Font-Size="Small" ToolTip="Shows the number of resident(s) who have checked out more than 4 hours." />
                                </td>
                            </tr>
                        </table>
                        <table style="width: 65%;">
                            <tr>
                                <td>
                                    <asp:Label ID="Label4" runat="server" ForeColor="Blue" Font-Names="verdana" Font-Size="Small" Text="By Name :" />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlName" Width="220px" ToolTip="Select the Resident Name (Owner Resident / Tenant)" runat="server"
                                        Font-Names="Verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlName_SelectedIndexChanged" Font-Size="Small">
                                        <asp:ListItem Text="Please Select" Selected="True"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblVNO" runat="server" ForeColor="Blue" Font-Names="verdana" Font-Size="Small" Text="By Door No." />
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlVillaNo" Width="220px" ToolTip="Select the Door No. (Owner Resident/Tenant)" runat="server"
                                        Font-Names="Verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlVillaNo_SelectedIndexChanged" Font-Size="Small">
                                        <asp:ListItem Text="Please Select" Selected="True"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <br />

                    <table style="width:100%">
                        <tr>
                            <td>
                                <telerik:RadWindow ID="rwSpecialReport" Width="700" Height="280" VisibleOnPageLoad="false" runat="server"  Title="Profile++" Modal="true">
                                <ContentTemplate>
                                    <table>
                                        <tr>
                                            <td>
                                                  <telerik:RadGrid ID="rgSpecialReport" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                            Height="250px" Width="600px" AllowFilteringByColumn="false" AllowSorting="true" AllowPaging="false" PageSize="5"  Skin="Sunset">
                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                            <ClientSettings>
                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                <PagerStyle Mode="NumericPages" />
                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                <RowIndicatorColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>

                                                                    <telerik:GridBoundColumn DataField="RARSN" HeaderText="RARSN" UniqueName="RARSN"
                                                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                     <telerik:GridBoundColumn DataField="RTRSN" HeaderText="RTRSN" UniqueName="RTRSN"
                                                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                     <telerik:GridBoundColumn DataField="Code" HeaderText="Code" UniqueName="Code"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                 
                                                                    <telerik:GridBoundColumn DataField="Details" HeaderText="Details" UniqueName="Details"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                       <telerik:GridBoundColumn DataField="ContactNo" HeaderText="ContactNo" UniqueName="ContactNo"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"  Width="100px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"  Width="100px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Emailid" HeaderText="Emailid" UniqueName="Emailid"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                            </td>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </telerik:RadWindow>
                            </td>
                        </tr>
                    </table>


                        <table style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblChkout" runat="server" Text="CheckOut" ForeColor="Blue" Visible="false" Font-Names="verdana" Font-Bold="true" Font-Size="Small" />
                                    <telerik:RadGrid ID="radgrdCheckout" Skin="WebBlue" runat="server" AutoGenerateColumns="false" AllowFilteringByColumn="true" OnItemCommand="radgrdCheckout_ItemCommand"
                                        AllowPaging="true" AllowSorting="true" Width="600px" OnInit="radgrdCheckout_Init">
                                        <MasterTableView>
                                            <NoRecordsTemplate>
                                                No Records Found.
                                            </NoRecordsTemplate>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Door No" DataField="RTVILLANO" ReadOnly="true"></telerik:GridBoundColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="Name" DataField="RTName" ReadOnly="true"></telerik:GridBoundColumn>--%>

                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" DataField="RTName" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                              HeaderText="Name" HeaderStyle-Font-Names="Calibri" UniqueName="Name2" SortExpression="RTName">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                    Text='<%# Eval("RTName")%>' Font-Underline="true"
                                                    ForeColor="#7049BA" Font-Bold="true" OnClick="lbtnName_Click" ToolTip="Click here to add a transaction" CommandName='<%# Eval("RTRSN") %>'>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                                <telerik:GridBoundColumn HeaderText="Mobile No" DataField="Contactcellno" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btngrdchkout" ToolTip="Click here to checkout." Font-Names="Verdana" runat="server" CommandName="UpdateRow" Text="CheckOut" CommandArgument='<%# Eval("RTRSN") %>' />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                                <td style="vertical-align: top;">
                                    <text style="font-family: Verdana; font-size: x-small;"><br />
                                Shows the selected resident name.Click the CheckOut Button in case the resident is going out of the community for a shortwhile.
                            </text>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblChkIn" runat="server" Text="CheckIn" ForeColor="Blue" Visible="false" Font-Names="verdana" Font-Bold="true" Font-Size="Small" />
                                    <telerik:RadGrid ID="radgrdCheckin" Skin="WebBlue" runat="server" AutoGenerateColumns="false" AllowFilteringByColumn="true" OnItemCommand="radgrdCheckin_ItemCommand"
                                        AllowPaging="true" AllowSorting="true" Width="600px" OnInit="radgrdCheckin_Init">
                                        <MasterTableView>
                                            <NoRecordsTemplate>
                                                No Records Found.
                                            </NoRecordsTemplate>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Door No" DataField="RTVILLANO" ReadOnly="true"></telerik:GridBoundColumn>
                                               <%-- <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" ReadOnly="true"></telerik:GridBoundColumn>--%>
                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" DataField="RTName" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                              HeaderText="Name" HeaderStyle-Font-Names="Calibri" UniqueName="Name2" SortExpression="RTName">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                    Text='<%# Eval("RTName")%>' Font-Underline="true"
                                                    ForeColor="#7049BA" Font-Bold="true" OnClick="lbtnName_Click" ToolTip="Click here to add a transaction" CommandName='<%# Eval("RTRSN") %>'>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Mobile No">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnSMS" ToolTip="Click here to send SMS." runat="server" Text='<%# Eval("Contactcellno") %>' CommandName="SendSMS" CommandArgument='<%# Eval("Contactcellno") %>' OnClientClick ="javascript:if(!confirm('Send alert SMS to resident. Are you sure?')){return false;}" ></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="DateTime" DataField="DateTime" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btngrdchkin" ToolTip="Click here to checkin" Font-Names="Verdana" runat="server" CommandName="UpdateRow" Text="CheckIn" CommandArgument='<%# Eval("RTRSN") %>' />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                                <td style="vertical-align: top;">
                                    <text style="font-family: Verdana; font-size: x-small;"> <br />
                                Shows the names of residents who are currently out of the community.When a resident comes in, click the CheckIn button against his/her name.
                            </text>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="radgrdCheckin" />
                    <asp:PostBackTrigger ControlID="radgrdCheckout" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

