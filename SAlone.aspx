<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="SAlone.aspx.cs" Inherits="SAlone" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
    .preference .rwWindowContent
    {
        background-color: Green !important;
    }
    .availability .rwWindowContent
    {
        background-color: Yellow !important;
    }
</style>
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

                 <asp:Panel ID="PnlLevelW" Visible="false"  runat="server">

                 <table style ="width:100% ">
                      <tr>
                        <td style ="width:25% ">
                            
                            </td>
                            <td style ="width:40% ">
                               <%--   <asp:Label ID="Label12" Visible="true" Text="Level W -  List of residents who are single occupants in a villa."
                                Font-Bold="true" ForeColor="Blue" Font-Size="Medium" runat="server" />--%>

                                  <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>

                            </td>
                          <td style ="width:35% " align="right">

                              <asp:Button ID="btnhelptext" runat="server" Text="Help?" CssClass="btn btn-success" Visible="true" 
                                                                            OnClick="btnhelptext_Click"  ToolTip="Click here to view the help about this page." />
                          
                          
                        </td>
              
                         
                    </tr>
                  </table>
                     
                     <table style ="width:100% ">
                    <tr>
                        <td style="width: 1100px; height: 450px; vertical-align: top;">
                            <telerik:RadGrid ID="SAloneListView" runat="server" AllowPaging="True" PageSize="20"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true" 
                                OnPageIndexChanged="SAloneListView_PageIndexChanged" OnItemCommand="SAloneListView_ItemCommand"
                                OnPageSizeChanged="SAloneListView_PageSizeChanged" OnSortCommand="SAloneListView_SortCommand"
                                CellSpacing="0" Width="99%" AllowFilteringByColumn="true"
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
                                            ItemStyle-Wrap="false" AllowFiltering="false" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false" ItemStyle-ForeColor="Gray" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn HeaderText="Villa No." DataField="villano"  HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="75px"  FilterControlWidth="60px"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="center" AllowSorting="true"
                                            ItemStyle-CssClass="Row1"  >
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
                                        <%--<telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="250px"
                                            HeaderText="Name" HeaderStyle-Font-Names="Calibri" UniqueName="Name2" SortExpression="Name">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                    Text='<%# Eval("RTName")%>' Font-Underline="true"
                                                    ForeColor="#7049BA" Font-Bold="true" OnClick="lbtnName_Click" ToolTip="Click here to add a transaction">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>

                                         <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False" ForeColor="#7049BA" Font-Bold="true"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                         <%-- <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                            HeaderText="Name" DataField="RTName" HeaderStyle-Font-Names="Calibri" UniqueName="Name2" SortExpression="Name">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                    Text='<%# Eval("RTName")%>' Font-Underline="true"
                                                    ForeColor="#7049BA" Font-Bold="true" OnClick="lbtnName_Click" ToolTip="Click here to post transactions for the resident">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>--%>


                                        <telerik:GridBoundColumn HeaderText="Gender" DataField="Gender" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="false"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn HeaderText="Address" DataField="RTAddress1" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False" ></HeaderStyle>
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
                                        <telerik:GridBoundColumn HeaderText="Mobile No" DataField="Contactcellno" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Center"
                                            ItemStyle-CssClass="Row1" ItemStyle-Width="30px">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MailID" DataField="Contactmail" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Left"
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
                                         <telerik:GridBoundColumn HeaderText="Age" DataField="Age" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Right"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true"   ItemStyle-HorizontalAlign="right"  
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Date of Birth" DataField="DOB" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Right"
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
                        </td>
                    </tr>
                </table>

            </asp:Panel>

                </div>
            </div>
        </div>
     <telerik:RadWindow ID="RWHelpmessageSA" VisibleOnPageLoad="false" BackColor="Red" Font-Names="Calibri" ForeColor="blue" Width="450px" Height="230px" runat="server">
        <ContentTemplate>
         
            <p style="color:blue">This list displays the names of those residents who are staying alone at the moment.</p> 
           <p style="color:blue"> List is provided as they may need assistance.</p>
     </ContentTemplate>
          </telerik:RadWindow>

        <%-- <telerik:RadGrid ID="RadEmgGrid" runat="server" AllowPaging="True" PageSize="20" AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true" 
                                                             
                                CellSpacing="0" Width="99%" >
                              
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

                                        <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="center" AllowSorting="true"
                                            ItemStyle-CssClass="Row1" ItemStyle-Width="50px">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn HeaderText="Gender" DataField="Gender" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
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
                                        <telerik:GridBoundColumn HeaderText="Blood Group" DataField="BloodGroup" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Emergency Contact No." DataField="EMgContactNo" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
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
                            </telerik:RadGrid>--%>
    
</asp:Content>
