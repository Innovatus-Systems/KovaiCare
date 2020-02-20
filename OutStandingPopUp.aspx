<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="OutStandingPopUp.aspx.cs" Inherits="OutStandingPopUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
      <link href="CSS/bootstrap.css" rel="stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%;">
            <table style="width: 100%;">
                <tr>
                    <td align="center">
                        <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Underline="true" Font-Size="Medium" ForeColor="Green"  Text="Account Summary" Font-Bold="true"></asp:LinkButton>
                    </td>
                </tr>
            </table>
     <div>
                          
                            <table  align="center" >
                                <tr>
                                    <td align="center" >
                                        <table>
                                            <tr>
                                                <td>
                                                     <asp:Label ID="lblBilledFor" runat="server" Font-Names="verdana" Font-Size="Small"  Text=""></asp:Label>
                                                    <asp:Label ID="lblPREV" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="#3333ff"  Text=""></asp:Label>
                                                </td>
                                                <td>
                                                     <asp:Label ID="lblBilledForAmount" runat="server" Font-Names="verdana" Font-Size="Small" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td>
                                                     <asp:Label ID="lblPayments" runat="server" Font-Names="verdana" Font-Size="Small" Text="Payment's Done : "></asp:Label>
                                                </td>
                                                <td>
                                                     <asp:Label ID="lblPaymentsDone" runat="server" Font-Names="verdana" Font-Size="Small" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                     <asp:Label ID="lblUnBilledFor" runat="server" Font-Names="verdana" Font-Size="Small"  Text=""></asp:Label>
                                                    <asp:Label ID="lblCRT" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor="#3333ff"  Text=""></asp:Label>
                                                </td>
                                                <td>
                                                     <asp:Label ID="lblUnBilledForAmount" runat="server" Font-Names="verdana" Font-Size="Small" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                     <asp:Label ID="lblNetOut" runat="server" Font-Names="verdana" Font-Size="Small"  Text="Net Outstanding : "></asp:Label>
                                                </td>
                                                <td>
                                                     <asp:Label ID="lblNetOutAmount" runat="server" Font-Names="verdana" Font-Size="Small" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                           
                                        </table>
                                    </td>
                                </tr>                                
                            </table>
                            <table align="center">
                                 <tr>
                                                <td>
                                                     <asp:Label ID="lblAccount" runat="server" Font-Names="verdana" Font-Size="Small" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                     </tr>
                                 </table>
                                <table align="center">
                                       <tr>
                                                <td>
                                                     <asp:Label ID="lblResident" runat="server" Font-Names="verdana" Font-Size="Small" Font-Bold="true" Text=""></asp:Label>
                                                </td>
                                            </tr>
                            </table>
         </div>
                        </div>
    </form>
</body>
</html>
