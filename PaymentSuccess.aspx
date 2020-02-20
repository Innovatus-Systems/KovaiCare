<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="PaymentSuccess.aspx.cs" Inherits="PaymentSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/PayStyle.css" rel="stylesheet" />
    
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .divInfo{
    margin-top:5px;
    margin-left:4%;
    width:90%;
    border:2px solid #ccc;
    border-radius:3px;
    font-family:Verdana;
    font-size:12px;
    color:#000000;
    padding:10px;
    height:auto;
     box-shadow: 5px 5px 5px #CCCCCC;
  -webkit-box-shadow: 5px 5px 5px #CCCCCC;
  -moz-box-shadow: 5px 5px 5px #CCCCCC;
    
}
        .btn {
    display: inline-block;
    padding: 3px 6px;
    margin-bottom: 0;
    font-size: 13px;
    width: 100px;
    font-family: Verdana;
    font-weight: bold;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    color: white;
    background-color: #2c8de0;
}
    </style>
    <div class="divHead" align="center">
        <p style="color: #ffffff;">Recharge Successful</p>
    </div>
    <div class="divBtns" align="right">
        <asp:Button ID="BtnHome" runat="server" Text="Home" CssClass="btn" ToolTip="Click here to return to Home Page" OnClick="BtnHome_Click" />
        <asp:Button ID="BtnPayDetails" runat="server" Text="Recharge" CssClass="btn" ToolTip="Click here to make your recharge" OnClick="BtnPayDetails_Click" />
        <asp:Button ID="BtnHistory" runat="server" Text="History" CssClass="btn" ToolTip="Click here to view the recharge history" OnClick="BtnHistory_Click" Visible="False"/>
        <asp:Button ID="BtnStatement" runat="server" Text="History" CssClass="btn" ToolTip="Click here to view the recharge Statement" OnClick="BtnStatement_Click"/>
    </div>
    <asp:Panel ID="PnlPaymentDet" runat="server">
        <div class="divInfo" align="center">
        <table>
            <tr>
                <td align="center">
                    <asp:Image ID="ImgThankU" Height="120px" Width="300px" ImageUrl="~/Images/Thank-You.png" runat="server" /></td>
            </tr>
            <tr style="font-family: Verdana;color: darkblue;" font-size: 30px;">
                <td align="center">
                    <asp:Label ID="LblAmount"  runat="server" Text="Rs."></asp:Label>
                </td>
            </tr>
            <tr style="color: darkblue;">
                <td  align="center">
                    <asp:Label ID="LblMsg" runat="server" Text="Your recharge has been processed successfully.<br/> We'll send you confirmation email shortly."></asp:Label><br />
                    <asp:Label ID="LblNewBal" runat="server" Visible="false" Text=""></asp:Label><br />
                    <asp:Label ID="LblGoodFor" runat="server" Visible="false" Text=""></asp:Label><br />
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
        <hr />
       </div>

       <div  class="divInfo" align="left">
        <table style="width: 100%;">
            <tr>
                <%--<td style="width:50%;">
                    <table align="left" cellpadding="5px" style="font-family: Verdana; font-size: 12px; width: 98%;">
                        <caption style="background-color: #0094ff; color: #ffffff; font-size: 13px; font-weight:800; padding: 5px;">Amount and Tax Breakup</caption>
                        <tr style="color: darkblue;">
                            <td width="40%">Old Balance(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblOldBalance" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr style="color: darkblue;">
                            <td>Total Amount(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblTotAmt" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr style="color: darkblue;">
                            <td>Service Tax(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblServiceTax" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr style="color: darkblue;">
                            <td>Swahh Bharat Cess(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblSBCess" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr style="color: darkblue;">
                            <td>Final Amount(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblFinalAmt" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr style="color: darkblue;">
                            <td>New Balance(Rs.)
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblNewBalance" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>--%>
                <td style="width:50%; vertical-align:top;" >
                     <table align="left"  cellpadding="5px"  style="font-family: Verdana; font-size: 12px; width: 48%; margin-left:26%;border:1px solid #ccc;">
                        <caption style="background-color: #0094ff; color: #ffffff; font-size: 13px; font-weight:800; padding: 5px;">Recharge Details</caption>
                        <tr style="color: darkblue;">
                            <td width="40%">Transaction ID.
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblInvoiceNo" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr style="color: darkblue;">
                            <td>Transaction Date
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblDate" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                          <tr style="color: darkblue;">
                            <td>Recharge Amount
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblTotAmt" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                          <tr style="color: darkblue;">
                            <td>Service Tax
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblServiceTax" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                         <tr style="color: darkblue;">
                            <td>Swachh Bharath Cess
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblSBCess" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                         <tr style="color: darkblue;">
                            <td>Total Amount
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblFinalAmt" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                       
                         <%--<tr style="color: darkblue;">
                            <td>Invoice To
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblInvoiceTo" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>
                        <tr style="color: darkblue;">
                            <td>Billing Address
                            </td>
                            <td>:</td>
                            <td>
                                <asp:Label ID="LblBillingAddress" runat="server" Text=""></asp:Label>
                            </td>
                        </tr>--%>
                    </table>
                    
                </td>
            </tr>
        </table>
           <table width="100%">
                         <tr style="color: darkblue;">
                            <td>Payable To
                            </td>
                        </tr>
                        <tr style="color: darkblue;">
                            <td>
                                <asp:Label ID="LblInvoiceTo" runat="server" Text=""></asp:Label>
                            </td>

                        </tr>
                           <tr style="color: darkblue;">
                            <td>
                                <asp:Label ID="LblBillingAddress" runat="server" Text=""></asp:Label>
                            </td>
                               <td colspan="3" align="right">
                                  <asp:Button ID="BtnPrint" runat="server" Text="Print" CssClass="btn" Visible="false" ToolTip="Click here to print the payment details" OnClick="BtnPrint_Click"/>
                             </td>
                        </tr>
                       
                    </table>
    </div>
    </asp:Panel>
</asp:Content>

