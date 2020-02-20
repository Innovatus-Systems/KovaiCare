<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AccountLedger.aspx.cs" Inherits="AccountLedger" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <%--<script src="//code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" language="javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });

        function askConfirm() {
            if (confirm("Are you sure, you want to save?"))
                alert(" ")
            else {
                //alert(" ")

                return false;
            }
        }
        //function FileUpd_Load() {
        //    // Get File Upload Path & File Name
        //    var file = document.getElementById("FileUpd");
        //    // Set Image Url from FileUploader Control
        //    document.getElementById("#Custimage").src = file.value;
        //    // Display Selected File Path & Name
        //    alert("You selected " + file.value);
        //    // Get File Size From Selected File in File Uploader Control 
        //    var inputFile = document.getElementById("FileUpd").files[0].size;
        //    // Displaty Selected File Size
        //    alert("File size: " + inputFile.toString());
        //}

    </script>
    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="upnlUpdate" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="main_cnt">
                <div class="first_cnt">
                    <div style="width: 98%">
                        <table>
                            <tr>
                                      <td>
                                    <telerik:RadWindow ID="rdMEB" VisibleOnPageLoad="false" Width="600" MinHeight="500" Title="" Font-Names="Verdana"
                                        runat="server" EnableShadow="true" Modal="true">
                                        <ContentTemplate>
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <div>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label1" runat="server" Text="Account : " Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>&nbsp;&nbsp;                                                                
                                                                    <asp:Label ID="lblAccount" runat="server" Text="-" Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>
                                                                </td>
                                                                </tr>
                                                                <tr>
                                                                 <td>
                                                                    <asp:Label ID="Label3" runat="server" Text="Category : " Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>&nbsp;&nbsp;
                                                               
                                                                    <asp:Label ID="lblcategory" runat="server" Text="-" Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                                                                
                                                                    <asp:Label ID="Label5" runat="server" Text="Sub Group : " Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>&nbsp;&nbsp;
                                                               
                                                                    <asp:Label ID="lblSubGrp" runat="server" Text="-" Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>
                                                                </td>
                                                               
                                                            </tr>

                                                            <tr>
                                                                <td align="center" colspan="5">
                                                                    <telerik:RadGrid ID="rgMEB" runat="server" AutoPostBack="true"
                                                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                                                        CellSpacing="5" Width="50%"
                                                                        MasterTableView-HierarchyDefaultExpanded="true">
                                                                        <ClientSettings>
                                                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                                                        </ClientSettings>
                                                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                                                        </HeaderContextMenu>
                                                                        <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
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
                                                                                <telerik:GridBoundColumn HeaderText="YearMonth" HeaderStyle-Width="60px" DataField="YearMonth" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Dr.Bal" HeaderStyle-Width="50px" DataField="DRBal" ReadOnly="true" AllowFiltering="true" FilterControlWidth="30px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Cr.Bal" HeaderStyle-Width="50px" DataField="CRBal" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>                                                                               
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

                                                        </table>
                                                        <%--<table align="Right">
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="Button1" AutoPostBack="true" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export Excel" OnClick="Button1_Click" ForeColor="White" ToolTip="Click to export grid details in excel." />
                                                                </td>
                                                            </tr>
                                                        </table>--%>
                                                    </div>
                                                </ContentTemplate>                                                
                                            </asp:UpdatePanel>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadWindow ID="rwTransactions" VisibleOnPageLoad="false" Width="1200" MinHeight="500" Font-Names="Verdana"
                                        runat="server" EnableShadow="true" Modal="true">
                                        <ContentTemplate>
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <div>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblAccountCode" runat="server" Text="" Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblAccountName" runat="server" Text="" CssClass="style2" ForeColor="Maroon" Font-Names="Verdana"
                                                                        Font-Bold="false" Font-Size="small"></asp:Label>
                                                                </td>                                                                

                                                                <td>
                                                                    <text style="font-family: Verdana; font-size: small; color: maroon"> Billing Period :</text>
                                                                    &nbsp;
                                                   <asp:DropDownList ID="ddlBilling" ToolTip="Current billing period" runat="server" Width="150px" Height="25px" AutoPostBack="true" OnSelectedIndexChanged="ddlBilling_SelectedIndexChanged"></asp:DropDownList>
                                                                    &nbsp;&nbsp;&nbsp;
                                                                </td>
                                                                <%-- <td>
                                                     <asp:Button ID="btnTransactionClose" runat="server" Text="Close" CssClass="button" Width="50px" Height="30px"
                                                        ToolTip="Click to return to account ledger." OnClick="btnTransactionClose_Click" ForeColor="DarkBlue" />
                                                </td>--%>
                                                           
                                                                <td >
                                                                    <asp:Label ID="lblFrom" runat="server" Text="" Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>&nbsp;&nbsp;

                                                                    <asp:Label ID="lblTill" runat="server" Text="" Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td align="center" colspan="5">
                                                                    <telerik:RadGrid ID="rgGeneralTransactions" runat="server" AutoPostBack="true"
                                                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                                                        CellSpacing="5" Width="98%"
                                                                        MasterTableView-HierarchyDefaultExpanded="true">
                                                                        <ClientSettings>
                                                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                                                        </ClientSettings>
                                                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                                                        </HeaderContextMenu>
                                                                        <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
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

                                                                                <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Wrap="false" HeaderStyle-Width="50px"
                                                                                    ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                                                    ItemStyle-CssClass="Row1">
                                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Account No." DataField="AccountNo" HeaderStyle-Wrap="false" Display="false"
                                                                                    ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                                                    ItemStyle-CssClass="Row1">
                                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Door No." DataField="rtvillano" HeaderStyle-Wrap="false" Display="false"
                                                                                    ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                                                    ItemStyle-CssClass="Row1">
                                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Name" DataField="rtname" HeaderStyle-Wrap="false" Display="false"
                                                                                    ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                                                    ItemStyle-CssClass="Row1">
                                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Ref" HeaderStyle-Width="100px" DataField="Ref" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Txn.Code" HeaderStyle-Width="50px" DataField="Group" ReadOnly="true" AllowFiltering="true" FilterControlWidth="30px"></telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Narration" HeaderStyle-Width="350px" DataField="Narration" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Dr/Cr" HeaderStyle-Width="50px" DataField="Type" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="DR.Amount" HeaderStyle-Width="80px" DataField="DR" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="CR.Amount" HeaderStyle-Width="80px" DataField="CR" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
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

                                                        </table>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="ddlBilling" EventName="SelectedIndexChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </ContentTemplate>
                                    </telerik:RadWindow>


                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%">
                            <tr>
                                <td align="center">
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table align="Center" style="width: 80%">
                            <tr>
                                <td style="width: 70%; vertical-align: top;" align="Center">
                                    <span style="font-family:Verdana;font-size:9px;color:gray;" >* Click on any ledger name to view the transactions posted against it.</span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 70%; height: 100px; vertical-align: top;" align="Center">
                                    <telerik:RadGrid ID="rdAllTrial" runat="server"  AutoPostBack="true"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                CellSpacing="5" Width="43%" Height="170px" 
                                MasterTableView-HierarchyDefaultExpanded="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                </ClientSettings>
                                <HeaderContextMenu CssClass="table table-bordered table-hover">
                                </HeaderContextMenu>
                                <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
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

                                          <telerik:GridTemplateColumn HeaderText="" HeaderStyle-Width="100px" DataField="Title"  AllowFiltering="true" FilterControlWidth="70px" UniqueName="Title" SortExpression="Title">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkTitle" runat="server" ToolTip="Click here to view the transactions posted against this ledger" Text='<%# Eval("Title") %>' Font-Bold="true" Font-Size="Small"  ForeColor="Green" OnClick="lnkTitle_Click">View</asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                       <%-- <telerik:GridBoundColumn HeaderText="" HeaderStyle-Width="100px" DataField="Title"  AllowFiltering="true" FilterControlWidth="70px"></telerik:GridBoundColumn>                      --%>
                                        <telerik:GridBoundColumn HeaderText="Total Debit" DataField="Debit" HeaderStyle-Wrap="false" ItemStyle-Width="50px" HeaderStyle-Width="50px"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Total Credit" DataField="Credit" HeaderStyle-Wrap="false" ItemStyle-Width="50px"  HeaderStyle-Width="50px"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
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

                        </table>
                        <table align="Center" style="width: 80%">
                            <tr>
                                <td align="Left">
                                     <asp:Label runat="server" ID="lbltile" Text="" Font-Names="verdana" Font-Bold="true" ForeColor="#000066" Visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>

                                <td style="width: 70%; height: 100px; vertical-align: top;" align="Center">
                                   
                                    <telerik:RadGrid ID="ReportList" runat="server" AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                        MasterTableView-HierarchyDefaultExpanded="true" OnInit="ReportList_Init" Visible="false">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <MasterTableView AllowCustomPaging="false" AllowFilteringByColumn="true">
                                            <NoRecordsTemplate>
                                                No Records Found.
                                            </NoRecordsTemplate>
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Account Type" DataField="RAccountType" HeaderStyle-Wrap="false"
                                                    ItemStyle-Wrap="false" Display="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                                    ItemStyle-CssClass="Row1">
                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderStyle-Width="60px" FilterControlWidth="45px" HeaderTooltip="Eight digit unique code defining a GL account.  All GL accounts start with G1.  All resident accounts start with G0.Click on an account code to view the General Ledger transactions for the current billing period. You can also choose to view the transactions for any other period." HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px" DataField="AccountCode"
                                                    HeaderText="Account Code"  AllowFiltering="true" UniqueName="AccountCode" SortExpression="AccountCode">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Lnkbtnview" runat="server" ToolTip="Click to View current month transaction details." Text='<%# Eval("AccountCode") %>' Font-Bold="true" Font-Size="X-Small"  ForeColor="DarkBlue" OnClick="Lnkbtnview_Click">View</asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                               
                                                 <telerik:GridTemplateColumn HeaderText="Account Name" HeaderStyle-Width="150px" DataField="AccountName" HeaderTooltip="As defined in the Chart of Accounts.  The trial balance is shown sorted in Group, Subgroup1,Account Code order.Click on account name to view balance at the end of a billing period" AllowFiltering="true" FilterControlWidth="120px" UniqueName="AccountName" SortExpression="AccountName">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkAccName" runat="server" ToolTip="Click to View month end Closing Balance details." Text='<%# Eval("AccountName") %>' Font-Bold="true" Font-Size="X-Small"  OnClick="lnkAccName_Click"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>


                                                <%--<telerik:GridBoundColumn HeaderText="Account Name" HeaderStyle-Width="150px" DataField="AccountName" HeaderTooltip="As defined in the Chart of Accounts.  The trial balance is shown sorted in Group, Subgroup1,Account Code order.Click on account name to view balance at the end of a billing period" AllowFiltering="true" FilterControlWidth="120px"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Debit Bal" HeaderStyle-Width="60px" FilterControlWidth="55px" HeaderTooltip=" Closing balance in the account.  If it is  a positive value it is shown in the Debit Balance Col." DataField="DtAccountBalance" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right"  ItemStyle-HorizontalAlign="Right" 
                                                                     FooterStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                              <telerik:GridBoundColumn HeaderText="Credit Bal" HeaderStyle-Width="60px" FilterControlWidth="55px" HeaderTooltip="Closing balance in the account.  If it is  a negative value it is shown in the Credit Balance Col." DataField="CrAccountBalance" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right"  ItemStyle-HorizontalAlign="Right" FooterStyle-Font-Bold="true"
                                                                     FooterStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                 <telerik:GridBoundColumn HeaderText="Category" HeaderStyle-Width="80px" DataField="AccountGroup" HeaderTooltip=" Defines whether the account belongs to Assets or Liabilities or Income or Expense main group (category).  The number 1 or 2 or 3 or 4 is prefixed to ensure the sort order is always as Assets, Liabilities, Income, Expense." AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Sub Group" HeaderStyle-Width="80px" DataField="SubGroup" HeaderTooltip=" Various subgroups can be defined and an account can belong to one of the sub-groups.  When defining an account code, include the subgroup also." AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                 <telerik:GridBoundColumn HeaderText="AccountCode" Display="false" HeaderStyle-Width="150px" DataField="AccountCode"  AllowFiltering="true" FilterControlWidth="120px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="AccountName" Display="false" HeaderStyle-Width="150px" DataField="AccountName"  AllowFiltering="true" FilterControlWidth="120px"></telerik:GridBoundColumn>
                                                 <%--  <telerik:GridBoundColumn DataField="CrAccountBalance" HeaderText="Cr.Cls.Bal" HeaderStyle-ForeColor="White" FooterStyle-Font-Bold="true" UniqueName="CrAccountBalance"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterText="Total:" FooterStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle></telerik:GridBoundColumn>--%>
                                                
                                                
                                              
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
                                    <asp:Label runat="server" ID="lblCount" Text="-" CssClass="style2" ForeColor="Maroon" Font-Names="Verdana"
                                                                        Font-Bold="true" Font-Size="small" Visible="false"></asp:Label>&nbsp;&nbsp;
                                    <asp:Button ID="BtnnExcelExport" Visible="false" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="Button1_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                                </td>
                            </tr>
                        </table>
                       
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="ReportList" />
            <asp:PostBackTrigger ControlID="lnkTitle" />
            <asp:PostBackTrigger ControlID="BtnnExcelExport" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>


