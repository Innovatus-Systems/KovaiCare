<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DailyFoodBillReport.aspx.cs" Inherits="DailyFoodBillReport" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
       <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 98%">
                <table>
                    <tr>
                        <td></td>
                    </tr>
                </table>
                <table style="width: 100%">
                    <tr>
                        <td align="center">
                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <table>

                    <%--<tr>


                        <td>
                            <telerik:RadAutoCompleteBox ID="DdlUhid" Font-Names="verdana" Width="350px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource1" runat="server" DataTextField="Customer" DataValueField="RTRSN" InputType="Text" MinFilterLength="1"
                                EmptyMessage="Choose ResidentID / DoorNo / Name " ToolTip="Choose the ResidentID / DoorNo / Name to view the customer details" AutoPostBack="true" TextSettings-SelectionMode="Single">
                                <TextSettings SelectionMode="Single" />
                            </telerik:RadAutoCompleteBox>
                            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select convert(nvarchar(10),RTRSN) +', '+ RTVILLANO +', '+ RTName + ', ' + convert(nvarchar(10),RTRSN) as Customer,RTRSN from tblresident order by RTName asc"></asp:SqlDataSource>
                        </td>





                    </tr>--%>

                    <tr>

                        <td>
                            <asp:Label ID="lblfordate" runat="Server" Text="From" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <telerik:RadDatePicker ID="dtpfordate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date from which you wish to view the transaction details." AutoPostBack="true">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>
                            &nbsp;&nbsp;
                       <%-- </td>
                        <td>--%>
                            <asp:Label ID="lbluntildate" runat="Server" Text="To" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                            <telerik:RadDatePicker ID="dtpuntildate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date till which you wish to view the transaction details." AutoPostBack="true">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>
                            &nbsp;&nbsp;
                      <%--  </td>
                         <td>     --%>
                            <asp:Label ID="Label4" runat="Server" Text="Resident" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                Width="250px" ToolTip="" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged"
                                RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                            </telerik:RadComboBox>
                            &nbsp;                            
                             <asp:Label ID="Label3" runat="Server" Text="Account" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:DropDownList ID="ddlAccountNumber" ToolTip="Select General or Deposit account number" Width="120px" Height="25px" runat="server"
                                Font-Names="Verdana" Font-Size="Small">
                            </asp:DropDownList>
                        </td>
                        <td style="right: auto">
                            <%--<asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the transaction details within the selected date range." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />--%>

                            <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the transaction details within the selected date range." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />

                        </td>
                    </tr>

                    <tr>
                        <td colspan="4">
                            <asp:Label ID="Label1" runat="Server" Text=""
                                ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                        </td>
                    </tr>

                    

                    <tr>
                        
                        <td colspan="2" align="left">
                            <asp:Label ID="lbldepositamount" runat="Server" Text="" ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                        </td>
                        <td colspan="2" align="right">
                            <asp:Label ID="lbloutstanding" runat="Server" Text="" ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                        </td>
                    </tr>

                </table>

                <table style ="width:100%">
                    <tr>
                        
                        <td style ="margin-left:60%" >

                            <asp:Label ID="lblDoorNo" runat="Server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:Label ID="lblstatus" runat="Server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                       
                                                      
                            <asp:Label ID="lblaccountname" runat="Server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        </td>
                    </tr>
                </table>

                <table>
                    <tr>

                        <td style="width: 1200px; height: 100px; vertical-align: top;">
                            <telerik:RadGrid ID="ReportList" runat="server"  AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
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

                                        <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Wrap="false"
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
                                        <telerik:GridBoundColumn HeaderText="Group" DataField="Group" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn HeaderText="Ref" DataField="Ref" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn HeaderText="Narration" DataField="Narration" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Type" DataField="Type" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Debit" DataField="DR" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Credit" DataField="CR" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Closing" DataField="Closing" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="50px"
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


                <table style="width:100%">
                    <tr>
                        <td style="width:50%">
                            <asp:LinkButton ID="LinkButton1" runat="server" Text="Meals-to be billed" CommandName="ViewDetails" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" ToolTip="Meals consumed during the current billing period. Actual charges will be posted as part of month end billing."></asp:LinkButton>
                             <telerik:RadGrid ID="rgDiningSummaryBills" runat="server" AllowPaging="false"  AutoPostBack="true"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                Width="99%" Height="250px"
                                MasterTableView-HierarchyDefaultExpanded="true" OnInit="rgDiningSummaryBills_Init" >
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" FrozenColumnsCount="3" />
                                </ClientSettings>
                                <HeaderContextMenu CssClass="table table-bordered table-hover">
                                </HeaderContextMenu>
                                <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
                                <MasterTableView AllowCustomPaging="false" AllowFilteringByColumn="false" TableLayout="Fixed">
                                    <NoRecordsTemplate>
                                        No Transactions Found.
                                    </NoRecordsTemplate>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                   
                                    <Columns>

                                        <telerik:GridTemplateColumn HeaderText="Session" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="true"  ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnksession" runat="server" Text='<%# Eval("sessionname") %>'  ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Meals" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkdinerscount" runat="server" Text='<%# Eval("DCount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Rs." ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkdinersamount" runat="server" Text='<%# Eval("DAmount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Guests" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkguestcount" runat="server" Text='<%# Eval("GCount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Rs." ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkguestamount" runat="server" Text='<%# Eval("GuestAmount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                         
                                        <telerik:GridTemplateColumn HeaderText="H.S.Count" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkhscount" runat="server" Text='<%# Eval("HCount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        
                                        <telerik:GridTemplateColumn HeaderText="Rs." ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkhsamount" runat="server" Text='<%# Eval("HSAmount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="Total Amt." ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnktotalamount" runat="server" Text='<%# Eval("TotalAmount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

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

                        <td style="width:50%">
                             <asp:LinkButton ID="lnkctcm" runat="server" Text="Beverages-to be billed" CommandName="ViewDetails" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" ToolTip="Beverages consumed during the current billing period. Actual charges will be posted as part of month end billing."></asp:LinkButton>
                             <telerik:RadGrid ID="rgTCMBillSummary" runat="server" AllowPaging="false"  AutoPostBack="true"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                Width="99%" Height="250px"
                                MasterTableView-HierarchyDefaultExpanded="true" OnInit="rgDiningSummaryBills_Init" >
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" FrozenColumnsCount="3" />
                                </ClientSettings>
                                <HeaderContextMenu CssClass="table table-bordered table-hover">
                                </HeaderContextMenu>
                                <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
                                <MasterTableView AllowCustomPaging="false" AllowFilteringByColumn="false" TableLayout="Fixed">
                                    <NoRecordsTemplate>
                                        No Transactions Found.
                                    </NoRecordsTemplate>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                   
                                    <Columns>

                                        <telerik:GridTemplateColumn HeaderText="Session" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="true"  ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" >
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnksession" runat="server" Text='<%# Eval("sessionname") %>'  ></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Tea" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkteacount" runat="server" Text='<%# Eval("Tea") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Rs." ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkteaaamount" runat="server" Text='<%# Eval("TAmount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Coffee" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkcoffeecount" runat="server" Text='<%# Eval("Coffee") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Rs." ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkcoffeeamount" runat="server" Text='<%# Eval("CAmount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                         
                                        <telerik:GridTemplateColumn HeaderText="HomeSvce" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="center" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkhscount" runat="server" Text='<%# Eval("Homeservice") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        
                                        <telerik:GridTemplateColumn HeaderText="Rs." ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkhsamount" runat="server" Text='<%# Eval("HSAmount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="Total Amount" ItemStyle-HorizontalAlign="right" HeaderStyle-HorizontalAlign="right" Visible="true" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnktotalamount" runat="server" Text='<%# Eval("TotalAmount") %>'  CommandName="ViewDetails"></asp:LinkButton>
                                        </ItemTemplate>
                                        </telerik:GridTemplateColumn>

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
        </div>
    </div>
    </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="cmbResident" />
                
                </Triggers>
     </asp:UpdatePanel>


</asp:Content>

