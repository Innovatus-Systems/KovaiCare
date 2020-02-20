<%@ Page Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="RechargeMsg.aspx.cs" Inherits="RechargeMsg" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/MenuCSS.css" rel="stylesheet" />
</asp:Content> 


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">
               <div style="width:100%;  ">
                        <table style="width:auto; margin-left:auto; margin-right:auto;"">
                            <tr>
                                <td style="text-align:center">
                                    <asp:Label ID="Label34" runat="server" Text="Please recharge to enjoy continuos usage." Font-Names="verdana" Font-Size="Medium" Font-Bold="true" ForeColor="Red"></asp:Label>
                                </td>
                                <td>
                                    <asp:LinkButton ID="lnkDwellingUnits" runat="server" Font-Names="verdana" Font-Size="Smaller" Text="Click here to recharge your account now."   ></asp:LinkButton>
                                </td>
                            </tr>
                       </table>
            </div>
        </div>
        </div>

     </asp:Content>
