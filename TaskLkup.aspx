<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="TaskLkup.aspx.cs" Inherits="TaskLkup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += TaskVal();
            summ += DescVal();
            if (summ == "") {
                var x = confirm('Do you want to save?');
                if (x) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }
        function TaskVal() {
            var door = document.getElementById('<%= txtTaskTitle.ClientID %>').value;
            if (door == "") {
                return "Please enter Task Title." + "\n";
            } else {
                return "";
            }
        }
        function DescVal() {
            var door = document.getElementById('<%= txtdesc.ClientID %>').value;
            if (door == "") {
                return "Please enter Description." + "\n";
            } else {
                return "";
            }
        }
        function ConfirmUpdate() {
            var x = confirm('Do you want to Update?');
            if (x) {
                return true;
            } else {
                return false;
            }
        }
        function ConfirmDelete() {
            var x = confirm('Do you want to Delete?');
            if (x) {
                return true;
            } else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server" >
    <div class="main_cnt">
        <div class="first_cnt" style="min-height:425px">
            <div style="width: 100%;">
                <asp:HiddenField ID="hbtnRSN" runat="server" />
                <table style="width: 100%; font-family: Verdana; font-size: small; min-height: 300px;">
                    <tr>
                        <td>
                           
                           <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ToolTip="Enter the task title" ></asp:LinkButton>
                        </td>
                    </tr>
                    <tr style="width: 100%;">
                        <td style="width: 50%;">
                            <table style="width: 100%;" cellspacing="5" cellpadding="5">
                                <tr>
                                    <td style="font-weight: bold;">Category :
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCategory" runat="server" Width="150px" Height="25px" ToolTip="Please select tasks lookup category">
                                            <asp:ListItem Text="Service Request" Value="RT"></asp:ListItem>
                                            <asp:ListItem Text="Complaint" Value="CT"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold;">Task Title :
                                        <text style="color: red; font-size: smaller;">*</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTaskTitle" runat="server" ToolTip="Please enter task title.ML.80" MaxLength="80" Width="300px" Height="20px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold;">Description :
                                        <text style="color: red; font-size: smaller;">*</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtdesc" runat="server" MaxLength="2400" ToolTip="Please enter description.ML240." TextMode="MultiLine" Width="300px" Height="60px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btnSave" OnClientClick="return Validate();" ToolTip="Click here to save the tasks lookup details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                        <asp:Button ID="btnUpdate" OnClientClick="return ConfirmUpdate();" ToolTip="Click here to update the tasks lookup details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                        <%--<asp:Button ID="btnDelete" Visible ="false" OnClientClick="return ConfirmDelete();" ToolTip="Click here to delete the tasks lookup" OnClick="btnDelete_Click" runat="server" Text="Delete" ForeColor="White" BackColor="DarkBlue" Width="90px" Height="25px" />--%>
                                        <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" Height="25px" OnClick="btnClear_Click" />
                                        <asp:Button ID="btnReturn" ToolTip="Click here to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" Height="25px" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 50%;">
                            <telerik:RadGrid ID="gvTaskLkup" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="gvTaskLkup_ItemCommand" Width="700px" AllowFilteringByColumn="true" AllowPaging="true" PageSize="10">
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the Villa details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="Category" DataField="Category" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Task Title" HeaderStyle-Width="100px" DataField="TaskTittle" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="200px" DataField="Message" ReadOnly="true"></telerik:GridBoundColumn>
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

