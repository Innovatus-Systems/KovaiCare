<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MenuPrepared.aspx.cs" Inherits="MenuPrepared" %>

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
                                                &nbsp;&nbsp;                                    
                                                <asp:Label ID="Label6" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="false" Text="Session :"></asp:Label>
                                                <asp:DropDownList ID="ddlDinersSession" Width="150px" CssClass="ddl" ToolTip="Choose the session." runat="server"
                                                    AutoPostBack="true">
                                                </asp:DropDownList>
                                                &nbsp;&nbsp;&nbsp;                                    
                                                <asp:Button ID="btnSearch" OnClick="btnSearch_Click" runat="server" Text="Search" ToolTip="Click here to show menu details." Width="90px" ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" />
                                                <%-- <asp:Button ID="Button1" runat="server" Text="Export to PDF" ToolTip="" Width="90px" ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Visible="false" />--%>
                                            </td>

                                        </tr>
                                    </table>

                                    <asp:Panel ID="pnlShowDet" runat="server" Visible="false">
                                        <table>
                                            <tr>
                                                <td style="width: 10px"></td>
                                                <td style="vertical-align: top">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <table id="tblBDet" runat="server" visible="false">
                                                                    <tr>
                                                                        <td>
                                                                            <telerik:RadGrid ID="rgDinersTotal" runat="server" Skin="Sunset" GridLines="None"
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
                                                                                        <telerik:GridBoundColumn DataField="Status" HeaderText="" UniqueName="Status"
                                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="RegularBooking" HeaderText="Regular" UniqueName="Regular"
                                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="CasualBooking" HeaderText="Casual" UniqueName="Casual"
                                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="GuestBooking" HeaderText="Guest" UniqueName="Guest"
                                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="TotalBooking" HeaderText="Total" UniqueName="Total"
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
                                                        <tr>
                                                            <td style="vertical-align: top">
                                                                <telerik:RadGrid ID="rdgMenuDetails" runat="server" Skin="Sunset" GridLines="None" Width="1000px"
                                                                    AutoGenerateColumns="False" AllowSorting="false" Font-Size="Small">
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
                                                                            <telerik:GridBoundColumn DataField="ServeQty" HeaderText="Serv Qty." UniqueName="ServeQty" HeaderTooltip=" How much will a person usually consume?  Ex:  4 Idlies per person."
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" UniqueName="UOM"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="Total" HeaderText="Est Qty." UniqueName="Total" HeaderTooltip="What is the total estimated quantity. Serv.Qty * No.of bookings."
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridTemplateColumn DataField="NotConsumed" HeaderText="Not Consumed" UniqueName="NotConsumed" HeaderTooltip="Instead of recording how much was prepared, which is rather difficult, one can measure the quantity remaining not consumed at the end of the session."
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtNotConsumed" runat="server" Width="100px" onkeypress="return isNumberKey(event);" MaxLength="7"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>
                                                                            <telerik:GridTemplateColumn DataField="Remarks" HeaderText="Remarks" UniqueName="Remarks" HeaderTooltip="Any remarks about the reason"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtRemarks" runat="server" Width="220px" MaxLength="2400"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>
                                                                            <telerik:GridBoundColumn DataField="ItemCode" HeaderText="ItemCode" UniqueName="ItemCode"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" Display="false">
                                                                            </telerik:GridBoundColumn>

                                                                        </Columns>
                                                                    </MasterTableView>
                                                                </telerik:RadGrid>
                                                            </td>
                                                            <td style="vertical-align: top">
                                                                <asp:Button ID="btnSave" runat="server" Text="Save" ToolTip="Click here to save the details" ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" Width="90px" OnClick="btnSave_Click" OnClientClick="javascript:return SaveValidate()" />
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
                    <asp:PostBackTrigger ControlID="btnSave" />
                  
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

