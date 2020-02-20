<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="InvoiceLkUp.aspx.cs" Inherits="InvoiceLkUp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
            vali += TXNCode();
            vali += Prefix();
            vali += Year();
            vali += StdText();
            vali += HSNCode();
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
            vali += TXNCode();
            vali += Prefix();
            vali += Year();
            vali += StdText(); 
            vali += HSNCode();

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

        function TXNCode() {
            var Estimate = document.getElementById('<%= txtTXNCode.ClientID %>').value;
            if (Estimate == "") {
                return "Please enter the TXN Code" + "\n";
            }
            else {
                return "";
            }
        }
        function Prefix() {
            var Estimate = document.getElementById('<%= txtPrefix.ClientID %>').value;
            if (Estimate == "") {
                return "Please enter the Prefix" + "\n";
            }
            else {
                return "";
            }
        }
        function Year() {
            var Estimate = document.getElementById('<%= txtYear.ClientID %>').value;
            if (Estimate == "") {
                return "Please enter the Year" + "\n";
            }
            else {
                return "";
            }
        }
       
        function StdText() {
            var Estimate = document.getElementById('<%= txtStdText.ClientID %>').value;
            if (Estimate == "") {
                return "Please enter the Std. Text" + "\n";
            }
            else {
                return "";
            }
        }
        function HSNCode() {
            var Estimate = document.getElementById('<%= txtHSNCode.ClientID %>').value;
            if (Estimate == "") {
                return "Please enter the HSN Code" + "\n";
            }
            else {
                return "";
            }
        }
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

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


                                    <table style="width:75%" align="center">  
                                        <tr>                                                                           
                                            <td align="center" style="width:80%">
                                                <telerik:RadGrid ID="gvInvoiceLkUp" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                                    AutoGenerateColumns="false" OnItemCommand="gvInvoiceLkUp_ItemCommand" Height="200px" 
                                                    AllowFilteringByColumn="true" AllowPaging="false" OnInit="gvInvoiceLkUp_Init">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />


                                                    </ClientSettings>
                                                    <MasterTableView>

                                                        <CommandItemSettings ShowExportToCsvButton="true" />
                                                        <Columns>
                                                            <telerik:GridTemplateColumn  AllowFiltering="false" HeaderStyle-Width="30px">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the lookup deatails" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                             <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("TXNCODE") %>' CommandArgument='<%# Eval("TXNCODE") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>  
                                                             <telerik:GridBoundColumn HeaderText="TxnCode" HeaderStyle-Width="50px" DataField="TxnCode" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="30px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Prefix" HeaderStyle-Width="70px" DataField="Prefix" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  FilterControlWidth="50px"></telerik:GridBoundColumn>                                                                                                               
                                                            <telerik:GridBoundColumn HeaderText="Year" HeaderStyle-Width="70px" DataField="Year" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"  FilterControlWidth="50px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Invoice No" HeaderStyle-Width="70px" DataField="InvoiceCode" ReadOnly="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"  FilterControlWidth="50px"></telerik:GridBoundColumn>                                                           
                                                            <telerik:GridBoundColumn HeaderText="Std. Text" HeaderStyle-Width="150px" DataField="StdText" ReadOnly="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"  FilterControlWidth="90px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="HSN Code" HeaderStyle-Width="70px" DataField="HSNCode" ReadOnly="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"  FilterControlWidth="50px"></telerik:GridBoundColumn>   
                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                                </td>
                                         
                                                
                                        </tr>
                                        <tr>
                       <td align="right" style="Width:90%;">
                            
                            <asp:Button ID="BtnExcelExport" AutoPostBack="true" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export Excel" OnClick="BtnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                                            </td>
                                            </tr>
                                         
                                    </table>
                   
                        
                    </div>
                    <div align="Left" style="width:83%">
                       
                    </div>
                 
                        <table style="width:45%">
                        <tr>
                            <td style="width:100px;">

                            </td>
                                <td  vertical-align: text-top">
                                    <table cellspacing="10" cellpadding="10">
                                        <tr>
                                            <td> <asp:LinkButton runat="server" ID="LnkSH" ToolTip="To add new." Text=" Add Code" OnClientClick="return ShowHide();" ForeColor="Green" Font-Bold="true"></asp:LinkButton></td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="Server" Text="TXN Code" Font-Bold="true" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label4" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTXNCode" runat="server" CssClass="form-control" ToolTip="TXN Code (Unique)."
                                                    Width="250px" MaxLength="2"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label2" runat="Server" Text="Prefix" ForeColor="Black" Font-Bold="true" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label5" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPrefix" CssClass="form-control" runat="server" ToolTip="" Width="250px"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label6" runat="Server" Text="Year" ForeColor="Black" Font-Bold="true" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label8" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>
                                                 <asp:TextBox ID="txtYear" CssClass="form-control" runat="server" ToolTip="" Width="250px"></asp:TextBox>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td>
                                                <asp:Label ID="Label9" runat="Server" Text="Std. Text" ForeColor="Black" Font-Bold="true" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label10" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                             <td>
                                                 <asp:TextBox ID="txtStdText" CssClass="form-control" runat="server" ToolTip="" Width="250px"></asp:TextBox>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td>
                                                <asp:Label ID="Label3" runat="Server" Text="HSN Code" ForeColor="Black" Font-Bold="true" Font-Names="verdana"></asp:Label>
                                                <asp:Label ID="Label7" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                            </td>
                                             <td>
                                                 <asp:TextBox ID="txtHSNCode" CssClass="form-control" runat="server" ToolTip="" Width="250px"></asp:TextBox>
                                                 <asp:TextBox ID="txtRSN" CssClass="form-control" runat="server" ToolTip="" Width="250px" Visible="false"></asp:TextBox>
                                            </td>
                                        </tr>
                                      
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" CssClass="btn btn-success" ToolTip="Click here to save the Invoice LookUp Details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" />
                                                <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" CssClass="btn btn-success" ToolTip="Click here to update the house keeping task details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px"  />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" CssClass="btn btn-default" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" CssClass="btn btn-default" ForeColor="White" BackColor="DarkBlue" Width="90px" OnClick="btnReturn_Click" />
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

