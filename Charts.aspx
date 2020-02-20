<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Charts.aspx.cs" Inherits="Charts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
   <%--  <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <style type="text/css">
        .auto-style1 {
            width: 238px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 98%; background-color: white">
               <table style="width:100%">
                <tr>
                    <td align="center">
                       <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </td>
                </tr>
                   </table>
            <asp:Panel ID="pnlGentlemenLadiesratio" runat="server" Visible="True">
                <table style="width:90%">
                  
                    <tr>

                        
                        <td style="width:50%">
                            
                            <telerik:RadGrid ID="GenderGrid" runat="server" Height="100%" ToolTip="Includes all residents and their dependents(OR,ORD,T,TD)"
                                AutoGenerateColumns="False" Skin="Outlook"
                                OnPageIndexChanged="GenderGrid_PageIndexChanged" OnItemCommand="GenderGrid_ItemCommand"
                                OnPageSizeChanged="GenderGrid_PageSizeChanged" OnSortCommand="GenderGrid_SortCommand"
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
                                        <telerik:GridBoundColumn HeaderText="Gender" DataField="RGender" HeaderStyle-Wrap="false" Visible="True"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="left" ItemStyle-Width="150px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="true" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="center" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Percentage(%)" DataField="Percentage" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" AllowSorting="true" ItemStyle-Width="150px"
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
                             <asp:Label ID="lblHelp1Chrt" runat="server" ForeColor="Blue" Font-Size="Smaller" Font-Names="Calibri" Text="Among the present occupants, how many are gentlemen and how many are ladies?"></asp:Label>
                            <asp:HiddenField ID="CnfResult" runat="server" />
                        </td>
                        <td style="width:5%"></td>
                       <td style="width:45%">
                            <telerik:RadHtmlChart runat="server" ID="GenderChart" Skin="Office2007" Height="500px" Width="500px" Legend-Appearance-Visible="true" Legend-Appearance-Position="left">
                                <PlotArea>
                                    <Series>
                                        <telerik:PieSeries DataFieldY="Percentage" Name="Ratio" NameField="RGender">
                                            <LabelsAppearance DataFormatString="{0}%">
                                            </LabelsAppearance>
                                            <TooltipsAppearance>

                                                <ClientTemplate>
                                                                                          #=dataItem.RGender#<br />
                                                                                           #=dataItem.Percentage# % 
                                                </ClientTemplate>
                                            </TooltipsAppearance>

                                        </telerik:PieSeries>

                                    </Series>
                                    <YAxis Name="Gender">
                                    </YAxis>
                                </PlotArea>
                                <ChartTitle Text="Gentlemen / Ladies ratio">
                                    <Appearance Align="Center" BackgroundColor="white" Position="Top">
                                        <TextStyle Color="Blue" FontSize="14" FontFamily="Calibri" Margin="5" Bold="true" Padding="10" />
                                    </Appearance>

                                </ChartTitle>
                            </telerik:RadHtmlChart>
                        </td>
                    </tr>
              </table>


                 <table style="width:90%;" >
                   <%-- <tr>
                        <td>
                            <asp:Label ID="lblOccupants" runat="server" Visible="false" Text="Occupants Per Resident(OR & T):" Font-Underline="False" Font-Bold="true" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" BackColor="White"></asp:Label>
                        </td>
                    </tr>--%>
                    <tr>

                         <td style="width:50%">
                            <telerik:RadGrid ID="OccupantsGrid" runat="server" Height="100%" ToolTip="Count of houses with 1 or 2 or 3 or more people staying in them "
                                AutoGenerateColumns="False" Skin="Outlook" AllowSorting="false"
                                AllowFilteringByColumn="false"
                                OnPageIndexChanged="OccupantsGrid_PageIndexChanged" OnItemCommand="OccupantsGrid_ItemCommand"
                                OnPageSizeChanged="OccupantsGrid_PageSizeChanged" OnSortCommand="OccupantsGrid_SortCommand"
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
                                        <telerik:GridBoundColumn HeaderText="No./House" DataField="ROccupants" HeaderStyle-Wrap="false" Visible="True"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="left" ItemStyle-Width="150px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="true" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="center" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Percentage(%)" DataField="Percentage" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" AllowSorting="true" ItemStyle-Width="150px"
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
                            <asp:Label ID="Label4" runat="server" ForeColor="Blue" Font-Size="Smaller" Font-Names="Calibri" Text="What is the occupancy per residence. Is it one person or two or more?"></asp:Label>
                           

                        </td>
                        <td style="width: 5%"></td>
                     <td style="width: 45%">

                            <telerik:RadHtmlChart runat="server" ID="OccupantChart" Skin="Office2007" Height="500px" Width="500px" Legend-Appearance-Visible="true" Legend-Appearance-Position="left">
                                <PlotArea>
                                    <Series>
                                        <telerik:PieSeries DataFieldY="Percentage" Name="Ratio" NameField="ROccupants">
                                            <LabelsAppearance DataFormatString="{0}%">
                                            </LabelsAppearance>
                                            <TooltipsAppearance>

                                                <ClientTemplate>
                                              #=dataItem.ROccupants#<br />
                                                   #=dataItem.Percentage# %                                             
                                                </ClientTemplate>
                                            </TooltipsAppearance>

                                        </telerik:PieSeries>

                                    </Series>
                                    <YAxis Name="Occupants">
                                    </YAxis>
                                </PlotArea>
                                <ChartTitle Text="People per Residence">
                                    <Appearance Align="Center" BackgroundColor="White" Position="Top">
                                        <TextStyle Color="Blue" FontSize="14" FontFamily="Calibri" Margin="5" Bold="true" Padding="10" />
                                    </Appearance>

                                </ChartTitle>
                            </telerik:RadHtmlChart>
                        </td>
                    </tr>
                </table>


                  <table style="width:90%">
                    <tr>
                        <td>
                            <asp:Label ID="lblStatus" runat="server" Visible="false" Text="Owners & Tenants:" Font-Bold="true" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" BackColor="White"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                       <td style="width: 50%">
                            <telerik:RadGrid ID="StatusGrid" runat="server"
                                AutoGenerateColumns="False" Skin="Outlook" AllowSorting="false"
                                AllowFilteringByColumn="false" ToolTip="How many houses are rented out and how many where owners are staying?"
                                OnPageIndexChanged="StatusGrid_PageIndexChanged" OnItemCommand="StatusGrid_ItemCommand"
                                OnPageSizeChanged="StatusGrid_PageSizeChanged" OnSortCommand="StatusGrid_SortCommand"
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
                                        <telerik:GridBoundColumn HeaderText="Status" DataField="Status" HeaderStyle-Wrap="false" Visible="True"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="left" ItemStyle-Width="150px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="true" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="center" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Percentage(%)" DataField="Percentage" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" AllowSorting="true" ItemStyle-Width="150px"
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
                            <asp:Label ID="Label5" runat="server" ForeColor="Blue" Font-Size="Smaller" Font-Names="Calibri" Text="How many houses are rented out and how many where owners are staying?"></asp:Label>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                        </td>
                        <td style="width: 5%"></td>
                        <td style="width:45%">
                            <telerik:RadHtmlChart runat="server" ID="ORTChart" Skin="Office2007" Height="500px" Width="500px" Legend-Appearance-Visible="true" Legend-Appearance-Position="left">
                                <PlotArea>
                                    <Series>
                                        <telerik:PieSeries DataFieldY="Percentage" Name="Ratio" NameField="Status">
                                            <LabelsAppearance DataFormatString="{0}%">
                                            </LabelsAppearance>
                                            <TooltipsAppearance>

                                                <ClientTemplate>
                                                                                          #=dataItem.Status#<br />
                                                                                           #=dataItem.Percentage# % 
                                                </ClientTemplate>
                                            </TooltipsAppearance>

                                        </telerik:PieSeries>

                                    </Series>
                                    <YAxis Name="Gender">
                                    </YAxis>
                                </PlotArea>
                                <ChartTitle Text="Owners & Tenants">
                                    <Appearance Align="Center" BackgroundColor="white" Position="Top">
                                        <TextStyle Color="Blue" FontSize="14" FontFamily="Calibri" Margin="5" Bold="true" Padding="10" />
                                    </Appearance>

                                </ChartTitle>
                            </telerik:RadHtmlChart>
                        </td>
                    </tr>
                </table>

                 <table style="width:90%">
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Visible="false" Text="Owners Residents & Owner Away:" Font-Bold="true" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" BackColor="White"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                        <td style="width: 50%">
                            <telerik:RadGrid ID="StatusGridA" runat="server"
                                AutoGenerateColumns="False" Skin="Outlook" AllowSorting="false"
                                AllowFilteringByColumn="false" ToolTip="How many house owners are residing & how many are not staying in the community?"
                                OnPageIndexChanged="StatusGridA_PageIndexChanged" OnItemCommand="StatusGridA_ItemCommand"
                                OnPageSizeChanged="StatusGridA_PageSizeChanged" OnSortCommand="StatusGridA_SortCommand"
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
                                        <telerik:GridBoundColumn HeaderText="Status" DataField="Status" HeaderStyle-Wrap="false" Visible="True"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="left" ItemStyle-Width="150px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="true" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="center" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Percentage(%)" DataField="Percentage" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" AllowSorting="true" ItemStyle-Width="150px"
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
                            <asp:Label ID="Label6" runat="server" ForeColor="Blue" Font-Size="Smaller" Font-Names="Calibri" Text="How many house owners are residing & how many are not staying in the community?"></asp:Label>
                            <asp:HiddenField ID="HiddenField2" runat="server" />
                        </td>
                        <td style="width: 5%"></td>
                      <td style="width:45%">
                            <telerik:RadHtmlChart runat="server" ID="OROAVChart" Skin="Office2007" Height="500px" Width="500px" Legend-Appearance-Visible="true" Legend-Appearance-Position="left">
                                <PlotArea>
                                    <Series>
                                        <telerik:PieSeries DataFieldY="Percentage" Name="Ratio" NameField="Status">
                                            <LabelsAppearance DataFormatString="{0}%">
                                            </LabelsAppearance>
                                            <TooltipsAppearance>

                                                <ClientTemplate>
                                                                                          #=dataItem.Status#<br />
                                                                                           #=dataItem.Percentage# % 
                                                </ClientTemplate>
                                            </TooltipsAppearance>

                                        </telerik:PieSeries>

                                    </Series>
                                    <YAxis Name="Gender">
                                    </YAxis>
                                </PlotArea>
                                <ChartTitle Text="Owners Residing/Away">
                                    <Appearance Align="Center" BackgroundColor="White" Position="Top">
                                        <TextStyle Color="Blue" FontSize="14" FontFamily="Calibri" Margin="5" Bold="true" Padding="10" />
                                    </Appearance>

                                </ChartTitle>
                            </telerik:RadHtmlChart>
                        </td>
                    </tr>
                </table>


                <table style="width:90%">
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Visible="False" Text="Age Distribution(Gents):" Font-Bold="true" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" BackColor="White"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                         <td style="width: 50%">
                            <telerik:RadGrid ID="MaleRatioGrid" runat="server"
                                AutoGenerateColumns="False" Skin="Outlook" AllowSorting="false"
                                AllowFilteringByColumn="false" ToolTip="How many resident gents are in different age groups?"
                                OnPageIndexChanged="MaleRatioGrid_PageIndexChanged" OnItemCommand="MaleRatioGrid_ItemCommand"
                                OnPageSizeChanged="MaleRatioGrid_PageSizeChanged" OnSortCommand="MaleRatioGrid_SortCommand"
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
                                        <telerik:GridBoundColumn HeaderText="Category" DataField="Category" HeaderStyle-Wrap="false" Visible="True"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="left" ItemStyle-Width="150px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="true" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="center" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Percentage(%)" DataField="Percentage" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" AllowSorting="true" ItemStyle-Width="150px"
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
                            <asp:Label ID="Label7" runat="server" ForeColor="Blue" Font-Size="Smaller" Font-Names="Calibri" Text="How many resident gents are in different age groups?"></asp:Label>
                            <asp:HiddenField ID="HiddenField3" runat="server" />
                        </td>
                        <td style="width: 5%"></td>
                       <td style="width:45%">
                            <telerik:RadHtmlChart runat="server" ID="RadMaleChart" Skin="Office2007" Height="500px" Width="500px" Legend-Appearance-Visible="true" Legend-Appearance-Position="left">
                                <PlotArea>
                                    <Series>
                                        <telerik:PieSeries DataFieldY="Percentage" Name="Ratio" NameField="Category">
                                            <LabelsAppearance DataFormatString="{0}%">
                                            </LabelsAppearance>
                                            <TooltipsAppearance>

                                                <ClientTemplate>
                                                                                          #=dataItem.Category#<br />
                                                                                           #=dataItem.Percentage# % 
                                                </ClientTemplate>
                                            </TooltipsAppearance>

                                        </telerik:PieSeries>

                                    </Series>
                                    <YAxis Name="Male">
                                    </YAxis>
                                </PlotArea>
                                <ChartTitle Text="Age Distribution(Gents)">
                                    <Appearance Align="Center" BackgroundColor="white" Position="Top">
                                        <TextStyle Color="Blue" FontSize="14" FontFamily="Calibri" Margin="5" Bold="true" Padding="10" />
                                    </Appearance>

                                </ChartTitle>
                            </telerik:RadHtmlChart>
                        </td>
                    </tr>
                </table>

                 <table style="width:90%">
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Visible="false" Text="Age Distribution(Ladies):" Font-Bold="true" Font-Names="Calibri" Font-Size="Medium" ForeColor="Black" BackColor="White"></asp:Label>
                        </td>
                    </tr>
                    <tr>

                         <td style="width: 50%">
                            <telerik:RadGrid ID="FemaleRatioGrid" runat="server" 
                                AutoGenerateColumns="False" Skin="Outlook" AllowSorting="false"
                                AllowFilteringByColumn="false" ToolTip="How many resident ladies are in different age groups?"
                                OnPageIndexChanged="FemaleRatioGrid_PageIndexChanged" OnItemCommand="FemaleRatioGrid_ItemCommand"
                                OnPageSizeChanged="FemaleRatioGrid_PageSizeChanged" OnSortCommand="FemaleRatioGrid_SortCommand"
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
                                        <telerik:GridBoundColumn HeaderText="Category" DataField="Category" HeaderStyle-Wrap="false" Visible="True"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="left" ItemStyle-Width="150px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="true" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="center" ItemStyle-Width="100px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Percentage(%)" DataField="Percentage" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" AllowSorting="true" ItemStyle-Width="150px"
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
                            <asp:Label ID="Label8" runat="server" ForeColor="Blue" Font-Size="Smaller" Font-Names="Calibri" Text="How many resident ladies are in different age groups?"></asp:Label>
                            <asp:HiddenField ID="HiddenField4" runat="server" />
                        </td>
                        <td style="width: 5%"></td>
                         <td style="width: 45%">
                            <telerik:RadHtmlChart runat="server" ID="RadFeMaleChart" Skin="Office2007" Height="500px" Width="500px" Legend-Appearance-Visible="true" Legend-Appearance-Position="left">
                                <PlotArea>
                                    <Series>
                                        <telerik:PieSeries DataFieldY="Percentage" Name="Ratio" NameField="Category">
                                            <LabelsAppearance DataFormatString="{0}%">
                                            </LabelsAppearance>
                                            <TooltipsAppearance>

                                                <ClientTemplate>
                                                                                          #=dataItem.Category#<br />
                                                                                           #=dataItem.Percentage# % 
                                                </ClientTemplate>
                                            </TooltipsAppearance>

                                        </telerik:PieSeries>

                                    </Series>
                                    <YAxis Name="Male">
                                    </YAxis>
                                </PlotArea>
                                <ChartTitle Text="Age Distribution(Ladies)">
                                    <Appearance Align="Center" BackgroundColor="White" Position="Top">
                                        <TextStyle Color="Blue" FontSize="14" FontFamily="Calibri" Margin="5" Bold="true" Padding="10" />
                                    </Appearance>

                                </ChartTitle>
                            </telerik:RadHtmlChart>
                        </td>
                    </tr>
                </table>
                 

                </asp:Panel>

                



            </div>

        </div>
    </div>
</asp:Content>
