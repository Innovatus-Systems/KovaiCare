<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="OwnersAway.aspx.cs" Inherits="OwnersAway" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%--<script src="//code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" language="javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });



        function askConfirm() {
            if (confirm("Are you sure, you want to save?"))
                alert(" ")
            else {
                //alert(" ")

                return false;
            }
        }

    </script>

    
    <div class="main_cnt">

        <div class="first_cnt">
            <div style="width:98%";>

                <asp:Panel ID="PnlLevelOA" Visible="false"  runat="server">



                 <table style="width:100%" >
                      <tr>
                        <td align="center">
                             <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                        </td>
                         
                    </tr>
                     </table>

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

                    <table>
                     <tr>
                            <td style="width:80%">
                             <telerik:RadGrid ID="OwnerAwayGridView" runat="server" AllowPaging="True" PageSize="20"
                            AutoGenerateColumns="false"    Skin="WebBlue" AllowSorting="true" 
                                OnPageIndexChanged="OwnerAwayGridView_PageIndexChanged" OnItemDataBound="OwnerAwayGridView_ItemDataBound" 
                                OnPageSizeChanged="OwnerAwayGridView_PageSizeChanged" OnSortCommand="OwnerAwayGridView_SortCommand" OnItemCommand="OwnerAwayGridView_ItemCommand"
                                CellSpacing="0" Width="96%" AllowFilteringByColumn="true"
                                MasterTableView-HierarchyDefaultExpanded="true">
                                 <GroupingSettings CaseSensitive="false" />
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
                                                <%--<asp:ImageButton ID="ImagBtnnEdit" Height="15px" ToolTip="Click here to Edit resident details" Width="25px" ImageUrl="~/App_Theme/edit-icon1.png" OnClick="ImagBtnnEdit_Click" runat="server" />--%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                            HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="AddOn" SortExpression="AddOn">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="LnkbtnAddOn" runat="server" Text="++" ToolTip="Click to manage additional particulars of the profile" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="LnkbtnAddOn_Click">++</asp:LinkButton>
                                                <%--<asp:ImageButton ID="ImagBtnnEdit" Height="15px" ToolTip="Click here to Edit resident details" Width="25px" ImageUrl="~/App_Theme/edit-icon1.png" OnClick="ImagBtnnEdit_Click" runat="server" />--%>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn HeaderText="#" DataField="RTRSN" HeaderStyle-Wrap="true"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="True" ItemStyle-HorizontalAlign="Left" AllowSorting="false" ItemStyle-ForeColor="Gray" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn HeaderText="Villa No." DataField="villano" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="center" AllowSorting="true"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Status" DataField="SDescription" HeaderStyle-Wrap="false"  ItemStyle-Width="150px"
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

                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" DataField="RTName" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                            HeaderText="Name" HeaderStyle-Font-Names="Calibri" UniqueName="Name2" SortExpression="RTName">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                    Text='<%# Eval("RTName")%>' Font-Underline="true"
                                                    ForeColor="#7049BA" Font-Bold="true" OnClick="lbtnName_Click" ToolTip="Click here to add a transaction">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <%--<telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False" ForeColor="#7049BA" Font-Bold="true"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
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
                                       <%-- <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="250px"
                                            HeaderText="Mobile No." HeaderStyle-Font-Names="Calibri" UniqueName="MobileNo" SortExpression="Mobile No">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnMobileNo" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                    Text='<%# Eval("Contactcellno")%>' Font-Underline="true"
                                                    ForeColor="Black" Font-Bold="false" OnClick="lbtnMobileNo_Click" ToolTip="Click here to add a Billing">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>
                                        <telerik:GridBoundColumn HeaderText="Mobile No" DataField="Contactcellno" HeaderStyle-Wrap="false"  ItemStyle-Width="150px"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MailID" DataField="Contactmail" HeaderStyle-Wrap="false"  ItemStyle-Width="200px"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn HeaderText="AlternateEMAILID" DataField="AlternateEMAILID" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn HeaderText="Date of Birth" DataField="DOB" HeaderStyle-Wrap="false"  ItemStyle-Width="100px"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="right"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <%--<telerik:GridBoundColumn HeaderText="BloodGroup" DataField="BloodGroup" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn HeaderText="Occupants" DataField="Occupants" HeaderStyle-Wrap="false"
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
                                        <%--<telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" HeaderStyle-Wrap="false"
                                ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" >
                                <HeaderStyle Wrap="False"></HeaderStyle>
                                <ItemStyle Wrap="False"></ItemStyle>
                            </telerik:GridBoundColumn>
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
                        </td>
                     </tr>
                 

                
                </table>

            </asp:Panel>

                </div>
            </div>
        </div>
</asp:Content>

