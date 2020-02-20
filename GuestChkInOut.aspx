<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GuestChkInOut.aspx.cs" Inherits="GuestChkInOut" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />


    <script type="text/javascript">
        function chkvalue() {

            var starttime = $find("<%=dtpfromTime.ClientID %>").get_dateInput().get_value();
            var endtime = $find("<%=dtptoTime.ClientID %>").get_dateInput().get_value();
            if (starttime != null && endtime != null && starttime != "" && endtime != "") {
                var startDate = new Date("1/1/1900 " + starttime);
                var endDate = new Date("1/1/1900 " + endtime);
                var difftime = endDate.getTime() - startDate.getTime();
                difftime /= 1000;
                var hrstomins = difftime / 60;
                var hours = parseFloat(difftime / 3600);
                //var mins = parseInt((difftime % 3600) / 60);
                var mins = parseFloat(hours * 60);

            }
            else {
                //alert("No need to Check Any Conditions")
            }
        }
    </script>


    <script type="text/javascript">



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

        function SaveValidate() {
            var vali = "";

            vali += BookingType();
            vali += BookingFor();
            vali += FromDate();
            vali += TillDate();
            vali += Name();
            vali += MobileNo();


            if (vali == "") {
                var result = confirm('Do you want to save?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            }
            else {
                alert(vali);
                return false;
            }
        }

        function UpdateValidate() {
            var vali = "";


            vali += BookingType();
            vali += BookingFor();
            vali += FromDate();
            //vali += TillDate();
            //vali += ActualFromDate();
            //vali += ActualTillDate();
            vali += Name();
            vali += MobileNo();



            if (vali == "") {

                var result = confirm('Do you want to update?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            }
            else {
                alert(vali);
                return false;
            }
        }


        function BookingType() {
            var Estimate = document.getElementById('<%= ddlBookingType.ClientID %>').value;

            if (Estimate == "--Select--") {
                return "Please select the booking type" + "\n";
            }
            else {
                return "";
            }
        }


        function BookingFor() {
            var Estimate = document.getElementById('<%= ddlBookingFor.ClientID %>').value;

            if (Estimate == "--Select--") {
                return "Please select the booking for" + "\n";
            }
            else {
                return "";
            }
        }

        function FromDate() {
            var FDate = document.getElementById('<%=dtpfromdate.ClientID%>').value;
            if (FDate == "") {
                return "Please Select check in date" + "\n";
            }
            else {
                return "";
            }
        }


        function TillDate() {
            var TDate = document.getElementById('<%=dtptilldate.ClientID%>').value;
            if (TDate == "") {
                return "Please Select check out date" + "\n";
            }
            else {
                return "";
            }
        }

        <%--         function ActualFromDate() {
             var AFDate = document.getElementById('<%=dtpActualFromDate.ClientID%>').value;
             var Status = document.getElementById('<%=ddlStatus.ClientID%>').value;

             if (Status == "20") {
                 if (AFDate == "") {
                     return "Please Select actual from date" + "\n";
                 }
                 else {
                     return "";
                 }
             }
             else {
                 return "";
             }


         }--%>


         <%--function ActualTillDate() {
             var ATDate = document.getElementById('<%=dtpActualTillDate.ClientID%>').value;
             if (ATDate == "") {
                 return "Please Select actual till date" + "\n";
             }
             else {
                 return "";
             }
         }--%>


        function Name() {
            var Name = document.getElementById('<%= txtName.ClientID %>').value;

            if (Name == "") {
                return "Please enter the name of the customer" + "\n";
            }
            else {
                return "";
            }
        }

        function MobileNo() {
            var MobileNo = document.getElementById('<%= txtMobileNo.ClientID %>').value;

            if (MobileNo == "") {
                return "Please enter the mobile no of the customer" + "\n";
            }
            else {
                return "";
            }
        }


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
        <div class="first_cnt" style="background-color: #FDF184">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>


                    <asp:HiddenField ID="hfregularcount" runat="server" />

                    <div style="width: 100%">

                        <table style="width: 100%">
                            <tr>
                                <td align="center">
                                    <asp:HiddenField ID="hbtnRSN" runat="server" />
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                                <td>
                                    <telerik:RadWindow ID="rwPosting" Width="500" Height="450" VisibleOnPageLoad="false"
                                        runat="server" OpenerElementID="<%# btnPosting.ClientID  %>" Title="Posting " Modal="true" CssClass="availability">
                                        <ContentTemplate>

                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>

                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblAccountNo" runat="server" Text="" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon" CssClass="Font_lbl2"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblGuestName" runat="server" Text="" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon" CssClass="Font_lbl2"></asp:Label>
                                                            </td>

                                                            <td>
                                                                <asp:Label ID="lblMobileNo" runat="server" Text="" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon" CssClass="Font_lbl2"></asp:Label>
                                                            </td>

                                                        </tr>

                                                    </table>


                                                    <table>
                                                        <tr>

                                                            <td style="width: 150px;">
                                                                <asp:Label ID="lblCDate" runat="server" Text="Date" CssClass="Font_lbl2"></asp:Label>
                                                                <asp:Label ID="Label12" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
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
                                                                <asp:Label ID="lblAmountType" runat="server" Text="Type" CssClass="Font_lbl2" Visible="false"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlAmountType" runat="server" Width="200px" Visible="false" OnSelectedIndexChanged="ddlAmountType_Changed" AutoPostBack="true"
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
                                                                <asp:Label ID="Label13" runat="server" Text="Payment Mode" CssClass="Font_lbl2"></asp:Label>
                                                            </div>
                                                            <div id="lblcgroup" runat="server">
                                                                <asp:Label ID="Label16" runat="server" Text="Txn. Code" CssClass="Font_lbl2"></asp:Label>
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
                                                                <asp:Label ID="Label15" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
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
                                                                <%-- <asp:DropDownList ID="ddlsavetime" runat="server" Width="280px" ToolTip="Select from a standard picklist of frequently used sentences." OnSelectedIndexChanged="ddlsavetime_SelectedIndexChanged" AutoPostBack="true">
                                                        </asp:DropDownList>
                                                        <asp:Button ID="btnSaveTime" runat="server" Text="SaveTime" CssClass="Button"
                                                            OnClick="btnSaveTime_Click" ToolTip="SaveTime by adding frequently used comments. Click here to add such comments.  Remember whatever you add once is available everywhere in the system." Font-Names="verdana" BackColor="DarkBlue" ForeColor="White" />--%>
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

                                                            <td style="width: 150px;"></td>
                                                            <td>
                                                                <asp:Button ID="btnTransSave" runat="server" Text="Save" CssClass="btn btn-success" Visible="true"
                                                                    OnClick="btnTransSave_Click" OnClientClick="ConfirmMsg()" ToolTip="Click here to save the details" />

                                                                <asp:Button ID="btnCClear" runat="server" Text="Clear" CssClass="btn btn-info" Visible="true"
                                                                    OnClick="btnCClear_Click" ToolTip="Click here to clear entered details" />

                                                                <asp:Button ID="btnTransExit" runat="server" Text="Exit" CssClass="btn btn-info" Visible="true"
                                                                    OnClick="btnTransExit_Click" ToolTip="" />

                                                            </td>
                                                          </tr>
                                                    </table>

                                                </ContentTemplate>

                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="txtCAmount" EventName="TextChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="ddlGroup" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="ddlPayMode" EventName="SelectedIndexChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="ddlAmountType" EventName="SelectedIndexChanged" />

                                                </Triggers>
                                            </asp:UpdatePanel>

                                        </ContentTemplate>


                                    </telerik:RadWindow>
                                </td>

                                <td>
                                    <telerik:RadWindow ID="rwTransactions" VisibleOnPageLoad="false" Title="Transactions" Width="1000" MinHeight="600" Font-Names="Verdana"
                                        runat="server" Modal="true">
                                        <ContentTemplate>
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
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
                                                                    <asp:Label ID="lblAccountType" runat="server" Text="" CssClass="style2" ForeColor="Maroon" Font-Names="Verdana"
                                                                        Font-Size="small"></asp:Label>
                                                                </td>


                                                                <td>
                                                                    <asp:Button ID="btnTransactionClose" runat="server" Text="Close" CssClass="button" Width="50px" Height="30px"
                                                                        ToolTip="Click to return to account ledger." OnClick="btnTransactionClose_Click" ForeColor="DarkBlue" />
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td colspan="4">
                                                                    <asp:Label ID="lblFrom" runat="server" Text="" Font-Names="Verdana"
                                                                        CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>

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
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>


                                                    <asp:PostBackTrigger ControlID="btnTransactionClose" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>

                                <td>
                                    <telerik:RadWindow ID="rwPayment" Width="500" Height="450" VisibleOnPageLoad="false"
                                        runat="server" OpenerElementID="<%# btnPayment.ClientID  %>" Title="Posting" Modal="true" CssClass="availability">
                                        <ContentTemplate>
                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                <ContentTemplate>

                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblpAccountCode" runat="server" Text="" Font-Names="Verdana"
                                                                    CssClass="style2" ForeColor="Maroon" Font-Bold="false" Font-Size="small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblpName" runat="server" Text="" CssClass="style2" ForeColor="Maroon" Font-Names="Verdana"
                                                                    Font-Bold="false" Font-Size="small"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblpMobileNo" runat="server" Text="" CssClass="style2" ForeColor="Maroon" Font-Names="Verdana"
                                                                    Font-Size="small"></asp:Label>
                                                            </td>

                                                           
                                                        </tr>

                                                    </table>

                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label17" runat="server" Text="Payment Mode" CssClass="Font_lbl2"></asp:Label>
                                                            </td>
                                                            <td>
                                                                 <asp:DropDownList ID="ddlPPaymode" runat="server" Width="200px"
                                                                    ToolTip="Indicates if the amount is pay to cash or card" OnSelectedIndexChanged="ddlPPaymode_SelectedIndexChanged" AutoPostBack="true">
                                                                    <asp:ListItem Text="CASH" Value="CASH"></asp:ListItem>
                                                                    <asp:ListItem Text="CARD" Value="CARD"></asp:ListItem>
                                                                    <asp:ListItem Text="CHEQUE" Value="CHEQUE"></asp:ListItem>
                                                                    <asp:ListItem Text="ADVANCE PAYMENT" Value="ADVANCE PAYMENT"></asp:ListItem>
                                                                    <asp:ListItem Text="DEPOSIT" Value="DEPOSIT"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <asp:Label ID="Label18" runat="server" Text="Amount" CssClass="Font_lbl2"></asp:Label>
                                                                <asp:Label ID="Label20" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="."   Width="200px" OnTextChanged="txtPAmount_TextChanged" onkeypress="return isNumberKey(event);"   AutoPostBack="true"></asp:TextBox>
                                                                <%--OnTextChanged="txtCAmount_TextChanged"--%>
                                                                <asp:Label ID="Label21" runat="Server" Text="" ForeColor="DarkBlue" Font-Names="Calibri" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 150px;">
                                                                <asp:Label ID="lblPNarration" runat="server" Text="Narration" CssClass="Font_lbl2"></asp:Label>
                                                                <asp:Label ID="Label23" runat="server" CssClass="TextBox" ForeColor="Red" Text="*"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtPNarration" runat="server" CssClass="TextBox" TextMode="MultiLine"
                                                                    Height="50px" Width="350px" ToolTip=" A brief description of the transaction"></asp:TextBox>
                                                             </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" align="center">
                                                                <asp:Label ID="lblPDeposit" runat="server" Text="" ForeColor="DarkBlue" Font-Names="verdana" Font-Size="Small"></asp:Label>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2" align="center">
                                                                <asp:Label ID="lblpNewBalance" runat="server" Text="" ForeColor="DarkBlue" Font-Names="verdana" Font-Size="Small" Visible="false"></asp:Label>
                                                            </td>
                                                        </tr>


                                                        <tr>

                                                            <td style="width: 150px;"></td>
                                                            <td>
                                                                <asp:Button ID="btnPSave" runat="server" Text="Save" CssClass="btn btn-success" Visible="true"
                                                                    OnClick="btnPSave_Click" OnClientClick="ConfirmMsg()" ToolTip="Click here to save the details" />

                                                                <asp:Button ID="btnPClear" runat="server" Text="Clear" CssClass="btn btn-info" Visible="true"
                                                                    OnClick="btnCClear_Click" ToolTip="Click here to clear entered details" />

                                                                <asp:Button ID="btnPExit" runat="server" Text="Exit" CssClass="btn btn-info" Visible="true"
                                                                    OnClick="btnPExit_Click" ToolTip="" />

                                                            </td>
                                                          </tr>
                                                          
                                                    </table>

                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="txtPAmount" EventName="TextChanged" />
                                                    <asp:AsyncPostBackTrigger ControlID="ddlPPaymode" EventName="SelectedIndexChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </ContentTemplate>
                                    </telerik:RadWindow>

                                </td>

                            </tr>
                        </table>

                        <table>
                              <tr>

                                <td align="left">
                                    <asp:LinkButton ID="lnkcount" runat="server" Font-Names="Verdana" ForeColor="Maroon" Font-Size="Medium" Font-Bold="true"></asp:LinkButton>
                                </td>

                                <td align="right">

                                    <asp:Button ID="BtnExcelExport" CssClass="btn" Width="125PX" Font-Bold="true" Text="Export to Excel" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here export grid details to excel." OnClick="BtnExcelExport_Click" />
                                </td>
                            </tr>

                            <tr style="width: 100%">
                                <td colspan="2">
                                    <%--<asp:Label ID="Label12" runat="Server" Text="Status" ForeColor="Black" Font-Names="verdana"></asp:Label>

                                    <asp:DropDownList ID="ddlRStatus" runat="server" ToolTip="Choose the booking status." Height="23px" Width="175px" AutoPostBack="true" OnSelectedIndexChanged="ddlRStatus_SelectedIndexChanged">

                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Booked" Value="00"></asp:ListItem>
                                        <asp:ListItem Text="Occupancy for today" Value="20"></asp:ListItem>
                                        <asp:ListItem Text="Billed" Value="30"></asp:ListItem>

                                    </asp:DropDownList>


                                    <asp:Label ID="lblcrfromdate" runat="Server" Text="From Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                    <telerik:RadDatePicker ID="dtpcrfromdate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking start date." AutoPostBack="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>

                                    <asp:Label ID="lblcrtilldate" runat="Server" Text="Till Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                    <telerik:RadDatePicker ID="dtpcrtilldate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking start date." AutoPostBack="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>


                                    <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the facility details based on selection type." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click"></asp:Button>--%>

                                </td>
                            </tr>


                            <tr>
                                <td>
                                    <asp:Button ID="btnPosting" ToolTip="Click here to post transactions to the selected guest house resident." CssClass="btn" OnClick="btnPosting_Click" runat="server" Text="Posting" ForeColor="White" BackColor="DarkGreen" Width="90px" />
                                    &nbsp;  &nbsp;
                                    <asp:Button ID="btnPayment" ToolTip="Click here to collect payment from the guest house resident." CssClass="btn" OnClick="btnPayment_Click" runat="server" Text="Payment" ForeColor="White" BackColor="Orange" Width="90px" Visible="false"/>
                                    <asp:Button ID="BtnAlacarte" ToolTip="Click here to add food billing for the guest house residents" CssClass="btn" OnClick="BtnAlacarte_Click" runat="server" Text="A La Carte" ForeColor="White" BackColor="Orange" Width="120px" />
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">
                                    <telerik:RadGrid ID="gvGuestBooking" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                        AutoGenerateColumns="false" OnItemCommand="gvGuestBooking_ItemCommand" Width="100%"
                                        AllowFilteringByColumn="true" AllowPaging="false" OnInit="gvGuestBooking_Init" OnItemDataBound="gvGuestBooking_ItemDataBound">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />

                                        </ClientSettings>
                                        <MasterTableView>

                                            <CommandItemSettings ShowExportToCsvButton="true" />
                                            <Columns>
                                                <%--<telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the booking deatails" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>--%>

                                               <%-- <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1" ItemStyle-Width="25px" HeaderStyle-Width="25px" HeaderTooltip="Click here if you wish to update all. Uncheck whichever you do not want to update.">
                                                </telerik:GridClientSelectColumn>--%>

                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false" UniqueName="RSN">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RSN") %>' CommandArgument='<%# Eval("RSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="Facility Type" HeaderStyle-Width="10%" DataField="FacilityGroup" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Arrival Date" HeaderStyle-Width="10%" DataField="FromDate" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Checkout Date" HeaderStyle-Width="10%" DataField="TillDate" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Facility" HeaderStyle-Width="10%" DataField="BookingFor" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="10%" DataField="Name" ReadOnly="true" UniqueName="Name" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <%-- <telerik:GridBoundColumn HeaderText="AccountCode" HeaderStyle-Width="10%" DataField="AccountCode" UniqueName="AccountCode" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>--%>
                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center" HeaderStyle-Width="10%" DataField="AccountCode"
                                                    HeaderText="Account Code" HeaderStyle-Font-Names="Calibri" AllowFiltering="true" UniqueName="AccountCode" SortExpression="AccountCode">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="Lnkbtnview" runat="server" ToolTip="Click to View transaction details." Text='<%# Eval("AccountCode") %>' Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtnview_Click">View</asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn HeaderText="Mobile No" HeaderStyle-Width="10%" DataField="MobileNo" ReadOnly="true" UniqueName="MobileNo" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="EmailID" HeaderStyle-Width="20%" DataField="EmailID" ReadOnly="true" UniqueName="EmailID" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="20%" DataField="Remarks" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="10%" DataField="Purpose" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="true" HeaderStyle-Width="10%" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkCheckOut" runat="server" Text='CheckOut' CommandArgument='<%# Eval("RSN") %>' CommandName="CheckOut" ToolTip="Click here to CheckOut."></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false" HeaderStyle-Width="10%" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkStatus" runat="server" Text='<%# Eval("Status") %>' CommandArgument='<%# Eval("Status") %>' CommandName="Status" ToolTip="Click here to CheckOut."></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="10%" DataField="Status" ReadOnly="true" Visible="false" FilterControlWidth="50%" UniqueName="Status"></telerik:GridBoundColumn>

                                                <%-- <telerik:GridBoundColumn HeaderText="Actual From Date" HeaderStyle-Width="10%" DataField="ActualFromDate" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Actual Till Date" HeaderStyle-Width="10%" DataField="ActualTillDate" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>--%>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings>

                                            <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                            <Selecting AllowRowSelect="true" CellSelectionMode="SingleCell"></Selecting>

                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </td>
                            </tr>

                        </table>
                        <table style="width: 100%">






                            <tr>
                                <td style="width: 120px">
                                    <asp:Label ID="Label1" runat="Server" Text="Facility Type" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                    <asp:Label ID="Label8" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlBookingType" runat="server" ToolTip="Choose the booking type." Height="23px" Width="175px" AutoPostBack="true" OnSelectedIndexChanged="ddlBookingType_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="Label3" runat="Server" Text="Facility" ForeColor="Black" Font-Names="verdana" Font-Size="Small" CssClass="Font_lbl2"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlBookingFor" runat="server" ToolTip="." Height="23px" Width="175px" AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="Label14" runat="server" Text="Booking For" ForeColor="Black" Font-Names="verdana" Font-Size="Small" CssClass="Font_lbl2"></asp:Label>

                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlPurpose" runat="server" ToolTip="Select a purpose of vehicle" Height="23px" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="ddlPurpose_SelectedIndexChanged">
                                        <asp:ListItem Text="Official" Value="Official"></asp:ListItem>
                                        <asp:ListItem Text="Personal" Value="Personal"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>

                            <tr>

                                <td>
                                    <asp:Label ID="Label47" runat="Server" Text="Arrival Date" ForeColor=" Black " Font-Names="verdana" Font-Size="Small" CssClass="Font_lbl2"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtpfromdate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking start date." AutoPostBack="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>

                                    <asp:Label ID="Label10" runat="server" Text="Arrival Time" Width="90px"></asp:Label>


                                    <telerik:RadTimePicker ID="dtpfromTime" runat="server" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                        <TimeView ID="TimeView6" runat="server">
                                        </TimeView>
                                        <ClientEvents OnDateSelected="chkvalue" />
                                    </telerik:RadTimePicker>


                                </td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:Label ID="Label2" runat="Server" Text="Check out Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" CssClass="Font_lbl2"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtptilldate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking end date." AutoPostBack="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>


                                    <asp:Label ID="Label11" runat="server" Text="Check Out Time"></asp:Label>


                                    <telerik:RadTimePicker ID="dtptoTime" runat="server" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                        <TimeView ID="TimeView1" runat="server">
                                        </TimeView>
                                        <ClientEvents OnDateSelected="chkvalue" />
                                    </telerik:RadTimePicker>

                                </td>

                            </tr>

                            <%-- <tr>

                                <td>
                                    <asp:Label ID="lblactualfromdate" runat="Server" Text="Actual From Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" CssClass="Font_lbl2"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtpActualFromDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking start date." AutoPostBack="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>

                                    <asp:Label ID="lblcActualcheckintime" runat="server" Text="Actual Check In Time" Width="130px"></asp:Label>


                                    <telerik:RadTimePicker ID="dtpAfromtime" runat="server" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                        <TimeView ID="TimeView2" runat="server">
                                        </TimeView>
                                        <ClientEvents OnDateSelected="chkvalue" />
                                    </telerik:RadTimePicker>

                                </td>

                            </tr>
                            <tr>

                                <td>
                                    <asp:Label ID="lblactualtilldate" runat="Server" Text="Actual Till Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtpActualTillDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking end date." AutoPostBack="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>

                                    <asp:Label ID="lblcActualcheckouttime" runat="server" Text="Actual Check Out Time"></asp:Label>


                                    <telerik:RadTimePicker ID="dtpAToTime" runat="server" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                        <TimeView ID="TimeView3" runat="server">
                                        </TimeView>
                                        <ClientEvents OnDateSelected="chkvalue" />
                                    </telerik:RadTimePicker>


                                </td>

                            </tr>--%>



                            <tr>
                                <td>
                                    <asp:Label ID="lblcresident" runat="Server" Text="Resident" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>

                                    <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                        Width="250px" ToolTip="" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged"
                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>


                            <tr>
                                <td>
                                    <asp:Label ID="Label4" runat="Server" Text="Name" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtName" runat="server" ToolTip="Enter the name of the booking customer/resident" Width="250px" MaxLength="80"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="Label5" runat="Server" Text="Address" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAddress" runat="server" ToolTip="" TextMode="MultiLine" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="Server" Text="MobileNo" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMobileNo" runat="server" ToolTip="Enter the name of the booking customer/resident" Width="250px" MaxLength="80"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="Label7" runat="Server" Text="EmailID" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmailID" runat="server" ToolTip="Enter the name of the booking customer/resident" Width="250px" MaxLength="80"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <asp:Label ID="Label9" runat="server" Text="Remarks" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Height="80px" Width="240px" MaxLength="40" ToolTip=""></asp:TextBox>

                                </td>

                            </tr>

                            <%-- <tr>
                                <td>
                                    <asp:Label ID="lblcamount" runat="server" Text="Booking Amount" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAmount" runat="server" TextMode="SingleLine" Width="250px" MaxLength="40" ToolTip="Facility booking amount." OnTextChanged="txtAmount_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </td>

                            </tr>
                              <tr>
                                <td>
                                    <asp:Label ID="lblctaxamount" runat="server" Text="CGST Amount" Font-Names="verdana" Font-Size="Small" Visible="false" Enabled="false"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txttaxamount" runat="server" CssClass="TextBox" Height="25px" ToolTip="Tax amount." Width="200px" Enabled="true" Visible="true" AutoPostBack="true" OnTextChanged="txttaxamount_TextChanged"></asp:TextBox>
                                     <asp:Label ID="lbltaxpercentage" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana"></asp:Label>
                                </td>
                              </tr>
                              <tr>
                                    <td>
                                        <asp:Label ID="lblsgstamount" runat="server" Text="SGST Amount" CssClass="Font_lbl2" Visible="false" Enabled="false"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtSGSTAmouont" runat="server" CssClass="TextBox" Height="25px" ToolTip="Tax amount." Width="200px" Enabled="false" Visible="true"></asp:TextBox>
                                        <asp:Label ID="lblsgstpercentage" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana"></asp:Label>
                                    </td>
                                </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblcDiningamount" runat="server" Text="Dining Amount" Font-Names="verdana" Font-Size="Small" Visible="true"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDiningAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="Dining charges" Width="200px" Enabled="true" Visible="true" onkeypress="return isNumberKey(event);" OnTextChanged="txtDiningAmount_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </td>
                            </tr>
                          
                            <tr>
                                <td>
                                    <asp:Label ID="lblcotheramount" runat="server" Text="Other Amount" Font-Names="verdana" Font-Size="Small" Visible="false" Enabled="false"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtOtherAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="Other charges." Width="200px" Enabled="true" AutoPostBack="true" Visible="true" OnTextChanged="txtOtherAmount_TextChanged"></asp:TextBox>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <asp:Label ID="lblTotalamount" runat="server" Text="Gross Amount" Font-Names="verdana" Font-Size="Small" Visible="false" Enabled="false"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txttotalAmount" runat="server" CssClass="TextBox" Height="25px" ToolTip="Total Amount" Width="200px" Enabled="false" Visible="false" ></asp:TextBox>
                                </td>
                            </tr>--%>

                            <tr>
                                <td>
                                    <asp:Label ID="lblstatus" runat="Server" Text="Status" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlStatus" runat="server" ToolTip="Choose the booking status." Height="23px" Width="175px">
                                        <asp:ListItem Text="Checked In" Value="20"></asp:ListItem>
                                        <asp:ListItem Text=" Checked Out" Value="30"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to check out" OnClick="btnSave_Click" runat="server" Text="Check Out" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                    <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the house keeping task details" OnClick="btnUpdate_Click" runat="server" Text="Check In" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                    <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" Height="25px" OnClick="btnClear_Click" />
                                    <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" Height="25px" OnClick="btnReturn_Click" />
                                </td>

                            </tr>
                          
                        </table>



                    </div>

                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <asp:PostBackTrigger ControlID="btnClear" />
                    <asp:PostBackTrigger ControlID="BtnExcelExport" />
                    <asp:PostBackTrigger ControlID="btnReturn" />
                    <asp:PostBackTrigger ControlID="gvGuestBooking" />
                    <asp:PostBackTrigger ControlID="btnPayment" />
                    <asp:PostBackTrigger ControlID="btnPosting" />
                    <asp:PostBackTrigger ControlID="BtnAlacarte" />
                    <%--<asp:AsyncPostBackTrigger ControlID="txtAmount" EventName ="TextChanged" />
                    <asp:AsyncPostBackTrigger ControlID="txtDiningAmount" EventName ="TextChanged"  />
                    <asp:AsyncPostBackTrigger ControlID="txtOtherAmount" EventName ="TextChanged" />
                    <asp:AsyncPostBackTrigger ControlID="txttaxamount" EventName ="TextChanged" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

