<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ControlPanal.aspx.cs" Inherits="ControlPanal" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">
            <div style="font-family: Verdana; font-size: small;">

                <div style="width: 100%;">
                    <table style="width: 100%">
                        <tr>
                            <td style="text-align: center">
                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    <table border="1" style="font-family: Verdana;width:80%" align="Center">
                        <tr>
                            <td style="width:10%;background-color: #196F3D;color: white;font-weight: bold;">
                                <b>Refer To</b>
                            </td>
                            <td style="width:15%;background-color: #196F3D;color: white;font-weight: bold;">
                                <b>Events</b>
                            </td>
                            <td style="width:30%;background-color: #196F3D;color: white;font-weight: bold;">
                                <b>Details</b>
                            </td>
                        </tr>
                        <tr>
                            <td> <asp:Label ID="Label1" runat="server" Text="Events"></asp:Label></td>
                            <td><asp:Label ID="Label2" runat="server" Text="Oncoming event"></asp:Label></td>
                            <td><asp:Label ID="lblOnComing" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        <tr>
                             <td> <asp:Label ID="Label3" runat="server" Text="Events"></asp:Label></td>
                            <td><asp:Label ID="Label4" runat="server" Text="Confirmation"></asp:Label></td>
                            <td><asp:Label ID="lblConfirmation" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        <tr>
                             <td> <asp:Label ID="Label5" runat="server" Text="Accounts"></asp:Label></td>
                            <td><asp:Label ID="Label6" runat="server" Text="Monthly Billing"></asp:Label></td>
                            <td><asp:Label ID="lblMEB" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td> <asp:Label ID="Label7" runat="server" Text="Accounts"></asp:Label></td>
                            <td><asp:Label ID="Label8" runat="server" Text="Outstandings"></asp:Label></td>
                            <td><asp:Label ID="lblOutstanding" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td> <asp:Label ID="Label35" runat="server" Text="Accounts"></asp:Label></td>
                            <td><asp:Label ID="Label36" runat="server" Text="OutStd. vs Receipts"></asp:Label></td>
                            <td><asp:Label ID="lblOSvsRec" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        <tr>
                             <td> <asp:Label ID="Label9" runat="server" Text="Assets"></asp:Label></td>
                            <td><asp:Label ID="Label10" runat="server" Text="Warranty Ending"></asp:Label></td>
                            <td><asp:Label ID="lblWarrantyEnding" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td> <asp:Label ID="Label11" runat="server" Text="Assets"></asp:Label></td>
                            <td><asp:Label ID="Label12" runat="server" Text="AMC Ending"></asp:Label></td>
                            <td><asp:Label ID="lblAMCEnding" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        <tr>
                             <td> <asp:Label ID="Label13" runat="server" Text="Assets"></asp:Label></td>
                            <td><asp:Label ID="Label14" runat="server" Text="Insurance Ending"></asp:Label></td>
                            <td><asp:Label ID="lblInsuranceEnding" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td> <asp:Label ID="Label37" runat="server" Text="Residents"></asp:Label></td>
                            <td><asp:Label ID="Label38" runat="server" Text="Tenancy Renewal"></asp:Label></td>
                            <td><asp:Label ID="lblTenancyRenewal" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td style="vertical-align:top;"> <asp:Label ID="Label39" runat="server" Text="Residents"></asp:Label></td>
                            <td style="vertical-align:top;"><asp:Label ID="Label40" runat="server" Text="Tenancy Renewal Code(TRDD)"></asp:Label></td>
                            <td><asp:Label ID="lbltenancyNotavl" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td> <asp:Label ID="Label15" runat="server" Text="Residents"></asp:Label></td>
                            <td><asp:Label ID="Label16" runat="server" Text="Count"></asp:Label></td>
                            <td><asp:Label ID="lblRCount" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        <tr>
                             <td> <asp:Label ID="Label17" runat="server" Text="Residents"></asp:Label></td>
                            <td><asp:Label ID="Label18" runat="server" Text="ICE"></asp:Label></td>
                            <td><asp:Label ID="lblRICE" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td> <asp:Label ID="Label19" runat="server" Text="Dining"></asp:Label></td>
                            <td><asp:Label ID="Label20" runat="server" Text="Diner Notes"></asp:Label></td>
                            <td><asp:Label ID="lblDinerNotes" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        <tr>
                             <td> <asp:Label ID="Label21" runat="server" Text="Dining"></asp:Label></td>
                            <td><asp:Label ID="Label22" runat="server" Text="Menu TimeTable"></asp:Label></td>
                            <td><asp:Label ID="lblMenuTimeTable" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        <tr>
                             <td> <asp:Label ID="Label23" runat="server" Text="Kitchen"></asp:Label></td>
                            <td><asp:Label ID="Label24" runat="server" Text="High Rate Purchase"></asp:Label></td>
                            <td><asp:Label ID="lblHighRatePurchase" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        <tr>
                             <td> <asp:Label ID="Label25" runat="server" Text="Houses"></asp:Label></td>
                            <td><asp:Label ID="Label26" runat="server" Text="Blocked/ Locked"></asp:Label></td>
                            <td><asp:Label ID="lblBlockedLocked" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td> <asp:Label ID="Label27" runat="server" Text="Houses"></asp:Label></td>
                            <td><asp:Label ID="Label28" runat="server" Text="Vacant"></asp:Label></td>
                            <td><asp:Label ID="lblVacant" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td> <asp:Label ID="Label29" runat="server" Text="Housekeeping"></asp:Label></td>
                            <td><asp:Label ID="Label30" runat="server" Text="Overdue"></asp:Label></td>
                            <td><asp:Label ID="lblHOverdue" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        <tr>
                             <td> <asp:Label ID="Label31" runat="server" Text="Service requests"></asp:Label></td>
                            <td><asp:Label ID="Label32" runat="server" Text="Overdue"></asp:Label></td>
                            <td><asp:Label ID="lblSOverdue" runat="server" Text="-"></asp:Label></td>
                        </tr>
                         <tr>
                             <td> <asp:Label ID="Label33" runat="server" Text="Latest Transaction"></asp:Label></td>
                            <td><asp:Label ID="Label34" runat="server" Text="Transaction"></asp:Label></td>
                            <td><asp:Label ID="lblLatestTrans" runat="server" Text="-"></asp:Label></td>
                        </tr>
                        
                    </table>

                </div>

            </div>
        </div>
    </div>

</asp:Content>

