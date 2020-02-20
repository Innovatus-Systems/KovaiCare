<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ItemMaster.aspx.cs" Inherits="ItemMaster" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">

        function TaskConfirmMsg() {

            var result = confirm('Do you want to save the new item?');
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
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }

    </script>
     <script type="text/javascript">
         function validate() {
             var summ = "";
             summ += ItemName();
             summ += ItemCode();
             summ += Remarks();

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
        function Remarks() {
            var Val = document.getElementById('<%=txtRemarks.ClientID%>').value;
            if (Val == "") {
                return "Please enter Features" + "\n";
            }
            else {
                return "";
            }
        }

    </script>

    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 99%;">
               
                <table>
                    <tr>
                        <td>
                             
                     
                             <asp:Button ID="btnreturnfromlevelISettings" runat="server" Text="Return" CssClass="btn btn-info" Visible="true" 
                                                                            OnClick="btnreturnfromlevelISettings_Click"  ToolTip="Click here to return Settings." />
                            <asp:Label ID="lbllevelH" Visible="true" Text="Level I - Item Master"
                                Font-Bold="true" ForeColor="Blue" Font-Size="Medium" runat="server" />
                      
                        </td>
                    </tr>
                </table>
                 <table>
                    <tr>
                        <td>
                            <table>
                               
                                <tr>
                                    <td>
                                          <asp:HiddenField ID="CnfResult" runat="server" />
                                        <asp:Label ID="lblItemCode" runat="Server" Text="Item Code" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    </td>
                                   
                                    <td>
                                        <asp:TextBox ID="ItemCode" runat="Server" MaxLength="12" ToolTip="Enter Unique code for the item ML12." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                    </td>
                                     <td rowspan="3" style="width:300px">

                                    </td>
                                    <td rowspan="3" style="width:500px">
                                         <asp:Label ID="lblHelptext" runat="server" Width="500px" Height="100px" Font-Names="Verdana" Font-Size="Smaller">Define all the Food Items that will be served for the residents.  A Food Item must be present here before it can be included in the Daily Menu.  Describe the Menu Item in detail, if needed.</asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblItemName" runat="Server" Text="Item Name" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="ItemName" runat="Server" MaxLength="20" ToolTip="Enter Item name ML20." Width="250px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblUOM" runat="Server" Text="UOM" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    </td>
                                    <td>
                                        <%-- Help : Dropdown --%>
                                        <asp:DropDownList ID="ddlUOM" ToolTip="Select Unit Of Measurement for the particular item ML10." Width="150px" Height="25px" runat="server" AutoPostBack="true"
                                            Font-Names="Calibri" Font-Size="Small">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCategory" runat="Server" Text="Category" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlCategory" ToolTip="Choose Diabetic if the food is advised for people with Diabetic.  If the food is special for certain residents only as advised by Doctor, choose Special. Else keep it Normal." Width="150px" Height="25px" runat="server" AutoPostBack="true"
                                            Font-Names="Calibri" Font-Size="Small">
                                        </asp:DropDownList>

                                    </td>
                                   

                                </tr>
                                <tr>
                                    <td>
                                         <asp:Label ID="Label1" runat="Server" Text="Salient features" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    </td>
                                    <td>
                                         <asp:TextBox ID="txtRemarks" runat="Server" MaxLength ="2400" TextMode ="MultiLine" Height ="50px" ToolTip="Include here special features about the Dish." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    
                                    <td   colspan ="2" style ="vertical-align:central">
                                        <asp:Button ID="btnSave" runat="Server" Width="100px" Text="Save" ToolTip="Click here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" Font-Size="Medium"  OnClick="btnSaveItem_Click" OnClientClick="javascript:return validate()"/>
                                        <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnClear_Click" />
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                </table>

                <table>
                    <tr>
                        <td style="width: 1300px">


                            <telerik:RadGrid ID="rdgItemList" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False"
                                Height="250px" Width="800px" AllowFilteringByColumn="true" AllowSorting="true" AllowPaging="true" PageSize="10">
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


                                        <telerik:GridBoundColumn DataField="RSN" HeaderText="RSN" UniqueName="RSN" Display="false" SortExpression="RSN"
                                             HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                            <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" ></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="ItemCode" HeaderText="Item Code" UniqueName="ItemCode" SortExpression="ItemCode"
                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                            <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="ItemName" HeaderText="Item Name" UniqueName="ItemName" SortExpression="ItemName"
                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" >
                                            <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" ></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" UniqueName="UOM" SortExpression="UOM"
                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" >
                                            <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Category" HeaderText="Category" UniqueName="Category" SortExpression="Category"
                                            Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" >
                                            <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left" ></ItemStyle>
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

            </div>
        </div>
    </div>
</asp:Content>

