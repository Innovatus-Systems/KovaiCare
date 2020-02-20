<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="FoodBillPosting.aspx.cs" Inherits="Account_FoodBillPosting" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

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

            var result = confirm('Are you sure, you want to save?');

            if (result) {
                document.getElementById('<%=HResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=HResult.ClientID%>').value = "false";
                return false;
            }

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="main_cnt">
        <div class="first_cnt">
            <div>

                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblLevel" runat="server" Text="Group Billing" ForeColor="Blue" Font-Bold="true" Font-Names="Verdana"></asp:Label>
                        </td>
                        <td style="width: 25px"></td>
                        <td style="background-color: lightgray">
                            <asp:RadioButton ID="rbYetToBill" AutoPostBack="true" GroupName="CB" Checked="true" runat="server" OnCheckedChanged="rbBilled_OnCheckedChange" ToolTip="Shows sessions for which group billing is not yet done." />
                            <asp:Label ID="Label5" runat="Server" Text=" Yet to be Billed ," ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                            <asp:RadioButton ID="rbBilled" AutoPostBack="true" GroupName="CB" Checked="false" runat="server" OnCheckedChanged="rbBilled_OnCheckedChange" ToolTip="Shows sessions for which a group billing is already done. You can use the Group Billing Option only once for a session for a day." />
                            <asp:Label ID="Label4" runat="Server" Text=" Billed" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>


                        </td>

                        <td style="width: 50px"></td>

                        <%--  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp--%>
                        <td>
                            <asp:Label ID="LblBillingDate" runat="Server" Text="Billing Date :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>



                            <telerik:RadDatePicker ID="BillingDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip=" This date cannot be a future date and must be within the current billing period." AutoPostBack="true" OnSelectedDateChanged="BillingDate_Changed">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>
                            <%--<telerik:RadDatePicker ID="BillingDate" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick the billing start date." AutoPostBack="true"
                                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" OnSelectedDateChanged="BillingDate_Changed">
                                                            <DatePopupButton></DatePopupButton>
                                                            <DateInput ID="DateInput2" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                                                            </DateInput>
                                                            <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle BackColor="bisque" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDatePicker>--%>

                            <%--  <telerik:RadDatePicker ID="BillingDate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Pick the Billing Date." AutoPostBack="true"
                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                <DatePopupButton></DatePopupButton>
                                <DateInput ID="DateInput1" DateFormat="ddd dd-MMM-yy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                </DateInput>
                                <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                    <SpecialDays>
                                        <telerik:RadCalendarDay Repeatable="Today">
                                            <ItemStyle BackColor="bisque" />
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>
                                </Calendar>
                            </telerik:RadDatePicker>--%>
                            &nbsp;&nbsp;&nbsp
                                     <asp:Label ID="Label1" runat="Server" Text="For Session :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:DropDownList ID="ddlSession" Width="175px" ToolTip="Select the session name. See tool tip for Yet to be billed and Billed." runat="server"
                                Font-Names="Verdana" AutoPostBack="true" Font-Size="Small" OnSelectedIndexChanged="ddlSession_SelectedIndexChanged">
                            </asp:DropDownList>
                            &nbsp;&nbsp;&nbsp
                                    <asp:Label ID="Label2" runat="Server" Text="Rate :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="lblSessionRate" runat="Server" Text="" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        </td>
                    </tr>
                    <table>
                        <tr><td>
                            <asp:Label ID="Label6" runat="server" Text="Here you can bill all residents for a session(Ex: breakfast, Lunch) in one lot saving your time.   Remember to check the count of persons per Door No.   If you forget some one, or if you wish to bill guests / staff use the individual billing option. " ForeColor="Gray" Font-Bold="true" Font-Names="Verdana" Font-Size="X-Small"></asp:Label>
                            </td></tr>
                    </table>
                    <tr>
                        <td></td>
                    </tr>

                </table>
                <br />

                <asp:Panel ID="pnlYetToBill" runat="server" Visible="true">

                    <table>
                        <tr>
                            <td style="width: 1200px; vertical-align: top; height: 350px">
                                <telerik:RadGrid ID="FoodBillingListView" runat="server" AllowPaging="False"
                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="true" ShowFooter="true"
                                    OnItemCommand="FoodBillingListView_ItemCommand" CellSpacing="5" Width="97%" CellPadding="20" MasterTableView-HierarchyDefaultExpanded="true">

                                    <HeaderContextMenu CssClass="table table-bordered table-hover">
                                    </HeaderContextMenu>

                                    <MasterTableView AllowCustomPaging="false" AllowPaging="false">
                                        <NoRecordsTemplate>
                                            No Records Found.
                                        </NoRecordsTemplate>
                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                        <RowIndicatorColumn>
                                            <HeaderStyle Width="0px"></HeaderStyle>
                                        </RowIndicatorColumn>
                                        <ExpandCollapseColumn>
                                            <HeaderStyle Width="0px"></HeaderStyle>
                                        </ExpandCollapseColumn>
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="All" HeaderText="All" ItemStyle-Wrap="false" AllowFiltering="false"
                                                ItemStyle-HorizontalAlign="Center" ItemStyle-Width="5px" HeaderTooltip="Uncheck a resident if you do not wish to include him/her in the group billing.">
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" Checked="true" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="ChkConfirm" ToolTip="Tick here for confirm billing." runat="server" Checked="true"></asp:CheckBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn HeaderText="" DataField="RTRSN" HeaderStyle-Wrap="false" Visible="true" ItemStyle-ForeColor="LightGray"
                                                ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="1px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Villa No" DataField="RTVILLANO" HeaderStyle-Wrap="false"
                                                ItemStyle-Wrap="false" AllowFiltering="FALSE" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Status" DataField="RTStatus" HeaderStyle-Wrap="false" ItemStyle-Width="20px"
                                                ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Left" Visible="true"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false" Visible="true"
                                                ItemStyle-Wrap="false" AllowFiltering="FALSE" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="75px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>


                                            <%-- <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                    HeaderText="Billing Code" HeaderStyle-Font-Names="" UniqueName="BillingCode" SortExpression="" AllowFiltering="false">

                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlBillingCode" Width="100px" ToolTip="*Select the Billing Code." Height="25px" runat="server"
                                                            Font-Names="Verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlBillingCode_SelectedIndexChanged" Font-Size="XX-Small">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                    HeaderText="Rate" HeaderStyle-Font-Names="" UniqueName="BCodeRate" SortExpression="BCrate" AllowFiltering="false">

                                                    <ItemTemplate>
                                                        <telerik:RadNumericTextBox ID="TxtBillCodeRate" runat="server" Enabled="false" ForeColor="RoyalBlue" Height="20px" Width="50px" AutoPostBack="true" ToolTip=""
                                                            EnabledStyle-HorizontalAlign="Right" Culture="gu-IN" NumberFormat-DecimalDigits="0" MinValue="0">
                                                            <NumberFormat DecimalDigits="2" GroupSeparator=""></NumberFormat>
                                                            <EnabledStyle HorizontalAlign="Right"></EnabledStyle>
                                                        </telerik:RadNumericTextBox>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>--%>

                                            <telerik:GridBoundColumn HeaderText="Count" DataField="Occupants" HeaderStyle-Wrap="TRUE" ItemStyle-Width="50pX" HeaderTooltip="Shows the no. of residents and dependents in a house / villa. "
                                                ItemStyle-Wrap="false" AllowFiltering="FALSE" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                HeaderText="BillFor" HeaderStyle-Font-Names="" UniqueName="BillFor" SortExpression="BillFor" AllowFiltering="false" HeaderTooltip="This is the number of persons to be counted for billing.  This value can be zero or equal to or less than the Count of residents.  This validation avoids any wrong / excess billing.">
                                                <ItemTemplate>
                                                    <telerik:RadNumericTextBox ID="TxtBillFor" Text='<%# Eval("Occupants")%>' runat="server" Height="20px" Width="50px" AutoPostBack="true" 
                                                        EnabledStyle-HorizontalAlign="Right" Culture="gu-IN" NumberFormat-DecimalDigits="0" MinValue="0" 
                                                        OnTextChanged="TxtBillFor_TextChanged " MaxValue='<%# Convert.ToDouble(Eval("Occupants")) %>' ShowSpinButtons="true" ButtonsPosition="Right" > 
                                                        <NumberFormat DecimalDigits="0" GroupSeparator=""></NumberFormat>
                                                        <EnabledStyle HorizontalAlign="Right"></EnabledStyle>
                                                    </telerik:RadNumericTextBox>

                                                     
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <telerik:RadNumericTextBox ID="lblPCount" runat="server" ForeColor="Blue" Font-Bold="true" Height="20px" Width="50px" AutoPostBack="true" Enabled="false" ToolTip=""
                                                        EnabledStyle-HorizontalAlign="Right" Culture="gu-IN" NumberFormat-DecimalDigits="0" MinValue="0" Visible="false">
                                                        <NumberFormat DecimalDigits="2" GroupSeparator=""></NumberFormat>
                                                        <EnabledStyle HorizontalAlign="Right"></EnabledStyle>
                                                    </telerik:RadNumericTextBox>
                                                </FooterTemplate>

                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                                HeaderText="Amount" HeaderStyle-Font-Names="" UniqueName="Amount" AllowFiltering="false" SortExpression="Amount" HeaderTooltip="This is the calculated bill amount (Rate per session multiplied by the Bill For Count).">
                                                <ItemTemplate>                                                                                                        
                                                    <telerik:RadNumericTextBox ID="TxtAmnt" runat="server" Height="20px" Width="100px" ForeColor="Black" Font-Bold="true" Enabled="false" AutoPostBack="true" ToolTip=""
                                                        EnabledStyle-HorizontalAlign="Right" Culture="gu-IN" NumberFormat-DecimalDigits="0" MinValue="0">
                                                        <NumberFormat DecimalDigits="2" GroupSeparator=""></NumberFormat>
                                                        <EnabledStyle HorizontalAlign="Right"></EnabledStyle>
                                                    </telerik:RadNumericTextBox>
                                                </ItemTemplate>

                                                <FooterTemplate>

                                                    <asp:Label ID="lblTotal" Text="Total :" ForeColor="Blue" Font-Bold="true" runat="server" />
                                                    <asp:Label ID="Label3" Text="" ForeColor="Blue" Font-Bold="true" runat="server" Width="22px" />
                                                    <telerik:RadNumericTextBox ID="lblTotalAmnt" runat="server" ForeColor="Blue" Font-Bold="true" Height="20px" Width="100px" AutoPostBack="true" Enabled="false" ToolTip=""
                                                        EnabledStyle-HorizontalAlign="Right" Culture="gu-IN" NumberFormat-DecimalDigits="0" MinValue="0">
                                                        <NumberFormat DecimalDigits="2" GroupSeparator=""></NumberFormat>
                                                        <EnabledStyle HorizontalAlign="Right"></EnabledStyle>
                                                    </telerik:RadNumericTextBox>
                                                </FooterTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <EditFormSettings>
                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>

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
                            <td>
                                <asp:Button ID="BtnSave" runat="server" ToolTip="Click here to raise billing transactions for all the residents selected above." CssClass="btn btn-primary" Text="Save" OnClick="BtnSave_Click" OnClientClick="javascript:return ConfirmMsg()"></asp:Button>
                                <asp:HiddenField ID="HResult" runat="server" />
                                <asp:Button ID="btnreturnfromlevelW" runat="server" Text="Return" CssClass="btn btn-info" Visible="true"
                                    OnClick="btnreturnfromGrpBill_Click" ToolTip="Click here to return Billing & Receipts" />
                            </td>
                        </tr>
                    </table>

                </asp:Panel>

                <asp:Panel ID="pnlBilled" runat="server" Visible="false">
                    <table width="97%">
                        <tr>
                            <td align="right">
                                <asp:Label ID="lblTotalAmt"  runat="server" ForeColor="Blue">
                                </asp:Label>
                            </td>
                        </tr>
                    </table>

                    <table>
                        <tr>

                            <td style="width: 1200px; height: 185px; vertical-align: top;">
                                <telerik:RadGrid ID="ReportList" runat="server" AllowPaging="true" PageSize="50" AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="False" ShowFooter="true"
                                    CellSpacing="5" Width="98%"
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
                                            <telerik:GridBoundColumn HeaderText="RTRSN" DataField="RRTRSN" HeaderStyle-Wrap="false" Visible="false"
                                                ItemStyle-Wrap="false" AllowFiltering="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Name" DataField="Name" HeaderStyle-Wrap="false" Visible="true"
                                                ItemStyle-Wrap="false" AllowFiltering="False" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="75px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Villa No" DataField="RTVILLANO" HeaderStyle-Wrap="true" ItemStyle-Width="20px"
                                                ItemStyle-Wrap="true" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="left"
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

                                            <telerik:GridBoundColumn HeaderText="Date" DataField="TXDATE" HeaderStyle-Wrap="false"
                                                ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn HeaderText="Code" DataField="Code" HeaderStyle-Wrap="false"
                                                ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>

                                            <telerik:GridBoundColumn HeaderText="Narration" DataField="Narration" HeaderStyle-Wrap="false"
                                                ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="TxnType" DataField="TransType" HeaderStyle-Wrap="false"
                                                ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px"
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
                                            <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                HeaderStyle-HorizontalAlign="Center"
                                                ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Center"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Amount" DataField="TXAMOUNTDR" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                ItemStyle-CssClass="Row1">
                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                <ItemStyle Wrap="False"></ItemStyle>
                                            </telerik:GridBoundColumn>

                                            <%-- <telerik:GridBoundColumn HeaderText="Credit" DataField="TXAMOUNTCR" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
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
            </div>



        </div>
    </div>
</asp:Content>

