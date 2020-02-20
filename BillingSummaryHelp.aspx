<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillingSummaryHelp.aspx.cs" Inherits="BillingSummaryHelp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                 <tr style="height:5px"><td></td></tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label11" runat="server" Font-Names="Calibri" Font-Size="20px" Text="Billing Summary" Font-Underline="true" ForeColor="Gray"></asp:Label>
                    </td>
                </tr>                
                 <tr style="height:5px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="lblHelp" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Shows details of Billing Period, amount billed, amount received, carried forward from previous month, 
                            status of the Billing period and other details."></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Status   Yet to Open -  (00) -  The billing period is in the future.   Open (10) -  All bills will be 
                            posted against the Open billing period.There can be only one Open period at any time. Yet to Bill (20) – This is the immediately previous 
                            billing period to an Open period. (Ex: If June 15 is the Open period, May 15 is the Yet to bill  period). This indicates the monthly bills are 
                            yet to be printed and despatched to the residents. There can be only one billing period of this status and it has to be the immediate previous one.  
                               Billed (30) – When the monthly bills (Statements based on which a resident will pay his dues) are raised, the Yet to Bill Status becomes Billed 
                            Status."></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Closed (90) -  The billing periods which are in Closed Status are those for which bills have been raised in 
                            the past. Any amount remaining unpaid in these closed periods would have been carried over to subsequent billing months. " ></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Font-Names="Calibri" Font-Size="14px" Text="One can set a Special message for each billing period, to be printed on the Statement. "></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Last Date indicates the date by which the residents are required to pay their dues."></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Font-Names="Calibri" Font-Size="14px" Text="No.of Bills – Refers to the count of monthly statements (or in other words number of residents for whom bills were raised)."></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Amount (B) is the cumulative amount billed for the billing period based on the debits raised per resident."></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Amount ( R) is the cumulative amount received against the bills for the period."></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Amount(CF)  is the difference between Amount (B) and Amount (R )  of the immediate previous billing period."></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Font-Names="Calibri" Font-Size="14px"  Text="A negative Amount (CF) means a Credit balance carried forward.  A Positive Amount (CF) means a Debit balance carried forward."></asp:Label>
                    </td>
                </tr>
                <tr style="height:3px"><td></td></tr>
                <tr>
                    <td>
                        <asp:Label ID="Label10" runat="server" Font-Names="Calibri" Font-Size="14px" Text="The total outstanding in a billing period is the sum of Amount (B) + Amount (CF) – Amount (R) ."></asp:Label>
                    </td>

                </tr>
            </table>
        </div>
    </form>
</body>
</html>
