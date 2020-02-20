<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GuestBooking.aspx.cs" Inherits="GuestBooking" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />


    <script type="text/javascript">
        function chkvalue() {

            var starttime = $find("<%=dtpfromTime.ClientID %>").get_dateInput().get_value();
            var endtime = $find("<%=dtptoTime.ClientID %>").get_dateInput().get_value();
            if (starttime != null && endtime != null && starttime != "" && endtime != "") {
                var startDate = new Date("1/1/1900 " + starttime);
                var endDate = new Date("1/1/1900 " + endtime);
                var difftime = endDate.getTime() - startDate.getTime();
                difftime /= 1000;
                var hrstomins = difftime / 60;
                var hours = parseFloat(difftime / 3600);
                //var mins = parseInt((difftime % 3600) / 60);
                var mins = parseFloat(hours * 60);

            }
            else {
                //alert("No need to Check Any Conditions")
            }
        }
    </script>


    <script type="text/javascript">

        function SaveValidate() {
            var vali = "";

            //vali += BookingType();
            vali += BookingFor();
            vali += FromDate();
            vali += TillDate();
            vali += Name();
            vali += MobileNo();


            if (vali == "") {
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
                alert(vali);
                return false;
            }
        }

        function UpdateValidate() {
            var vali = "";


            //vali += BookingType();
            vali += BookingFor();
            vali += FromDate();
            vali += TillDate();
            //vali += ActualFromDate();
            //vali += ActualTillDate();
            vali += Name();
            vali += MobileNo();



            if (vali == "") {

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
            else {
                alert(vali);
                return false;
            }
        }


        function BookingType() {
            var Estimate = document.getElementById('<%= ddlBookingType.ClientID %>').value;

            if (Estimate == "--Select--") {
                return "Please select the booking type" + "\n";
            }
            else {
                return "";
            }
        }


        function BookingFor() {
            var Estimate = document.getElementById('<%= ddlBookingFor.ClientID %>').value;

            if (Estimate == "--Select--") {
                return "Please select the booking for" + "\n";
            }
            else {
                return "";
            }
        }

        function FromDate() {
            var FDate = document.getElementById('<%=dtpfromdate.ClientID%>').value;
            if (FDate == "") {
                return "Please Select booking from date" + "\n";
            }
            else {
                return "";
            }
        }


        function TillDate() {
            var TDate = document.getElementById('<%=dtptilldate.ClientID%>').value;
             if (TDate == "") {
                 return "Please Select booking  till date" + "\n";
             }
             else {
                 return "";
             }
         }

        <%--         function ActualFromDate() {
             var AFDate = document.getElementById('<%=dtpActualFromDate.ClientID%>').value;
             var Status = document.getElementById('<%=ddlStatus.ClientID%>').value;

             if (Status == "20") {
                 if (AFDate == "") {
                     return "Please Select actual from date" + "\n";
                 }
                 else {
                     return "";
                 }
             }
             else {
                 return "";
             }


         }--%>


         <%--function ActualTillDate() {
             var ATDate = document.getElementById('<%=dtpActualTillDate.ClientID%>').value;
             if (ATDate == "") {
                 return "Please Select actual till date" + "\n";
             }
             else {
                 return "";
             }
         }--%>


        function Name() {
            var Name = document.getElementById('<%= txtName.ClientID %>').value;

            if (Name == "") {
                return "Please enter the name of the customer" + "\n";
            }
            else {
                return "";
            }
        }

        function MobileNo() {
            var MobileNo = document.getElementById('<%= txtMobileNo.ClientID %>').value;

             if (MobileNo == "") {
                 return "Please enter the mobile no of the customer" + "\n";
             }
             else {
                 return "";
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
        <div class="first_cnt" style="background-color: #FDF184; min-height: 475px">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>

                    <asp:HiddenField ID="hfregularcount" runat="server" />

                    <div style="width: 100%">

                        <table style="width: 100%">
                            <tr>
                                <td align="center">
                                    <asp:HiddenField ID="hbtnRSN" runat="server" />
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>

                        <table style="width: 100%">


                            <tr>

                                <td align="left">
                                    <asp:LinkButton ID="lnkcount" runat="server" Font-Names="Verdana" ForeColor="Maroon" Font-Size="Medium" Font-Bold="true"></asp:LinkButton>
                                </td>

                                <td align="right">

                                    <asp:Button ID="BtnExcelExport" CssClass="btn btn-primary" Font-Bold="true" Text="Export" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here export grid details to excel." OnClick="BtnExcelExport_Click" />
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2">
                                    <telerik:RadGrid ID="gvGuestBooking" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                        AutoGenerateColumns="false" OnItemCommand="gvGuestBooking_ItemCommand" Width="100%"
                                        AllowFilteringByColumn="true" AllowPaging="false" OnInit="gvGuestBooking_Init" OnItemDataBound="gvGuestBooking_ItemDataBound" Height="250px">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />

                                        </ClientSettings>
                                        <MasterTableView>

                                            <CommandItemSettings ShowExportToCsvButton="true" />
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the booking deatails" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RSN") %>' CommandArgument='<%# Eval("RSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="From Date" HeaderStyle-Width="15%" DataField="FromDate" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Till Date" HeaderStyle-Width="15%" DataField="TillDate" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Days" HeaderStyle-Width="10%" DataField="Days" ReadOnly="true" FilterControlWidth="50%" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Facility" HeaderStyle-Width="10%" DataField="BookingFor" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="10%" DataField="Name" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="DoorNo" HeaderStyle-Width="10%" DataField="rtvillano" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Mobile No" HeaderStyle-Width="10%" DataField="MobileNo" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="EmailID" HeaderStyle-Width="20%" DataField="EmailID" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="20%" DataField="Remarks" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Type" HeaderStyle-Width="10%" DataField="Purpose" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>

                                                <telerik:GridTemplateColumn HeaderText="" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="true" HeaderStyle-Width="10%" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkCheckOut" runat="server" Text='CheckIn' CommandArgument='<%# Eval("RSN") %>' CommandName="CheckIn" ToolTip="Click here to CheckIn for One day before (or) One day after (or) equal to."></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <%-- <telerik:GridBoundColumn HeaderText="Actual From Date" HeaderStyle-Width="10%" DataField="ActualFromDate" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Actual Till Date" HeaderStyle-Width="10%" DataField="ActualTillDate" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="10%" DataField="Status" ReadOnly="true" FilterControlWidth="50%"></telerik:GridBoundColumn>--%>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lnkaddnewtask" runat="server" Visible="true" Text="" Font-Bold="true" ForeColor="DarkBlue" OnClick="lnkaddnewtask_Click" ToolTip="Click here to add new task"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>

                                <td>

                                    <asp:Panel ID="pnladdnewtask" runat="server" Visible="false" BackColor="BurlyWood">

                                        <table>

                                            <tr>
                                                <td style="width: 120px">
                                                    <asp:Label ID="Label1" runat="Server" Text="Facility Type" ForeColor="Black" Font-Names="verdana" Font-Size="Small" Visible="false"></asp:Label>
                                                    <asp:Label ID="Label8" runat="Server" Text="*" ForeColor="Red" Font-Names="verdana" Visible="false"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlBookingType" runat="server" ToolTip="Choose the booking type." Height="23px" Width="175px" AutoPostBack="true" OnSelectedIndexChanged="ddlBookingType_SelectedIndexChanged" Enabled="false" Visible="false">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" runat="Server" Text="Facility" ForeColor="Black" Font-Names="verdana" Font-Size="Small" CssClass="Font_lbl2"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlBookingFor" runat="server" ToolTip="." Height="23px" Width="175px" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label14" runat="server" Text="Booking For" ForeColor="Black" Font-Names="verdana" Font-Size="Small" CssClass="Font_lbl2"></asp:Label>

                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlPurpose" runat="server" ToolTip="Select a purpose of vehicle" Height="23px" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="ddlPurpose_SelectedIndexChanged">
                                                        <asp:ListItem Text="Official" Value="Official"></asp:ListItem>
                                                        <asp:ListItem Text="Personal" Value="Personal"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>


                                            </tr>


                                            <tr>

                                                <td>
                                                    <asp:Label ID="Label47" runat="Server" Text="Check In Date" ForeColor=" Black " Font-Names="verdana" Font-Size="Small" CssClass="Font_lbl2"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtpfromdate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking start date." AutoPostBack="true">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>

                                                    <asp:Label ID="Label10" runat="server" Text="Check In Time" Width="90px" Visible="false"></asp:Label>


                                                    <telerik:RadTimePicker ID="dtpfromTime" runat="server" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US" Visible="false">
                                                        <TimeView ID="TimeView6" runat="server">
                                                        </TimeView>
                                                        <ClientEvents OnDateSelected="chkvalue" />
                                                    </telerik:RadTimePicker>


                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <asp:Label ID="Label2" runat="Server" Text="Check Out Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" CssClass="Font_lbl2"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="dtptilldate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking end date." AutoPostBack="true">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>


                                                    <asp:Label ID="Label11" runat="server" Text="Check Out Time" Visible="false"></asp:Label>


                                                    <telerik:RadTimePicker ID="dtptoTime" runat="server" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US" Visible="false">
                                                        <TimeView ID="TimeView1" runat="server">
                                                        </TimeView>
                                                        <ClientEvents OnDateSelected="chkvalue" />
                                                    </telerik:RadTimePicker>

                                                </td>

                                            </tr>


                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblcresident" runat="Server" Text="Resident" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>

                                                    <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                                        Width="250px" ToolTip="" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged"
                                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label4" runat="Server" Text="Name" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtName" runat="server" ToolTip="Enter the name of the booking customer/resident" Width="250px" MaxLength="80"></asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label5" runat="Server" Text="Address" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtAddress" runat="server" ToolTip="" TextMode="MultiLine" Height="55px" Width="250px" MaxLength="2400"></asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label6" runat="Server" Text="MobileNo" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtMobileNo" runat="server" ToolTip="Enter the name of the booking customer/resident" Width="250px" MaxLength="80"></asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label7" runat="Server" Text="EmailID" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmailID" runat="server" ToolTip="Enter the name of the booking customer/resident" Width="250px" MaxLength="80"></asp:TextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label9" runat="server" Text="Remarks" ForeColor="Black" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Height="80px" Width="240px" MaxLength="40" ToolTip=""></asp:TextBox>

                                                </td>

                                            </tr>


                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblstatus" runat="Server" Text="Status" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlStatus" runat="server" ToolTip="Choose the booking status." Height="23px" Width="175px">
                                                        <asp:ListItem Text="Booked" Value="00"></asp:ListItem>
                                                        <asp:ListItem Text="Cancelled" Value="90"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save facility details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                                    <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the house keeping task details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" Height="25px" />
                                                    <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" Height="25px" OnClick="btnClear_Click" />
                                                    <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" Height="25px" OnClick="btnReturn_Click" />
                                                </td>

                                            </tr>

                                        </table>

                                    </asp:Panel>
                                </td>

                            </tr>


                            <tr style="width: 100%;">
                                <td colspan="2">
                                    <%--<asp:Label ID="Label12" runat="Server" Text="Status" ForeColor="Black" Font-Names="verdana"></asp:Label>

                                    <asp:DropDownList ID="ddlRStatus" runat="server" ToolTip="Choose the booking status." Height="23px" Width="175px" AutoPostBack="true" OnSelectedIndexChanged="ddlRStatus_SelectedIndexChanged">

                                        <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Booked" Value="00"></asp:ListItem>
                                        <asp:ListItem Text="Occupancy for today" Value="20"></asp:ListItem>
                                        <asp:ListItem Text="Billed" Value="30"></asp:ListItem>

                                    </asp:DropDownList>


                                    <asp:Label ID="lblcrfromdate" runat="Server" Text="From Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                    <telerik:RadDatePicker ID="dtpcrfromdate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking start date." AutoPostBack="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>

                                    <asp:Label ID="lblcrtilldate" runat="Server" Text="Till Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                    <telerik:RadDatePicker ID="dtpcrtilldate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                        Width="165px" CssClass="TextBox" ReadOnly="true" ToolTip="Booking start date." AutoPostBack="true">
                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                            CssClass="TextBox" Font-Names="Calibri">
                                        </Calendar>
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                            ForeColor="Black" ReadOnly="true">
                                        </DateInput>
                                    </telerik:RadDatePicker>


                                    <asp:Button ID="BtnShow" runat="server" CssClass="btn btn-primary" ToolTip="Click here to view the facility details based on selection type." AutoPostBack="true" Text="Show" ForeColor="White" OnClick="BtnShow_Click"></asp:Button>--%>

                                </td>
                            </tr>



                        </table>



                    </div>

                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <asp:PostBackTrigger ControlID="btnClear" />
                    <asp:PostBackTrigger ControlID="BtnExcelExport" />
                    <asp:PostBackTrigger ControlID="btnReturn" />
                    <asp:PostBackTrigger ControlID="gvGuestBooking" />
                    <%--<asp:AsyncPostBackTrigger ControlID="txtAmount" EventName ="TextChanged" />
                    <asp:AsyncPostBackTrigger ControlID="txtDiningAmount" EventName ="TextChanged"  />
                    <asp:AsyncPostBackTrigger ControlID="txtOtherAmount" EventName ="TextChanged" />
                    <asp:AsyncPostBackTrigger ControlID="txttaxamount" EventName ="TextChanged" />--%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

