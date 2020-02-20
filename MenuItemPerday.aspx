<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MenuItemPerday.aspx.cs" Inherits="MenuItemPerday" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="width:100%;min-height:400px;">
                        <table style="width:100%">
                            <tr>
                                <td align="center">
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td style="width:10%">

                                </td>
                                <td>
                                    <table style="font-family:Verdana;font-size:small;border-spacing:10px;padding:7px;">
                            <tr>
                                 <td> Date : 
                                    <asp:Label ID="lblDate" runat="server" Text="" Font-Bold="true"></asp:Label>&nbsp;
                                    <asp:Label ID="lblDayName" runat="server" Text="" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                               
                                <td>
                                    
                                    <asp:Button ID="btnPrevious" Font-Names="Verdana" CssClass="btn" ForeColor="White" BackColor="DarkBlue" Width="100px" ToolTip="Click here to search menu items for the selected date." runat="server" OnClick="btnPrevious_Click" Text="Previous" />
                                    <asp:Button ID="btnNext" Font-Names="Verdana" ForeColor="White" CssClass="btn" BackColor="DarkBlue" Width="100px" ToolTip="Click here to search menu items for the selected date." runat="server" OnClick="btnNext_Click" Text="Next" />
                                    
                                    <asp:Button ID="btnEstimate" runat="server" BackColor="DarkGreen" CssClass="btn" ForeColor="White"  Text="Estimate" ToolTip="Click here to view dining estimate."  OnClick="btnEstimate_Click" />

                                </td>                                
                            </tr>
                            <tr>
                                
                                <td colspan="2">                                    
                                    <telerik:RadGrid ID="gvItems" OnPreRender="gvItems_PreRender" GroupingSettings-CaseSensitive="true" AllowFilteringByColumn="true" OnItemCommand="gvItems_ItemCommand" Width="400px" 
                                        Skin="Web20"  AllowSorting="true" runat="server" AutoGenerateColumns="false" OnInit="gvItems_Init">
                                        <MasterTableView CellPadding="5" CellSpacing="5">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="Sessions" HeaderText="Sessions" ReadOnly="true" Visible="false"></telerik:GridBoundColumn>

                                                 <telerik:GridTemplateColumn HeaderText="Session" HeaderStyle-Font-Names="" UniqueName="SessionName" SortExpression="SessionName" AllowFiltering="true" HeaderTooltip=" Session(s) name.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lnkdoorno" runat="server" ForeColor="#3333cc" Text='<%# Eval("SessionName") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn AllowSorting="false" DataField="ItemName" HeaderText="Items" ReadOnly="true"></telerik:GridBoundColumn>

                                                 <telerik:GridBoundColumn AllowSorting="false" DataField="Contains" HeaderText="Contains" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            <tr> 
                                <td colspan="2">

                                    <telerik:RadGrid ID="gvEvents" GroupingSettings-CaseSensitive="true"  Width="400px" Skin="Sunset" AllowPaging="true" AllowSorting="true" runat="server" AutoGenerateColumns="false">
                                        <MasterTableView CellPadding="5" CellSpacing="5">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="EventName" HeaderText="Event" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn AllowSorting="false" DataField="Description" HeaderText="Description" ReadOnly="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>

                                </td>
                            </tr>
                        </table>
                                </td>
                            </tr>
                        </table>
                        
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnEstimate" />
                </Triggers>
            </asp:UpdatePanel>

        </div>
    </div>
</asp:Content>

