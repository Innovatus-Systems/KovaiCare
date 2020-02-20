<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div align="center" style="background-color: transparent; background-image: url(Images/RC1.jpeg); background-size: cover">
            <asp:Login ID="Login1" runat="server" Font-Size="Large" BackColor="#F7F6F3" BorderColor="#E6E2D8" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" ForeColor="#333333" DestinationPageUrl="~/Common/Default.aspx" DisplayRememberMe="False" FailureText="Login failed" RememberMeSet="False" Height="524px" Width="384px">
                <TitleTextStyle BackColor="#5D7B9D" Font-Bold="True" Font-Size="0.9em" ForeColor="White" />
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <TextBoxStyle Font-Size="0.8em" />
                <LoginButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px"
                    Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
            </asp:Login>
        </div>

        <asp:Panel ID="pnlPerson" runat="server">
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
    </asp:Panel>
    <asp:Button ID="btnExport" runat="server" Text="Export" OnClick="btnExport_Click" />
    </form>


    

</body>
</html>
