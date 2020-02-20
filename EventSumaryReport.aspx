<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventSumaryReport.aspx.cs" Inherits="EventSumaryReport" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="font-family: Verdana; font-size: small; min-height: 400px;">
                        <table style="width:100%">
                             <tr>
                                <td align="center">
                                     <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                         <table cellspacing="5" cellpadding="5">
                          
                           <tr>
                               <td>
                                    <text style="font-family: Verdana;">Type :</text>
                                    &nbsp;
                                    <asp:DropDownList ID="ddlType" Width="150px" runat="server" ToolTip="Select the all Event (or) OnComingEvents (Or) Completed Events." OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text ="All" Value="1"></asp:ListItem>
                                        <asp:ListItem Text ="OnComing" Value="2"></asp:ListItem>
                                        <asp:ListItem Text ="Completed" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                               </td>
                           </tr>

                            <tr>
                                <td  >
                                    <telerik:RadGrid ID="gvEventSummary" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"
                                         OnItemCommand="gvEventSummary_ItemCommand" Width="95%" AllowFilteringByColumn="true" ShowFooter="true" OnInit="gvEventSummary_Init"  >
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <MasterTableView AllowFilteringByColumn="true">

                                            <Columns>
                                                
                                                <telerik:GridBoundColumn HeaderText="From Date" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="fromDate" ReadOnly="true" AllowFiltering="true" ></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Till Date" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="tillDate" ReadOnly="true" AllowFiltering="true" ></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" DataField="EventName" ReadOnly="true" AllowFiltering="true"   ></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" DataField="Description" ReadOnly="true" AllowFiltering="true"   ></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Attending" DataField="Attending" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center"   ></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Attended" DataField="Attended" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center" ></telerik:GridBoundColumn>
                                               
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                </ContentTemplate>
                <Triggers>
                   <%-- <asp:PostBackTrigger ControlID="BtnnExcelExport" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
