<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkTypeLkup.aspx.cs" Inherits="WorkTypeLkup" MasterPageFile="~/CovaiSoft.master" %>

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
        function SaveValidate() {
            var summ = "";
            summ += SiteName();
             

            if (summ == "") {
                var result = confirm('Do you want to save?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }


        function UpdateValidate() {
            var summ = "";
            summ += SiteName();


            if (summ == "") {
                var result = confirm('Do you want to update?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }
        function SiteName() {
            var SiteName = document.getElementById('<%= txtworktype.ClientID %>').value;
            if (SiteName == "") {
                return "Please enter the work type.";
            } else {
                return "";
            }
        }

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt" style="min-height:485px">
            <div style="font-family: Verdana; font-size: small;">
                <asp:HiddenField ID="hbtnRSN" runat="server" />

                <table style="width: 100%;">
                    <tr>
                        <td align="center">

                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                        </td>
                    </tr>
                </table>

                 <table style="width: 100%;">
                     
                     <tr>
                           <td>
                               <table>
                     
                      <tr>
                    <td>
                      <asp:HiddenField ID="CnfResult" runat="server" />
                    </td>
                    </tr>
                     <tr>
                                  
                                            <td>Code :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtworktype" runat="server" CssClass="form-controlForResidentAdd" Width="250px" MaxLength="20" ToolTip="Please enter the house keeping work type.ML20."></asp:TextBox>
                                                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                                            </td>
                            
                                </tr>
                           <tr>
                                    <td>Description :                                        
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtdesc" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Please enter the description about work type.ML2400." TextMode="MultiLine" Height="55px" Width="250px" MaxLength="240"></asp:TextBox>
                                    </td>
                                </tr>

                             

                           <tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the work type details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" CssClass="btn" />
                                        <asp:Button ID="btnUpdate"  OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the work type details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" CssClass="btn" />
                                        <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" CssClass="btn" OnClick="btnClear_Click" />
                                        <asp:Button ID="btnReturn" ToolTip="Click here to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" CssClass="btn" />
                                    </td>
                                </tr>

                                   </table>

                               </td>
                         <td style="vertical-align:top">

                              <telerik:RadGrid ID="rgProvision" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgSite_ItemCommand" Width="700px"  AllowPaging="true" PageSize="10">
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the provision group details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Schedule" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="100px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnSiteName" runat="server" Text='<%# Eval("WorkType") %>' ></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="250px" DataField="PDescription" ReadOnly="true"></telerik:GridBoundColumn>
                                        
                                       
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
