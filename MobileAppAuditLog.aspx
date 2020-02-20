<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MobileAppAuditLog.aspx.cs" Inherits="MobileAppAuditLog" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <div class="main_cnt">
                <div class="first_cnt" style="min-height: 450px">
                    <div style="font-family: Verdana; font-size: small;">                       
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                    <asp:LinkButton ID="lnktitle"  runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                                 
                            </tr>

                        </table>
                                    <table style="width:60%" align="center">  
                                        <tr>                                          
                                            <td align="center" style="width:60%">
                                                <telerik:RadGrid ID="gvLog" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                                    AutoGenerateColumns="false" OnItemCommand="gvLog_ItemCommand" 
                                                    AllowFilteringByColumn="true" AllowPaging="false" OnInit="gvLog_Init">
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                                    </ClientSettings>
                                                    <MasterTableView>

                                                        <CommandItemSettings ShowExportToCsvButton="true" />
                                                        <Columns>                                                                                                                 
                                                           
                                                            <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="130px" DataField="Name" ReadOnly="true" FilterControlWidth="110px"></telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="150px" DataField="Type" ReadOnly="true" FilterControlWidth="110px"></telerik:GridBoundColumn>      
                                                            <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="70px" DataField="Date" ReadOnly="true" FilterControlWidth="90px"></telerik:GridBoundColumn>
                                                            
                                                        </Columns>
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                                </td>     
                                        </tr>
                                        <tr>
                       <td align="right" style="Width:90%;">
                            <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" CssClass="btn btn-default" ForeColor="White" BackColor="#ff6600" Width="90px" OnClick="btnReturn_Click" />
                            <asp:Button ID="BtnExcelExport" AutoPostBack="true" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export Excel" OnClick="BtnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                                            </td>
                                            </tr>
                                        </table>             
                    </div>           
                    <br />
                    <br />
                </div>
            </div>

        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="BtnExcelExport" />
            <asp:PostBackTrigger ControlID="btnReturn" />         
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="loading3.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>


</asp:Content>

