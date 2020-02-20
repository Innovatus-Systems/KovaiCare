<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GuestLedger.aspx.cs" Inherits="GuestLedger" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%--<link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
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
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 98%" align="center">
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
                         <td colspan="2" >    
                            <asp:Label ID="Label4" runat="Server" Text="Guest:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" ></asp:Label>
                            <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                Font-Names="Arial" Font-Size="Small" AutoPostBack="true"
                                Width="200px" ToolTip="" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged"
                                RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                            </telerik:RadComboBox>
                            &nbsp;                            
                             <asp:Label ID="Label3" runat="Server" Text="Account:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                            <asp:DropDownList ID="ddlAccountNumber" ToolTip="Select General or Deposit account number"  runat="server"
                                Font-Names="Verdana" Font-Size="Small" Visible="false">
                            </asp:DropDownList>
                         &nbsp;&nbsp;
                            <asp:Label ID="lblfordate" runat="Server" Text="From" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                            <telerik:RadDatePicker ID="dtpfordate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small" Visible="false"
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
                            <asp:Label ID="lbluntildate" runat="Server" Text="To" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>

                            <telerik:RadDatePicker ID="dtpuntildate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date till which you wish to view the transaction details." AutoPostBack="true" Visible="false">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>
                              &nbsp;&nbsp;
                                    <asp:CheckBox ID="chkstatus" runat="server" Text="Show GST also" ToolTip="Click here to view GST txns also." AutoPostBack="true" OnCheckedChanged="chkstatus_CheckedChanged" />
                            &nbsp;&nbsp;
                            <%-- <td style="right: auto">--%>
                            <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the transaction details within the selected date range." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                          
                               
                         </td>
                   
                        
                    </tr>
                    <tr style="width:80%">
                        <td>  
                           <asp:Label ID="lblname" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller"  Font-Bold="true"></asp:Label>
                                         <%-- <asp:Label ID="Label7" runat="server" Text="Category:"  Font-Size="Smaller" Visible="false"></asp:Label>
                            <asp:Label ID="lblCategory" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller"  Font-Bold="true" Visible="false"></asp:Label>
                           --%>
                            <asp:Label ID="Label8" runat="server" Text="DebitAmount:Rs." Font-Names="Verdana" Font-Size="Smaller" ToolTip="Total debit amount within selected date range."></asp:Label> 
                            <asp:Label ID="lblTDt" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" ToolTip="Total debit amount within selected date range." Font-Bold="true"></asp:Label>&nbsp;&nbsp
                                                              
                            <asp:Label ID="Label5" runat="Server" Text="Total Credit :Rs." Font-Names="Verdana" Font-Size="Smaller" ToolTip="Total credit amount within selected date range." Visible="false"></asp:Label>
                            <asp:Label ID="lblTCt" runat="Server" Text="-" ForeColor="Maroon" Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller" ToolTip="Total credit amount within selected date range." Visible="false"></asp:Label>                            
                          
                           <%-- <asp:Label ID="Label2" runat="Server" Text="Total Debit :Rs." Font-Names="Verdana" Font-Size="Smaller" ToolTip="Opening Bal. as of 'To Date' selected."> </asp:Label>
                            <asp:Label ID="lblCloBal" runat="Server" Text="0.00" ForeColor="Maroon" Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller" ToolTip="Opening Bal. as of 'To Date' selected."></asp:Label>
                             ---%>
                            <asp:Label ID="Label6" runat="Server" Text="Latest Txn. Dt.:" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                            <asp:Label ID="lblLatTxnDt" runat="Server" Text="-" ForeColor="Maroon" Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                        
                             <asp:Label ID="Label10" runat="server" Text="TxnCount:" Font-Names="Verdana"  Font-Size="Smaller"></asp:Label>
                             <asp:Label ID="lblDebitCnt" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller"  Font-Bold="true" ></asp:Label>
                            
                            <asp:Label ID="Label11" runat="server" Text="#Credit:" Font-Names="Verdana" Font-Size="Smaller" Visible="false"></asp:Label>
                            <asp:Label ID="lblCreditcnt" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller"  Font-Bold="true" Visible="false"></asp:Label>                          
                             
                                   
                        </td>
                        <td align="left">
                             <asp:Label ID="Label1" runat="server" Text="Filter By Session : " ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller"  Font-Bold="true" Visible="false"></asp:Label>
                             <asp:DropDownList ID="drpSessionfilters" ToolTip="."  runat="server" ForeColor="Maroon" Font-Bold="true" OnSelectedIndexChanged="drpSessionfilters_SelectedIndexChanged" Visible="false" AutoPostBack="true">                                
                            </asp:DropDownList>                           
                        </td>
                    </tr>
                </table>
                <table style="width: 97%">
                    <tr>
                        
                        <td align="right">
                            <asp:Label ID="lbltotoutstanding" runat="Server" Text="" ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Smaller" Visible="false"></asp:Label>
                            <asp:Label ID="lbltotdebitcredit" runat="Server" Text="" ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Smaller" Visible="false"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table align="center">
                    <tr>
                        <td style="width: 98%; height: 185px; vertical-align: top;" align="center">
                            <telerik:RadGrid ID="ReportList" runat="server" AllowPaging="false" AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="false" AllowFilteringByColumn="true" OnInit="ReportList_Init"
                                CellSpacing="5" Width="85%" GroupingSettings-CaseSensitive="false"
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
                                        <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="50px" DataField="Date" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="Sorted by ascending order of date." ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Txn.Cd" HeaderStyle-Width="40px" DataField="Group" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip="This links to the transaction posting rules." ></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Ref" HeaderStyle-Width="60px" DataField="Ref" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip="Digits 1 to 14 – Batch ref.no,  Last two digits – Sequence no. within the batch , Last but one digit – No.of txns in the batch."></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Narration" HeaderStyle-Width="140px" DataField="Narration" ReadOnly="true" AllowFiltering="true" FilterControlWidth="105px" HeaderTooltip="Standard narration as set for the transaction code # additional remarks"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="DR/CR" HeaderStyle-Width="40px" DataField="Type" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Debit" HeaderStyle-Width="45px" DataField="DR" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip=""></telerik:GridBoundColumn>
                                       <%-- <telerik:GridBoundColumn HeaderText="Reg." HeaderStyle-Width="40px" DataField="DINERS" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Gst./Cas." HeaderStyle-Width="40px" DataField="GUEST" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Hm.Dly." HeaderStyle-Width="40px" DataField="HMDLY" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>--%>
                                        
                                         <telerik:GridBoundColumn HeaderText="TXREFNO" HeaderStyle-Width="40px" DataField="TXREFNO" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" Display="false" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        
                                        
                                         <telerik:GridBoundColumn HeaderText="Credit" HeaderStyle-Width="50px" DataField="CR" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="55px" HeaderTooltip="" Display="false"></telerik:GridBoundColumn>
                                        <%-- <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
                                        <%-- <telerik:GridBoundColumn HeaderText="Account No." DataField="AccountNo" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="DooNo" DataField="DoorNo" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Name" DataField="Name" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
                                        <%--    <telerik:GridBoundColumn HeaderText="Txn.Cd" DataField="Group" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
                                        <%--     <telerik:GridBoundColumn HeaderText="Ref" DataField="Ref" HeaderStyle-Wrap="false" Visible="true"
                                            ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="10px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
                                        <%-- <telerik:GridBoundColumn HeaderText="Narration" DataField="Narration" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn HeaderText="Mode" DataField="Paymode" HeaderStyle-Wrap="false" Display="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <%--  <telerik:GridBoundColumn HeaderText="DR/CR" DataField="Type" HeaderStyle-Wrap="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
                                        <%-- <telerik:GridBoundColumn HeaderText="Debit" DataField="DR" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Credit" DataField="CR" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn HeaderText="Closing" DataField="Closing" HeaderStyle-Wrap="false" Display="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="50px"
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
                        
                            <telerik:RadGrid ID="ReportListAll" runat="server" AllowPaging="false" AutoPostBack="true" OnItemCommand="ReportListAll_ItemCommand"
                                AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" ShowFooter="false" AllowFilteringByColumn="true" OnInit="ReportListAll_Init"
                                 Width="95%" GroupingSettings-CaseSensitive="false"
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
                                        <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="60px" DataField="Date" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="Sorted by ascending order of date." ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="120px" DataField="Name" ReadOnly="true" AllowFiltering="true" FilterControlWidth="105px" HeaderTooltip=""></telerik:GridBoundColumn>
                                         <telerik:GridBoundColumn HeaderText="Txn.Cd" HeaderStyle-Width="40px" DataField="Group" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip="This links to the transaction posting rules." ></telerik:GridBoundColumn>
                                      
                                         
                                          <telerik:GridBoundColumn HeaderText="Ref" HeaderStyle-Width="80px" DataField="Ref" ReadOnly="true" AllowFiltering="true" FilterControlWidth="65px" HeaderTooltip="Digits 1 to 14 – Batch ref.no,  Last two digits – Sequence no. within the batch , Last but one digit – No.of txns in the batch."></telerik:GridBoundColumn>
                                       
                                         <telerik:GridBoundColumn HeaderText="Narration" HeaderStyle-Width="140px" DataField="Narration" ReadOnly="true" AllowFiltering="true" FilterControlWidth="105px" HeaderTooltip="Standard narration as set for the transaction code # additional remarks"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="DR/CR" HeaderStyle-Width="40px" DataField="Type" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Debit" HeaderStyle-Width="45px" DataField="DR" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip=""></telerik:GridBoundColumn>
                                       <%-- <telerik:GridBoundColumn HeaderText="Reg." HeaderStyle-Width="40px" DataField="DINERS" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Gst./Cas." HeaderStyle-Width="40px" DataField="GUEST" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Hm.Dly." HeaderStyle-Width="40px" DataField="HMDLY" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        --%>
                                           <telerik:GridBoundColumn HeaderText="TXREFNO" HeaderStyle-Width="40px" DataField="TXREFNO" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" Display="false" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        
                                        
                                         <telerik:GridBoundColumn HeaderText="Credit" HeaderStyle-Width="50px" DataField="CR" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="55px" HeaderTooltip="" Display="false"></telerik:GridBoundColumn>
                                      
                                     
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
</asp:Content>


