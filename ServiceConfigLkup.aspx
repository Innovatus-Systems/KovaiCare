<%@ Page Title="Service Config Lookup" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ServiceConfigLkup.aspx.cs" Inherits="ServiceConfigLkup" %>

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
            summ += DoorNoVal();
            
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
            summ += DoorNoVal();

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
            var CodeVal = document.getElementById('<%= txtcode.ClientID %>').value;
            if (CodeVal == "") {
                return "Please enter the Service code." + "\n";
            } else {
                return "";
            }
        }
        function DoorNoVal() {
            var door = document.getElementById('<%= txtServiceCat.ClientID %>').value;
            if (door == "") {
                return "Please enter the Service Category." + "\n";
            } else {
                return "";
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
                                <td style="width: 40%;">
                                    <table cellspacing="5" cellpadding="5">
                                        
                                        <tr>
                                            <td>Code :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtcode" runat="server" Width="100" CssClass="form-controlForResidentAdd" MaxLength="2" ToolTip="Assign a unique two character code for the Service Category."></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Service Category :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtServiceCat" runat="server" Width="250" CssClass="form-controlForResidentAdd" MaxLength="40" ToolTip="This is used when assigning housekeeping tasks or when positng service requests from residents."></asp:TextBox>
                                            </td>
                                        </tr>
                                       
                                        <%-- <tr>
                                            <td>Service Type :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtsertype" runat="server" Width="250" Height="20" MaxLength="80" ToolTip="Please enter service type.ML 80."></asp:TextBox>
                                            </td>
                                        </tr>--%>
                                        
                                        <tr>
                                            <td>Department Name :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddldeptname" Font-Names="verdana" CssClass="form-controlForResidentAdd"  runat="server" ToolTip="Which department covers this category of service?  If you do not find a department here, add it first in Departments Lookup."></asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Description :                                        
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtdesc" Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" ToolTip=" Brief description about the category of service.ML2400." TextMode="MultiLine" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
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
                                        <tr>
                                            <td colspan ="2">
                                                <asp:Label ID="Label1" runat="server" Text="Define a department first. Next add all service categories that are performed by that dept. Once this step is done, add various service requests under each service category" Font-Bold="false" ForeColor="Black" Font-Size="Small"></asp:Label><br />
                                                <%--<asp:Label ID="Label2" runat="server" Text="Department  >  Service Categories  provided by a dept.  >>>   Service Types  within a category." Font-Bold="false" ForeColor="Black" Font-Size="Small"></asp:Label><br/>
                                                <asp:Label ID="Label3" runat="server" Text="You can define the different service types only after defining the categories here." Font-Bold="false" ForeColor="Black" Font-Size="Small"></asp:Label>--%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 60%; vertical-align: top;">
                                    <br />
                                    <br />
                                    <telerik:RadGrid ID="gvService" MasterTableView-ShowHeadersWhenNoRecords="true" GroupingSettings-CaseSensitive="false" Skin="WebBlue" 
                                        AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="gvService_ItemCommand" Width="700px"
                                         AllowFilteringByColumn="true" AllowPaging="false" OnInit="gvService_Init" >
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
                                                <telerik:GridBoundColumn HeaderText="Department" HeaderStyle-Width="100px" DataField="DeptName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Code" HeaderStyle-Width="100px" DataField="Code" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Category" HeaderStyle-Width="100px" DataField="Category" ReadOnly="true"></telerik:GridBoundColumn>
                                                
                                                
                                                <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="150px" DataField="Description" ReadOnly="true"></telerik:GridBoundColumn>
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

