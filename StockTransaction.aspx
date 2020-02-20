<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="StockTransaction.aspx.cs" Inherits="StockTransaction" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function SaveValidate() {

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



        function UpdateValidate() {




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



        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode


            if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
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

                    <%-- <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>--%>
                    <%--
        <telerik:RadWindowManager runat="server" ID="RadWindowManager1">
         
        </telerik:RadWindowManager>


                     <script type="text/javascript">
                         function confirmCallbackFn(arg) {
                             if (arg) //the user clicked OK
                             {
                                 __doPostBack("<%=HiddenButton.UniqueID %>", "");
                }

            }
        </script>--%>


                    <div style="font-family: Verdana; font-size: small;">
                        <table style="width: 100%;">
                            <tr>
                                <td align="center" style="width: 80%">
                                    <asp:Label ID="lbltitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:HiddenField ID="hdnRSN" runat="server" />
                                    <asp:HiddenField ID="hdnItem" runat="server" />
                                </td>

                                <td align="right" style="width: 20%">
                                    <%--<asp:LinkButton ID="lnkvegetableprice" runat="server" ForeColor="Green" Font-Names="Verdana" OnClick="lnkvegetableprice_Click" Text ="Vegetables-daily-price" Font-Underline="true" ToolTip="Click here to show daily price list of vegetables. It shows based on your country,state and city."></asp:LinkButton>--%>
                                    <asp:LinkButton ID="lnkvegetableprice" runat="server" ForeColor="Green" Font-Names="Verdana" OnClick="lnkvegetableprice_Click" Text="Vegetables-daily-price" Font-Underline="true" ToolTip="Click here to show daily price list of vegetables and groceries."></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
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


                        <table style="width: 100%;">

                            <tr>
                                <td style="width: 50%;">

                                    <table style="width: 100%;">

                                        <tr>

                                            <td>

                                                <tr>
                                                    <td style="width: 30%;">
                                                        <asp:Label ID="Label21" runat="server" Text="Group"></asp:Label>
                                                        <asp:Label ID="Label22" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlItemGroup" runat="server" ToolTip="Select the stock group" Height="23px" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="ddlItemGroup_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblResident" runat="server" Text="Item"></asp:Label>
                                                        <asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlItemCode" runat="server" ToolTip="Select the Item" Height="23px" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="ddlItemCode_Changed">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label9" runat="server" Text="UOM"></asp:Label>
                                                        <asp:Label ID="Label10" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtIUOM" runat="server" ToolTip="Shows Unit Of Measurement" Width="150px" MaxLength="20" ReadOnly="true"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label11" runat="server" Text="Available Stock"></asp:Label>
                                                        <asp:Label ID="Label12" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td colspan="3">
                                                        <asp:TextBox ID="txtClosingStk" runat="server" ToolTip="Shows available stock" Width="150px" MaxLength="20" ReadOnly="true"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-wrap: none;">
                                                        <asp:Label ID="Label7" runat="server" Text="Transaction Type"></asp:Label>
                                                        <asp:Label ID="Label8" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlTransactionType" runat="server" ToolTip="Select the transaction type" Height="23px" Width="250px" OnSelectedIndexChanged="ddlTransactionType_SelectedIndexChanged" AutoPostBack="true">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" Text="Qty"></asp:Label>
                                                        <asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtQty" runat="server" ToolTip="Enter the quantity" Width="150px" MaxLength="10" ReadOnly="false" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblpurchaseprice" runat="server" Text="Value"></asp:Label>
                                                        <asp:Label ID="Label5" runat="server" Text="" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPurchaseprice" runat="server" ToolTip="Enter the price at which this item was purchased. This will help later in estimating the costs." Width="150px" MaxLength="10" ReadOnly="false" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                                    </td>
                                                </tr>



                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lbldate" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small "></asp:Label>
                                                        <asp:Label ID="Label4" runat="Server" Text="" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtpdate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="By mentioning the date/session and the menu item for which this stock item is being issued, it will be possible to estimate the costs incurred and to have control over the usage and wastage.  However this information is optional.  "
                                                            OnSelectedDateChanged="dtpdate_SelectedDateChanged" Culture="English (United Kingdom)" Skin="Default" AutoPostBack="true">
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput1" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                            </DateInput>
                                                            <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle BackColor="Pink" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDatePicker>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblSessionCode" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlSession" ToolTip="Entering the Date/Session/Menu Item for adjustment transactions, may be needed if you had to issue additional stock when there was a shortage or when you had to take back unused stock." Width="200px" Height="25px" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSession_SelectedIndexChanged"
                                                            Font-Names="Calibri" Font-Size="Small">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblmenuitem" runat="Server" Text="Menu Item" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlMenuItem" ToolTip=" If you do not find a Menu Item here, it means that Menu item is not in the menu for the session.  Check the menu." Width="200px" Height="25px" runat="server" AutoPostBack="true"
                                                            Font-Names="Calibri" Font-Size="Small">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label23" runat="server" Text="Supplier Name"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtSupplierName" runat="server" ToolTip="Enter the supplier name where the item was purchased." Width="250px" MaxLength="30" ReadOnly="false"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label25" runat="server" Text="Invoice Number"></asp:Label>

                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtInvoiceNo" runat="server" ToolTip="Enter the invoice number." Width="250px" MaxLength="20" ReadOnly="false"  ></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label24" runat="Server" Text="Invoice Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small "></asp:Label>
                                                    </td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtpInoviceDt" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select invoice date."
                                                            Culture="English (United Kingdom)" Skin="Default" AutoPostBack="true">
                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                            <DateInput ID="DateInput3" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                            </DateInput>
                                                            <Calendar ID="Calendar3" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                                <SpecialDays>
                                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                                        <ItemStyle BackColor="Pink" />
                                                                    </telerik:RadCalendarDay>
                                                                </SpecialDays>
                                                            </Calendar>
                                                        </telerik:RadDatePicker>
                                                    </td>


                                                </tr>
                                                <tr>
                                                    <td style="vertical-align: top">
                                                        <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                                                    </td>
                                                    <td>

                                                        <asp:TextBox ID="txtRemarks" runat="server" ToolTip="Enter if there is any remarks." TextMode="MultiLine" Height="75px" Width="250px" MaxLength="2400"></asp:TextBox>
                                                        <asp:DropDownList ID="ddlsavetime" runat="server" Width="200px" ToolTip="Select from a standard picklist of frequently used sentences." OnSelectedIndexChanged="ddlsavetime_SelectedIndexChanged" AutoPostBack="true">
                                                        </asp:DropDownList>
                                                        <asp:Button ID="btnSaveTime" runat="server" Text="SaveTime" CssClass="Button"
                                                            OnClick="btnSaveTime_Click" ToolTip="SaveTime by adding frequently used comments. Click here to add such comments.  Remember whatever you add once is available everywhere in the system." Font-Names="verdana" BackColor="DarkBlue" ForeColor="White" />
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td></td>
                                                    <td>
                                                        <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                                        <%--<asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the details" OnClick="btnUpdate_Click"  runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" Visible="false"/>--%>
                                                        <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" Height="25px" OnClick="btnClear_Click" />
                                                        <asp:Button ID="HiddenButton" Text="" Style="display: none;" OnClick="HiddenButton_Click" runat="server" />
                                                    </td>
                                                </tr>

                                            </td>
                                        </tr>

                                    </table>
                                </td>
                                <td style="width: 50%; vertical-align: top">
                                    <asp:Label ID="Label14" runat="server" Text="Opening Stock is used only when an item is introduced for the first time. This will not appear for items that are already having some transactions." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                    <asp:Label ID="Label15" runat="server" Text="Receipt - Use this transaction type when an item is purchased and added to stock. Enter the Purchase value otherwise the average price cannot be determined.  Receipts are always to the main stores identified as location 1 internally." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                    <asp:Label ID="Label16" runat="server" Text="Issue - Use this transaction type when an item is issued to the kitchen for preparing a menu. Mention the Date/Session/Menu for which this issue is being made.  You can either leave it at the Date level or at the Date+Session level or link the issue to a specific Menu Item.  Issues are always to the Pantry Stores or location 2." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label>
                                    <br />
                                    <asp:Label ID="Label17" runat="server" Text="Adjustment (+)  - Use this transaction type when  a stock adjustment (adding to the stock)  has to be done. Happens when there is a discrepancy between physical stock and system stock has to be set right." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                    <asp:Label ID="Label18" runat="server" Text="Adjustment (-)  - Use this transaction type when  a negative stock adjustment (reducing from stock)  has to be done. Happens when there is a discrepancy between physical stock and system stock has to be set right." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label><br />
                                    <asp:Label ID="Label19" runat="server" Text="Write Off -  Use this transaction type when  a negative stock adjustment (reducing from stock)  has to be done. Happens when some stock quantity has to be written off perhaps because it is damaged." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label>
                                    <br />
                                    <asp:Label ID="Label20" runat="server" Text="Stock Return -  Use this transaction type when some stock of large quantity is coming back to main stores from the pantry.  Stock gets added to main stores." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label>

                                </td>

                            </tr>

                        </table>


                        <table style="width: 100%;">

                            <tr>
                                <td style="width: 100%">
                                    <asp:Label ID="lblhelp" runat="server" Width="70%" Text="Provisions -Also refers to Groceries . Ex: Rice, Oil,  Wheat, Pulses etc.Perishables -Also refers to Vegetables, Fruits, Milk, Egg etc.Consumables-Refers to items such as Paper cups, paper plates,  Plastic spoons, tissue box,  Plantain leaf , Cooking Gas etc." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label>
                                </td>
                            </tr>


                            <tr>
                                <td>
                                    <asp:Label ID="lblrecenttransaction" runat="server" Text="" Font-Names="verdana" ForeColor="Maroon" Font-Size="Medium"></asp:Label>
                                </td>
                            </tr>

                            <tr>
                                <td style="width: 50%; vertical-align: top">
                                    <telerik:RadGrid ID="rgRecentTransaction" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                        AutoGenerateColumns="false" Height="165px" Width="90%" AllowPaging="false" OnInit="rgRecentTransaction_Init" OnItemDataBound="rgRecentTransaction_ItemDataBound">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView NoMasterRecordsText="No Records Found.">
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Ref.No" HeaderStyle-Width="40px" DataField="RSN" ReadOnly="true" Display="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Unique Txn Ref.No"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DateStamp" HeaderStyle-Width="80px" ItemStyle-Width="80px" DataField="Date" ReadOnly="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="60px" HeaderTooltip="Date and Time of Txn."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="80px" ItemStyle-Width="80px" DataField="TransType" ReadOnly="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="50px" HeaderTooltip="Type of the Txn."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="UOM" HeaderStyle-Width="60px" ItemStyle-Width="60px" DataField="issueuom" ReadOnly="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="40px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Qty" HeaderStyle-Width="60px" ItemStyle-Width="60px" DataField="Qty" ReadOnly="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="40px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Rate" HeaderStyle-Width="60px" ItemStyle-Width="60px" DataField="Rate" ReadOnly="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="40px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Value" HeaderStyle-Width="60px" ItemStyle-Width="60px" DataField="purchaseprice" ReadOnly="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="40px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Var(%)" HeaderStyle-Width="65px" ItemStyle-Width="65px" DataField="VPCNT" ReadOnly="true" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center" FilterControlWidth="40px" HeaderTooltip="Var%   = Variation Percentage =    (Latest Rate  Minus Immediate previous rate) /  Immediate Previous Rate    expressed in Percentage.  If the Variation is >= 20%,  it is shown in RED colour.  VAR% is shown only for RECEIPT Transactions.   Helps to keep a check on major variation in prices."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ForDate" HeaderStyle-Width="70px" ItemStyle-Width="70px" DataField="ForDate" ReadOnly="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="50px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ForSession" HeaderStyle-Width="70px" ItemStyle-Width="70px" DataField="SessionName" ReadOnly="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="50px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ForMenuItem" HeaderStyle-Width="70px" ItemStyle-Width="70px" DataField="ItemName" ReadOnly="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="50px" HeaderTooltip=""></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>

                            <tr>
                                <td style="width: 100%; margin-right: 10%">
                                    <div>
                                        <table>
                                            <tr>
                                                <td style="width: 50%">
                                                    <asp:Label ID="Label13" runat="Server" Text="Transaction Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small "></asp:Label>
                                                    <telerik:RadDatePicker ID="dtpTransDate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select transaction date."
                                                        OnSelectedDateChanged="dtpTransDate_SelectedDateChanged" Culture="English (United Kingdom)" Skin="Default" AutoPostBack="true">
                                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                        <DateInput ID="DateInput2" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                        </DateInput>
                                                        <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                            <SpecialDays>
                                                                <telerik:RadCalendarDay Repeatable="Today">
                                                                    <ItemStyle BackColor="Pink" />
                                                                </telerik:RadCalendarDay>
                                                            </SpecialDays>
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                </td>

                                                <td style="width: 50%">
                                                    <asp:Button ID="BtnExcelExport" Width="125PX" Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExport_Click" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here export grid details to excel." />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                </td>
                            </tr>

                            <tr>
                                <td style="width: 60%; vertical-align: top">
                                    <telerik:RadGrid ID="grdTransDet" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="350px" Width="1100px" AllowFilteringByColumn="true" AllowPaging="false"
                                        OnItemCommand="grdTransDet_ItemCommand" OnInit="grdTransDet_Init" OnItemDataBound="grdTransDet_ItemDataBound">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView AllowFilteringByColumn="true">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkView" ToolTip="Click here to view the details" runat="server" Text="View" ForeColor="Blue" OnClick="lnkView_Click" Font-Underline="false"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Ref.No" HeaderStyle-Width="40px" DataField="RSN" ReadOnly="true" AllowFiltering="false" Display="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Unique Txn Ref.No"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DateStamp" HeaderStyle-Width="80px" ItemStyle-Width="80px" DataField="Date" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="60px" HeaderTooltip="Date and Time of Txn."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="80px" ItemStyle-Width="80px" DataField="TransType" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="50px" HeaderTooltip="Type of the Txn."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Item" HeaderStyle-Width="100px" DataField="Item" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" HeaderTooltip="Provisons and Groceries for the txn."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="UOM" HeaderStyle-Width="60px" ItemStyle-Width="60px" DataField="IssueUOM" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" FilterControlWidth="40px" HeaderTooltip="Unito of measurement"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Qty" HeaderStyle-Width="60px" ItemStyle-Width="60px" DataField="Qty" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="40px" HeaderTooltip=""></telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn HeaderText="Closing Stock" HeaderStyle-Width="70px" ItemStyle-Width="70px" DataField="ClosingStock" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="50px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Value" HeaderStyle-Width="70px" ItemStyle-Width="70px" DataField="PurchasePrice" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="50px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Rate" HeaderStyle-Width="70px" ItemStyle-Width="70px" DataField="Rate" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="50px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Var(%)" HeaderStyle-Width="60px" ItemStyle-Width="60px" DataField="VPCNT" ReadOnly="true" HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center" FilterControlWidth="40px" HeaderTooltip="Var%   = Variation Percentage =    (Latest Rate  Minus Immediate previous rate) /  Immediate Previous Rate    expressed in Percentage.  If the Variation is >= 20%,  it is shown in RED colour.  VAR% is shown only for RECEIPT Transactions.   Helps to keep a check on major variation in prices."></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ForDate" HeaderStyle-Width="70px" ItemStyle-Width="70px" DataField="ForDate" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="50px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ForSession" HeaderStyle-Width="70px" ItemStyle-Width="70px" DataField="SessionName" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="50px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ForMenuItem" HeaderStyle-Width="70px" ItemStyle-Width="70px" DataField="ItemName" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" FilterControlWidth="50px" HeaderTooltip=""></telerik:GridBoundColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="150px" DataField="Remarks" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>--%>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                    <br />
                                    <text style="color: gray; font-family: Verdana; font-size: smaller;">
                                  Here enter the transactions with reference to receipts , issues and adjustments of provisions, groceries needed in the kitchen. 
                               </text>

                                </td>

                            </tr>
                        </table>
                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSave" />
                    <asp:PostBackTrigger ControlID="lnkvegetableprice" />
                    <asp:PostBackTrigger ControlID="BtnExcelExport" />
                </Triggers>
            </asp:UpdatePanel>

        </div>
    </div>
</asp:Content>

