<%@ Page Title="Food Ingredients" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="RawMaterial.aspx.cs" Inherits="RawMaterial" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
     <style type="text/css">

    .RadGrid th.rgHeader
    {
        background-image: none;
        background-color:  #196F3D;
        color:white;
        font-weight:bold;
    }
    .form-controlForResidentAdd {
  /*display: block;*/
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
</style>
    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += RMCodeVal();
            summ += RMNameVal();
            summ += RMCSVal();
            if (summ == "") {
                var x = confirm('Do you want to save?');
                if (x) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert(summ);
                return false;
            }
        }
        function RMCodeVal() {
            var door = document.getElementById('<%= txtRMCode.ClientID %>').value;
            if (door == "") {
                return "Please enter the Code." + "\n";
            } else {
                return "";
            }
        }
        function RMNameVal() {
            var door = document.getElementById('<%= txtRMName.ClientID %>').value;
            if (door == "") {
                return "Please enter the Name." + "\n";
            } else {
                return "";
            }
        }

        function RMCSVal() {
            var door = document.getElementById('<%= txtClosingStock.ClientID %>').value;
            if (door == "") {
                return "Please enter the closing stock." + "\n";
            } else {
                return "";
            }
        }
        function ConfirmUpdate() {
            var x = confirm('Do you want to Update?');
            if (x) {
                return true;
            } else {
                return false;
            }
        }
        function ConfirmDelete() {
            var x = confirm('Do you want to Delete?');
            if (x) {
                return true;
            } else {
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="font-family: Verdana; font-size: small; min-height: 400px;">
                        <asp:HiddenField ID="hbtnRSN" runat="server" />

                        <table style="width: 100%;">
                            <tr>
                                <td align="center" style="width:80%">

                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                    <asp:HiddenField ID="hdnRSN" runat="server" />
                                </td>

                                <td align="right" style="width:20%">
                                    <%--<asp:LinkButton ID="lnkvegetableprice" runat="server" ForeColor="Green" Font-Names="Verdana" OnClick="lnkvegetableprice_Click" Text ="Vegetables-daily-price" Font-Underline="true" ToolTip="Click here to show daily price list of vegetables. It shows based on your country,state and city."></asp:LinkButton>--%>
                                    <asp:LinkButton ID="lnkvegetableprice" runat="server" ForeColor="Green" Font-Names="Verdana" OnClick="lnkvegetableprice_Click" Text ="Vegetables-daily-price" Font-Underline="true" ToolTip="Click here to show daily price list of vegetables and groceries."></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="width: 100%;">
                            <tr style="width: 100%;">
                                <td style="width: 40%; vertical-align: top;">
                                    <table cellspacing="3" cellpadding="3">

                                        <tr>
                                            <td>Code 
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRMCode" ReadOnly="false" ToolTip="Unique code for each Food Item.Upto Eight alphanumeric characters." Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="150px" MaxLength="8"></asp:TextBox>
                                            </td>
                                            <td>Available Stock           
                                                 <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtClosingStock" ToolTip="Shows available stock" Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="150px" MaxLength="10" Text="0" Enabled="false" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Name
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRMName" ToolTip="Name of the item. Ex: Raw Rice,Toor Dal,Ponni Rice, Basmati Rice." Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="250px" MaxLength="24"></asp:TextBox>
                                            </td>
                                            <td>Avg.Rate           
                                                 <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRate" ToolTip="Shows avg.rate" Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="150px" MaxLength="10" Text="0" Enabled="false" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                            </td>
                                            
                                        </tr>

                                        <tr>
                                            <td>UOM                                         
                                            </td>
                                            <td>

                                                <asp:DropDownList ID="ddlIUOM" ToolTip="Unit Of Measurement" Width="150px" CssClass="form-controlForResidentAdd" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small">
                                                </asp:DropDownList>
                                            </td>
                                            <td>ReOrder Level          
                                                 <text style="color: red;"></text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtReorderlevel" ToolTip="Reorderlevel" Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="150px" MaxLength="10" Text="0" Enabled="true" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                            </td>
                                            
                                        </tr>
                                        <tr>
                                            <td>Category                                         
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCategory" ToolTip="HL-High Value,NV-Normal Value,LV-Low Value" Width="150px" CssClass="form-controlForResidentAdd" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small">
                                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="High Value" Value="High Value"></asp:ListItem>
                                                    <asp:ListItem Text="Average Value" Value="Average Value"></asp:ListItem>
                                                    <asp:ListItem Text="Low Value" Value="Low Value"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td>MinStock         
                                                 <text style="color: red;"></text>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtminstock" ToolTip="Minimum stock" Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="150px" MaxLength="10" Text="0" Enabled="true" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                            </td>
                                            
                                        </tr>

                                        <tr>
                                            <td>Group                                         
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlGroup" ToolTip="Provisions  - Also refers to Groceries . Ex: Rice, Oil,  Wheat, Pulses etc.
                                                 Fruits & Vegetables -    Also refers to Vegetables, Fruits, Milk, Egg etc    
                                                 Consumables -   Refers to items such as Paper cups, paper plates,  Plastic spoons, tissue box,  Plantain leaf , Cooking Gas  etc."
                                                    Width="150px" CssClass="form-controlForResidentAdd" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small">
                                                </asp:DropDownList>
                                            </td>
                                            <td>Supplier                                        
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSupp" ToolTip="Names of the different suppliers." Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Height="50px" TextMode="MultiLine" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                            
                                        </tr>

                                        <tr>
                                            <td>Remarks                                        
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" ToolTip="Enter if there is any remarks" Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Height="50px" TextMode="MultiLine" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:DropDownList ID="ddlStatus" Visible="false" runat="server" CssClass="form-controlForResidentAdd" Width="150px" Font-Names="verdana">
                                                    <asp:ListItem Text="Very High" Value="VH"></asp:ListItem>
                                                    <asp:ListItem Text="High" Value="HI" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="Low" Value="LO"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <telerik:RadDatePicker ID="dtpClosingStk" runat="server" Culture="English (United Kingdom)"
                                                    ReadOnly="true" ToolTip="" CssClass="form-controlForResidentAdd"
                                                    Width="155px" Enabled="false" Visible="false">
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

                                        <%-- <tr>
                                            <td>Opening Stock   
                                                 <text style="color: red;">*</text>                                     
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtOpeningStock" ToolTip="Opening stock of the item" Font-Names="verdana" runat="server" Height="25px" Width="150px" MaxLength="10" onkeypress="return isNumberKey(event);"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>

                                            <td>Opening Stock As of                                       
                                            </td>
                                            <td>
                                                <telerik:RadDatePicker ID="dtpOpeningStk" runat="server" Culture="English (United Kingdom)"
                                                    CssClass="TextBox" ReadOnly="true" ToolTip=""
                                                    Width="155px" Enabled="false">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" CssClass="TextBox"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                            </td>

                                        </tr>--%>
                                        <%-- <tr>
                                            <td>Receipt UOM                                         
                                            </td>
                                            <td>

                                                <asp:DropDownList ID="ddlRUOM" ToolTip="Unit Of Measurement where the item received." Width="150px" Height="25px" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Button ID="btnSave" OnClientClick="return Validate();" ToolTip="Click here to save the ingredients details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" CssClass="btn btn-success"  />
                                                <asp:Button ID="btnUpdate" OnClientClick="return ConfirmUpdate();" ToolTip="Click here to update the ingredients details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" CssClass="btn btn-success" />
                                                <asp:Button ID="btnDelete" Visible="false" OnClientClick="return ConfirmDelete();" ToolTip="Click here to delete the food ingredients." OnClick="btnDelete_Click" runat="server" Text="Delete" ForeColor="White" BackColor="DarkBlue" CssClass="btn btn-success" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BorderColor="Gray" BackColor="DarkOrange" CssClass="btn btn-success"  OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BorderColor="Gray" BackColor="DarkBlue" CssClass="btn btn-success"  />
                                            </td>
                                        </tr>
                                    </table>
                                </td>

                            </tr>

                            <tr>

                                <td style="width: 60%; margin-right: 10%">
                                    <table>
                                        <tr>
                                            <td style="width:80%">
                                                <asp:Label ID="lblhelp" runat="server" Width="70%" Text="Provisions -Also refers to Groceries . Ex: Rice, Oil,  Wheat, Pulses etc.Perishables -Also refers to Vegetables, Fruits, Milk, Egg etc.Consumables-Refers to items such as Paper cups, paper plates,  Plastic spoons, tissue box,  Plantain leaf , Cooking Gas etc." Font-Names="verdana" ForeColor="Gray" Font-Size="X-Small"></asp:Label>
                                            </td>
                                            <td style="width:20%">
                                                <asp:Button ID="BtnExcelExport"  Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExport_Click" BackColor="#7049BA" ForeColor="White" BorderColor="GrayText" runat="server" CssClass="btn btn-success" ToolTip="Click here export grid details to excel." />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                <td style="width: 60%; vertical-align: top;">



                                    <telerik:RadGrid ID="gvRawMaterial" MasterTableView-EnableNoRecordsTemplate="true" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                         AutoGenerateColumns="false" OnItemCommand="gvRawMaterial_ItemCommand" Height="330px" Width="1100px" 
                                        AllowFilteringByColumn="true" AllowPaging="false" PageSize="10" OnInit="gvRawMaterial_Init">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the food ingredients details" runat="server" Text="Edit" ForeColor="Blue" CommandName="UpdateRow" CommandArgument='<%# Eval("RSN") %>' OnClick="LnkEditItem_Click"></asp:LinkButton>
                                                        <%-- CommandName="UpdateRow"  CommandArgument='<%# Eval("RSN") %>'--%>
                                                    </ItemTemplate>

                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn HeaderText="RSN" HeaderStyle-Width="75px" FilterControlWidth="50px" DataField="RSN" ReadOnly="true" Display="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Group" HeaderStyle-Width="90px" HeaderStyle-HorizontalAlign="Center" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Center" DataField="StockGroup" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Code" HeaderStyle-Width="100px" FilterControlWidth="50px" DataField="RMCode" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="100px" FilterControlWidth="50px" DataField="RMName" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="UOM" HeaderStyle-Width="90px" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="UOM" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Avg.Rate" HeaderStyle-Width="90px" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="right" DataField="AvgRate" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Closing Stock" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Center" DataField="ClosingStock" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Category" HeaderStyle-Width="90px" FilterControlWidth="50px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" DataField="Category" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Supplier" HeaderStyle-Width="150px" DataField="Supplier" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="ReOrder Level" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Center" DataField="ReOrderLevel" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Min.Stock" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Center" DataField="MinStock" ReadOnly="true"></telerik:GridBoundColumn>



                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                    <br />
                                    <text style="color: gray; font-family: Verdana; font-size: smaller;">
                                        Define here the names of important Provisions/Groseries that are used in the preparation of different menu items.<br />
                                        Exampless: Sugar, Wheat, Raw Rice,  Boiled Rice, Ghee, Cooking Oil , Toor Dal,  Urd Dal etc.<br />
                                        This master is used later when you wish to define which Item is used in which food menu. Very useful to estimate quantity of an ingredient needed for cooking.<br />

                                        DEFINING SUCH INFORMATION IS A BIG STEP TOWARDS COST SAVINGS & AVOIDANCE OF WASTAGE IN THE KITCHEN.
                                    </text>
                                </td>
                            </tr>

                        </table>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="BtnExcelExport" />
                    <asp:PostBackTrigger ControlID="lnkvegetableprice" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

