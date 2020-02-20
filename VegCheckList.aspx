<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="VegCheckList.aspx.cs" Inherits="VegCheckList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .ddlstyle {
            color: rgb(33,33,00);
            Font-Family: Verdana;
            font-size: 12px;
            /*vertical-align: middle;*/
        }
    </style>

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="main_cnt">
                <div class="first_cnt" style="min-height: 450px">
                    <div style="font-family: Verdana; font-size: small;">
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">

                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td style="width: 70px;">
                                    <asp:Label ID="lblCurMonth" runat="server"><b>Month :</b></asp:Label>
                                </td>

                                <td>
                                    <asp:DropDownList ID="drpMonth" runat="server"  Width="75px"></asp:DropDownList>
                                </td>

                                <td style="text-align: right; width: 70px;">
                                    <asp:Label ID="lblGroup" runat="server"><b>Group :</b></asp:Label>
                                </td>
                                <td style="width: 150px;">
                                    <asp:DropDownList ID="drpGroup" AutoPostBack="true" ToolTip="Please select Group name and click search button to filter the grid" runat="server"  OnSelectedIndexChanged="drpGroup_SelectedIndexChanged"></asp:DropDownList>
                                </td>

                                <td style="text-align: right; width: 70px;">
                                    <asp:Label ID="lblItem" runat="server"><b>Item :</b></asp:Label>
                                </td>
                                <td style="width: 130px;">
                                    <asp:DropDownList ID="drpItem" runat="server" ToolTip="Please select Item name and click search button to filter the grid" AutoPostBack="true"  OnSelectedIndexChanged="drpItem_SelectedIndexChanged"></asp:DropDownList>
                                </td>
                                <td style="width: 70px;">
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Search" ForeColor="White" BackColor="BlueViolet" ToolTip="Click here to get details in grid." OnClick="btnSearch_Click" />
                                </td>
                                <td align="right" style="width: 150px;">
                                    <asp:Button ID="BtnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                                </td>
                                <td style="text-align: right; width: 100px;">
                                    <asp:Label ID="lbllabel" runat="server"><b>Valid As Of :</b></asp:Label>
                                </td>

                                <td style="text-align: left; width: 200px;">
                                    <b>
                                        <asp:Label ID="lblvalid" runat="server" Text="-"></asp:Label></b>
                                </td>
                            </tr>

                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 500px;">
                                    <asp:CheckBox ID="ChkDontShow" runat="server" AutoPostBack="true" Font-Size="X-Small" ToolTip="Mark this Check Box  to exclude all those items that were not purchased during the selected period." Text="Do Not Show All Blank Items" TextAlign="Right" OnCheckedChanged="ChkDontShow_CheckedChanged" />
                               &nbsp; &nbsp; &nbsp;
                                    <asp:CheckBox ID="ChkYeterday" runat="server" AutoPostBack="true" Font-Size="X-Small" ToolTip="Mark this Check Box to show only those items that had a 'Purchase' yesterday. " Text="Show Only Items Purchased Yesterday" OnCheckedChanged="ChkYeterday_CheckedChanged" />
                                </td>
                                <td >
                                    <asp:Label runat="server" ID="txthelp" ForeColor="GrayText" Font-Size="X-Small" Text="Worried about rising prices? Click on an item to view a graph - both quantity and value of purchase during the period. Ensure PopUps are NOT BLOCKED."></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table align="center" style="width: 100%;">

                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td style="width: 70%">
                                                <telerik:RadGrid ID="rgVegList" runat="server" AutoPostBack="true"
                                                    AutoGenerateColumns="False" AllowSorting="True" AllowFilteringByColumn="false"
                                                    Width="98%" Skin="Sunset">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                    </ClientSettings>
                                                    <MasterTableView ShowHeadersWhenNoRecords="true">
                                                        <NoRecordsTemplate>
                                                            No Records Found.
                                                        </NoRecordsTemplate>
                                                        <Columns>
                                                            <%--<telerik:GridBoundColumn HeaderText="GROUP" DataField="GROUP"
                                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="110px" 
                                                                HeaderTooltip="Group Of Item">
                                                            </telerik:GridBoundColumn>--%>
                                                             <telerik:GridBoundColumn HeaderText="ITEMCode" DataField="ITEMCode" Visible="false" UniqueName="ITEMCode"
                                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="110px" >
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn HeaderText="ITEM" DataField="ITEM" 
                                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" FilterControlWidth="120px"
                                                                HeaderTooltip="Name Of Item">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnlLink" ToolTip="Click here to get charts for particular Item , Which you click." runat="server" Text='<%# Eval("ITEM") %>'  CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("ITEM") %>' OnClick="lnlLink_Click" ></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>

                                                             



                                                            <%-- <telerik:GridBoundColumn HeaderText="MONTH" DataField="MONTH"
                                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="95px" FilterControlWidth="60px"
                                                                HeaderTooltip="First Two Digits Is Year and Next Two Digits Is Month">
                                                            </telerik:GridBoundColumn>--%>
                                                            <telerik:GridBoundColumn HeaderText="01" DataField="01"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="First Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="02" DataField="02"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Second Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="03" DataField="03"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Third Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="04" DataField="04"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Fourth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="05" DataField="05"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Fifth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="06" DataField="06"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Sixth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="07" DataField="07"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Seventh Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="08" DataField="08"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Eighth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="09" DataField="09"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Ninth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="10" DataField="10"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Tenth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="11" DataField="11"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Eleventh Day Of The Month">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn HeaderText="12" DataField="12"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twelth Day Of The Month">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn HeaderText="13" DataField="13"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Thirteenth Day Of The Month">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn HeaderText="14" DataField="14"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Fourteenth Day Of The Month">
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn HeaderText="15" DataField="15"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Fifteenth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="16" DataField="16"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Sixteenth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="17" DataField="17"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Seventeenth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="18" DataField="18"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Eighteenth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="19" DataField="19"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Nineteenth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="20" DataField="20"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twentieth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="21" DataField="21"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twenty First Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="22" DataField="22"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twenty Second Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="23" DataField="23"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twenty Third Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="24" DataField="24"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twenty Fourth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="25" DataField="25"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twenty Fifth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="26" DataField="26"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twenty Sixth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="27" DataField="27"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twenty Seventh Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="28" DataField="28"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twenty Eighth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="29" DataField="29"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Twenty Ninth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="30" DataField="30"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Thirtieth Day Of The Month">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="31" DataField="31"
                                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                HeaderTooltip="Thirty First Day Of The Month">
                                                            </telerik:GridBoundColumn>

                                                        </Columns>

                                                    </MasterTableView>

                                                </telerik:RadGrid>
                                            </td>
                                            <td style="width: 25%">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <b>
                                                                <asp:Label ID="lblyesterday" runat="server" Visible="false" Text="Yesterday Purchased."></asp:Label></b>

                                                            &nbsp;
                                                       
                                                            <asp:Button ID="yesterdaySearch" runat="server" Font-Bold="true" Text="Search" ForeColor="White" BackColor="YellowGreen" ToolTip="Click here to get details in grid." Visible="false" OnClick="yesterdaySearch_Click1" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadGrid ID="rdYesterdayVegList" runat="server" AutoPostBack="true"
                                                                AutoGenerateColumns="False" AllowSorting="True" AllowFilteringByColumn="false"
                                                                Width="250px" Skin="Web20" Visible="false">
                                                                <ClientSettings>
                                                                    <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                                </ClientSettings>
                                                                <MasterTableView ShowHeadersWhenNoRecords="true">
                                                                    <NoRecordsTemplate>
                                                                        No Records Found.
                                                                    </NoRecordsTemplate>
                                                                    <Columns>
                                                                        <%--<telerik:GridBoundColumn HeaderText="GROUP" DataField="GROUP"
                                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="110px" 
                                                                HeaderTooltip="Group Of Item">
                                                            </telerik:GridBoundColumn>--%>
                                                                        <telerik:GridBoundColumn HeaderText="ITEM" DataField="ITEM"
                                                                            ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="120px" FilterControlWidth="120px"
                                                                            HeaderTooltip="Name Of Item" ItemStyle-Font-Size="Smaller">
                                                                        </telerik:GridBoundColumn>
                                                                        <%-- <telerik:GridBoundColumn HeaderText="MONTH" DataField="MONTH"
                                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="95px" FilterControlWidth="60px"
                                                                HeaderTooltip="First Two Digits Is Year and Next Two Digits Is Month">
                                                            </telerik:GridBoundColumn>--%>
                                                                        <telerik:GridBoundColumn HeaderText="Yesterday" DataField="Yesterday"
                                                                            ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                                            HeaderTooltip="Yesterday Purchased Rate" ItemStyle-Font-Size="Smaller">
                                                                        </telerik:GridBoundColumn>


                                                                    </Columns>

                                                                </MasterTableView>

                                                            </telerik:RadGrid>
                                                        </td>

                                                    </tr>

                                                </table>
                                            </td>

                                        </tr>
                                    </table>
                                    <br />
                                    <br />
                                </td>

                            </tr>

                        </table>
                        <br />
                        <br />
                    </div>
                </div>
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="BtnExcelExport" />
            <asp:AsyncPostBackTrigger ControlID="drpGroup" />
            <asp:AsyncPostBackTrigger ControlID="drpItem" />
            <asp:AsyncPostBackTrigger ControlID="BtnSearch" />
            <asp:AsyncPostBackTrigger ControlID="ChkDontShow" EventName="CheckedChanged" />
            <asp:AsyncPostBackTrigger ControlID="ChkYeterday" EventName="CheckedChanged" />
            <asp:AsyncPostBackTrigger ControlID="yesterdaySearch" />
            <asp:PostBackTrigger ControlID="rgVegList" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>


</asp:Content>

