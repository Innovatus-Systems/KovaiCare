<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuExcessReport.aspx.cs" Inherits="MenuExcessReport" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

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
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="font-family: Verdana; font-size: small; min-height: 400px;">

                        <table style="width: 100%">
                            <tr>
                                <td align="center">
                                    <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                                     <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:HiddenField ID="hdnBtot" runat="server" />
                                    <asp:HiddenField ID="hdnAtot" runat="server" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table>
                            <tr>
                                <td style="width: 70%; vertical-align: top">
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 10px"></td>
                                            <td style="vertical-align: top">
                                                
                                                <asp:Label ID="Label1" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="false" Text="Menu Item :"></asp:Label>

                                                <asp:DropDownList ID="ddlMenuItem" ToolTip="Select from list the food item for which you wish to add the ingredient quantities." runat="server" Height="23px" Width="150px" Font-Names="verdana">
                                                </asp:DropDownList>
                                                
                                                <asp:Label ID="Label5" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="false" Text="From:"></asp:Label>
                                                <telerik:RadDatePicker ID="dtpfrom" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="180px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date." AutoPostBack="true">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>


                                                <asp:Label ID="Label2" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="false" Text="Till:"></asp:Label>
                                                <telerik:RadDatePicker ID="dtptil" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="180px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date." AutoPostBack="true">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                                                                
                                                <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Show" ToolTip="Click here to show excess menu item details." Width="90px" ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" />
                                                <%-- <asp:Button ID="Button1" runat="server" Text="Export to PDF" ToolTip="" Width="90px" ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Visible="false" />--%>
                                            </td>

                                        </tr>
                                    </table>

                                    <asp:Panel ID="pnlShowDet" runat="server" Visible="true">
                                        <table>
                                            <tr>
                                                <td style="width: 10px"></td>
                                                <td style="vertical-align: top">
                                                    <table>
                                                        
                                                      

                                                        <tr>
                                                            <td>
                                                                <table>
                                                                    <tr>
                                                                        <%--<td style="width: 10px"></td>--%>

                                                                        <td>
                                                                            <telerik:RadGrid ID="grdBillingDays" GroupingSettings-CaseSensitive="false" Skin="Sunset" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="300px" Width="1000px" AllowFilteringByColumn="true" AllowPaging="false"
                                                                                OnItemCommand="grdBillingDays_ItemCommand" ShowHeader="true" MasterTableView-ShowHeadersWhenNoRecords="true">
                                                                                <ClientSettings>
                                                                                    <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                                                </ClientSettings>
                                                                                <MasterTableView AllowFilteringByColumn="true" ShowHeadersWhenNoRecords="true">
                                                                                    <NoRecordsTemplate>
                                                                                    No Records Found.
                                                                                    </NoRecordsTemplate>
                                                                                    <Columns>
                                                                                        <%-- <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                                            <ItemTemplate>
                                                                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>' OnClick="LnkEditItem_Click"></asp:LinkButton>
                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>--%>
                                                                                        <telerik:GridBoundColumn HeaderText="RSN" HeaderStyle-Width="100px" DataField="RSN" ReadOnly="true" AllowFiltering="true" Display="false"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="80px" ItemStyle-Width="80px" FilterControlWidth="50px" DataField="Date" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="Session" HeaderStyle-Width="80px" ItemStyle-Width="80px" FilterControlWidth="50px" DataField="Session" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="Booked" HeaderStyle-Width="80px" ItemStyle-Width="80px" FilterControlWidth="50px" DataField="BCount" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="Actuals" HeaderStyle-Width="80px" ItemStyle-Width="80px" FilterControlWidth="50px" DataField="ACount" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="Menu" HeaderStyle-Width="120px" ItemStyle-Width="120px" FilterControlWidth="80px" DataField="Menu" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="UOM" HeaderStyle-Width="80px" ItemStyle-Width="80px" FilterControlWidth="50px" DataField="UOM" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="Serve Qty." HeaderStyle-Width="80px" ItemStyle-Width="80px" FilterControlWidth="50px" DataField="ServQty" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="Est. Qty." HeaderStyle-Width="80px" ItemStyle-Width="80px" FilterControlWidth="50px" DataField="EstQty" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="Not Consumed" HeaderStyle-Width="90px" ItemStyle-Width="90px" FilterControlWidth="50px" DataField="NotConsumed" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="150px" DataField="Remarks" ReadOnly="true" AllowFiltering="true" Display="false"></telerik:GridBoundColumn>

                                                                                    </Columns>
                                                                                </MasterTableView>
                                                                            </telerik:RadGrid>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                             <td style="vertical-align: top">
                                                                <asp:Button ID="btnExcel" runat="server" Text="Export to Excel" ToolTip="Click here to export grid data in excel." ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Width="120px" />
                                                            </td>

                                                        </tr>
                                                    </table>
                                                </td>




                                            </tr>


                                        </table>


                                    </asp:Panel>

                                </td>

                                <%--<td style="width: 25%; vertical-align: top">

                                    <table style="width: 100%;">
                                        <tr style="width: 100%;">
                                            <td>
                                                <text style="color: gray; font-family: Verdana; font-size: smaller;">
                                                        This screen is to record how much of each item was remaining not consumed at the end of a session.<br />
                                                        Helps to track any wastage due to over preparation or shortage due to a poor estimate.<br />
                                                        By fine tuning the estimate one can avoid wastage or last minute shortages.<br />
                                                        Usually this screen is updated at the end of a session.
                                                                                                
                                                    </text>
                                            </td>
                                        </tr>
                                    </table>
                                </td>--%>
                            </tr>
                        </table>


                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSearch" />
                    <asp:PostBackTrigger ControlID="btnExcel" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
