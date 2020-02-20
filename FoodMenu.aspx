<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="FoodMenu.aspx.cs" Inherits="FoodMenu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <script type="text/javascript">


        function AcceptPaymentValidate() {
            var summ = "";
            summ += Resident();
            summ += AmountReceived();

            if (summ == "") {

                var result = confirm('Do you want to Submit?');

                if (result) {

                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }

        function Resident() {
            var Resident = document.getElementById('<%= racAPResident.ClientID %>').value;
            if (Resident == "") {
                return "Please select the resident." + "\n";
            } else {
                return "";
            }
        }

        function AmountReceived() {
            var AmountReceived = document.getElementById('<%= txtamountreceived.ClientID %>').value;
            if (AmountReceived == "") {
                return "Please enter amount received from the resident.";
            } else {
                return "";
            }
        }



        function ConfirmPreparetobill() {

            var result = confirm('This is not reversible. Can I proceed to prepare the bill?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }

        function TaskConfirmMsg() {

            var result = confirm('Do you want to Add?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }

        function TaskConfirmMsg2() {

            var result = confirm('Do you want to update?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
            }

        }
        function TaskConfirmMsgET() {

            var result = confirm('Do you want to Update?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }


        function NavigateDir() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (540 + 50);
            iMyHeight = (window.screen.height / 2) - (275 + 25);
            var Y = 'KitchenPlannerHelp.aspx';
            var win = window.open(Y, "Construction Status - Block Level", "status=no,height=450,width=1150,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");

            win.focus();
        }

    </script>

   

     <script type="text/javascript">
         function validate() {
             var summ = "";
             summ += ItemName();
             summ += ItemCode();


             if (summ == "") {
                 var result = confirm('Do you want to save?');
                 if (result) {
                     document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return true;
                }
                else {
                    document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                    return false;
                }

            }
            else {
                alert(summ);
                return false;
            }
        }
        function ItemName() {
            var Val = document.getElementById('<%=ItemName.ClientID%>').value;
            if (Val == "") {
                return "Please enter Item Name" + "\n";
            }
            else {
                return "";
            }
        }
        function ItemCode() {
            var Val = document.getElementById('<%=ItemCode.ClientID%>').value;
            if (Val == "") {
                return "Please enter Item Code" + "\n";
            }
            else {
                return "";
            }
        }

    </script>



    <script type="text/javascript">
        function CheckAll(id) {
            var masterTable = $find("<%= rgMenuforday.ClientID %>").get_masterTableView();
            var row = masterTable.get_dataItems();
            if (id.checked == true) {
                for (var i = 0; i < row.length; i++) {
                    masterTable.get_dataItems()[i].findElement("ChkConfirm").checked = true;
                }
            }
            else {
                for (var i = 0; i < row.length; i++) {
                    masterTable.get_dataItems()[i].findElement("ChkConfirm").checked = false;
                }
            }
        }
    </script>

    <script type="text/javascript">
        function Check(id) {

            var masterTable = $find("<%= rgMenuforday.ClientID %>").get_masterTableView();
            var row = masterTable.get_dataItems();
            var hidden = document.getElementById("HiddenField1");
            if (id.checked == false) {

                var checkBox = document.getElementById(hidden.value);
                checkBox.checked = false;
            }
            else {
                var checkBox = document.getElementById(hidden.value);
                checkBox.checked = true;
                for (var i = 0; i < row.length; i++) {
                    if (masterTable.get_dataItems()[i].findElement("ChkConfirm").checked == false) {
                        var checkBox = document.getElementById(hidden.value);
                        checkBox.checked = false;
                    }
                }
            }
        }


    </script>

    <script type="text/javascript">
        function UncheckOthers(objchkbox) {
            //Get the parent control of checkbox which is the checkbox list
            var objchkList = objchkbox.parentNode.parentNode.parentNode;
            //Get the checkbox controls in checkboxlist
            var chkboxControls = objchkList.getElementsByTagName("input");
            //Loop through each check box controls
            for (var i = 0; i < chkboxControls.length; i++) {
                //Check the current checkbox is not the one user selected
                if (chkboxControls[i] != objchkbox && objchkbox.checked) {
                    //Uncheck all other checkboxes
                    chkboxControls[i].checked = false;
                }
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



    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">


            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>

                    <script type="text/javascript">
                        function confirmReceiptCallbackFn(arg) {
                            if (arg) //the user clicked OK
                            {
                                __doPostBack("<%=btnPrintReceipt.UniqueID %>", "");
                            }
                        }
                    </script>

                    <script type="text/javascript">
                        function confirmAddMoreCallbackFn(arg) {
                            if (arg) //the user clicked OK
                            {
                                __doPostBack("<%=btnAddMore.UniqueID %>", "");
                            }
                        }
                    </script>

                    <telerik:RadWindowManager runat="server" EnableShadow="true" ID="RadWindowManager2" Localization-OK="Yes" Localization-Cancel="No">
                    </telerik:RadWindowManager>

                    <asp:Button ID="btnPrintReceipt" Text="" Style="display: none;" OnClick="btnPrintReceipt_Click" runat="server" />
                    <asp:Button ID="btnAddMore" Text="" Style="display: none;" OnClick="btnAddMore_Click" runat="server" />

                    <div style="width: 99%; height: 99%">

                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <telerik:RadWindow ID="rwSpecialReport" Width="700" Height="280" VisibleOnPageLoad="false" runat="server" Title="Profile++" Modal="true">
                                        <ContentTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblCRName" runat="server" Text="Name:" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblRName" runat="server" Text="" Font-Names="verdana"></asp:Label>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="lblCRStatus" runat="server" Text="Status:" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblRStatus" runat="server" Text="" Font-Names="verdana"></asp:Label>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="lblCRDoorNo" runat="server" Text="Door No:" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblRDoorNo" runat="server" Text="" Font-Names="verdana"></asp:Label>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <telerik:RadGrid ID="rgSpecialReport" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                            Height="250px" Width="600px" AllowFilteringByColumn="false" AllowSorting="true" AllowPaging="false" PageSize="5" Skin="Sunset">
                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                            <ClientSettings>
                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                <PagerStyle Mode="NumericPages" />
                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                <RowIndicatorColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>

                                                                    <telerik:GridBoundColumn DataField="RARSN" HeaderText="RARSN" UniqueName="RARSN"
                                                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="RTRSN" HeaderText="RTRSN" UniqueName="RTRSN"
                                                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Code" HeaderText="Code" UniqueName="Code"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="100px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="100px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Details" HeaderText="Details" UniqueName="Details"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="ContactNo" HeaderText="ContactNo" UniqueName="ContactNo"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center" Width="100px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center" Width="100px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Emailid" HeaderText="Emailid" UniqueName="Emailid"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </td>
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
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:HiddenField ID="HiddenField2" runat="server" />
                                    <asp:Button ID="btnHelp" runat="server" Text="Help?" CssClass="Button" OnClick="btnHelp_Click" Visible="false" ToolTip="" />
                                </td>
                                <td>
                                    <telerik:RadWindow ID="rwHelp" Width="700" Height="325" VisibleOnPageLoad="false"
                                        runat="server" OpenerElementID="<%# btnHelp.ClientID  %>" Title="Help" Modal="true">
                                        <ContentTemplate>
                                            <table>
                                                <tr>
                                                    <td style="font-size: small; color: Green; font-weight: bold; font-family: calibri">Guess who is coming to Dinner!
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">Shows all occupied houses and the no. of residents (including the dependents) in each house.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">Some may not be using the Dining facility for a day.  Update the ‘Booked’ count for those houses only.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">Some may have guests.  Some may need food to be delivered to their house.   Update these values also.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">These actions help to know in advance, how many diners will be there for a session on a day.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">
                                                    Update the actual count of diners per house and the count of guests and the count of home-service after the session.
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">This action helps to raise the bills automatically and accurately, without delays.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">You can either update in one shot for all houses or select a particular house or a particular resident.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">You can also prepare the data in a Spreadsheet and import.
                                                    </td>
                                                </tr>

                                            </table>
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                                <td>
                                    <telerik:RadWindow ID="rwDTHelp" Width="700" Height="280" VisibleOnPageLoad="false"
                                        runat="server" OpenerElementID="<%# btnDTHelp.ClientID  %>" Title="Help" Modal="true">
                                        <ContentTemplate>
                                            <table>

                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">Detailed statement for a billing month for a resident
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">The amount is calculated based on the actual count and the amount charged for a session.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">For the current billing month, the values are up to the current date and can change.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">For the previous billing months, the values are summed up and shown in the monthly billing statement.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-size: small; color: Blue; font-family: calibri">
                                                    (Rates per session are set in the Sessions master and can be different for regular diners and guests).
                                                </tr>

                                            </table>

                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                                <td>
                                    <telerik:RadWindow ID="rwAddMore" Width="700" Height="280" VisibleOnPageLoad="false"
                                        runat="server" OpenerElementID="<%# btnDTHelp.ClientID  %>" Title="Add More" Modal="true">
                                        <ContentTemplate>
                                            
                                            
                                            <table>

                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label45" runat="server" Text="From Date" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>

                                                        <telerik:RadDatePicker ID="dtpABFromDate" runat="server" Culture="English (United Kingdom)"
                                                            Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Enter the Registration date" MinDate="01/08/2001">
                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="TextBox" Font-Names="Calibri">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="TextBox"
                                                                ForeColor="#00008B" ReadOnly="true" BackColor="Yellow">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label46" runat="server" Text="Till Date" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>

                                                        <telerik:RadDatePicker ID="dtpABToDate" runat="server" Culture="English (United Kingdom)"
                                                            Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Enter the Registration date" MinDate="01/08/2001">
                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                CssClass="TextBox" Font-Names="Calibri">
                                                            </Calendar>
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="TextBox"
                                                                ForeColor="#00008B" ReadOnly="true" BackColor="Yellow">
                                                            </DateInput>
                                                        </telerik:RadDatePicker>
                             
                                                                               </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                </tr>

                                            </table>

                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                                <td>
                                    <telerik:RadWindow ID="rwMenuItems" Width="550px" Height="500px" VisibleOnPageLoad="false"
                                        runat="server" OpenerElementID="<%# btnDTHelp.ClientID  %>" Title="Menu Card" Modal="true">
                                        <ContentTemplate>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadGrid ID="rgMenuItem" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                            Height="400px" Width="500px" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="false" PageSize="10" OnItemCommand="rgMenuItem_ItemCommand" Skin="Sunset">
                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                            <ClientSettings>
                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                <PagerStyle Mode="NumericPages" />
                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                <RowIndicatorColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>

                                                                    <telerik:GridBoundColumn DataField="RSN" HeaderText="RSN" UniqueName="RSN"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Type" HeaderText="Group" UniqueName="Type"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="ItemName" HeaderText="Item Name" UniqueName="ItemName"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Rate" HeaderText="Price" UniqueName="Rate"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </td>
                                                </tr>

                                            </table>

                                        </ContentTemplate>
                                    </telerik:RadWindow>
                                </td>
                            </tr>

                        </table>

                        <%--******************************************--%>
                        <table>
                            <tr id="trCustDet" visible="true" runat="server">
                                <td style="width: 5px;"></td>
                                <td id="tdTab" style="width: 1200px; vertical-align: central;" visible="true" runat="server">



                                    <table style="width: 100%">
                                        <tr>
                                            <td style="text-align: center">
                                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>


                                    <div id="dvWhichItemWhen" runat="server" style="width: 100%">


                                        <asp:LinkButton ID="lbShowMenu" runat="server" Text="+ Add item to standard menu" Font-Underline="false" ForeColor="Black" Font-Names="Calibri" Font-Size="Small" ToolTip="Click here to add a new item to weekly standard menu." OnClick="lbShowMenu_click"></asp:LinkButton>
                                        <asp:Panel ID="pnlMFirst" runat="server" BackColor="LightGray" Visible="false" Width="1180px">

                                            <table>

                                                <tr>

                                                    <td style="width: 65%">

                                                        <table>

                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblSessionCode" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlSession" ToolTip="Choose the session where you wish to include the Menu Item." Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>
                                                                </td>



                                                                <td style="width: 120px">
                                                                    <asp:Label ID="lblCategory" runat="Server" Text="Category" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <%-- <asp:DropDownList ID="ddlCategory" ToolTip="Select Category" Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                            Font-Names="Calibri" Font-Size="Small">
                                                        </asp:DropDownList>--%>

                                                                    <asp:TextBox ID="txtCategory" runat="Server" MaxLength="12" ToolTip="" Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px">
                                                                    <asp:Label ID="lblItemCode" runat="Server" Text="Menu Item" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td style="width: 150px">
                                                                    <asp:DropDownList ID="ddlItemCode" ToolTip="Select Menu Item from the list." Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                                        Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlItemCode_Changed">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblsmtype" runat="Server" Text="Type" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <%-- <asp:DropDownList ID="ddlDay" ToolTip="Select the Day" Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                Font-Names="Calibri" Font-Size="Small">
                                            </asp:DropDownList>--%>
                                                                    <asp:TextBox ID="txtType" runat="Server" MaxLength="12" ToolTip="" Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>

                                                                </td>



                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblItemName" runat="Server" Text="Item Name" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtItemName" runat="Server" MaxLength="12" ToolTip="" Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>

                                                                </td>

                                                                <td>
                                                                    <asp:Label ID="lblServeQty" runat="Server" Text="Serve Qty" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtServeQty" runat="Server" MaxLength="12" ToolTip="Enter here the usual serving quantity per person. Though need not be 100% accurate, try to be close. This will help in forecasting properly and will avoid wastage." Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>

                                                                </td>

                                                            </tr>
                                                            <tr>

                                                                <td>
                                                                    <asp:Label ID="lblUOM" runat="Server" Text="UOM" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtUOM" runat="Server" MaxLength="12" ToolTip="" Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>

                                                                </td>




                                                                <td>
                                                                    <asp:Label ID="lblMonday" runat="Server" Text="Price" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>

                                                                <td>
                                                                    <asp:TextBox ID="txtItemRate" runat="Server" MaxLength="12" ToolTip="" Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>

                                                                </td>

                                                                <%--  <td >
                                                                    <asp:CheckBox ID="chkMonday" runat="server" Text="M" ToolTip="Mention the days of the week when this Food Item will be in the Menu" />
                                                                    <asp:CheckBox ID="chkTuesday" runat="server" Text="Tu" ToolTip="Mention the days of the week when this Food Item will be in the Menu" />
                                                                    <asp:CheckBox ID="chkWednesday" runat="server" Text="W" ToolTip="Mention the days of the week when this Food Item will be in the Menu" />
                                                                    <asp:CheckBox ID="chkThursday" runat="server" Text="Th" ToolTip=" Mention the days of the week when this Food Item will be in the Menu" />
                                                                    <asp:CheckBox ID="chkFriday" runat="server" Text="F" ToolTip="Mention the days of the week when this Food Item will be in the Menu" />
                                                                    <asp:CheckBox ID="chkSaturday" runat="server" Text="Sa" ToolTip=" Mention the days of the week when this Food Item will be in the Menu" />
                                                                    <asp:CheckBox ID="chkSunday" runat="server" Text="Su" ToolTip="Mention the days of the week when this Food Item will be in the Menu" />
                                                                    <asp:CheckBox ID="chkSpl" runat="server" Text="Spcialday" ToolTip="Mention the days of the week when this Food Item will be in the Menu" />

                                                                </td>--%>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label58" runat="Server" Text="Contains" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>

                                                                <td colspan="3">
                                                                    <asp:TextBox ID="txtContains" TextMode="MultiLine" runat="Server" MaxLength="12" ToolTip="" Width="300px" Height="60px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>

                                                                </td>

                                                            </tr>
                                                            <tr>

                                                                <td colspan="4" style="text-align: center">
                                                                    <asp:Button ID="btnSave" runat="Server" Width="70px" Text="Save" ToolTip="Click here to save the details" ForeColor="White" Visible="false" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnSave_Click" OnClientClick="javascript:return TaskConfirmMsg()" />
                                                                    <asp:Button ID="btnUpdate" runat="Server" Width="70px" Text="Update" ToolTip="Click here to Update the details" Visible="false" ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnUpdate_Click" OnClientClick="javascript:return TaskConfirmMsgET()" />
                                                                    <asp:Button ID="btnClear" runat="Server" Width="70px" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnClear_Click" />
                                                                    <asp:Button ID="btnClose" runat="Server" Width="70px" Text="Return" ToolTip="Click here to close" ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Medium" OnClick="btnClose_Click" />
                                                                </td>

                                                            </tr>
                                                        </table>

                                                    </td>

                                                    <td style="vertical-align: top; width: 35%">
                                                        <asp:Label ID="Label37" runat="Server" Text="Here define which Food Menu Item should be served on which day of the week.  If the food item is reserved for a special day (Ex:  Kheer to be served only on a  festival day and not on other days), check the SpecialDay Box.  Make sure you define  all the items properly. Only then these will appear when you set the menu for any particular date.
By defining the Usual Qty. consumed per person, you can get the total quantity that need to be prepared. This will help in estimating the ingredients required and time needed to prepare."
                                                            ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                    </td>
                                                </tr>



                                            </table>

                                        </asp:Panel>
                                        <%-- <asp:Panel ID="pnlSmenuEdit" runat="server" BackColor="LightGray" Visible="false" Width="1180px">
                                            <table>

                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblSessionCodeET" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlSessionET" ToolTip="Choose the session where you wish to include the Menu Item." Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                            Font-Names="Calibri"  Font-Size="Small">
                                                        </asp:DropDownList>
                                                    </td>


                                                    <td style="width: 250px"></td>
                                                    <td style="width: 120px">
                                                        <asp:Label ID="lblCategoryET" runat="Server" Text="Category" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <%-- <asp:DropDownList ID="ddlCategoryET" ToolTip="Select Category" Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                            Font-Names="Calibri" Font-Size="Small">
                                                        </asp:DropDownList>--%>

                                        <%--   <asp:TextBox ID="txtCategoryET" runat="Server" MaxLength="12" ToolTip="" Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>


                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px">
                                                        <asp:Label ID="lblItemCodeET" runat="Server" Text="Menu Item" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                    </td>
                                                    <td style="width: 150px">
                                                        <asp:DropDownList ID="ddlItemCodeET" ToolTip="Select Menu Item from the list." Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                            Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlItemCodeET_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>


                                                    <td style="width: 250px"></td>
                                                    <td>
                                                        <asp:Label ID="lblServeQtyET" runat="Server" Text="Usual Qty" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtServeQtyET" runat="Server" MaxLength="12" ToolTip="Enter here the usual serving quantity per person. Though need not be 100% accurate, try to be close. This will help in forecasting properly and will avoid wastage." Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" ></asp:TextBox>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblItemNameET" runat="Server" Text="Item Name" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtItemNameET" runat="Server" MaxLength="12" ToolTip="" Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>

                                                    </td>

                                                    <td style="width: 250px"></td>
                                                    <td>
                                                        <asp:Label ID="lblMondayET" runat="Server" Text="Served on" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                    </td>
                                                    <td>--%>
                                        <%-- <asp:DropDownList ID="ddlDay" ToolTip="Select the Day" Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                Font-Names="Calibri" Font-Size="Small">
                                            </asp:DropDownList>--%>
                                        <%--   <asp:CheckBox ID="chkMondayET" runat="server" Text="M" ToolTip ="Mention the days of the week when this Food Item will be in the Menu" />
                                                        <asp:CheckBox ID="chkTuesdayET" runat="server" Text="Tu"  ToolTip ="Mention the days of the week when this Food Item will be in the Menu"/>
                                                        <asp:CheckBox ID="chkWednesdayET" runat="server" Text="W"  ToolTip ="Mention the days of the week when this Food Item will be in the Menu"/>
                                                        <asp:CheckBox ID="chkThursdayET" runat="server" Text="Th"  ToolTip =" Mention the days of the week when this Food Item will be in the Menu"/>
                                                        <asp:CheckBox ID="chkFridayET" runat="server" Text="F" ToolTip ="Mention the days of the week when this Food Item will be in the Menu" />
                                                        <asp:CheckBox ID="chkSaturdayET" runat="server" Text="Sa" ToolTip =" Mention the days of the week when this Food Item will be in the Menu" />
                                                        <asp:CheckBox ID="chkSundayET" runat="server" Text="Su" ToolTip ="Mention the days of the week when this Food Item will be in the Menu" />
                                                        <asp:CheckBox ID="chkSplET" runat="server" Text="Spl"  ToolTip ="Mention the days of the week when this Food Item will be in the Menu"/>
                                                    </td>
                                                </tr>
                                                <tr>

                                                    <td>
                                                        <asp:Label ID="lblUOMET" runat="Server" Text="UOM" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtUOMET" runat="Server" MaxLength="12" ToolTip="" Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>

                                                    </td>

                                                    <td></td>
                                                    <td></td>
                                                    <td>
                                                        <asp:Button ID="btnSaveET" runat="Server" Width="70px" Text="Update" ToolTip="Clik here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnSaveET_Click" OnClientClick="TaskConfirmMsgET()" />
                                                        <asp:Button ID="btnClearET" runat="Server" Width="70px" Text="Clear" ToolTip=" Clik here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" />
                                                        <asp:Button ID="btnCloseET" runat="Server" Width="70px" Text="Return" ToolTip="Clik here to close" ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Medium" OnClick="btnCloseET_Click" />
                                                       
                                                    </td>
                                                </tr>


                                            </table>
                                        </asp:Panel>--%>
                                        <asp:Panel ID="pnlMSecond" runat="server" BackColor="LightGray" Visible="true" Width="1180px">
                                            <table>
                                                <tr>
                                                    <td>


                                                        <telerik:RadGrid ID="rdgMenuList" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                            Height="350px" Width="1170px" AllowFilteringByColumn="false" OnItemDataBound="rdgMenuList_ItemDataBound">
                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                            <ClientSettings>
                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                <PagerStyle Mode="NumericPages" />
                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                <RowIndicatorColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn ItemStyle-Width="200px" HeaderStyle-Width="200px">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="LnkEditItem" runat="server" Text="Edit" ToolTip="Click here to edit the statndard menu" Font-Names="verdana" OnClick="LnkEditItem_Click" ForeColor="Blue" Font-Size="Smaller"></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridBoundColumn DataField="RSN" HeaderText="#" UniqueName="RSN"
                                                                        Display="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>


                                                                    <telerik:GridBoundColumn DataField="Session" HeaderText="Session" UniqueName="Session"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="200px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="200px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="ItmName" HeaderText="Item Name" UniqueName="ItmName"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="200px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="200px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="UOM" HeaderText="Units" UniqueName="UOM"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" AllowFiltering="false">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="80px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="80px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="ServeQty" HeaderText="Serve Qty" UniqueName="ServeQty"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" AllowFiltering="false">
                                                                        <HeaderStyle HorizontalAlign="Right" Width="80px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Right" Width="80px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" AllowFiltering="false">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="80px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="80px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Category"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" AllowFiltering="false">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="80px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="80px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Rate" HeaderText="Rate" UniqueName="Rate"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" AllowFiltering="false">
                                                                        <HeaderStyle HorizontalAlign="Right" Width="80px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Right" Width="80px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                        <br />
                                                        <asp:Label ID="lblsmhelp" runat="server" Font-Names="smll" Font-Size="Small" ForeColor="Gray" Text="Define here on which days of the week, which food item to be prepared as part of the menu.  You can set some items for a special day (Ex: Diwali, Resident's Birthday)"></asp:Label>
                                                    </td>
                                                </tr>

                                            </table>
                                        </asp:Panel>
                                    </div>


                                    <div id="dvDayPlanner" runat="server" style="width: 100%">

                                        <telerik:RadWindowManager runat="server" ID="RadWindowManager1"></telerik:RadWindowManager>
                                        <asp:Button ID="HiddenButton" Text="" Style="display: none;" OnClick="HiddenButton_Click" runat="server" />

                                        <asp:LinkButton ID="lblDayCal" runat="server" Text="+ Add a new diner" Font-Underline="false" ForeColor="Black" Font-Names="Calibri" Font-Size="Small" ToolTip="Click here to add estimate diners." OnClick="lblDayCal_click"></asp:LinkButton>
                                        <asp:Panel ID="pnlDCFirst" runat="server" BackColor="LightGray" Visible="false">
                                            <table style="width: 1200px">


                                                <tr>

                                                    <td style="width: 800px">

                                                        <table>

                                                            <tr>
                                                                <td class="auto-style1">
                                                                    <asp:Label ID="Label1" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                </td>
                                                                <td class="auto-style2">
                                                                    <telerik:RadDatePicker ID="dtpDCDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select a date upto seven day ahead.All Open sessions for the selected date are displayed next." AutoPostBack="true" OnSelectedDateChanged="dtpDCDate_Changed">
                                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                            CssClass="TextBox" Font-Names="Calibri">
                                                                        </Calendar>
                                                                        <DatePopupButton></DatePopupButton>
                                                                        <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                            ForeColor="Black" ReadOnly="true">
                                                                        </DateInput>
                                                                    </telerik:RadDatePicker>
                                                                    <asp:Label ID="lblDCWeek" runat="Server" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                </td>

                                                                <td class="auto-style4">
                                                                    <asp:Label ID="Label2" runat="Server" Text="Estimated Diners" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td class="auto-style4">
                                                                    <asp:TextBox ID="txtECount" runat="Server" MaxLength="12" ToolTip="Shows the number of residents expected to dine in the session.This values is the current number of residents. Can be changed." Enabled="false" Width="80px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>

                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label7" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlDCSession" ToolTip="Select the session for which the day planner is being setup.New sessions can be defined by the administrator" Width="230px" Height="25px" runat="server" AutoPostBack="true"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>

                                                                </td>

                                                                <td>
                                                                    <asp:Label ID="Label5" runat="Server" Text="Guests" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtGuests" runat="Server" MaxLength="240" ToolTip="Enter the number of Guests expected to dine in the session." Width="80px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" OnTextChanged="txtGuests_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label4" runat="Server" Text="Special Day?" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:CheckBox ID="chkSplDay" runat="server" ToolTip=" If you set a day as a special day, you can add a special menu item for the day" />
                                                                </td>

                                                                <td>
                                                                    <asp:Label ID="Label39" runat="Server" Text="Staff" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtstaff" runat="Server" MaxLength="240" ToolTip="Enter the number of staff expected to dine in the session." Width="80px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" OnTextChanged="txtstaff_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                                </td>

                                                            </tr>
                                                            <tr>

                                                                <td>
                                                                    <asp:Label ID="Label38" runat="Server" Text="Special Message" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtMessage" runat="Server" MaxLength="240" ToolTip="Set any special message for the day." Width="230px" TextMode="MultiLine" Height="55px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                </td>

                                                                <td>
                                                                    <asp:Label ID="Label40" runat="Server" Text="Total" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtTotal" runat="Server" MaxLength="240" Enabled="false" ToolTip="Total number of diners is calculated and shown here." Width="80px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4" style="text-align: center">
                                                                    <asp:Button ID="btnDCSave" runat="Server" Width="70px" Text="Save" ToolTip="Click here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnDCSave_Click" OnClientClick="javascript:return TaskConfirmMsg()" />
                                                                    <asp:Button ID="btnDCClear" runat="Server" Width="70px" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnDCClear_Click" />
                                                                    <asp:Button ID="Button1" runat="Server" Width="70px" Text="Close" ToolTip="Click here to close" ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Medium" OnClick="btnDCClose_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>

                                                    </td>
                                                    <td style="vertical-align: top; width: 400px">
                                                        <asp:Label ID="Label31" runat="server" Width="200px" Text="Here define how many residents are likely to be servered per session on a day.  This Step Must be done before the Food Menu is defined for that session. Helps to estimate the qtys. Estimate can be done 7 days in advance." Font-Names="Calibri" Font-Size="Smaller" ForeColor="Black"></asp:Label>
                                                    </td>

                                                </tr>

                                            </table>
                                        </asp:Panel>
                                        <asp:Panel ID="pnlDCSecond" runat="server" BackColor="LightGray" Visible="true">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid data to excel." />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 1300px">

                                                        <telerik:RadGrid ID="rdgDCalendar" runat="server" CssClass="table table-bordered table-hover" AllowSorting="true" AutoGenerateColumns="False" AllowPaging="true" PageSize="10"
                                                            Height="350px" Width="1200px" AllowFilteringByColumn="true" OnItemDataBound="rdgDCalendar_ItemBound" OnItemCommand="rdgDCalendar_ItemCommand">
                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                            <ClientSettings>

                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                            </ClientSettings>
                                                            <GroupingSettings CaseSensitive="false" />
                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                <PagerStyle Mode="NumericPages" />
                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                <RowIndicatorColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="RSN" HeaderText="RSN" UniqueName="RSN" Exportable="false"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Date" HeaderText="Date" UniqueName="Date"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Session" HeaderText="Session" UniqueName="Session"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="SplDay" HeaderText="Special Day?" UniqueName="SplDay"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="ExpCount" HeaderText="Estimated Diners" UniqueName="ExpCount"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="GuestCount" HeaderText="Guests" UniqueName="GuestCount"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="StaffCount" HeaderText="Staff" UniqueName="StaffCount"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="TotalCount" HeaderText="Total" UniqueName="TotalCount"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Message" HeaderText="Special Message" UniqueName="Message"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="200px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="200px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>


                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>


                                    <div id="dvDailyMenu" runat="server" style="width: 100%">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtpDMDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpDMDate_Changed">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                    <asp:Label ID="lblWeekDay" runat="Server" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <table>

                                            <tr>
                                                <td>
                                                    <table>

                                                        <tr>
                                                            <td>


                                                                <telerik:RadGrid ID="rdgDayMenu" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                                    Height="300px" Width="900px" AllowFilteringByColumn="true" AllowSorting="true" OnItemCommand="rdgDayMenu_ItemCommand">
                                                                    <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                    </HeaderContextMenu>
                                                                    <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                    </HeaderContextMenu>
                                                                    <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                    <ClientSettings>
                                                                        <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                            ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                        <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                                    </ClientSettings>
                                                                    <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                        <PagerStyle Mode="NumericPages" />
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn>
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn>
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <%--<telerik:GridBoundColumn DataField="Date" HeaderText="Date" UniqueName="Date"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center" Width="80px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center" Width="80px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>--%>
                                                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="left" UniqueName="All" HeaderText="All" ItemStyle-Wrap="false" AllowFiltering="false"
                                                                                ItemStyle-HorizontalAlign="left">
                                                                                <HeaderTemplate>
                                                                                    <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="true" Checked="true" />
                                                                                </HeaderTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="ChkConfirm" ToolTip="Select here to confirm." runat="server" Checked="true"></asp:CheckBox>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>
                                                                            <telerik:GridBoundColumn DataField="Session" HeaderText="Session" UniqueName="Session"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="TItemName" HeaderText="Menu" UniqueName="TItemName"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="TACount" HeaderText="Estimate" UniqueName="TACount"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="TUOM" HeaderText="UOM" UniqueName="TUOM"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="TotServeQty" HeaderText="Estimated Qty" UniqueName="TotServeQty"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                            </telerik:GridBoundColumn>

                                                                            <telerik:GridBoundColumn DataField="SessionCode" HeaderText="" UniqueName="SessionCode"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                                <HeaderStyle HorizontalAlign="Right" Width="0px"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Right" Width="0px"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="ItemCode" HeaderText="" UniqueName="ItemCode"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                                <HeaderStyle HorizontalAlign="Right" Width="0px"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Right" Width="0px"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="TServeQty" HeaderText="" UniqueName="TServeQty"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                                <HeaderStyle HorizontalAlign="Right" Width="0px"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Right" Width="0px"></ItemStyle>
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                                    </ClientSettings>
                                                                </telerik:RadGrid>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Button ID="Button2" runat="server" ToolTip="Click here to Save ." CssClass="btn btn-primary" Text="Save" OnClick="BtnSave_Click" OnClientClick="ConfirmMsg()"></asp:Button>
                                                                <asp:HiddenField ID="HResult" runat="server" />

                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="vertical-align: top">
                                                    <asp:Label ID="Label32" runat="server" Width="150px" Text="Here define the Menu Items per session for a day. You can define a Menu only for tomorrow and for next three days" Font-Names="Calibri" Font-Size="Smaller" ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>

                                    <div id="dvMenuItems" runat="server" style="width: 100%">



                                        <asp:LinkButton ID="lnkMenuItem" runat="server" Text="+ Add a new Menu Item" Font-Underline="false" ForeColor="Black" Font-Names="Calibri" Font-Size="Medium" ToolTip="You can add a new food menu item to the master by clicking here." OnClick="lnkMenuItem_click"></asp:LinkButton>
                                       
                                         <asp:Panel ID="pnlMenuItem" runat="server" BackColor="LightGray" Visible="false">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                                                    <asp:Label ID="Label9" runat="Server" Text="Item Code" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="ItemCode" runat="Server" MaxLength="12" ToolTip="Enter Unique code for the item ML12." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium" Enabled="false"></asp:TextBox>
                                                                </td>
                                                                <td rowspan="3" style="width: 200px"></td>
                                                                <td rowspan="3" style="width: 400px">
                                                                    <asp:Label ID="lblHelptext" runat="server" Width="400px" Height="50px" Font-Names="Verdana" Font-Size="Smaller">Define all the Food Items that will be served for the residents.  A Food Item must be present here before it can be included in the Daily Menu.  Describe the Menu Item in detail, if needed.</asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label10" runat="Server" Text="Item Name" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="ItemName" runat="Server" MaxLength="20" ToolTip="Enter Item name ML20." Width="250px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label11" runat="Server" Text="Units" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <%-- Help : Dropdown --%>
                                                                    <asp:DropDownList ID="ddlUOM" ToolTip="Select Unit Of Measurement for the particular item ML10." Width="150px" Height="25px" runat="server"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label12" runat="Server" Text="Category" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlitmCategory" ToolTip="Define whether this is a Main Dish (Ex: Idly , Bread)  or a Side Dish (Ex: Sambhar , Jam)." Width="150px" Height="25px" runat="server"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                        <asp:ListItem Text="Main" Value="Main"></asp:ListItem>
                                                                        <asp:ListItem Text="Sub" Value="Sub"></asp:ListItem>
                                                                        <asp:ListItem Text="Adhoc" Value="Adhoc"></asp:ListItem>
                                                                    </asp:DropDownList>

                                                                </td>


                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label36" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlitmType" ToolTip="You can group items of same family together. Ex: Different varieties of Rice, Different types of Sambhar." Width="150px" Height="25px" runat="server"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>

                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label90" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlMISession" ToolTip="Choose the session where you wish to include the Menu Item." Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label91" runat="Server" Text="Serve Qty" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtMIServeQty" runat="Server" MaxLength="12" ToolTip="Enter here the usual serving quantity per person. Though need not be 100% accurate, try to be close. This will help in forecasting properly and will avoid wastage." Width="200px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label41" runat="Server" Text="Qty Alert" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtQtyAlert" runat="Server" MaxLength="12" ToolTip=" If the quantity to be prepared for a session, exceeds this value, it is highlighted.  Helps to decide on getting the ingredients and to plan for the cooking." Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label51" runat="Server" Text="Rate" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtRate" runat="Server" MaxLength="12" ToolTip=" The amount to be charged for the menu item if the billing is menu item based." Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label42" runat="Server" Text="Lead Time" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtLeadTime" runat="Server" MaxLength="12" ToolTip=" Some items mayu need to planned atleast a few days in advance. Example Dosa / Idly Batter.  Set the lead time to avoid last minute hassles." Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                </td>
                                                            </tr>


                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label33" runat="Server" Text="Contains" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtRemarks" runat="Server" MaxLength="2400" TextMode="MultiLine" Height="50px" ToolTip=" Describe all items served along with this menu item. Ex: Dosa will be served with Sambhar and Chutney." Width="300px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                                                </td>

                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center" colspan="2">
                                                                    <asp:Button ID="btnSaveItm" runat="Server" Width="70px" Text="Save" ToolTip="Click here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" Font-Size="Medium" OnClick="btnSaveItem_Click" OnClientClick="javascript:return validate()" />
                                                                    <asp:Button ID="btnUpteItm" runat="Server" Width="70px" Text="Update" ToolTip="Click here to Update the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" Font-Size="Medium" OnClick="btnUpteItm_Click" OnClientClick="javascript:return TaskConfirmMsgET()" />
                                                                    <asp:Button ID="btnClearItm" runat="Server" Width="70px" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnClearItm_Click" />
                                                                    <asp:Button ID="btnCloseItm" runat="Server" Width="70px" Text="Close" ToolTip="Click here to close" ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Medium" OnClick="btnCloseItm_Click" />

                                                                </td>
                                                            </tr>
                                                        </table>

                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                        <asp:Panel ID="Panel2" runat="server" BackColor="LightGray" Visible="true ">
                                            <table>
                                                <tr>
                                                    <td style="width: 950px">


                                                        <telerik:RadGrid ID="rdgItemList" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                            Height="350px" Width="900px" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="false" PageSize="10">
                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                            </HeaderContextMenu>
                                                            <PagerStyle AlwaysVisible="false" Mode="NumericPages" />
                                                            <ClientSettings>
                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                            </ClientSettings>
                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true">
                                                                <PagerStyle AlwaysVisible="false" Mode="NumericPages" />
                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                <RowIndicatorColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn>
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="RSN" HeaderText="RSN" UniqueName="RSN"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left" Width="0px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left" Width="0px"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridTemplateColumn AllowFiltering="false" ItemStyle-Width="80px" HeaderStyle-Width="80px">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="LnkEditItemMaster" runat="server" Text="Edit" ToolTip="Click here to edit the statndard menu" Font-Names="verdana" OnClick="LnkEditItemMaster_Click" ForeColor="Blue" Font-Size="Smaller"></asp:LinkButton>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <%--  <telerik:GridBoundColumn DataField="ItemCode" HeaderText="Item Code" UniqueName="ItemCode"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>--%>
                                                                    <telerik:GridBoundColumn DataField="ItemName" HeaderText="Item Name" UniqueName="ItemName"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="UOM" HeaderText="Units" UniqueName="UOM"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Type" HeaderText="Group" UniqueName="Type"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="QtyAlert" HeaderText="Qty Alert" UniqueName="QtyAlert"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Rate" HeaderText="Rate" UniqueName="Rate"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="LeadTime" HeaderText="Lead Time" UniqueName="LeadTime"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </td>

                                                    <td style="vertical-align:top">
                                                        <asp:Label ID="Label56" runat="server"  Font-Names="Verdana" Font-Size="Smaller">List of standard items that are served in breakfast, lunch or dinner or other sessions.</asp:Label><br />
                                                        <asp:Label ID="Label83" runat="server"  Font-Names="Verdana" Font-Size="Smaller">Define all the Food Items that will be served for the residents. A Food Item must be present here before it can be included in the Daily Menu. Describe the Menu Item in detail, if needed.</asp:Label>
                                                    </td>
                                                </tr>

                                            </table>
                                        </asp:Panel>
                                    
                                    </div>


                                    <div id="dvMenuforday" runat="server" style="width: 100%">

                                        <%-- <asp:LinkButton ID="lnkmenuforday" runat="server" Text="+ Add a new Menu for day" Font-Underline="false" ForeColor="Black" Font-Names="Calibri" Font-Size="Small" ToolTip="You can add a new menu items for day by clicking here." OnClick="lnkmenuforday_Click"></asp:LinkButton>--%>



                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label94" runat="Server" Text="Here you can set the Menu for a specific date and all similar days in the same month." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                                    <asp:Label ID="Label95" runat="Server" Text="If you have already set the Menu for a specific date, you can remove an item from the menu only for that day." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>


                                                    <asp:Label ID="Label34" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>

                                                    <telerik:RadDatePicker ID="dtpmenuforday" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpmenuforday_SelectedDateChanged">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="rgSessionMenuForDay" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False">


                                                        <MasterTableView NoMasterRecordsText="No Records Found." DataKeyNames="sessioncode">

                                                            <Columns>


                                                                <telerik:GridBoundColumn DataField="sessionname" HeaderText="Session" UniqueName="sessionname"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridTemplateColumn AllowFiltering="false" Visible="true" HeaderText="Status" UniqueName="Status">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LnkSessionMenuforday" runat="server" Text='<%# Eval("Status") %>' ToolTip="Click here to edit the menu for day" CommandArgument='<%# Eval("sessioncode") %>' Font-Names="verdana" ForeColor="Blue" Font-Size="Smaller" CommandName="Status" OnClick="LnkSessionMenuforday_Click"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>

                                                            </Columns>
                                                        </MasterTableView>

                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>

                                        <table>
                                            <tr>

                                                <td>

                                                    <asp:Panel ID="panNotSet" runat="server">


                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:CheckBoxList ID="chkCopyType" runat="server" OnSelectedIndexChanged="chkCopyType_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal">
                                                                        <asp:ListItem Text="Copy to same day in coming weeks" Value="1" onclick="UncheckOthers(this);"></asp:ListItem>
                                                                        <asp:ListItem Text="Copy for a date range" Value="2" onclick="UncheckOthers(this);"></asp:ListItem>
                                                                    </asp:CheckBoxList>

                                                                </td>
                                                            </tr>
                                                            <tr>

                                                                <td>
                                                                    <div id="dvWeekly" runat="server">
                                                                        <table>
                                                                            <tr>

                                                                                <td>
                                                                                    <asp:Label ID="Label93" runat="Server" Text="Copy To" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label><br />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:CheckBox ID="chkMenuforday1" runat="server" />
                                                                                    <telerik:RadDatePicker ID="dtpMenuforday1" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpmenuforday_SelectedDateChanged" Enabled="false">
                                                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                            CssClass="TextBox" Font-Names="Calibri">
                                                                                        </Calendar>
                                                                                        <DatePopupButton></DatePopupButton>
                                                                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                            ForeColor="Black" ReadOnly="true">
                                                                                        </DateInput>
                                                                                    </telerik:RadDatePicker>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:CheckBox ID="chkMenuforday2" runat="server" />
                                                                                    <telerik:RadDatePicker ID="dtpmenuforday2" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpmenuforday_SelectedDateChanged" Enabled="false">
                                                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                            CssClass="TextBox" Font-Names="Calibri">
                                                                                        </Calendar>
                                                                                        <DatePopupButton></DatePopupButton>
                                                                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                            ForeColor="Black" ReadOnly="true">
                                                                                        </DateInput>
                                                                                    </telerik:RadDatePicker>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:CheckBox ID="chkmenuforday3" runat="server" />
                                                                                    <telerik:RadDatePicker ID="dtpMenuforday3" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpmenuforday_SelectedDateChanged" Enabled="false">
                                                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                            CssClass="TextBox" Font-Names="Calibri">
                                                                                        </Calendar>
                                                                                        <DatePopupButton></DatePopupButton>
                                                                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                            ForeColor="Black" ReadOnly="true">
                                                                                        </DateInput>
                                                                                    </telerik:RadDatePicker>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:CheckBox ID="chkmenuforday4" runat="server" />
                                                                                    <telerik:RadDatePicker ID="dtpmenuforday4" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpmenuforday_SelectedDateChanged" Enabled="false">
                                                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                            CssClass="TextBox" Font-Names="Calibri">
                                                                                        </Calendar>
                                                                                        <DatePopupButton></DatePopupButton>
                                                                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                            ForeColor="Black" ReadOnly="true">
                                                                                        </DateInput>
                                                                                    </telerik:RadDatePicker>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                    <div id="dvDaily" runat="server">
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                    <asp:Label ID="Label35" runat="Server" Text="Copy From" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label><br />
                                                                                </td>
                                                                                <td>

                                                                                    <telerik:RadDatePicker ID="dtpCopyFrom" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpmenuforday_SelectedDateChanged">
                                                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                            CssClass="TextBox" Font-Names="Calibri">
                                                                                        </Calendar>
                                                                                        <DatePopupButton></DatePopupButton>
                                                                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                            ForeColor="Black" ReadOnly="true">
                                                                                        </DateInput>
                                                                                    </telerik:RadDatePicker>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="Label43" runat="Server" Text="To" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label><br />
                                                                                </td>
                                                                                <td>

                                                                                    <telerik:RadDatePicker ID="dtpCopyTo" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpmenuforday_SelectedDateChanged">
                                                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                            CssClass="TextBox" Font-Names="Calibri">
                                                                                        </Calendar>
                                                                                        <DatePopupButton></DatePopupButton>
                                                                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                            ForeColor="Black" ReadOnly="true">
                                                                                        </DateInput>
                                                                                    </telerik:RadDatePicker>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>

                                                                </td>


                                                            </tr>



                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label96" runat="Server" Text="Dates matching the same day within a month are shown." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                                                </td>
                                                            </tr>
                                                        </table>


                                                    </asp:Panel>

                                                    <asp:Panel ID="panSet" runat="server">
                                                        <table>
                                                            <tr>

                                                                <td>
                                                                    <br />

                                                                </td>

                                                                <td>
                                                                    <br />

                                                                </td>

                                                                <td>
                                                                    <br />

                                                                </td>

                                                            </tr>

                                                        </table>
                                                    </asp:Panel>


                                                </td>

                                            </tr>
                                        </table>



                                        <div>

                                            <asp:Panel ID="panLoadMenufordays" runat="server" BackColor="LightGray">

                                                <table>


                                                    <tr>

                                                        <td>

                                                            <table>
                                                                <tr>

                                                                    <td>

                                                                        <telerik:RadGrid ID="rgLoadMenuforday" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                                            Height="350px" Width="900px" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true" PageSize="10" OnItemDataBound="rgLoadMenuforday_ItemDataBound">
                                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                            </HeaderContextMenu>
                                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                            </HeaderContextMenu>
                                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" />
                                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                                                            </ClientSettings>
                                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" DataKeyNames="filterdate,sessioncode">
                                                                                <PagerStyle Mode="NumericPages" />
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn>
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn>
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>


                                                                                    <telerik:GridTemplateColumn AllowFiltering="false" ItemStyle-Width="80px" HeaderStyle-Width="80px">
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="LnkEditMenuforday" runat="server" Text="Edit" ToolTip="Click here to edit the menu for day" Font-Names="verdana" OnClick="LnkEditMenuforday_Click" ForeColor="Blue" Font-Size="Smaller"></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </telerik:GridTemplateColumn>

                                                                                    <telerik:GridBoundColumn DataField="menudate" HeaderText="Date" UniqueName="menudate"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>

                                                                                    <telerik:GridBoundColumn DataField="sessionname" HeaderText="Session" UniqueName="sessionname"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>

                                                                                    <telerik:GridBoundColumn DataField="[By]" HeaderText="By" UniqueName="[By]"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>


                                                                                </Columns>
                                                                            </MasterTableView>
                                                                        </telerik:RadGrid>


                                                                    </td>

                                                                </tr>
                                                            </table>

                                                        </td>
                                                        <td></td>

                                                    </tr>
                                                </table>


                                            </asp:Panel>


                                            <asp:Panel ID="panEditMenufordays" runat="server" BackColor="LightGray">




                                                <table>
                                                    <tr>
                                                        <td style="text-align: left">
                                                            <asp:Label ID="lblTotalDiners" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black"></asp:Label>
                                                            <asp:Label ID="lblMainItem" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black"></asp:Label>
                                                            <asp:Label ID="lblSubItem" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black"></asp:Label>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>

                                                            <table>

                                                                <tr>

                                                                    <td>

                                                                        <telerik:RadGrid ID="rgEditMenuforday" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                                            Height="350px" Width="900px" AllowSorting="true" OnItemCreated="rgMenuforday_ItemCreated" AllowMultiRowSelection="true">
                                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                            </HeaderContextMenu>
                                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                            </HeaderContextMenu>
                                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" />
                                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                            </ClientSettings>
                                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true">
                                                                                <PagerStyle Mode="NumericPages" />
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn>
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn>
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>

                                                                                <Columns>

                                                                                    <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1">
                                                                                    </telerik:GridClientSelectColumn>

                                                                                    <%--<telerik:GridTemplateColumn HeaderText="#" UniqueName="RowNumber">
                                                                        <ItemTemplate>
                                                                            <asp:Label runat="server" ID="lblRowNumber" Width="50px" Text=""></asp:Label>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>--%>

                                                                                    <telerik:GridTemplateColumn HeaderText="#" HeaderStyle-Font-Names="" UniqueName="BillFor" SortExpression="BillFor" AllowFiltering="false">
                                                                                        <ItemTemplate>
                                                                                            <asp:TextBox ID="txtRowNumber" Width="20px" runat="server" Text=""></asp:TextBox>
                                                                                        </ItemTemplate>
                                                                                    </telerik:GridTemplateColumn>


                                                                                    <telerik:GridTemplateColumn HeaderText="Item Name" HeaderStyle-Font-Names="" UniqueName="ItemName" SortExpression="ItemName" AllowFiltering="false">
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="lnkitemname" runat="server" Text='<%# Eval("ItemName") %>' ToolTip='<%# Eval("Remarks") %>'></asp:LinkButton>

                                                                                        </ItemTemplate>
                                                                                    </telerik:GridTemplateColumn>

                                                                                    <%--<telerik:GridBoundColumn DataField="ItemName" HeaderText="Item Name" UniqueName="ItemName" 
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>--%>

                                                                                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Type" HeaderText="Diabetic?" UniqueName="Type"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Is it a diabetic food? If not, shown as Regular">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="FoodType" HeaderText="Special?" UniqueName="FoodType" Display="false"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Is it a item reserved for a special day? If not, shown as Regular">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Diners" HeaderText="Diners" UniqueName="Diners"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Shows the count of estimated diners as updated via the Diners update option.">
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="UsualQty" HeaderText="ServingQty" UniqueName="UsualQty"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderTooltip="Shows the count of estimated diners as updated via the Diners update option.">
                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="UOM" HeaderText="Unit" UniqueName="UOM"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>

                                                                                    <telerik:GridBoundColumn DataField="TotalQty" HeaderText="TotalQty" UniqueName="TotalQty"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="QtyAlert" HeaderText="QtyAlert" UniqueName="QtyAlert"
                                                                                        Visible="true" Display="false" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center">
                                                                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="LeadTime" HeaderText="LeadTime" UniqueName="LeadTime"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                                                <Selecting AllowRowSelect="true"></Selecting>

                                                                            </ClientSettings>
                                                                        </telerik:RadGrid>
                                                                    </td>
                                                                    <td style="vertical-align: top">

                                                                        <asp:Button ID="btnUpdateMenuforday" runat="Server" Width="70px" Text="Update" ToolTip="Click to update the Menu for the given date and session." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnUpdateMenuforday_Click" OnClientClick="javascript:return TaskConfirmMsg2()" />
                                                                        <asp:Button ID="btnCloseMenuforday" runat="Server" Width="70px" Text="Clear" ToolTip="Click here to clear the menu details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnCloseMenuforday_Click" />
                                                                        <asp:Button ID="btnmenufordayexporttoexcel" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="btnmenufordayexporttoexcel_Click" ForeColor="White" ToolTip="Click here to export grid data to excel." />

                                                                    </td>
                                                                </tr>

                                                            </table>

                                                        </td>
                                                    </tr>
                                                </table>

                                            </asp:Panel>



                                            <asp:Panel ID="PanAddMenufordays" runat="server" BackColor="LightGray" Visible="true ">





                                                <table>
                                                    <tr>
                                                        <td style="text-align: left">
                                                            <asp:Label ID="lblATotalDiners" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black"></asp:Label>
                                                            <asp:Label ID="lblAMainItem" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black"></asp:Label>
                                                            <asp:Label ID="lblASubItem" runat="server" Text="" Font-Names="Verdana" Font-Bold="true" ForeColor="Black"></asp:Label>

                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 1300px">

                                                            <table>

                                                                <tr>

                                                                    <td>

                                                                        <telerik:RadGrid ID="rgMenuforday" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                                            Height="350px" Width="900px" AllowSorting="true" OnItemCreated="rgMenuforday_ItemCreated" OnItemDataBound="rgMenuforday_ItemDataBound" AllowMultiRowSelection="true">
                                                                            <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                            </HeaderContextMenu>
                                                                            <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                                            </HeaderContextMenu>
                                                                            <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                                            <ClientSettings>
                                                                                <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                                                <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                                            </ClientSettings>
                                                                            <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true" DataKeyNames="ItemCode">
                                                                                <PagerStyle Mode="NumericPages" />
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn>
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn>
                                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>

                                                                                <Columns>

                                                                                    <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1">
                                                                                    </telerik:GridClientSelectColumn>

                                                                                    <%--<telerik:GridTemplateColumn HeaderText="#" UniqueName="RowNumber">
                                                                        <ItemTemplate>
                                                                            <asp:Label runat="server" ID="lblRowNumber" Width="50px" Text=""></asp:Label>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>--%>

                                                                                    <telerik:GridTemplateColumn HeaderText="#" HeaderStyle-Font-Names="" UniqueName="BillFor" SortExpression="BillFor" AllowFiltering="false">
                                                                                        <ItemTemplate>
                                                                                            <asp:TextBox ID="txtRowNumber" Width="20px" runat="server" Text=""></asp:TextBox>
                                                                                        </ItemTemplate>
                                                                                    </telerik:GridTemplateColumn>

                                                                                    <telerik:GridTemplateColumn HeaderText="Item Name" HeaderStyle-Font-Names="" UniqueName="ItemName" SortExpression="ItemName" AllowFiltering="false">
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="lnkitemname" runat="server" Text='<%# Eval("ItemName") %>' ToolTip='<%# Eval("Remarks") %>'></asp:LinkButton>

                                                                                        </ItemTemplate>
                                                                                    </telerik:GridTemplateColumn>

                                                                                    <%-- <telerik:GridBoundColumn DataField="ItemName" HeaderText="Item Name" UniqueName="ItemName"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>--%>

                                                                                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>

                                                                                    <telerik:GridBoundColumn DataField="Type" HeaderText="Diabetic?" UniqueName="Type"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Is it a diabetic food? If not, shown as Regular">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="FoodType" HeaderText="Special?" UniqueName="FoodType" Display="false"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Is it a item reserved for a special day? If not, shown as Regular">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="Diners" HeaderText="Diners" UniqueName="Diners"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="UsualQty" HeaderText="ServingQty" UniqueName="UsualQty"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="UOM" HeaderText="Unit" UniqueName="UOM"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="TotalQty" HeaderText="TotalQty" UniqueName="TotalQty"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="QtyAlert" HeaderText="QtyAlert" UniqueName="QtyAlert"
                                                                                        Visible="true" Display="false" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center">
                                                                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="LeadTime" HeaderText="LeadTime" UniqueName="LeadTime"
                                                                                        Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                                    </telerik:GridBoundColumn>

                                                                                </Columns>

                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                                                <Selecting AllowRowSelect="true"></Selecting>

                                                                            </ClientSettings>
                                                                        </telerik:RadGrid>

                                                                    </td>
                                                                    <td style="vertical-align: top">

                                                                        <asp:Button ID="btnmenufordaysave" runat="Server" Width="100px" Text="Set the Menu" ToolTip=" Click to Save the Menu for the given date and session." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnmenufordaysave_Click" OnClientClick="javascript:return TaskConfirmMsg()" />
                                                                        <asp:Button ID="btnmenufordayclear" runat="Server" Width="70px" Text="Clear" ToolTip="Click here to clear the menu details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnmenufordayclear_Click" />
                                                                        <asp:Button ID="btnmenufordayclose" runat="Server" Width="70px" Text="Close" ToolTip="Click here to close the add new menu for day" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnmenufordayclose_Click" Visible="false" />

                                                                    </td>

                                                                </tr>

                                                            </table>

                                                        </td>
                                                    </tr>

                                                </table>
                                            </asp:Panel>



                                        </div>

                                    </div>


                                    <div id="dvHelp" runat="server" style="width: 100%">
                                        <table>
                                            <tr style="height: 5px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblHelp" runat="server" Font-Names="Calibri" Font-Size="20px" Text="Kitchen Planner" Font-Underline="true" ForeColor="Gray"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 5px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" runat="server" Font-Names="Calibri" Font-Size="14px" Text="The Kitchen Planner helps in proper advance planning at the Kitchen. " ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label8" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Save money.  Avoid wastage. Ensure the residents have always a good word for the food served.  Avoid frequent repetitions of the same menu. Have better inventory control and avoid last minute purchases at higher costs. " ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label13" runat="server" Font-Names="Calibri" Font-Size="14px" Text="The Kitchen Planner is beneficial to all – the Management, The Kitchen Chefs, The Store Keepers and above all the residents." ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 5px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label14" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Font-Bold="true" Text="Menu Item Master"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label15" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="Here you define the names of the food items that are served in the daily Menu, for the residents. It is very important to define a menu item first before it can be added in a daily menu."></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label16" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Benefits of Kitchen Planner:  Helps in advance planning. Saves Cost. Reduces wastage. Frequent repetitions avoided. Better inventory control and therefore no last minute purchases at higher cost. Improved service levels." ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 5px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label17" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Font-Bold="true" Text="Standard Menu"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label18" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="To avoid worrying about what to cook for tomorrow, one can set a standard menu for each day of the week. Here you add a menu item and define which days of the week you are planning to serve it.  Example:  Idlies only on Monday, Wednesday and Friday for breakfast."></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label19" runat="server" Font-Names="Calibri" Font-Size="14px" Text="If a Menu Item is special and reserved only for a special day (Ex: Diwali day breakfast) it can be defined so." ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label20" runat="server" Font-Names="Calibri" Font-Size="14px" Text="The average quantity per menu item per person, when set here,  lets one estimate the total quantity to be prepared later. " ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 5px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label21" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Font-Bold="true" Text="Day planner"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label22" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="The planner for a day lets you mention how many persons are estimated to dine on a day. If it is a special day (Ex: Diwali or Independence day) mention this as well. The Menu for the day can be set up only after doing the initial planning.  By estimating how many people may arrive for breakfast, the quantity of each item to be cooked can be estimated."></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 5px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label23" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="Every Monday comes and goes. But some Mondays may be special. May be it is a resident’s birthday or may be it is Diwali day. Naturally apart from the regular menu, one may like to add some special item for the special day."></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label24" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="You can also set a message for the special day so that everyone knows about it.  (Displayed as a scroll message in the Sign In Screen). If one or more residents are celebrating their birthday on the day, the day planner knows about it and prompts you. "></asp:Label>
                                                </td>
                                            </tr>
                                            <tr style="height: 5px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label25" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Font-Bold="true" Text="Daily Menu"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label26" runat="server" Font-Names="Calibri" Font-Size="14px" ForeColor="Black" Text="Here one sets the  Menu for different sessions on a particular day and which is to be used by the Kitchen."></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label27" runat="server" Font-Names="Calibri" Font-Size="14px" Text="The Daily Menu is prepared by referring to the Standard Menu for the day and the Day Planner. " ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label28" runat="server" Font-Names="Calibri" Font-Size="14px" Text="One can remove a Menu Item suggested from the Standard Menu." ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label29" runat="server" Font-Names="Calibri" Font-Size="14px" Text="This Menu can be prepared upto three days in advance." ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label30" runat="server" Font-Names="Calibri" Font-Size="14px" Text="Also shown is the estimated quantity to be prepared, as a guideline for the kitchen." ForeColor="Black"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>


                                    <div id="dvDinersUpdates" runat="server" style="100%">


                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label47" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtpDiners" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date for which you wish to view the Diners Count." AutoPostBack="true" OnSelectedDateChanged="dtpDMDate_Changed">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                    <asp:Label ID="Label48" runat="Server" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label49" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlDinersSession" ToolTip="Select the session for which you wish to view the Diners Count.  The session may be Closed or Open or Yet to Open. The colours indicate the status." Width="100px" Height="25px" runat="server" AutoPostBack="true"
                                                        Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlDinersSession_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <div id="dvDinersUpdate" runat="server">
                                                        <table>
                                                            <tr>
                                                                <%--<td>
                                                                <asp:CheckBox ID="chkAll" runat="server" Text="All" OnCheckedChanged="chkAll_CheckedChanged" AutoPostBack="true" />
                                                            </td>
                                                            <td style="text-align: center">
                                                                <asp:CheckBox ID="chkByDoorNo" runat="server" Text="By DoorNo" OnCheckedChanged="chkByDoorNo_CheckedChanged" AutoPostBack="true" /><br />
                                                                <asp:DropDownList ID="ddlByDoorNo" ToolTip="If you wish to update for a specific resident, select the House Number here." Width="150px" Height="25px" runat="server" AutoPostBack="true"
                                                                    Font-Names="Calibri" Font-Size="Small">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td style="text-align: center">
                                                                <asp:CheckBox ID="chkByName" runat="server" Text="By Name" OnCheckedChanged="chkByName_CheckedChanged" AutoPostBack="true" /><br />
                                                                <asp:DropDownList ID="ddlByName" ToolTip=" If you wish to update for a specific resident, select the name here." Width="150px" Height="25px" runat="server" AutoPostBack="true"
                                                                    Font-Names="Calibri" Font-Size="Small">
                                                                </asp:DropDownList>
                                                            </td>--%>
                                                                <td>
                                                                    <telerik:RadAutoCompleteBox ID="racResidentSearch" Font-Names="verdana" Width="300px" DropDownWidth="240px" Skin="Defult" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource2" runat="server" DataTextField="Customer" DataValueField="RTRSN" InputType="Text" MinFilterLength="1"
                                                                        EmptyMessage="Choose ResidentID / DoorNo / Name " ToolTip="Choose the ResidentID / DoorNo / Name to view the customer details" AutoPostBack="true" TextSettings-SelectionMode="Single">
                                                                        <TextSettings SelectionMode="Single" />
                                                                    </telerik:RadAutoCompleteBox>
                                                                    <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select convert(nvarchar(10),RTRSN) +', '+ RTVILLANO +', '+ RTName + ', ' + convert(nvarchar(10),RTRSN) as Customer,RTRSN from tblresident order by RTName asc"></asp:SqlDataSource>
                                                                </td>
                                                                <td>
                                                                    <asp:Button ID="btnDinersGO" runat="Server" Width="70px" Text="GO" ToolTip="Click here to load  the diners details." ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Medium" OnClick="btnDinersGO_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnDinersSave" runat="Server" Width="70px" Text="Save" ToolTip="Click here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnDinersSave_Click" OnClientClick="javascript:return TaskConfirmMsg()" />

                                                    <asp:Button ID="btnDinersClose" runat="Server" Width="70px" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnDinersClose_Click" />
                                                    <asp:Button ID="btnDinersHelp" runat="Server" Width="70px" Text="Help" ToolTip="Click here to shows help." ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Medium" OnClick="btnDinersHelp_Click" />
                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnDinersExporttoExcel" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Import" OnClick="btnDinersExporttoExcel_Click" ForeColor="White" ToolTip="This option available in live." />
                                                </td>

                                            </tr>
                                        </table>


                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblsessionandtime" runat="server" Text="" Font-Bold="true"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblallow" runat="server" Text="" Font-Bold="true"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Summary" runat="server" Text="Diners Summary" Font-Bold="true" Font-Underline="true"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="rgDinersTotal" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                        Height="100px" Width="500px" AllowSorting="true" AllowMultiRowSelection="true">
                                                        <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true" />
                                                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true">
                                                            <PagerStyle Mode="NumericPages" />
                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                            <RowIndicatorColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </RowIndicatorColumn>
                                                            <ExpandCollapseColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </ExpandCollapseColumn>

                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="Type" HeaderText="" UniqueName="Type" Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">

                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Regular" HeaderText="Resident" UniqueName="Regular"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Casual" HeaderText="Casual" UniqueName="Casual"
                                                                    Visible="false" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Guest" HeaderText="Guest" UniqueName="Guest"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="HomeService" HeaderText="HomeService" UniqueName="HomeService"
                                                                    Visible="false" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Total" HeaderText="Total" UniqueName="Total"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>



                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                            <Selecting AllowRowSelect="true"></Selecting>

                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </td>
                                                <td>
                                                    <telerik:RadGrid ID="rgDinersRate" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                        Height="100px" Width="500px" AllowSorting="true" AllowMultiRowSelection="true">
                                                        <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true" />
                                                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true">
                                                            <PagerStyle Mode="NumericPages" />
                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                            <RowIndicatorColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </RowIndicatorColumn>
                                                            <ExpandCollapseColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </ExpandCollapseColumn>

                                                            <Columns>
                                                                <telerik:GridBoundColumn DataField="SessionName" HeaderText="Rate" UniqueName="SessionName" Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">

                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Regular" HeaderText="Resident" UniqueName="Rugular"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Casual" HeaderText="Casual" UniqueName="Casual"
                                                                    Visible="false" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Guest" HeaderText="Guest" UniqueName="Guest"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="HomeService" HeaderText="HomeService" UniqueName="HomeService"
                                                                    Visible="false" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>





                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                            <Selecting AllowRowSelect="true"></Selecting>

                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>

                                        <table>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label ID="lblmenubasedmsg" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:LinkButton ID="lnkviewall" runat="server" Text="" OnClick="lnkviewall_Click"></asp:LinkButton>
                                                </td>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label65" runat="server" Text="Resident Booking" Font-Names="vedana"></asp:Label><br />
                                                                <asp:DropDownList ID="ddlRegular" ToolTip="" Width="150px" Height="25px" runat="server" AutoPostBack="true"
                                                                    Font-Names="Calibri" Font-Size="Small">
                                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label66" runat="server" Text="Resident Actual" Font-Names="vedana"></asp:Label><br />
                                                                <asp:DropDownList ID="ddlRegularA" ToolTip="" Width="150px" Height="25px" runat="server" AutoPostBack="true"
                                                                    Font-Names="Calibri" Font-Size="Small">
                                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label67" runat="server" Text="Guest Booking" Font-Names="vedana"></asp:Label><br />
                                                                <asp:DropDownList ID="ddlGuest" ToolTip="" Width="150px" Height="25px" runat="server" AutoPostBack="true"
                                                                    Font-Names="Calibri" Font-Size="Small">
                                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label68" runat="server" Text="Guest Actual" Font-Names="vedana"></asp:Label><br />
                                                                <asp:DropDownList ID="ddlGuestA" ToolTip="" Width="150px" Height="25px" runat="server" AutoPostBack="true"
                                                                    Font-Names="Calibri" Font-Size="Small">
                                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <br />
                                                                <asp:Button ID="btnDinersUpdate" runat="Server" Width="70px" Text="Update" ToolTip="Click here to Update the details" ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnDinersUpdate_Click" OnClientClick="javascript:return TaskConfirmMsgET()" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>

                                        <table>

                                            <tr>
                                                <td>

                                                    <%--<asp:LinkButton ID="lnkmsg" runat="server"></asp:LinkButton><br />--%>

                                                    <telerik:RadGrid ID="rgDiners" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                        Height="350px" Width="900px" AllowSorting="true" AllowMultiRowSelection="true" OnItemDataBound="rgDiners_ItemDataBound">
                                                        <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="true" />
                                                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true" DataKeyNames="RSN,RTRSN">
                                                            <PagerStyle Mode="NumericPages" />
                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                            <RowIndicatorColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </RowIndicatorColumn>
                                                            <ExpandCollapseColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </ExpandCollapseColumn>

                                                            <Columns>

                                                                <%--<telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1">
                                                                    </telerik:GridClientSelectColumn>--%>

                                                                <%--<telerik:GridTemplateColumn HeaderText="#" UniqueName="RowNumber">
                                                                        <ItemTemplate>
                                                                            <asp:Label runat="server" ID="lblRowNumber" Width="50px" Text=""></asp:Label>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>--%>



                                                                <telerik:GridBoundColumn DataField="DoorNo" HeaderText="DoorNo" UniqueName="DoorNo"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="Name" HeaderText="Name" UniqueName="Name"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridTemplateColumn HeaderText="Regular" HeaderTooltip="How many for the session" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="Booked" SortExpression="Booked" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtBooked" Width="30px" Height="30px" Style="text-align: center" ForeColor="DarkGreen" Font-Bold="true" Font-Size="Medium" runat="server" Text='<%# Eval("RegularB") %>'></asp:TextBox>

                                                                        <%-- <telerik:RadNumericTextBox ID="txtBooked" runat="server" DisplayText='<%# Eval("RegularB") %>'></telerik:RadNumericTextBox>--%>
                                                                    </ItemTemplate>

                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="R.Actual" HeaderStyle-ForeColor="Black" HeaderTooltip="How many actually dined. Click on the Check Box above to copy the Booked Count to Actual Count, saving time." HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="Actual" SortExpression="Actual" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtActual" Width="30px" HHeight="30px" Style="text-align: center" ForeColor="DarkGreen" Font-Size="Medium" Font-Bold="true" runat="server" Text='<%# Eval("RegularA") %>' AutoPostBack="true" OnTextChanged="txtActual_TextChanged"></asp:TextBox>

                                                                    </ItemTemplate>

                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="Casual" Visible="false" HeaderTooltip="How many for the session" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="CasualB" SortExpression="CasualB" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtCasualBooked" Width="30px" Height="30px" Style="text-align: center" Font-Size="Medium" ForeColor="DarkGreen" Font-Bold="true" runat="server" Text='<%# Eval("CasualB") %>'></asp:TextBox>
                                                                    </ItemTemplate>

                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="C.Actual" Visible="false" HeaderStyle-ForeColor="Black" HeaderTooltip="How many actually dined. Click on the Check Box above to copy the Booked Count to Actual Count, saving time." HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="CasualA" SortExpression="CasualA" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtCasualActual" Width="30px" Height="30px" Style="text-align: center" Font-Size="Medium" ForeColor="DarkGreen" Font-Bold="true" runat="server" Text='<%# Eval("CasualA") %>' AutoPostBack="true" OnTextChanged="txtActual_TextChanged"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn HeaderText="Guests" HeaderTooltip="How many guests expected?" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="GuestBooked" SortExpression="GuestBooked" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtGuestBooked" Width="30px" Height="30px" Style="text-align: center" Font-Size="Medium" ForeColor="DarkGreen" Font-Bold="true" runat="server" Text='<%# Eval("GuestB") %>'></asp:TextBox>
                                                                    </ItemTemplate>

                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="G.Actual" HeaderStyle-ForeColor="Black" HeaderTooltip="How many guests actually dined?" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="GuestActual" SortExpression="GuestActual" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtGuestActual" Width="30px" Height="30px" Style="text-align: center" Font-Size="Medium" ForeColor="DarkGreen" Font-Bold="true" runat="server" Text='<%# Eval("GuestA") %>' AutoPostBack="true" OnTextChanged="txtGuestActual_TextChanged"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="H.S.Booked" Visible="false" HeaderTooltip="Does the resident require the food to be delivered at home?" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="HSBooked" SortExpression="HSBooked" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtHSBooked" Width="30px" Height="30px" Style="text-align: center" runat="server" Font-Size="Medium" ForeColor="DarkGreen" Font-Bold="true" Text='<%# Eval("HomeServiceB") %>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="H.S.Actual" Visible="false" HeaderTooltip=" Did the Home service actually happen." HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="HSActual" SortExpression="HSActual" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtHSActual" Width="30px" Height="30px" Style="text-align: center" runat="server" Font-Size="Medium" ForeColor="DarkGreen" Font-Bold="true" Text='<%# Eval("HomeServiceA") %>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="Total" HeaderTooltip="Booked + Guests" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="Total" SortExpression="Total" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtTotal" Width="30px" Height="30px" Style="text-align: center" ForeColor="DarkGreen" Font-Size="Medium" Font-Bold="true" runat="server" Text='<%# Eval("TotalB") %>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderText="T.Actual" HeaderStyle-ForeColor="Black" HeaderTooltip="Actual + GuestsDined" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="TotalActual" SortExpression="TotalActual" AllowFiltering="false">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtTotalActual" Width="30px" Height="30px" Style="text-align: center" Font-Size="Medium" ForeColor="DarkGreen" Font-Bold="true" runat="server" Text='<%# Eval("TotalA") %>'></asp:TextBox>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>

                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                            <Selecting AllowRowSelect="true"></Selecting>

                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>


                                  
                                      <div id="dvDiningTransaction" runat="server" style="width: 100%">

                                        <table style="width: 100%">
                                            <tr>
                                                <%--<td>
                                                    <asp:Label ID="Label52" runat="server" Font-Names="verdana" Font-Size="Small" Text="Name" ForeColor="DarkGray"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlTName" ToolTip="" Width="100px" Height="25px" runat="server" Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlTName_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label53" runat="server" Font-Names="verdana" Font-Size="Small" Text="Door No" ForeColor="DarkGray"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlTDoorNo" ToolTip="" Width="100px" Height="25px" runat="server" Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlTDoorNo_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </td>
                                                --%>
                                                <td>
                                                    <br />
                                                    <telerik:RadComboBox ID="cmbFTResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                                                                        Width="350px" ToolTip="" 
                                                                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                                                                    </telerik:RadComboBox>

                                                </td>
                                                
                                                <td>
                                                    <asp:Label ID="Label54" runat="server" Font-Names="verdana" Font-Size="Small" Text="Session" ForeColor="DarkGray"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlTSession" ToolTip="" Width="100px" Height="25px" runat="server" Font-Names="Calibri" Font-Size="Small">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label55" runat="server" Font-Names="verdana" Font-Size="Small" Text="Billing Month" ForeColor="DarkGray"></asp:Label><br />
                                                    <asp:DropDownList ID="ddlBillingMonth" ToolTip="" Width="100px" Height="25px" runat="server" Font-Names="Calibri" Font-Size="Small">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <br />
                                                    <asp:Button ID="btnTOK" runat="Server" Width="70px" Text="GO" ToolTip="" ForeColor="White" BackColor="DarkBlue " Font-Names="Calibri" Font-Size="Medium" OnClick="btnTOK_Click" />
                                                </td>
                                                <td>
                                                    <br />
                                                    <asp:Button ID="BbtnTClear" runat="Server" Width="70px" Text="Clear" ToolTip=" Click here to clear the selected dining transactions details." ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="BbtnTClear_Click" />
                                                </td>
                                                <td>
                                                    <br />
                                                    <asp:Button ID="btnDTHelp" runat="server" Text="Help?" BackColor="DarkGreen" ForeColor="White" Width="70px" OnClick="btnDTHelp_Click" ToolTip="Click here to show help of dining transactions" />
                                                </td>
                                                <td>
                                                    <br />
                                                    <asp:Label ID="lblCount" runat="server" Font-Names="verdana" Font-Size="Small" Font-Bold="true" Text="" ForeColor="DarkGreen"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    
                                                    <telerik:RadGrid ID="rgFoodTransaction" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                        Height="350px" Width="85%" AllowSorting="true"  CellSpacing="5" ShowFooter="true" AllowPaging="true" PageSize="10"  OnItemDataBound="rgFoodTransaction_ItemDataBound"
                                                        MasterTableView-HierarchyDefaultExpanded="true" OnItemCommand="rgFoodTransaction_ItemCommand">

                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                        <ClientSettings>
                                                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true">
                                                            <PagerStyle Mode="NumericPages" />
                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                            <RowIndicatorColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </RowIndicatorColumn>
                                                            <ExpandCollapseColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </ExpandCollapseColumn>

                                                            <ColumnGroups>
                                                                <telerik:GridColumnGroup HeaderText="Regular" Name="Regular" HeaderStyle-HorizontalAlign="Center">
                                                                </telerik:GridColumnGroup>
                                                                <telerik:GridColumnGroup HeaderText="Casual" Name="Casual" HeaderStyle-HorizontalAlign="Center">
                                                                </telerik:GridColumnGroup>
                                                                <telerik:GridColumnGroup HeaderText="Guest" Name="Guest" HeaderStyle-HorizontalAlign="Center">
                                                                </telerik:GridColumnGroup>
                                                                <telerik:GridColumnGroup HeaderText="HomeService" Name="HomeService" HeaderStyle-HorizontalAlign="Center">
                                                                </telerik:GridColumnGroup>
                                                            </ColumnGroups>

                                                            <Columns>


                                                                <telerik:GridBoundColumn DataField="Date" HeaderText="Date" UniqueName="Date"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                                <telerik:GridBoundColumn DataField="SessionName" HeaderText="Session" UniqueName="SessionName"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="RCount" HeaderText="Count" UniqueName="RCount" ColumnGroupName="Regular"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Aggregate="Sum" FooterText="R:" FooterStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="RegularAmount" HeaderText="Amount" UniqueName="RegularAmount" ColumnGroupName="Regular"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterText="R:" FooterStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="CCount" HeaderText="Count" UniqueName="CCount" ColumnGroupName="Casual"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Aggregate="Sum" FooterText="C:" FooterStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="CasualAmount" HeaderText="Amount" UniqueName="CasualAmount" ColumnGroupName="Casual"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterText="C:" FooterStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="GCount" HeaderText="Count" UniqueName="GCount" ColumnGroupName="Guest"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Aggregate="Sum" FooterText="G:" FooterStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="GuestAmount" HeaderText="Amount" UniqueName="GuestAmount" ColumnGroupName="Guest"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterText="G:" FooterStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="HCount" HeaderText="Count" UniqueName="HCount" ColumnGroupName="HomeService"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center" Aggregate="Sum" FooterText="H:" FooterStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="HSAmount" HeaderText="Amount" UniqueName="HSAmount" ColumnGroupName="HomeService"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterText="H:" FooterStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="TotalAmount" HeaderText="Total Amount" UniqueName="TotalAmount"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" Aggregate="Sum" FooterText="T:" FooterStyle-HorizontalAlign="Right">
                                                                    <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>


                                                            </Columns>

                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                            <Selecting AllowRowSelect="true"></Selecting>

                                                        </ClientSettings>
                                                    </telerik:RadGrid>

                                                </td>
                                            </tr>
                                        </table>
                                    </div>


                                    <div id="dvBookingAlacartemenu" runat="server" style="width: 100%">

                                        <table>

                                            <tr>
                                                <td style="width: 50%">

                                                    <table>

                                                        <tr>
                                                            <td>

                                                                <table>

                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label59" runat="server" Text="For which Resident?Search by" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <%--<telerik:RadAutoCompleteBox ID="DdlUhid" Font-Names="verdana" Width="350px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource1" runat="server" DataTextField="Customer" DataValueField="RTRSN" InputType="Text" MinFilterLength="1"
                                                                                EmptyMessage="Choose ResidentID / DoorNo / Name " ToolTip="Choose the ResidentID / DoorNo / Name to view the customer details" OnEntryAdded="DdlUhid_EntryAdded" AutoPostBack="true" TextSettings-SelectionMode="Single">
                                                                                <TextSettings SelectionMode="Single" />
                                                                            </telerik:RadAutoCompleteBox>
                                                                            
                                                                            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select convert(nvarchar(10),RTRSN) +', '+ RTVILLANO +', '+ RTName + ', ' + convert(nvarchar(10),RTRSN) as Customer,RTRSN from tblresident order by RTName asc"></asp:SqlDataSource>--%>

                                                                            <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                                                                        Width="350px" ToolTip="" 
                                                                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                                                                    </telerik:RadComboBox>



                                                                        </td>
                                                                        <td>
                                                                            <%--<asp:Button ID="btnSearch" runat="server" Text="Search" BackColor="DarkBlue" ForeColor="White" ToolTip="This will be inactive if there is some value in the grid.  Press Clear All, to abort all work and start again." CssClass="Button" OnClick="btnSearch_Click" />--%>
                                                                            <asp:Button ID="btnMenuItems" runat="server" BackColor="DarkGreen" ForeColor="White" Text="Menu Card" ToolTip="Click here to view all outstanding bills of the resident." CssClass="Button" OnClick="btnMenuItems_Click" />
                                                                            <br />
                                                                            <br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <div style="border: 1px thin maroon;">
                                                                                <asp:Label ID="lblDiscount" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
                                                                                <asp:Label ID="lblBMName" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon"></asp:Label>
                                                                                <asp:Label ID="lblBMDoorNo" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon"></asp:Label>
                                                                                <asp:Label ID="lblBMMobileNo" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon"></asp:Label>
                                                                                <asp:Label ID="lblBMEamil" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon"></asp:Label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>

                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>

                                                                <table>
                                                                   <%-- <tr>
                                                                        <td colspan="2">
                                                                            <asp:Label ID="Label57" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                            <asp:DropDownList ID="ddlBMSession" ToolTip="Select the session" Width="100px" Height="25px" runat="server" AutoPostBack="true"
                                                                                Font-Names="Calibri" Font-Size="Small">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:RadioButton ID="rdospecificdate" Text="Is it for a specific date?" runat="server" AutoPostBack="true" OnCheckedChanged="rdospecificdate_CheckedChanged" />
                                                                            <asp:RadioButton ID="rdodaterange" Text="Is it for a date range?" runat="server" AutoPostBack="true" OnCheckedChanged="rdodaterange_CheckedChanged" />
                                                                        </td>
                                                                    </tr>--%>
                                                                    <tr>

                                                                        <td>
                                                                            <asp:Label ID="lblfordate" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                            <telerik:RadDatePicker ID="dtpfordate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                                Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date in the future, for which you wish to do the booking. " AutoPostBack="true" OnSelectedDateChanged="dtpfordate_SelectedDateChanged">
                                                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                    CssClass="TextBox" Font-Names="Calibri">
                                                                                </Calendar>
                                                                                <DatePopupButton></DatePopupButton>
                                                                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                    ForeColor="Black" ReadOnly="true">
                                                                                </DateInput>
                                                                            </telerik:RadDatePicker>
                                                                        </td>

                                                                       <%-- <td>
                                                                            <asp:Label ID="lbluntildate" runat="Server" Text="Until Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                                                            <telerik:RadDatePicker ID="dtpuntildate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                                Width="150px" CssClass="TextBox" ReadOnly="true" ToolTip="Select the date upto which you wish to do the booking." AutoPostBack="true" OnSelectedDateChanged="dtpuntildate_SelectedDateChanged">
                                                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                    CssClass="TextBox" Font-Names="Calibri">
                                                                                </Calendar>
                                                                                <DatePopupButton></DatePopupButton>
                                                                                <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                    ForeColor="Black" ReadOnly="true">
                                                                                </DateInput>
                                                                            </telerik:RadDatePicker>
                                                                        </td>--%>


                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table>
                                                                   <%-- <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label69" runat="Server" Text="No of days" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtNoofdays" runat="Server" MaxLength="12" ToolTip="Total No of days, Auto Calculated." Width="150px" Height="25px" Enabled="false" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                        </td>
                                                                    </tr>--%>

                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label60" runat="Server" Text="Menu Item" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlItemName" ToolTip="Select the menu item available for this session." Width="100px" Height="25px" runat="server" AutoPostBack="true"
                                                                                Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlItemName_SelectedIndexChanged">
                                                                            </asp:DropDownList>
                                                                            <asp:Label ID="lblcontains" runat="Server" Text="" Enabled="false" ForeColor="DarkBlue" Font-Names="Calibri" Font-Size="X-Small" BackColor="Yellow"></asp:Label>

                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label61" runat="Server" Text="Rate" Enabled="false" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                        </td>

                                                                        <td>
                                                                            <asp:TextBox ID="txtBMRate" runat="Server" MaxLength="12" ToolTip="The Rate for the menu item set earlier." Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                            <asp:Label ID="lbloriginalrate" runat="Server" Text="" ForeColor="DarkBlue" BackColor="Yellow" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label62" runat="Server" Text="No. of persons" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                        </td>
                                                                        <td>

                                                                            <asp:DropDownList ID="ddlnoofpersons" ToolTip="How many diners?(Residents and Guests).Shows the count of residents in the same doorno, By default." Width="100px" Height="25px" runat="server" AutoPostBack="true"
                                                                                Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlBMQuantiry_SelectedIndexChanged">
                                                                                <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                                                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                                <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                                                <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                                                <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                                                <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                                                <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label63" runat="Server" Text="Quantity/Person" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <%-- <asp:TextBox ID="txtBMQuantity" runat="Server" MaxLength="12" ToolTip="How much to order per person?" Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" AutoPostBack="true" OnTextChanged="txtBMQuantity_TextChanged"></asp:TextBox>--%>
                                                                            <asp:DropDownList ID="ddlBMQuantiry" ToolTip="How many diners?(Residents and Guests).Shows the count of residents in the same doorno, By default." Width="100px" Height="25px" runat="server" AutoPostBack="true"
                                                                                Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlBMQuantiry_SelectedIndexChanged">
                                                                                <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                                                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                                                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                                                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                                                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                                                <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                                                                <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                                                                <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                                                                <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                                                                <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                                                            </asp:DropDownList>


                                                                            <asp:Label ID="lblunit" runat="Server" Text="" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label92" runat="Server" Text="Total Qty" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtBMTotQty" runat="Server" MaxLength="12" ToolTip="How much quantity of food to be eat." Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>

                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label64" runat="Server" Text="Amount to pay" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtBMAmounttopay" Enabled="false" runat="Server" MaxLength="12" ToolTip="(Rate * No of persons * Quantity * No of days) " Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>

                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" align="center">
                                                                            <asp:Button ID="btnSubmit" runat="Server" Width="70px" Text="Add" ToolTip=" Have you chosen the right Menu Item and Quantity.   Have you checked the amount to pay. If so, click here to add the item to the order list." ForeColor="White" BackColor="DarkBlue" Font-Names="Calibri" Font-Size="Medium" OnClick="btnSubmit_Click" OnClientClick="javascript:return TaskConfirmMsg()" />
                                                                            <asp:Button ID="btnClearAll" runat="Server" Width="70px" Text="Clear All" ToolTip=" If you wish to abort all you have done so far, without preparing the Bill, click this button." ForeColor="White" BackColor="Orange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnClearAll_Click" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <telerik:RadGrid ID="rgBookingameal" AutoGenerateColumns="false" runat="server" OnNeedDataSource="rgBookingameal_NeedDataSource" OnItemCommand="rgBookingameal_ItemCommand">
                                                                                <MasterTableView>
                                                                                    <Columns>
                                                                                        <%--<telerik:GridTemplateColumn UniqueName="TemplateColumn1">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkEdit" CommandName="Edit" runat="server" Text="Edit"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>--%>
                                                                                        <telerik:GridTemplateColumn UniqueName="ItemCode" HeaderText="ItemCode" Visible="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblItemCode" runat="server" Text='<%#Eval("ItemCode") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn UniqueName="ItemName" HeaderText="Item">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblItemName" runat="server" Text='<%#Eval("ItemName") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn UniqueName="Rate" HeaderText="Rate">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblRate" runat="server" Text='<%#Eval("Rate") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn UniqueName="Person" HeaderText="Ct.">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblRate" runat="server" Text='<%#Eval("Persons") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn UniqueName="Qty" HeaderText="Tot.Qty">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblQty" runat="server" Text='<%#Eval("Qty") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn UniqueName="Unit" HeaderText="Unit">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblQty" runat="server" Text='<%#Eval("Unit") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn UniqueName="AmounttoPay" HeaderText="Amount">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblAmounttoPay" runat="server" Text='<%#Eval("AmounttoPay") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                      <%--  <telerik:GridTemplateColumn UniqueName="SessionCode" HeaderText="SessionCode" Visible="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblSessionCode" runat="server" Text='<%#Eval("SessionCode") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>--%>
                                                                                        <telerik:GridTemplateColumn UniqueName="From" HeaderText="From">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblFrom" runat="server" Text='<%#Eval("From") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>
                                                                                        <telerik:GridTemplateColumn UniqueName="To" HeaderText="To">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblTo" runat="server" Text='<%#Eval("To") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>

                                                                                      <%--  <telerik:GridTemplateColumn UniqueName="Session" HeaderText="Session">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblSession" runat="server" Text='<%#Eval("Session") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>--%>

                                                                                    </Columns>
                                                                                </MasterTableView>
                                                                            </telerik:RadGrid>
                                                                        </td>

                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>

                                                    </table>

                                                </td>

                                                <td style="width: 50%">
                                                    <table>
                                                        <tr>
                                                            <td style="vertical-align: top">
                                                                <table>
                                                                    <tr>
                                                                        <asp:Button ID="btnPreparetobill" runat="Server" Width="100px" Text="Save" ToolTip="Click here if the payment will be collected later." ForeColor="White" BackColor="DarkBlue" Font-Names="Calibri" Font-Size="Medium" OnClick="btnPreparetobill_Click" OnClientClick="javascript:return ConfirmPreparetobill()" Visible="false" />
                                                                        <%--<asp:Button ID="btnpaynow" runat="Server" Width="100px" Text="Pay Now" ToolTip="Click here if the payment will be collected now." ForeColor="White" BackColor="DarkBlue" Font-Names="Calibri" Font-Size="Medium" OnClick="btnpaynow_Click" OnClientClick="javascript:return ConfirmPreparetobill()"  Visible="false"/>--%>
                                                                        <asp:Button ID="btnOutstandingBills" runat="server" BackColor="DarkGreen" ForeColor="White" Text="Outstanding Bills" ToolTip="Click here to view all outstanding bills of the resident." CssClass="Button" OnClick="btnOutstandingBills_Click" />
                                                                        <asp:Label ID="lblOutstanding" runat="server" Text="" Font-Names="vedana" ForeColor="DarkGray"></asp:Label>
                                                                    </tr>

                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label70" runat="server" Text="Welcome to A la Carte Billing!" Font-Names="vedana"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label71" runat="server" Text="Enter here the orders for various items in the A la Carte menu." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label72" runat="server" Text="Select the name of the resident who is placing an order." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label73" runat="server" Text="Select the session (Breakfast or Lunch or Dinner) ." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                    <%--<tr>
                                                                        <td>
                                                                            <asp:Label ID="Label74" runat="server" Text="One can book for a specific day (Ex: Dosa for Dinner on 25th March)  or for a range of dates (Ex: Meals during lunch for the entire month of March)" Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>--%>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label75" runat="server" Text="Only those menu items set for the session, are visible." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label76" runat="server" Text="Enter the count of persons and quantity per person." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label77" runat="server" Text="The total amount to pay is calculated." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label78" runat="server" Text="Continue the ordering process for the same person until it is done in full." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                    <%--<tr>
                                                                        <td>
                                                                            <asp:Label ID="Label79" runat="server" Text="Ex: The same resident can order for Roti and Dhall for Dinner on all days during a month.When done,  press the Prepare Bill button." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>--%>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label80" runat="server" Text="The Menu items are added to the resident’s order book." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label81" runat="server" Text="The total amount to be paid by the resident, is added to the Unbilled transactions list." Font-Names="vedana"></asp:Label><br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label82" runat="server" Text="One can either accept payment immediately or later as part of the month end billing." Font-Names="vedana"></asp:Label>
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


                                    <div id="dvAcceptPayment" runat="server" style="width: 100%">


                                        <table>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label ID="Label84" runat="server" Text="For which customer?Search by" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadAutoCompleteBox ID="racAPResident" Font-Names="verdana" Width="350px" DropDownWidth="240px" Skin="Default" Font-Size="13px" MaxResultCount="10" DataSourceID="SqlDataSource2" runat="server" DataTextField="Customer" DataValueField="RTRSN" InputType="Text" MinFilterLength="1"
                                                        EmptyMessage="Choose ResidentID / DoorNo / Name " ToolTip="Choose the ResidentID / DoorNo / Name to view the customer details" OnEntryAdded="DdlUhid_EntryAdded" AutoPostBack="true" TextSettings-SelectionMode="Single">
                                                        <TextSettings SelectionMode="Single" />
                                                    </telerik:RadAutoCompleteBox>
                                                    <asp:LinkButton ID="lnkprofile" runat="server" Text="Profile++" OnClick="lnkprofile_Click" Font-Names="verdana" Font-Bold="true"></asp:LinkButton>
                                                    <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:CovaiSoft %>' SelectCommand="select convert(nvarchar(10),RTRSN) +', '+ RTVILLANO +', '+ RTName + ', ' + convert(nvarchar(10),RTRSN) as Customer,RTRSN from tblresident order by RTName asc"></asp:SqlDataSource>



                                                </td>
                                                <td>
                                                    <asp:Button ID="btnAPSearch" runat="server" Text="Search" ToolTip="This will be inactive if there is some value in the grid.  Press Clear All, to abort all work and start again." CssClass="Button" OnClick="btnAPSearch_Click" />
                                                    <br />
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <div style="border: 1px thin maroon;">
                                                        <asp:Label ID="lblName" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon"></asp:Label>
                                                        <asp:Label ID="lblDoorNO" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon"></asp:Label>
                                                        <asp:Label ID="lblMobileNo" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon"></asp:Label>
                                                        <asp:Label ID="lblEmail" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small" ForeColor="Maroon"></asp:Label>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                        <table style="width: 50%">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label85" runat="server" Text="Billing Period" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>

                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtBillingPeriod" runat="Server" MaxLength="12" ToolTip="The current billing period is given here." Width="150px" Height="25px" Enabled="false" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label86" runat="server" Text="Amount OutStanding" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>

                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtamountoutstanding" runat="Server" MaxLength="12" ToolTip="The total amount yet to be received from this resident." Width="150px" Height="25px" Enabled="false" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnAmtOutstanding" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label44" runat="server" Text="PaymentMode" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlPayMode" runat="server" Width="200px" ToolTip="Indicates if the amount is pay to cash or card" OnSelectedIndexChanged="ddlPayMode_SelectedIndexChanged" AutoPostBack="true">
                                                        <asp:ListItem Text="CASH" Value="CASH"></asp:ListItem>
                                                        <asp:ListItem Text="CHEQUE" Value="CHEQUE"></asp:ListItem>
                                                        <asp:ListItem Text="TRANSFER" Value="TRANSFER"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblNo" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblSNo" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNo" runat="Server" MaxLength="40" ToolTip="" Width="240px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" AutoPostBack="true" OnTextChanged="txtamountreceived_TextChanged"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblDate" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblSDate" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtpDate" runat="server" Culture="English (United Kingdom)"
                                                        Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Enter the Registration date" MinDate="01/08/2001">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="TextBox"
                                                            ForeColor="#00008B" ReadOnly="true" BackColor="Yellow">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblBankandBranch" runat="server" Text="" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="lblSBankandBranch" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtBankandBranch" runat="Server" MaxLength="100" ToolTip="" Width="240px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" AutoPostBack="true" OnTextChanged="txtamountreceived_TextChanged"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label87" runat="server" Text="Amount Received" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                    <asp:Label ID="Label50" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>

                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtamountreceived" runat="Server" MaxLength="12" ToolTip="Enter the amount that you are receiving from this resident now." Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" AutoPostBack="true" OnTextChanged="txtamountreceived_TextChanged" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label89" runat="server" Text="Balance" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>

                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtBalance" runat="Server" MaxLength="12" Enabled="false" ToolTip="The balance amount which this resident has to pay." Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnBalance" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label88" runat="server" Text="Remarks" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label>

                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAPRemarks" runat="Server" TextMode="MultiLine" MaxLength="240" ToolTip="Enter if there is any remarks." Width="240px" Height="80px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td colspan="2">
                                                    <asp:Button ID="btnAPOK" runat="Server" Width="70px" Text="Submit" ToolTip=" Have you chosen the right Menu Item and Quantity.Have you checked the amount to pay. If so, click here to add the item to the order list." ForeColor="White" BackColor="DarkBlue" Font-Names="Calibri" Font-Size="Medium" OnClick="btnAPOK_Click" OnClientClick="javascript:return AcceptPaymentValidate()" />
                                                </td>
                                            </tr>
                                        </table>
                                        <table>
                                            <tr>
                                                <td>
                                                    <telerik:RadGrid ID="gvBillSummary" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Width="100%" AllowFilteringByColumn="true" AllowPaging="true" PageSize="10">
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



                                    <telerik:RadTabStrip ID="RadTabStrip1" runat="server" MultiPageID="RadMultiPage1"
                                        Skin="Sunset" BorderColor="LightGray" BorderStyle="Ridge" BorderWidth="0px" SelectedIndex="0" Style="margin-bottom: 0">
                                        <Tabs>
                                            <telerik:RadTab runat="server" Text="Which Menu When?" PageViewID="StandardMnu" CssClass="Font_lbl"
                                                ForeColor="Black" ToolTip="Helps to know about which item when to be serve? " Selected="true" Visible="false">
                                            </telerik:RadTab>
                                            <telerik:RadTab runat="server" Text="How many diners?" PageViewID="DayPlanner" CssClass="Font_lbl" Visible="false"
                                                ForeColor="Black" ToolTip="Helps to set the estimate the number of diners on a day. Set the day planner first before setting the daily menu.">
                                            </telerik:RadTab>
                                            <telerik:RadTab runat="server" Text="Booking A la carte menu" PageViewID="BookingaMeal" CssClass="Font_lbl" Visible="false"
                                                ForeColor="Black" ToolTip="Here resident can Booking a meal for day/session/item wise">
                                            </telerik:RadTab>
                                            <telerik:RadTab runat="server" Text="Accept Payment" PageViewID="AcceptPayment" CssClass="Font_lbl" Visible="false"
                                                ForeColor="Black" ToolTip="Here resident can Booking a meal for day/session/item wise">
                                            </telerik:RadTab>
                                            <telerik:RadTab runat="server" Text="Diners Update" PageViewID="Diners" CssClass="Font_lbl" Visible="false"
                                                ForeColor="Black" ToolTip="Helps to set the estimate the number of diners on the session.">
                                            </telerik:RadTab>
                                            <telerik:RadTab runat="server" Text="Daily Menu" PageViewID="DailyMenu" CssClass="Font_lbl" Visible="false"
                                                ForeColor="Black" ToolTip="Helps to view and print daily menu.">
                                            </telerik:RadTab>
                                            <telerik:RadTab runat="server" Text="Menu Items" PageViewID="MenuItemMst" CssClass="Font_lbl" Visible="false"
                                                ForeColor="Black" ToolTip="This is the master list of all Food Menu Items, that will be served to the residents.">
                                            </telerik:RadTab>
                                            <telerik:RadTab runat="server" Text="Menu For Day" PageViewID="MenuForDay" CssClass="Font_lbl" Visible="false"
                                                ForeColor="Black" ToolTip="Click here to manage menu for a day">
                                            </telerik:RadTab>
                                            <telerik:RadTab runat="server" Text="Dining Transactions" PageViewID="FoodTransaction" CssClass="Font_lbl" Visible="false"
                                                ForeColor="Black" ToolTip="Click here to manage menu for a day">
                                            </telerik:RadTab>
                                            <telerik:RadTab runat="server" Text="Help" PageViewID="Help" CssClass="Font_lbl" Visible="false"
                                                ForeColor="Black" ToolTip="Click here to manage menu items">
                                            </telerik:RadTab>
                                        </Tabs>
                                    </telerik:RadTabStrip>






                                    <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" Width="1200px"
                                        Height="100%" Visible="true" BorderColor="#E3E4FA" BorderStyle="Ridge" BorderWidth="1" Selected="true">


                                        <telerik:RadPageView ID="Diners" runat="server" ForeColor="Black" Height="100%" Selected="true"
                                            Width="100%" Visible="true">
                                        </telerik:RadPageView>


                                        <telerik:RadPageView ID="BookingaMeal" runat="server" ForeColor="Black" Height="100%" Selected="true"
                                            Width="100%" Visible="true">
                                        </telerik:RadPageView>

                                        <telerik:RadPageView ID="AcceptPayment" runat="server" ForeColor="Black" Height="100%" Selected="true" Width="100%" Visible="true">
                                        </telerik:RadPageView>

                                        <telerik:RadPageView ID="StandardMnu" runat="server" ForeColor="Black" Height="100%" Selected="true"
                                            Width="1200px" Visible="true">
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="DayPlanner" runat="server" ForeColor="Black" Height="100%"
                                            Width="1200px" Visible="true">
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="DailyMenu" runat="server">
                                        </telerik:RadPageView>
                                        <telerik:RadPageView ID="MenuItemMst" runat="server">
                                        </telerik:RadPageView>

                                        <telerik:RadPageView ID="MenuForDay" runat="server">
                                        </telerik:RadPageView>


                                        <telerik:RadPageView ID="FoodTransaction" runat="server" ForeColor="Black" Height="100%" Selected="true"
                                            Width="100%" Visible="true">
                                        </telerik:RadPageView>

                                        <telerik:RadPageView ID="Help" runat="server">
                                        </telerik:RadPageView>



                                    </telerik:RadMultiPage>


                                </td>
                            </tr>
                        </table>

                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnOutstandingBills" />
                    <asp:PostBackTrigger ControlID="btnmenufordayexporttoexcel" />
                    <asp:PostBackTrigger ControlID="btnPrintReceipt" />
                    <asp:PostBackTrigger ControlID="rgSessionMenuForDay" />
                    <asp:PostBackTrigger ControlID="btnTOK" />
                    <asp:PostBackTrigger ControlID="lnkprofile" />
                   <%-- <asp:PostBackTrigger ControlID="btnpaynow" />--%>
                    <asp:PostBackTrigger ControlID="btnPreparetobill" />
                </Triggers>

            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>




