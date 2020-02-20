<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConfirmDiningR.aspx.cs" Inherits="ConfirmDiningR" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Confirm Dining- R</title>
    <link href="CSS/HomeSPD.css" rel="stylesheet" />
    <script src="JQuery/jquery1.9.1.js" type="text/javascript"></script>
    <script src="JQuery/jquery-1.10.3.js" type="text/javascript"></script>
    <link href="CSS/MenuCSS.css" rel="stylesheet" />
    <link href="CSS/Fix.css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">

        function TaskConfirmMsg() {

            var result = confirm('Do you want to update your dining?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }
        </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="CnfResult" runat="server" />
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div style="background-color: #4D94DB; width: 100%">
            <table style="width: 100%">
                <tr>
                    <td style="width: 20%">

                        <asp:Label ID="lblcomName" runat="server" Text="" Font-Bold="true" Font-Names="Cooper Black" Font-Size="Large" ForeColor="White"></asp:Label>

                    </td>
                    <td style="text-align: center; width: 60%">

                        <asp:Label ID="LblOris" runat="server" Text="CovaiSmart" Font-Bold="true" Font-Names="Cooper Black" Font-Size="Large" ForeColor="White"></asp:Label>
                        <br />
                        <asp:Label ID="LblSubTitle" runat="server" Text="Online Residents Information System  for Retirement Communities" ForeColor="White" Font-Bold="false" Font-Names="Calibri" Font-Size="Medium"></asp:Label>

                    </td>
                    <td style="width: 20%; text-align: right">

                        <asp:Label ID="lblversionnumber" runat="server" Text="" Font-Bold="true" Font-Names="Cooper Black" Font-Size="Large" ForeColor="White"></asp:Label>

                    </td>
                </tr>
            </table>
        </div>
        <div style="width: 100%;">
            <table style="width: 100%;">
                <tr>
                    <td style="text-align: center" colspan="2">
                        <asp:Label ID="Label8" runat="server" Text="Confirm Dining - R" Font-Bold="true" ForeColor="Blue"></asp:Label>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblcsession" runat="server" Text="" Font-Names="Verdana"  Font-Bold="true" ForeColor="DarkBlue" Font-Size="Large"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br />
                        <asp:Label ID="lblcbirthday" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" Font-Underline ="true" ForeColor="DarkGreen" Font-Size="Medium"></asp:Label>
                    </td>

                </tr>
                <tr>
                    <td colspan="2">
                       
                        <asp:Label ID="lblcevents" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" Font-Underline ="true" ForeColor="Maroon" Font-Size="Medium"></asp:Label>
                         <br />
                    </td>

                </tr>
            </table>
            <table style="width: 100%;" >
                <tr>
                    <td style="width:70%">
                        <table  style="border-collapse: collapse;border: 1px solid black;" cellpadding="3px" >
                <%--<tr>
                    <td colspan="2">
                        <asp:Label ID="Label10" runat="server" Text="Please confirm your arrival here" Font-Names="Verdana" Font-Bold="true" ForeColor="Blue"></asp:Label>
                    </td>
                </tr>--%>
                <tr>
                    <td style="width: 300px">
                        <asp:Label ID="Label1" runat="server" Text="Please select your house number" Font-Names="Verdana" Font-Bold="true" ForeColor="DarkBlue"></asp:Label>
                    </td>
                    <td>
                        <table>
                            <tr>

                                <td style="text-align: center">
                                    <asp:CheckBox ID="chkRByDoorNo" runat="server" Text="By DoorNo" OnCheckedChanged="chkRByDoorNo_CheckedChanged" AutoPostBack="true" /><br />
                                    <asp:DropDownList ID="ddlRByDoorNo" ToolTip="Names of those who are booked for the sessions." Width="150px" Height="25px" runat="server"
                                        Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlRByDoorNo_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                                <td style="text-align: center">
                                    <asp:CheckBox ID="chkRByName" runat="server" Text="By Name" OnCheckedChanged="chkRByName_CheckedChanged" AutoPostBack="true" /><br />
                                    <asp:DropDownList ID="ddlRByName" ToolTip="Names of those who are booked for the sessions." Width="150px" Height="25px" runat="server"
                                        Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlRByName_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label12" runat="server" Text="Please enter your 4 digit PIN" Font-Names="Verdana" Font-Bold="true" ForeColor="DarkBlue"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPinNumber" runat="server"></asp:TextBox>

                        <asp:Button ID="btnOK" runat="server" Text="OK" Font-Size="Small" CssClass="ButtonRC" OnClick="btnOK_Click" ToolTip="" />

                    </td>
                </tr>

                <tr>
                    <td></td>
                    <td >
                                    <asp:Label ID="lblDiner" runat="Server" Text="Residents" ForeColor="DarkBlue " Width="150px" Font-Bold="true"  Font-Names="Verdana" Font-Size="Medium "></asp:Label>

                                    <asp:DropDownList ID="ddlDiner" BackColor="Yellow" ToolTip="By default, the original booking count (which could be same as the no.of residents) is displayed.  Change if needed." Width="50px" Height="25px" runat="server"
                                        Font-Names="Calibri" Font-Size="Small">
                                        <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    </asp:DropDownList>

                                   

                                
                    </td>
                </tr>
                            <tr>
                                <td></td>
                                <td>
                                     <asp:Label ID="lblGuest" runat="Server" Text="Guests" ForeColor=" DarkGreen " Width="150px" Font-Bold="true" Font-Names="Verdana" Font-Size="Medium "></asp:Label>
                                    
                                    <asp:DropDownList ID="ddlGuest" BackColor="Yellow" ToolTip=" Did the resident have a guest today?  If so, enter it here.  By default the booking count is displayed." Width="50px" Height="25px" runat="server"
                                        Font-Names="Calibri" Font-Size="Small">
                                        <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                             <tr>
                                <td>

                                </td>
                                <td>
                                    <asp:Label ID="lblRName" runat="Server" Text="" ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Medium"></asp:Label>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>

                                </td>
                                <td>
                                    <asp:Label ID="Label2" runat="Server" Text="Shows Booking done by default. Change if needed." ForeColor="Gray"    Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td  align="center">
                                    <asp:Button ID="btnSave" runat="Server" Width="70px" Text="Confirm" ToolTip="Click here to save the details" ForeColor="White"  BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnSave_Click" OnClientClick="javascript:return TaskConfirmMsg()" />
                                </td>
                            </tr>
                            
                            </table>
                        </td>
                    <td style="width:30%">
                        <%--<telerik:RadGrid ID="rgTodaysMenu" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                            Height="350px" AllowSorting="true" AllowMultiRowSelection="true">
                                                           
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                            <ClientSettings>
                                                                <Selecting AllowRowSelect="true" />
                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true">
                                                                <PagerStyle Mode="NumericPages" />
                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                <RowIndicatorColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>

                                                                <Columns>

                                                                    <telerik:GridBoundColumn DataField="ItemName" HeaderText="Today's Menu" UniqueName="ItemName"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                                <Selecting AllowRowSelect="true"></Selecting>

                                                            </ClientSettings>
                                                        </telerik:RadGrid>--%>

                        <%--<telerik:RadGrid ID="rgTodaysMenu" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                            Height="350px" AllowSorting="true" AllowMultiRowSelection="true">
                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true">
                                <Columns>
                                     <telerik:GridBoundColumn DataField="ItemName" HeaderText="Todays Menu" UniqueName="ItemName"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                </Columns>
                             </MasterTableView>
                            </telerik:RadGrid>--%>


                        <asp:GridView ID="gvTodaysMenu" runat="server" AutoGenerateColumns="false" HeaderStyle-BackColor ="#4D94DB">
                            <Columns>
                                <asp:BoundField DataField="ItemName" ItemStyle-HorizontalAlign ="Left" HeaderText ="TodaysMenu" />
                            </Columns>
                        </asp:GridView>
                    </td>
                    </tr>
            </table>

        </div>
    </form>
</body>
</html>
