<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="KitchenCharts.aspx.cs" Inherits="KitchenCharts" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .btn {
            color: white;
            background-color: darkblue;
            font-family: Verdana;
        }

        .Grid {
            width: 300px;
            margin: 5px 0 10px 0;
            border: solid 1px #525252;
            border-collapse: collapse;
            font-family: Verdana;
            color: #474747;
            width: 250px;
        }

            .Grid td {
                padding: 2px;
                border: solid 1px #c1c1c1;
                font-family: Verdana;
            }

            .Grid th {
                padding: 4px 2px;
                color: #fff;
                background: darkblue url(Images/grid-header.png) repeat-x top;
                border-left: solid 1px #525252;
                font-size: 0.9em;
                font-family: Verdana;
            }

            .Grid .alt {
                background: #fcfcfc url(Images/grid-alt.png) repeat-x top;
            }

            .Grid .pgr {
                background: #363670 url(Images/grid-pgr.png) repeat-x top;
            }

                .Grid .pgr table {
                    margin: 3px 0;
                    font-family: Verdana;
                }

                .Grid .pgr td {
                    border-width: 0;
                    padding: 0 6px;
                    border-left: solid 1px #666;
                    font-weight: bold;
                    color: #fff;
                    line-height: 12px;
                    font-family: Verdana;
                }

                .Grid .pgr a {
                    color: Gray;
                    text-decoration: none;
                    font-family: Verdana;
                }

                    .Grid .pgr a:hover {
                        color: #000;
                        text-decoration: none;
                        font-family: Verdana;
                    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="main_cnt">
                <div class="first_cnt" style="min-height: 450px">
                    <div style="font-family: Verdana; font-size: small;">

                        <div>
                            <script type="text/javascript" src="https://www.google.com/jsapi"></script>



                          
                            <div align="center">
                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" Text="Kitchen Purchase Rate Chart" ToolTip="Kitchen Purchase Rate Chart"></asp:LinkButton>
                            </div>
                           
                            <div>
                                <table>
                                    <tr>
                                        <td>
                                            <b>
                                                <asp:Label ID="lblGroup" runat="server" Text="Group : "></asp:Label></b>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblGrpShow" runat="server" Text="-"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <b>
                                                <asp:Label ID="lblItem" runat="server" Text="Item : "></asp:Label></b>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblItmShow" runat="server" Text="-"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <b>
                                                <asp:Label ID="lblMonth" runat="server" Text="Month : "></asp:Label></b>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblmntShow" runat="server" Text="-"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <b>
                                                <asp:Label ID="lblAvgValue" runat="server" Text="3 Month Avg. Rate in Rs. : " ToolTip="Average rate of purchase for the selected item in the threee months prior to the current billing month."></asp:Label></b>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblAvgValueShow" runat="server" Text="-"></asp:Label>
                                        </td>
                                          <td rowspan="1" style="padding-left:400px;">
                                             <asp:Button ID="btnReturn2" runat="Server" Width="100px" Text="Return" ToolTip="Click here to return to the Kitchen purchase list" ForeColor="White" BackColor=" DarkBlue " Font-Names="Verdana" Font-Size="Small" OnClick="btnReturn2_Click" />
                                        </td>
                                    </tr>
                                </table>


                            </div>

                            <div>
                                <table>
                                    <tr>
                                        <td>
                                           <b><asp:Label ID="lblLabelRate" runat="server" Text="-" Font-Names="verdana" Font-Size="Small" ForeColor="Blue" Font-Bold="true"></asp:Label></b> 
                                            <asp:Literal ID="ltrscr" runat="server"></asp:Literal>
                                            <div id="chart_div" style="width: 600px; height: 300px;">
                                        </td>
                                        <td>
                                             <b><asp:Label ID="lblLabelQuantity" runat="server" Text="-" Font-Names="verdana" Font-Size="Small" ForeColor="Blue" Font-Bold="true"></asp:Label></b>
                                            <asp:Literal ID="ltrscr1" runat="server"></asp:Literal>
                                            <div id="chart_div1" style="width: 600px; height: 300px;">
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <div>
                          <b><asp:Label ID="lblRate" Font-Names="verdana" Font-Size="Medium" ForeColor="Blue" Font-Bold="true" runat="server" Text="Rate in Rs.:"></asp:Label></b>
                            </div>
                                <div align="center">
                                <telerik:RadGrid ID="grdview" runat="server" AutoPostBack="true"
                                    AutoGenerateColumns="False" AllowSorting="True" AllowFilteringByColumn="false"
                                    Width="1190px" Skin="Web20" Height="70px">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True"  SaveScrollPosition="true" UseStaticHeaders="True" />
                                    </ClientSettings>
                                    <MasterTableView ShowHeadersWhenNoRecords="true">
                                        <NoRecordsTemplate>
                                            No Records Found.
                                        </NoRecordsTemplate>
                                        <Columns>
                                            <telerik:GridBoundColumn HeaderText="GROUP" DataField="GROUP" Visible="false"
                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="110px"
                                                HeaderTooltip="Group Of Item">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="ITEM" DataField="ITEM" UniqueName="ITEMCode"
                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="110px" Visible="false">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="MONTH" DataField="MONTH"
                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false" HeaderStyle-Width="95px" FilterControlWidth="60px"
                                                HeaderTooltip="First Two Digits Is Year and Next Two Digits Is Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="01" DataField="1"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="First Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="02" DataField="2"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Second Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="03" DataField="3"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Third Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="04" DataField="4"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Fourth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="05" DataField="5"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Fifth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="06" DataField="6"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Sixth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="07" DataField="7"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Seventh Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="08" DataField="8"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Eighth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="09" DataField="9"
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
                                <%-- <asp:GridView ID="grdview" runat="server" CssClass="Grid" Width="1190px" ></asp:GridView>--%>
                            </div>
                            <div>
                           <b><asp:Label ID="lblQty" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Blue" Font-Bold="true" Text="Quantity:"></asp:Label></b>                          
                            </div>
                                <div align="center">
                                <telerik:RadGrid ID="rgQuantity" runat="server" AutoPostBack="true"
                                    AutoGenerateColumns="False" AllowSorting="True" AllowFilteringByColumn="false"
                                    Width="1190px" Skin="Web20" Height="70px">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />
                                    </ClientSettings>
                                    <MasterTableView ShowHeadersWhenNoRecords="true">
                                        <NoRecordsTemplate>
                                            No Records Found.
                                        </NoRecordsTemplate>
                                        <Columns>
                                            <telerik:GridBoundColumn HeaderText="GROUP" DataField="GROUP" Visible="false"
                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="110px"
                                                HeaderTooltip="Group Of Item">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="ITEM" DataField="ITEM" Visible="false" UniqueName="ITEMCode"
                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="110px">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="MONTH" DataField="MONTH" Visible="false"
                                                ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="95px" FilterControlWidth="60px"
                                                HeaderTooltip="First Two Digits Is Year and Next Two Digits Is Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="01" DataField="Q1"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="First Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="02" DataField="Q2"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Second Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="03" DataField="Q3"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Third Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="04" DataField="Q4"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Fourth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="05" DataField="Q5"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Fifth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="06" DataField="Q6"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Sixth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="07" DataField="Q7"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Seventh Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="08" DataField="Q8"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Eighth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="09" DataField="Q9"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Ninth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="10" DataField="Q10"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Tenth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="11" DataField="Q11"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Eleventh Day Of The Month">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn HeaderText="12" DataField="Q12"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twelth Day Of The Month">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn HeaderText="13" DataField="Q13"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Thirteenth Day Of The Month">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn HeaderText="14" DataField="Q14"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Fourteenth Day Of The Month">
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn HeaderText="15" DataField="Q15"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Fifteenth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="16" DataField="Q16"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Sixteenth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="17" DataField="Q17"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Seventeenth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="18" DataField="Q18"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Eighteenth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="19" DataField="Q19"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Nineteenth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="20" DataField="Q20"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twentieth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="21" DataField="Q21"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twenty First Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="22" DataField="Q22"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twenty Second Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="23" DataField="Q23"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twenty Third Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="24" DataField="Q24"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twenty Fourth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="25" DataField="Q25"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twenty Fifth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="26" DataField="Q26"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twenty Sixth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="27" DataField="Q27"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twenty Seventh Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="28" DataField="Q28"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twenty Eighth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="29" DataField="Q29"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Twenty Ninth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="30" DataField="Q30"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Thirtieth Day Of The Month">
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="31" DataField="Q31"
                                                ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" HeaderStyle-Width="60px"
                                                HeaderTooltip="Thirty First Day Of The Month">
                                            </telerik:GridBoundColumn>

                                        </Columns>

                                    </MasterTableView>

                                </telerik:RadGrid>
                                <%-- <asp:GridView ID="grdview" runat="server" CssClass="Grid" Width="1190px" ></asp:GridView>--%>
                            </div>

                             <div>
                                <table >
                                    <tr>
                                        <td style="width:5%">

                                        </td>
                                        <td >
                                          <b>.</b>   <asp:Label ID="Label1" Font-Size="XX-Small" Font-Names="verdana" Font-Bold="true" runat="server" Text="* (Star) indicates that the purchase rate is higher than the 3 month average rate on that date."></asp:Label>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:5%">

                                        </td>
                                        <td>
                                         <b>.</b>   <asp:Label ID="Label2" Font-Size="XX-Small" Font-Bold="true" Font-Names="verdana" runat="server" Text="Only the dates where a purchase has been made, are shown."></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width:5%">

                                        </td>
                                        <td>
                                         <b>.</b>   <asp:Label ID="Label3" Font-Size="XX-Small" Font-Bold="true" Font-Names="verdana" runat="server" Text="Place the cursor in a graph point to view the Rate / Quantity."></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                            
                           


                        </div>
                    </div>
                </div>
            </div>

        </ContentTemplate>

    </asp:UpdatePanel>

</asp:Content>

