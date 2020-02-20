<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="LevelSFilter.aspx.cs" Inherits="LevelSFilter" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />

    <div class="main_cnt">

        <div class="first_cnt">
            <div style="width: 98%">
                <table>
                    <tr>
                        <td>
                            <asp:Panel ID="pnlgeneral" Visible="true" runat="server">
                                <table align="Left" style="width: 92%;">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label16" Visible="true" Text="Level Q "
                                                Font-Bold="true" ForeColor="#660066" Font-Size="Small" runat="server" />
                                        </td>



                                    </tr>
                                    <tr>



                                        <td style="width: 50%;">


                                            <telerik:RadGrid ID="VillaCountListView" runat="server" AllowPaging="False" PageSize="10"
                                                AutoGenerateColumns="False" Skin="WebBlue" OnItemDataBound="VillaCountListView_ItemDataBound" AllowSorting="True" Visible="true"
                                                CellSpacing="0" Width="45%"
                                                MasterTableView-HierarchyDefaultExpanded="true">
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
                                                        <telerik:GridBoundColumn HeaderText="Residents" HeaderTooltip="Count of Owner residents" DataField="OwnerResident" HeaderStyle-Wrap="false"
                                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="True" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn HeaderText="Tenants" DataField="Tenant" HeaderTooltip="Count of Tenants" HeaderStyle-Wrap="false" Visible="true"
                                                            ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Total" DataField="Total" HeaderTooltip="Total of Residents and Tenants" HeaderStyle-Wrap="false" Visible="true"
                                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Occupants" DataField="OccupantsCount" HeaderTooltip="Number of occupants including dependents" HeaderStyle-Wrap="false" Visible="true"
                                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Away" DataField="OwnerAway" HeaderTooltip="Count of Owners (Not residing )" HeaderStyle-Wrap="false" ItemStyle-Width="100px"
                                                            ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" Visible="true"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Vacant" DataField="Vacant" HeaderTooltip="Count of vacant villas/apartments." HeaderStyle-Wrap="false"
                                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Others" DataField="staff" HeaderStyle-Wrap="false" ItemStyle-Width="100px"
                                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Center" Visible="false"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Staff" DataField="Others" HeaderTooltip="Count of Staff and others" HeaderStyle-Wrap="false" ItemStyle-Width="100px"
                                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Center"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Checked Out" DataField="CheckedOutCount" HeaderTooltip="Checked Out Count" HeaderStyle-Wrap="false" ItemStyle-Width="100px"
                                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Center"
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
                                                <FilterMenu Skin="Outlook" EnableTheming="True">
                                                    <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                                </FilterMenu>
                                            </telerik:RadGrid>
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel ID="PnlLevelS" Visible="true" runat="server">

                                <table>
                                    <tr>

                                        <td>
                                            <asp:Label ID="Label15" Visible="true" Text="Level S - Owners, Tenants, Owners Away"
                                                Font-Bold="true" ForeColor="Blue" Font-Size="Medium" runat="server" />                                         
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 50%;">
                                            <telerik:RadGrid ID="rcntgrdView" runat="server" AllowPaging="True" PageSize="20"
                                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                                OnPageIndexChanged="rdgListView_PageIndexChanged" OnItemDataBound="rcntgrdView_ItemDataBound"
                                                OnPageSizeChanged="rdgListView_PageSizeChanged" OnSortCommand="rdgListView_SortCommand" OnItemCommand="rcntgrdView_ItemCommand"
                                                CellSpacing="0" Width="100%" AllowFilteringByColumn="true"
                                                MasterTableView-HierarchyDefaultExpanded="true">
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                                </ClientSettings>
                                                <GroupingSettings CaseSensitive="false" />
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

                                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                            HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Viewresident" SortExpression="View">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="Lnkbtnview" runat="server" ToolTip="Click here to View profile" Text="View" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtnview_Click">View</asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                            HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="Lnkbtnedit" runat="server" ToolTip="Click here to Edit profile" Text="Edit" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtnedit_Click">Edit</asp:LinkButton>
                                                               </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                            HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="AddOn" SortExpression="AddOn">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="LnkbtnAddOn" runat="server" Text="++" ToolTip="Click to manage additional particulars of the profile" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="LnkbtnAddOn_Click">++</asp:LinkButton>
                                                               </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn HeaderText="#" DataField="RTRSN" HeaderStyle-Wrap="true"
                                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="True" ItemStyle-HorizontalAlign="Left" AllowSorting="false" ItemStyle-ForeColor="Gray" ItemStyle-Width="10px"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="DoorNo." DataField="RTVILLANO" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="center" AllowSorting="true" FilterControlWidth="30px" ItemStyle-Width="30px"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Status" DataField="SDescription" HeaderStyle-Wrap="false"
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
                                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                                            HeaderText="Name" DataField="RTName" HeaderStyle-Font-Names="Calibri" UniqueName="Name2" SortExpression="Name">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lbtnName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                                    Text='<%# Eval("RTName")%>' Font-Underline="true"
                                                                    ForeColor="#7049BA" Font-Bold="true" OnClick="lbtnName_Click" ToolTip="Click here to add a transaction">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>                                                       
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
                                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="left"
                                                            ItemStyle-CssClass="Row1" FilterControlWidth="30px" ItemStyle-Width="30px">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="MailID" DataField="Contactmail" HeaderStyle-Wrap="false"
                                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>                                                        
                                                        <telerik:GridBoundColumn HeaderText="Age" DataField="Age" HeaderStyle-Wrap="false"
                                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="right"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="DOB" DataField="DOB" HeaderStyle-Wrap="false"
                                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="Right"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>                                                      
                                                        <telerik:GridBoundColumn HeaderText="Ct." DataField="Occupants" HeaderStyle-Wrap="false"
                                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Center"
                                                            ItemStyle-CssClass="Row1">
                                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                                            <ItemStyle Wrap="False"></ItemStyle>
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="OutStanding" DataField="Outstanding" HeaderStyle-Wrap="false"
                                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right"
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
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

