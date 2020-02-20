<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdditionalParticulars.aspx.cs" Inherits="AdditionalParticulars" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>


        <div>

            <table>

                <tr>
                    <td style="text-align: center; color: Black; background-color: yellow; font-family: Calibri; font-weight: 200; font-size: medium">Emergency Contacts</td>
                </tr>
                <tr>
                    <td>

                        <telerik:RadGrid ID="rdgAttribute" runat="server"
                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                            CellSpacing="0" Width="100%" AllowFilteringByColumn="true"
                            MasterTableView-HierarchyDefaultExpanded="true">

                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                            </HeaderContextMenu>
                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                            <ClientSettings>
                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="3"></Scrolling>
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
                                    <telerik:GridBoundColumn DataField="RTVILLANO" HeaderText="Villa No." UniqueName="RTVILLANO"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="50px">
                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RTSTATUS" HeaderText="Status" UniqueName="RTSTATUS"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RTName" HeaderText="Name" UniqueName="RTName"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <%-- <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                            HeaderText="Name" DataField="RTName" HeaderStyle-Font-Names="Calibri" UniqueName="RTName" SortExpression="Name" FilterControlWidth="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                    Text='<%# Eval("RTName")%>' Font-Underline="true"
                                                    ForeColor="#7049BA" Font-Bold="true" OnClick="lbtnName_Click"  ToolTip="">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>
                                    <telerik:GridBoundColumn DataField="RACode" HeaderText="Item" UniqueName="RACode"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RAText" HeaderText="Text" UniqueName="RAText"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DOB" HeaderText="DOB" UniqueName="DOB"
                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RAValue" HeaderText="Value" UniqueName="RAValue"
                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RADate" HeaderText="Date" UniqueName="RADate"
                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RAContactNo" HeaderText="ContactNo" UniqueName="RAContactNo"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RAEmailId" HeaderText="Email Id" UniqueName="RAEmailId"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="250px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="250px"></ItemStyle>
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

    </form>

</body>
</html>
