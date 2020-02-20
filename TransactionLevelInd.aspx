<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="TransactionLevelInd.aspx.cs" Inherits="TransactionLevelInd" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <%--<link href="CSS/MenuCSS.css" rel="stylesheet" />--%>

    <script type="text/javascript">
        function NavigatePopup1() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (450 + 50);
            iMyHeight = (window.screen.height / 2) - (250 + 50);
            var Y = 'PrintReceipt.aspx?ReceiptRSN=' + '<%=Convert.ToString(Session["ReceiptRSN"])%>';
            var win = window.open(Y, "Receipt", "status=no,height=600,width=1000,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");
            win.focus();


        }
    </script>


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

        function TallyLink() {
            alert('This tally link is activated internally, Financial transactions posted in ORIS are automatically updated in Tally also.  This link will work in a live ORIS Installation.')
        }

        function TransConfirmMsg() {

            var result = confirm('You have posted a Payment against last billing done. Confirm?');

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
            if (Name == "") {
                return "Please enter action" + "\n";
            }
            else {
                return "";
            }
        }

        function Email() {
            var Name = document.getElementById('<%=txtvalue.ClientID%>').value;
            if (Name == "") {
                return "Please enter value" + "\n";
            }
            else {
                return "";
            }
        }

    </script>

    <script type="text/javascript">
        function ValidateAmt() {
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

    <script type="text/javascript">
        function confirmCallbackFn(arg) {
            if (arg) //the user clicked OK
            {
                __doPostBack("<%=HiddenButton.UniqueID %>", "");
            }
        }
    </script>


    <style type="text/css">
        .preference .rwWindowContent {
            background-color: yellow !important;
        }

        .availability .rwWindowContent {
            background-color: yellow !important;
        }
    </style>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <asp:Button ID="Button1" runat="server" Text="Help?" CssClass="Button" OnClick="btnHelp_Click" Visible="false" ToolTip="" />
                    <asp:Button ID="btnHelp" runat="server" Text="Help?" CssClass="Button" OnClick="btnHelp_Click" Visible="false" ToolTip="" />



                    <telerik:RadWindowManager runat="server" EnableShadow="true" ID="RadWindowManager1" Localization-OK="Yes" Localization-Cancel="No">
                    </telerik:RadWindowManager>

                    <asp:Button ID="HiddenButton" Text="" Style="display: none;" OnClick="HiddenButton_Click" runat="server" />

                    <table>
                        <tr>
                            <td>
                                <telerik:RadWindow ID="rwHelp" Width="500" Height="150" VisibleOnPageLoad="false"
                                    runat="server" OpenerElementID="<%# btnHelp.ClientID  %>" Title="Help" Modal="true" CssClass="availability">
                                    <ContentTemplate>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lbldescription" runat="server" Text="" CssClass="TextBox" ForeColor="DarkBlue" Font-Names="verdana" Font-Size="Small" Font-Bold="true"></asp:Label><br />
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </telerik:RadWindow>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadWindow ID="rwSaveTime" VisibleOnPageLoad="false" Width="350px" Height="350px" runat="server" ToolTip="Save time by selecting from a list of predefined entries." OpenerElementID="<%# btnSaveTime.ClientID  %>">
                                    <ContentTemplate>
                                        <table cellpadding="3">
                                            <tr>
                                                <td align="center">
                                                    <asp:Label ID="lblInfo" runat="server" Text="Add to PickList to SaveTime" ForeColor="Green" Font-Bold="true" Width="160px" CssClass="style2" Font-Names="Calibri" Font-Size="X-Small"></asp:Label>

                                                </td>
                                            </tr>
                                            <tr>

                                                <td align="center">
                                                    <asp:TextBox ID="txtInfo" runat="server" Width="200px" MaxLength="80"></asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td align="center">
                                                    <asp:Button ID="btnSTSave" runat="server" Text="Save" CssClass="Button" OnClick="btnSTSave_Click"
                                                        ToolTip="Write a sentence to be added to the PickList and click Save." />
                                                    <asp:Button ID="btnSTClear" runat="server" Text="Clear" CssClass="Button" OnClick="btnSTClear_Click" ToolTip="Click to Clear what you have written above." />
                                                    <asp:Button ID="btnSTClose" runat="server" Text="Close" CssClass="Button" OnClick="btnSTClose_Click" ToolTip="Clickto return back to previous page." />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" align="center">

                                                    <%--  <asp:GridView ID="gvSaveTime" runat="server" AutoGenerateColumns="false" OnRowCommand="gvSaveTime_RowCommand" CssClass="gridview_borders">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="PickList" DataField="Savetimeentry" ReadOnly="true" HeaderStyle-BackColor="DarkBlue"
                                                                HeaderStyle-ForeColor="White" ItemStyle-Font-Size="Small" ItemStyle-Font-Names="Calibri"
                                                                ItemStyle-Width="200px" ItemStyle-ForeColor="Black" HeaderStyle-HorizontalAlign="left" />
                                                        </Columns>
                                                    </asp:GridView>--%>


                                                    <telerik:RadGrid ID="gvSaveTime" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="165px" Width="100%" AllowPaging="false">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                        </ClientSettings>
                                                        <MasterTableView>
                                                            <Columns>
                                                                <telerik:GridBoundColumn HeaderText="PickList" HeaderStyle-Width="200px" DataField="Savetimeentry" ReadOnly="true" Display="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Unique Txn Ref.No"></telerik:GridBoundColumn>

                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </telerik:RadWindow>

                            </td>
                        </tr>
                    </table>

                    <table>
                        <tr>
                            <td>
                                <div style="width: 100%">
                                    <table style="width: 100%">
                                        <tr>
                                            <td align="center">
                                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>

                                    <table oncontextmenu="return false;">
                                        <tr>
                                            <td style="width: 50%">
                                                <table>

                                                    <tr>

                                                        <td style="width: 890px; height: 405px; vertical-align: top; background-color: Beige;">
                                                            <table id="tblCredit" visible="true">

                                                                <tr>
                                                                    <td>

                                                                        <table>

                                                                            <tr>
                                                                                <td colspan="3">
                                                                                    <asp:RadioButtonList ID="rdoLedger" runat="server" RepeatDirection="Horizontal"
                                                                                        OnSelectedIndexChanged="rdoLedger_SelectedIndexChanged" AutoPostBack="true" Width="250px">
                                                                                        <asp:ListItem Text="Resident" Value="1"></asp:ListItem>
                                                                                        <%--<asp:ListItem Text="Guest House" Value="2"></asp:ListItem>--%>
                                                                                         <asp:ListItem Text="General" Value="3"></asp:ListItem>
                                                                                    </asp:RadioButtonList>
                                                                                </td>
                                                                            </tr>

                                                                            <tr>


                                                                                <td colspan="3">

                                                                                    <asp:Label ID="Label59" runat="server" Text="For which Resident Account?Search by" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label><br />
                                                                                    <%--<telerik:RadAutoCompleteBox ID="DdlUhid" Font-Names="verdana" Width="350px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource1" runat="server" DataTextField="Customer" DataValueField="RTRSN" InputType="Text" MinFilterLength="1"
                                                                                        EmptyMessage="Choose ResidentID / DoorNo / Name " ToolTip="Choose the ResidentID / DoorNo / Name to view the customer details" AutoPostBack="true" TextSettings-SelectionMode="Single" on>
                                                                                        <TextSettings SelectionMode="Single" />
                                                                                    </telerik:RadAutoCompleteBox>
                                                                                    <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select convert(nvarchar(10),RTRSN) +', '+ RTVILLANO +', '+ RTName + ', ' + convert(nvarchar(10),RTRSN) as Customer,RTRSN from tblresident where rtstatus in ('OR','T','RS','OA','TS') order by RTName asc"></asp:SqlDataSource>--%>

                                                                                    <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                                                                        Width="350px" ToolTip=""
                                                                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged">
                                                                                    </telerik:RadComboBox>

                                                                                    <telerik:RadComboBox ID="cmbGeneral" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                                                                        Width="350px" ToolTip=""
                                                                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type General Ledger Name to search" OnSelectedIndexChanged="cmbGeneral_SelectedIndexChanged">
                                                                                    </telerik:RadComboBox>


                                                                                    
                                                                                    <telerik:RadComboBox ID="cmbGGenearl" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                                                                        Width="350px" ToolTip=""
                                                                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type General Ledger Name to search" OnSelectedIndexChanged="cmbGGenearl_SelectedIndexChanged">
                                                                                    </telerik:RadComboBox>


                                                                                </td>
                                                                            </tr>

                                                                            <tr>

                                                                                <td style="width: 150px;">
                                                                                    <asp:Label ID="lblCDate" runat="server" Text="Date" CssClass="Font_lbl2"></asp:Label>
                                                                                    <asp:Label ID="Label2" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                                                                </td>
                                                                                <td>
                                                                                    <telerik:RadDatePicker ID="dtpCDate" runat="server" Culture="English (United Kingdom)"
                                                                                        CssClass="TextBox" ReadOnly="true" ToolTip="Transaction date is system date by default and cannot be changed"
                                                                                        Width="200px" Enabled="true">
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
                                                                            </tr>

                                                                            <td style="width: 150px;">
                                                                                <div id="lblcPayMode" runat="server">
                                                                                    <asp:Label ID="Label9" runat="server" Text="Payment Mode" CssClass="Font_lbl2"></asp:Label>
                                                                                </div>
                                                                                <div id="lblcgroup" runat="server">
                                                                                    <asp:Label ID="Label1" runat="server" Text="Group" CssClass="Font_lbl2"></asp:Label>
                                                                                </div>
                                                                            </td>
                                                                            <td>
                                                                                <div id="lblpaymode" runat="server">
                                                                                    <asp:DropDownList ID="ddlPayMode" runat="server" Width="200px"
                                                                                        ToolTip="Indicates if the amount is pay to cash or card" OnSelectedIndexChanged="ddlPayMode_SelectedIndexChanged" AutoPostBack="true">
                                                                                        <asp:ListItem Text="CASH" Value="CASH"></asp:ListItem>
                                                                                        <asp:ListItem Text="CARD" Value="CARD"></asp:ListItem>
                                                                                        <asp:ListItem Text="CHEQUE" Value="CHEQUE"></asp:ListItem>
                                                                                        <asp:ListItem Text="ADVANCE PAYMENT" Value="ADVANCE PAYMENT"></asp:ListItem>
                                                                                        <asp:ListItem Text="DEPOSIT" Value="DEPOSIT"></asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </div>

                                                                                <div id="lblgroup" runat="server">
                                                                                    <asp:DropDownList ID="ddlGroup" runat="server" Width="200px"
                                                                                        ToolTip="Indicates if the amount is a debit or a credit or a reversal of a previous debit or a credit" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged" AutoPostBack="true">
                                                                                        <asp:ListItem Text="DINING" Value="DINING"></asp:ListItem>
                                                                                        <asp:ListItem Text="SERVICE" Value="SERVICE"></asp:ListItem>
                                                                                        <asp:ListItem Text="CASH" Value="CASH"></asp:ListItem>

                                                                                    </asp:DropDownList>
                                                                                </div>
                                                                            </td>
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
                                                                                    <asp:TextBox ID="txtCAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="The transaction amount either entered manually or calculated as Rate * Count and displayed (Cannot be edited)." Width="200px" onkeypress="return isNumberKey(event);" OnTextChanged="txtCAmount_TextChanged" AutoPostBack="true"></asp:TextBox>
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
                                                                                    <asp:DropDownList ID="ddlsavetime" runat="server" Width="280px" ToolTip="Select from a standard picklist of frequently used sentences." OnSelectedIndexChanged="ddlsavetime_SelectedIndexChanged" AutoPostBack="true">
                                                                                    </asp:DropDownList>
                                                                                    <asp:Button ID="btnSaveTime" runat="server" Text="SaveTime" CssClass="Button"
                                                                                        OnClick="btnSaveTime_Click" ToolTip="SaveTime by adding frequently used comments. Click here to add such comments.  Remember whatever you add once is available everywhere in the system." Font-Names="verdana" BackColor="DarkBlue" ForeColor="White" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" align="center">
                                                                                    <asp:Label ID="lbldeposit" runat="server" Text="" ForeColor="DarkBlue" Font-Names="verdana" Font-Size="Small"></asp:Label>

                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" align="center">
                                                                                    <asp:Label ID="lblNewBalance" runat="server" Text="" ForeColor="DarkBlue" Font-Names="verdana" Font-Size="Small" Visible="false"></asp:Label>
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

                                                                    </td>

                                                                    <td style="vertical-align: top; visibility:hidden">
                                                                        <%--<asp:Label ID="Label11" runat="server" Text="Use this screen to post adhoc debits or to accept payments against the monthly statement." Font-Names="verdana" ForeColor="Gray" Font-Size="Small"></asp:Label><br />--%>
                                                                        <asp:Label ID="Label28" runat="server" Text="Use this screen to post Debits, Credits, Deposits, and Reversals to a resident’s account." Font-Names="verdana" ForeColor="Gray" Font-Size="Small"></asp:Label><br />
                                                                        <%--<asp:Label ID="Label13" runat="server" Text="Payments can be accepted against the main account only." Font-Names="verdana" ForeColor="Gray" Font-Size="Small"></asp:Label><br />
                                                                        <asp:Label ID="lblcurrentBillingMonth" runat="server" Text="" Font-Names="verdana" ForeColor="Gray" Font-Size="Small"></asp:Label><br />
                                                                        <asp:Label ID="lblBillGenerationDate" runat="server" Text="" Font-Names="verdana" ForeColor="Gray" Font-Size="Small"></asp:Label><br />
                                                                        <asp:Label ID="Label18" runat="server" Text="Make sure all debits for the month are posted before the deadline to ensure these appear in the statement of account." Font-Names="verdana" ForeColor="Gray" Font-Size="Small"></asp:Label><br />
                                                                        <asp:Label ID="Label16" runat="server" Text="Debits can be posted to the main account only." Font-Names="verdana" ForeColor="Gray" Font-Size="Small"></asp:Label><br />--%>
                                                                        <asp:Label ID="Label17" runat="server" Text="Are you going to accept a DEPOSIT from the resident. If so, use the code DEPOSIT." Font-Names="verdana" ForeColor="Gray" Font-Size="Small"></asp:Label>
                                                                    </td>

                                                                </tr>

                                                            </table>
                                                            <table>
                                                                <tr>

                                                                    <td style="width: 150px;"></td>
                                                                    <td>
                                                                        <asp:Button ID="btnTransSave" runat="server" Text="Save" CssClass="btn btn-success" Visible="true"
                                                                            OnClick="btnTransSave_Click" OnClientClick="ConfirmMsg()" ToolTip="Click here to save the details" />

                                                                        <%-- <asp:Button ID="btnTransPayLater" runat="server" Text="Pay Later" CssClass="btn btn-success" Visible="false"
                                                                            OnClick="btnTransPayLater_Click" OnClientClick="ConfirmMsg()" ToolTip="" />

                                                                        <asp:Button ID="btnTransCredit" runat="server" Text="Credit" CssClass="btn btn-success" Visible="false"
                                                                            OnClick="btnTransCredit_Click" OnClientClick="ConfirmMsg()" ToolTip="" />

                                                                        <asp:Button ID="btnTransPostCrAdjust" runat="server" Text="Post cr.Adj" CssClass="btn btn-success" Visible="false"
                                                                            OnClick="btnTransPostCrAdjust_Click" OnClientClick="ConfirmMsg()" ToolTip="" />

                                                                        <asp:Button ID="btnTransPostDrAdust" runat="server" Text="Post Dr.Adj" CssClass="btn btn-success" Visible="false"
                                                                            OnClick="btnTransPostDrAdust_Click" OnClientClick="ConfirmMsg()" ToolTip="" />--%>

                                                                        <asp:Button ID="btnCClear" runat="server" Text="Clear" CssClass="btn btn-info" Visible="true"
                                                                            OnClick="btnCClear_Click" ToolTip="Click here to clear entered details" />

                                                                        <asp:Button ID="btnTransExit" runat="server" Text="Exit" CssClass="btn btn-info" Visible="true"
                                                                            OnClick="btnTransExit_Click" ToolTip="" />

                                                                    </td>
                                                                </tr>



                                                            </table>

                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label11" runat="server" Text="Resident Name:" Font-Names="verdana" ForeColor="Maroon" Font-Bold="false" ></asp:Label>
                                                                        <asp:Label ID="lblresidentname" runat="server" Text="Label" Font-Names="verdana" ForeColor="DarkBlue" Font-Bold="false"></asp:Label>
                                                                        <asp:Label ID="Label16" runat="server" Text=" - Door No:" Font-Names="verdana" ForeColor="Maroon" Font-Bold="false"></asp:Label>
                                                                        <asp:Label ID="lblDoorno" runat="server" Text="Label" Font-Names="verdana" ForeColor="DarkBlue" Font-Bold="false"></asp:Label>
                                                                        <asp:Label ID="Label29" runat="server" Text=" - AccountNo:" Font-Names="verdana" ForeColor="Maroon" Font-Bold="false"></asp:Label>
                                                                        <asp:Label ID="lblAccountNo" runat="server" Text="Label" Font-Names="verdana" ForeColor="DarkBlue" Font-Bold="false"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <telerik:RadGrid ID="gvTransactions" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"  Height="350px"
                                                                            Width="700px" AllowFilteringByColumn="false" AllowPaging="false" >
                                                                            <ClientSettings>
                                                                                <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                                                                <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                                            </ClientSettings>
                                                                            <MasterTableView>
                                                                                <Columns>
                                                                                   <%-- <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="100px" DataField="Name" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn HeaderText="DoorNo" HeaderStyle-Width="100px" DataField="DoorNo" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>--%>
                                                                                    <telerik:GridBoundColumn HeaderText="RefNo" HeaderStyle-Width="100px" DataField="BillNo" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="100px" DataField="Date" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn HeaderText="Narration" HeaderStyle-Width="100px" DataField="Narration" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn HeaderText="Dr./Cr." HeaderStyle-Width="50px" DataField="Dr./Cr." ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn HeaderText="Amount" HeaderStyle-Width="100px" DataField="Amount" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderStyle-HorizontalAlign ="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn HeaderText="Closing" HeaderStyle-Width="100px" DataField="Closing" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" HeaderStyle-HorizontalAlign ="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                                                </Columns>
                                                                            </MasterTableView>
                                                                        </telerik:RadGrid>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </td>

                                                        <td style="width: 10px; vertical-align: top">
                                                            <asp:Button ID="TallyLink" runat="server" Text="Tally Link" CssClass="btn btn-success" Visible="true"
                                                                OnClientClick="TallyLink()" ToolTip="" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>

                                        </tr>


                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>


                    <table>

                        <tr id="trCustDet" visible="true" runat="server">
                            <td style="width: 5px;"></td>
                            <td id="tdTab" style="width: 100%; vertical-align: central;" visible="true" runat="server">
                                <telerik:RadTabStrip ID="RadTabStrip2" runat="server" MultiPageID="RadMultiPage1"
                                    Skin="Sunset" BorderColor="LightGray" BorderStyle="Ridge" BorderWidth="0px" SelectedIndex="5" Style="margin-bottom: 0">
                                    <Tabs>
                                        <telerik:RadTab runat="server" Text="Post Debits & Credits" PageViewID="Transactions" CssClass="Font_lbl"
                                            ForeColor="Black" ToolTip="Click here to post the financial transaction(s) for the selected resident." Selected="false" Visible="false">
                                        </telerik:RadTab>
                                        <telerik:RadTab runat="server" Text="Bill Payment" PageViewID="MBPayment"
                                            CssClass="Font_lbl" ForeColor="Black" ToolTip="Payments by the resident towards monthly bill are posted here." Selected="false" Visible="false">
                                        </telerik:RadTab>
                                        <telerik:RadTab runat="server" Text="Transactions" PageViewID="BTxns" CssClass="Font_lbl"
                                            ForeColor="Black" ToolTip="Click here to view the transactions for any billing period for the selected resident." Visible="false">
                                        </telerik:RadTab>
                                        <telerik:RadTab runat="server" Text="Diary" PageViewID="Diary"
                                            CssClass="Font_lbl" ForeColor="Black" ToolTip="Click here to view the diary entries for the selected resident." Visible="false">
                                        </telerik:RadTab>

                                        <%--<telerik:RadTab runat="server" Text="Yet to be billed" PageViewID="UBTxns" CssClass="Font_lbl"
                                    ForeColor="Black" ToolTip="Click here to view yet to be billed transactions" Visible="true">
                                </telerik:RadTab>--%>
                                        <%-- <telerik:RadTab runat="server" Text="Past Bills" PageViewID="PastBills" CssClass="Font_lbl"
                                    ForeColor="Black" ToolTip="Click here to view the past bills" Visible="true">
                                </telerik:RadTab>--%>
                                    </Tabs>
                                </telerik:RadTabStrip>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblBillingPrd" runat="server" CssClass="Font_lbl2" Text="Billing Period :-" Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label14" runat="server" CssClass="Font_lbl2" Text="From :" Visible="false"></asp:Label>
                                            <asp:Label ID="lblBillFrom" runat="server" CssClass="Font_lbl2" Text="" Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label15" runat="server" CssClass="Font_lbl2" Text="To :" Visible="false"></asp:Label>
                                            <asp:Label ID="lblBillTo" runat="server" CssClass="Font_lbl2" Text="" Visible="false"></asp:Label>
                                            <asp:Label ID="Label3" runat="server" CssClass="Font_lbl2" Text="  ||  " Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" CssClass="Font_lbl2" Text="Last Billed :-" Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" CssClass="Font_lbl2" Text="From :" Visible="false"></asp:Label>
                                            <asp:Label ID="lblLBillFrom" runat="server" CssClass="Font_lbl2" Text="" Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label10" runat="server" CssClass="Font_lbl2" Text="To :" Visible="false"></asp:Label>
                                            <asp:Label ID="lblLBillTo" runat="server" CssClass="Font_lbl2" Text="" Visible="false"></asp:Label>
                                            <asp:Label ID="Label5" runat="server" CssClass="Font_lbl2" Text="  ||  " Visible="false"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label12" runat="server" CssClass="Font_lbl2" Text="Outstanding :-" Visible="false"></asp:Label>
                                            <%--UnBilled Amount--%>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblUBillAmt" runat="server" CssClass="Font_lbl2" Text="" Visible="false"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="2" Width="100%"
                                    Height="100%" Visible="true" BorderColor="#E3E4FA" BorderStyle="Ridge" BorderWidth="1">
                                    <telerik:RadPageView ID="Transactions" runat="server" Selected="true">
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
                                                                <td style="width: 500px; height: 405px; vertical-align: top; background-color: Beige;">
                                                                    <table id="Table1" runat="server" visible="true">
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                <asp:Label ID="Label19" runat="server" Text="Billing Period" Visible="true" CssClass="Font_lbl2"></asp:Label>
                                                                                <%--<asp:Label ID="Label20" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>--%>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddlBillingPeriod" runat="server" AutoPostBack="true" ToolTip="Shows the billing period for which the payments are expected. This will be one less than the current open billing period."
                                                                                    Font-Names="Verdana" Font-Size="Small" Width="200px" Enabled="false">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                <asp:Label ID="Label33" runat="server" Text="Amount Billed" CssClass="Font_lbl2" Visible="true"></asp:Label>

                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtAmtBilled" runat="server" CssClass="TextBox" Height="25px" ToolTip="Amount billed for the billing period" Width="200px" Enabled="false" Visible="true"></asp:TextBox>

                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                <asp:Label ID="Label35" runat="server" Text="Received so far" CssClass="Font_lbl2" Visible="true"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtAmtReceived" runat="server" CssClass="TextBox" Height="25px" ToolTip="Amount paid so far." Width="200px" Enabled="false" Visible="true"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                <asp:Label ID="Label37" runat="server" Text="Amount Due" CssClass="Font_lbl2" Visible="true"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtAmtDue" runat="server" CssClass="TextBox" Height="25px" ToolTip="Outstanding amount" Width="200px" Enabled="false" Visible="true"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="width: 150px;">
                                                                                <asp:Label ID="Label39" runat="server" Text="Amount Received Now" CssClass="Font_lbl2" Visible="true"></asp:Label>

                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtAmtReceivedNow" runat="server" CssClass="TextBox" Height="25px" ToolTip="Amount received now." Width="200px" Enabled="true" Visible="true" onkeypress="return isNumberKey(event);"></asp:TextBox>

                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <table>
                                                                        <tr>
                                                                            <td style="width: 150px;"></td>
                                                                            <td>
                                                                                <telerik:RadWindowManager runat="server" ID="BulkDebitConfirmationMsgBox">
                                                                                </telerik:RadWindowManager>
                                                                                <%--<asp:Button ID="btnPMBSave" runat="server" Text="Save" CssClass="btn btn-success" Visible="true"
                                                                            OnClick="UpdateBulkDebit" OnClientClick="javascript:return ValidateAmt()" ToolTip="Click here to save the details" />--%>
                                                                                <asp:Button ID="btnPMBSave" runat="server" Text="Save" CssClass="btn btn-success" Visible="true"
                                                                                    OnClick="btnPMBSave_Click" OnClientClick="TransConfirmMsg()" ToolTip="Click here to save the details" />

                                                                                <%--OnClientClick="javascript:return ValidateAmt()"--%>

                                                                                <%-- btnPMBSave_Click--%>
                                                                                <asp:Button ID="btnPMBClear" runat="server" Text="Clear" CssClass="btn btn-info" Visible="false"
                                                                                    OnClick="btnPMBClear_Click" ToolTip="Click here to clear entered details" />
                                                                                <asp:Button ID="btnpmbhidden" Text="" Style="display: none;" OnClick="btnPMBSave_Click" runat="server" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td style="vertical-align: top">
                                                                    <asp:Label ID="Label20" runat="server" Text="Monthly bills for the residents are raised at the end of each billing period." CssClass="Font_lbl2" Visible="true" Font-Size="Small"></asp:Label><br />
                                                                    <asp:Label ID="Label22" runat="server" Text="Payments for the same are usually done in the next open billing period." CssClass="Font_lbl2" Visible="true" Font-Size="Small"></asp:Label><br />
                                                                    <asp:Label ID="Label23" runat="server" Text="This screen is for accepting payments against the monthly bill." CssClass="Font_lbl2" Visible="true" Font-Size="Small"></asp:Label><br />
                                                                    <asp:Label ID="Label24" runat="server" Text="This screen is not for posting adhoc credits." CssClass="Font_lbl2" Visible="true" Font-Size="Small"></asp:Label><br />
                                                                    <asp:Label ID="Label25" runat="server" Text="If the amount is not paid in full it will be carried forward." CssClass="Font_lbl2" Visible="true" Font-Size="Small"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView ID="BTxns" runat="server">
                                        <table oncontextmenu="return false;" width="99%">
                                            <tr>
                                                <td style="width: 10px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 10px"></td>
                                                <td colspan="2" style="width: 100%; height: 405px; vertical-align: top; background-color: Beige;">
                                                    <table width="97%" style="font-family: Calibri;">
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="LblFromDate" runat="Server" Text="Transactions for the Billing Period:" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>


                                                                <asp:DropDownList ID="ddlBPeriod" ToolTip="Select billing period" runat="server" AutoPostBack="true"
                                                                    Font-Names="Verdana" Font-Size="Small" Width="200px" OnSelectedIndexChanged="ddlBPeriod_Changed">
                                                                </asp:DropDownList>
                                                                <asp:Label ID="lblBPeriod" runat="Server" Text="" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>

                                                                <%--<telerik:RadDatePicker ID="BTFromDate" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick the billing start date." AutoPostBack="true"
                                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                                            <DatePopupButton></DatePopupButton>
                                                            <DateInput ID="DateInput1" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                                                            </DateInput>
                                                            <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle BackColor="bisque" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                        &nbsp;&nbsp;&nbsp
                                                         <asp:Label ID="LblToDate" runat="Server" Text="Till  " ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>

                                                        <telerik:RadDatePicker ID="BTToDate" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick the billing end date" AutoPostBack="true"
                                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                                            <DatePopupButton></DatePopupButton>
                                                            <DateInput ID="DateInput2" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                                                            </DateInput>
                                                            <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle BackColor="bisque" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDatePicker>--%>
                                                      
                                                        
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button ID="btnExpBT" runat="server" Text="Export to excel" CssClass="btn btn-success"
                                                                    Visible="true" OnClick="btnExpBT_Click" ToolTip="Click here to export billed transaction" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table>
                                                        <tr>
                                                            <td width="100%" colspan="4">
                                                                <asp:Panel runat="server" Width="100%" Height="300px" ScrollBars="Auto">
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
                                                                                <telerik:GridBoundColumn HeaderText="Billing Period" DataField="BPeriod" HeaderStyle-Width="80px"
                                                                                    ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                                    <HeaderStyle HorizontalAlign="Center" Width="80px"></HeaderStyle>
                                                                                    <ItemStyle Width="80px" HorizontalAlign="Center"></ItemStyle>
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Txn Date" DataField="TXDATE" HeaderStyle-Width="80px"
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
                                                                                <telerik:GridBoundColumn HeaderText="Txn Type" DataField="TransType" ItemStyle-Wrap="true"
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
                                                        <tr align="right">
                                                            <td>
                                                                <asp:Label ID="Label64" runat="server" Text="Total Debits:" CssClass="Font_lbl2"></asp:Label>
                                                                <asp:Label ID="lblDebit" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                                &nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label66" runat="server" Text="Total Credits:" CssClass="Font_lbl2"></asp:Label>
                                                                <asp:Label ID="lblCredit" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                                &nbsp;&nbsp;&nbsp &nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label62" runat="server" Text="Outstanding:" CssClass="Font_lbl2"></asp:Label>
                                                                <asp:Label ID="lblTotal" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView ID="Diary" runat="server" ForeColor="Black" Height="420px"
                                        Width="100%" Visible="true">
                                        <div style="float: left">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvMoreinfo" runat="server" AllowPaging="true" PageSize="10" Visible="true"
                                                            Font-Names="Calibri" Font-Size="Smaller" ForeColor="Black" BorderColor="#5B74A8" CssClass="gridview_borders" AllowSorting="true"
                                                            AutoGenerateColumns="false" DataKeyNames="RSN" OnRowCommand="gvMoreinfo_RowCommand" OnPageIndexChanging="gvMoreinfo_PageIndexChanging1" OnSorting="gvMoreinfo_Sorting">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="RSN" HeaderStyle-BackColor="#5B74A8" Visible="false" SortExpression="CreatedOn" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White">
                                                                    <ItemStyle BorderColor="#5B74A8" HorizontalAlign="Center" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRSN" runat="server" Text='<%# Eval("RSN") %>' Width="80px"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

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

                                                                <asp:TemplateField HeaderText="Entry Date" HeaderStyle-BackColor="#5B74A8" SortExpression="MoreinfoText" HeaderStyle-ForeColor="White">
                                                                    <ItemStyle BorderColor="#5B74A8" Wrap="true" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbltext" runat="server" Text='<%# Eval("MoreInfoText") %>' Width="75px" ToolTip="This is the date when the diary entry was made."></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Entry" HeaderStyle-BackColor="#5B74A8" SortExpression="Response" HeaderStyle-ForeColor="White">
                                                                    <ItemStyle BorderColor="#5B74A8" Wrap="true" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblresponse" runat="server" Text='<%# Eval("Response") %>' Width="220px" ToolTip="This could be automatically inserted or also be a manually entry."></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Response" HeaderStyle-BackColor="#5B74A8" SortExpression="MoreInfoValue" HeaderStyle-HorizontalAlign="Center" HeaderStyle-ForeColor="White">
                                                                    <ItemStyle BorderColor="#5B74A8" HorizontalAlign="left" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblvalue" runat="server" Text='<%# Eval("MoreInfoValue") %>' Width="220px" ToolTip="If the entry was with respect to some action or service request (Ex:  Plumbing work to be done at Villa xyz, the Response col. will have the description of action taken against the request)."></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Response Date" HeaderStyle-BackColor="#5B74A8" SortExpression="MoreInfoGroup" HeaderStyle-ForeColor="White">
                                                                    <ItemStyle BorderColor="#5B74A8" />
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lbltype" runat="server" Text='<%# Eval("MoreInfoGroup") %>' Width="75px" ToolTip="This is the date on which the Response was recorded."></asp:Label>
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
                                                                                        <asp:Label ID="Label41" runat="Server" Text="New Entry or a Response" ForeColor="DarkOliveGreen" Font-Bold="true" Font-Names="Calibri" Font-Size="Medium"></asp:Label>
                                                                                        <br />
                                                                                    </td>
                                                                                </tr>

                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblctext" runat="Server" Text="Date:" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true" Visible="false"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txttext" runat="Server" MaxLength="240" ToolTip="Enter the action taken (response) to the diary entry. " ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline" Width="310px" Height="50px" Visible="false"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>

                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblcvalue" runat="Server" Text="Entry:" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtvalue" runat="Server" MaxLength="240" ToolTip="What is this entry all about.  Either Auto Inserted or Manually entered." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline" Width="310px" Height="50px"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>

                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblcdescription" runat="Server" Text="Response:" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtdescription" runat="Server" MaxLength="240" ToolTip="Response for the entered data." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline" Width="310px" Height="50px"></asp:TextBox>
                                                                                    </td>
                                                                                </tr>

                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label ID="lblDRSN" runat="Server" Text="RSN" ForeColor="Black" Font-Names="Calibri" Font-Size="small" Font-Bold="true" Visible="false"></asp:Label>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:TextBox ID="txtDRSN" runat="Server" MaxLength="240" ToolTip=" What is this entry all about.  Either Auto Inserted or Manually entered." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline" Width="310px" Height="50px" Visible="false"></asp:TextBox>
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
                                                                                        <asp:Label ID="Label43" runat="Server" Text="" ForeColor="Gray" Font-Names="Calibri" Font-Size="Smaller" Font-Bold="true"></asp:Label>
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
                                                        <asp:Label ID="Label69" runat="Server" Text="If there is a certain monetary value attached , enter the amount in the Value column." ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Smaller"></asp:Label><br />
                                                        <asp:Label ID="Label26" runat="Server" Text="You cannot edit the Entry, after it is recorded. But you can write a Response by clicking on the Edit button." ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Smaller"></asp:Label><br />
                                                        <asp:Label ID="Label27" runat="Server" Text="To add a New Entry, click on the PLUS Button." ForeColor="DarkGray" Font-Names="Calibri" Font-Size="Smaller"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </telerik:RadPageView>

                                    <telerik:RadPageView ID="UBTxns" runat="server">
                                        <table oncontextmenu="return false;">
                                            <tr>
                                                <td style="width: 10px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 10px"></td>
                                                <td colspan="2" style="width: 1200px; height: 405px; vertical-align: top; background-color: Beige;">
                                                    <table width="1150px" style="font-family: Calibri;">
                                                        <tr align="right">
                                                            <td>
                                                                <%--<asp:Label ID="Label28" runat="Server" Text="From" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>

                                                        <telerik:RadDatePicker ID="YBFromDate" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick the billing start date." AutoPostBack="true"
                                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                                            <DatePopupButton></DatePopupButton>
                                                            <DateInput ID="DateInput3" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                                                            </DateInput>
                                                            <Calendar ID="Calendar3" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle BackColor="bisque" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                        &nbsp;&nbsp;&nbsp
                                                         <asp:Label ID="Label29" runat="Server" Text="Till  " ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>

                                                        <telerik:RadDatePicker ID="YBToDate" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick the billing end date" AutoPostBack="true"
                                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                                                            <DatePopupButton></DatePopupButton>
                                                            <DateInput ID="DateInput4" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
                                                            </DateInput>
                                                            <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle BackColor="bisque" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                        &nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp--%>
                                                                <asp:Button ID="btnExpUBT" runat="server" Text="Export to excel" CssClass="btn btn-success"
                                                                    Visible="true" OnClick="btnExpUBT_Click" ToolTip="Click here to export yet to be billed transaction." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td width="1150px" colspan="4">
                                                                <asp:Panel runat="server" Width="1150px" Height="300px" ScrollBars="Auto">
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
                                                                                <telerik:GridBoundColumn HeaderText="Billing Period" DataField="BPeriod" HeaderStyle-Width="80px"
                                                                                    ItemStyle-Width="80px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                                    <HeaderStyle HorizontalAlign="Center" Width="80px"></HeaderStyle>
                                                                                    <ItemStyle Width="80px" HorizontalAlign="Center"></ItemStyle>
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn HeaderText="Txn Date" DataField="TXDATE" HeaderStyle-Width="80px"
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

                                                        <tr align="right">
                                                            <td>&nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label268" runat="server" Text="Total Debits:" CssClass="Font_lbl2"></asp:Label>
                                                                <asp:Label ID="lblDebit2" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                                &nbsp;&nbsp;
                                                                    <asp:Label ID="Label269" runat="server" Text="Total Credits:" CssClass="Font_lbl2"></asp:Label>
                                                                <asp:Label ID="lblCredit2" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
                                                                &nbsp;&nbsp;&nbsp
                                                                    <asp:Label ID="Label270" runat="server" Text="Outstanding:" CssClass="Font_lbl2"></asp:Label>
                                                                <asp:Label ID="lblTotal2" runat="server" Text="" CssClass="Font_lbl2"></asp:Label>
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
                                                        OnClientClick="javascript:return ConfirmMsg()" ToolTip="Click here to update the Registration date in the milestones." OnClick="btnRegistrationSave_Click" />
                                                    <asp:Button ID="btnRegistrationClear" runat="server" Text="Clear" CssClass="btn btn-info" Visible="true"
                                                        ToolTip="Click here to clear entered details" OnClick="btnRegistrationClear_Click" />
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

                </ContentTemplate>
                <Triggers>

                    <asp:PostBackTrigger ControlID="HiddenButton" />
                    <asp:PostBackTrigger ControlID="btnTransSave" />
                </Triggers>

            </asp:UpdatePanel>


        </div>
    </div>
</asp:Content>
