<%@ Page Title="" Language="C#" MasterPageFile="~/Mstrpg1.master" AutoEventWireup="true" CodeFile="PaymentFailure.aspx.cs" Inherits="PaymentFailure" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="CSS/PayStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="divHead" align="center">
        <p style="color: #ffffff;">Recharge Failed</p>
    </div>
    <div class="divBtns" align="right">
        <asp:Button ID="BtnHome" runat="server" Text="Home" CssClass="btn" ToolTip="Click here to return to Home Page" OnClick="BtnHome_Click" />
        <asp:Button ID="BtnPayDetails" runat="server" Text="Recharge" CssClass="btn" ToolTip="Click here to make your recharge" OnClick="BtnPayDetails_Click" />
        <asp:Button ID="BtnHistory" runat="server" Text="History" CssClass="btn" ToolTip="Click here to view the recharge history" OnClick="BtnHistory_Click"/>
        <asp:Button ID="BtnStatement" runat="server" Text="Statement" CssClass="btn" ToolTip="Click here to view the recharge Statement" OnClick="BtnStatement_Click"/>
    </div>
    <div class="divInfo">
        <table style="width:100%">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr style="font-family: Verdana; font-size: 24px;color:red">
                <td align="center">
                    <asp:Label ID="LblTitle" runat="server" Text="Sorry, Recharge payment failed"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
        <hr />
        <asp:Label ID="Label1" style="color: darkblue;" runat="server" Text="We're sorry. This payment has been declined by your card issuer or our payment systems."></asp:Label>
        <asp:Label ID="Label2" style="color: darkblue;" runat="server">
            <asp:LinkButton ID="LnkPayAgain" runat="server" style="text-decoration:none;" OnClick="LnkPayAgain_Click">Click here</asp:LinkButton>  to make a payment again.</asp:Label>

        <br />
        <br />
    </div>
</asp:Content>

