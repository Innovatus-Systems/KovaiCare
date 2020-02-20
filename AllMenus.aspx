<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="AllMenus.aspx.cs" Inherits="AllMenus" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>All Menus</title>
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

    <style>
        .ButtonInfi {
            background-color: #38ACEC;
            width: 75px;
            height: 27px;
            padding: 5px;
            color: white;
            cursor: pointer;
            text-align: center;
            align-self: flex-start;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            -khtml-border-radius: 5px;
            behavior: url(/border-radius.htc);
            border-radius: 5px;
        }

        .Myheader {
            background-color: darkblue !important;
            color: white !important;
            background-image: none !important;
        }

        /*.RadComboBoxDropDown_Default .rcbList 
{
    background: #384B84;
   
    
    font-weight: bold ;
}*/
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <asp:HiddenField ID="hbtnRSN" runat="server" />
        <div style="width: 100%;margin: 0 auto; ">

            <%--<telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />--%>

            <table style="width: 100%;table-layout: fixed">                  <tr>
                    <td align="center">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="server" Font-Size="Small" Text="Resident name search" Font-Names="Verdana" ForeColor="Black" Visible="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNSearch" runat="server" Font-Size="Small" Font-Names="Calibri" Style="width: 300px; background-color: palegoldenrod" BorderStyle="Outset" BorderWidth=".1px" Font-Bold="false" ForeColor="Black" ToolTip="Press Enter key or Go button to Search"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="btnSearch" runat="server" Text="Go" Font-Size="Small" CssClass="ButtonRC" BackColor="#C4D8F6" ForeColor="Black" OnClick="BtnSearch_Click" ToolTip="Enter minimum of four letters of resident name to view a list of residents matching the criteria." />
                                </td>
                              
                            </tr>
                        </table>

                  

                    </td>
                </tr>

            </table>

            <table style="width: 100%;">

                <tr>

                    <td align="center">

                        <div style="min-height: 410px; width: 100%">

                            <table style="table-layout: fixed">

                                <tr>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadImageTile ID="rtResidents" runat="server" ImageUrl="~/Images/NResident.png" Height="175px" ImageWidth="150px">
                                                        <Title Text="Residents"></Title>
                                                        <%--ToolTip="Click here to view Residents modules."--%>
                                                    </telerik:RadImageTile>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rcResidents" Filter="StartsWith" runat="server" OnSelectedIndexChanged="rcResidents_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadImageTile ID="rtDining" runat="server" ImageUrl="~/Images/Ndining.png" Shape="Square" Height="175px" ImageWidth="150px" Font-Names="verdana" Font-Bold="true">

                                                        <Title Text="Dining"></Title>
                                                        <%--ToolTip="Click here to view Dining module."--%>
                                                    </telerik:RadImageTile>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rcDining" Filter="StartsWith" runat="server" OnSelectedIndexChanged="rcDining_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadImageTile ID="rtBillingandReceipts" runat="server" ImageUrl="~/Images/Nbilling.png" Height="175px" ImageWidth="150px">
                                                        <Title Text="Billing & Receipts"></Title>
                                                        <%-- ToolTip="Click here to view Billing and Receipts module."--%>
                                                    </telerik:RadImageTile>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rcBillingandReceipts" Filter="StartsWith" runat="server" OnSelectedIndexChanged="rcBillingandReceipts_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadImageTile ID="rtHouseKeeping" runat="server" ImageUrl="~/Images/Nhousekeeping.png" Height="175px" ImageWidth="150px">
                                                        <Title Text="House Keeping"></Title>
                                                        <%-- ToolTip="Click here to view House Keeping module."--%>
                                                    </telerik:RadImageTile>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rcHouseKeeping" Filter="StartsWith" runat="server" OnSelectedIndexChanged="rcHouseKeeping_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadImageTile ID="rtEvents" runat="server" ImageUrl="~/Images/Nevents.png" Height="175px" ImageWidth="150px">
                                                        <Title Text="Information"></Title>
                                                        <%--ToolTip="Click here to view Events module."--%>
                                                    </telerik:RadImageTile>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rcEvents" Filter="StartsWith" runat="server" OnSelectedIndexChanged="rcEvents_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadImageTile ID="rtReports" runat="server" ImageUrl="~/Images/Nreports.png" Height="175px" ImageWidth="150px">
                                                        <Title Text="Reports"></Title>
                                                        <%-- ToolTip="Click here to view Reports modules."--%>
                                                    </telerik:RadImageTile>

                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rcReports" Filter="StartsWith" runat="server" OnSelectedIndexChanged="rcReports_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadImageTile ID="rtSettings" runat="server" ImageUrl="~/Images/NSettings.png" Height="175px" ImageWidth="150px">
                                                        <Title Text="Settings"></Title>
                                                    </telerik:RadImageTile>
                                                    <%--ToolTip="Click here to view Settings modules."--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="rcSettings" Filter="StartsWith" runat="server" OnSelectedIndexChanged="rcSettings_SelectedIndexChanged" AutoPostBack="true"></telerik:RadComboBox>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                </tr>

                                <tr>
                                    <td style="vertical-align: top; width: 125px">
                                        <telerik:RadGrid ID="rgResidents" GroupingSettings-CaseSensitive="false" Skin="Outlook" HeaderStyle-CssClass="Myheader" Width="200px" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgResidents_ItemCommand">
                                            <MasterTableView>
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Residents" AllowFiltering="false">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkResidents" ToolTip='<%# Eval("Description") %>' runat="server" Text='<%# Eval("Title") %>' CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("MenuId") %>' Font-Names="Verdana"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                    <td style="vertical-align: top;">
                                        <telerik:RadGrid ID="rgDining" GroupingSettings-CaseSensitive="false" Skin="Outlook" HeaderStyle-CssClass="Myheader" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgDining_ItemCommand">
                                            <MasterTableView>
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Dining" AllowFiltering="false" HeaderStyle-Width="50px">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkdining" ToolTip='<%# Eval("Description") %>' runat="server" Text='<%# Eval("Title") %>' CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("MenuId") %>' Font-Names="Verdana"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                    <td style="vertical-align: top">
                                        <telerik:RadGrid ID="rgBillingandReceipts" GroupingSettings-CaseSensitive="false" Skin="Outlook" HeaderStyle-CssClass="Myheader" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgBillingandReceipts_ItemCommand">
                                            <MasterTableView>
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Billing & Receipts" AllowFiltering="false" HeaderStyle-Width="50px">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkbillingandreceipts" ToolTip='<%# Eval("Description") %>' runat="server" Text='<%# Eval("Title") %>' CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("MenuId") %>' Font-Names="Verdana"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                    <td style="vertical-align: top; width: 200px">

                                        <telerik:RadGrid ID="rgHousekeeping" GroupingSettings-CaseSensitive="false" Skin="Outlook" HeaderStyle-CssClass="Myheader" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgHousekeeping_ItemCommand">
                                            <MasterTableView>
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="House Keeping" AllowFiltering="false">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkhousekeeping" ToolTip='<%# Eval("Description") %>' runat="server" Text='<%# Eval("Title") %>' CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("MenuId") %>' Font-Names="Verdana"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                    <td style="vertical-align: top" align="left">

                                        <telerik:RadGrid ID="rgevents" GroupingSettings-CaseSensitive="false" Skin="Outlook" HeaderStyle-CssClass="Myheader" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgevents_ItemCommand">
                                            <MasterTableView>
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Events" AllowFiltering="false" HeaderStyle-Width="50px">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkevents" ToolTip='<%# Eval("Description") %>' runat="server" Text='<%# Eval("Title") %>' CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("MenuId") %>' Font-Names="Verdana"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>

                                    </td>
                                    <td style="vertical-align: top">
                                        <telerik:RadGrid ID="rgreports" GroupingSettings-CaseSensitive="false" Skin="Outlook" HeaderStyle-CssClass="Myheader" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgreports_ItemCommand">
                                            <MasterTableView>
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Reports" AllowFiltering="false" HeaderStyle-Width="50px">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkreports" ToolTip='<%# Eval("Description") %>' runat="server" Text='<%# Eval("Title") %>' CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("MenuId") %>' Font-Names="Verdana"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                    <td style="vertical-align: top">
                                        <telerik:RadGrid ID="rgsettings" GroupingSettings-CaseSensitive="false" Skin="Outlook" HeaderStyle-CssClass="Myheader" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgsettings_ItemCommand">
                                            <MasterTableView>
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Settings" AllowFiltering="false" HeaderStyle-Width="50px">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="lnkSettings" ToolTip='<%# Eval("Description") %>' runat="server" Text='<%# Eval("Title") %>' CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("MenuId") %>' Font-Names="Verdana"></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                </Columns>
                                            </MasterTableView>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>

                            </table>

                        </div>

                    </td>
                </tr>

            </table>
        </div>
    </div>

</asp:Content>

