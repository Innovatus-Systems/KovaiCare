<%@ Page Title="Department Lookup" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DeptLkup.aspx.cs" Inherits="DeptLkup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
      <style type="text/css">

    .RadGrid th.rgHeader
    {
        background-image: none;
        background-color:  #196F3D;
        color:white;
        font-weight:bold;
    }
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
</style>
    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += CodeVal();
            summ += NameVal();
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
        function CodeVal() {
            var door = document.getElementById('<%= txtcode.ClientID %>').value;
            if (door == "") {
                return "Please enter the department code" + "\n";
            } else {
                return "";
            }
        }
        function NameVal() {
            var door = document.getElementById('<%= txtdeptname.ClientID %>').value;
            if (door == "") {
                return "Please enter the department name" + "\n";
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="font-family: Verdana; font-size: small;">
                        <asp:HiddenField ID="hbtnRSN" runat="server" />


                        <table style="width:100%">
                            <tr>
                                <td align="center">
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr style="width: 100%;">
                                <td style="width: 40%;vertical-align:top">
                                    <table cellspacing="5" cellpadding="5">

                                        <tr>
                                            <td>Code :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtcode" runat="server" CssClass="form-controlForResidentAdd" Width="250" MaxLength="2" ToolTip="Enter a unique code, each department is identified by a unique code of 2 characters."></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Department Name :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtdeptname" runat="server" CssClass="form-controlForResidentAdd" Width="250" MaxLength="80" ToolTip="Enter the name of the department, Ex. Housekeeping, Facilities.ML 80."></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Contact No :                                       
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtcno" runat="server" CssClass="form-controlForResidentAdd" Width="250" MaxLength="15" ToolTip="Enter the main mobile number of the department. Useful for SMS communication.ML 15."></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Description :                                        
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtdesc" Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Please enter description about department.ML2400." TextMode="MultiLine" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="return Validate();" ToolTip="Click here to save the department details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" CssClass="btn" />
                                                <asp:Button ID="btnUpdate" OnClientClick="return ConfirmUpdate();" ToolTip="Click here to update the department details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" CssClass="btn" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" CssClass="btn" OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" CssClass="btn" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="Label1" runat="server" Text="Define the different departments in the community.  One department can offer multiple services.
Define the Service Types after you define the departments."
                                                    Font-Bold="false" ForeColor="Black" Font-Size="Small"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 60%; vertical-align:top;">
                                    
                                    <telerik:RadGrid ID="gvDept" MasterTableView-ShowHeadersWhenNoRecords="true" GroupingSettings-CaseSensitive="false" Skin="WebBlue" 
                                        AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="gvDept_ItemCommand" Width="700px" 
                                        AllowFilteringByColumn="true" AllowPaging="true" PageSize="10" OnInit="gvDept_Init">
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the department details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <%--<telerik:GridBoundColumn HeaderStyle-Width="200px" HeaderText="Door No" DataField="DoorNo" ReadOnly="true"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Code" HeaderStyle-Width="100px" DataField="Code" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DeptName" HeaderStyle-Width="100px" DataField="DeptName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Contact No" HeaderStyle-Width="150px" DataField="MobileNo" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="150px" DataField="Details" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

