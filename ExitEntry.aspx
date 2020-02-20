<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ExitEntry.aspx.cs" Inherits="ExitEntry" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/MenuCSS.css" rel="stylesheet" />
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

            var result = confirm('Are you sure, you want to save?');

            if (result) {

                document.getElementById('<%=HResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=HResult.ClientID%>').value = "false";
            }

        }
        function ConfirmMsg2() {

            var result = confirm('CheckOut?');

            if (result) {

                document.getElementById('<%=HResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=HResult.ClientID%>').value = "false";
            }

        }
        function ConfirmMsg3() {

            var result = confirm('CheckIn?');

            if (result) {

                document.getElementById('<%=HResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=HResult.ClientID%>').value = "false";
            }

        }
        function ConfirmMsg4() {

            var result = confirm('You are about to Reset a CheckOut Status.  Confirm.');

            if (result) {

                document.getElementById('<%=HResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=HResult.ClientID%>').value = "false";
            }

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <div>
                <div>
                    <%--  <asp:UpdatePanel ID="UpdatePanel2" runat="server">--%>
                    <%--<ContentTemplate>--%>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadMenu ID="RMCare" runat="server" Skin="" Width="250px" OnItemClick="RMCare_ItemClick" Style="z-index: 2900">
                                    <Items>
                                        <telerik:RadMenuItem runat="server" Text="Care" CssClass="main_menu">
                                            <Items>
                                                <telerik:RadMenuItem runat="server" Width="240px" Text="Checkout register" CssClass="level_menu ">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" Width="240px" Text="Living alone" CssClass="level_menu ">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" Width="240px" Text="Birthdays in 7 days" CssClass="level_menu">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" Width="240px" Text="Daily messages" CssClass="level_menu ">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem runat="server" Width="240px" Text="Help" CssClass="level_menu ">
                                                </telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                                <asp:Label ID="lblLevelY" runat="server" Visible="True" Text="Level Y : CheckIn/CheckOut Register" Font-Underline="false" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" ForeColor="Blue"></asp:Label>
                            </td>
                            <%--  <td>
                                
                            </td>--%>
                            <td style="width: 115px"></td>
                            <td>
                                <asp:Label ID="LblOutCount" runat="server" Autopostback="true" ForeColor="Blue" Visible="true" Font-Names="verdana" Font-Bold="true" Font-Size="Small" />
                            </td>
                            <td style="width: 50px"></td>
                            <td>
                                <asp:Label ID="lblCOTime" runat="server" BackColor="Yellow" Autopostback="true" ForeColor="Blue" Visible="true" Font-Names="verdana" Font-Bold="true" Font-Size="Small" ToolTip="Shows the number of resident(s) who have checked out more than 4 hours." />
                            </td>
                        </tr>
                    </table>

                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblVNO" runat="server" ForeColor="Blue" Font-Names="verdana" Font-Size="Small" Text="By Door No." />
                                <asp:HiddenField ID="HResult" runat="server" />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlVillaNo" Width="175px" ToolTip="Select the Door No. (Owner Resident/Tenant)" runat="server"
                                    Font-Names="Verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlVillaNo_SelectedIndexChanged" Font-Size="Small">
                                </asp:DropDownList>


                            </td>
                            <td style="width: 10px"></td>
                            <td>
                                <asp:Button ID="BtnShow" CssClass="btn btn-primary" runat="server" ToolTip="Click here to show profile deatils." Text="Show" OnClick="BtnShow_Click" Font-Size="Small" />

                                <asp:Label ID="LBlRTRSN" runat="server" ForeColor="BlueViolet" Visible="False" Font-Names="verdana" Font-Size="Small" />
                                <asp:Label ID="LblRTRSN1" runat="server" ForeColor="BlueViolet" Visible="False" Font-Names="verdana" Font-Size="Small" />
                            </td>

                            <%-------------------%>
                            <td style="width: 50Px; height: auto"></td>
                            <td>
                                <asp:Label ID="Label4" runat="server" ForeColor="Blue" Font-Names="verdana" Font-Size="Small" Text="By Name" />
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlName" Width="175px" ToolTip="Select the Resident Name (Owner Resident / Tenant)" runat="server"
                                    Font-Names="Verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlVillaNo_SelectedIndexChanged" Font-Size="Small">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 10px"></td>
                            <td>
                                <asp:Button ID="btnShowName" CssClass="btn btn-primary" runat="server" ToolTip="Click here to show profile deatils." Text="Show" OnClick="BtnShowName_Click" Font-Size="Small" />

                                <asp:Label ID="Label6" runat="server" ForeColor="BlueViolet" Visible="False" Font-Names="verdana" Font-Size="Small" />
                                <asp:Label ID="Label7" runat="server" ForeColor="BlueViolet" Visible="False" Font-Names="verdana" Font-Size="Small" />
                            </td>

                        </tr>
                    </table>

                    <%--</ContentTemplate>--%>
                    <%--  </asp:UpdatePanel>--%>

                    <table>
                        <tr>
                            <td style="width: 500Px; height: auto">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Image ID="RImage" runat="server" Height="150px" GenerateEmptyAlternateText="true" AlternateText="" ForeColor="Gray" Width="150px" BorderColor="Blue" BorderStyle="Solid" BorderWidth="1px" Visible="false" />
                                                </td>
                                                <td></td>
                                                <td style="width: 250Px; height: 150px">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblVilla1" ForeColor="Blue" runat="server" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblStatus1" ForeColor="Blue" runat="server" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblName1" runat="server" ForeColor="Blue" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblCNo1" ForeColor="Blue" runat="server" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblLNO1" ForeColor="Blue" runat="server" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="radgrdCheckout" runat="server" AutoGenerateColumns="false" AllowFilteringByColumn="true"  OnItemCommand="radgrdCheckout_ItemCommand"
                                                        AllowPaging="true" AllowSorting="true">
                                                        <MasterTableView>
                                                            <Columns>
                                                                <telerik:GridBoundColumn HeaderText="Door No" DataField="RTVILLANO" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Mobile No" DataField="Contactcellno" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridTemplateColumn>
                                                                    <ItemTemplate>
                                                                        <asp:Button ID="btngrdchkout" runat="server" CommandName="UpdateRow" Text="CheckOut" CommandArgument='<%# Eval("RTRSN") %>' />
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                     <telerik:RadGrid ID="radgrdCheckin" runat="server" AutoGenerateColumns="false" AllowFilteringByColumn="true"  OnItemCommand="radgrdCheckin_ItemCommand"
                                                        AllowPaging="true" AllowSorting="true">
                                                        <MasterTableView>
                                                            <Columns>
                                                                <telerik:GridBoundColumn HeaderText="Door No" DataField="RTVILLANO" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Mobile No" DataField="Contactcellno" ReadOnly="true"></telerik:GridBoundColumn>
                                                                <telerik:GridTemplateColumn>
                                                                    <ItemTemplate>
                                                                        <asp:Button ID="btngrdchkin" runat="server" CommandName="UpdateRow" Text="CheckIn" CommandArgument='<%# Eval("RTRSN") %>' />
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>

                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="BtnExit" runat="server" ToolTip="Press here to resident is going out." Text="CheckOut" OnClick="BtnExit_Click" OnClientClick="ConfirmMsg2()" CssClass="btn btn-danger" Font-Size="Small" Visible="false" />

                                        </td>
                                        <td>
                                            <asp:Button ID="BtnEntry" runat="server" ToolTip="Press here to resident is coming in." Text="CheckIn" CssClass="btn btn-success" BackColor="Green" OnClick="BtnEntry_Click" OnClientClick="ConfirmMsg3()" Font-Size="Small" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:Button ID="BtnReset" runat="server" CssClass="btn btn-success" ToolTip="Press here to Reset the status CheckOut into CheckIn." Text="Reset" OnClick="BtnReset_Click" OnClientClick="ConfirmMsg4()" Font-Size="Small" Visible="false" />
                                        </td>
                                    </tr>
                                </table>

                            </td>
                            <td style="width: 500px; height: auto">
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>

                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Image ID="DepndntImage" runat="server" Height="150px" Width="150px" GenerateEmptyAlternateText="true" AlternateText="" ForeColor="Gray" BorderColor="Blue" BorderStyle="Solid" BorderWidth="1px" Visible="false" />
                                                </td>
                                                <td style="width: 250Px; height: 150px">

                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblVilla11" ForeColor="Blue" runat="server" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblStatus11" ForeColor="Blue" runat="server" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblName11" ForeColor="Blue" runat="server" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblCNo11" ForeColor="Blue" runat="server" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblLNO11" ForeColor="Blue" runat="server" Font-Size="Small" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>

                                    </ContentTemplate>
                                </asp:UpdatePanel>

                                <table>

                                    <tr>
                                        <td>
                                            <asp:Button ID="BtnExit1" ToolTip="Press here to resident is going out.." runat="server" Text="CheckOut" OnClick="BtnExit1_Click" OnClientClick="ConfirmMsg2()" CssClass="btn btn-danger" Font-Size="Small" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:Button ID="BtnEntry1" runat="server" ToolTip="Press here to resident is coming in." OnClick="BtnEntry1_Click" OnClientClick="ConfirmMsg3()" Text="CheckIn" CssClass="btn btn-success" Font-Size="Small" BackColor="Green" Visible="false" />
                                        </td>
                                        <td>
                                            <asp:Button ID="BtnReset1" runat="server" ToolTip="Press here to Reset the status CheckOut into CheckIn." OnClick="BtnReset1_Click" OnClientClick="ConfirmMsg4()" Text="Reset" CssClass="btn btn-success" Font-Size="Small" Visible="false" />
                                        </td>
                                    </tr>

                                </table>
                            </td>
                            <td style="width: 500px; height: auto; vertical-align: top">
                                <asp:Label ID="Label1" runat="server" Text="Here, you mark those who have either gone out shopping or for an evening stroll or for some personal work outside the Retirement Community." Font-Size="Smaller" ForeColor="Gray" Style="text-align: justify;"></asp:Label><br />
                                <asp:Label ID="Label2" runat="server" Text="By Checking Out, one can make sure, the Resident can be reached out, in case of emergency, The Retirement Community Management will know immdiately if any resident is away for several hours and has not returned." Font-Size="Smaller" ForeColor="Gray" Style="text-align: justify;"></asp:Label><br />
                                <asp:Label ID="Label3" runat="server" Text="The Management can call the resident and inquire if he/she needs any assistance to return back." Font-Size="Smaller" ForeColor="Gray" Style="text-align: justify;"></asp:Label>
                            </td>

                        </tr>

                    </table>
                </div>
                <div>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>

                            <table>
                                <tr>
                                    <td style="width: 1200px; height: 50px; vertical-align: top;">
                                        <asp:Label ID="LblGridHeading" runat="server" Visible="false" ForeColor="Blue" Text="Checked Out" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" />
                                        <telerik:RadGrid ID="OutInListView" runat="server" AllowPaging="False" PageSize="100"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="false"
                                            OnPageIndexChanged="OutInListView_PageIndexChanged" OnItemCommand="OutInListView_ItemCommand"
                                            OnPageSizeChanged="OutInListView_PageSizeChanged" OnSortCommand="OutInListView_SortCommand"
                                            CellSpacing="5" Width="70%" Visible="false"
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
                                                    <HeaderStyle Width="5px"></HeaderStyle>
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn>
                                                    <HeaderStyle Width="5px"></HeaderStyle>
                                                </ExpandCollapseColumn>
                                                <Columns>
                                                    <telerik:GridBoundColumn HeaderText="RTRSN" DataField="ERTRSN" HeaderStyle-Wrap="false" Visible="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="100px"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Villa No" DataField="VillaNo" HeaderStyle-Wrap="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RStatus" HeaderStyle-Wrap="false" ItemStyle-Width="75px"
                                                        ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="Name" HeaderStyle-Wrap="false" Visible="true"
                                                        ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="75px"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Mobile No" DataField="MobileNo" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                        ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Checked Out" DataField="TimeDate" HeaderStyle-Wrap="false" ItemStyle-Width="20px"
                                                        ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="left"
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

                                <tr>
                                    <td style="width: 1200px; height: 50px; vertical-align: top;">
                                        <asp:Label ID="LblGridHeading1" runat="server" ForeColor="Blue" Text="Residents checked out as of now" Font-Bold="true" Font-Names="Verdana" Font-Size="Small" />
                                        <telerik:RadGrid ID="GeneralOutInListView" runat="server" AllowPaging="False"
                                            AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="true"
                                            OnPageIndexChanged="GeneralOutInListView_PageIndexChanged" OnItemCommand="GeneralOutInListView_ItemCommand"
                                            OnPageSizeChanged="GeneralOutInListView_PageSizeChanged" OnSortCommand="GeneralOutInListView_SortCommand"
                                            OnItemDataBound="GeneralOutInListView_ItemDataBound"
                                            CellSpacing="5" Width="70%"
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
                                                    <HeaderStyle Width="5px"></HeaderStyle>
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn>
                                                    <HeaderStyle Width="5px"></HeaderStyle>
                                                </ExpandCollapseColumn>
                                                <Columns>
                                                    <telerik:GridBoundColumn HeaderText="RTRSN" DataField="ERTRSN" HeaderStyle-Wrap="false" Visible="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="100px"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Villa No" DataField="VillaNo" HeaderStyle-Wrap="false"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Status" DataField="RStatus" HeaderStyle-Wrap="false" ItemStyle-Width="75px"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Name" DataField="Name" HeaderStyle-Wrap="false" Visible="true"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="75px"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Mobile No." DataField="MobileNo" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                        ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn HeaderText="Checked Out" DataField="TimeDate" HeaderStyle-Wrap="false" ItemStyle-Width="20px"
                                                        ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="left"
                                                        ItemStyle-CssClass="Row1">
                                                        <HeaderStyle Wrap="False"></HeaderStyle>
                                                        <ItemStyle Wrap="False"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                        HeaderText="" HeaderStyle-Font-Names="Calibri" UniqueName="Customer2" AllowFiltering="false">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lblCustomerName" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                                Text="SMS" Font-Underline="true"
                                                                ForeColor="#00008B" ToolTip="SMS can be sent using a SMS Gateway. Contact Innovatus Systems for details.">
                                                            </asp:LinkButton>
                                                            <%--Text='<%# Eval("Customer")%>'--%>
                                                        </ItemTemplate>
                                                        <HeaderStyle HorizontalAlign="Left" Width="30px"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="30px"></ItemStyle>
                                                    </telerik:GridTemplateColumn>
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
                                </tr>
                            </table>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

