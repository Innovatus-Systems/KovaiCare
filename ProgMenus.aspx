<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="ProgMenus.aspx.cs" Inherits="ProgMenus" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function SaveValidate() {


            var type = "";
            var summ = "";



            type += MenuType();

         
           


       if (type == "1") {

                summ += Group();
                summ += Title();


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

            else if (type == "0")
            {
                summ += TitleGroup();

               
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

            else {
                alert("Please select the menu type");
            }
        }
        
        


        function MenuType() {
            var MenuType = document.getElementById('<%= ddlType.ClientID %>').value;
            if (MenuType == "--Select--") {
                return "Please select a type." + "\n";
            } else {
                return MenuType;
            }
        }


        function Group() {
            var Group = document.getElementById('<%= ddlGroup.ClientID %>').value;
            if (Group == "--Select--") {
                return "Please select a group." +  "\n";
            } else {
                return "";
            }
        }

        function TitleGroup() {
            var TitleGroup = document.getElementById('<%= txtGroup.ClientID %>').value;
            if (TitleGroup == "") {
                return "Please enter the group title." + "\n";
            } else {
                return "";
            }
        }
        
        function Title() {
            var Title = document.getElementById('<%= txtTitle.ClientID %>').value;

            if (Title == "") {
                return "Please enter the title of the menu";
            }
            else {
                return "";
            }

        }

        
    </script>

     <script type="text/javascript">
         function UpdateValidate() {
             var type = "";
             var summ = "";



             type += MenuType();





             if (type == "1") {

                 summ += Group();
                 summ += Title();


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

             else if (type == "0") {
                 summ += TitleGroup();


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

             else {
                 alert("Please select the menu type");
             }
         }




         function MenuType() {
             var MenuType = document.getElementById('<%= ddlType.ClientID %>').value;
             if (MenuType == "--Select--") {
                 return "Please select a type." + "\n";
             } else {
                 return MenuType;
             }
         }


         function Group() {
             var Group = document.getElementById('<%= ddlGroup.ClientID %>').value;
             if (Group == "--Select--") {
                 return "Please select a group." + "\n";
             } else {
                 return "";
             }
         }

         function TitleGroup() {
             var TitleGroup = document.getElementById('<%= txtGroup.ClientID %>').value;
             if (TitleGroup == "") {
                 return "Please enter the group title." + "\n";
             } else {
                 return "";
             }
         }

         function Title() {
             var Title = document.getElementById('<%= txtTitle.ClientID %>').value;

             if (Title == "") {
                 return "Please enter the title of the menu";
             }
             else {
                 return "";
             }

        }


    </script>
     <style>
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
    

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt"  >
        <div class="first_cnt"  style="min-height:425px">
            <div style="font-family: Verdana; font-size: small; ">
                <asp:HiddenField ID="hbtnRSN" runat="server" />

                <table style="width: 100%;">
                    <tr>
                        <td align="Center">

                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                        </td>
                    </tr>
                </table>


                <table style="width: 100%;">
                    <tr>
                        <td>
                            <asp:HiddenField ID="CnfResult" runat="server" />
                        </td>
                    </tr>

                    <tr style="width: 100%;">

                        <td style="width: 40%; vertical-align:top; ">
                            <table cellspacing="5" cellpadding="5">

                                 <tr>
                                    <td style="font-family:Verdana">Type :
                                        <text style="color: red;">*</text>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlType" runat="server" ToolTip="Class means create a group and Menu means create a Sub menu" CssClass="form-control" Width="150px" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true" >
                                            <asp:ListItem Text="--Select--" Value="--Select--"></asp:ListItem>
                                            <asp:ListItem Text="Group" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Menu" Value="1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>

                                </tr>
                                 <tr>

                                    <td>
                                        <asp:Label ID="lblcGroup" Width="170px" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlGroup" runat="server" ToolTip="Please select group of menu." CssClass="form-control" Width="150px" >
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                         <asp:Label ID="lblctGroup" Width="170px" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtGroup" runat="server"  CssClass="form-control" Width="150px" MaxLength="80" ToolTip="Enter the menus group."></asp:TextBox>
                                   </td>
                                </tr>
                                <tr>

                                    <td>
                                         <asp:Label ID="lblcTitle" Width="170px" runat="Server" Text="Title" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" Width="150px" MaxLength="80" ToolTip="Enter the menu title."></asp:TextBox>

                                    </td>

                                </tr>

                                <tr>
                                    <td style="font-family:Verdana">
                                        <text>Department :</text>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDepartment" ToolTip="Define the deparment." runat="server" Width="150px" CssClass="form-control" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" AutoPostBack="true">
                                       </asp:DropDownList>
                                    </td>
                                </tr>
                                 <tr>
                                    <td>                                        
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDepartment" runat="server" ToolTip="Selection department code listed here." TextMode="MultiLine" CssClass="form-control" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                    </td>
                                </tr>

                                <tr>
                                    <td style="font-family:Verdana">Description :                                        
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtdesc" runat="server" ToolTip="Please enter description about the menu." TextMode="MultiLine" CssClass="form-control" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>

                                    <td style="font-family:Verdana">Visibility :
                                        <text style="color: red;">*</text>
                                    </td>
                                    <td>
                                        
                                        <asp:DropDownList ID="ddlVisibility" runat="server" ToolTip="Please select the visibility type of the menu." CssClass="form-control" Width="150px" >
                                            <asp:ListItem Text ="Not Visible" Value="0"></asp:ListItem>
                                            <asp:ListItem Text ="Visible" Value="1"></asp:ListItem>
                                            <asp:ListItem Text ="Highlight" Value="2"></asp:ListItem>
                                        </asp:DropDownList>

                                    </td>

                                </tr>

                                <tr>
                                    <td colspan="2" align="center">
                                        <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the menu details." OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn btn-success" />
                                        <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the menu details." OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn btn-success" />
                                        <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn btn-default" OnClick="btnClear_Click" />
                                        <asp:Button ID="btnReturn" ToolTip="Click here to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" CssClass="btn btn-default"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 60%; vertical-align: middle;">
                            <telerik:RadGrid ID="gvMenu" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                AutoGenerateColumns="false" OnItemCommand="gvMenu_ItemCommand" Width="700px" AllowFilteringByColumn="true" OnInit="gvMenu_Init" >
                                   <ClientSettings>
                                        <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the Prog menu details" runat="server" Text="Edit" 
                                                    CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("MenuID") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                         <telerik:GridBoundColumn HeaderText="Group" HeaderStyle-Width="100px" DataField="Group" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Title" HeaderStyle-Width="100px" DataField="Title" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Department" HeaderStyle-Width="150px" DataField="Department" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Description" HeaderStyle-Width="150px" DataField="Description" ReadOnly="true"></telerik:GridBoundColumn>
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

