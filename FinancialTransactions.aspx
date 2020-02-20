<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="FinancialTransactions.aspx.cs" Inherits="FinancialTransactions" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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

        function checkBoxList1OnCheck(listControlRef) {
            var inputItemArray = listControlRef.getElementsByTagName('input');

            for (var i = 0; i < inputItemArray.length; i++) {
                var inputItem = inputItemArray[i];

                if (inputItem.checked) {
                    inputItem.parentElement.style.color = 'Orange';
                }
                else {
                    inputItem.parentElement.style.color = 'Black';
                }
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
                        <td>
                            <asp:Label ID="Label4" runat="Server" Text="Resident:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                Font-Names="Arial" Font-Size="Small" AutoPostBack="true"
                                Width="200px" ToolTip="" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged"
                                RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                            </telerik:RadComboBox>
                            &nbsp;                            
                             <asp:Label ID="Label3" runat="Server" Text="Account:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <asp:DropDownList ID="ddlAccountNumber" ToolTip="Select General or Deposit account number" Width="120px" Height="25px" runat="server"
                                Font-Names="Verdana" Font-Size="Small">
                            </asp:DropDownList>
                            &nbsp;&nbsp;
                            <asp:Label ID="lblfordate" runat="Server" Text="From" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            <telerik:RadDatePicker ID="dtpfordate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date from which you wish to view the transaction details." AutoPostBack="false">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>
                            &nbsp;&nbsp;
                        
                            <asp:Label ID="lbluntildate" runat="Server" Text="To" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                            <telerik:RadDatePicker ID="dtpuntildate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date till which you wish to view the transaction details." AutoPostBack="false">
                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                    CssClass="TextBox" Font-Names="Calibri">
                                </Calendar>
                                <DatePopupButton></DatePopupButton>
                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                    ForeColor="Black" ReadOnly="true">
                                </DateInput>
                            </telerik:RadDatePicker>

                            &nbsp;&nbsp;
                             
                            <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the transaction details within the selected date range." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />




                        </td>


                    </tr>
                    <tr>
                        <td>


                            <table>

                                <tr>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" Text="Category:" Font-Size="Smaller" Visible="false"></asp:Label>
                                        <asp:Label ID="lblCategory" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>

                                        <asp:Label ID="Label8" runat="server" Text="Sub Group:" Font-Size="Smaller" Visible="false"></asp:Label>
                                        <asp:Label ID="lblSubGrp1" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>&nbsp;&nbsp
                                                   
                                        <asp:Label ID="Label10" runat="server" Text="For the period - " Font-Names="Verdana" Font-Size="Smaller" Visible="true"></asp:Label>

                                        <asp:Label ID="Label5" runat="Server" Text="Opn. Bal. :Rs." Font-Names="Verdana" Font-Size="Smaller" ToolTip="Opening Bal. as of 'From Date' selected."></asp:Label>
                                        <asp:Label ID="lblOpBal" runat="Server" Text="0.00" ForeColor="Maroon" Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller" ToolTip="Opening Bal. as of 'From Date' selected."></asp:Label>
                                        - 
                                        <asp:Label ID="Label2" runat="Server" Text="Closing Bal. :Rs." Font-Names="Verdana" Font-Size="Smaller" ToolTip="Opening Bal. as of 'To Date' selected."> </asp:Label>
                                        <asp:Label ID="lblCloBal" runat="Server" Text="0.00" ForeColor="Maroon" Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller" ToolTip="Opening Bal. as of 'To Date' selected."></asp:Label>
                                        -
                                        <asp:Label ID="Label6" runat="Server" Text="Latest Txn. Dt.:" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                        <asp:Label ID="lblLatTxnDt" runat="Server" Text="-" ForeColor="Maroon" Font-Bold="true" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                        -
                          
                                                  <%--  <asp:Label ID="Label10" runat="server" Text="#Debit:" Font-Size="Smaller" Visible="false"></asp:Label>
                                                    <asp:Label ID="lblDebitCnt" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>
                                                    -
                                                    <asp:Label ID="Label11" runat="server" Text="#Credit:" Font-Size="Smaller" Visible="false"></asp:Label>
                                                    <asp:Label ID="lblCreditcnt" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>--%>

                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        <asp:Label ID="Label9" runat="server" Text="Category:" Font-Size="Smaller" Visible="false"></asp:Label>
                                        <asp:Label ID="Label13" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>

                                        <asp:Label ID="Label15" runat="server" Text="Sub Group:" Font-Size="Smaller" Visible="false"></asp:Label>
                                        <asp:Label ID="Label16" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>&nbsp;&nbsp
                                                             

                                        <asp:Label ID="lblLCount" runat="server" Text="Count - " Font-Size="Smaller" Visible="false" Font-Names="Verdana"></asp:Label>
                                        <asp:Label ID="lblLDR" runat="server" Text="#Debit : " Font-Size="Smaller" Visible="false" Font-Names="Verdana"></asp:Label>
                                        <asp:Label ID="lblDR" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>

                                        <asp:Label ID="lblLCR" runat="server" Text="#Credit : " Font-Size="Smaller" Visible="false" Font-Names="Verdana"></asp:Label>
                                        <asp:Label ID="lblCR" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>

                                    </td>
                                </tr>
                            </table>


                        </td>
                    </tr>
                </table>
                <table style="width: 100%">
                    <tr>
                        <td align="right">
                            <asp:Label ID="lbltotoutstanding" runat="Server" Text="" ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Smaller" Visible="false"></asp:Label>
                            <asp:Label ID="lbltotdebitcredit" runat="Server" Text="" ForeColor="DarkGray" Font-Names="Verdana" Font-Size="Smaller" Visible="false"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%">
                    <tr>


                        <td style="width: 100%; height: 185px; vertical-align: top;">
                            <telerik:RadGrid ID="ReportList" runat="server" AutoPostBack="true" OnItemCommand="ReportList_ItemCommand"
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
                                        Select an Account to view the ledger.
                                    </NoRecordsTemplate>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn>
                                        <HeaderStyle Width="10px"></HeaderStyle>
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn>
                                        <HeaderStyle Width="10px"></HeaderStyle>
                                    </ExpandCollapseColumn>
                                    <FooterStyle ForeColor="Black" Font-Bold="true" HorizontalAlign="Right" />
                                    <Columns>
                                        <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="50px" DataField="Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ReadOnly="true" AllowFiltering="true" FilterControlWidth="45px" HeaderTooltip="Sorted by ascending order of date."></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Txn.Cd" HeaderStyle-Width="40px" DataField="Group" ReadOnly="true" AllowFiltering="true" FilterControlWidth="35px" HeaderTooltip="This links to the transaction posting rules."></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Ref#" HeaderStyle-Width="80px" DataField="Ref" ReadOnly="true" AllowFiltering="true" FilterControlWidth="85px" HeaderTooltip="Digits 1 to 14 – Batch ref.no,  Last two digits – Sequence no. within the batch , Last but one digit – No.of txns in the batch."></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Narration" HeaderStyle-Width="180px" DataField="Narration" ReadOnly="true" AllowFiltering="true" FilterControlWidth="135px" HeaderTooltip="Standard narration as set for the transaction code # additional remarks"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="DR/CR" HeaderStyle-Width="40px" DataField="Type" ReadOnly="true" AllowFiltering="true" FilterControlWidth="25px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn Aggregate="Sum" FooterText="Total: " HeaderText="Debit" HeaderStyle-Width="50px" DataField="DR" UniqueName="DR" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="55px" HeaderTooltip=""></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn Aggregate="Sum" FooterText="Total: " HeaderText="Credit" HeaderStyle-Width="50px" DataField="CR" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ReadOnly="true" AllowFiltering="true" FilterControlWidth="55px" HeaderTooltip=""></telerik:GridBoundColumn>                                        
                                        <telerik:GridBoundColumn HeaderText="Mode" DataField="Paymode" HeaderStyle-Wrap="false" Display="false"
                                            ItemStyle-Wrap="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="30px"
                                            ItemStyle-CssClass="Row1">
                                            <HeaderStyle Wrap="False"></HeaderStyle>
                                            <ItemStyle Wrap="False"></ItemStyle>
                                        </telerik:GridBoundColumn>                                        
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
                        </td>
                    </tr>
                   <%-- <tr>


                        <td align="right">


                            <asp:Label ID="lblLDrTot" runat="server" Text="Debit Total :" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>
                            <asp:Label ID="lblDrTot" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>
                            &nbsp;&nbsp;
                         <asp:Label ID="lblLCrTot" runat="server" Text="Credit Total :" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>
                            <asp:Label ID="lblCrTot" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="false"></asp:Label>
                        </td>
                    </tr>--%>
                    <tr>
                        <td>
                            <asp:Label ID="Label17" runat="server" Text="Transaction Codes (Select required ones and press Show) : " ToolTip="By default all txn. codes for which txns. exist, are displayed. To filter for specific codes, select them & press Show." Font-Names="Verdana" Font-Size="Smaller" Font-Bold="true" Visible="true"></asp:Label>
                            <br />
                            <%--<asp:Panel ID="chkListPanel" runat="server" Height="300" Width="280" ScrollBars="Both" Visible="true" BorderWidth="1">--%>
                            <asp:CheckBoxList ID="chkTxnCode" Width="100%" RepeatLayout="Table" BorderStyle="Solid" 
                                BorderWidth="1" BorderColor="LightGray" runat="server" Visible="true" CellPadding="0" CellSpacing="0" 
                                RepeatDirection="Horizontal" RepeatColumns="6" onclick="checkBoxList1OnCheck(this);"></asp:CheckBoxList>
                            <%--</asp:Panel>--%>
                                     
                        </td>
                    </tr>
                </table>




            </div>
        </div>
    </div>
</asp:Content>


