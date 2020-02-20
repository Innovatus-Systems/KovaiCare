<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DiningHealthCheck.aspx.cs" Inherits="DiningHealthCheck" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        GHtable {
            border-style: solid;
            border-width: 1px;
            border-color: gray;
        }

        tr.GHForTR td {
            border-style: solid;
            border-color: white;
            border-width: 1px;
            padding: 5px;
            /*background-color: #00BF9A;*/
            background-color: #E2DFA2;
            /*background-color: #AEBD38;*/
            color: black;
            font-family: Verdana;
            font-size: small;
        }

        tr.test td {
            border-style: solid;
            border-color: white;
            border-width: 1px;
            padding: 5px;
            /*background-color: #008975;*/
            background-color: #A1BE95;
            color: black;
        }
    </style>

    <script type="text/javascript">
        function Validate() {



            var result = confirm('Do you want to update?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }


        }





    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>


                    <table style="width: 100%;">

                        <tr>
                            <td align="center">
                                <asp:HiddenField ID="CnfResult" runat="server" />
                                <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:10px"></tr>
                        <tr>
                            <td>

                                <%--<asp:Label ID="Label59" runat="server" Text="Shows dining confirmation pending details. Please confirm all pending details,for generating month end bill." CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label><br />--%>
                                <asp:Label ID="Label1" runat="server" Text="Shows dining confirmation pending details. To generate month end bill, please confirm all pending details." CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label><br />
                            </td>
                        </tr>
                        <tr style="height:10px"></tr>
                        <tr>
                            <td align="left">
                                <text style="font-family: Verdana; font-weight: bold; font-size: small;"> Billing Peroid :</text>
                                &nbsp;
                                <asp:DropDownList ID="ddlBilling" ToolTip="Current billing period" runat="server" Width="150px" Height="25px" AutoPostBack="true" OnSelectedIndexChanged="ddlBilling_SelectedIndexChanged" Enabled="false"></asp:DropDownList>
                                &nbsp;&nbsp;&nbsp;
                                <text style="font-family: Verdana; font-weight: bold; font-size: small;"> Type :</text>

                                <asp:DropDownList ID="ddlType" ToolTip="Select diners type to show confirmation pending details" CssClass="ddl" runat="server"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" Width="150px" Height="25px">
                                    <asp:ListItem Text="Regular" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Casual" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </td>


                        </tr>


                        <tr>
                            <td>
                                <table style="width: 100%; margin-left: auto; margin-right: auto; border-collapse: collapse; border: inset">
                                    <tr>
                                        <td style="width: 100%;">
                                            <table style="width: 80%;" class="GHtable" valign="top">



                                                <tr class="GHForTR">

                                                    <td style="width: 350px">
                                                        <text style="font-family: Verdana; font-size: small;"> Total number of residents</text>
                                                    </td>
                                                    <td style="width: 200px">
                                                        <asp:Label runat="server" ID="txtResTot" Style="font-family: Verdana; font-size: small;"> </asp:Label>
                                                    </td>

                                                    <td style="width: 350px">
                                                        <text style="font-family: Verdana; font-size: small;"> Total number of diners</text>
                                                    </td>
                                                    <td style="width: 200px">
                                                        <asp:Label runat="server" ID="txtDinTot" Style="font-family: Verdana; font-size: small;"> </asp:Label>
                                                    </td>
                                                </tr>
                                                <tr class="GHForTR">

                                                    <td style="width: 350px">
                                                        <text style="font-family: Verdana; font-size: small;">Regular diners </text>
                                                    </td>
                                                    <td style="width: 200px">
                                                        <asp:Label runat="server" ID="txtRDTot" Style="font-family: Verdana; font-size: small;"> </asp:Label>
                                                    </td>

                                                    <td style="width: 350px">
                                                        <text style="font-family: Verdana; font-size: small;">Casual diners</text>
                                                    </td>
                                                    <td style="width: 200px">
                                                        <asp:Label runat="server" ID="txtCDTot" Style="font-family: Verdana; font-size: small;"> </asp:Label>
                                                    </td>
                                                </tr>
                                                <%--  <tr class="GHForTR">

                                            <td style="width: 350px">
                                                <text style="font-family: Verdana; font-size: small;">Guest  </text>
                                            </td>
                                            <td style="width: 200px">
                                                <asp:Label runat="server" ID="txtGuestTot" Style="font-family: Verdana; font-size: small;"> </asp:Label>
                                            </td>

                                            <td style="width: 350px">
                                                <text style="font-family: Verdana; font-size: small;"> Home service</text>
                                            </td>
                                            <td style="width: 200px">
                                                <asp:Label runat="server" ID="txtHSTot" Style="font-family: Verdana; font-size: small;"> </asp:Label>
                                            </td>
                                        </tr>--%>
                                                <%--  <tr class="GHForTR">

                                                    <td style="width: 350px">
                                                        <text style="font-family: Verdana; font-size: small;"> Booked </text>
                                                    </td>
                                                    <td style="width: 200px">
                                                        <text style="font-family: Verdana; font-size: small;"> </text>
                                                    </td>

                                                    <td style="width: 350px">
                                                        <text style="font-family: Verdana; font-size: small;"> Actuals</text>
                                                    </td>
                                                    <td style="width: 200px">
                                                        <text style="font-family: Verdana; font-size: small;"> </text>
                                                    </td>
                                                </tr>--%>
                                            </table>
                                        </td>





                                    </tr>
                                </table>

                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" ID="txtHSTot" Style="font-family: Verdana; font-size: small;"> </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1200px; height: 185px; vertical-align: top;">


                                            <telerik:RadGrid ID="ReportList" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="false" runat="server" AutoGenerateColumns="false" Height="350px"
                                                Width="1100px" AllowFilteringByColumn="false" AllowPaging="false">
                                                <ClientSettings>

                                                    <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                </ClientSettings>
                                                <MasterTableView AllowFilteringByColumn="false">
                                                    <Columns>
                                                        <telerik:GridBoundColumn HeaderText="RSN" ItemStyle-Width="30px" HeaderStyle-Width="30px" DataField="RSN" ReadOnly="true" AllowFiltering="false" Display="false"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Door No." ItemStyle-Width="80px" HeaderStyle-Width="80px" DataField="VillaNo" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Name" ItemStyle-Width="130px" HeaderStyle-Width="130px" DataField="Name" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Date" ItemStyle-Width="80px" HeaderStyle-Width="80px" DataField="SDate" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="Session" ItemStyle-Width="80px" HeaderStyle-Width="80px" DataField="Session" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn HeaderText="R/C" ItemStyle-Width="30px" HeaderStyle-Width="30px" DataField="Type" ReadOnly="true" AllowFiltering="false" HeaderTooltip=" R - Regular / C - Casual" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>

                                                        <telerik:GridBoundColumn HeaderText="Diners" HeaderStyle-Width="50px" DataField="Diners" ReadOnly="true" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Booked Diners"></telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="All" ItemStyle-Wrap="false" AllowFiltering="false"
                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px" HeaderTooltip=" ">
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkRegularBAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkRegularBAll_CheckedChanged" Checked="false" ToolTip="Select to confirm - Diners." />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="ChkRegularBConfirm" runat="server" Checked="false"></asp:CheckBox>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn HeaderText="Guest" HeaderStyle-Width="50px" DataField="GuestB" ReadOnly="true" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Booked Guest"></telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="All" ItemStyle-Wrap="false" AllowFiltering="false"
                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px" HeaderTooltip=" ">
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkGuestBAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkGuestBAll_CheckedChanged" Checked="false" ToolTip="Select to confirm - Guest." />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="ChkGuestBConfirm" runat="server" Checked="false"></asp:CheckBox>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridBoundColumn HeaderText="HService" HeaderStyle-Width="50px" DataField="HomeServiceB" ReadOnly="true" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Booked Home Service"></telerik:GridBoundColumn>

                                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="All" ItemStyle-Wrap="false" AllowFiltering="false"
                                                            ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20px" HeaderStyle-Width="20px" HeaderTooltip=" ">
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkHServiceBAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkHServiceBAll_CheckedChanged" Checked="false" ToolTip="Select to confirm - Home Service." />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="ChkHServiceBConfirm" runat="server" Checked="false"></asp:CheckBox>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>


                                                    </Columns>
                                                </MasterTableView>
                                            </telerik:RadGrid>



                                        </td>
                                        <td valign="top">
                                            <asp:Button ID="btnUpdate" runat="Server" Width="100px" Text="Update" ToolTip="Click here to update the selected records" ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnUpdate_Click" OnClientClick="javascript:return Validate()" />
                                        </td>
                                    </tr>
                                </table>



                            </td>
                        </tr>
                    </table>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <%-- <asp:PostBackTrigger ControlID="btnClear" />
                    <asp:PostBackTrigger ControlID="ddlDinersSession" />
                    <asp:PostBackTrigger ControlID="btnExit" />
                    <asp:PostBackTrigger ControlID="btnDiningBooking" />--%>
                    <%--<asp:PostBackTrigger ControlID="btnOneTouchUpdate" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

