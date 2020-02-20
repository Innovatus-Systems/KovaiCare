<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MonthlyStatement.aspx.cs" Inherits="MonthlyStatement" EnableEventValidation="false" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="pnlMain" runat="server" Height="100%">
        <div class="main_cnt">
            <div class="first_cnt">              
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="LblFromDate" runat="Server" Text="Date From" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                <%--<asp:Label ID="Label2" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>--%>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="FromDate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Pick the Billing Date."
                                    Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput ID="DateInput1" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                    </DateInput>
                                    <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                        <SpecialDays>
                                            <telerik:RadCalendarDay Repeatable="Today">
                                                <ItemStyle BackColor="bisque" />
                                            </telerik:RadCalendarDay>
                                        </SpecialDays>
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </td>
                            <td>
                                <asp:Label ID="LblToDate" runat="Server" Text="Untill" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                <%--<asp:Label ID="Label3" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>--%>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="ToDate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Pick the Billing Date."
                                    Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput ID="DateInput2" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                    </DateInput>
                                    <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                        <SpecialDays>
                                            <telerik:RadCalendarDay Repeatable="Today">
                                                <ItemStyle BackColor="bisque" />
                                            </telerik:RadCalendarDay>
                                        </SpecialDays>
                                    </Calendar>
                                </telerik:RadDatePicker>
                            </td>
                            <%-- <td style="width: 20px"></td>--%>
                            <td>
                                <asp:Label ID="lblVillaNo" runat="Server" Text="Resident Name & VillaNo" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                <%-- <asp:Label ID="Label14" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>--%>
                            </td>
                            <td>

                                <asp:DropDownList ID="ddlVillaNo" Width="300px" ToolTip="*Select Name and VillaNo." runat="server"
                                    Font-Names="Verdana" AutoPostBack="true" Font-Size="Small">
                                </asp:DropDownList>
                            </td>
                            <td></td>

                            <%-- <td style="width: 20px"></td>--%>
                            <td style="right: auto">

                                <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to Show Monthly Statement." AutoPostBack="true" Text="Show" ForeColor="Blue" OnClick="BtnShow_Click"></asp:Button>
                                <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Print to PDF" ForeColor="White" Visible="False" OnClick="btnExport_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <asp:Panel runat="server" ID="pnlStatementDet" Height="100%"  Visible="false" BackColor="Wheat">
                        <table>
                            <tr>
                                <td style="width: 200px">
                                    <asp:Label ID="lblHeading" runat="server" Text="ORIS" Font-Size="Medium" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 300px">
                                    <asp:Label ID="Label1" runat="server" Text="Monthly Statement" Font-Size="Medium" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 300px">
                                    <asp:Label ID="lblFromDt" runat="server" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                    <asp:Label ID="Label5" runat="server" Text="to" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                    <asp:Label ID="lblToDt" runat="server" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>

                            </tr>
                            <tr>
                                <td></td>
                                <td></td>

                                <td style="width: 300px">
                                    <asp:Label ID="Label13" runat="server" Text="Printed On : " Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                    <asp:Label ID="lblPrintedOn" runat="server" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>


                            </tr>
                        </table>
                        <table>

                            <tr>
                                <td style="width: 200px">
                                    <asp:Label ID="Label2" runat="server" Text="Villa" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 100px">
                                    <asp:Label ID="lblVilla" runat="server" Text="Villa" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    <asp:Label ID="Label3" runat="server" Text="Resident" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 100px">
                                    <asp:Label ID="lblResident" runat="server" Text="Resident" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    <asp:Label ID="Label4" runat="server" Text="Status" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 100px">
                                    <asp:Label ID="lblStatus" runat="server" Text="Status" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    <asp:Label ID="Label12" runat="server" Text="Email" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 100px">
                                    <asp:Label ID="lblEmail" runat="server" Text="Email" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td style="width: 200px">
                                    <asp:Label ID="Label15" runat="server" Text="Mobile" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 100px">
                                    <asp:Label ID="lblMobile" runat="server" Text="Mobile" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>
                        </table>

                        <br />
                        <table>
                            <tr>
                                <td style="width: 200px">
                                    <asp:Label ID="Label8" runat="server" Text="Name of incharge" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 500px">
                                    <asp:Label ID="lblIncharge" runat="server" Text="Incharge" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    <asp:Label ID="Label9" runat="server" Text="Name of community" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 500px">
                                    <asp:Label ID="lblCommunity" runat="server" Text="Community" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 200px">
                                    <asp:Label ID="Label10" runat="server" Text="Payment instructions" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td style="width: 500px">
                                    <asp:Label ID="lblInstruction" runat="server" Text="Instruction" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table>
                            <tr>
                                <td style="width: 505px">
                                    <asp:Label ID="Label6" runat="server" Text="Amount payable" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblAmountPay" runat="server" Text="AmountPay" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>

                            </tr>
                            <tr>
                                <td style="width: 505px">
                                    <asp:Label ID="Label7" runat="server" Text="Kindly make arrangements to pay the outstanding on or before" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblOutDt" runat="server" Text="OutDt" Font-Size="Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Transactions during the billing period" Font-Size="Small" Font-Names="Calibri"></asp:Label><br />
                                    <asp:Label ID="Label22" runat="server" Text="*Wherever Rate & Count are present, debit amount is auto calculated" Font-Size="X-Small" Font-Names="Calibri"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 800px; height: 60px; vertical-align: top;">
                                    <telerik:RadGrid ID="rdgMonthlyStat" runat="server" AutoPostBack="true" 
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="False" ShowFooter="true"
                                        CellSpacing="5" Width="99%" Height="300px">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="false" UseStaticHeaders="false" />
                                        </ClientSettings>
                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                        <MasterTableView AllowCustomPaging="false">
                                            <NoRecordsTemplate>
                                                No Records Found.
                                            </NoRecordsTemplate>

                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Wrap="true" Visible="true"
                                                    ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Code" DataField="Code" HeaderStyle-Wrap="true" ItemStyle-Width="20px"
                                                    ItemStyle-Wrap="true" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="left"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Narration" DataField="Narration" HeaderStyle-Wrap="false" ItemStyle-Width="75px"
                                                    ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Txn Type" DataField="TxnType" HeaderStyle-Wrap="false" Visible="true"
                                                    ItemStyle-Wrap="false" AllowFiltering="False" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="75px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Rate" DataField="Rate" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="50px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Debit" DataField="Debit" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="50px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Credit" DataField="Credit" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="30px"
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
                     

                        


                    </asp:Panel>



                   <%-- <asp:Panel ID="pnlPerson" runat="server">
                        <table border="1" style="font-family: Arial; font-size: 10pt; width: 200px">
                            <tr>
                                <td colspan="2" style="background-color: #18B5F0; height: 18px; color: White; border: 1px solid white">
                                    <b>Personal Details</b>
                                </td>
                            </tr>
                            <tr>
                                <td><b>Name:</b></td>
                                <td>
                                    <asp:Label ID="lblName" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td><b>Age:</b></td>
                                <td>
                                    <asp:Label ID="lblAge" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td><b>City:</b></td>
                                <td>
                                    <asp:Label ID="lblCity" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td><b>Country:</b></td>
                                <td>
                                    <asp:Label ID="lblCountry" runat="server"></asp:Label></td>
                            </tr>
                        </table>
                    </asp:Panel>--%>
                
            </div>

        </div>
    </asp:Panel>
</asp:Content>
