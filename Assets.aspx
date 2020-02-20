<%@ Page Title="Assets" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="Assets.aspx.cs" Inherits="Assets" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += AssetcodeVal();
            summ += AssNameVal();
            summ += DescVal();
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
        function AssetcodeVal() {
            var door = document.getElementById('<%= txtAssetcode.ClientID %>').value;
            if (door == "") {
                return "Please enter Asset Code." + "\n";
            } else {
                return "";
            }
        }
        function AssNameVal() {
            var door = document.getElementById('<%= txtAssetName.ClientID %>').value;
            if (door == "") {
                return "Please enter Asset Name." + "\n";
            } else {
                return "";
            }
        }
        function DescVal() {
            var door = document.getElementById('<%= txtdesc.ClientID %>').value;
            if (door == "") {
                return "Please enter Description." + "\n";
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
    </script>
    <style type="text/css">
        .HelpMsg {
            color: gray;
            font-size: x-small;
            font-family: Verdana;
            vertical-align: top;
        }
    </style>
    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
    <style type="text/css">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <div style="width: 100%; font-family: Verdana; font-size: small;">
                <asp:HiddenField ID="hbtnRSN" runat="server" />

                <table style="width: 100%;">
                    <tr>
                        <td align="center">
                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" cellspacing="5" cellpadding="5">
                     <tr>
                        <td colspan="2" align="left">
                            <asp:Label ID="lblSold" runat="server" Font-Size="Small" Font-Bold="true" Font-Names="Verdana" ForeColor="Black" Text="Assets - In Use :"></asp:Label>
                        </td>
                        <td colspan="2" align="right">
                            <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn" Font-Bold="true" Text="Export Excel" OnClick="BtnnExcelExport_Click" BackColor="DarkGreen" ForeColor="White" ToolTip="Click here to export grid data in excel." />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">

                            <telerik:RadGrid ID="gvAssets" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" 
                                runat="server" AutoGenerateColumns="false" OnItemCommand="gvTaskLkup_ItemCommand" Width="100%" Height="300px" 
                                AllowFilteringByColumn="true" AllowPaging="false"  OnInit="gvAssets_Init">
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the assets details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="Code" DataField="AssetCode" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="100px" DataField="Assetname" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="Type"  DataField="Assettype" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="Department"  DataField="DeptName" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridDateTimeColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Warranty Ends" DataField="Warrantyend" ReadOnly="true"></telerik:GridDateTimeColumn>
                                        <telerik:GridDateTimeColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="AMC Ends" DataField="AMCEnd" ReadOnly="true"></telerik:GridDateTimeColumn>
                                        <telerik:GridDateTimeColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Insurance Ends" DataField="InsuranceEnd" ReadOnly="true"></telerik:GridDateTimeColumn>
                                                                            </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>
                            <telerik:RadGrid ID="gvAssets2" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" OnItemCommand="gvTaskLkup_ItemCommand" Width="100%" AllowFilteringByColumn="true" AllowPaging="true" PageSize="10">
                                <MasterTableView>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the assets details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="Code" DataField="AssetCode" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="100px" DataField="Assetname" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Mode" HeaderStyle-Width="100px" DataField="Assetmode" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridDateTimeColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Warranty End Date" DataField="Warrantyend" ReadOnly="true"></telerik:GridDateTimeColumn>
                                        <telerik:GridDateTimeColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="AMC End Date" DataField="AMCEnd" ReadOnly="true"></telerik:GridDateTimeColumn>
                                        <telerik:GridDateTimeColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150px" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Insurance End Date" DataField="InsuranceEnd" ReadOnly="true"></telerik:GridDateTimeColumn>
                                        <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="Vendor" DataField="Vendor" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Vendor contact" HeaderStyle-Width="100px" DataField="Vendorcontactno" ReadOnly="true"></telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="Type" Visible="false" DataField="Assettype" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="100px" DataField="Assetstatus" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderStyle-HorizontalAlign="Center" Visible="false" ItemStyle-HorizontalAlign="Center" HeaderText="Engineer Contactno" HeaderStyle-Width="200px" DataField="AssigneeContactno" ReadOnly="true"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Description" Visible="false" HeaderStyle-Width="200px" DataField="Description" ReadOnly="true"></telerik:GridBoundColumn>
                                    </Columns>
                                </MasterTableView>
                            </telerik:RadGrid>

                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" cellspacing="5" cellpadding="5">

                    <tr>
                        <td width="70%">
                            <table style="width: 100%;" cellpadding="5" cellspacing="5">
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Asset Type :</text>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlAssettype" ToolTip="Define the type of the asset so that it is easy to locate it later." runat="server" Width="150px" CssClass="form-controlForResidentAdd">
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
                                </tr>
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Department :</text>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDepartment" ToolTip="Define the deparment of the asset so that it is easy to locate it later." runat="server" Width="150px" CssClass="form-controlForResidentAdd">
                                       </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Asset Code :</text>
                                        <text style="color: red; font-size: smaller;">*</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAssetcode" ReadOnly="true" MaxLength="8" ToolTip="Unique code for the Asset.ML 8." runat="server" Width="150px" CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                </tr>
                                
                                <tr>

                                    <td>
                                        <text style="font-weight: bold;">Asset Name :</text>
                                        <text style="color: red; font-size: smaller;">*</text>
                                    </td>
                                    <td>
                                        <%--<asp:TextBox ID="txtAssetName" MaxLength="240" ToolTip="What is the name of the asset.Example:  Honda Sedan Car.ML 240." runat="server" Width="250px" Height="20px"></asp:TextBox>--%>
                                        <asp:TextBox ID="txtAssetName" runat="server" ToolTip="What is the name of the asset.Example:  Honda Sedan Car.ML 240." Width="250px" MaxLength="240" TextMode="MultiLine" CssClass="form-controlForResidentAdd" Height="40px"></asp:TextBox>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Acquisition Type :</text>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlAssetmode" ToolTip="The asset could be a purchased one or on lease or on rent.Define the mode here." runat="server" Width="150px" CssClass="form-controlForResidentAdd">
                                            <asp:ListItem Text="Purchased" Value="Purchased"></asp:ListItem>
                                            <asp:ListItem Text="On Loan" Value="On Loan"></asp:ListItem>
                                            <asp:ListItem Text="On Rent" Value="On Rent"></asp:ListItem>
                                            <asp:ListItem Text="On Lease" Value="On Lease"></asp:ListItem>
                                            <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <text style="font-weight: bold;">Asset Status :</text>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlAssetsts" ToolTip="What is the status of the asset. Is it in Use or Sold?" runat="server" Width="150px" CssClass="form-controlForResidentAdd">
                                            <asp:ListItem Text="In Use" Value="In Use"></asp:ListItem>
                                            <asp:ListItem Text="Sold" Value="Sold"></asp:ListItem>
                                            <asp:ListItem Text="Not In Use" Value="Not In Use"></asp:ListItem>
                                            <asp:ListItem Text ="Written Off" Value="Written Off"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Description :</text>
                                        <text style="color: red; font-size: smaller;">*</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtdesc" runat="server" ToolTip="Enter a brief description for the asset that you are adding now.ML 2400." Width="250px" MaxLength="2400" TextMode="MultiLine" CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Count :</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtCount" runat="server" ToolTip="Asset count" CssClass="form-controlForResidentAdd" Width="150px" Text ="1" ></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Value :</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtValue" runat="server" ToolTip="Asset value" Width="150px" CssClass="form-controlForResidentAdd" Text ="0.00" onkeypress="return isNumberKey(event);" ></asp:TextBox>
                                    </td>
                                </tr>
                                 <tr>
                                   
                                    <td>
                                        <text style="font-weight: bold;">Acquired On :</text>
                                    </td>
                                    <td>
                                        <%--<asp:TextBox ID="txtAcqon" runat="server" Width="250px" Height="20px"></asp:TextBox>--%>
                                        <telerik:RadDatePicker ID="txtAcqon" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="When was the asset acquired in the community." CssClass="form-controlForResidentAdd"
                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="25" AutoPostBack="true" OnSelectedDateChanged="txtAcqon_SelectedDateChanged">
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput3" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
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
                                    <td>
                                        <text style="font-weight: bold;">Vendor :</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtvendor" runat="server" ToolTip="If you know the name of the vendor who sold this asset, enter it here.ML 2400." Width="250px" MaxLength="2400" TextMode="MultiLine" CssClass="form-controlForResidentAdd" Height="60px"></asp:TextBox>
                                    </td>
                                </tr>
                                

                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Vendor Contact No :</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtvencno" MaxLength="40" ToolTip="This will help in case you wish to contact the vendor for any service regarding the asset. ML 40." runat="server" Width="250px" CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                    <td>
                                        <text style="font-weight: bold;">Vendor Email ID :</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtvenemail" MaxLength="90" ToolTip="This will help in case you wish to contact the vendor for any service regarding the asset.ML 90." runat="server" Width="250px" CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                </tr>
                                
                               
                                <tr>

                                    <td>
                                        <text style="font-weight: bold;">Warranty Until :</text>
                                    </td>
                                    <td>
                                        <%--<asp:TextBox ID="txtwarrantyend" runat="server" Width="250px" Height="20px"></asp:TextBox>--%>
                                        <telerik:RadDatePicker ID="txtwarrantyend" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="If the asset is on warranty, what is the end date?"
                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999" CssClass="form-controlForResidentAdd">
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput2" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                            </DateInput>
                                            <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                <SpecialDays>
                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                        <ItemStyle BackColor="Pink" />
                                                    </telerik:RadCalendarDay>
                                                </SpecialDays>
                                            </Calendar>
                                        </telerik:RadDatePicker>
                                        <asp:Button ID="btnWDateClear" ToolTip="Click here to clear the warranty date." runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="70px" CssClass="btn" OnClick="btnWDateClear_Click" />
                                    </td>
                                   
                                </tr>
                                <tr>
                                     <td>
                                        <text style="font-weight: bold;">AMC Until :</text>
                                    </td>
                                    <td>
                                        <%--<asp:TextBox ID="txtAMCend" runat="server" Width="250px" Height="20px"></asp:TextBox>--%>
                                        <telerik:RadDatePicker ID="txtAMCend" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="If the asset is on Maintenance Contract, enter the end date so that renewal can be done on time."
                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999" CssClass="form-controlForResidentAdd">
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput4" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                            </DateInput>
                                            <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                <SpecialDays>
                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                        <ItemStyle BackColor="Pink" />
                                                    </telerik:RadCalendarDay>
                                                </SpecialDays>
                                            </Calendar>
                                        </telerik:RadDatePicker>
                                        <asp:Button ID="btnADateClear" ToolTip="Click here to clear the AMC date." runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="70px" CssClass="btn" OnClick="btnADateClear_Click" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <text style="font-weight: bold;">Insurance Until :</text>
                                    </td>
                                    <td>
                                        <%--<asp:TextBox ID="txtAMCend" runat="server" Width="250px" Height="20px"></asp:TextBox>--%>
                                        <telerik:RadDatePicker ID="dtpInsuranceEnd" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="If the asset is on insurance, enter the end date so that renewal can be done on time."
                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999" CssClass="form-controlForResidentAdd">
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput5" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                            </DateInput>
                                            <Calendar ID="Calendar5" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                <SpecialDays>
                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                        <ItemStyle BackColor="Pink" />
                                                    </telerik:RadCalendarDay>
                                                </SpecialDays>
                                            </Calendar>
                                        </telerik:RadDatePicker>
                                        <asp:Button ID="btnIDateClear" ToolTip="Click here to clear the AMC date." runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="70px" CssClass="btn" OnClick="btnIDateClear_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Engineer Contact No :</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEnggContNo" MaxLength="40" ToolTip="What is the contact number of the Service Engineer.ML 24." runat="server" Width="250px" CssClass="form-controlForResidentAdd"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Disposal Date :</text>
                                    </td>
                                    <td>
                                        <%-- <asp:TextBox ID="txtdispon" runat="server" Width="250px" Height="20px"></asp:TextBox>--%>
                                        <telerik:RadDatePicker ID="txtdispon" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="You can also have details of an asset which is disposed of.Enter the date of disposal if available."
                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999" CssClass="form-controlForResidentAdd">
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput1" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                            </DateInput>
                                            <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                                <SpecialDays>
                                                    <telerik:RadCalendarDay Repeatable="Today">
                                                        <ItemStyle BackColor="Pink" />
                                                    </telerik:RadCalendarDay>
                                                </SpecialDays>
                                            </Calendar>
                                        </telerik:RadDatePicker>
                                        <asp:Button ID="btnDClear" ToolTip="Click here to clear the disposal date." runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="70px" CssClass="btn" OnClick="btnDClear_Click" />
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td>
                                        <text style="font-weight: bold;">Remarks :</text>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAMCRemarks" runat="server" ToolTip="Write about the AMC conditions.ML 2400." Width="250px" TextMode="MultiLine" MaxLength="2400" CssClass="form-controlForResidentAdd" Height="60px"></asp:TextBox>
                                    </td>

                                </tr>
                            </table>
                        </td>
                        <td style="vertical-align: top;">

                            <asp:Label ID="Label2" runat="Server" Text="A community can have various types of assets – Machines, Vehicles, Computers, Furniture and so on. One may be managing the assets, their book value, depreciation etc. in the accounting system, already." CssClass="HelpMsg"></asp:Label><br />
                            <asp:Label ID="Label3" runat="Server" Text="In ORIS, details of such assets can be maintained." CssClass="HelpMsg"></asp:Label><br />
                            <asp:Label ID="Label4" runat="Server" Text="The purpose is to be alerted when an AMC or a Warranty falls due so that there are no delays in renewing the contracts." CssClass="HelpMsg"></asp:Label><br />
                            <asp:Label ID="Label6" runat="Server" Text="Other purpose is also to know which assets are in use and where they are." CssClass="HelpMsg"></asp:Label><br />
                            <asp:Label ID="Label14" runat="Server" Text="Sometimes, much unforeseen expenses can be avoided, if a machine is serviced at the right time." CssClass="HelpMsg"></asp:Label><br />
                            <asp:Label ID="Label7" runat="Server" Text="A Stitch in time saves nine!" CssClass="HelpMsg"></asp:Label><br />
                            <asp:Label ID="Label8" runat="Server" Text="So, define all important assets in this module and make ORIS work for you." CssClass="HelpMsg"></asp:Label><br />


                        </td>
                    </tr>
                </table>
                <table style="width: 100%;" cellspacing="5" cellpadding="5">
                    <tr>
                        <td></td>
                        <td colspan="1" align="left">
                            <asp:Button ID="btnSave" OnClientClick="return Validate();" ToolTip="Click here to save the assets details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn" />
                            <asp:Button ID="btnUpdate" OnClientClick="return ConfirmUpdate();" ToolTip="Click here to update the assets details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn"/>
                            <asp:Button ID="btnDelete" OnClientClick="return ConfirmDelete();" ToolTip="Click here to delete the asset" OnClick="btnDelete_Click" runat="server" Text="Delete" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn" />
                            <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn" OnClick="btnClear_Click" />
                            <asp:Button ID="btnReturn" ToolTip="Click here to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" CssClass="btn" />
                            <asp:Button ID="btnSold" ToolTip="Click here to show the sold out assets" OnClick="btnSold_Click" runat="server" Text="Sold" ForeColor="White" BackColor="Green" Width="90px" CssClass="btn" />
                            <%--<asp:Button ID="btnSold" runat="server" CssClass="btn-success"  Text="Assets-Sold Out" OnClick="btnSold_Click" ForeColor="White" ToolTip="Click here to show the sold out assets" />--%>
                        </td>
                    </tr>
                   
                </table>
            </div>
        </div>
    </div>
</asp:Content>

