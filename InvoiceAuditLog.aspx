<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="InvoiceAuditLog.aspx.cs" Inherits="InvoiceAuditLog" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

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
    <script type="text/javascript" language="javascript">
        function ConfirmMsg() {
            var result = confirm('Are you sure, you want to reprint invoice for selected invoice number?');
            if (result) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <div class="main_cnt">
                <div class="first_cnt" style="min-height: 450px">
                    <div style="font-family: Verdana; font-size: small;">
                        <asp:HiddenField ID="hbtnRSN" runat="server" />
                        <asp:HiddenField ID="CnfResult" runat="server" />
                        <table style="width: 100%;">
                            <tr>

                                <td align="center">
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>

                            </tr>

                        </table>
                        <table style="width: 98%" align="center">
                            <tr>
                                <td align="center" style="width: 100%">

                                    <telerik:RadGrid ID="gvLog" runat="server" AllowPaging="false"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true" OnInit="gvLog_Init"
                                        OnPageIndexChanged="gvLog_PageIndexChanged" OnItemDataBound="gvLog_ItemDataBound"
                                        OnPageSizeChanged="gvLog_PageSizeChanged" OnSortCommand="gvLog_SortCommand" OnItemCommand="gvLog_ItemCommand"
                                        Width="90%" AllowFilteringByColumn="true"
                                        MasterTableView-HierarchyDefaultExpanded="true" OnItemEvent="gvLog_ItemEvent">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <GroupingSettings CaseSensitive="false" />
                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
                                        <MasterTableView AllowCustomPaging="false">
                                            <NoRecordsTemplate>
                                                No Records Found.
                                            </NoRecordsTemplate>
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="10px"></HeaderStyle>
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="110px" DataField="Date" ReadOnly="true" FilterControlWidth="80px" AllowFiltering="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="110px" DataField="Type" ReadOnly="true" FilterControlWidth="80px" AllowFiltering="false"></telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn UniqueName="InvoiceNo" Visible="True" HeaderText="InvoiceNo." AllowFiltering="true"
                                                    HeaderStyle-Width="110px" FilterControlWidth="70px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkInvoiceNo" Font-Underline="true" Text='<%# Eval("InvoiceNo") %>' CommandArgument='<%# Eval("InvoiceNo") %>' ForeColor="DarkBlue" UniqueName="InvoiceNo" runat="server" CommandName="InvoiceNo" OnClick="lnkInvoiceNo_Click"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="InvoiceNo." HeaderStyle-Width="110px" DataField="InvoiceNo" ReadOnly="true" FilterControlWidth="90px"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="150px" DataField="Name" ReadOnly="true" FilterControlWidth="90px" AllowFiltering="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Amount" HeaderStyle-Width="70px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataField="Amount"
                                                    ReadOnly="true" FilterControlWidth="40px" Visible="false" AllowFiltering="true">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="MailId" HeaderStyle-Width="150px" DataField="MailId" ReadOnly="true" FilterControlWidth="90px" AllowFiltering="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="FileName" HeaderStyle-Width="300px" DataField="FileName" ReadOnly="true" FilterControlWidth="250px" AllowFiltering="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Printed Cnt." HeaderStyle-Width="70px" DataField="INVPCOunt" ReadOnly="true" FilterControlWidth="40px" AllowFiltering="true"
                                                    HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" DataType="System.String">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                            <PagerStyle AlwaysVisible="True"></PagerStyle>
                                        </MasterTableView>
                                        <ClientSettings>
                                            <Selecting AllowRowSelect="True" />
                                        </ClientSettings>
                                        <FilterMenu Skin="WebBlue" EnableTheming="True">
                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                        </FilterMenu>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 90%;">
                                    <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" CssClass="btn btn-default" ForeColor="White" BackColor="#ff6600" Width="90px" OnClick="btnReturn_Click" />
                                    <asp:Button ID="BtnExcelExport" AutoPostBack="true" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export Excel" OnClick="BtnExcelExport_Click1" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                                </td>
                            </tr>
                        </table>
                        <table style="width: 95%" align="center">
                            <tr>
                                <td align="Left" style="width: 98%">
                                    <asp:Label runat="server" ID="lblGridName" Text="Invoice View" Font-Bold="true" Font-Size="Medium" ForeColor="#0000cc"> </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="Left" style="width: 98%">
                                    <table>
                                        <tr>
                                            <td align="Left" style="width: 89%;">
                                                <asp:Label runat="server" ID="lblName" Text="" Font-Bold="true" Font-Size="Small" ForeColor="Maroon"> </asp:Label>
                                            </td>
                                            <td align="Right">
                                                <asp:Button ID="btnGenerate" runat="Server" Text="Reprint Invoice" CssClass="btn btn-danger"
                                                    ToolTip="Click here to Reprint Invoice." ForeColor="White" OnClick="lnkPrint_Click" OnClientClick="javascript:return ConfirmMsg()" Visible="false" />
                                                <%-- <asp:Button runat="server" ID="lnkPrint" Font-Underline="true" ToolTip="Click to reprint the selected invoice." Text="Invoice Reprinting" OnClick="lnkPrint_Click" AutoPostBack="True" Font-Bold="true" Font-Size="Small" ForeColor="Maroon" Visible="false"></asp:Button>--%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" style="width: 98%">
                                    <telerik:RadGrid ID="rdInvoice" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                        AutoGenerateColumns="false" OnItemCommand="rdInvoice_ItemCommand" Height="200px"
                                        AllowFilteringByColumn="false" AllowPaging="false" OnInit="rdInvoice_Init">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="InvoiceNo" HeaderStyle-Width="110px" DataField="InvoiceNo" ReadOnly="true" FilterControlWidth="90px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Particulars" HeaderStyle-Width="150px" DataField="Particular" ReadOnly="true" FilterControlWidth="90px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="HSN" HeaderStyle-Width="110px" DataField="HSN" ReadOnly="true" FilterControlWidth="90px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="GST Rate%" HeaderStyle-Width="70px" DataField="GSTPERCENTAGE" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ReadOnly="true" FilterControlWidth="45px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="CGST" HeaderStyle-Width="70px" DataField="CGST" ReadOnly="true" FilterControlWidth="45px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="SGST" HeaderStyle-Width="70px" DataField="SGST" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ReadOnly="true" FilterControlWidth="45px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="TaxableVlu" HeaderStyle-Width="70px" DataField="Amount" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ReadOnly="true" FilterControlWidth="45px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Total" HeaderStyle-Width="70px" DataField="Total" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ReadOnly="true" FilterControlWidth="45px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="AccountCode" HeaderStyle-Width="150px" DataField="Accountcode" ReadOnly="true" FilterControlWidth="90px"></telerik:GridBoundColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="FileName" HeaderStyle-Width="300px" DataField="FileName" ReadOnly="true" FilterControlWidth="250px"></telerik:GridBoundColumn>--%>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
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
            <asp:PostBackTrigger ControlID="btnGenerate" />

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

