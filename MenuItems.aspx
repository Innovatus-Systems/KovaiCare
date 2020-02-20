<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuItems.aspx.cs" MasterPageFile="~/CovaiSoft.master" Inherits="MenuItems" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
     <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

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

                     <table style="width: 100%">
                                        <tr>
                                            <td style="text-align: center">
                                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>

                     <div id="dvMenuItems" runat="server" style="width: 100%">

                          <asp:HiddenField ID="CnfResult" runat="server" />

                                        <asp:LinkButton ID="lnkMenuItem" runat="server" Text="+ Add a new Menu Item" Font-Underline="false" ForeColor="#000066" Font-Names="Calibri" Font-Size="Medium" Font-Bold="true" ToolTip="You can add a new food menu item to the master by clicking here." OnClick="lnkMenuItem_Click"></asp:LinkButton>
                                       
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
                                                                    <asp:TextBox ID="ItemCode" runat="Server" MaxLength="12" CssClass="form-control" ToolTip="Enter Unique code for the item ML12." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium" Enabled="false"></asp:TextBox>
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
                                                                    <asp:TextBox ID="ItemName" runat="Server" MaxLength="20" CssClass="form-control" ToolTip="Enter Item name ML20." Width="250px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label11" runat="Server" Text="Units" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <%-- Help : Dropdown --%>
                                                                    <asp:DropDownList ID="ddlUOM" ToolTip="Select Unit Of Measurement for the particular item ML10." CssClass="form-control" Width="150px"  runat="server"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label12" runat="Server" Text="Category" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlitmCategory" ToolTip="Define whether this is a Main Dish (Ex: Idly , Bread)  or a Side Dish (Ex: Sambhar , Jam)." CssClass="form-control" Width="150px"  runat="server"
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
                                                                    <asp:DropDownList ID="ddlitmType" ToolTip="You can group items of same family together. Ex: Different varieties of Rice, Different types of Sambhar." CssClass="form-control" Width="150px"  runat="server"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>

                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label90" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlMISession" ToolTip="Choose the session where you wish to include the Menu Item." CssClass="form-control" Width="200px" runat="server" AutoPostBack="true"
                                                                        Font-Names="Calibri" Font-Size="Small">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label91" runat="Server" Text="Serve Qty" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtMIServeQty" runat="Server" Text="0" MaxLength="12" CssClass="form-control" ToolTip="Enter here the usual serving quantity per person. Though need not be 100% accurate, try to be close. This will help in forecasting properly and will avoid wastage." Width="200px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label41" runat="Server" Text="Qty Alert" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtQtyAlert" runat="Server" MaxLength="12" Text="0" CssClass="form-control" ToolTip=" If the quantity to be prepared for a session, exceeds this value, it is highlighted.  Helps to decide on getting the ingredients and to plan for the cooking." Width="150px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label51" runat="Server" Text="Rate" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtRate" runat="Server" MaxLength="12" Text="0" CssClass="form-control" ToolTip="The amount to be charged for the menu item if the billing is menu item based." Width="150px"  ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label42" runat="Server" Text="Lead Time" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtLeadTime" runat="Server" MaxLength="12" Text="0" CssClass="form-control" ToolTip=" Some items mayu need to planned atleast a few days in advance. Example Dosa / Idly Batter.  Set the lead time to avoid last minute hassles." Width="150px"  ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                </td>
                                                            </tr>


                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label33" runat="Server" Text="Contains" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtRemarks" runat="Server" MaxLength="2400" CssClass="form-control" TextMode="MultiLine"  ToolTip=" Describe all items served along with this menu item. Ex: Dosa will be served with Sambhar and Chutney." Width="300px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                                                </td>

                                                            </tr>

                                                            <tr>
                                                                <td style="text-align: center" colspan="2">
                                                                    <asp:Button ID="btnSaveItm" runat="Server" CssClass="btn btn-success" Text="Save" ToolTip="Click here to save the details" ForeColor="White" BackColor="DarkGreen"  Font-Size="Medium" OnClick="btnSaveItem_Click" OnClientClick="javascript:return validate()" />
                                                                    <asp:Button ID="btnUpteItm" runat="Server" CssClass="btn btn-success" Text="Update" ToolTip="Click here to Update the details" ForeColor="White" BackColor="DarkGreen"  Font-Size="Medium" OnClick="btnUpteItm_Click" OnClientClick="javascript:return TaskConfirmMsgET()" />
                                                                    <asp:Button ID="btnClearItm" runat="Server" CssClass="btn" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="White" BackColor="DarkOrange"  Font-Size="Medium" OnClick="btnClearItm_Click" />
                                                                    <asp:Button ID="btnCloseItm" runat="Server" CssClass="btn" Text="Close" ToolTip="Click here to close" ForeColor="White" BackColor=" DarkBlue " Font-Size="Medium" OnClick="btnCloseItm_Click" />

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


                                                        <telerik:RadGrid ID="rdgItemList" runat="server" CssClass="table table-bordered table-hover" Skin="WebBlue" AutoGenerateColumns="False"
                                                            Height="350px" Width="900px" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="false" 
                                                            PageSize="10" OnItemCommand="rdgItemList_ItemCommand" OnInit="rdgItemList_Init">
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
                                                                            <asp:LinkButton ID="LnkEditItemMaster" runat="server" Text="Edit" ToolTip="Click here to edit the statndard menu" Font-Names="verdana" OnClick="LnkEditItemMaster_Click1" ForeColor="Blue" Font-Size="Smaller"></asp:LinkButton>
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


                 </ContentTemplate>
                <Triggers>
                    
                </Triggers>

            </asp:UpdatePanel>

            </div>
        </div>
 
</asp:Content>
