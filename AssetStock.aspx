<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AssetStock.aspx.cs" Inherits="AssetStock" MasterPageFile="~/CovaiSoft.master" %>

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

            var result = confirm('Do you want to save the asset verification details?');

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

            var result = confirm('Do you want to update the asset verification details?');

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

                     <table style="width: 20%;">

                            <tr>
                                <td>
                                    <asp:Button ID="btnNewBatchCode" runat="server" Text="New Batch" ToolTip="Click here to select items for which you wish to do a physical stock verification.  One batch can contain many items but always of the same category.  Caution:  DO not have any transactions when the physical stock verification is going on." CssClass="button_example" OnClick="btnNewBatchCode_Click" />
                                </td>
                                <td>
                                    <asp:Button ID="btnAssetUpdate" runat="server" Text="Update Assets" ToolTip="Use this option after you have done the asset verification and have collected information about the actual assets in the stores.  Here you are now expected to select the right batch and enter the values.  The comparison between System  and the Physical asset will be done internally.   Later you may have to do Adjustment + or -  or Write Off or asset Returns  in asset Transactions to sync the system stock with the physical stock." CssClass="button_example" OnClick="btnAssetUpdate_Click" />
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
                                                    <asp:Label ID="Label39" runat="Server" Text="Select department for asset verification" ForeColor="DarkGreen" Font-Names="verdana" Font-Bold="true" Font-Size="Small"></asp:Label>
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
                            <td>Department                                         
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDepartment" ToolTip="" Width="150px" Height="25px" runat="server"
                                    Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlDepartment_SelectedIndexChanged" AutoPostBack="true" >
                                </asp:DropDownList>
                            </td>
                            <td>Type                                         
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlType" ToolTip="" Width="150px" Height="25px" runat="server"
                                    Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Accessory" Value="Accessory"></asp:ListItem>
                                    <asp:ListItem Text="Building" Value="Building"></asp:ListItem>
                                    <asp:ListItem Text="Computer" Value="Computer"></asp:ListItem>
                                    <asp:ListItem Text="Crockery" Value="Crockery"></asp:ListItem>
                                    <asp:ListItem Text="Cutlery" Value="Cutlery"></asp:ListItem>
                                    <asp:ListItem Text="Equipment" Value="Equipment"></asp:ListItem>
                                    <asp:ListItem Text="Furniture" Value="Furniture"></asp:ListItem>
                                    <asp:ListItem Text="Machine" Value="Machine"></asp:ListItem>
                                    <asp:ListItem Text="Software" Value="Software"></asp:ListItem>
                                    <asp:ListItem Text="Vehicle" Value="Vehicle"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>

                    </table>
                        <table>
                                         
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
                                                                Height="350px" Width="900px" AllowFilteringByColumn="true" AllowSorting="true"  
                                                                OnItemDataBound="rgPhysicalStock_ItemDataBound" Skin="WebBlue" AllowMultiRowSelection="true" OnInit="rgPhysicalStock_Init">
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

                                                                        <telerik:GridBoundColumn DataField="Assetcode" HeaderText="Code" UniqueName="Assetcode"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="AssetName" HeaderText="Name" UniqueName="AssetName"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="DeptName" HeaderText="Department" UniqueName="DeptName"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="AssetType" HeaderText="Type" UniqueName="AssetType"
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
                                      <telerik:RadGrid ID="rgUpdatePhysicalStock" GroupingSettings-CaseSensitive="false" Skin="Office2010Blue" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="rgUpdatePhysicalStock_ItemCommand" Width="900px"  AllowFilteringByColumn="true"
                                           AllowPaging="false" OnItemDataBound="rgUpdatePhysicalStock_ItemDataBound"  OnInit="rgUpdatePhysicalStock_Init"  >
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true"  />
                                            
                                            
                                        </ClientSettings>
                                        <MasterTableView>
                                            
                                          <CommandItemSettings  ShowExportToCsvButton="true" />
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Update" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to update the physical stock verification details." runat="server" Text="Update" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("pscode") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                               
                                                <telerik:GridBoundColumn HeaderText="BatchCode" HeaderStyle-Width="100px" DataField="pscode" UniqueName="pscode" ReadOnly="true" HeaderTooltip="Automatically assigned and links items in one physical stock verification exercise." FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Date" HeaderStyle-Width="100px" DataField="Date" UniqueName="Date" ReadOnly="true" HeaderTooltip="Date when this batch was created. " ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Department" HeaderStyle-Width="100px" DataField="DeptName" UniqueName="DeptName" ReadOnly="true" HeaderTooltip="Date when this batch was created. " ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Total Items" HeaderStyle-Width="100px" DataField="TotalItem" UniqueName="TotalItem" ReadOnly="true" ItemStyle-HorizontalAlign ="Center" HeaderTooltip="Total No of items in the selected group , category. " HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Batch Count" HeaderStyle-Width="100px" DataField="VerificationItems" UniqueName="VerificationItems" ReadOnly="true" HeaderTooltip="Number of items included in the batch." ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Updated" HeaderStyle-Width="100px" DataField="Verified" UniqueName="Verified" ReadOnly="true" HeaderTooltip="Count of items for which physical stock data has been updated." ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="60px"></telerik:GridBoundColumn>

                                                 <telerik:GridTemplateColumn HeaderText="Report1" UniqueName="psvr1" HeaderTooltip="Working Sheet for asset verification"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="center"  ItemStyle-HorizontalAlign="center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" AllowFiltering="false">
                                                                         <ItemTemplate >
                                                                         <%--<asp:TextBox ID="txtphysicalstock" style="text-align:right" runat="server" Text='<%# Eval("PhysicalStock") %>' Width="100px" onkeypress="return isNumberKey(event);" MaxLength="7"></asp:TextBox>--%>

                                                                             <asp:LinkButton ID="lnkpsvr1" runat="server" Text ="AVR-1" ToolTip="" CommandName="PSVR1" CommandArgument='<%# Eval("pscode") %>' ></asp:LinkButton>
                                                 </ItemTemplate>
                                                 </telerik:GridTemplateColumn>

                                                
                                                 <telerik:GridTemplateColumn  HeaderText="Report2" UniqueName="psvr2" HeaderTooltip="Report after asset verification For posting asset adjustment transactions"
                                                                                Visible="true" HeaderStyle-HorizontalAlign="center"  ItemStyle-HorizontalAlign="center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" AllowFiltering="false" >
                                                                         <ItemTemplate >
                                                                         <%--<asp:TextBox ID="txtphysicalstock" style="text-align:right" runat="server" Text='<%# Eval("PhysicalStock") %>' Width="100px" onkeypress="return isNumberKey(event);" MaxLength="7"></asp:TextBox>--%>

                                                                             <asp:LinkButton ID="lnkpsvr2" runat="server" Text ="AVR-2" ToolTip="" CommandName="PSVR2" CommandArgument='<%# Eval("pscode") %>'></asp:LinkButton>
                                                 </ItemTemplate>
                                                 </telerik:GridTemplateColumn>

                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
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

                                                                        <telerik:GridBoundColumn DataField="AssetCode" HeaderText="Asset Code" UniqueName="AssetCode"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="AssetName" HeaderText="Asset Name" UniqueName="AssetName"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                                            <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="DeptName" HeaderText="Department" UniqueName="DeptName"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                                            <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                        </telerik:GridBoundColumn>

                                                                        <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type"
                                                                            Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderTooltip="Either High Value (HV) or Nominal Value (NL) or Low Value (LV )  as defined in the stock master">
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
                                                <asp:Button ID="btnStockUpdate" runat="Server" Width="70px" Text="Update" ToolTip=" Be careful . Once  you enter a value  you will not be able to correct it." ForeColor="White" Visible="true" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnStockUpdate_Click" OnClientClick="javascript:return UpdateConfirmMsg()" />
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
