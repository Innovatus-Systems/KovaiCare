<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CovaiSmart</title>


    <link href="Css/Changepassword.css" rel="stylesheet" type="text/css" />
    <link href="Css/HomeSPD.css" rel="stylesheet" type="text/css" />
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
</head>


<body>
    <form id="form1" runat="server">
        
        <div>
            <center>
                <div class="HD1" >
                    <asp:Label ID="LblOris" runat="server" Text="CovaiSmart" Font-Bold="true" Font-Names="Cooper Black" Font-Size="XX-Large"></asp:Label>
                    <br />
                    
                    <asp:Label ID="Label4" runat="server" Text="Online Residents Information System  for Retirement Communities" Font-Bold="false" Font-Names="calibri" Font-Size="Medium"></asp:Label>

                </div>
            </center>
            
            <div class="pswmain_cnt">
                <div class="pswfirst_cnt">


                    <center>
                        <div class="Cpwd_HD">
                            <table style="font-family: Calibri; font-size: large; font-weight: bold; color: White">
                                <tr>
                                    <td>Change Password
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </center>
                    <br />



                    <table style="font-family: Calibri; font-size: small; font-weight: normal">

                        <tr>
                            <td>
                                <asp:Label ID="lbluserid" runat="Server" Text="UserID" ForeColor=" Black " Font-Names="calibri"
                                    Font-Size="Medium">UserID</asp:Label>
                                <asp:Label ID="Label6" ForeColor="#FF3300" runat="server" Text="*">
                                </asp:Label>
                            </td>
                            <td width="30px">
                                
                            </td>
                            <td>
                                <asp:TextBox ID="TxtUserId" ReadOnly="true" runat="Server" MaxLength="18" ToolTip=" Please enter your UserID." Width="200px"
                                    ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCurrentPassword" runat="Server" Text="Current Password" ForeColor=" Black " Font-Names="calibri"
                                    Font-Size="Medium ">Current Password</asp:Label>
                                <asp:Label ID="Label3" ForeColor="#FF3300" runat="server" Text="*">
                                </asp:Label>
                            </td>
                            <td width="30px">
                                
                            </td>
                            <td>
                                <asp:TextBox ID="TxtCurrentPassword" runat="Server" MaxLength="10" TextMode="Password" ToolTip=" Please enter your current password." Width="200px"
                                    ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblNewPassword" runat="Server" Text="RACode" ForeColor=" Black " Font-Names="calibri"
                                    Font-Size="Medium">New Password</asp:Label>
                                <asp:Label ID="Label7" ForeColor="#FF3300" runat="server" Text="*">
                                </asp:Label>
                            </td>
                            <td width="30px">
                               

                            </td>
                            <td>
                                <asp:TextBox ID="TxtNewpassword" runat="Server" MaxLength="10" TextMode="Password" ToolTip=" Please enter your new password." Width="200px"
                                    ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblConfirmPassword" runat="Server" Text="Description" ForeColor=" Black "
                                    Font-Names="calibri" Font-Size="Medium ">Confirm Password</asp:Label>
                                <asp:Label ID="Label8" ForeColor="#FF3300" runat="server" Text="*">
                                </asp:Label>
                            </td>
                            <td width="30px">
                                
                            </td>
                            <td>
                                <asp:TextBox ID="TxtConfirmPwd" runat="Server" MaxLength="10" TextMode="Password" ToolTip=" Confirm your new password." Width="200px"
                                    ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                            </td>

                        </tr>


                    </table>


                    <center>
                        <table>


                            <tr>
                                <td>
                                    <asp:Button ID="btnChange" runat="Server" Width="90px" Text="Change" ToolTip="Click here to Change Password" OnClick="btnChange_Click"
                                        CssClass="btn btn-primary btn-large btn-block" />

                                </td>
                                <td>

                                    <asp:Button ID="btnClose" runat="Server" Width="90px" Text="Close" ToolTip="Click here to Close" OnClick="btnClose_Click"
                                        CssClass="btn btn-primary btn-large btn-block" />
                                </td>
                            </tr>

                        </table>
                    </center>
                    <br />
                </div>
            </div>
            <div style="margin-top: 21%;"></div>

        </div>
        <div class="Footer">
            <p>
                 <asp:LinkButton ID="LinkButton1" runat="server" Text ="Software designed with care by Innovatus Systems for Retirement Communities." ForeColor="White" Font-Bold="false" Font-Names="Calibri" Font-Size="Medium" Font-Underline ="false" OnClick="LinkButton1_Click"></asp:LinkButton>
            </p>
        </div>

    </form>
</body>
</html>
