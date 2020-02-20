<%@ Page Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="FoodTransactions.aspx.cs" Inherits="FoodTransactions" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  <style type="text/css">
    .preference .rwWindowContent
    {
        background-color: Green !important;
    }
    .availability .rwWindowContent
    {
        background-color: Yellow !important;
    }
</style>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />


     <div class="main_cnt">

        <div class="first_cnt">
            <div style="width:100%";>

                <table style ="width:100%">
                    <tr>
                        <td style ="width:25%">
                             <telerik:RadMenu ID="RMKPlanner" runat="server" Skin="" Width="250px" OnItemClick="RMKPlanner_ItemClick"  Style="z-index: 2900">

                                <Items>

                                    <telerik:RadMenuItem runat="server" Text="Dining" CssClass="main_menu">
                                        <Items>
                                            <telerik:RadMenuItem runat="server" Width="240px" Text="Ingredients Master" CssClass="level_menu ">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem runat="server" Width="240px" Text="Recipe Master" CssClass="level_menu ">
                                            </telerik:RadMenuItem>

                                            <telerik:RadMenuItem runat="server" Width="240px" Text="Menu Items" CssClass="level_menu ">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem runat="server" Width="240px" Text="Sessions" CssClass="level_menu ">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem runat="server" Width="240px" Text="Which Item When?" CssClass="level_menu">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem runat="server" Width="240px" Text="Menu for the day" CssClass="level_menu ">
                                            </telerik:RadMenuItem>
                                            <telerik:RadMenuItem runat="server" Width="240px" Text="Diners Update" CssClass="level_menu">
                                           </telerik:RadMenuItem>
                                           
                                           
                                            <%-- <telerik:RadMenuItem runat="server" Width="240px" Text="Menu for the day" CssClass="level_menu ">
                                            </telerik:RadMenuItem>--%>


                                            <telerik:RadMenuItem runat="server" Width="240px" Text="Help" CssClass="level_menu ">
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenuItem>
                                </Items>
                            </telerik:RadMenu>
                        </td>
                        <td style ="width:40%">

                        </td>
                        <td style ="width:35%"></td>
                    </tr>
                </table>

                </div>
            </div>
         </div>
</asp:Content>