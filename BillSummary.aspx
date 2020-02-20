<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="BillSummary.aspx.cs" Inherits="BillSummary" %>

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
                        <table cellspacing="5" cellpadding="5">
                           <tr>
                               <td>
                         <telerik:RadWindow ID="rwPopUp" Title="Billing Details" BackColor="LightGreen" runat="server" VisibleOnPageLoad="false" Visible="false" Modal="true" Height="350px" Width="500px">
                        <ContentTemplate>
                            <div>
                                <table>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <asp:Label ID="lblbillno" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                   
                                    <td>
                                        <telerik:RadGrid ID="gvBillingDetails" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"  Width="60%"  AllowPaging="true" PageSize="10">
                                        <MasterTableView>
                                           <Columns>
                                                <telerik:GridBoundColumn HeaderText="BillNo" DataField="BillNo" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Menu" DataField="ItemName" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ReadOnly="true"></telerik:GridBoundColumn>
                                                 <telerik:GridBoundColumn HeaderText="Persons" DataField="Count" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Rate" DataField="Rate" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Tot.Qty" DataField="Qty" ReadOnly="true"></telerik:GridBoundColumn>
                                               
                                               <telerik:GridBoundColumn HeaderText="Amount" DataField="Amount" ReadOnly="true"></telerik:GridBoundColumn>

                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                    </td>
                                       
                                        </tr>
                                </table>
                            </div>
                         </ContentTemplate>
                         </telerik:RadWindow>
                               </td>
                           </tr>
                            
                             <tr>
                                <td colspan="2">
                                   
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>
                                </td>
                                  <td style="vertical-align:top">
                                            <asp:Button ID="btnAcceptPayment" runat="server" BackColor="DarkGreen" ForeColor="White"  Text="Accept Payment" ToolTip="Click here to view Accept payment" CssClass="Button" OnClick="btnAcceptPayment_Click" />
                                        </td>
                            </tr>
                           
                             <tr>
                                        <td>
                                                <telerik:RadAutoCompleteBox ID="racAPResident" Font-Names="verdana" Width="350px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource3" runat="server" DataTextField="Customer" DataValueField="RTRSN" InputType="Text" MinFilterLength="1"
                                                    EmptyMessage="Choose ResidentID / DoorNo / Name " ToolTip="Choose the ResidentID / DoorNo / Name to view the customer details"  AutoPostBack="true" TextSettings-SelectionMode="Single">
                                                    <TextSettings SelectionMode="Single" />
                                                </telerik:RadAutoCompleteBox>
                                                
                                                <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select convert(nvarchar(10),RTRSN) +', '+ RTVILLANO +', '+ RTName + ', ' + convert(nvarchar(10),RTRSN) as Customer,RTRSN from tblresident order by RTName asc"></asp:SqlDataSource>
                                                
                                            </td>
                                            <td>
                                                <asp:Button ID="btnSearch" runat="server" Text="Search" ToolTip="This will be inactive if there is some value in the grid.  Press Clear All, to abort all work and start again." CssClass="Button" OnClick="btnSearch_Click" />
                                            </td>
                                    </tr>
                                     <tr>
                                             <td colspan="2" >
                                                 <div style="border:1px thin maroon;">
                                                 <asp:Label ID="lblName" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon" ></asp:Label>
                                                 <asp:Label ID="lblDoorNO" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon" ></asp:Label>
                                                  <asp:Label ID="lblMobileNo" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon" ></asp:Label>
                                                 <asp:Label ID="lblEmail" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon" ></asp:Label>
                                                 </div>
                                             </td>
                                         </tr>
                                    <tr>
                             <td align="right" colspan="2">
                                    <asp:Label ID="lbloutstanding" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="DarkGray"></asp:Label>
                                </td>
                                        </tr>

                                        <tr>
                               
                                <td colspan="2" >
                                    <telerik:RadGrid ID="gvBillSummary" GroupingSettings-CaseSensitive="false" Skin="WebBlue" OnItemCommand="gvBillSummary_ItemCommand" AllowSorting="true" runat="server" AutoGenerateColumns="false"  Width="100%" AllowFilteringByColumn="true" AllowPaging="true" PageSize="10">
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="BillNo" HeaderTooltip="Resident Bill No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="BillNo" SortExpression="BillNo" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkBillNo" runat="server" ToolTip="Click here to view details." Text='<%# Eval("BillNo") %>' CommandName="BillNo" CommandArgument='<%# Eval("BillNo") %>'></asp:LinkButton>

                                                    </ItemTemplate>

                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Description" DataField="Description" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" DataField="Type" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Amount" DataField="Amount" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Closing" DataField="Closing" ReadOnly="true"></telerik:GridBoundColumn>

                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <%--<asp:PostBackTrigger ControlID="BtnnExcelExport" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
