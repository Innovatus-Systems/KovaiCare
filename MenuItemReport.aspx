<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MenuItemReport.aspx.cs" Inherits="MenuItemReport" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .RadGrid .rgSelectedRow {
            background-color: red !important;
        }
    </style>
    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
   
        .form-controlForResidentAdd {
  /*display: block;*/
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="font-family: Verdana; font-size: small; min-height: 400px;">


                        <table style="width: 100%">

                            <tr>
                                <td align="center">

                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>

                        </table>

                        <table style="width: 100%">

                            <tr>
                                <td style="vertical-align: top">Date : 
                                    <telerik:RadDatePicker ID="dtpmenuforday" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="185px" CssClass="form-controlForResidentAdd" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpmenuforday_SelectedDateChanged">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="form-control" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                    &nbsp;&nbsp;Session :
                                    <asp:DropDownList ID="ddlDinersSession" CssClass="form-controlForResidentAdd"  ToolTip="Choose the session where you wish to include the Menu Item." runat="server"
                                        AutoPostBack="true" >
                                    </asp:DropDownList>
                                    &nbsp;&nbsp;
                                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success" BorderColor="#3333ff" BackColor="#3333ff" OnClick="btnSearch_Click" ToolTip="To search particular date and session for booking and actual counts." />
                                </td>

                            </tr>
                        </table>



                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label9" runat="server" Text="Diners Estimation Count" ForeColor="Green" Font-Names="verdana" Font-Size="Small" ToolTip="If you find the resident count and the total count not same, it could be because there are some casual diners who have not yet booked.  Scroll down to see the list of such diners."></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="rgDinBkng" runat="server" AutoPostBack="true"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true" Height="80px"
                                        CellSpacing="5" Width="70%"
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

                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Width="120px" HeaderTooltip="This information is entered in Diners booking." ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="120px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="100px" DataField="Session" ReadOnly="true" HeaderTooltip="This information is entered in Diners booking." AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Regular" HeaderStyle-Width="60px" DataField="Regular" ReadOnly="true" HeaderTooltip="No. of regular resident diners.Billing Rates or tariff may differ for regular and casual diners." AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Casual" HeaderStyle-Width="60px" DataField="Casual" ReadOnly="true" HeaderTooltip="No. of casual resident diners.Billing Rates or tariff may differ for regular and casual diners." AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Res.Guests" HeaderStyle-Width="60px" DataField="Guests" ReadOnly="true" HeaderTooltip="No. of guest dinres for resident." AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="HomeDly." HeaderStyle-Width="60px" DataField="HS" ReadOnly="true" HeaderTooltip="No. of home dly. services.Refer diners Notes for additional information if any." AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="G.House" HeaderStyle-Width="60px" DataField="GH" ReadOnly="true" HeaderTooltip="No. of Guest diners in Guest House." AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Staff" HeaderStyle-Width="60px" DataField="Staff" ReadOnly="true" HeaderTooltip="No. of staff who are dining." AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Total" HeaderStyle-Width="60px" DataField="Total" ReadOnly="true" HeaderTooltip="Total diners for given date and session." AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Actual" HeaderStyle-Width="60px" DataField="Actual" ReadOnly="true" HeaderTooltip="Actual count of persons who dined on the particular date and session, This is entered after the session is over.This will help in excess / shortage montering." AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>

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
                        <table>
                            <tr>

                                <td style="vertical-align: top">

                                    <asp:Label ID="Label7" runat="server" Text="A.Menu Estimate" ForeColor="Green" Font-Names="verdana" Font-Size="Small" ToolTip="What is the quantity to be prepared for the  session? You can have the estimate here."></asp:Label><br />

                                    <telerik:RadGrid ID="rgItemEstimate" runat="server" Skin="WebBlue" GridLines="None"
                                        AutoGenerateColumns="False" AllowSorting="True" SelectedItemStyle-CssClass="RadGrid" Width="400px">
                                        <SortingSettings SortToolTip="SortToolTip" SortedAscToolTip="SortedAscToolTip" SortedDescToolTip="SortedDescToolTip" />
                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" />
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridTemplateColumn UniqueName="TemplateColumn1" AllowFiltering="False" Visible="True"
                                                    HeaderStyle-Width="5px" ItemStyle-Width="5px">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImgItemBtn" runat="server" CausesValidation="false" CommandName="View"
                                                            ImageUrl="~/images/imagesCATYPXYB.jpg" OnClick="ImgItemBtn_Click" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn DataField="MenuDate" HeaderText="Date" UniqueName="MenuDate"
                                                    Display="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="FormatDate" HeaderText="FormatDate" UniqueName="FormatDate"
                                                    Display="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SessionCode" HeaderText="SessionCode" UniqueName="SessionCode"
                                                    Display="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="day" HeaderText="Day" UniqueName="Day"
                                                    Visible="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="SessionName" HeaderText="Session" UniqueName="SessionName"
                                                    Visible="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="Group" HeaderText="Group" UniqueName="Group"
                                                    Display="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="ItemName" HeaderText="Menu" UniqueName="ItemName" HeaderTooltip="If you do not find a menu item planned for the day , you have to add it first via a separate option. "
                                                    Visible="true" HeaderStyle-Width="100px" ItemStyle-Width="100px">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="AddOn" HeaderText="Add on" UniqueName="AddOn"
                                                    Display="false">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="ServeQty" HeaderText="ServeQty" UniqueName="ServeQty"
                                                    Display="true" HeaderStyle-Width="80px" ItemStyle-Width="80px">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="uom" HeaderText="Unit" UniqueName="uom" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                                    Display="true">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="EstimateQty" HeaderText="Estimated Qty" UniqueName="EstimateQty" HeaderTooltip="How much qty to be perpared based on the bookings done for the session. "
                                                    Display="true" HeaderStyle-Width="100px" ItemStyle-Width="100px">
                                                </telerik:GridBoundColumn>
                                                



                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                                <td style="width:25px;">

                                </td>
                                <td style="vertical-align: top">

                                    <asp:Label ID="Label8" runat="server" Text="B.Provisions" ForeColor="Green" Font-Names="verdana" Font-Size="Small" ToolTip="What is the quantity of a provision / grocery to be issued from the stores for the  selected menu item? You can have the estimate here."></asp:Label><br />
                                    <telerik:RadGrid ID="rgRMEstimate" runat="server" Skin="WebBlue" GridLines="None"
                                        AutoGenerateColumns="False" AllowSorting="True">
                                        <%--<SortingSettings SortToolTip="SortToolTip" SortedAscToolTip="SortedAscToolTip" SortedDescToolTip="SortedDescToolTip" />--%>


                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" />
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>
                                               <%-- <telerik:GridTemplateColumn UniqueName="TemplateColumn1" AllowFiltering="False" Visible="True"
                                                    HeaderStyle-Width="5px" ItemStyle-Width="5px">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImgBtn" runat="server" CausesValidation="false" CommandName="View"
                                                            ImageUrl="~/images/imagesCATYPXYB.jpg" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>--%>

                                                <telerik:GridBoundColumn DataField="ItemName" HeaderText="Menu" UniqueName="ItemName" HeaderTooltip="Name of the menu item included in the selected session."
                                                    Visible="true">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="rmname" HeaderText="Ingredient" UniqueName="rmname" HeaderTooltip="Name of the provision/grocery included in the recipe of the menu item."
                                                    Visible="true">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="EstimateQty" HeaderText="Estimate" UniqueName="EstimateQty" HeaderTooltip="Qty of the provision required. based on the cooking estimate of the menu item."
                                                    Display="true">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="inputuom" HeaderText="Unit" UniqueName="inputuom" HeaderTooltip="Unit of measure"
                                                    Display="true">
                                                </telerik:GridBoundColumn>

                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>

                    </div>
                </ContentTemplate>
                <Triggers>
                    <%-- <asp:PostBackTrigger ControlID="BtnnExcelExport" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

