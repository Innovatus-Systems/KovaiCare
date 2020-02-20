<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhysicalStock.aspx.cs" Inherits="PhysicalStock" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />


    <style type="text/css">
        .HkLabel {
            display: inline-block;
            font-size: small;
            font-family: Verdana;
            background-color: limegreen;
            border: 2px solid inset;
            font-weight: bold;
        }
    </style>

    <style type="text/css">
        .button_example {
            border: 1px solid #25729a;
            -webkit-border-radius: 3px;
            font-stretch: normal;
            -moz-border-radius: 3px;
            border-radius: 3px;
            font-size: 12px;
            font-family: verdana, sans-serif;
            padding: 5px 5px 5px 5px;
            text-decoration: none;
            display: inline-block;
            text-shadow: -1px -1px 0 rgba(0,0,0,0.3);
            font-weight: bold;
            color: #FFFFFF;
            background-color: #3093c7;
            background-image: -webkit-gradient(linear, left top, left bottom, from(#3093c7), to(#1c5a85));
            background-image: -webkit-linear-gradient(top, #3093c7, #1c5a85);
            background-image: -moz-linear-gradient(top, #3093c7, #1c5a85);
            background-image: -ms-linear-gradient(top, #3093c7, #1c5a85);
            background-image: -o-linear-gradient(top, #3093c7, #1c5a85);
            background-image: linear-gradient(to bottom, #3093c7, #1c5a85);
            filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr=#3093c7, endColorstr=#1c5a85);
        }

            .button_example:hover {
                border: 1px solid #1c5675;
                background-color: #26759e;
                background-image: -webkit-gradient(linear, left top, left bottom, from(#26759e), to(#133d5b));
                background-image: -webkit-linear-gradient(top, #26759e, #133d5b);
                background-image: -moz-linear-gradient(top, #26759e, #133d5b);
                background-image: -ms-linear-gradient(top, #26759e, #133d5b);
                background-image: -o-linear-gradient(top, #26759e, #133d5b);
                background-image: linear-gradient(to bottom, #26759e, #133d5b);
                filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,startColorstr=#26759e, endColorstr=#133d5b);
            }
    </style>


    <script type="text/javascript">
        function CheckAll(id) {
            var masterTable = $find("<%= rgPhysicalStock.ClientID %>").get_masterTableView();
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

            var masterTable = $find("<%= rgPhysicalStock.ClientID %>").get_masterTableView();
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

     function ConfirmMsg() {

            var result = confirm('Do you want to save the physical stock verification details?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }
    </script>

    <script type="text/javascript">

        function UpdateConfirmMsg() {

            var result = confirm('Do you want to update the physical stock verification details?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt" style="min-height:490px">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>

                    <asp:HiddenField ID="CnfResult" runat="server" />

                    <table style="width: 100%;">
                        <tr>
                            <td align="center">

                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                <asp:HiddenField ID="hdnRSN" runat="server" />
                            </td>
                        </tr>
                    </table>

                     <table style="width: 30%;">

                            <tr>
                                <td>
                                    <asp:Button ID="btnNewBatchCode" runat="server" Text="New Batch" ToolTip="Click here to select items for which you wish to do a physical stock verification.  One batch can contain many items but always of the same category.  Caution:  DO not have any transactions when the physical stock verification is going on." CssClass="button_example" OnClick="btnNewBatchCode_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="btnUpdate" runat="server" Text="Update Physical Stock" ToolTip="Use this option after you have done the physical stock verification and have collected information about the actual stock in the stores.  Here you are now expected to select the right batch and enter the values.  The comparison between System Stock and the Physical Stock will be done internally.   Later you may have to do Adjustment + or -  or Write Off or Stock Returns  in Stock Transactions to sync the system stock with the physical stock." CssClass="button_example" OnClick="btnUpdate_Click" />
                                </td>
                                

                            </tr>
                         

                        </table>

                   


                    <table>

                        <tr>
                            <td>

                                <div id="dvNewBatchCode" runat="server">

                                    <table style="width:100%">
                                       
                                             <tr>
                                                <td  align="center">
                                                    <asp:Label ID="Label39" runat="Server" Text="Select Items for stock verification" ForeColor="DarkGreen" Font-Names="verdana" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                </td>
                                          
                                        </tr>
                                    </table>

                                   <table>
                        <tr>
                            <%--<td>Date</td>
                            <td>
                                <telerik:RadDatePicker ID="dtpDate" runat="server" Culture="English (United Kingdom)"
                                    Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="Physical stock verification date." MinDate="01/08/2001">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                        CssClass="TextBox" Font-Names="Calibri">
                                    </Calendar>
                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                    <DateInput DisplayDateFormat="dd-MM-yyyy" DateFormat="dd-MM-yyyy" CssClass="TextBox"
                                        ForeColor="#00008B" ReadOnly="true" BackColor="Yellow">
                                    </DateInput>
                                </telerik:RadDatePicker>
                            </td>--%>
                            <td>Group                                         
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlGroup" ToolTip="Provisions -Also refers to Groceries . Ex: Rice, Oil,  Wheat, Pulses etc.
                                    Perishables -Also refers to Vegetables, Fruits, Milk, Egg etc.
                                    Consumables-Refers to items such as Paper cups, paper plates,  Plastic spoons, tissue box,  Plantain leaf , Cooking Gas etc." Width="150px" Height="25px" runat="server"
                                    Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged" AutoPostBack="true" >
                                   
                                </asp:DropDownList>
                            </td>
                            <td>Category                                         
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCategory" ToolTip="HL-High Value,NV-Normal Value,LV-Low Value" Width="150px" Height="25px" runat="server"
                                    Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="High Value" Value="High Value"></asp:ListItem>
                                    <asp:ListItem Text="Average Value" Value="Average Value"></asp:ListItem>
                                    <asp:ListItem Text="Low Value" Value="Low Value"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>

                    </table>

                        

                                    <table>
                                         <tr>
                                            <td style="width:100%">
                                                <asp:Label ID="lblhelp" runat="server" Text="Provisions -Also refers to Groceries . Ex: Rice, Oil,  Wheat, Pulses etc.Perishables -Also refers to Vegetables, Fruits, Milk, Egg etc.Consumables-Refers to items such as Paper cups, paper plates,  Plastic spoons, tissue box,  Plantain leaf , Cooking Gas etc." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label>
                                              </td>
                                        </tr>
                        <tr>
                            <td>

                                <asp:Panel ID="PanPhysicalStock" runat="server" BackColor="LightGray">

                                    <table>

                                        <tr>

                                            <td>

                                                <table>
                                                    <tr>

                                                        <td>

                                                            <telerik:RadGrid ID="rgPhysicalStock" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                                Height="350px" Width="900px" AllowFilteringByColumn="true" AllowSorting="true"  OnItemDataBound="rgPhysicalStock_ItemDataBound"
                                                                 Skin="WebBlue" AllowMultiRowSelection="true" OnInit="rgPhysicalStock_Init">
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


                                                                        <%-- <telerik:GridTemplateColumn AllowFiltering="false" ItemStyle-Width="80px" HeaderStyle-Width="80px">
                                                                                        <ItemTemplate>
                                                                                            <asp:LinkButton ID="LnkEditMenuforday" runat="server" Text="Edit" ToolTip="Click here to edit the menu for day" Font-Names="verdana" OnClick="LnkEditMenuforday_Click" ForeColor="Blue" Font-Size="Smaller"></asp:LinkButton>
                                                                                        </ItemTemplate>
                                                                                    </telerik:GridTemplateColumn>--%>

                                                                     <%--   <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1">
                                                                                    </telerik:GridClientSelectColumn>--%>

                                                                        <%-- <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="left" UniqueName="All" HeaderText="All" ItemStyle-Wrap="false" AllowFiltering="false"
                                                                                ItemStyle-HorizontalAlign="left">
                                                                                <HeaderTemplate>
                                                                                    <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="true" Checked="true" />
                                                                                </HeaderTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="ChkConfirm" ToolTip="Select here to confirm." runat="server" Checked="true"></asp:CheckBox>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>--%>

                                                                         <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1">
                                                                                    </telerik:GridClientSelectColumn>

                                                                        <telerik:GridBoundColumn DataField="RMCode" HeaderText="Item Code" UniqueName="RMCode"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="RMName" HeaderText="Item Name" UniqueName="RMName"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="IssueUOM" HeaderText="UOM" UniqueName="IssueUOM"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="StockGroup" HeaderText="Group" UniqueName="StockGroup"
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
                                           
                                             <td style="vertical-align:top">
                                                 <asp:Button ID="btnSave" runat="Server" Width="70px" Text="Save" ToolTip="Click here to save the details" ForeColor="White" Visible="true" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnSave_Click" OnClientClick="javascript:return ConfirmMsg()" />
                                             </td>

                                        </tr>

                                       
                                    </table>


                                </asp:Panel>
                            </td>
                        </tr>
                    </table>

                                    </div>



                                </td>

                            </tr>

                        <tr>
                            <td>
                                 <div id="dvUpdatePhysicalStock" runat="server">

                                      <table style="width:100%">
                                       
                                             <tr>
                                                <td  align="center">
                                                    <asp:Label ID="Label1" runat="Server" Text="Batch List" ForeColor="DarkGreen" Font-Names="verdana" Font-Bold="true" Font-Size="Small"></asp:Label>
                                                </td>
                                          
                                        </tr>
                                    </table>

                                     <table>
                                         <tr>
                                             <td>
                                                 <table>

                                                     <tr>

                                                         <td>

                                      <telerik:RadGrid ID="rgUpdatePhysicalStock" GroupingSettings-CaseSensitive="false" Skin="Office2010Blue" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgUpdatePhysicalStock_ItemCommand" Width="900px"  AllowFilteringByColumn="true" 
                                          AllowPaging="false" OnItemDataBound="rgUpdatePhysicalStock_ItemDataBound" OnInit="rgUpdatePhysicalStock_Init"  >
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true"  />
                                            
                                            
                                        </ClientSettings>
                                        <MasterTableView>
                                            
                                          <CommandItemSettings  ShowExportToCsvButton="true" />
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Update" AllowFiltering="false" HeaderStyle-Width="50px" HeaderTooltip="Update:Click to update the physical stock. Verified:Batch is verified.">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="" runat="server" Text="Update" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("pscode") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                               
                                                <telerik:GridBoundColumn HeaderText="BatchCode" HeaderStyle-Width="100px" DataField="pscode" UniqueName="pscode" ReadOnly="true" HeaderTooltip="Automatically assigned and links items in one physical stock verification exercise. Red color indicates batches yet to be verified in full. " FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="100px" DataField="Date" UniqueName="Date" ReadOnly="true" HeaderTooltip="Date when this batch was created. " ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Verified Date" HeaderStyle-Width="100px" DataField="ModifiedDate" UniqueName="ModifiedDate" ReadOnly="true" HeaderTooltip="Date when this batch was Verified. " ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Stock Group" HeaderStyle-Width="100px" DataField="StockGroup" UniqueName="StockGroup" ReadOnly="true" HeaderTooltip="Provisions or Perishables or Consumables" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Category" HeaderStyle-Width="100px" DataField="Category" UniqueName="Category" ReadOnly="true" HeaderTooltip="Either High Value (HV) or Nominal Value (NL) or Low Value (LV )  as defined in the stock master" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" FilterControlWidth="60px" Visible="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Total Items" HeaderStyle-Width="100px" DataField="TotalItem" UniqueName="TotalItem" ReadOnly="true" ItemStyle-HorizontalAlign ="Center" HeaderTooltip="Total No of items in the selected group , category. " HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Batch Count" HeaderStyle-Width="100px" DataField="VerificationItem" UniqueName="VerificationItem" ReadOnly="true" HeaderTooltip="Number of items included in the batch." ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Updated" HeaderStyle-Width="100px" DataField="Verified" UniqueName="Verified" ReadOnly="true" HeaderTooltip="Count of items for which physical stock data has been updated." ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>


                                                <telerik:GridTemplateColumn HeaderText="Report1" UniqueName="psvr1" HeaderTooltip="Working Sheet for physical stock verification"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="center"  ItemStyle-HorizontalAlign="center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" AllowFiltering="false">
                                                                         <ItemTemplate >
                                                                         <%--<asp:TextBox ID="txtphysicalstock" style="text-align:right" runat="server" Text='<%# Eval("PhysicalStock") %>' Width="100px" onkeypress="return isNumberKey(event);" MaxLength="7"></asp:TextBox>--%>

                                                                             <asp:LinkButton ID="lnkpsvr1" runat="server" Text ="PSVR-1" ToolTip="" CommandName="PSVR1" CommandArgument='<%# Eval("pscode") %>' ></asp:LinkButton>
                                                 </ItemTemplate>
                                                 </telerik:GridTemplateColumn>

                                                
                                                 <telerik:GridTemplateColumn  HeaderText="Report2" UniqueName="psvr2" HeaderTooltip="Report after stock verification For posting stock adjustment transactions"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="center"  ItemStyle-HorizontalAlign="center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" AllowFiltering="false" >
                                                                         <ItemTemplate >
                                                                         <%--<asp:TextBox ID="txtphysicalstock" style="text-align:right" runat="server" Text='<%# Eval("PhysicalStock") %>' Width="100px" onkeypress="return isNumberKey(event);" MaxLength="7"></asp:TextBox>--%>

                                                                             <asp:LinkButton ID="lnkpsvr2" runat="server" Text ="PSVR-2" ToolTip="" CommandName="PSVR2" CommandArgument='<%# Eval("pscode") %>'></asp:LinkButton>
                                                 </ItemTemplate>
                                                 </telerik:GridTemplateColumn>

                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>

                                                             </td>

                                                         <td style="vertical-align:top">
                                                             <asp:Label ID="Label3" runat="server" Text="1. Select the items which you wish to include in a verification exercise." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label><br />
                                                             <asp:Label ID="Label4" runat="server" Text="2. All such items are grouped in a batch identified by a unique batch number." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label><br />
                                                             <asp:Label ID="Label5" runat="server" Text="3. Print the PSVR-1 report for an open batch. The Stock verifier will have to note down the physical stock in this working sheet." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label><br />
                                                             <asp:Label ID="Label6" runat="server" Text="4. The physical stock is updated for the respective items.  Use the Update option." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label><br />
                                                             <asp:Label ID="Label7" runat="server" Text="5. Print the PSVR-2 report for a completed batch. This report now contains the physical stock and the stock in the system." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label><br />
                                                             <asp:Label ID="Label8" runat="server" Text="6. Decide what to do with the discrepancy and post appropriate adjustment transaction." Font-Names="verdana" ForeColor="Gray" Font-Size="Smaller"></asp:Label>
                                                         </td>

                                                         </tr>

                                                     </table>

                                             </td>
                                         </tr>
                                     </table>

                                 </div>

                                <div id="dvUpdateStock" runat="server">
                                    <table>

                                        <tr>
                                            <td>
                                                <asp:Label ID="lblcPScode" runat="server" Text="Batch :" Font-Names="verdana" ForeColor="DarkBlue" Font-Size="Medium" ></asp:Label>
                                                <asp:Label ID="lblPSCode" runat="server" Text="" Font-Names="verdana" ForeColor="DarkBlue" Font-Size="Medium"></asp:Label>
                                                <asp:Label ID="lblcdate" runat="server" Text=" Date :" Font-Names="verdana" ForeColor="DarkBlue" Font-Size="Medium" ></asp:Label>
                                                <asp:Label ID="lblDate" runat="server" Text="" Font-Names="verdana" ForeColor="DarkBlue" Font-Size="Medium"></asp:Label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label2" runat="server" Text="Enter the physical stock available, in the Physical stock field.  Cannot change it once a value is entered. " Font-Names="verdana" ForeColor="Gray" Font-Size="Small" ></asp:Label>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                            <telerik:RadGrid ID="rgUpdateStock" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                                                Height="350px" Width="900px" AllowFilteringByColumn="true" AllowSorting="true"  Skin="WebBlue" AllowMultiRowSelection="true" OnItemDataBound ="rgUpdateStock_ItemDataBound">
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
                                                                            Display="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="ItemCode" HeaderText="Item Code" UniqueName="RMCode"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="rmname" HeaderText="Item Name" UniqueName="RMName"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" UniqueName="IssueUOM"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Either High Value (HV) or Nominal Value (NL) or Low Value (LV )  as defined in the stock master">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="StockGroup" HeaderText="Group" UniqueName="StockGroup"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Provisions or Perishables or Consumables">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                         <telerik:GridTemplateColumn DataField="PhysicalStock" HeaderText="Physical Stock" UniqueName="Physicalstock" HeaderTooltip="Enter the physical stock available -1 means physical stock is not yet updated."
                                                                                Visible="true" HeaderStyle-HorizontalAlign="Right"  ItemStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small">
                                                                         <ItemTemplate >
                                                                         <asp:TextBox ID="txtphysicalstock" style="text-align:right" runat="server" Text='<%# Eval("PhysicalStock") %>' Width="100px" onkeypress="return isNumberKey(event);" MaxLength="7"></asp:TextBox>
                                                                         </ItemTemplate>
                                                                         </telerik:GridTemplateColumn>

                                                                       <%-- <telerik:GridBoundColumn DataField="ClosingStock" HeaderText="Closing Stock" UniqueName="ClosingStock"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="right">
                                                                            <HeaderStyle HorizontalAlign="right"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="right"></ItemStyle>
                                                                        </telerik:GridBoundColumn>--%>

                                                                    </Columns>
                                                                </MasterTableView>
                                                            </telerik:RadGrid>
                                            </td>
                                            <td  style="vertical-align:top">
                                                <asp:Button ID="btnStockUpdate" runat="Server" Width="70px" Text="Update" ToolTip=" Be careful . Once  you enter a value  you will not be able to correct it." ForeColor="White" Visible="true" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnUpdate_Click1" OnClientClick="javascript:return UpdateConfirmMsg()" />
                                                <asp:Button ID="BtnExcelExport" Width="70PX" Font-Bold="true" Text="Report" OnClick="BtnExcelExport_Click" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here to print a report (export the details) of a fully verified batch  to a spreadsheet, for passing adjustment transactions. You can print a report only after the values are updated for all items in the batch."  />
                                                <asp:Button ID="btnReturn" runat="Server" Width="70px" Text="Return" ToolTip="Click here to return back." ForeColor="White" Visible="true" BackColor="Orange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnReturn_Click"  />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                            </td>
                        </tr>

                     </table>   


                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSave" />
                    <asp:PostBackTrigger ControlID="btnStockUpdate" />
                    <asp:PostBackTrigger ControlID="BtnExcelExport" />
                    <asp:PostBackTrigger ControlID="rgUpdatePhysicalStock" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
