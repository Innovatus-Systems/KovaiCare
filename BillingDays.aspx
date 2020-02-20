<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="BillingDays.aspx.cs" Inherits="BillingDays" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        function SaveValidate() {

            var result = confirm('Do you want to save?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }



        function UpdateValidate() {




            var result = confirm('Do you want to Update?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }
        }



        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode


            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }




    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">
            <div style="font-family: Verdana; font-size: small;">
                <table style="width: 100%;">
                    <tr>
                        <td align="center">

                            <asp:Label ID="lbltitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                            <asp:HiddenField ID="CnfResult" runat="server" />
                            <asp:HiddenField ID="hdnRSN" runat="server" />
                        </td>

                    </tr>
                </table>

                <table style="width: 100%;">
                    <tr style="width: 100%;">
                        <td style="width: 40%; vertical-align: top">

                            <table>
                                <tr>
                                    <td>
                                        <text style="color: gray; font-family: Verdana; font-size: smaller;">
                                                   Mark the dates when the person will not be dining <br />
                                                   
                                                </text>
                                    </td>
                                </tr>
                            </table>
                            <table>

                                <tr>
                                    <td colspan="3">
                                        <asp:Label ID="lblResident" runat="server" Text="Resident"></asp:Label>
                                        <asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:DropDownList ID="ddlResident" runat="server" ToolTip="Select a resident or dependent from the list.  Includes OR, ORD, T , TD, RS, RSD categories." Height="23px" Width="250px" AutoPostBack="false">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:Label ID="Label2" runat="server" Text="Billing Month"></asp:Label>
                                        <asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:DropDownList ID="ddlBillingMonth" runat="server" ToolTip="Select the billing month" Height="23px" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="ddlBillingMonth_Changed">
                                        </asp:DropDownList>
                                        <%--<asp:TextBox ID="txtBillingMonth" runat="server" ToolTip="Shows current billing month" Width="150px" MaxLength="20" ReadOnly="true"></asp:TextBox>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:Label ID="lblFromDt" runat="Server" Text="From" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <telerik:RadDatePicker ID="dtpFromDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                            Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Enter the start date of absence" AutoPostBack="true" OnSelectedDateChanged="dtpFromDate_Changed">
                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                CssClass="TextBox" Font-Names="Calibri">
                                            </Calendar>
                                            <DatePopupButton></DatePopupButton>
                                            <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                ForeColor="Black" ReadOnly="true">
                                            </DateInput>
                                        </telerik:RadDatePicker>

                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:Label ID="Label7" runat="Server" Text="Till" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <telerik:RadDatePicker ID="dtpTillDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                            Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Enter the date upto which the resident will be away.  The billing month and no.of days are automatically calculated." AutoPostBack="true" OnSelectedDateChanged="dtpFromDate_Changed">
                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                CssClass="TextBox" Font-Names="Calibri">
                                            </Calendar>
                                            <DatePopupButton></DatePopupButton>
                                            <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                ForeColor="Black" ReadOnly="true">
                                            </DateInput>
                                        </telerik:RadDatePicker>

                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:Label ID="Label4" runat="server" Text="Not dining"></asp:Label>
                                        <asp:Label ID="Label5" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtNoDaysDinned" runat="server" ToolTip="This is the no. of days a resident will not be dining." MaxLength="2" Width="150px" onkeypress="return isNumberKey(event);" ReadOnly="true"></asp:TextBox>
                                       <%-- <asp:Label ID="Label8" runat="server" Text="days."></asp:Label>--%>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="txtRemarks" runat="server" ToolTip="Write any descriptive remarks." TextMode="MultiLine" Height="75px" Width="350px" MaxLength="2400"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="3"></td>
                                    <td colspan="3">
                                        <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                        <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" Visible="false" />
                                        <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" Height="25px" OnClick="btnClear_Click" />
                                        <%-- <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" Height="25px" OnClick="btnReturn_Click" />--%>
                                       
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 60%; vertical-align: top">
                            <telerik:RadGrid ID="grdBillingDays" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="300px" Width="700px" AllowFilteringByColumn="true" AllowPaging="false"
                                OnItemCommand="grdBillingDays_ItemCommand" OnInit="grdBillingDays_Init">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                </ClientSettings>
                                <MasterTableView AllowFilteringByColumn="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>' OnClick="LnkEditItem_Click"></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="RSN" HeaderStyle-Width="100px" DataField="RSN" ReadOnly="true" AllowFiltering="true" Display="false"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Resident" HeaderStyle-Width="120px" DataField="Resident" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="100px" FilterControlWidth="60px" DataField="Status" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Billing Month" HeaderStyle-Width="80px" FilterControlWidth="60px" ItemStyle-Width="80px" DataField="BillingMonth" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="From" HeaderStyle-Width="80px" FilterControlWidth="50px" DataField="FromDt" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Till" HeaderStyle-Width="80px" FilterControlWidth="50px" DataField="TillDt" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Days" HeaderStyle-Width="80px" FilterControlWidth="50px" ItemStyle-Width="80px" DataField="DNNoDays" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="150px" DataField="Remarks" ReadOnly="true" AllowFiltering="true" Display="false"></telerik:GridBoundColumn>

                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>

                <table style="width: 100%;">
                    <tr style="width: 100%;">
                   
                        <td  style="width: 40%; vertical-align: top"></td>
                        <td  style="width: 60%; vertical-align: top">
                            <text style="color: gray; font-family: Verdana; font-size: smaller;">
                                    Use this option only to mark a long absence of a resident.<br />
                                    Billing for dining can be controlled by marking the days of absence.<br />
                                    This can be done only within the current or next billing month.<br />
                                    Make sure you update the values before the month end billing process is carried out.<br />
                                    Residents, Tenants and their dependents are covered.<br />
                                    Also includes resident staff and their dependents.<br />
                                    You can view this information for a resident, in his/her profile.<br />
                                    Also refer to dining-billing rules settings if applicable to your community.                                                   
                            </text>
                        </td>
                    </tr>
                </table>

            </div>
        </div>
    </div>
</asp:Content>




