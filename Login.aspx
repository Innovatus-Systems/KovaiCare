<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CovaiSmart</title>
    <style type="text/css">
        .divContent {
            font-family: Verdana;
            font-size: 12px;
            width: 100%;
            min-height: 500px;
            height: 100%;
        }

        .divHeader1 {
            width: 100%;
            padding: 5px;
            background-color: #196F3D;
            color: #000;
        }

        .divHeader2 {
            width: 100%;
            padding: 5px;
            background-color: #196F3D;
            color: #FFFFFF;
        }

        .divLoginContent {
            margin-top: 3%;
            height: auto;
            width: 300px;
            background-color: #D7E4BD;
            border-radius: 10px 10px;
            padding: 15px;
            box-shadow: 5px 5px 5px #DDDDDD;
            /*box-shadow: 0 0 2px rgba(0, 0, 0, 0.2),  
                0 1px 1px rgba(0, 0, 0, .2),
                0 3px 0 #fff,
                0 4px 0 rgba(0, 0, 0, .2),
                0 6px 0 #fff,  
                0 7px 0 rgba(0, 0, 0, .2);*/
        }

        .divError {
            height: auto;
            width: 300px;
            background-color: #FFC962;
            border-radius: 10px 10px;
            padding: 10px;
        }

        .btnNew {
            font-family: Verdana;
            color: white;
            font-size: 12px;
            background: #196F3D;
            font-weight: 500;
            padding: 8px 10px 8px 10px;
            text-decoration: none;
            border: 0px solid #FFFFFF;
        }

            .btnNew:hover {
                background: #FFFFFF;
                color: #196F3D;
                text-decoration: none;
                -webkit-box-shadow: 0px 0px 20px 5px #CCC;
                -moz-box-shadow: 0px 0px 20px 5px #CCC;
                box-shadow: 0px 0px 20px 5px #CCC;
                border: 0px solid #FFFFFF;
                cursor: pointer;
            }
        /*#TxtUserID{
                float:left; margin:20px 0px 0px 18px; width:350px; height:32px; padding-left:10px; border: 1px solid #ccc; border-radius:8px;
                background: url(../Image/username1.png) no-repeat;
                background-position: 5px 5px;
            }*/
    </style>
    <script type="text/javascript">
        function chkSignIn() {
            var userID = document.getElementById("TxtUserID").value;
            var pwd = document.getElementById("TxtPassword").value;

            if (userID == '') {
                alert('Please enter User ID');
                document.getElementById("TxtUserID").focus();
                return false;
            }
            else if (pwd == '') {
                alert('Please enter Password');
                document.getElementById("TxtPassword").focus();
                return false;
            }
            else
                return true;
        }
    </script>
    <link href="CSS/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="login" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="divContent">
            <div class="divHeader1">
                <table width="100%">
                    <tr>
                        <td align="left" width="30%">
                            <asp:Label runat="server" ForeColor="White" ID="LblDate"></asp:Label>
                        </td>
                        <td align="center" width="40%">
                            <asp:Label runat="server" ForeColor="White" ID="LblTitle" Style="font-size: 14px;">Online Residents Information System</asp:Label>
                        </td>
                        <td align="right" width="30%">
                            <asp:Label runat="server" ForeColor="White" ID="LblDateTime">Time</asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <div align="center" class="divHeader2">
                <asp:Label runat="server" ForeColor="White" Style="font-size: 14px; font-weight: bold" ID="LblCommunittyName">Community Name</asp:Label>
            </div>
            <div align="center">
                <div class="divLoginContent">
                    <table width="280px;">
                        <tr>
                            <td align="left" width="180px"><%--style="line-height:2; border-left:2px solid #244180; border-right:2px solid #244180; background:#6189df; ">--%>
                                <asp:Label runat="server" Style="color: #196F3D; font-size: 14px; font-weight: bold;">CovaiSmart</asp:Label>
                            </td>
                            <td align="right">
                                <asp:Label runat="server" ID="LblVersionNo">VNo</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <%--<asp:Label runat="server">User ID</asp:Label>--%>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox CssClass="form-control" Placeholder="User ID" ToolTip="Enter your User ID" Font-Names="Verdana" Font-Size="12px" runat="server" ID="TxtUserID" Width="270px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <%--<asp:Label runat="server">Password</asp:Label>--%>&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:TextBox CssClass="form-control" Placeholder="Password" ToolTip="Enter your User Password" Font-Names="Verdana" Font-Size="12px" TextMode="Password" runat="server" ID="TxtPassword" Width="270px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br />
                                <asp:Button runat="server" ID="BtnSignIn" CssClass="btnNew"  ToolTip="Click here to Sign In" OnClientClick="return chkSignIn();" OnClick="BtnSignIn_Click" Text="Sign In" Width="270px" />
                            </td>
                        </tr>

                    </table>
                    <br />
                </div>
                <br />
                <div runat="server" id="DivError" class="divError" visible="false">
                    <asp:Label runat="server" ID="LblError">Perhaps it is a wrong ID and/or a Password. Try again</asp:Label>
                </div>

                <div>
                    <img src="Images/HappyRetirements.png" width="400" height="230" />
                </div>
                <div>
                    <table style="padding: 10px; width: 400px;" align="center">
                        <tr>
                            <td align="center">
                                <div style="line-height: 2; border-left: 4px solid #196F3D; border-right: 2px solid #196F3D; background: #DFDAD4;">
                                    <asp:Label runat="server">Efficient Operations</asp:Label>
                                </div>

                            </td>
                            <td align="center">
                                <div style="line-height: 2; border-left: 2px solid #196F3D; border-right: 2px solid #196F3D; background: #DFDAD4;">
                                    <asp:Label runat="server">Cost Savings</asp:Label>
                                </div>

                            </td>
                            <td align="center">
                                <div style="line-height: 2; border-left: 2px solid #196F3D; border-right: 4px solid #196F3D; background: #DFDAD4;">
                                    <asp:Label runat="server">Satisfied Residents</asp:Label>
                                </div>
                            </td>

                        </tr>

                    </table>



                </div>
            </div>


        </div>
        <div style="width: 96%; margin-left: 10px;">
            <hr style="padding: 0px;" />
            <asp:Label runat="server" Style="padding: 0px; margin-top: -10px; font-family: Verdana; font-size: 500; font-size: 12px;">Yet another quality software from Innovatus Systems</asp:Label>
        </div>

        <telerik:RadWindowManager runat="server" ID="RadWindowManager1" BackColor="Yellow" ForeColor="DarkBlue" CssClass="rwBackcolor">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
