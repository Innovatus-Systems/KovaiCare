<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditBPMessage.aspx.cs" Inherits="EditBPMessage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<script language="javascript" type="text/javascript">


    function TaskConfirmMsg() {

        var result = confirm('Do you want to update?');

        if (result) {

            document.getElementById('<%=CnfResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
            }

    }

   
    

</script>
<body onunload="opener.location=opener.location;">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <form id="form1" runat="server">
        <div>
            <table>

                <tr style="height: 10px">
                    <td>
                        <asp:HiddenField ID="CnfResult" runat="server" />
                         <asp:HiddenField ID="hdnBPRSN" runat="server" />
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label1" runat="Server" Text="Period" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBillingPeriod" runat="Server" MaxLength="12" ToolTip="" Width="100px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRTVILLANO" runat="Server" Text="Message" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMessage" runat="Server" MaxLength="80" ToolTip="" Width="450px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                <tr style="height: 20px">
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Update" ForeColor="White" Visible="true" OnClientClick="TaskConfirmMsg()" OnClick="btnUpdate_Click" ToolTip="Click here to Update the details" />
                        <asp:Button ID="btnClose" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Close" ForeColor="White" BackColor="Goldenrod" ToolTip="Click here to close the screen" OnClick="btnClose_Click" OnClientClick="refreshAndClose()" />
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
