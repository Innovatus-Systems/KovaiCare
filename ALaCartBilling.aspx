<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ALaCartBilling.aspx.cs" Inherits="ALaCartBilling" %>
<%--COVAI SOFT--%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $(".allow_numeric").on("input", function (evt) {
                var self = $(this);
                self.val(self.val().replace(/[^\d].+/, ""));
                if ((evt.which < 48 || evt.which > 57)) {
                    evt.preventDefault();
                }
            });

            $(".allow_decimal").on("input", function (evt) {
                var self = $(this);
                self.val(self.val().replace(/[^0-9\.]/g, ''));
                if ((evt.which != 46 || self.val().indexOf('.') != -1) && (evt.which < 48 || evt.which > 57)) {
                    evt.preventDefault();
                }
            });

        });
        function ConfirmMsg() {
            var result = confirm('Are you sure, you want to save?');
            if (result) {
                return true;
            }
            else {

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
        //You can set the speed of flashing here
        var speed = 500;
        //Below method will create flashing effect with the help of Fade in and fade out effect
        function effectFadeIn(classname) {
            $("." + classname).fadeOut(speed).fadeIn(speed, effectFadeOut(classname))
        }
        function effectFadeOut(classname) {
            $("." + classname).fadeIn(speed).fadeOut(speed, effectFadeIn(classname))
        }
        //Calling function on pageload
        $(document).ready(function () {
            effectFadeIn('flashingTextcss');
        });
    </script>
    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
    <style type="text/css">
        .Loadingdiv {
            position: fixed;
            z-index: 999;
            height: 100%;
            width: 100%;
            top: 0;
            background-color: Black;
            filter: alpha(opacity=60);
            opacity: 0.6;
            -moz-opacity: 0.8;
        }

        .centerdiv {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 130px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .centerdiv img {
                height: 128px;
                width: 128px;
            }
    </style>


    <style>
        .ddlstyle {
            color: rgb(33,33,00);
            Font-Family: Verdana;
            font-size: 12px;
            /*vertical-align: middle;*/
        }
    </style>
    <style>
        .auto-style1 {
            width: 119px;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpPanel">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                            <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="Images/Loader.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel ID="UpPanel" runat="server">
                <ContentTemplate>
                    <div runat="server" style="width: 100%">

                        <table style="width: 100%;">
                            <tr>
                                <td align="center">

                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">

                                    <telerik:RadWindow ID="rwDinCount" Width="820" Height="450" VisibleOnPageLoad="false" Title=""
                                        runat="server" Modal="true" >
                                        <ContentTemplate>

                                            <div>
                                                <table style="padding: 10px;" cellspacing="3px">
                                                    <tr>
                                                        <td colspan="2" style="width: 62%">
                                                            <asp:Label ID="Label5" runat="server" Font-Names="verdana" ForeColor="Maroon" Font-Size="Medium" Font-Bold="true" Text="A La Carte Billing - Menu Item-Wise Split."></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label3" runat="Server" Text="From" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadDatePicker ID="rdFrom" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                            Width="150px" CssClass="form-control" ReadOnly="true" ToolTip="Select the date in the future">
                                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                CssClass="form-control" Font-Names="Calibri">
                                                                            </Calendar>
                                                                            <DatePopupButton></DatePopupButton>
                                                                            <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                ForeColor="Black" ReadOnly="true">
                                                                            </DateInput>
                                                                        </telerik:RadDatePicker>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label4" runat="Server" Text="Till" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadDatePicker ID="rdTill" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                            Width="150px" CssClass="form-control" ReadOnly="true" ToolTip="Select the date in the future ">
                                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                CssClass="form-control" Font-Names="Calibri">
                                                                            </Calendar>
                                                                            <DatePopupButton></DatePopupButton>
                                                                            <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                ForeColor="Black" ReadOnly="true">
                                                                            </DateInput>
                                                                        </telerik:RadDatePicker>

                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="Label6" runat="Server" Text="Item : " ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="drpItem" ToolTip="Select the item to filter." CssClass="form-control" runat="server"
                                                                            Font-Names="Calibri" Font-Size="Small">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnSearch" runat="Server" Text="Search" ToolTip="" CssClass="btn btn-success" OnClick="btnSearch_Click" /></td>
                                                                    <td>
                                                                        <asp:Label ID="lblQty" runat="Server" Text="" ForeColor="DarkBlue" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td style="vertical-align: top; width: 60%" colspan="2">
                                                            <telerik:RadGrid ID="rgCount" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="350px"
                                                                Width="770px" AllowFilteringByColumn="false" AllowPaging="false" ShowFooter="false" MasterTableView-NoDetailRecordsText="true" OnItemCommand="rgCount_ItemCommand" OnInit="rgCount_Init">
                                                                <ClientSettings>
                                                                    <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                                                    <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />
                                                                </ClientSettings>


                                                                <MasterTableView AllowFilteringByColumn="false">
                                                                    <NoRecordsTemplate>
                                                                        No Record Found
                                                                    </NoRecordsTemplate>
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="DATE" DataField="Date" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderStyle-Width="200px" HeaderText="RESIDENT" DataField="NAME" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="ITEM" DataField="ITEMNAME" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="QTY" DataField="QTY" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn HeaderStyle-Width="100px" HeaderText="AMOUNT" DataField="AMOUNTTOPAY" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                                    </Columns>
                                                                </MasterTableView>
                                                            </telerik:RadGrid>

                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </ContentTemplate>

                                    </telerik:RadWindow>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 62%;">

                                    <table>

                                        <tr>
                                            <td style="width: 50%">

                                                <table>

                                                    <tr>
                                                        <td>

                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <asp:RadioButtonList ID="ChkGR" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ChkGR_SelectedIndexChanged"
                                                                            ToolTip="Select Resident or Guest to whom the booking is to be done" RepeatDirection="Horizontal">
                                                                            <asp:ListItem Selected="True" Text="Resident" Value="R"></asp:ListItem>
                                                                            <%--<asp:ListItem Text="Guest" Value="G"></asp:ListItem>--%>
                                                                        </asp:RadioButtonList>
                                                                    </td>
                                                                </tr>
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
                                                                            AutoPostBack="false" Font-Names="Arial" Font-Size="Small"
                                                                            Width="400px" ToolTip="" CssClass="form-control"
                                                                            RenderMode="Lightweight" MarkFirstMatch="false" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged" CausesValidation="false">
                                                                        </telerik:RadComboBox>

                                                                        &nbsp;&nbsp;
                                                                        <asp:CheckBox ID="chkAll" runat="server" AutoPostBack="true" Text="Show All" OnCheckedChanged="chkAll_CheckedChanged" 
                                                                            ToolTip="Residents with Owner,OwnerAway and Tenant statuses are shown by default. Tick 'Show All' to list residents of all statuses."/>

                                                                    </td>
                                                                    <td>
                                                                        <%--<asp:Button ID="btnSearch" runat="server" Text="Search" BackColor="DarkBlue" ForeColor="White" ToolTip="This will be inactive if there is some value in the grid.  Press Clear All, to abort all work and start again." CssClass="Button" OnClick="btnSearch_Click" />--%>
                                                                        <asp:Button ID="btnMenuItems" Visible="false" runat="server" BackColor="DarkGreen" ForeColor="White" Text="Menu Card" ToolTip="Click here to view all outstanding bills of the resident." CssClass="Button" OnClick="btnMenuItems_Click" />
                                                                        <br />
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div style="border: 1px thin maroon;">
                                                                            <%-- <asp:Label ID="LabelName" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text="Resident:"></asp:Label>--%>
                                                                            <asp:Label ID="lblDrNo" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                                                            <asp:Label ID="lblSpace" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" - "></asp:Label>
                                                                            <asp:Label ID="lblnm" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                                                            <%-- <asp:Label ID="LabelDrNo" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" - Dr. No:"></asp:Label>--%>
                                                                            <asp:Label ID="LabelAccNo" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" - Acc.Code:"></asp:Label>
                                                                            <asp:Label ID="lblAccNo" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>
                                                                            <asp:Label ID="LabelOutSt" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text=" - Balance:- Rs. "></asp:Label>
                                                                            <asp:Label ID="lblOtSt" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-"></asp:Label>

                                                                        </div>
                                                                    </td>
                                                                </tr>

                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <table>

                                                                <tr>

                                                                    <td>
                                                                        <asp:Label ID="lblfordate" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadDatePicker ID="dtpfordate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                            Width="190px" CssClass="form-control" ReadOnly="true" ToolTip="Select the date in the future, for which you wish to do the booking. " AutoPostBack="true">
                                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                                CssClass="form-control" Font-Names="Calibri">
                                                                            </Calendar>
                                                                            <DatePopupButton></DatePopupButton>
                                                                            <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                                ForeColor="Black" ReadOnly="true">
                                                                            </DateInput>
                                                                        </telerik:RadDatePicker>
                                                                    </td>
                                                                    <td>
                                                                        <asp:CheckBox ID="chkPastDate" runat="Server" Text="Posting for Past Date" ToolTip="Click here to allow selection of a past date within this billing month." ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:CheckBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label60" runat="Server" Text="Menu Item" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlItemName" ToolTip="Select the menu item available for this session." Width="150px" CssClass="form-control" runat="server" AutoPostBack="true"
                                                                            Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlItemName_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                       

                                                                        <asp:Label ID="lblcontains" runat="Server" Text="" Enabled="false" ForeColor="DarkBlue" Font-Names="Calibri" Font-Size="X-Small" BackColor="Yellow"></asp:Label>

                                                                    </td>
                                                                    <td>                                                                        
                                                                        <asp:CheckBox ID="chkTCM" runat="server" AutoPostBack="true" Text="Show All" Checked="false"  OnCheckedChanged="chkTCM_CheckedChanged" 
                                                                            ToolTip="By default the list shows Tea,Coffee and Milk. Tick 'Show All' to list all menu items."/>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label61" runat="Server" Text="Rate" Enabled="false" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                    </td>

                                                                    <td>
                                                                        <asp:TextBox ID="txtBMRate" runat="Server" MaxLength="12" ToolTip="The Rate for the menu item set earlier." Width="150px" CssClass="form-control" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" onkeypress="return isNumberKey(event);" ></asp:TextBox>
                                                                        <asp:Label ID="lbloriginalrate" runat="Server" Text="" ForeColor="DarkBlue" BackColor="Yellow" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                               <%-- <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label62" runat="Server" Text="No. of persons" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtNoOfPersons" runat="Server" ToolTip="How many diners?(Residents and Guests).Shows the count of residents in the same doorno, By default." Width="150px" CssClass="form-control allow_decimal" ForeColor="Black" Text="0" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>--%>
                                                                        <%-- <asp:DropDownList ID="ddlnoofpersons" ToolTip="How many diners?(Residents and Guests).Shows the count of residents in the same doorno, By default." Width="100px" Height="25px" runat="server" AutoPostBack="true"
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
                                                            </asp:DropDownList>--%>
                                                                  <%--  </td>
                                                                </tr>--%>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label63" runat="Server" Text="Quantity/Person" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                         <asp:TextBox ID="txtBMQuantity" runat="Server" MaxLength="12" ToolTip="How much to order per person?" Width="150px" Height="25px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" AutoPostBack="true" OnTextChanged="ddlBMQuantiry_SelectedIndexChanged"></asp:TextBox>
                                                                       <%-- <asp:DropDownList ID="ddlBMQuantiry" ToolTip="How many diners?(Residents and Guests).Shows the count of residents in the same doorno, By default." Width="150px" CssClass="form-control" runat="server" AutoPostBack="true"
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
                                                                        </asp:DropDownList>--%>


                                                                        <asp:Label ID="lblunit" runat="Server" Text="" ForeColor=" Black " Font-Names="Calibri"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label92" runat="Server" Text="Total Qty" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtBMTotQty" runat="Server" MaxLength="12" ToolTip="How much quantity of food to be eat." Width="150px" CssClass="form-control" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" onkeypress="return isNumberKey(event);" ReadOnly="true"></asp:TextBox>

                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:Label ID="lblAmount" runat="server" Text="Gross Amount:- Rs." Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblAmount1" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Text="-" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblCGST" runat="server" Text="CGST:- Rs." Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblCGST1" runat="server" Text="-" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblSGST" runat="server" Text="SGST:- Rs." Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblSGST1" runat="server" Text="-" Font-Bold="false" Font-Names="verdana" ForeColor="DarkBlue" Visible="false"></asp:Label>
                                                                    </td>
                                                                </tr>

                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label64" runat="Server" Text="Net Amount" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtBMAmounttopay" Enabled="false" runat="Server" MaxLength="12" ToolTip="(Rate * No of persons * Quantity +(CGST+SGST)) " Width="150px" CssClass="form-control" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>

                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" align="center">
                                                                        <asp:Button ID="btnSubmit" runat="Server" Width="70px" Text="Add" ToolTip=" Have you chosen the right Menu Item and Quantity.   Have you checked the Net Amount. If so, click here to add the item to the order list." ForeColor="White" BackColor="DarkBlue" Font-Names="Calibri" Font-Size="Medium" CssClass="btn btn-success" OnClick="btnSubmit_Click" OnClientClick="javascript:return TaskConfirmMsg()" />
                                                                        <asp:Button ID="btnClearAll" runat="Server" Text="Clear All" ToolTip=" If you wish to abort all you have done so far, without preparing the Bill, click this button." ForeColor="White" BackColor="Orange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnClearAll_Click" CssClass="btn btn-default" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>

                                                </table>

                                            </td>

                                        </tr>

                                    </table>

                                </td>
                                <td style="width: 38%; vertical-align: top">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblhelp" Visible="false" runat="server" Text="Help" Font-Names="verdana" Font-Size="Medium" ForeColor="#cc0000" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblMsg" runat="server" Text="-" Visible="false"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblhelp1" Visible="false" runat="server" Text="-" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td class="auto-style1">
                                                            <asp:Button ID="lnkDinCount" runat="Server" Text="Item Split" CssClass="btn" BorderColor="#ff6600" BackColor="#ff6600" ForeColor="white" ToolTip="Show a pop-up of item-wise split for a given date range." Font-Names="Calibri" Font-Size="Medium" OnClick="lnkDinCount_Click" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style1">
                                                            <telerik:RadGrid ID="rgBookingameal" AutoGenerateColumns="false" runat="server">
                                                                <MasterTableView>
                                                                    <Columns>

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
                                                                                <asp:Label ID="Label1" runat="server" Text='<%#Eval("Persons") %>'></asp:Label>

                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn UniqueName="Qty" HeaderText="Tot.Qty">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblQty" runat="server" Text='<%#Eval("Qty") %>'></asp:Label>

                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn UniqueName="Unit" HeaderText="Unit" Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="Label2" runat="server" Text='<%#Eval("Unit") %>'></asp:Label>

                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn UniqueName="AmounttoPay" HeaderText="Amount">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblAmounttoPay" runat="server" Text='<%#Eval("AmounttoPay") %>'></asp:Label>

                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn UniqueName="Amount" HeaderText="Amount" Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblAmount" runat="server" Text='<%#Eval("Amount") %>'></asp:Label>

                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn UniqueName="CGST" HeaderText="CGST" Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="CGST" runat="server" Text='<%#Eval("CGST") %>'></asp:Label>

                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <telerik:GridTemplateColumn UniqueName="SGST" HeaderText="SGST" Visible="false">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="SGST" runat="server" Text='<%#Eval("SGST") %>'></asp:Label>

                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <%--  <telerik:GridTemplateColumn UniqueName="SessionCode" HeaderText="SessionCode" Visible="false">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblSessionCode" runat="server" Text='<%#Eval("SessionCode") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>--%>
                                                                        <telerik:GridTemplateColumn UniqueName="From" HeaderText="Date">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblFrom" runat="server" Text='<%#Eval("From") %>'></asp:Label>

                                                                            </ItemTemplate>
                                                                        </telerik:GridTemplateColumn>
                                                                        <%--<telerik:GridTemplateColumn UniqueName="To" HeaderText="To">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblTo" runat="server" Text='<%#Eval("To") %>'></asp:Label>

                                                                                            </ItemTemplate>
                                                                                        </telerik:GridTemplateColumn>--%>

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
                                                    <tr>
                                                        <td align="left" aria-multiline="True" style="width: 62%" >
                                                            <asp:Label ID="lblPrompt" class="flashingTextcss" Visible="false" runat="server" Text="-" ForeColor="Green"
                                                                Font-Names="verdana" Font-Size="Small">Please click save button, After completing selection</asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="auto-style1">
                                                            <asp:Button ID="btnPreparetobill" runat="Server" Width="100px" Text="Save" ToolTip="Click here to confirm the payment" CssClass="btn btn-success" ForeColor="White" BackColor="Green" Font-Names="Calibri" Font-Size="Medium" OnClick="btnPreparetobill_Click" OnClientClick="javascript:return ConfirmPreparetobill()" Visible="false" />
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
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnPreparetobill" />
                    <asp:PostBackTrigger ControlID="btnSubmit" />
                    <asp:AsyncPostBackTrigger ControlID="btnClearAll" />
                    <asp:AsyncPostBackTrigger ControlID="txtBMRate" />
                    <asp:AsyncPostBackTrigger ControlID="txtBMTotQty" />
                    <asp:AsyncPostBackTrigger ControlID="cmbResident" />
                    <%--<asp:AsyncPostBackTrigger ControlID="txtNoOfPersons" />--%>
                    <%--<asp:AsyncPostBackTrigger ControlID="ddlBMQuantiry" />--%>
                    <asp:AsyncPostBackTrigger ControlID="txtBMQuantity" />
                    <asp:PostBackTrigger ControlID="chkGR" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

