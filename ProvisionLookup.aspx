<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProvisionLookup.aspx.cs" Inherits="ProvisionLookup" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
     <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
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
            var SiteName = document.getElementById('<%= txtPcode.ClientID %>').value;
            if (SiteName == "") {
                return "Please enter the Provision Group.";
            } else {
                return "";
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt" style="min-height: 485px">



            <div style="font-family: Verdana; font-size: small;">
                <asp:HiddenField ID="hbtnRSN" runat="server" />

                <table style="width: 100%;">
                    <tr>
                        <td align="center">

                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                        </td>
                    </tr>
                </table>

                <table style="width: 70%;" align="center">

                    <tr>
                        <td>
                            <table>

                                <tr>
                                    <td>
                                        <asp:HiddenField ID="CnfResult" runat="server" />
                                    </td>
                                </tr>
                                <tr>

                                    <td> Group :
                                        <text style="color: red;">*</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPcode" runat="server" CssClass="form-controlForResidentAdd" Width="250px" MaxLength="20" ToolTip="Please enter the Provision Group.Max length is 20 character."></asp:TextBox>
                                        <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                                    </td>

                                </tr>
                                <tr>
                                    <td>Description :   <text style="color: red;">*</text>                                     
                                    </td>
                                    <td>
                                        
                                        <asp:TextBox ID="txtPdesc" runat="server"   CssClass="form-controlForResidentAdd" Width="250px" ToolTip="To determine which group should be shown first and second and so on."  ></asp:TextBox>
                                    </td>
                                </tr>



                                <tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click to save Provision Group details" OnClick="btnSave_Click" CssClass="btn btn-success" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" />
                                        <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click to Provision Group details" OnClick="btnUpdate_Click" CssClass="btn btn-success" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px"  />
                                        <asp:Button ID="btnClear" ToolTip="Click to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" CssClass="btn btn-default" Width="90px" OnClick="btnClear_Click" />
                                        <asp:Button ID="btnReturn" ToolTip="Click to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" CssClass="btn btn-default" Width="90px"  />
                                    </td>
                                </tr>

                            </table>

                        </td>
                        <td style="vertical-align: top" align="Left">

                            <telerik:RadGrid ID="rgProvision" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgSite_ItemCommand" Width="80%" AllowPaging="true">
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the provision group details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Group" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="220px" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="220px" HeaderTooltip="The broad classification under which an item is placed.   Ex: Provisions for – Rice, Oil, Wheat, Dhal etc.,  Consumables for – Milk, Butter,  Plates, Spoon  etc. ,   Miscellaneous – Any thing else.">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnSiteName" runat="server" Text='<%# Eval("PCode") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="100px" DataField="PDescription" ReadOnly="true" HeaderTooltip="To determine which group should be shown first and second and so on."></telerik:GridBoundColumn>


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
