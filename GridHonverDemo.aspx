<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GridHonverDemo.aspx.cs" Inherits="GridHonverDemo" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
            <telerik:RadGrid ID="SAloneListView" runat="server" AllowPaging="True" PageSize="20"
                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                OnPageIndexChanged="SAloneListView_PageIndexChanged" OnItemDataBound="SAloneListView_ItemDataBound"
                OnPageSizeChanged="SAloneListView_PageSizeChanged" OnSortCommand="SAloneListView_SortCommand"
                CellSpacing="0" Width="99%" AllowFilteringByColumn="true"
                MasterTableView-HierarchyDefaultExpanded="true">
                <ClientSettings>
                    <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                </ClientSettings>
                <HeaderContextMenu CssClass="table table-bordered table-hover">
                </HeaderContextMenu>
                <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                <MasterTableView AllowCustomPaging="false">
                    <NoRecordsTemplate>
                        No Records Found.
                    </NoRecordsTemplate>
                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                    <RowIndicatorColumn>
                        <HeaderStyle Width="10px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="10px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <Columns>
                   
                        <telerik:GridBoundColumn HeaderText="#" DataField="RTRSN" HeaderStyle-Wrap="true"
                            ItemStyle-Wrap="false" AllowFiltering="false" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false" ItemStyle-ForeColor="Gray" ItemStyle-Width="10px"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn HeaderText="Villa No." DataField="RTVILLANO" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="center" AllowSorting="true"
                            ItemStyle-CssClass="Row1" ItemStyle-Width="50px">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>

                         <telerik:GridBoundColumn HeaderText="Name" DataField="RTNAME" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="center" AllowSorting="true"
                            ItemStyle-CssClass="Row1" ItemStyle-Width="50px">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Title" DataField="RTTitle" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                    
                        <telerik:GridBoundColumn HeaderText="Gender" DataField="Gender" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="false"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>


                        <telerik:GridBoundColumn HeaderText="Address" DataField="RTAddress1" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="City" DataField="CityName" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="PinCode" DataField="Pincode" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Country" DataField="Country" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Mobile No" DataField="Contactcellno" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="left"
                            ItemStyle-CssClass="Row1" ItemStyle-Width="30px">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="MailID" DataField="Contactmail" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <%--<telerik:GridBoundColumn HeaderText="AlternateEMAILID" DataField="AlternateEMAILID" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>--%>
                        <telerik:GridBoundColumn HeaderText="Age" DataField="Age" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="right"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Date of Birth" DataField="DOB" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="right"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="BloodGroup" DataField="BloodGroup" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="Occupants" DataField="Occupants" HeaderStyle-Wrap="false"
                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="false" ItemStyle-HorizontalAlign="Center"
                            ItemStyle-CssClass="Row1">
                            <HeaderStyle Wrap="False"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>
                        </telerik:GridBoundColumn>
                        <%--<telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>--%>
                        <%--<telerik:GridTemplateColumn HeaderText="" HeaderButtonType="TextButton"
                             HeaderStyle-HorizontalAlign ="Left" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Italic="false">
                                <ItemTemplate>
                                       <asp:LinkButton ID="LnkRemove" runat="server" Text="Remove" 
                                       Font-Names="Verdana" Font-Size="Small" Font-Italic="false"></asp:LinkButton>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>--%>
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
        </div>
    </form>
</body>
</html>
