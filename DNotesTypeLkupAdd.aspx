<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DNotesTypeLkupAdd.aspx.cs" Inherits="DNotesTypeLkupAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <link href="CSS/bootstrap.css" rel="stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%;background-color:skyblue;">
            <table style="width: 100%;background-color:skyblue;">
                <tr>
                    <td align="center">
                        <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </td>
                </tr>
            </table>
            <div>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblDNCODE" runat="server" Text="Diner Notes Cd." Font-Bold="true"></asp:Label>
                            <asp:Label ID="Label1" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDNCODE" runat="server" ToolTip="Enter Diner Notes Code."></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblDNDESC" runat="server" Text="Diner Notes Desc." Font-Bold="true"></asp:Label>
                            <asp:Label ID="Label2" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDNDESC" runat="server" ToolTip="Enter Diner Notes Description."></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success" Font-Names="Verdana" OnClick="btnSave_Click" ToolTip="Click to save diner notes." />
                        </td>

                    </tr>
                </table>
            </div>
    </form>
</body>
</html>
