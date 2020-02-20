<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostMMTEdit.aspx.cs" Inherits="PostMMTEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script>
        function TaskConfirmMsg2() {

            var result = confirm('Do you want to update?');

            if (result) {

                return true;
            }
            else {
                return false;
            }

        }
    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%;">
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Underline="true" Font-Size="Medium" ForeColor="Green" Text="Update Resident Details" Font-Bold="true"></asp:LinkButton>
                    </td>
                </tr>
            </table>

            <div>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="Label14" runat="Server" Text="DoorNo:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblDoorNo" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label15" runat="Server" Text="Name:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblName" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="Label17" runat="Server" Text="DOB:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lbldob" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label18" runat="Server" Text="Account No:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblaccountno" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                    </tr>


                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="Server" Text="Status:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlStatus" runat="server" Width="200px">
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="Label44" runat="Server" Text="Maintenance Charge:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMCharge" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label45" runat="Server" Text="Kitchen Overhead Charges:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtkoc" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="Label19" runat="Server" Text="Diner Type:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDType" runat="server">                              
                                <asp:ListItem Text="Casual" Value="N"></asp:ListItem>
                                  <asp:ListItem Text="Regular" Value="Y"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <asp:Label ID="Label2" runat="Server" Text="Caregiver & Nursing charges:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtNC" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    <%-- <tr>
                        <td>
                            <asp:Label ID="Label20" runat="Server" Text="Start Date:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="dtpstartdate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="" AutoPostBack="true">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>
                        </td>
                    </tr>--%>
                    <%--  <tr>
                        <td>
                            <asp:Label ID="Label21" runat="Server" Text="End Date:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="dtpenddate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="" AutoPostBack="true">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>

                        </td>
                    </tr>--%>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Button ID="btnUpdate" OnClientClick="javascript:return TaskConfirmMsg2()" CssClass="btn btn-success" ToolTip="Click here to update the house keeping status" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" />

                        </td>
                    </tr>
                </table>
                <div>
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" />
    </div>
            </div>
        </div>
    </form>
</body>
</html>
