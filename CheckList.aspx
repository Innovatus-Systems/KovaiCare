<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="CheckList.aspx.cs" Inherits="CheckList" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
  </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt" >
        <div class="first_cnt" >
            <div style="font-family: Verdana; font-size: small;">
               
                <table style="width:100%">
                            <tr>
                                <td style="text-align:center">
                                   <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                
                <table style="width:auto; margin-left:auto; margin-right:auto; border-collapse:collapse; " border="1" >
               
                    <tr>
                        <td>
                            <asp:Label ID="Label41" runat="server" Text="Implementation Guide" Font-Bold="true" Font-Names="Verdana"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label42" runat="server" Text="Refer to" Font-Bold="true" Font-Names="Verdana"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="Label43" runat="server" Text="Status" Font-Bold="true" Font-Names="Verdana"></asp:Label>
                        </td>
                    </tr>
                   <tr>
                   <td>
                       <asp:Label ID="Label1" runat="server" Text="Check SysAdmin Settings information" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label2" runat="server" Text="S1.SysAdmin parameters" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus1" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label3" runat="server" Text="How many users are defined?" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label4" runat="server" Text="S3.Users" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus2" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label5" runat="server" Text="Define dwelling units" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label6" runat="server" Text="Villas & Apartments" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus3" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label7" runat="server" Text="Check if Special DoorNos WALKIN, UNASGND, STAFF are defined" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label8" runat="server" Text="Villas & Apartments" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus4" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label9" runat="server" Text="Define Tasks master list" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label10" runat="server" Text="Tasks MasterList" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus5" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label11" runat="server" Text="Define Staff List  for assigning tasks" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label12" runat="server" Text="HouseKeeping Staff" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus6" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label13" runat="server" Text="Define Services master list" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label14" runat="server" Text="S6.Service requests Lookup" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus7" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label15" runat="server" Text="Define Dining sessions" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label16" runat="server" Text="Dining Sessions" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus8" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label17" runat="server" Text="Dining billing rule - Session based / A La Carte" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label18" runat="server" Text="S1.SysAdmin parameters" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus9" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
               <tr>
                   <td>
                       <asp:Label ID="Label19" runat="server" Text="Are there any profiles with a fixed monthly charge for dining?" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label20" runat="server" Text="Resident's Profile" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus10" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
               <tr>
                   <td>
                       <asp:Label ID="Label39" runat="server" Text="Are there any profiles with a fixed monthly charge for housekeeping?" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label40" runat="server" Text="Resident's Profile" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus11" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr> 
                    <tr>
                   <td>
                       <asp:Label ID="Label21" runat="server" Text="Define Menu Items and rate per menu item" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label22" runat="server" Text="Menu Items" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus12" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
                  </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label23" runat="server" Text="Define Menu ingredients" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label24" runat="server" Text="Ingredients Master" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus13" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label25" runat="server" Text="Define Monthly charges for Housekeeping" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label26" runat="server" Text="Resident's Profie" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus14" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label27" runat="server" Text="Define Monthly charges for dining"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label28" runat="server" Text="Resident's Profile"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus15" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label29" runat="server" Text="Define Calendar of religious and other important dates" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label30" runat="server" Text="Events Calendar" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus16" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label31" runat="server" Text="Ensure Mobile APP works for management" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label32" runat="server" Text="" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus17" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label33" runat="server" Text="Ensure Mobile APP works for resident" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label34" runat="server" Text="" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus18" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label35" runat="server" Text="Define Profile++ Codes" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label36" runat="server" Text="Profile++ Lookup" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus19" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>
                    <tr>
                   <td>
                       <asp:Label ID="Label37" runat="server" Text="Define Assets" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td>
                       <asp:Label ID="Label38" runat="server" Text="Manage Assets" Font-Names="Verdana"></asp:Label>
                   </td>
                   <td align="center">
                       <asp:LinkButton ID="lnkStatus20" runat="server" Font-Names="Verdana"></asp:LinkButton>
                   </td>
               </tr>

               </table>
            </div>
        </div>
    </div>
</asp:Content>
