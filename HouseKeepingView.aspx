<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="HouseKeepingView.aspx.cs" Inherits="HouseKeepingView" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <style>
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    

<div class="main_cnt">
        <div class="first_cnt">
                        
    <asp:Panel runat="server" ID="PnlHK" Visible="false">

        <table style="width: 100%">
            <tr align="center">
                <td>
                    <asp:Label ID="lnktitle" runat="server" Text="Housekeeping Schedule" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                </td>
            </tr>
        </table>

        <table>
            <tr style="height: 5px"></tr>
            

            <tr>
                <td style="width: 15px"></td>
                <td>

                    <asp:Label ID="lblICE" runat="server" Text="Specific :" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                    <telerik:RadGrid ID="grdIndHouseKeeping" runat="server" AllowPaging="false" PageSize="5" AutoGenerateColumns="False" Skin="Sunset" AllowSorting="true"
                        CellSpacing="0" Width="1100px" Height="375px" AllowFilteringByColumn="true" MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="grdIndHouseKeeping_OnItemCommand">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                        </ClientSettings>
                        <GroupingSettings CaseSensitive="false" />
                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                        </HeaderContextMenu>
                        <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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



                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Category" DataField="Category" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Type" FilterControlWidth="50px" DataField="StaffType" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Task" DataField="taskid" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="WorkType" FilterControlWidth="50px" DataField="WorkType" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Assigned To" FilterControlWidth="60px" DataField="wfid" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Location" FilterControlWidth="50px" DataField="Location" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="LocationDesc" FilterControlWidth="60px" DataField="LocationDesc" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="UsualTime" FilterControlWidth="30px" DataField="UsualTime" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Status" FilterControlWidth="60px" DataField="Status" ReadOnly="true" Display="false"></telerik:GridBoundColumn>

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
                        <FilterMenu Skin="Sunset" EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </FilterMenu>
                    </telerik:RadGrid>


                </td>
                <td style="vertical-align: top">

                    <%--<asp:Button ID="btnAdd" ToolTip="Click here to assign a task." runat="server" Text="Add" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" OnClick="btnAdd_Click" />--%>
                    <asp:Button ID="btnReturn" ToolTip="Click here to view the dashboard" runat="server" Text="Return" ForeColor="White" BackColor="DarkOrange" Width="90px" Height="25px" OnClick="btnReturn_Click" />

                </td>
            </tr>

            <tr style="height: 5px"></tr>
           

            <tr>
                <td style="width: 15px"></td>
                <td>

                   
                    <asp:LinkButton ID="lnkshowall" runat="server" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue" OnClick="lnkshowall_Click" Text ="All :" ></asp:LinkButton>
                    
                    <div id="dvhk" runat="server">

                    <telerik:RadGrid ID="grdHouseKeeping" runat="server" AllowPaging="false" PageSize="5" AutoGenerateColumns="False" Skin="Sunset" AllowSorting="true"
                        CellSpacing="0" Width="1100px" Height="300px" AllowFilteringByColumn="true" MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="grdHouseKeeping_OnItemCommand">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                        </ClientSettings>
                        <GroupingSettings CaseSensitive="false" />
                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                        </HeaderContextMenu>
                        <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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


                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Category" DataField="Category" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Type" FilterControlWidth="50px" DataField="StaffType" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Task" DataField="taskid" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="WorkType" FilterControlWidth="50px" DataField="WorkType" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Assigned To" FilterControlWidth="60px" DataField="wfid" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Location" FilterControlWidth="50px" DataField="Location" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="LocationDesc" FilterControlWidth="60px" DataField="LocationDesc" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="UsualTime" FilterControlWidth="30px" DataField="UsualTime" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" ReadOnly="true"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Status" FilterControlWidth="60px" DataField="Status" ReadOnly="true"  Display="false"></telerik:GridBoundColumn>

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
                        <FilterMenu Skin="Sunset" EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </FilterMenu>
                    </telerik:RadGrid>

                        </div>

                </td>
            </tr>


        </table>

    </asp:Panel>

    <asp:Panel runat="server" ID="PnlSR" Visible="false">

        <table style="width: 100%">
            <tr align="center">
                <td>
                    <asp:Label ID="lnktitle2" runat="server" Text="Service Requests" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                </td>
            </tr>
        </table>

        <table>
            <tr style="height: 5px"></tr>

           

            <tr>
                <td style="width: 15px"></td>
                <td>

                    <asp:Label ID="Label2" runat="server" Text="Specific :" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>
                    <telerik:RadGrid ID="grdIndTaskList" runat="server" AllowPaging="false" PageSize="5" AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                        CellSpacing="0" Width="1100px" Height="375px" AllowFilteringByColumn="true" MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="grdIndTaskList_OnItemCommand">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                        </ClientSettings>
                        <GroupingSettings CaseSensitive="false" />
                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                        </HeaderContextMenu>
                        <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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





                                <telerik:GridBoundColumn DataField="RSN" HeaderText="Ref" UniqueName="RSN"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="30px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="30px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AssignedTo" ItemStyle-ForeColor="Blue" HeaderText="Name" UniqueName="AssignedTo" SortExpression="AssignedTo"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="70px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="60px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DoorNo" HeaderText="Door No." UniqueName="DoorNo" SortExpression="DoorNo"
                                    Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="40px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TaskDate" HeaderText="Date" UniqueName="TaskDate" SortExpression="TaskDate"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" SortExpression="Category"
                                    Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="50px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Need" HeaderText="Service Type" UniqueName="Need" SortExpression="Need"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="120px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Task" HeaderText="Description" UniqueName="Task" SortExpression="Task"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="140px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="140px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TargetDate" HeaderText="Target Date" UniqueName="TargetDate" SortExpression="TargetDate"
                                    Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="60px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="60px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TStatus" HeaderText="Status" UniqueName="TStatus" SortExpression="TStatus"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left"  Display="false">
                                    <HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="50px"></ItemStyle>
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
                        <FilterMenu Skin="Sunset" EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </FilterMenu>
                    </telerik:RadGrid>


                </td>
                <td style="vertical-align: top">

                    <%--<asp:Button ID="btnAdd2" ToolTip="Click here to add a service request." runat="server" Text="Add" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" OnClick="btnAdd2_Click" />--%>
                    <asp:Button ID="btnReturn2" ToolTip="Click here to view the dashboard" runat="server" Text="Return" ForeColor="White" BackColor="DarkOrange" Width="90px" Height="25px" OnClick="btnReturn2_Click" />

                </td>
            </tr>

            <tr style="height: 5px"></tr>
            

            <tr>
                <td style="width: 15px"></td>
                <td>

                    <%-- <asp:Label ID="Label3" runat="server" Text="All :" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue"></asp:Label>--%>
                    
                     <asp:LinkButton ID="lnksrshowall" runat="server" Font-Names="Verdana" Font-Size="Medium" ForeColor="Blue" OnClick="lnksrshowall_Click" Text ="All :" ></asp:LinkButton>
                    
                    <div id="dvsr" runat="server">
                    <telerik:RadGrid ID="grdTaskList" runat="server" AllowPaging="false" PageSize="5" AutoGenerateColumns="False" Skin="Sunset" AllowSorting="true"
                        CellSpacing="0" Width="1100px" Height="300px" AllowFilteringByColumn="true" MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="grdTaskList_OnItemCommand">
                        <ClientSettings>
                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                        </ClientSettings>
                        <GroupingSettings CaseSensitive="false" />
                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                        </HeaderContextMenu>
                        <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
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


                                <telerik:GridBoundColumn DataField="RSN" HeaderText="Ref" UniqueName="RSN"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="30px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="30px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AssignedTo" ItemStyle-ForeColor="Blue" HeaderText="Name" UniqueName="AssignedTo" SortExpression="AssignedTo"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="70px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="60px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="DoorNo" HeaderText="Door No." UniqueName="DoorNo" SortExpression="DoorNo"
                                    Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="40px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TaskDate" HeaderText="Date" UniqueName="TaskDate" SortExpression="TaskDate"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" SortExpression="Category"
                                    Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="50px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Need" HeaderText="Service Type" UniqueName="Need" SortExpression="Need"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="120px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Task" HeaderText="Description" UniqueName="Task" SortExpression="Task"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="140px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="140px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TargetDate" HeaderText="Target Date" UniqueName="TargetDate" SortExpression="TargetDate"
                                    Visible="true" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left">
                                    <HeaderStyle HorizontalAlign="Left" Width="60px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="60px"></ItemStyle>
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TStatus" HeaderText="Status" UniqueName="TStatus" SortExpression="TStatus"
                                    Visible="true" HeaderStyle-HorizontalAlign="Left" FilterControlWidth="40px" ItemStyle-HorizontalAlign="Left"  Display="false">
                                    <HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" Width="50px"></ItemStyle>
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
                        <FilterMenu Skin="Sunset" EnableTheming="True">
                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                        </FilterMenu>
                    </telerik:RadGrid>

                        </div>

                </td>
            </tr>


        </table>





    </asp:Panel>
</div>
    </div>

</asp:Content>

