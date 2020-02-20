<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AccountMaster.aspx.cs" Inherits="AccountMaster" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <style>
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">


        function SaveValidate() {
            var vali = "";

            vali += AccountCode();
            vali += AccountName();
            vali += AccountGroup();


            if (vali == "") {
                var result = confirm('Do you want to save?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            }
            else {
                alert(vali);
                return false;
            }
        }

        function UpdateValidate() {
            var vali = "";


            vali += AccountCode();
            vali += AccountName();
            vali += AccountGroup();


            if (vali == "") {

                var result = confirm('Do you want to update?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            }
            else {
                alert(vali);
                return false;
            }
        }




        function AccountCode() {
            var Estimate = document.getElementById('<%= txtAccountCode.ClientID %>').value;

            if (Estimate == "") {
                return "Please enter the account code" + "\n";
            }
            else {
                return "";
            }
        }


        function AccountName() {
            var Estimate = document.getElementById('<%= txtAccountName.ClientID %>').value;

            if (Estimate == "") {
                return "Please enter the account name" + "\n";
            }
            else {
                return "";
            }
        }

        function AccountGroup() {
            var Estimate = document.getElementById('<%= ddlAccountGroup.ClientID %>').value;

            if (Estimate == "") {
                return "Please enter the account group" + "\n";
            }
            else {
                return "";
            }
        }



        <%--    function ShowHide()
        {
           
            if (document.getElementById('ShowHideDiv').style.display == '') {
              
                document.getElementById('ShowHideDiv').style.display = 'none';
                document.getElementById('<%= LnkSH.ClientID %>').innerText = 'Add Account Code';
            }
            else {
               
                document.getElementById('ShowHideDiv').style.display = '';
                document.getElementById('<%= LnkSH.ClientID %>').innerText = 'Hide';
                
            }
            return false;

            button.onclick = function () {
                var div = document.getElementById('ShowHideDiv');
                alert(div);
                if (div.style.display !== 'none') {
                    div.style.display = 'none';
                    document.getElementById('<%= LnkSH.ClientID %>').value = "Add Account Code";
                    
                }
                else {
                    div.style.display = 'block';
                    document.getElementById('<%= LnkSH.ClientID %>').value = "Hide";
                }
            };
        }--%>
        <%-- function Sitevali()
         {
             var Site = document.getElementById('<%= ddlSite.ClientID %>').value;

             console.log(Site);

             if (Site == "0")
             {
                 return "Please select the site" + "\n";
             }
             else {
                 return "";
             }
         }--%>

        
    </script>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <div class="main_cnt">
                <div class="first_cnt" style="min-height: 450px">
                    <div style="font-family: Verdana; font-size: small;">
                        <asp:HiddenField ID="hbtnRSN" runat="server" />
                        <asp:HiddenField ID="CnfResult" runat="server" />
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
                                    <telerik:RadWindow ID="rwAccountGroup" Width="450" Height="425px" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnShowAccountGroup.ClientID  %>" Title="Update Schedule" Modal="true">
                                        <ContentTemplate>

                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>

                                                    <div>
                                                        <table>

                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label13" runat="Server" Text="Group:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtAccountGroup" CssClass="form-control" runat="server" Width="220px" MaxLength="20" ToolTip="Enter the major group for facility"></asp:TextBox>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td colspan="2" align="center">
                                                                    <asp:Button ID="btnGroupSave" OnClientClick="javascript:return TaskConfirmMsg2()" ToolTip="Click here to add account group." OnClick="btnGroupSave_Click" runat="server" Text="Add" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                                                    <asp:Button ID="btnGroupClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" Height="25px" OnClick="btnGroupClear_Click" />
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td colspan="2">
                                                                    <telerik:RadGrid ID="rgAcccountGroup" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                                                        AutoGenerateColumns="false" Width="100%"
                                                                        AllowFilteringByColumn="true" AllowPaging="false">
                                                                        <ClientSettings>
                                                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />


                                                                        </ClientSettings>
                                                                        <MasterTableView>

                                                                            <CommandItemSettings ShowExportToCsvButton="true" />
                                                                            <Columns>
                                                                                <%-- <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the booking lookup deatails" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>--%>
                                                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                                                    <ItemTemplate>
                                                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RSN") %>' CommandArgument='<%# Eval("RSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                                                    </ItemTemplate>
                                                                                </telerik:GridTemplateColumn>

                                                                                <telerik:GridBoundColumn HeaderText="Group" HeaderStyle-Width="100px" DataField="AccountGroup" ReadOnly="true" FilterControlWidth="60px"></telerik:GridBoundColumn>

                                                                            </Columns>
                                                                        </MasterTableView>
                                                                    </telerik:RadGrid>

                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnGroupSave" />
                                                    <asp:PostBackTrigger ControlID="btnGroupClear" />
                                                </Triggers>
                                            </asp:UpdatePanel>


                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>
                            </table>

                                    <table style="width:75%" align="center">  
                                        
                                        <tr>                                          
                                       
                                            <td align="center" style="width:60%">
                                                <telerik:RadGrid ID="gvAccountMaster" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                                    AutoGenerateColumns="false" OnItemCommand="gvAccountMaster_ItemCommand" 
                                                    AllowFilteringByColumn="true" AllowPaging="false" OnInit="gvAccountMaster_Init">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />


                                                    </ClientSettings>
                                                    <MasterTableView>

                                                        <CommandItemSettings ShowExportToCsvButton="true" />
                                                        <Columns>
                                                            <telerik:GridTemplateColumn  AllowFiltering="false" HeaderStyle-Width="30px">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the lookup deatails" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("AccountsMRSN") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("AccountsMRSN") %>' CommandArgument='<%# Eval("AccountsMRSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>                                                           
                                                            <telerik:GridBoundColumn HeaderText="Category" HeaderStyle-Width="70px" DataField="AccountGroup" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Sub Grp1" HeaderStyle-Width="70px" DataField="SubGroup" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>                                                           
                                                            <telerik:GridBoundColumn HeaderText="Account Code" HeaderStyle-Width="70px" DataField="AccountCode" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Account Name" HeaderStyle-Width="150px" DataField="AccountName" ReadOnly="true" FilterControlWidth="90px"></telerik:GridBoundColumn>   
                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                                </td>
                                         
                                                
                                        </tr>
                                        <tr>
                       <td align="right" style="Width:90%;">
                            
                            <asp:Button ID="BtnExcelExport" AutoPostBack="true" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                                            </td>
                                            </tr>
                                         
                                    </table>
                   
                        
                    </div>
                    <div align="Left" style="width:83%">
                        <asp:LinkButton runat="server" ID="LnkSH" ToolTip="To add new Account." Text=" Add Account Code" OnClientClick="return ShowHide();" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </div>
                 
                        <table style="width:45%">
                        <tr>
                                <td  vertical-align: text-top">
                                    <table cellspacing="10" cellpadding="10">
                                        <tr>
                                            <td></td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="Server" Text="Account Code" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label4" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAccountCode" runat="server" CssClass="form-control" ToolTip="A GL Code not related to a resident, always starts with G1.  So when creating an account enter the next six characters (or) digits only.  
                                                    For a resident, the GL Codes are created automatically when a resident profile is added."
                                                    Width="250px" MaxLength="6"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label2" runat="Server" Text="Account Name" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label5" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAccountName" CssClass="form-control" runat="server" ToolTip="" Width="250px" MaxLength="80"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label6" runat="Server" Text="Account Group" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label8" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlAccountGroup" CssClass="form-control" runat="server" ToolTip="Choose the Account Group."  Width="175px" AutoPostBack="true">
                                                </asp:DropDownList>
                                                <asp:Button ID="btnShowAccountGroup" ToolTip="Click here to add a new account group." runat="server" Text="+" ForeColor="White" BackColor="DarkBlue" Width="30px" Height="25px" Visible="false"  OnClick="btnShowAccountGroup_Click" />
                                            </td>
                                        </tr>
                                         <tr>
                                            <td>
                                                <asp:Label ID="Label9" runat="Server" Text="Sub Group" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label10" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                             <td>
                                                <asp:DropDownList ID="drpSubgroup" CssClass="form-control" runat="server" ToolTip="Choose the Sub Group." Width="175px" AutoPostBack="true">
                                                </asp:DropDownList>
                                                <%--<asp:Button ID="btnSubgroup" ToolTip="Click here to add a new sub group." runat="server" Text="+" ForeColor="White" BackColor="DarkBlue" Width="30px" Height="25px" OnClick="btnSubgroup_Click" />--%>
                                            </td>
                                        </tr>

                                        <%--<tr>
                                            <td> 
                                                <asp:Label ID="Label7" runat="Server" Text="Account Type" ForeColor="Black" Font-Names="verdana"></asp:Label> 
                                                
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlAccountType" runat="server" ToolTip="Choose the Account type." Height="23px" Width="175px"  AutoPostBack="true">
                                                    <asp:ListItem Text ="--Select--" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text ="Resident" Value="R"></asp:ListItem>
                                                    <asp:ListItem Text ="General" Value="G"></asp:ListItem>
                                                </asp:DropDownList>
                                                
                                            </td>
                                        </tr>--%>


                                        <tr>
                                            <td>
                                                <asp:Label ID="Label3" runat="Server" Text="Remarks" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" ToolTip="" TextMode="MultiLine" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" CssClass="btn btn-success" ToolTip="Click here to save the house keeping task details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" />
                                                <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" CssClass="btn btn-success" ToolTip="Click here to update the house keeping task details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px"  />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" CssClass="btn btn-default" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" CssClass="btn btn-default" ForeColor="White" BackColor="DarkBlue" Width="90px" OnClick="btnReturn_Click" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Label ID="Label7" runat="server" Text="A GL Code not related to a resident, always starts with G1.  So when creating an account enter the next six characters (or) digits only.  
                                                    For a resident, the GL Codes are created automatically when a resident profile is added."
                                                    Font-Names="Verdana" ForeColor="DarkGray" Font-Size="Small"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            </table>
                  
                    <br />
                    <br />

                </div>
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="BtnExcelExport" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>


</asp:Content>
