<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="RMMenu.aspx.cs" Inherits="RMMenu" %>

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
            summ += COdeVal();
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
        function COdeVal() {
            var door = document.getElementById('<%= ddlRMCode.ClientID %>').value;
            if (door == "") {
                return "Please enter the RM Code.";
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

    <script type="text/javascript">
        function IValidate() {
            var summ = "";
            summ += RMCodeVal();
            summ += RMNameVal();
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
                return "Please enter the Ingredient Code." + "\n";
            } else {
                return "";
            }
        }
        function RMNameVal() {
            var door = document.getElementById('<%= txtRMName.ClientID %>').value;
            if (door == "") {
                return "Please enter the Ingredient Name." + "\n";
            } else {
                return "";
            }
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
                        <table style="width: 100%">
                            <tr>

                                <td style="text-align: center">
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadWindow ID="rwAddIngredients" Title="Add Ingredient" CssClass="preference" runat="server" VisibleOnPageLoad="false" Visible="false" Modal="true" Height="325px" Width="385px">
                                        <ContentTemplate>
                                            <div style="width: 100%;">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="text-align: center">
                                                            <asp:Label ID="Label2" runat="server" Text="Add Ingredient" Font-Bold="true" ForeColor="Blue"></asp:Label>
                                                        </td>

                                                    </tr>
                                                </table>
                                                <table style="width: 100%;">
                                                    <tr style="width: 100%;">
                                                        <td>
                                                            <table cellspacing="5" cellpadding="5">

                                                                <tr>
                                                                    <td>Code :
                                        <text style="color: red;">*</text>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtRMCode" ReadOnly="false" ToolTip="Unique code for each Food Item.Upto Eight alphanumeric characters." Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="150px" MaxLength="8"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Name :
                                        <text style="color: red;">*</text>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtRMName" ToolTip="Name of the item. Ex: Raw Rice,Toor Dal,Ponni Rice, Basmati Rice." Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Width="250px" MaxLength="24"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Supplier :                                       
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtSupp" ToolTip="Names of the different suppliers." Font-Names="verdana" runat="server" CssClass="form-controlForResidentAdd" Height="50px" TextMode="MultiLine" Width="250px" MaxLength="2400"></asp:TextBox>
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
                                                                    <td colspan="2" align="center">
                                                                        <asp:Button ID="btnISave" OnClientClick="return IValidate();" ToolTip="Click here to save the food details" OnClick="btnISave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" CssClass="btn Btn-success" />
                                                                        <asp:Button ID="btnIClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" CssClass="btn Btn-success" BorderColor="Gray" OnClick="btnIClear_Click" />
                                                                        <asp:Button ID="btnIExit" ToolTip="Click here to exit." OnClick="btnIExit_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" CssClass="btn Btn-success" BorderColor="Gray" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>

                                                    </tr>
                                                </table>

                                            </div>

                                        </ContentTemplate>
                                    </telerik:RadWindow>

                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%; font-family: Verdana; font-size: small;">
                            <tr style="width: 100%;">
                                <td style="width: 40%;">


                                    <table cellspacing="5" cellpadding="5">

                                        <tr>
                                            <td>
                                                <text style="font-size: small;">Menu Code :</text>
                                                <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <%--<asp:TextBox ID="txtmnucode" Font-Names="verdana" ReadOnly="true" ToolTip="Enter a unique code for the Raw materials menu that you wish to include.ML 8." runat="server" Height="18px" Width="150px" MaxLength="8"></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlMenuItem" ToolTip="Select from list the food item for which you wish to add the ingredient quantities." runat="server" CssClass="form-controlForResidentAdd" Width="150px" Font-Names="verdana">
                                                </asp:DropDownList>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Output Qty :                                        
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtoutputqty" ToolTip="What is the output quantity to be used as a reference." Font-Names="verdana" runat="server" MaxLength="9" CssClass="form-controlForResidentAdd" TextMode="SingleLine" Width="150px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Output UOM :                                        
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddloutuom" ToolTip="What is the unit of measure for the output quantity." runat="server" CssClass="form-controlForResidentAdd" Width="150px" Font-Names="verdana">
                                                    <asp:ListItem Text="Grams" Value="Grams"></asp:ListItem>
                                                    <asp:ListItem Text="KGs." Value="KGs."></asp:ListItem>
                                                    <asp:ListItem Text="Mls." Value="Mls."></asp:ListItem>
                                                    <asp:ListItem Text="Litres" Value="Litres"></asp:ListItem>
                                                    <asp:ListItem Text="Nos." Value="Nos."></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Ingredient Name :
                                        <text style="color: red;">*</text>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlRMCode" ToolTip="Select from the list the ingredient which you wish to quantify." CssClass="form-controlForResidentAdd" Width="100px" runat="server" Font-Names="verdana">
                                                </asp:DropDownList>
                                                <asp:LinkButton ID="lnkaddingredient" runat="server" Text="+ Ingredient" ToolTip="Add new ingredient" OnClick="lnkaddingredient_Click"></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Input Qty :                                        
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtinputqty" ToolTip="What is the ingredient quantity needed for the above said output quantity." Font-Names="verdana" runat="server" MaxLength="9" CssClass="form-controlForResidentAdd" TextMode="SingleLine" Width="150px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Input UOM :                                        
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlInputuom" ToolTip="The Unit of Measure of the ingredient" runat="server" CssClass="form-controlForResidentAdd" Width="150px" Font-Names="verdana">
                                                    <asp:ListItem Text="Grams" Value="Grams"></asp:ListItem>
                                                    <asp:ListItem Text="KGs." Value="KGs."></asp:ListItem>
                                                    <asp:ListItem Text="Mls." Value="Mls."></asp:ListItem>
                                                    <asp:ListItem Text="Litres" Value="Litres"></asp:ListItem>
                                                    <asp:ListItem Text="Nos." Value="Nos."></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Remarks :                                       
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" Font-Names="verdana" TextMode="MultiLine" ToolTip="Write any additional remarks.ML.2400." runat="server" CssClass="form-controlForResidentAdd" Height="50px" Width="250px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Button ID="btnSave" OnClientClick="return Validate();" ToolTip="Click here to save the recipes details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen"  CssClass="btn" />
                                                <asp:Button ID="btnUpdate" OnClientClick="return ConfirmUpdate();" ToolTip="Click here to update the recipes details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen"  CssClass="btn" />
                                                <asp:Button ID="btnDelete" Visible="false" OnClientClick="return ConfirmDelete();" ToolTip="Click here to delete the recipes" OnClick="btnDelete_Click" runat="server" Text="Delete" ForeColor="White" BackColor="DarkGreen"  CssClass="btn" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange"  CssClass="btn" OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit." OnClick="btnReturn_Click" runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" CssClass="btn" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table>
                                        <tr>
                                            <td>
                                                <text style="color: gray; font-family: Verdana; font-size: smaller;">
                                                    Define the important ingredients in a food Menu here.<br />
                                                    No need to be exact but will give an idea on the consumption of the raw material.<br />
                                                    Ex:  In order to prepare 10 litres of Kheer how much KGs. Of sugar is needed.  Or <br />
                                                    In order to prepare 100 Idlies how much raw rice in KGs. Is needed.<br />
                                                    This will be helpful to  have an estimate of the total quantity of a particular ingredient, when a menu is prepared.<br />
                                                    Helpful for planning purchases in bulk.<br />
                                                </text>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 60%; vertical-align: top;">
                                    <%--<br />

                                    <br />--%>
                                    <telerik:RadGrid ID="gvMenu" MasterTableView-DataKeyNames="MenuCode" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" 
                                        AutoGenerateColumns="false" OnItemCommand="gvMenu_ItemCommand" Height="400px" Width="720px" 
                                        AllowFilteringByColumn="true" AllowPaging="false" PageSize="10" OnInit="gvMenu_Init">
                                        <ClientSettings>
                                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true" FrozenColumnsCount="1"></Scrolling>
                                        </ClientSettings>
                                        <MasterTableView>
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the recipes details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") +","+ Eval("MenuCode") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="Menu Code" FilterControlWidth="50px" Visible="true" HeaderStyle-Width="70px" DataField="MenuCode" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" FilterControlWidth="50px" Visible="true" HeaderStyle-Width="70px" DataField="itemname" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Output Qty" FilterControlWidth="40px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" DataField="OutputQty" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Output UOM" FilterControlWidth="40px" HeaderStyle-Width="70px" DataField="OutputUOM" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="RM Name" HeaderStyle-Width="50px" DataField="RMCode" ReadOnly="true" FilterControlWidth="30px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Input Qty" FilterControlWidth="40px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="70px" DataField="InputQty" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Input UOM" FilterControlWidth="40px" HeaderStyle-Width="70px" DataField="InputUOM" ReadOnly="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="50px" DataField="Remarks" ReadOnly="true" FilterControlWidth="30px"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

