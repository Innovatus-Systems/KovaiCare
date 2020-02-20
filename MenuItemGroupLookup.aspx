<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/CovaiSoft.master" CodeFile="MenuItemGroupLookup.aspx.cs" Inherits="MenuItemGroupLookup" %>

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
           

            if (summ == "") {
                var result = confirm('Do you want to save?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                }
            } else {
                alert(summ);
                return false;
            }
        }


        function UpdateValidate() {
            var summ = "";
            summ += CodeVal();
           

            if (summ == "") {
                var result = confirm('Do you want to update?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                }
            } else {
                alert(summ);
                return false;
            }
        }


        function CodeVal() {
            var CodeVal = document.getElementById('<%= txtGroup.ClientID %>').value;
            if (CodeVal == "") {
                return "Please enter the Group Name." + "\n";
            } else {
                return "";
            }
        }
       

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt" style="min-height:430px">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="font-family: Verdana; font-size: small;">
                        <asp:HiddenField ID="hbtnRSN" runat="server" />
                         <asp:HiddenField ID="CnfResult" runat="server" />
                        
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
                                            <td>Group :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtGroup" runat="server" Width="250" CssClass="form-controlForResidentAdd" MaxLength="40" ToolTip="Have an option to add a new Group from within the Menu Item Option itself."></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Description :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDescription" runat="server" Width="250" CssClass="form-controlForResidentAdd" Height="60" MaxLength="240" TextMode="MultiLine" ToolTip="Enter the description of the group.ML 240."></asp:TextBox>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="return Validate();" ToolTip="Click here to save the service lookup details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" CssClass="btn" />
                                                <asp:Button ID="btnUpdate" OnClientClick="return UpdateValidate();" ToolTip="Click here to update the service lookup details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" CssClass="btn" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" CssClass="btn" OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" CssClass="btn" />
                                            </td>
                                        </tr>
                                       
                                    </table>
                                </td>
                                <td style="width: 60%; vertical-align: top;">
                                    
                                    <telerik:RadGrid ID="gvGroup" MasterTableView-ShowHeadersWhenNoRecords="true" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" 
                                        runat="server" AutoGenerateColumns="false" OnItemCommand="gvGroup_ItemCommand" 
                                        Width="700px" AllowFilteringByColumn="true" AllowPaging="false" PageSize="10" OnInit="gvGroup_Init">
                                         <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the service configuration details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Group" HeaderStyle-Width="100px" DataField="GroupName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="150px" DataField="Description" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnReturn" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>