<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="CheckDoorStatus.aspx.cs" Inherits="CheckDoorStatus" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
     <style>
        .rightAlign { text-align:right; }
    </style>
    <style type="text/css">
        
.Loadingdiv {
     position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 0.6;
    -moz-opacity: 0.8;
}

.centerdiv
{
    z-index: 1000;
    margin: 300px auto;
    padding: 10px;
    width: 130px;
    background-color: White;
    border-radius: 10px;
    filter: alpha(opacity=100);
    opacity: 1;
    -moz-opacity: 1;
}
.centerdiv img
{
    height: 128px;
    width: 128px;
}

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Always">
                <ContentTemplate>
                  
                        <table style="width:100%" align="center">
                            <tr align="center">
                                <td align="center" >
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                         <table style="width: 70%;" align="center">
                            <tr>
                                <td align="center" style="width: 70%;">
                                    <telerik:RadGrid ID="gvDoorStatus" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                        AutoGenerateColumns="false" OnItemCommand="gvDoorStatus_ItemCommand"  Width="100%" AllowFilteringByColumn="true" AllowPaging="false" Height="400px" 
                                        OnInit="gvDoorStatus_Init">
                                         
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                        </HeaderContextMenu>
                                        <MasterTableView>
                                            <Columns>                                               
                                                <telerik:GridBoundColumn HeaderText="Door No" FilterControlWidth="60px" Visible="true" HeaderStyle-Width="70px" DataField="RTVILLANO" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Status" FilterControlWidth="60px" Visible="true" HeaderStyle-Width="70px" DataField="DOORSTS" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Resd. Name" FilterControlWidth="100px"  HeaderStyle-Width="150px" DataField="RTNAME" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Resd. Status" FilterControlWidth="70px"  HeaderStyle-Width="100px" DataField="RTSTATUS" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Accountcode" FilterControlWidth="60px"  HeaderStyle-Width="70px" DataField="Accountcode" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                              <tr>
                       <td align="right" style="Width:70%;">
                            
                            <asp:Button ID="BtnExcelExport" AutoPostBack="true" runat="server" CssClass="btn" BackColor="#0000ff" Font-Bold="true" Text="Export Excel" OnClick="BtnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                        </td>
                        </tr>
                        </table>
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
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/loading3.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
            </div>
        </div>

</asp:Content>

