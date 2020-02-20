<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Residentdtls.aspx.cs" Inherits="Residentdtls" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />--%>
    <script type="text/javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="main_cnt">
        <div class="first_cnt">
            <table>
                <tr>
                    <td>
                        <telerik:RadGrid ID="rdgResidentview" runat="server" AllowPaging="True" PageSize="20"
                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="true"
                            OnPageIndexChanged="rdgListView_PageIndexChanged"
                            OnPageSizeChanged="rdgListView_PageSizeChanged" 
                            OnSortCommand="rdgListView_SortCommand"
                            CellSpacing="20" Width="100%"
                            MasterTableView-HierarchyDefaultExpanded="true">
                            <HeaderContextMenu CssClass="Row1">
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
                                 

                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="250px"
                                        HeaderText="Name" HeaderStyle-Font-Names="Calibri" UniqueName="Name2" SortExpression="Name">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                Text='<%# Eval("RTName")%>' Font-Underline="true"
                                                ForeColor="#00008B" OnClick="lbtnName_Click"  ToolTip="Click here to view  Resident detail  - Resident Profile">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                      <telerik:GridBoundColumn HeaderText="RSN" DataField="RTRSN" HeaderStyle-Wrap="false"
                                        ItemStyle-Wrap="false"  AllowFiltering="true" Visible="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                        ItemStyle-CssClass="Row1">
                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                        <ItemStyle Wrap="False"></ItemStyle>
                                    </telerik:GridBoundColumn>


                                    <telerik:GridBoundColumn HeaderText="VillaNo" DataField="RTVILLANO" HeaderStyle-Wrap="false"
                                        ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="150px"
                                        ItemStyle-CssClass="Row1">
                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                        <ItemStyle Wrap="False"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false" ItemStyle-Width="200px"
                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left"
                                        ItemStyle-CssClass="Row1">
                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                        <ItemStyle Wrap="False"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Address" DataField="RTAddress1" HeaderStyle-Wrap="false"
                                        ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="250px"
                                        ItemStyle-CssClass="Row1">
                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                        <ItemStyle Wrap="False"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                  
                                    <telerik:GridBoundColumn HeaderText="Mobileno" DataField="Contactcellno" HeaderStyle-Wrap="false"
                                        ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="200px"
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
        </div>
    </div>
</asp:Content>

