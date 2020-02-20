<%@ Page Title="" Language="C#" MasterPageFile="~/Mstrpg1.master" AutoEventWireup="true" CodeFile="PayLogin.aspx.cs" Inherits="PayLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/PayStyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function checkLogin()
        {
            var uname = document.getElementById('<%= TxtUsername.ClientID%>').value;
            var pass = document.getElementById('<%= TxtPassword.ClientID%>').value;
            if(uname=="")
            {
                alert("Please enter the username!");
                return false;
            }
            else if(pass=="")
            {
                alert("Please enter the password!");
                return false;
            }
            else
            {
                return true;
            }
        }
    </script>
    <div class="cover" align="center">
        <table style="width: 100%; border: 1px solid #213042;" cellpadding="10">

            <caption style="background-color: #006BB2; text-align: center; padding: 5px; color: #FFFFFF; font-family: Verdana; font-size: 16px; font-weight: 700;">Account Recharge</caption>
            <tr>
                <td></td>
            </tr>
            <tr style="color: darkblue;">
               <td  align="right" width="30%">Username
                </td>

                <td>
                    <asp:TextBox ID="TxtUsername" CssClass="inputBox" runat="server" PlaceHolder="Enter username" ToolTip="Enter the username to sign in"></asp:TextBox>
                </td>
            </tr>
            <tr style="color: darkblue;">
                <td align="right">Password
                </td>
                <td>
                    <asp:TextBox ID="TxtPassword" CssClass="inputBox" type="password" Style="height: 20px;" runat="server" PlaceHolder="Enter password" ToolTip="Enter the password to sign in"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button CssClass="btn" ID="BtnSubmit" runat="server" Text="Sign In"  OnClick="BtnSubmit_Click" ToolTip="Click here to sign in" />
                    <asp:Button CssClass="btn" ID="BtnCancel" runat="server" Text="Cancel" OnClick="BtnCancel_Click" />
                </td>
            </tr>
            <tr style="color: darkblue;">
                <td colspan="2">
                    <asp:Label ID="Label1" runat="server" Text="* Sign in to make your recharge" Style="color: darkblue; font-family: Verdana; font-size: 10px;"></asp:Label></td>
                <td></td>
                <%--<td> <asp:CheckBox ID="ChkRemme" runat="server" Text="Remember Me" ToolTip="Save the username and the password in this system" /></td>--%>
            </tr>
        </table>
    </div>

</asp:Content>

