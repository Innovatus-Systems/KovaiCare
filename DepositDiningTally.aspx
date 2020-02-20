<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DepositDiningTally.aspx.cs" Inherits="DepositDiningTally" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upnlUpdate">
                        <ProgressTemplate>
                            <div class="Loadingdiv">
                                <div class="centerdiv">
                                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                                    <img alt="Loading...." src="Images/Loader.gif" />
                                </div>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
            <asp:UpdatePanel ID="upnlUpdate" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
            <table style="width: 100%">
                <tr>
                    <td align="center">
                        <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </td>
                </tr>
            </table>

            <table align="Center" style="width: 90%">
                <tr>
                    <td style="width: 100%; vertical-align: middle;" align="center">
                                <telerik:RadGrid ID="radgvEvents"  FilterItemStyle-HorizontalAlign="Left" GroupingSettings-CaseSensitive="false" Width="80%" Height="400px"  AllowFilteringByColumn="true" 
                                    runat="server" Skin="WebBlue" OnItemDataBound="radgvEvents_ItemDataBound" OnItemCommand="radgvEvents_ItemCommand" 
                                    MasterTableView-AutoGenerateColumns="false" AutoGenerateColumns="false" Font-Names="Verdana" Font-Size="Smaller"
                                    AllowPaging="false" AllowSorting="true" OnInit="radgvEvents_Init">
                                    <ClientSettings>
                                        <Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />
                                        <Scrolling AllowScroll="True"  SaveScrollPosition="true" UseStaticHeaders="True" />
                                    </ClientSettings>
                                    <MasterTableView Font-Size="Small">
                                        <Columns>
                                            <telerik:GridBoundColumn HeaderText="#Door" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="CENTER" DataField="RTVILLANO" HeaderTooltip="DOOR NUMBER" HeaderStyle-Width="100px" FilterControlWidth="75px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="CENTER" DataField="RTNAME" HeaderTooltip="NAME OF RESIDENT" HeaderStyle-Width="100px"  FilterControlWidth="75px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="CENTER" DataField="RTSTATUS" HeaderTooltip="STATUS OF RESIDENT" HeaderStyle-Width="100px" FilterControlWidth="75px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Accountcode" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="CENTER" DataField="GLDepositaccount" HeaderTooltip="RESIDENT DEPOSIT ACCOUNTCODE" HeaderStyle-Width="100px"  FilterControlWidth="75px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="#Regular" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="CENTER" DataField="DINERS" HeaderTooltip="NUMBER OF REGULAR DINERS AT HOME." HeaderStyle-Width="100px"  FilterControlWidth="75px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Deposit Amt." HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="CENTER" DataField="ACCOUNTBALANCE" HeaderTooltip="TOTAL DEPOSIT AMOUNT PAID BY RESIDENT" HeaderStyle-Width="100px"  FilterControlWidth="75px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Tally?" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="CENTER" DataField="COLUMN" HeaderTooltip="DEPOSIT DINING RATIO IS 'TALLY' OR 'NOT TALLY'" HeaderStyle-Width="100px"  FilterControlWidth="75px"></telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                         </tr>
                </table>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
</asp:Content>

