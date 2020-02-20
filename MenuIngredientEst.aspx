<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MenuIngredientEst.aspx.cs" Inherits="MenuIngredientEst" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                                    <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <%--<br />--%>
                        <table style="width:75%">

                            <tr>
                                <td style="width: 10px"></td>
                                <td style="vertical-align: top">

                                    <asp:Label ID="Label5" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="false" Text="Date :"></asp:Label>
                                    <telerik:RadDatePicker ID="dtpmenuforday" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="180px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date." AutoPostBack="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>

                                    &nbsp;&nbsp;&nbsp;
                                    
                                    <asp:Label ID="Label6" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="false" Text="Session :"></asp:Label>
                                    <asp:DropDownList ID="ddlDinersSession" Width="150px" CssClass="ddl" ToolTip="Choose the session." runat="server"
                                        AutoPostBack="true">
                                    </asp:DropDownList>
                                    &nbsp;&nbsp;&nbsp; 

                                    
                                     <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search" ToolTip="Click here to show menu & ingredient estimate details." Width="90px" ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" />
                                    <asp:Button ID="Button1"  runat="server" Text="Export to PDF" ToolTip="" Width="90px" ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Visible="false" />
                                </td>
                                <td>
                                      <table id="tblBDet" runat="server" visible="false">
                                <%--<tr>
                                    <td style="width: 10px"></td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="false" Text="Booked Details :"></asp:Label>
                                    </td>
                                </tr>--%>
                                <tr>
                                 
                                    <td>


                                        <telerik:RadGrid ID="rgDinersTotal" runat="server" Skin="WebBlue" GridLines="None"
                                            AutoGenerateColumns="False" AllowSorting="True" Font-Size="Small">
                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="false">
                                                <PagerStyle Mode="NextPrevAndNumeric" />
                                                <RowIndicatorColumn>
                                                    <HeaderStyle Width="10px"></HeaderStyle>
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn>
                                                    <HeaderStyle Width="10px"></HeaderStyle>
                                                </ExpandCollapseColumn>

                                                <Columns>

                                                    <telerik:GridBoundColumn DataField="Regular" HeaderText="Regular" UniqueName="Regular"
                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Casual" HeaderText="Casual" UniqueName="Casual"
                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Guest" HeaderText="Guest" UniqueName="Guest"
                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn DataField="Total" HeaderText="Total" UniqueName="Total"
                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
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
                       <%-- <br />
                        <br />--%>

                        <asp:Panel ID="pnlShowDet" runat="server" Visible="false">

                          

                            <%--<br />--%>
                            <table>
                               <%-- <tr>
                                    <td style="width: 10px"></td>
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="false" Text="Menu Details :"></asp:Label>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td style="width: 10px"></td>
                                    <td style="vertical-align: top">
                                        <table>
                                            <tr>


                                                <td style="vertical-align: top">
                                                    <telerik:RadGrid ID="rdgMenuDetails" runat="server" Skin="WebBlue" GridLines="None" Width="880px"
                                                        AutoGenerateColumns="False" AllowSorting="True" Font-Size="Small">

                                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="false">
                                                            <PagerStyle Mode="NextPrevAndNumeric" />
                                                            <RowIndicatorColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </RowIndicatorColumn>
                                                            <ExpandCollapseColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </ExpandCollapseColumn>
                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="ItemName" HeaderText="Menu" UniqueName="ItemName"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Remarks" HeaderText="Description" UniqueName="Remarks"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="ServeQty" HeaderText="Serv Qty." UniqueName="ServeQty"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                </telerik:GridBoundColumn>
                                                                 <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" UniqueName="UOM"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Total" HeaderText="Est Qty." UniqueName="Total"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
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

                            <%--<br />--%>
                            <table>
                                <tr>
                                    <td style="width: 10px"></td>
                                    <td>
                                       <%-- <asp:Label ID="Label4" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="false" Text="View / Hide" ToolTip="Click here to view / hide the provision details."></asp:Label>--%>
                                        <asp:LinkButton ID="lnkViewHide" runat="server" Font-Names="verdana" Font-Size="X-Small" ForeColor="Blue" Font-Bold="false" Text="View / Hide" ToolTip="Click here to view / hide the provision details." OnClick="lnkViewHide_Click"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10px"></td>
                                    <td style="vertical-align: top">
                                        <table>
                                            <tr>


                                                <td style="vertical-align: top">
                                                    <telerik:RadGrid ID="rdgRawMaterial" runat="server" Skin="Sunset" GridLines="None" Width="880px"
                                                        AutoGenerateColumns="False" AllowSorting="True" Font-Size="Small">

                                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="false">
                                                            <PagerStyle Mode="NextPrevAndNumeric" />
                                                            <RowIndicatorColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </RowIndicatorColumn>
                                                            <ExpandCollapseColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </ExpandCollapseColumn>
                                                            <Columns>

                                                                <telerik:GridBoundColumn DataField="TMenu" HeaderText="Menu" UniqueName="TMenu"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" >
                                                                </telerik:GridBoundColumn>                                                                
                                                                <telerik:GridBoundColumn DataField="TOutQty" HeaderText="For" UniqueName="TOutQty" HeaderTooltip="In order to prepare this much quantity of the stated menu item, how much ingredient is required."
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small" ItemStyle-ForeColor="DarkBlue">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="TOutUOM" HeaderText="UOM" UniqueName="TOutUOM" 
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small" ItemStyle-ForeColor="DarkBlue">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="TRawMaterial" HeaderText="Provisions" UniqueName="TRawMaterial"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="TInQty" HeaderText="Est." UniqueName="TInQty"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small" ItemStyle-ForeColor="DarkBlue">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="TInUOM" HeaderText="UOM" UniqueName="TInUOM"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="X-Small" HeaderStyle-Font-Size="X-Small" ItemStyle-ForeColor="DarkBlue">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="TEstimateQty" HeaderText="To Issue" UniqueName="TEstimateQty" HeaderTooltip="Estimated quantity for issue to kitchen based on the diners count, serve quantity per diner."
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="TUOM" HeaderText="UOM" UniqueName="TUOM"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
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

                        </asp:Panel>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <%--<asp:PostBackTrigger ControlID="BtnnExcelExport" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

