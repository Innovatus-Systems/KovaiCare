<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Error_Check.aspx.cs" Inherits="Error_Check" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });


        function ConfirmMsg() {

            var result = confirm('Are you sure want to send Greetings?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
    }
    else {
        document.getElementById('<%=CnfResult.ClientID%>').value = "false";
    }

}

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div>
        <div class="main_cnt">
            <div class="first_cnt">
                <div style="width: 92%; min-height: 400px">

                       <table>
                           <tr>
                        <td>
                            <telerik:RadGrid ID="ErrorCheckView" runat="server" AllowPaging="false" ClientSettings-Scrolling-AllowScroll="true" 
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true"
                                OnPageIndexChanged="ErrorCheckView_PageIndexChanged" OnItemCommand="ErrorCheckView_ItemCommand"
                                OnPageSizeChanged="ErrorCheckView_PageSizeChanged" OnSortCommand="ErrorCheckView_SortCommand"
                                CellSpacing="0" Width="1000px" AllowFilteringByColumn="true"
                                MasterTableView-HierarchyDefaultExpanded="true">
                                <HeaderContextMenu CssClass="table table-bordered table-hover">
                                </HeaderContextMenu>
                                  <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true"  />
                                </ClientSettings>
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

                                                                   

<%--                                        <telerik:GridBoundColumn HeaderText="#" DataField="RSN" HeaderStyle-Wrap="true" 
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="TRUE"  ItemStyle-HorizontalAlign="Left" AllowSorting="false" ItemStyle-ForeColor="Wheat" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>

                                        <telerik:GridBoundColumn HeaderText="Villa Number" DataField="RTVILLANO" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="left" AllowSorting="true"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Status" DataField="RTSTATUS" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="true" Visible="True" ItemStyle-HorizontalAlign="left" AllowSorting="true"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                                                               
                                        <telerik:GridBoundColumn HeaderText="Message" DataField="Comments" HeaderStyle-Wrap="false" ItemStyle-ForeColor="Red" 
                                            ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="True" 
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

                           <asp:HiddenField ID="CnfResult" runat="server" />
                    </table>



                    </div>
                </div>
           </div>

            </div>
</asp:Content>

