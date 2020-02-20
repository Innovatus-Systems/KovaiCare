<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ProfilePP.aspx.cs" Inherits="ProfilePP" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
  
    <script type="text/javascript" language="javascript">
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
     <asp:UpdatePanel ID="Updtpnl" runat="server">
      <ContentTemplate>
    <div class="main_cnt">
        <div class="first_cnt">
            <table>
                <tr>

                        <td align="center">


                             <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>

                        </td>
                    </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                    </td>
                    <td>
                        <asp:DropDownList ID="ddlAttribGroup" AutoPostBack="true" Width="170px" Height="23px" runat="server" ToolTip="Select a 'Group' from the list shown"
                            Font-Names="Verdana" Font-Size="Small" OnSelectedIndexChanged="ddlAttribGroup_SelectedIndexChanged">
                            <asp:ListItem Text="--- ALL ---" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Incase of emergency" Value="1CE"></asp:ListItem>
                            <asp:ListItem Text="NextOfKin" Value="NOK"></asp:ListItem>
                            <asp:ListItem Text="Personal" Value="Personal"></asp:ListItem>
                            <asp:ListItem Text="Health" Value="Health"></asp:ListItem>
                            <asp:ListItem Text="Special" Value="Special"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="btnExpProject_Click" ForeColor="White" ToolTip="Click here to export grid data to excel." />
                    </td>
                </tr>
            </table>

            <table>
                <tr>
                    <td>
                        <telerik:RadGrid ID="rdgAttribute" runat="server" CssClass="table table-bordered table-hover"
                            AutoGenerateColumns="False" Height="400px" Width="1100px" AllowSorting="true" AllowFilteringByColumn="true" AllowPaging="false" Skin="WebBlue" OnItemCommand="rdgAttribute_ItemCommand">
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
                                    <telerik:GridBoundColumn DataField="RTVILLANO" HeaderText="Villa No." UniqueName="RTVILLANO" FilterControlWidth="40px"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                        <HeaderStyle HorizontalAlign="Left" Width="80px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="80px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RTStatus" HeaderText="Status" UniqueName="RTSTATUS"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                        <HeaderStyle HorizontalAlign="Left" Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RTName" HeaderText="Name" UniqueName="RTName"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                        <HeaderStyle HorizontalAlign="Left" Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RAGroup" HeaderText="Group" UniqueName="RAGroup"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                        <HeaderStyle HorizontalAlign="Left" Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RACode" HeaderText="Item" UniqueName="RACode"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                        <HeaderStyle HorizontalAlign="Left" Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RAText" HeaderText="Text" UniqueName="RAText"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                        <HeaderStyle HorizontalAlign="Left" Width="150px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Left" Width="150px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DOB" HeaderText="DOB" UniqueName="DOB" FilterControlWidth="60px"
                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RAValue" HeaderText="Value" UniqueName="RAValue" FilterControlWidth="60px"
                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                        <HeaderStyle HorizontalAlign="Right" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RADate" HeaderText="Date" UniqueName="RADate" FilterControlWidth="60px"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                        <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RAContactNo" HeaderText="ContactNo" UniqueName="RAContactNo" FilterControlWidth="60px"
                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                        <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Center" Width="100px"></ItemStyle>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RAEmailId" HeaderText="Email Id" UniqueName="RAEmailId"
                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
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
    </div>
          </ContentTemplate>
         </asp:UpdatePanel>

</asp:Content>


