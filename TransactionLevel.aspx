<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="TransactionLevel.aspx.cs" Inherits="TransactionLevel" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });

        function ConfirmMsg() {

            var result = confirm('Are you sure, you want to save?');

            if (result) {
                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }
        function allowOnlyNumber(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode

            if (charCode == 46) {
                var inputValue = $("#inputfield").val()
                if (inputValue.indexOf('.') < 1) {
                    return true;
                }
                return false;
            }
            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>
     <script type="text/javascript">
         function Validate() {
             var summ = "";
             summ += Phno();
             summ += Email();

             if (summ == "") {
                 var msg = "";
                 msg = 'Are you sure, you want to save?';
                 var result = confirm(msg, "Check");
                 if (result) {                    
                      return true;
                  }
                  else {                     
                      return false;
                  }
              }
              else {
                  alert(summ);
                  return false;
              }

          }

          function Phno() {
              var Name = document.getElementById('<%=txttext.ClientID%>').value;
            var chk = /^[-+]?[0-9]+$/
            if (Name == "") {
                return "Please enter action" + "\n";
            }            
            else {
                return "";
            }
        }

        function Email() {
            var Name = document.getElementById('<%=txtvalue.ClientID%>').value;
            var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
            if (Name == "") {
                return "Please enter value" + "\n";
            }           
            else {
                return "";
            }
        }

    </script>

    <script type="text/javascript">
        function ValidateAmt()
        {
            var summ = "";
            summ += Amt();
            if (summ == "") {
                var conf = confirm('Are you sure, you want to save?');
                if (conf)
                    return true;
                else
                    return false;
            }
            else {
                alert(summ);
                return false;
               
            }
        }

        function Amt() {
            var Name = document.getElementById('<%=txtAmtReceivedNow.ClientID%>').value;
            var chk = /^[0-9]+$/
            if (Name == "") {
                return "Please Enter received amount" + "\n";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid amount" + "\n";
            }
        }
    </script>

    <div class="main_cnt">
        <div class="first_cnt">

            <table>
                <tr>
                    <td style="width: 10px;"></td>
                    <td style="width: 600px;" align="left">
                        <asp:Label ID="Label56" runat="Server" Text="Level C  - " ForeColor="Brown" Font-Names="Calibri" Font-Bold="true"
                            Font-Size="Large"></asp:Label>
                        <asp:Label ID="lblSelCustName" runat="server" CssClass="Font_lbl" Visible="false" Font-Bold="true"
                            ForeColor="Blue"></asp:Label>
                        <asp:Label ID="Label58" runat="server" CssClass="Font_lbl" Text=" " Width="50px"
                            ForeColor="BlueViolet"></asp:Label>
                        <%-- <asp:HiddenField ID="hdnTotalAmt" runat="server" />--%>
                             
                    </td>
                </tr>
                <tr id="trCustDet" visible="true" runat="server">
                    <td style="width: 5px;"></td>
                    <td id="tdTab" style="width: 1100px; vertical-align: central;" visible="true" runat="server">
                        <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1"
                            Skin="Sunset" BorderColor="LightGray" BorderStyle="Ridge" BorderWidth="0px" SelectedIndex="4" Style="margin-bottom: 0">
                            <Tabs>
                                <telerik:RadTab runat="server" Text="TXN Posting" PageViewID="Transactions" CssClass="Font_lbl"
                                    ForeColor="Black" ToolTip="Click here to post the transaction(s)">
                                </telerik:RadTab>
                                <telerik:RadTab runat="server" Text="Billed TXNS" PageViewID="BTxns" CssClass="Font_lbl"
                                    ForeColor="Black" ToolTip="Click here to view the billed transactions">
                                </telerik:RadTab>
                                <telerik:RadTab runat="server" Text="UnBilled TXNS" PageViewID="UBTxns" CssClass="Font_lbl"
                                    ForeColor="Black" ToolTip="Click here to view the unbilled transactions">
                                </telerik:RadTab>
                                <telerik:RadTab runat="server" Text="Past Bills" PageViewID="PastBills" CssClass="Font_lbl"
                                    ForeColor="Black" ToolTip="Click here to view the past bills">
                                </telerik:RadTab>
                                <telerik:RadTab runat="server" Text="Diary" PageViewID="Diary"
                                    CssClass="Font_lbl" ForeColor="Black" ToolTip=" " Selected="True">
                                </telerik:RadTab>
                                 <telerik:RadTab runat="server" Text="Monthly Bill Payment" PageViewID="MBPayment"
                                    CssClass="Font_lbl" ForeColor="Black" ToolTip="">
                                </telerik:RadTab>
                            </Tabs>
                        </telerik:RadTabStrip>
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lblBillingPrd" runat="server" CssClass="Font_lbl2" Text="Billing Period :-"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label14" runat="server" CssClass="Font_lbl2" Text="From :"></asp:Label>
                                    <asp:Label ID="lblBillFrom" runat="server" CssClass="Font_lbl2" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label15" runat="server" CssClass="Font_lbl2" Text="To :"></asp:Label>
                                    <asp:Label ID="lblBillTo" runat="server" CssClass="Font_lbl2" Text=""></asp:Label>
                                    <asp:Label ID="Label3" runat="server" CssClass="Font_lbl2" Text="  ||  "></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label4" runat="server" CssClass="Font_lbl2" Text="Last Billed :-"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label6" runat="server" CssClass="Font_lbl2" Text="From :"></asp:Label>
                                    <asp:Label ID="lblLBillFrom" runat="server" CssClass="Font_lbl2" Text=""></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label10" runat="server" CssClass="Font_lbl2" Text="To :"></asp:Label>
                                    <asp:Label ID="lblLBillTo" runat="server" CssClass="Font_lbl2" Text=""></asp:Label>
                                    <asp:Label ID="Label5" runat="server" CssClass="Font_lbl2" Text="  ||  "></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label12" runat="server" CssClass="Font_lbl2" Text="Outstanding :-"></asp:Label>
                                    <%--UnBilled Amount--%>
                                </td>
                                <td>
                                    <asp:Label ID="lblUBillAmt" runat="server" CssClass="Font_lbl2" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="3" Width="1100px"
                            Height="100%" Visible="true" BorderColor="#E3E4FA" BorderStyle="Ridge" BorderWidth="1">
                            <telerik:RadPageView ID="Transactions" runat="server">
                                <div>

                                    <table oncontextmenu="return false;">
                                        <tr>
                                            <td style="width: 50%">
                                                <table>
                                                    <tr>
                                                        <td style="width: 10px"></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 890px; height: 405px; vertical-align: top; background-color: Beige;">
                                                            <table id="tblCredit" runat="server" visible="true">
                                                                <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="lblCDate" runat="server" Text="Date" CssClass="Font_lbl2"></asp:Label>
                                                                        <asp:Label ID="Label2" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadDatePicker ID="dtpCDate" runat="server" Culture="English (United Kingdom)"
                                                                            CssClass="TextBox" ReadOnly="true" ToolTip="Transaction date is system date by default and cannot be changed"
                                                                            Width="200px" Enabled="false">
                                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                CssClass="TextBox" Font-Names="Calibri">
                                                                            </Calendar>
                                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="TextBox"
                                                                                ForeColor="Black" ReadOnly="true">
                                                                            </DateInput>
                                                                        </telerik:RadDatePicker>
                                                                    </td>

                                                                </tr>
                                                                <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="lblAmountType" runat="server" Text="Type" CssClass="Font_lbl2"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlAmountType" runat="server" Width="200px" OnSelectedIndexChanged="ddlAmountType_Changed" AutoPostBack="true"
                                                                            ToolTip="Indicates if the amount is a debit or a credit or a reversal of a previous debit or a credit">
                                                                            <asp:ListItem Text="Credit" Value="1"></asp:ListItem>
                                                                            <asp:ListItem Text="Debit" Value="2"></asp:ListItem>
                                                                            <asp:ListItem Text="Credit Reversal" Value="3"></asp:ListItem>
                                                                            <asp:ListItem Text="Debit Reversal" Value="4"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="LblBCode" runat="server" Text="Billing Code" Visible="true" CssClass="Font_lbl2"></asp:Label>
                                                                        <asp:Label ID="Label1" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddllBCode" ToolTip="Indicates for what purpose the transaction is being posted.If not known or especially for credits, use the Code ‘General’." runat="server" AutoPostBack="true"
                                                                            Font-Names="Verdana" OnSelectedIndexChanged="ddlAmountType_Changed" Font-Size="Small" Width="200px">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>

                                                                <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="lblRate" runat="server" Text="Rate" CssClass="Font_lbl2" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblSRate" runat="server" Text="*" CssClass="TextBox" ForeColor="Red" Visible="false"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtRate" runat="server" CssClass="TextBox" Height="25px" Text="0" ToolTip="Picked up from the rate set against the billing code and cannot be changed here." Width="200px" Enabled="false" Visible="false"></asp:TextBox>
                                                                        <%--OnTextChanged="txtCAmount_TextChanged"--%>
                                                                    </td>
                                                                </tr>

                                                                <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="lblCount" runat="server" Text="Count" CssClass="Font_lbl2" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblSCount" runat="server" Text="*" CssClass="TextBox" ForeColor="Red" Visible="false"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtCount" runat="server" CssClass="TextBox" Height="25px" Text="0" ToolTip="Indicates the number of covers and is used only when the Rate is present." Width="200px" Visible="false" OnTextChanged="txtCount_Changed" AutoPostBack="true" onkeypress="return allowOnlyNumber(event);"></asp:TextBox>
                                                                        <%--OnTextChanged="txtCAmount_TextChanged"--%>
                                                                    </td>
                                                                </tr>


                                                                <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="lblCAmount" runat="server" Text="Amount" CssClass="Font_lbl2"></asp:Label>
                                                                        <asp:Label ID="Label8" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtCAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="The transaction amount either entered manually or calculated as Rate * Count and displayed (Cannot be edited)." Width="200px" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                                                        <%--OnTextChanged="txtCAmount_TextChanged"--%>
                                                                        <asp:Label ID="lbltamounttowords" runat="Server" Text="" ForeColor="DarkBlue" Font-Names="Calibri" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                                    </td>
                                                                </tr>

                                                                <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="lblCNarration" runat="server" Text="Narration" CssClass="Font_lbl2"></asp:Label>
                                                                        <asp:Label ID="Label78" runat="server" CssClass="TextBox" ForeColor="Red" Text="*"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtCNarration" runat="server" CssClass="TextBox" TextMode="MultiLine"
                                                                            Height="50px" Width="350px" ToolTip=" A brief description of the transaction"></asp:TextBox>
                                                                    </td>

                                                                </tr>
                                                                <tr>
                                                                    <td></td>
                                                                    <td>
                                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationExpression="((\d+)((\.\d{1,2})?))$"
                                                                            ErrorMessage="Please enter valid integer or decimal number with 2 decimal places." ForeColor="Red"
                                                                            ControlToValidate="txtCAmount" />


                                                                        <asp:TextBox ID="TxtRTRSN" runat="server" CssClass="TextBox" Visible="false" Height="25px" ToolTip="Enter the Transaction amount."></asp:TextBox>
                                                                        <%--<asp:TextBox ID="TxtRTVILLANO" runat="server" CssClass="TextBox" Visible="false" Height="25px" ToolTip="Enter the Transaction amount." Width="200px"></asp:TextBox>
                                                                        <asp:TextBox ID="TxtRTSTATUS" runat="server" CssClass="TextBox" Visible="false" Height="25px" ToolTip="Enter the Transaction amount." Width="200px"></asp:TextBox>
                                                                        <asp:TextBox ID="TxtRTName" runat="server" CssClass="TextBox" Visible="false" Height="25px" ToolTip="Enter the Transaction amount." Width="200px"></asp:TextBox>--%>

                                                                        <asp:DropDownList ID="ddlBStatus" ToolTip="Select the Billing Status." runat="server" Width="200px" Visible="false">
                                                                            <asp:ListItem Text="UnBilled" Value="UnBilled"></asp:ListItem>
                                                                            <asp:ListItem Text="Billed" Value="Billed"></asp:ListItem>
                                                                        </asp:DropDownList>

                                                                    </td>

                                                                </tr>

                                                            </table>
                                                            <table>
                                                                <tr>

                                                                    <td style="width: 150px;"></td>
                                                                    <td>
                                                                        <asp:Button ID="btnTransSave" runat="server" Text="Save" CssClass="btn btn-success" Visible="true"
                                                                            OnClick="btnTransSave_Click" OnClientClick="ConfirmMsg()" ToolTip="Click here to save the details" />
                                                                        <asp:Button ID="btnCClear" runat="server" Text="Clear" CssClass="btn btn-info" Visible="true"
                                                                            OnClick="btnCClear_Click" ToolTip="Click here to clear entered details" />
                                                                    </td>
                                                                </tr>

                                                            </table>

                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="vertical-align: top">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Label9" runat="server" Text="Post any manual transaction for the selected resident.  (Owner Resident or Owner Away or Tenant or Staff)." CssClass="Font_lbl2" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                                            <asp:Label ID="Label11" runat="server" Text="Post debits or credits if incurred by a dependent, against the main resident." CssClass="Font_lbl2" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                                            <asp:Label ID="Label13" runat="server" Text="Does not allow debits or credits for Previous tenants." CssClass="Font_lbl2" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                                            <asp:Label ID="Label16" runat="server" Text="If the particular billing code has a rate, enter the count and the Amount is automatically calculated." CssClass="Font_lbl2" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                                            <asp:Label ID="Label17" runat="server" Text="If the particular billing code does not a have a rate, enter the amount manually." CssClass="Font_lbl2" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                                            <asp:Label ID="Label18" runat="server" Text="For raising food bills to all residents, use the Group billing option to save time." CssClass="Font_lbl2" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                                            <%--<br />--%>
                                                            <%--<asp:Label ID="Label48" runat="server" Text="Debit:    Raise a demand note on the customer , to pay a certain amount." CssClass="Font_lbl2" ForeColor="Blue"></asp:Label><br />--%>
                                                            <asp:Label ID="Label49" runat="server" Text="Debit Reversal:   To  reverse any WRONG DEBITS posted.  Takes care of any clerical error but will be reflected in the Statement of Account." CssClass="Font_lbl2" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                                            <%--<asp:Label ID="Label50" runat="server" Text="Credit :  To record the payments received from the customer." CssClass="Font_lbl2" ForeColor="Blue"></asp:Label><br />--%>
                                                            <asp:Label ID="Label51" runat="server" Text="Credit Reversal:    To reverse any WRONG CREDIT. Takes care of any clerical error but will be reflected in the Statement of Account." CssClass="Font_lbl2" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Panel runat="server" Width="550px" Height="170px" ScrollBars="Auto">
                                                                <telerik:RadGrid ID="rdgLFTrans" runat="server" AllowPaging="False" PageSize="100"
                                                                    AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="True" AllowFilteringByColumn="false"                                                                    
                                                                    CellSpacing="5" Width="100%" Visible="true"
                                                                    MasterTableView-HierarchyDefaultExpanded="true">
                                                                    <HeaderContextMenu CssClass="table table-bordered table-hover">
                                                                    </HeaderContextMenu>
                                                                    <PagerStyle AlwaysVisible="true" Mode="NextPrevAndNumeric" />
                                                                    <MasterTableView AllowCustomPaging="false">
                                                                        <NoRecordsTemplate>
                                                                            No Records Found.
                                                                        </NoRecordsTemplate>
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn>
                                                                            <HeaderStyle Width="5px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn>
                                                                            <HeaderStyle Width="5px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn HeaderText="Date" DataField="Date" HeaderStyle-Wrap="false" Visible="true"
                                                                                ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ItemStyle-Width="100px"
                                                                                ItemStyle-CssClass="Row1">
                                                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                                                <ItemStyle Wrap="False"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Item Code" DataField="ItemCode" HeaderStyle-Wrap="false"
                                                                                ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="50px"
                                                                                ItemStyle-CssClass="Row1">
                                                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                                                <ItemStyle Wrap="False"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Dr/Cr" DataField="DrCr" HeaderStyle-Wrap="false" ItemStyle-Width="75px"
                                                                                ItemStyle-Wrap="false" AllowFiltering="false"  ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" Visible="true"
                                                                                ItemStyle-CssClass="Row1">
                                                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                                                <ItemStyle Wrap="False"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Amount" DataField="Amount" HeaderStyle-Wrap="false" Visible="true"
                                                                                ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" ItemStyle-Width="75px"
                                                                                ItemStyle-CssClass="Row1">
                                                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                                                <ItemStyle Wrap="False"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Rate" DataField="Rate" HeaderStyle-Wrap="false" ItemStyle-Width="50px"
                                                                                ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                                                ItemStyle-CssClass="Row1">
                                                                                <HeaderStyle Wrap="False"></HeaderStyle>
                                                                                <ItemStyle Wrap="False"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn HeaderText="Count" DataField="Count" HeaderStyle-Wrap="false" ItemStyle-Width="20px"
                                                                                ItemStyle-Wrap="false" AllowFiltering="false" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
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
                                                            </asp:Panel>

                                                        </td>

                                                    </tr>
                                                </table>

                                            </td>
                                        </tr>


                                    </table>
                                </div>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="BTxns" runat="server">
                                <table oncontextmenu="return false;">
                                    <tr>
                                        <td style="width: 10px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10px"></td>
                                        <td colspan="2" style="width: 1100px; height: 405px; vertical-align: top; background-color: Beige;">
                                            <table width="1050px" style="font-family: Calibri;">
                                                <tr>
                                                    <td width="1050px" colspan="4">
                                                        <asp:Panel runat="server" Width="1050px" Height="300px" ScrollBars="Auto">
                                                            <telerik:RadGrid ID="rdgBilledTrans" runat="server" AutoGenerateColumns="False" Visible="true"
                                                                CssClass="table table-bordered table-hover" AllowCustomPaging="false" AllowSorting="True"
                                                                Height="280px" AllowFilteringByColumn="false" AllowPaging="true" Skin="WebBlue">
                                                                <%--OnItemDataBound="rdgListView_ItemDataBound"--%>
                                                                <%--OnPageIndexChanged="rdgListView_PageIndexChanged" 
                                                                    OnPageSizeChanged="rdgListView_PageSizeChanged" OnSortCommand="rdgListView_SortCommand"--%>
                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                </HeaderContextMenu>
                                                                <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                <ClientSettings>
                                                                    <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                        ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AllowCustomPaging="false">
                                                                    <NoRecordsTemplate>
                                                                        No Records Found.
                                                                    </NoRecordsTemplate>
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                    <RowIndicatorColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn HeaderText="Date" DataField="TXDATE" HeaderStyle-Width="80px"
                                                                            ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center" Width="80px"></HeaderStyle>
                                                                            <ItemStyle Width="80px" HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Code" DataField="Code" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="left">
                                                                            <HeaderStyle Wrap="False" Width="80px" HorizontalAlign="left"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="80px" HorizontalAlign="left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Narration" DataField="Narration" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="200px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="left">
                                                                            <HeaderStyle Wrap="False" Width="200px" HorizontalAlign="left"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="200px" HorizontalAlign="left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="TxnType" DataField="TransType" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle Wrap="False" Width="80px" HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="80px" HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Rate" DataField="Rate" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Right">
                                                                            <HeaderStyle Wrap="False" Width="80px" HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="80px" HorizontalAlign="Right"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Count" DataField="Count" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle Wrap="False" Width="80px" HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="80px" HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Debit" DataField="TXAMOUNTDR" ItemStyle-Wrap="false"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" AllowFiltering="false">
                                                                            <HeaderStyle HorizontalAlign="Right" Wrap="False" Width="80px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" Width="80px" HorizontalAlign="Right"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Credit" DataField="TXAMOUNTCR" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" AllowFiltering="false"
                                                                            ItemStyle-Wrap="false" HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="85px">
                                                                            <HeaderStyle HorizontalAlign="Right" Wrap="False" Width="80px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" Width="80px" HorizontalAlign="Right"></ItemStyle>
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
                                                        </asp:Panel>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnExpBT" runat="server" Text="Export to excel" CssClass="btn btn-success"
                                                            Visible="true" OnClick="btnExpBT_Click" ToolTip="Click here to export billed transaction" />
                                                        <%--&nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label64" runat="server" Text="Total Debits:" CssClass="Font_lbl2"></asp:Label>
                                                        <asp:Label ID="lblDebit" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                        &nbsp;&nbsp;
                                                                    <asp:Label ID="Label66" runat="server" Text="Total Credits:" CssClass="Font_lbl2"></asp:Label>
                                                        <asp:Label ID="lblCredit" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label62" runat="server" Text="Outstanding:" CssClass="Font_lbl2"></asp:Label>
                                                        <asp:Label ID="lblTotal" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>--%>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td></td>

                                                </tr>

                                            </table>
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="UBTxns" runat="server">
                                <table oncontextmenu="return false;">
                                    <tr>
                                        <td style="width: 10px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10px"></td>
                                        <td colspan="2" style="width: 1100px; height: 405px; vertical-align: top; background-color: Beige;">
                                            <table width="1050px" style="font-family: Calibri;">
                                                <tr>
                                                    <td width="1050px" colspan="4">
                                                        <asp:Panel runat="server" Width="1050px" Height="300px" ScrollBars="Auto">
                                                            <telerik:RadGrid ID="rdgStatOfAcc" runat="server" AutoGenerateColumns="False" Visible="true"
                                                                CssClass="table table-bordered table-hover" AllowCustomPaging="false" AllowSorting="True"
                                                                Height="280px" AllowFilteringByColumn="false" AllowPaging="true" Skin="WebBlue">
                                                                <%--OnItemDataBound="rdgListView_ItemDataBound"--%>
                                                                <%--OnPageIndexChanged="rdgListView_PageIndexChanged" 
                                                                    OnPageSizeChanged="rdgListView_PageSizeChanged" OnSortCommand="rdgListView_SortCommand"--%>
                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                </HeaderContextMenu>
                                                                <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                <ClientSettings>
                                                                    <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                        ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AllowCustomPaging="false">
                                                                    <NoRecordsTemplate>
                                                                        No Records Found.
                                                                    </NoRecordsTemplate>
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                    <RowIndicatorColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn HeaderText="Date" DataField="TXDATE" HeaderStyle-Width="80px"
                                                                            ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center" Width="80px"></HeaderStyle>
                                                                            <ItemStyle Width="80px" HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Code" DataField="Code" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="left">
                                                                            <HeaderStyle Wrap="False" Width="80px" HorizontalAlign="left"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="80px" HorizontalAlign="left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Narration" DataField="Narration" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="200px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="left">
                                                                            <HeaderStyle Wrap="False" Width="200px" HorizontalAlign="left"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="200px" HorizontalAlign="left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="TxnType" DataField="TransType" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle Wrap="False" Width="80px" HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="80px" HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Rate" DataField="Rate" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Right">
                                                                            <HeaderStyle Wrap="False" Width="80px" HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="80px" HorizontalAlign="Right"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Count" DataField="Count" ItemStyle-Wrap="true"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle Wrap="False" Width="80px" HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="80px" HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Debit" DataField="TXAMOUNTDR" ItemStyle-Wrap="false"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" AllowFiltering="false">
                                                                            <HeaderStyle HorizontalAlign="Right" Wrap="False" Width="80px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" Width="80px" HorizontalAlign="Right"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Credit" DataField="TXAMOUNTCR" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" AllowFiltering="false"
                                                                            ItemStyle-Wrap="false" HeaderStyle-Wrap="false" HeaderStyle-Width="80px" ItemStyle-Width="85px">
                                                                            <HeaderStyle HorizontalAlign="Right" Wrap="False" Width="80px"></HeaderStyle>
                                                                            <ItemStyle Wrap="False" Width="80px" HorizontalAlign="Right"></ItemStyle>
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
                                                        </asp:Panel>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnExpUBT" runat="server" Text="Export to excel" CssClass="btn btn-success"
                                                            Visible="true" OnClick="btnExpUBT_Click" ToolTip="Click here to export unbilled transaction" />
                                                        <%--&nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label64" runat="server" Text="Total Debits:" CssClass="Font_lbl2"></asp:Label>
                                                        <asp:Label ID="lblDebit" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                        &nbsp;&nbsp;
                                                                    <asp:Label ID="Label66" runat="server" Text="Total Credits:" CssClass="Font_lbl2"></asp:Label>
                                                        <asp:Label ID="lblCredit" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label62" runat="server" Text="Outstanding:" CssClass="Font_lbl2"></asp:Label>
                                                        <asp:Label ID="lblTotal" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>--%>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td></td>

                                                </tr>

                                            </table>
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="Diary" runat="server" ForeColor="Black" Height="420px" Selected="true"
                                Width="1200px" Visible="true">
                                <div style="float: left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:GridView ID="gvMoreinfo" runat="server" AllowPaging="true" PageSize="10" Visible="true"
                                                    Font-Names="Calibri" Font-Size="Smaller" ForeColor="Black" BorderColor="#5B74A8" CssClass="gridview_borders" AllowSorting="true"
                                                    AutoGenerateColumns="false" DataKeyNames="RSN" OnRowCommand="gvMoreinfo_RowCommand" OnPageIndexChanging="gvMoreinfo_PageIndexChanging1" OnSorting="gvMoreinfo_Sorting">
                                                    <Columns>

                                                        <asp:TemplateField HeaderText="RTRSN" HeaderStyle-BackColor="#5B74A8" Visible="false" SortExpression="CreatedOn" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White">
                                                            <ItemStyle BorderColor="#5B74A8" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRTRSN" runat="server" Text='<%# Eval("RTRSN") %>' Width="80px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Villa No." HeaderStyle-BackColor="#5B74A8" Visible="false" SortExpression="CreatedBy" HeaderStyle-ForeColor="White">
                                                            <ItemStyle BorderColor="#5B74A8" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRTVILLANO" runat="server" Text='<%# Eval("RTVILLANO") %>' Width="100px"></asp:Label>
                                                            </ItemTemplate>

                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Status" HeaderStyle-BackColor="#5B74A8" Visible="false" SortExpression="RTSTATUS" HeaderStyle-ForeColor="White">
                                                            <ItemStyle BorderColor="#5B74A8" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRTSTATUS" runat="server" Text='<%# Eval("RTSTATUS") %>' Width="100px"></asp:Label>
                                                            </ItemTemplate>

                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Name" HeaderStyle-BackColor="#5B74A8" Visible="false" SortExpression="Name" HeaderStyle-ForeColor="White">
                                                            <ItemStyle BorderColor="#5B74A8" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRTName" runat="server" Text='<%# Eval("RTName") %>' Width="100px"></asp:Label>
                                                            </ItemTemplate>

                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Action" HeaderStyle-BackColor="#5B74A8" SortExpression="MoreinfoText" HeaderStyle-ForeColor="White">
                                                            <ItemStyle BorderColor="#5B74A8" Wrap="true" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbltext" runat="server" Text='<%# Eval("MoreInfoText") %>' Width="220px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Response" HeaderStyle-BackColor="#5B74A8" SortExpression="Response" HeaderStyle-ForeColor="White">
                                                            <ItemStyle BorderColor="#5B74A8" Wrap="true" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblresponse" runat="server" Text='<%# Eval("Response") %>' Width="220px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Value" HeaderStyle-BackColor="#5B74A8" SortExpression="MoreInfoValue" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White">
                                                            <ItemStyle BorderColor="#5B74A8" HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblvalue" runat="server" Text='<%# Eval("MoreInfoValue") %>' Width="100px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="Type" HeaderStyle-BackColor="#5B74A8" SortExpression="MoreInfoGroup" HeaderStyle-ForeColor="White">
                                                            <ItemStyle BorderColor="#5B74A8" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbltype" runat="server" Text='<%# Eval("MoreInfoGroup") %>' Width="50px"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <%-- <asp:TemplateField HeaderText="M-By" HeaderStyle-BackColor="#5B74A8" SortExpression="ModifiedBy" HeaderStyle-ForeColor="White" Visible="false">
                                                                        <ItemStyle BorderColor="#5B74A8" />
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblmodifiedby" runat="server" Text='<%# Eval("ModifiedBy") %>' Width="100px"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>

                                                                    <asp:TemplateField HeaderText="On" HeaderStyle-BackColor="#5B74A8" SortExpression="ModifiedOn" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White" Visible="false">
                                                                        <ItemStyle BorderColor="#5B74A8" HorizontalAlign="Center" />
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblmodifiedon" runat="server" Text='<%# Eval("ModifiedOn") %>' Width="80px"></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>--%>



                                                        <asp:TemplateField HeaderText="Edit" HeaderStyle-ForeColor="White" HeaderStyle-BackColor="#5B74A8">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkEdit" runat="server" Width="20px" Font-Names="Calibri" CommandName="MoreInfoEdit" CommandArgument='<%#((GridViewRow)Container).RowIndex%>'>Edit</asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>

                                            </td>
                                        </tr>
                                    </table>

                                </div>

                                <asp:HiddenField ID="CnfResult" runat="server" />

                                <div style="float: left">
                                    <table>
                                        <tr>
                                            <td>

                                                <br />
                                                <asp:ImageButton ID="imgbtnAddWorkDetails" runat="server" ToolTip="Click here to add a new diary entry." ImageUrl="~/Images/Add icon.png" OnClick="imgbtnAddWorkDetails_Click2" />
                                            </td>
                                            <td>
                                                <telerik:RadWindow ID="rwMoreInfo" VisibleOnPageLoad="false" Width="450px" Height="450px" runat="server">
                                                    <%--OpenerElementID="<%# imgbtnAddWorkDetails.RSN  %>"--%>
                                                    <ContentTemplate>
                                                        <asp:UpdatePanel ID="upmoreinfo" runat="server" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <div>

                                                                    <table>
                                                                        <tr>
                                                                            <td colspan="2" style="text-align: center;">
                                                                                <asp:Label ID="Label41" runat="Server" Text="Diary(Manual Entry)" ForeColor="DarkOliveGreen" Font-Bold="true" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                                                <br />
                                                                            </td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblctext" runat="Server" Text="Action:" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txttext" runat="Server" MaxLength="240" ToolTip="Enter the action taken (response) to the diary entry. " ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline" Width="310px" Height="50px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblcvalue" runat="Server" Text="Value:" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtvalue" runat="Server" MaxLength="13" ToolTip="Does the entry have a value attached (Ex:  Expenses Incurred)? If so mention it here." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Width="310px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblcdescription" runat="Server" Text="Response:" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtdescription" runat="Server" MaxLength="240" ToolTip=" What is this entry all about.  Either Auto Inserted or Manually entered." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline" Width="310px" Height="50px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>




                                                                        <tr>
                                                                            <td colspan="2" style="text-align: center">
                                                                                <asp:Button ID="btnMISave" runat="Server" Width="100px" Text="Save" OnClientClick="javascript:return Validate()" ToolTip="Press to Save the Information to the Work Details grid for the customer." CssClass="btnAdminSave" OnClick="btnMISave_Click" />
                                                                                <asp:Button ID="btnMIUpdate" runat="Server" Width="100px" Text="Update" OnClientClick="javascript:return Validate()" ToolTip="Press to Update the Information to the Work Details grid for the customer." CssClass="btnAdminSave" OnClick="btnMIUpdate_Click" />
                                                                                <asp:Button ID="btnMIClear" runat="Server" Width="100px" Text="Clear" ToolTip="Press Clear if you want to start all over again." CssClass="btnAdminClear" OnClick="btnMIClear_Click" />
                                                                                <asp:Button ID="btnMIExit" runat="Server" Width="100px" Text="Exit" ToolTip=" Press Exit to return to the BizPanel" CssClass="btnAdminExit" OnClick="btnMIExit_Click" />
                                                                            </td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td colspan="2" style="text-align: center">
                                                                                <asp:Label ID="Label43" runat="Server" Text="A diary entry can be automatic from the system (Ex: Milestones Update).  But here, you can also record a diary notes manually. A Manual entry is indicated as MNUL.You can only edit the Response field and only for a manual entry." ForeColor="Gray" Font-Names="Calibri" Font-Size="Smaller" Font-Bold="true"></asp:Label>
                                                                            </td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td colspan="2"></td>
                                                                        </tr>
                                                                    </table>


                                                                </div>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <asp:PostBackTrigger ControlID="btnMISave" />
                                                                <asp:PostBackTrigger ControlID="btnMIUpdate" />
                                                                <asp:PostBackTrigger ControlID="btnMIClear" />
                                                                <asp:PostBackTrigger ControlID="btnMIExit" />

                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </ContentTemplate>
                                                </telerik:RadWindow>
                                            </td>
                                        </tr>
                                    </table>

                                </div>
                                <div style="float: left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label63" runat="Server" Text="Many interactions may occur with reference to each Resident. " ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Smaller"></asp:Label><br />
                                                <asp:Label ID="Label65" runat="Server" Text="The diary is the place where all such interactions are recorded. " ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Smaller"></asp:Label><br />
                                                <asp:Label ID="Label70" runat="Server" Text="The diary can be referred at any point of time to ensure nothing is missed out in terms of service. However for this, you must have the diary kept updated always!" ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Smaller"></asp:Label><br />
                                                <asp:Label ID="Label67" runat="Server" Text="AUTO means a system generated diary entry.   MNUL  means a manually made entry." ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Smaller"></asp:Label><br />
                                                <asp:Label ID="Label68" runat="Server" Text="A Manual entry can also be edited to include the response." ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Smaller"></asp:Label><br />
                                                <asp:Label ID="Label69" runat="Server" Text="If there is a certain monetary value attached , enter the amount in the Value column." ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="MBPayment" runat="server">
                                <div>

                                    <table oncontextmenu="return false;">
                                        <tr>
                                            <td style="width: 50%">
                                                <table>
                                                    <tr>
                                                        <td style="width: 10px"></td>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 10px"></td>
                                                        <td style="width: 890px; height: 405px; vertical-align: top; background-color: Beige;">
                                                            <table id="Table1" runat="server" visible="true">
                                                                <tr>                                                                  
                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="Label19" runat="server" Text="Payment For" Visible="true" CssClass="Font_lbl2"></asp:Label>
                                                                        <%--<asp:Label ID="Label20" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>--%>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlBillingPeriod" ToolTip="Previous billing period" runat="server" AutoPostBack="true"
                                                                            Font-Names="Verdana" Font-Size="Small" Width="200px" Enabled="false" >
                                                                        </asp:DropDownList>
                                                                    </td>     
                                                                </tr>
                                                                 <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="Label33" runat="server" Text="Amount Billed" CssClass="Font_lbl2" Visible="true"></asp:Label>
                                                                       
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtAmtBilled" runat="server" CssClass="TextBox" Height="25px" ToolTip="Amount billed for the previous billing period" Width="200px" Enabled="false" Visible="true"></asp:TextBox>
                                                                       
                                                                    </td>
                                                                </tr>
                                                                 <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="Label35" runat="server" Text="Amount Received" CssClass="Font_lbl2" Visible="true"></asp:Label>
                                                                       
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtAmtReceived" runat="server" CssClass="TextBox" Height="25px"  ToolTip="Amount received for the previous billing period" Width="200px" Enabled="false" Visible="true"></asp:TextBox>
                                                                      
                                                                    </td>
                                                                </tr>
                                                                 <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="Label37" runat="server" Text="Amount Due" CssClass="Font_lbl2" Visible="true"></asp:Label>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtAmtDue" runat="server" CssClass="TextBox" Height="25px"  ToolTip="Amount Due for the previous billing period" Width="200px" Enabled="false" Visible="true"></asp:TextBox>
                                                                        
                                                                    </td>
                                                                </tr>
                                                                 <tr>

                                                                    <td style="width: 150px;">
                                                                        <asp:Label ID="Label39" runat="server" Text="Amount Received Now" CssClass="Font_lbl2" Visible="true"></asp:Label>
                                                                      
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtAmtReceivedNow" runat="server" CssClass="TextBox" Height="25px"  ToolTip="Amount received now for the previous billing period" Width="200px" Enabled="true" Visible="true"></asp:TextBox>
                                                                        
                                                                    </td>
                                                                </tr>
                                                                

                                                            </table>
                                                            <table>
                                                                <tr>

                                                                    <td style="width: 150px;"></td>
                                                                    <td>
                                                                        <asp:Button ID="btnPMBSave" runat="server" Text="Save" CssClass="btn btn-success" Visible="true"
                                                                            OnClick="btnPMBSave_Click" OnClientClick="javascript:return ValidateAmt()" ToolTip="Click here to save the details" />
                                                                        <asp:Button ID="btnPMBClear" runat="server" Text="Clear" CssClass="btn btn-info" Visible="true"
                                                                            OnClick="btnPMBClear_Click" ToolTip="Click here to clear entered details" />
                                                                    </td>
                                                                </tr>

                                                            </table>

                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            
                                        </tr>


                                    </table>
                                </div>
                            </telerik:RadPageView>


                            <telerik:RadPageView ID="PastBills" runat="server">
                                <table oncontextmenu="return false;">
                                    <tr>
                                        <td style="width: 10px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 10px"></td>
                                        <td colspan="2" style="width: 1100px; height: 405px; vertical-align: top; background-color: Beige;">
                                            <table width="1000px" style="font-family: Calibri;">
                                                <tr>
                                                    <td width="1000px" colspan="4">
                                                        <asp:Panel runat="server" Width="800px" Height="300px" ScrollBars="Auto">
                                                            <telerik:RadGrid ID="rdgPastBills" runat="server" AutoGenerateColumns="False" Visible="true"
                                                                CssClass="table table-bordered table-hover" AllowCustomPaging="false" AllowSorting="True"
                                                                Height="280px" AllowFilteringByColumn="false" AllowPaging="true" Skin="WebBlue">
                                                                <%--OnItemDataBound="rdgListView_ItemDataBound"--%>
                                                                <%--OnPageIndexChanged="rdgListView_PageIndexChanged" 
                                                                    OnPageSizeChanged="rdgListView_PageSizeChanged" OnSortCommand="rdgListView_SortCommand"--%>
                                                                <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                </HeaderContextMenu>
                                                                <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                <ClientSettings>
                                                                    <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                        ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                    <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                                </ClientSettings>
                                                                <MasterTableView AllowCustomPaging="false">
                                                                    <NoRecordsTemplate>
                                                                        No Records Found.
                                                                    </NoRecordsTemplate>
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                    <RowIndicatorColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn>
                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn HeaderText="TXDRCR" DataField="TXDRCR" Visible="false">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="From" DataField="BPFrom" HeaderStyle-Width="120px" HeaderTooltip="Billing Period Start Date"
                                                                            ItemStyle-Width="120px" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center" Width="120px"></HeaderStyle>
                                                                            <ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="To" DataField="BPTo" ItemStyle-Wrap="true" HeaderTooltip="Billing Period End Date"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="200px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle Wrap="False" Width="200px" HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="200px" HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderText="Billed Amount" DataField="BPAmount" ItemStyle-Wrap="true" HeaderTooltip="Billed Amount"
                                                                            HeaderStyle-Wrap="false" HeaderStyle-Width="200px" ItemStyle-Width="200px" HeaderStyle-HorizontalAlign="Right">
                                                                            <HeaderStyle Wrap="False" Width="200px" HorizontalAlign="Right"></HeaderStyle>
                                                                            <ItemStyle Wrap="True" Width="200px" HorizontalAlign="Right"></ItemStyle>
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
                                                        </asp:Panel>
                                                    </td>
                                                </tr>

                                                <%-- <tr>
                                                    <td>
                                                        <asp:Button ID="Button1" runat="server" Text="Export to excel" CssClass="btn btn-success"
                                                            Visible="true" OnClick="btnExpProject_Click" ToolTip="Click here to export statement of account" />
                                                        &nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label19" runat="server" Text="Total Debits:" CssClass="Font_lbl2"></asp:Label>
                                                        <asp:Label ID="Label20" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                        &nbsp;&nbsp;
                                                                    <asp:Label ID="Label22" runat="server" Text="Total Credits:" CssClass="Font_lbl2"></asp:Label>
                                                        <asp:Label ID="Label23" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                        &nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label24" runat="server" Text="Outstanding:" CssClass="Font_lbl2"></asp:Label>
                                                        <asp:Label ID="Label25" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                    </td>
                                                </tr>--%>
                                            </table>
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </telerik:RadPageView>
                            <telerik:RadPageView ID="Registration" runat="server" ForeColor="Black" Height="420px"
                                Width="1200px" Visible="true">

                                <table>
                                    <tr>
                                        <td style="width: 150px;">
                                            <asp:Label ID="Label77" runat="server" Text="Transaction Type:" CssClass="Font_lbl2"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTransType" runat="server" CssClass="TextBox" Height="25px" ToolTip=""></asp:TextBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px;">
                                            <asp:Label ID="Label60" runat="server" Text="Registration Amount:" CssClass="Font_lbl2"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRegistrationAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="Enter the Registration amount." OnTextChanged="txtRegistrationAmount_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            <asp:Label ID="lblamountseperation" runat="server" Text="" CssClass="Font_lbl2" ToolTip="This is the approximate registration amount calculated when the flat is booked."></asp:Label>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationExpression="((\d+)((\.\d{1,2})?))$"
                                                ErrorMessage="Please enter valid integer or decimal number with 2 decimal places."
                                                ControlToValidate="txtCAmount" />
                                            <br />
                                            <asp:Label ID="lblramountinwords" runat="Server" Text="" ForeColor="DarkBlue" Font-Names="Calibri" Font-Bold="true" Font-Size="Small"></asp:Label>
                                        </td>


                                    </tr>
                                    <tr>
                                        <td style="width: 150px;">
                                            <asp:Label ID="Label57" runat="server" Text="Date:" CssClass="Font_lbl2"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="dtpRegistrationdate" runat="server" Culture="English (United Kingdom)"
                                                Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Enter the Registration date">
                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                    CssClass="TextBox" Font-Names="Calibri">
                                                </Calendar>
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="TextBox"
                                                    ForeColor="#00008B" ReadOnly="true">
                                                </DateInput>
                                            </telerik:RadDatePicker>
                                        </td>

                                    </tr>


                                    <tr>

                                        <td style="width: 150px;">
                                            <asp:Label ID="Label61" runat="server" Text="Remarks:" CssClass="Font_lbl2"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRegistrationRemarks" runat="server" CssClass="TextBox" TextMode="MultiLine"
                                                Height="70px" Width="350px" ToolTip="Enter any narration."></asp:TextBox>
                                            <%--<asp:DropDownList ID="ddlCNarration" Width="350px" Height="20px" runat="server" AutoPostBack="true"
                                                                CssClass="TextBox">
                                                            </asp:DropDownList>
                                                            <asp:DropDownList ID="ddlSNarration" Width="350px" Height="20px" runat="server" AutoPostBack="true"
                                                                CssClass="TextBox">
                                                            </asp:DropDownList>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <asp:Button ID="btnRegistrationSave" runat="server" Text="Save" CssClass="btn btn-success" Visible="true"
                                                OnClientClick="StageConfirmMsg1()" ToolTip="Clik here to update the Registration date in the milestones." OnClick="btnRegistrationSave_Click" />
                                            <asp:Button ID="btnRegistrationClear" runat="server" Text="Clear" CssClass="btn btn-info" Visible="true"
                                                ToolTip="Clik here to clear entered details" OnClick="btnRegistrationClear_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="Label7" runat="server" Text="This screen is for updating the date of registration of the property in the milestones.(Milestone code is 0001 always)." CssClass="Font_lbl2"></asp:Label><br />
                                            <asp:Label ID="Label21" runat="server" Text=" The Amount spent for the registration is avaliable in the milestone record." CssClass="Font_lbl2"></asp:Label>

                                        </td>
                                    </tr>
                                </table>

                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </td>
                </tr>
            </table>







        </div>
    </div>
</asp:Content>

