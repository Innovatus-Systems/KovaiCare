<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="UserManagement.aspx.cs" Inherits="UserManagement" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.10.2.js"></script>
    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += NameVal();
            summ += DesigVal();
            summ += MobileVal();
            summ += UserIDVal();
            //summ += PwdVal();
            if (summ == "") {
                var prof = $("[id*='ddlProfile']").val();
                var kitchen = $("[id*='ddlKitchen']").val();
                var rep = $("[id*='ddlReports']").val();
                var accs = $("[id*='ddlAccounts']").val();
                var sett = $("[id*='ddlSettings']").val();
                var care = $("[id*='ddlCare']").val();
                var tasks = $("[id*='ddlTasks']").val();
                var events = $("[id*='ddlEvents']").val();
                //alert(prof);
                if (prof == 'N' && kitchen == 'N' && rep == 'N' && accs == 'N' && sett == 'N' && care == 'N' && tasks == 'N' && events == 'N') {
                    var x = confirm('You have not allowed access to any module. Is it Ok? Or Press OK to confirm.?');
                    if (x) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    var x = confirm('Do you want to save?');
                    if (x) {
                        return true;
                    } else {
                        return false;
                    }
                }

            } else {
                alert(summ);
                return false;
            }
        }
        function NameVal() {
            var Nme = document.getElementById('<%=txtName.ClientID %>').value;
            if (Nme == "") {
                return "Please Enter Name " + "\n";
            } else {
                return "";
            }
        }
        function DesigVal() {
            var Nme = document.getElementById('<%=txtDesig.ClientID %>').value;
            if (Nme == "") {
                return "Please Enter Designation " + "\n";
            } else {
                return "";
            }
        }
        function MobileVal() {
            var Nme = document.getElementById('<%=txtMobno.ClientID %>').value;
            if (Nme == "") {
                return "Please Enter Mobile No " + "\n";
            } else {
                return "";
            }
        }
        function UserIDVal() {
            var Nme = document.getElementById('<%=txtUserID.ClientID %>').value;
            if (Nme == "") {
                return "Please Enter User ID " + "\n";
            } else {
                return "";
            }
        }
        function PwdVal() {
            var Nme = document.getElementById('<%=txtpwd.ClientID %>').value;
            if (Nme == "") {
                return "Please Enter Password " + "\n";
            } else {
                return "";
            }
        }
        function ConfirmReset() {
            var x = confirm('Do you want to Reset your password?');
            if (x) {
                return true;
            } else {
                return false;
            }
        }
        function ConfirmMsg() {
            var prof = $("[id*='ddlProfile']").val();
            var kitchen = $("[id*='ddlKitchen']").val();
            var rep = $("[id*='ddlReports']").val();
            var accs = $("[id*='ddlAccounts']").val();
            var sett = $("[id*='ddlSettings']").val();
            var care = $("[id*='ddlCare']").val();
            var tasks = $("[id*='ddlTasks']").val();
            var events = $("[id*='ddlEvents']").val();
            //alert(prof);
            if (prof == 'N' && kitchen == 'N' && rep == 'N' && accs == 'N' && sett == 'N' && care == 'N' && tasks == 'N' && events == 'N') {
                var x = confirm('You have not allowed access to any module. Is it Ok? Or Press OK to confirm.?');
                if (x) {
                    return true;
                } else {
                    return false;
                }
            } else {
                var x = confirm('Do you want to Update?');
                if (x) {
                    return true;
                } else {
                    return false;
                }
            }
        }
    </script>
     <style type="text/css">
        .form-controlForResidentAdd {
  /*display: block;*/
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

        .roundedcorner {
            background: #fff;
            font-family: Times New Roman, Times, serif;
            font-size: 11pt;
            margin-left: auto;
            margin-right: auto;
            margin-top: 1px;
            margin-bottom: 1px;
            padding: 3px;
            border-top: 1px solid #CCCCCC;
            border-left: 1px solid #CCCCCC;
            border-right: 1px solid #999999;
            border-bottom: 1px solid #999999;
            -moz-border-radius: 8px;
            -webkit-border-radius: 8px;
        }
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 100%; font-family: Verdana; font-size: small;">
                <asp:HiddenField ID="htbnRSN" runat="server" />
                <asp:HiddenField ID="hbtnpwd" runat="server" />
                <table style="width: 100%;">
                    <tr>
                        <td align="center">
                            
                             <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                        </td>
                    </tr>                 
                    <tr style="width: 100%;">
                        <td>
                            <table cellspacing="5px" cellpadding="5px" style="width: 100%; font-family: Verdana; font-size: smaller;">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblName" runat="Server" Font-Bold="true" Text="Name:" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                        <text style="color: red;">*</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtName" TabIndex="1" runat="Server" MaxLength="40" CssClass="form-controlForResidentAdd" Width="250px" ToolTip="Please enter the user name.ML40." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label2" runat="Server" Font-Bold="true" Text="Email ID :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEmailid" TabIndex="8" runat="Server" MaxLength="120" ToolTip="Please enter Email id.ML120." CssClass="form-controlForResidentAdd" Width="250px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                    </td>
                                   
                                </tr>
                               <%-- <tr>
                                    <td></td>
                                    <td></td>
                                    <td colspan="2">
                                        <text style="color: gray;">Allow or deny access to these modules of ORIS</text>
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDesignation" runat="Server" Font-Bold="true" Text="Designation:" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                        <text style="color: red;">*</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDesig" runat="Server" TabIndex="2" MaxLength="80" ToolTip="Please enter the user's designation.ML80." Width="250px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblProfile" runat="Server" Font-Bold="true" Text="Department:" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                     <td>
                                        <asp:DropDownList ID="ddlDepartment" CssClass="form-controlForResidentAdd" ToolTip="Define the deparment of the asset so that it is easy to locate it later." runat="server" Width="150px">
                                       </asp:DropDownList>
                                    </td>
                                   

                                    <%--<td>
                                        <asp:Label ID="lblProfile" runat="Server" Font-Bold="true" Text="Profile:" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlProfile" runat="Server" TabIndex="10" ToolTip="No - Do not allow access, Yes- Allow, View – User can view but cannot edit" Height="23px" Width="120px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="View" Value="V"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblKitchen" runat="Server" Font-Bold="true" Text="Kitchen:" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlKitchen" runat="Server" TabIndex="11" ToolTip="No - Do not allow access, Yes- Allow, View – User can view but cannot edit" Height="23px" Width="120px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="View" Value="V"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>--%>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblLandlineNo" runat="Server" Font-Bold="true" Text="Landline No:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtLandline" runat="Server" TabIndex="3" MaxLength="12" ToolTip="Enter Landline no.ML12." CssClass="form-controlForResidentAdd" Width="250px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                    </td>
                                    
                                    <td>
                                        <asp:Label ID="lblStatus" runat="Server" Font-Bold="true" Text="Status:" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSTatus" runat="Server" TabIndex="9" CssClass="form-controlForResidentAdd" ToolTip="Define User Status" Width="120px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="InActive" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <%--<td>
                                        <asp:DropDownList ID="ddlReports" runat="Server" TabIndex="12" ToolTip="No - Do not allow access, Yes- Allow, View – User can view but cannot edit" Height="23px" Width="120px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="View" Value="V"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblEvents" Font-Bold="true" runat="Server" Text="Events :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlEvents" runat="Server" TabIndex="13" ToolTip="No - Do not allow access, Yes- Allow, View – User can view but cannot edit" Height="23px" Width="120px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="View" Value="V"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>--%>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="Server" Font-Bold="true" Text="Mobile No:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                        <text style="color: red;">*</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMobno" runat="Server" TabIndex="4" MaxLength="12" ToolTip="Enter Mobile no.ML12." CssClass="form-controlForResidentAdd" Width="250px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                    </td>
                                    <td></td>
                                    <td></td>
                                   <%-- <td>
                                        <asp:Label ID="lblAccounts" Font-Bold="true" runat="Server" Text="Accounts:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlAccounts" runat="Server" TabIndex="14" ToolTip="No - Do not allow access, Yes- Allow, View – User can view but cannot edit" Height="23px" Width="120px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="View" Value="V"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblSettings" Font-Bold="true" runat="Server" Text="Admin/Settings:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSettings" runat="Server" TabIndex="15" ToolTip="No - Do not allow access, Yes- Allow, View – User can view but cannot edit" Height="23px" Width="120px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="View" Value="V"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>--%>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAddress1" runat="Server" Font-Bold="true" Text="Address1:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddr1" runat="Server" TabIndex="5" MaxLength="80" ToolTip="Enter Address1.ML80." Width="250px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                    <td></td>
                                    <td></td>
                                   <%-- <td>
                                        <asp:Label ID="lblCare" Font-Bold="true" runat="Server" Text="Care :" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCare" runat="Server" TabIndex="16" ToolTip="No - Do not allow access, Yes- Allow, View – User can view but cannot edit" Height="23px" Width="120px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="View" Value="V"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblTasks" Font-Bold="true" runat="Server" Text="Tasks :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTasks" runat="Server" TabIndex="17" ToolTip="No - Do not allow access, Yes- Allow, View – User can view but cannot edit" Height="23px" Width="120px" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small">
                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                            <asp:ListItem Text="View" Value="V"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>--%>

                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAddr2" runat="Server" Font-Bold="true" Text="Address2:" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddr2" runat="Server" TabIndex="6" MaxLength="160" ToolTip="Enter Address2.ML160." Width="250px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" CssClass="form-controlForResidentAdd" Height="50px"></asp:TextBox>
                                    </td>
                                    <td align="right">
                                        <asp:Button ID="btnSave" TabIndex="18" OnClientClick="return Validate();" OnClick="btnSave_Click" runat="Server"  Text="Save" ToolTip="Clik here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names="Verdana" Font-Size="Small" CssClass="btn" />
                                        <asp:Button ID="btnUpdate" TabIndex="19" OnClick="btnUpdate_Click" OnClientClick="return ConfirmMsg();" runat="Server"  Text="Update" ToolTip="Clik here to update the details" ForeColor="White" BackColor="DarkGreen" Font-Names="Verdana" Font-Size="Small" CssClass="btn"/>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnClear" TabIndex="20" OnClick="btnClear_Click" runat="Server"  Text="Clear" ToolTip=" Clik here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Verdana" Font-Size="Small" CssClass="btn"/>
                                        <asp:Button ID="btnExit" TabIndex="21" runat="Server" OnClick="btnExit_Click" Text="Return" ToolTip="Clik here to exit" ForeColor="White" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="Small" CssClass="btn"/>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnReset" OnClick="btnReset_Click" OnClientClick="return ConfirmReset();" runat="Server"  Text="Reset Password" ToolTip="Clik here to reset your password" ForeColor="White" BackColor="DarkGreen" Font-Names="Verdana" Font-Size="Small" CssClass="btn"/>
                                    </td>
                                </tr>
                                <tr>
                                    <asp:UpdatePanel ID="upnlmain" runat="server" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <td>
                                                <asp:Label ID="lblUserID" runat="Server" Font-Bold="true" Text="User ID :" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <text style="color: red;">*</text>
                                            </td>
                                            <td colspan="2">
                                                <asp:TextBox ID="txtUserID" TabIndex="7" AutoPostBack="true" OnTextChanged="txtUserID_TextChanged" runat="Server" MaxLength="8" CssClass="form-controlForResidentAdd" Width="250px" ToolTip="Must be 4 – 8 Characters  and Unique.Password is same as User ID for a new user who must change it on first access." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox> 
                                                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                                            </td>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" Visible="false" runat="Server" Font-Bold="true" Text="Password:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                        <%-- <text style="color: red;">*</text>--%>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtpwd" Enabled="false" Visible="false" TextMode="SingleLine" runat="Server" MaxLength="20" CssClass="form-controlForResidentAdd" Width="250px" ToolTip="Password is same as User ID.ML20." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                    </td>
                                </tr>
                                </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" align="left">
                            <telerik:RadGrid ID="gvUsers" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" 
                                OnItemCommand="gvUsers_ItemCommand" Width="700px" AllowFilteringByColumn="true" AllowPaging="true" 
                                PageSize="10" OnInit="gvUsers_Init">
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the user details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderStyle-Width="200px" HeaderText="Name" DataField="Name" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Department" HeaderStyle-Width="100px" DataField="Department" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Designation" HeaderStyle-Width="100px" DataField="Designation" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="MobileNo" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" DataField="MobileNo" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="EmailID" HeaderStyle-Width="150px" DataField="EmailID" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="Status" ReadOnly="true"></telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

