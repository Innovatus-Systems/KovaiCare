<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BPTransSummary.aspx.cs" Inherits="BPTransSummary" %>
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
                    <td>

                        <telerik:RadGrid ID="rdgTransSum" runat="server"
                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                            CellSpacing="0" Width="100%" Height="280px" AllowFilteringByColumn="true"
                            MasterTableView-HierarchyDefaultExpanded="true" OnItemDataBound="rdgTransSum_ItemDataBound">

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
                                    
                                    <telerik:GridBoundColumn DataField="Date" HeaderText="Date" UniqueName="Date"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TDesc" HeaderText="Description" UniqueName="TDesc"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Code" HeaderText="Code" UniqueName="Code"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="Amount" HeaderText="Amount" UniqueName="Amount"
                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="80px">
                                        <HeaderStyle HorizontalAlign="Right" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="100px"></ItemStyle>
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
