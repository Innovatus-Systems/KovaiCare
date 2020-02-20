<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Beverages.aspx.cs" Inherits="Beverages" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />



    <style type="text/css">
        .Myheader {
            background-color: DarkGreen !important;
            background-image: none !important;
        }
    </style>

    <script type="text/javascript">


        function NavigateDir() {
            var iMyWidth;
            var iMyHeight;
            iMyWidth = (window.screen.width / 2) - (540 + 50);
            iMyHeight = (window.screen.height / 2) - (275 + 25);
            var Y = 'BeverageHelp.aspx';
            var win = window.open(Y, "Construction Status - Block Level", "status=no,height=450,width=1150,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,'Fullscreen=yes',location=no,directories=no");
            win.focus();
        }


        function Validate() {

            var summ = "";
            summ += Dates();
            summ += Session();


            if (summ == "") {

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
            else {
                alert(summ);
                return false;
            }

        }


        function Dates() {
            var Dates = document.getElementById('<%=dtpDiners.ClientID%>').value;
            if (Dates == "") {
                return "Please Select the date for Booking" + "\n";
            }
            else {
                return "";
            }
        }

        function Session() {
            var Session = document.getElementById('<%=ddlDinersSession.ClientID%>').value;
            if (Session == "0") {
                return "Please Select Dining Session" + "\n";
            }
            else {
                return "";
            }
        }


    </script>

    <style type="text/css">
        .selectedrow {
            /*background-color:#D4FFD4 !important;*/
            background: #D4FFD4 !important;
        }
    </style>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt" style="background-color: #FCDFFF">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>

                    <asp:HiddenField ID="hfregularcount" runat="server" />

                    <div style="width: 100%">


                        <%--<table style="width: 100%">
                            <tr>
                                <td style="text-align: center">
                                   

                                </td>
                            </tr>
                        </table>--%>

                        <table style="width: 100%">
                            <tr>
                                 <td>
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:Label ID="Label47" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                    <telerik:RadDatePicker ID="dtpDiners" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Shows only today and previous days within this billing month." AutoPostBack="true" OnSelectedDateChanged="dtpDiners_SelectedDateChanged">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                </td>

                                <td>
                                    <asp:Label ID="Label49" runat="Server" Text="Session" ForeColor="Black" Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    <asp:DropDownList ID="ddlDinersSession" ToolTip="Shows only completed sessions or a session in progress." CssClass="ddl" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlDinersSession_SelectedIndexChanged" Width="130px">
                                    </asp:DropDownList>
                                </td>
                               
                                <td>
                                     <asp:Label ID="Label1" runat="Server" Text="Dining AT" ForeColor="Black" Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                    <asp:DropDownList ID="ddlDiningAT" ToolTip="Select ." CssClass="ddl" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlDiningAT_SelectedIndexChanged" Width="160px">
                                        <asp:ListItem Text ="--Select--" Value="--Select--"></asp:ListItem>
                                        <asp:ListItem Text ="THE RETREAT" Value="RETREAT"></asp:ListItem>
                                        <asp:ListItem Text ="SUVAI" Value="SUVAI"></asp:ListItem>
                                       </asp:DropDownList>
                                </td>

                                <td>

                                    <asp:Button ID="btnUpdate" runat="Server" Width="100px" Text="Update" ToolTip="Enter the beverages consumed per resident in the table below and press Update button. This button is visible only for the current billing period." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnUpdate_Click" OnClientClick="javascript:return Validate()" />
                                    <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Click here to close Diners upate." ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnClear_Click" />
                                    <asp:Button ID="btnExit" runat="Server" Width="100px" Text="Exit" ToolTip=" Click here to show home page." ForeColor="White" BackColor="DarkBlue" Font-Names="Calibri" Font-Size="Medium" OnClick="btnExit_Click" />
                                </td>

                               

                            </tr>

                        </table>

                        <table style="width: 80%">
                            <tr>
                                <td style="width: 37%">
                                    <asp:Label ID="lblTotalResident" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="width: 18%">
                                    <asp:Label ID="lblTotalBooked" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                </td>
                                <td style="width: 45%">
                                    <asp:Label ID="lblTotalGuestBooked" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                        </table>

                        <table style="width: 100%">

                            <tr>
                                <td>
                                     <asp:LinkButton ID="LinkButton1" runat="server" Text="Update Beverage consumption for a date in the current billing month. Residents will be charged only at month end." Font-Names="verdana" Font-Size="Smaller" Font-Bold="false" ForeColor="Gray"></asp:LinkButton>
                                    <asp:Button ID="BtnnExcelExport" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                                   <asp:LinkButton ID="lnkbtnHelp" runat="server" Text="Help" Font-Names="Calibri" ForeColor="Gray" Font-Size="Medium" Font-Underline="true" OnClick="lnkbtnHelp_Click"></asp:LinkButton>
                                          
                                </td>
                            </tr>

                            <tr>
                                <td style="width: 70%; vertical-align: top">
                                    
                                     <telerik:RadGrid ID="rgCasualBulkUpdate" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="WebBlue"
                                        Height="600px" Width="100%" AllowSorting="true" OnItemCreated="rgCasualBulkUpdate_ItemCreated" OnItemDataBound="rgCasualBulkUpdate_ItemDataBound"
                                        OnItemCommand="rgCasualBulkUpdate_ItemCommand" AllowMultiRowSelection="true" AllowFilteringByColumn="true" OnInit="rgCasualBulkUpdate_Init">
                                        <%-- OnItemDataBound="RdGrd_TaskTrack_ItemDataBound"--%>

                                        <HeaderStyle CssClass="Myheader" />
                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                        </HeaderContextMenu>
                                        <HeaderContextMenu CssClass="GridContextMenu GridContextMenu_WebBlue">
                                        </HeaderContextMenu>
                                        <PagerStyle AlwaysVisible="true" Mode="NumericPages" />
                                        <GroupingSettings CaseSensitive="false" />
                                        <ClientSettings>
                                            <Resizing AllowColumnResize="True" AllowRowResize="false" ResizeGridOnColumnResize="false"
                                                ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true" />
                                            <Scrolling AllowScroll="True" UseStaticHeaders="True" SaveScrollPosition="true"></Scrolling>
                                        </ClientSettings>
                                        <SelectedItemStyle CssClass="selectedrow" />
                                        <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true" DataKeyNames="RTRSN" AllowSorting="true" AllowFilteringByColumn="true">
                                            <PagerStyle Mode="NumericPages" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn>
                                                <HeaderStyle Width="20px"></HeaderStyle>
                                            </ExpandCollapseColumn>

                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderText="Door No" HeaderStyle-Font-Names="" UniqueName="DoorNo" DataField="rtvillano" ItemStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-Width="10%" SortExpression="DoorNo" AllowFiltering="true"
                                                    HeaderTooltip="">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkdoorno" runat="server" Text='<%# Eval("rtvillano") %>' ToolTip=" By clicking on the name or Door No, the count is automatically copied to the confirmation fields. Any exceptions, you can always correct the value.  Press Update to apply the changes.  This is applicable only for Regular Not Confirmed and Casual Not Confirmed."></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Name" HeaderStyle-Font-Names="" UniqueName="Name" DataField="rtname" ItemStyle-Width="35%" HeaderStyle-Width="35%" FilterControlWidth="50%" SortExpression="Name" AllowFiltering="true" HeaderTooltip="Regular diner names are shown in Maroon color.>= 80 / WAIVER - home service charges are waived ">

                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkname" runat="server" Text='<%# Eval("rtname") %>' CommandArgument='<%# Eval("RTRSN") %>' CommandName="setdiners" ToolTip=" By clicking on the name or Door No, the count is automatically copied to the confirmation fields. Any exceptions, you can always correct the value.  Press Update to apply the changes.  This is applicable only for Regular Not Confirmed and Casual Not Confirmed."></asp:LinkButton>

                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>


                                                <telerik:GridTemplateColumn HeaderText="R/C" HeaderStyle-Font-Names="" UniqueName="Type" ItemStyle-Width="10%" FilterControlWidth="50%" DataField="Type" HeaderStyle-Width="10%" SortExpression="Type" AllowFiltering="true" HeaderTooltip="TR indicates regular diner.  C indicates a casual diner.  Different rates may apply." Display="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnktype" runat="server" Text='<%# Eval("Type") %>' ToolTip="  By clicking on the name or Door No, the count is automatically copied to the confirmation fields. Any exceptions, you can always correct the value.  Press Update to apply the changes.  This is applicable only for Regular Not Confirmed and Casual Not Confirmed."></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="BCount" HeaderStyle-Font-Names="" UniqueName="BCount" ItemStyle-Width="10%" HeaderStyle-Width="10%" SortExpression="BCount" AllowFiltering="false" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkbcount" runat="server" Text='<%# Eval("Tea") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="GCount" HeaderStyle-Font-Names="" UniqueName="GCount" SortExpression="GCount" ItemStyle-Width="10%" HeaderStyle-Width="10%" AllowFiltering="false" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkdcount" runat="server" Text='<%# Eval("Coffee") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>


                                                <telerik:GridTemplateColumn HeaderText="Tea" UniqueName="Tea" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip=" No.of cups of tea" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlTea" runat="server" SelectedValue='<%# Bind("Tea") %>' AutoPostBack="true" OnSelectedIndexChanged="ddlTea_SelectedIndexChanged">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lbltwarning" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="ddlEditTea" runat="server" AutoPostBack="true">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>

                                                </telerik:GridTemplateColumn>


                                                <telerik:GridTemplateColumn HeaderText="Coffee" UniqueName="Coffee" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip=" No.of cups of coffee" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlCoffee" runat="server" SelectedValue='<%# Bind("Coffee") %>' AutoPostBack="true" OnSelectedIndexChanged="ddlCoffee_SelectedIndexChanged">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblbwarning" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="ddlEditCoffee" runat="server" AutoPostBack="true">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>

                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Milk" UniqueName="Milk" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip=" No.of cups of milk" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlMilk" runat="server" SelectedValue='<%# Bind("Milk") %>' OnSelectedIndexChanged="ddlMilk_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblgwarning" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="ddlEditMilk" runat="server">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="HomeSvce" UniqueName="HomeService" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip="No.of flasks delivered to the resident." AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlHomeService" runat="server" SelectedValue='<%# Bind("HomeService") %>' OnSelectedIndexChanged="ddlHomeService_SelectedIndexChanged" AutoPostBack="true">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblhswarning" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:DropDownList ID="ddlEditHomeService" runat="server">
                                                            <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn1" ItemStyle-Width="10%" HeaderStyle-Width="10%" HeaderTooltip="Click here if you wish to update all. Uncheck whichever you do not want to update.">
                                                </telerik:GridClientSelectColumn>


                                            </Columns>

                                        </MasterTableView>
                                        <ClientSettings>

                                            <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>
                                            <Selecting AllowRowSelect="true"></Selecting>

                                        </ClientSettings>
                                    </telerik:RadGrid>

                                    <%--  <br />

                                    <asp:LinkButton ID="lnkDinersTotal" runat="server" Text ="Diners Total" ToolTip="Click here to show diners total for selected date,session and type." OnClick="lnkDinersTotal_Click"></asp:LinkButton>

                                    <br />--%>


                                </td>


                                <td style="vertical-align: top; width: 30%">
                                    <table>
                                        <tr>
                                            <td>
                                                 <asp:LinkButton ID="lnksummary" runat="server" Text="Total for the selected date" Font-Names="verdana" Font-Size="Small" Font-Bold="true"></asp:LinkButton>
                                                <telerik:RadGrid ID="rgDinersTotal" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="Web20"
                                                    Height="100px" Width="100%" AllowSorting="true" AllowMultiRowSelection="true">
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
                                                    <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true">
                                                        <PagerStyle Mode="NumericPages" />
                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                        <RowIndicatorColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </ExpandCollapseColumn>

                                                        <Columns>
                                                           <%-- <telerik:GridBoundColumn DataField="Type" HeaderText="" UniqueName="Type" Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterText="Total" FooterStyle-HorizontalAlign="Left">

                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                            </telerik:GridBoundColumn>--%>

                                                            <telerik:GridBoundColumn DataField="Tea" HeaderText="Tea" UniqueName="Tea" DataType="System.Int32" 
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="Coffee" HeaderText="Coffee" UniqueName="Coffee" DataType="System.Int32" 
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="Milk" HeaderText="Milk" UniqueName="Milk" DataType="System.Int32" 
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="HomeService" HeaderText="Home Service" UniqueName="HomeService" 
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                        <Selecting AllowRowSelect="true"></Selecting>

                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>
                                                   <telerik:RadGrid ID="rgTotalCount" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False" Visible="true" Skin="Web20"
                                                    Height="173px" Width="100%" AllowSorting="true" AllowMultiRowSelection="true">
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
                                                    <MasterTableView NoMasterRecordsText="No Records Found." ShowFooter="true" ShowHeadersWhenNoRecords="true">
                                                        <PagerStyle Mode="NumericPages" />
                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                        <RowIndicatorColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </RowIndicatorColumn>
                                                        <ExpandCollapseColumn>
                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                        </ExpandCollapseColumn>

                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="Date" HeaderText="Confirmation done for" UniqueName="Type" Visible="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" 
                                                                ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterText="Total" FooterStyle-HorizontalAlign="Left">
                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                            </telerik:GridBoundColumn>

                                                            <telerik:GridBoundColumn DataField="Count" HeaderText="Residents" UniqueName="Count" 
                                                                Visible="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Font-Bold="false" ItemStyle-Font-Size="Small" FooterStyle-HorizontalAlign="Center">
                                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                            </telerik:GridBoundColumn>


                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="True" SaveScrollPosition="True"></Scrolling>

                                                        <Selecting AllowRowSelect="true"></Selecting>

                                                    </ClientSettings>
                                                </telerik:RadGrid>

                                                </td>
                                        </tr>

                                    </table>
                                </td>
                            </tr>


                        </table>

                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <asp:PostBackTrigger ControlID="btnClear" />
                    <asp:PostBackTrigger ControlID="ddlDinersSession" />
                    <asp:PostBackTrigger ControlID="btnExit" />
                    <asp:PostBackTrigger ControlID="BtnnExcelExport" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

