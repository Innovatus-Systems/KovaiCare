<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuTimeTable.aspx.cs" Inherits="MenuTimeTable" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style>
        .rightAlign {
            text-align: right;
        }

        .panStyle {
            /*font-family: Arial;
            font-size: 14px;
            color: #0000cc;
            font-weight: bold;*/
            background-repeat: no-repeat;
            padding: 5px;
        }
    </style>

    <script type="text/javascript">

        function TaskConfirmMsg() {

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

        function TaskConfirmMsg2() {

            var result = confirm('Do you want to update?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
            }

        }
        <%-- function showPanelTop() {
            var imgurl = document.getElementById("<%= BtnUp.ClientID %>").src;
            //alert(imgurl);
            if (imgurl.includes("DownArrow.png")) {
                document.getElementById("<%= BtnUp.ClientID %>").src = "Images\\UpArrow.png";
                document.getElementById("<%= pnlTop.ClientID %>").style.display = "none";
                return false;
            }
            else
                return true;
        }--%>
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
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <table style="width: 100%;">
                        <tr>
                            <%--<td valign="top" style="width: 5%">
                                <asp:ImageButton Width="30px" Height="30px" ID="BtnUp" runat="server" ImageUrl="~/Images/UpArrow.png" OnClientClick="return showPanelTop();"
                                    OnClick="BtnUp_Click" />&nbsp;&nbsp;
                            </td>--%>
                            <td align="center">
                                <asp:Label ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>

                            </td>
                            <td valign="top" style="width: 5%">
                                <asp:HiddenField ID="CnfResult" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div id="dvMenuforday" runat="server" style="width: 100%">

                        <%-- <asp:LinkButton ID="lnkmenuforday" runat="server" Text="+ Add a new Menu for day" Font-Underline="false" ForeColor="Black" Font-Names="Calibri" Font-Size="Small" ToolTip="You can add a new menu items for day by clicking here." OnClick="lnkmenuforday_Click"></asp:LinkButton>--%>

                        <asp:Panel ID="pnlTop" runat="server">
                            <table style="width: 90%">
                                <tr>
                                    <td style="width: 75%">

                                        <table>
                                            <tr>
                                                <td>

                                                    <asp:Label ID="Label34" runat="Server" Text="Date" ForeColor="Black" Font-Names="Calibri" Font-Size="Small"></asp:Label>

                                                    <telerik:RadDatePicker ID="dtpmenuforday" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Select Menu Date" AutoPostBack="true" OnSelectedDateChanged="dtpmenuforday_SelectedDateChanged">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri" Font-Size="Small">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top">
                                                    <telerik:RadGrid ID="rgSessionMenuForDay" runat="server" AutoGenerateColumns="False" Width="350px">

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
                                                    <%--<td>--%>
                                                    <asp:CheckBoxList ID="chkCopyType" runat="server" OnSelectedIndexChanged="chkCopyType_SelectedIndexChanged" AutoPostBack="true" RepeatDirection="Horizontal">
                                                        <asp:ListItem Text="Copy to same day in coming weeks" Value="1" onclick="UncheckOthers(this);"></asp:ListItem>
                                                        <asp:ListItem Text="Copy for a date range" Value="2" onclick="UncheckOthers(this);"></asp:ListItem>
                                                    </asp:CheckBoxList>

                                                    <%--                                                </td>--%>
                                                </td>
                                                <td style="vertical-align: top">
                                                    <telerik:RadGrid ID="rdgResidentDet" runat="server" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                        Height="130px" Width="400px" AllowSorting="false" AllowMultiRowSelection="true">

                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                                        </HeaderContextMenu>
                                                        <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="false" />
                                                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                                        </ClientSettings>
                                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="false" ShowHeadersWhenNoRecords="true">
                                                            <PagerStyle Mode="NumericPages" />
                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                            <RowIndicatorColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </RowIndicatorColumn>
                                                            <ExpandCollapseColumn>
                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                            </ExpandCollapseColumn>

                                                            <Columns>
                                                                <telerik:GridTemplateColumn AllowFiltering="false" Visible="true" HeaderText="Menu for" HeaderStyle-Width="90px" UniqueName="SDate">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LnkSDate" runat="server" Text='<%# Eval("SDate") %>' ToolTip="Click here to set the menu" Font-Names="verdana" ForeColor="Blue" Font-Size="Smaller" CommandName="SDate" OnClick="lnkSDate_Click"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridBoundColumn DataField="SDate" HeaderText="Date" UniqueName="SDate"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" Display="false">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Session1" HeaderText="Breakfast" UniqueName="Session1"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Session2" HeaderText="Lunch" UniqueName="Session2"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Session3" HeaderText="Dinner" UniqueName="Session3"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Session4" HeaderText="Snacks" UniqueName="Session4"
                                                                    Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>

                                                            </Columns>
                                                        </MasterTableView>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                    <td>
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label94" runat="Server" Text="*Here you can set the Menu for a specific date and all similar days in the same month." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Smaller"></asp:Label><br />
                                                    <asp:Label ID="Label95" runat="Server" Text="*If you have already set the Menu for a specific date, you can remove an item from the menu only for that day." ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>

                        </asp:Panel>
                        <table>
                            <tr>

                                <td>

                                    <asp:Panel ID="panNotSet" runat="server">
                                        <table>
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
                                                                            CssClass="TextBox" Font-Names="Calibri" Font-Size="Small">
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
                                                                            CssClass="TextBox" Font-Names="Calibri" Font-Size="Small">
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
                                                                            CssClass="TextBox" Font-Names="Calibri" Font-Size="Small">
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
                                                                            CssClass="TextBox" Font-Names="Calibri" Font-Size="Small">
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
                                                                            CssClass="TextBox" Font-Names="Calibri" Font-Size="Small">
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
                                                                            CssClass="TextBox" Font-Names="Calibri" Font-Size="Small">
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
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <div>
                            <%-- <asp:Panel ID="panLoadMenufordays" runat="server" BackColor="LightGray">
                            </asp:Panel>--%>
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
                                                    <td style="text-align: left">
                                                        <telerik:RadComboBox ID="cmbUItemName" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                            AutoPostBack="true" Font-Names="Arial" Font-Size="Small" Height="100px"
                                                            Width="250px" ToolTip="" OnSelectedIndexChanged="cmbUItemName_SelectedIndexChanged"
                                                            RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="">
                                                            <%-- --%>
                                                        </telerik:RadComboBox>
                                                        &nbsp;&nbsp;
                                                        <asp:Button ID="btnUAddItem" runat="Server" Width="100px" Text="Add" ToolTip="Click here to add the Item" ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" CssClass="btn btn-Success" Font-Size="Medium" OnClick="btnUAddItem_Click" />

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadGrid ID="rgEditMenuforday" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                                            Width="900px" AllowSorting="true" OnItemCreated="rgMenuforday_ItemCreated" AllowMultiRowSelection="true" OnItemDataBound="rgEditMenuforday_ItemDataBound" OnDeleteCommand="rgEditMenuforday_DeleteCommand">
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

                                                                    <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1" Visible="false">
                                                                    </telerik:GridClientSelectColumn>

                                                                    <%--<telerik:GridTemplateColumn HeaderText="#" UniqueName="RowNumber">
                                                                        <ItemTemplate>
                                                                            <asp:Label runat="server" ID="lblRowNumber" Width="50px" Text=""></asp:Label>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>--%>

                                                                    <telerik:GridTemplateColumn HeaderText="#" HeaderStyle-Font-Names="" UniqueName="BillFor"
                                                                        SortExpression="BillFor" AllowFiltering="false" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtRowNumber" Width="20px" runat="server" Text=""></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <%--<telerik:GridTemplateColumn HeaderText="Item Name" HeaderStyle-Font-Names="" UniqueName="ItemName" SortExpression="ItemName" AllowFiltering="false">
                                                                        <ItemTemplate>
                                                                            <asp:LinkButton ID="lnkitemname" runat="server" Text='<%# Eval("ItemName") %>' ToolTip='<%# Eval("Remarks") %>'></asp:LinkButton>

                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>--%>

                                                                    <telerik:GridBoundColumn DataField="ItemName" HeaderText="Item Name" UniqueName="ItemName"
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
                                                                    <telerik:GridBoundColumn DataField="ItemCode" HeaderText="ItemCode" UniqueName="ItemCode"
                                                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridButtonColumn CommandName="Delete" Text="Remove" UniqueName="DeleteColumn"  />

                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                                <Selecting AllowRowSelect="true"></Selecting>

                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </td>
                                                    <td style="vertical-align: top">
                                                        <asp:Button ID="btnUpdateMenuforday" runat="Server" Width="70px" Text="Update" ToolTip="Click to update the Menu for the given date and session." ForeColor="White" CssClass="btn btn-success" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnUpdateMenuforday_Click" OnClientClick="javascript:return TaskConfirmMsg2()" />
                                                        <asp:Button ID="btnCloseMenuforday" runat="Server" Width="70px" Text="Clear" ToolTip="Click here to clear the menu details" ForeColor="White" CssClass="btn btn-success" BackColor="DarkOrange" BorderColor="Gray" Font-Names="Calibri" Font-Size="Medium" OnClick="btnCloseMenuforday_Click" />
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
                                            <asp:Label ID="Label96" runat="Server" Text="(Dates matching the same day within a month are shown.)" ForeColor="DarkBlue" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                        </td>
                                    </tr>



                                    <tr>
                                        <td style="text-align: left">
                                            <%--<asp:Label ID="Label4" runat="Server" Text="Please Select:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>--%>
                                            <telerik:RadComboBox ID="cmbItemName" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                AutoPostBack="true" Font-Names="Arial" Font-Size="Small" Height="100px"
                                                Width="250px" ToolTip="" OnSelectedIndexChanged="cmbItemName_SelectedIndexChanged"
                                                RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="">
                                                <%-- --%>
                                            </telerik:RadComboBox>
                                            &nbsp;&nbsp;
                                             <asp:Button ID="btnAddItem" runat="Server" Width="100px" Text="Add to List" ToolTip="Click here to add the Item to list" ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" CssClass="btn btn-Success" Font-Size="Medium" OnClick="btnAddItem_Click" />

                                        </td>
                                    </tr>


                                    <tr>
                                        <td style="width: 1300px">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadGrid ID="rgMenuforday" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue" ShowFooter="false"
                                                            Width="700px" AllowSorting="true" OnItemCreated="rgMenuforday_ItemCreated" OnItemDataBound="rgMenuforday_ItemDataBound" AllowMultiRowSelection="true" OnDeleteCommand="rgMenuforday_DeleteCommand">
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

                                                                    <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1" HeaderStyle-Width="40px" Visible="false">
                                                                    </telerik:GridClientSelectColumn>

                                                                    <%--<telerik:GridTemplateColumn HeaderText="#" UniqueName="RowNumber">
                                                                        <ItemTemplate>
                                                                            <asp:Label runat="server" ID="lblRowNumber" Width="50px" Text=""></asp:Label>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>--%>

                                                                    <telerik:GridTemplateColumn HeaderText="#" HeaderStyle-Font-Names="" UniqueName="BillFor"
                                                                        SortExpression="BillFor" HeaderStyle-Width="80px" AllowFiltering="false" Visible="false">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtRowNumber" CssClass="rightAlign" Width="40px" runat="server" Text=""></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" HeaderStyle-Width="130px"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <%--  <telerik:GridTemplateColumn HeaderText="Item Name" HeaderStyle-Font-Names="" UniqueName="ItemName" SortExpression="ItemName" AllowFiltering="false">
                                                                        <ItemTemplate>
                                                                             
                                                                            <asp:LinkButton ID="lnkitemname" runat="server" Text='<%# Eval("ItemName") %>' ToolTip='<%# Eval("Remarks") %>'></asp:LinkButton>

                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>--%>



                                                                    <telerik:GridBoundColumn DataField="ItemName" HeaderText="Item Name" UniqueName="ItemName"
                                                                        Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="Type" HeaderText="Diabetic?" UniqueName="Type" HeaderStyle-Width="130px"
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
                                                                        Display="false" Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="UsualQty" HeaderText="ServingQty" UniqueName="UsualQty"
                                                                        Display="false" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="UOM" HeaderText="Unit" UniqueName="UOM"
                                                                        Display="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="TotalQty" HeaderText="TotalQty" UniqueName="TotalQty"
                                                                        Display="false" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="QtyAlert" HeaderText="QtyAlert" UniqueName="QtyAlert"
                                                                        Display="false" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center">
                                                                        <HeaderStyle HorizontalAlign="center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="LeadTime" HeaderText="LeadTime" UniqueName="LeadTime"
                                                                        Display="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="ItemCode" HeaderText="ItemCode" UniqueName="ItemCode"
                                                                        Visible="false" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridButtonColumn CommandName="Delete" Text="Remove" UniqueName="DeleteColumn"  />


                                                                    <%--<telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn"/>--%>

                                                                    <%-- <telerik:GridButtonColumn CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                                                    </telerik:GridButtonColumn>--%>


                                                                    <%-- <telerik:GridTemplateColumn UniqueName="TemplateColumn">
                                                                        <ItemTemplate>
                                                                            <asp:ImageButton ID="ImageButton1" runat="server" AlternateText="Delete Customer"
                                                                                OnClientClick="javascript:if(!confirm('This action will delete the selected customer and all of his/her orders. Are you sure?')){return false;}"
                                                                                ImageUrl="~/RadControls/Grid/Skins/Default/Delete.gif" />
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>--%>
                                                                </Columns>

                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                                <Selecting AllowRowSelect="true"></Selecting>

                                                            </ClientSettings>
                                                        </telerik:RadGrid>

                                                    </td>
                                                    <td style="vertical-align: top">

                                                        <asp:Button ID="btnmenufordaysave" runat="Server" Width="100px" Text="Set Menu" ToolTip=" Click to Save the Menu for the given date and session." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" CssClass="btn btn-Success" Font-Size="Medium" OnClick="btnmenufordaysave_Click" OnClientClick="javascript:return TaskConfirmMsg()" />
                                                        <asp:Button ID="btnmenufordayclear" runat="Server" Width="70px" Text="Clear" CssClass="btn btn-default" ToolTip="Click here to clear the menu details" ForeColor="White" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnmenufordayclear_Click" />
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


                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="rgSessionMenuForDay" />
                    <asp:PostBackTrigger ControlID="btnmenufordayexporttoexcel" />
                    <asp:PostBackTrigger ControlID="btnAddItem" />
                    <asp:PostBackTrigger ControlID="btnUAddItem" />
                    <asp:PostBackTrigger ControlID="cmbUItemName" />
                    <asp:PostBackTrigger ControlID="cmbItemName" />
                </Triggers>

            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>


