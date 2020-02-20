<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DayBook.aspx.cs" Inherits="DayBook" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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

    </script>
    <style type="text/css">
        .RadGrid th.rgHeader
    {
        background-image: none;
        background-color: #196F3D;
        color:white;
        font-weight:bold;
    }
    </style>

     <style type="text/css">
        
.Loadingdiv {
     position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 0.6;
    -moz-opacity: 0.8;
}

.centerdiv
{
    z-index: 1000;
    margin: 300px auto;
    padding: 10px;
    width: 130px;
    background-color: White;
    border-radius: 10px;
    filter: alpha(opacity=100);
    opacity: 1;
    -moz-opacity: 1;
}
.centerdiv img
{
    height: 128px;
    width: 128px;
}

    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="main_cnt">
        <div class="first_cnt">
             <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpPanel">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                              <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="Images/Loader.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
             <asp:UpdatePanel ID="UpPanel" runat="server">
                <ContentTemplate>
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
                    <tr>
                       
          
                        <td colspan="3">                        
                             <asp:Label ID="Label4" runat="Server" Text="Account:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>                            
                            <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                Width="250px" ToolTip="" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged"
                                RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                            </telerik:RadComboBox>   &nbsp;&nbsp;
                              <asp:Label ID="lblDis" runat="server" Text="" Visible="false" Font-Size="Small"  Font-Bold="true" ></asp:Label>                           
                             <asp:Label ID="lblAccountCode" runat="server" Text="" Visible="false" Font-Size="Small"  Font-Bold="true" ></asp:Label>                        
                                     
                            </td>
                        
                        <td>


                            <asp:Label ID="lblfordate" runat="Server" Text="From:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                           
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
                          </td>
                        <td>

                     
                            <asp:Label ID="lbluntildate" runat="Server" Text="To:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            
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
                           </td>
                                            
                        
                        <td style="right: auto">
                            <%--<asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the transaction details within the selected date range." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />--%>

                            <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the transaction details within the selected date range." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                            <asp:Button ID="BtnnExcelExport" AutoPostBack="true" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />

                        </td>
                        <%-- <td>
                             <asp:Label ID="lblClosingbal" runat="server" Text="Closing bal Rs.:" ></asp:Label>
                             <asp:Label ID="lblClosingbalval" runat="server" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Font-Bold="true" Text="-" ></asp:Label>
                   
                        </td>   
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Txn:"></asp:Label>
                             <asp:Label ID="Label2" runat="server" Text="Debit:"></asp:Label>
                             <asp:Label ID="lblDebitCnt" runat="server" Text="-" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"  Font-Bold="true" ></asp:Label>
                             &nbsp;&nbsp;<asp:Label ID="Label5" runat="server" Text="Credit:"></asp:Label>
                            <asp:Label ID="lblCreditcnt" runat="server" Text="-" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"  Font-Bold="true" ></asp:Label>
                        </td>            --%>
                           </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Category:"></asp:Label> &nbsp;&nbsp;
                            <asp:Label ID="lblCategory" runat="server" Text="-" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"  Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label6" runat="server" Text="Sub Group1:"></asp:Label> &nbsp;&nbsp;
                            <asp:Label ID="lblSubGrp1" runat="server" Text="-" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"  Font-Bold="true"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                       
                  
                    </tr>
                       </table>
                <table>
         </table>
             
                <table>
                    <tr>

                        <td style="width: 1200px; height: 100px; vertical-align: top;">
                            <telerik:RadGrid ID="ReportList" runat="server"  AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                Width="98%"
                                MasterTableView-HierarchyDefaultExpanded="true">
                                <ClientSettings>
                                    <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                </ClientSettings>
                                <HeaderContextMenu CssClass="table table-bordered table-hover">
                                </HeaderContextMenu>
                                <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                <MasterTableView AllowCustomPaging="false">
                                    <NoRecordsTemplate>
                                       Select an Account to view the ledger.
                                    </NoRecordsTemplate>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn>
                                        <HeaderStyle Width="10px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn>
                                        <HeaderStyle Width="10px"></HeaderStyle>
                                    </ExpandCollapseColumn>
                                    <Columns>
                                         <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="60px" DataField="Date" ReadOnly="true" AllowFiltering="true" FilterControlWidth="40px"></telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn HeaderText="Ref" HeaderStyle-Width="100px" DataField="Ref" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn> 
                                        <telerik:GridBoundColumn HeaderText="Account" HeaderStyle-Width="70px" DataField="AccountNo" ReadOnly="true" AllowFiltering="true" FilterControlWidth="40px"></telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn HeaderText="Txn.Cd" HeaderStyle-Width="50px" DataField="TxnCode" ReadOnly="true" AllowFiltering="true" FilterControlWidth="30px"></telerik:GridBoundColumn>                    
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
                    <tr>
                        <td>
                            <telerik:RadGrid ID="rdTrailBal" runat="server" Visible="false"  AutoPostBack="true"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="true"
                                CellSpacing="5" Width="60%" Height="90px" 
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

                                        <telerik:GridBoundColumn HeaderText="From Date" DataField="FDate" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Till Date" DataField="TDate" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn> 
                                         <telerik:GridBoundColumn HeaderText="No. Of DR." DataField="NDR" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>  
                                         <telerik:GridBoundColumn HeaderText="No. Of CR." DataField="NCR" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>                                     
                                        <telerik:GridBoundColumn HeaderText="Total Debit" DataField="TDR" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                            ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Total Credit" DataField="TCR" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
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
            </div>
                     </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="BtnShow" />
                    <asp:PostBackTrigger ControlID="BtnnExcelExport" />                   
                    <asp:AsyncPostBackTrigger ControlID="cmbResident" />
                   
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

