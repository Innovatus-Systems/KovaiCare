<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="VehicleMovement.aspx.cs" Inherits="VehicleMovement" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

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

.centerdiv
{
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
.centerdiv img
{
    height: 128px;
    width: 128px;
}

    </style>
    <script type="text/javascript">
        function SaveValidate() {


            var vali = "";

            vali += VehicleType();
            vali += VehicleNo();
            vali += StartDate();
            //vali += StartKM();
            vali += UsedBy();


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

            vali += VehicleType();
            vali += VehicleNo();
            vali += StartDate();
            vali += StartKM();
            vali += UsedBy();


            if (vali == "") {


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
            else {
                alert(vali);
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


        function VehicleType() {
            var Estimate = document.getElementById('<%= ddlType.ClientID %>').value;

            if (Estimate == "--Select--") {
                return "Please select the vehicle type" + "\n";
            }
            else {
                return "";
            }
        }

        function VehicleNo() {
            var Estimate = document.getElementById('<%= ddlVehicle.ClientID %>').value;

            if (Estimate == "--Select--") {
                return "Please select the vehicle No" + "\n";
            }
            else {
                return "";
            }
        }

        function StartDate() {
            var FDate = document.getElementById('<%=dtpStartDate.ClientID%>').value;
            if (FDate == "") {
                return "Please Select the start date" + "\n";
            }
            else {
                return "";
            }
        }

        function StartKM() {
            var Name = document.getElementById('<%= txtStartKM.ClientID %>').value;

            if (Name == "") {
                return "Please enter the starting killometer" + "\n";
            }
            else {
                return "";
            }
        }

        function UsedBy() {
            var Name = document.getElementById('<%= txtUsedby.ClientID %>').value;

            if (Name == "") {
                return "Please enter the vehicle user name" + "\n";
            }
            else {
                return "";
            }
        }




    </script>
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

        .roundedcorner {
            background: #fff;
            font-family: Times New Roman, Times, serif;
            font-size: 11pt;
            margin-left: auto;
            margin-right: auto;
            margin-top: 1px;
            margin-bottom: 1px;
            padding: 3px;
            border-top: 1px solid #CCCCCC;
            border-left: 1px solid #CCCCCC;
            border-right: 1px solid #999999;
            border-bottom: 1px solid #999999;
            -moz-border-radius: 8px;
            -webkit-border-radius: 8px;
        }
    </style>
    <style>
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
             <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upnlMain">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                             <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="Images/Loader.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>

                    <div style="font-family: Verdana; font-size: small;">
                         <table style="width: 100%;">
                            <tr>
                                <td align="center">

                                    <asp:Label ID="lbltitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:HiddenField ID="hdnRSN" runat="server" />
                                </td>

                            </tr>
                        </table>
                        <br />
                          <table style="width: 100%">
                            <tr>

                                
                                
                            <td>
                                <asp:Label ID="lblFrom" runat="server" Text="From :" ></asp:Label>
                                <telerik:RadDatePicker ID="rdtFrom" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                   CssClass="form-controlForResidentAdd" Width="200px"  ReadOnly="true"  ToolTip="Select date in future to enter the booking.Select date in the past to enter the Actual counts.">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                        CssClass="TextBox" Font-Names="Calibri">
                                    </Calendar>
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                        ForeColor="Black" ReadOnly="true">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                &nbsp; &nbsp; 
                                 <asp:Label ID="lblTill" runat="server" Text="Till :" ></asp:Label>
                                <telerik:RadDatePicker ID="rdtTill" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                    CssClass="form-controlForResidentAdd" Width="200px"   ReadOnly="true"  ToolTip="Select date in future to enter the booking.Select date in the past to enter the Actual counts.">
                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                        CssClass="TextBox" Font-Names="Calibri">
                                    </Calendar>
                                    <DatePopupButton></DatePopupButton>
                                    <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                        ForeColor="Black" ReadOnly="true">
                                    </DateInput>
                                </telerik:RadDatePicker>
                                &nbsp; &nbsp;
                         
                               <asp:Label ID="Label12" runat="server" Text="Vehicle Name"></asp:Label>

                                    <asp:DropDownList ID="ddlVehicleName" runat="server" ToolTip="Select a type of vehicle." CssClass="form-controlForResidentAdd" AutoPostBack="true" >
                                    </asp:DropDownList>
                                  &nbsp; &nbsp;
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success"  OnClick="btnSearch_Click"   OnClientClick="return Chart();" ToolTip="To search particular date and session for booking and actual counts." />
                                 
                                
                           &nbsp; &nbsp;
                                    <asp:Button ID="BtnExcelExport" Width="150PX" Font-Bold="true" Text="Export to Excel" CssClass="btn btn-success" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here export grid details to excel." OnClick="BtnExcelExport_Click" />
                                </td>
                                <td aign="left">                                  
                                    <asp:LinkButton ID="lnkcount" runat="server" Font-Names="Verdana" ForeColor="Maroon" Font-Size="Medium" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <telerik:RadGrid ID="rgVMovement" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="300px" AllowFilteringByColumn="true" AllowPaging="false"
                                        OnItemCommand="rgVMovement_ItemCommand" OnInit="rgVMovement_Init" OnItemDataBound="rgVMovement_ItemDataBound" Width="97%">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView AllowFilteringByColumn="true">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="RSN" DataField="RSN" ReadOnly="true" AllowFiltering="true" Display="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Vehicle Name" HeaderStyle-Width="10%" DataField="VehicleCode" ReadOnly="true" AllowFiltering="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="VehicleNo" HeaderStyle-Width="10%" DataField="VehicleNo" ReadOnly="true" AllowFiltering="true" FilterControlWidth="50%"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Purpose" HeaderStyle-Width="10%" DataField="Purpose" ReadOnly="true" AllowFiltering="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="On Date" HeaderStyle-Width="10%" FilterControlWidth="50%" DataField="StartDate" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="On Time" HeaderStyle-Width="10%" FilterControlWidth="50%" DataField="StartTime" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Return Date" HeaderStyle-Width="10%" FilterControlWidth="50%" DataField="EndDate" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Return Time" HeaderStyle-Width="10%" FilterControlWidth="50%" DataField="EndTime" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Start KM"  HeaderStyle-Width="7%" FilterControlWidth="40%" ItemStyle-Width="80px" DataField="StartKM" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="End KM" HeaderStyle-Width="7%" FilterControlWidth="40%" DataField="EndKM" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Running KM"  HeaderStyle-Width="7%" FilterControlWidth="40%" DataField="RunKM" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="right" ItemStyle-HorizontalAlign="right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Driver" HeaderStyle-Width="10%" FilterControlWidth="50%" ItemStyle-Width="80px" DataField="UsedBy" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="left"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DoorNo" DataField="DoorNo" ReadOnly="true" AllowFiltering="true" HeaderStyle-Width="10%" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" DataField="Name" ReadOnly="true" AllowFiltering="true" HeaderStyle-Width="10%" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                               <%-- <telerik:GridBoundColumn HeaderText="Net.Amt" DataField="NetAmount" ReadOnly="true" AllowFiltering="true" HeaderStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="CGST" DataField="CGST" ReadOnly="true" AllowFiltering="true" HeaderStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="SGST" DataField="SGST" ReadOnly="true" AllowFiltering="true" HeaderStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Net.Amt" DataField="GrossAmount" ReadOnly="true" AllowFiltering="true" HeaderStyle-Width="10%" FilterControlWidth="50%" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" ReadOnly="true" AllowFiltering="true" HeaderStyle-Width="20%" FilterControlWidth="70%"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                       

                        <table style="width: 100%;">
                            <tr style="width: 100%;">
                                <td style="width: 40%; vertical-align: top">
                                    <table>

                                        <tr>
                                            <td>
                                                <asp:Label ID="lblResident" runat="server" Text="Vehicle Name"></asp:Label>
                                                <asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlType" runat="server" ToolTip="Select a type of vehicle." CssClass="form-controlForResidentAdd" Width="180px" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label2" runat="server" Text="Vehicle No"></asp:Label>
                                                <asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlVehicle" runat="server" ToolTip="vechice code (or) Number" Width="180px" CssClass="form-controlForResidentAdd" Enabled="false">
                                                </asp:DropDownList>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>


                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label14" runat="server" Text="Purpose"></asp:Label>

                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPurpose" runat="server" ToolTip="Select a purpose of vehicle" CssClass="form-controlForResidentAdd" Width="180px" AutoPostBack="true" OnSelectedIndexChanged="ddlPurpose_SelectedIndexChanged">
                                                    <asp:ListItem Text="Official" Value="Official"></asp:ListItem>
                                                    <asp:ListItem Text="Resident" Value="Resident"></asp:ListItem>
                                                    <asp:ListItem Text="Personal" Value="Personal"></asp:ListItem>
                                                    <asp:ListItem Text="Guest" Value="Guest"></asp:ListItem>
                                                    <asp:ListItem Text="Fuel" Value="Fuel"></asp:ListItem>
                                                    <asp:ListItem Text="Service" Value="Service"></asp:ListItem>
                                                 </asp:DropDownList>
                                                    
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>


                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="lblFromDt" runat="Server" Text="On Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td colspan="5">
                                                <telerik:RadDatePicker ID="dtpStartDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small" CssClass="form-controlForResidentAdd"
                                                    Width="150px"  ReadOnly="true" ToolTip="Enter the start date of absence" AutoPostBack="true" OnSelectedDateChanged="dtpStartDate_SelectedDateChanged">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>


                                                <asp:Label ID="Label8" runat="server" Text="On Time" Width="82px"></asp:Label>


                                                <telerik:RadTimePicker ID="dtpfromTime" runat="server" CssClass="form-controlForResidentAdd" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                                    <TimeView ID="TimeView6" runat="server">
                                                    </TimeView>
                                                    <ClientEvents OnDateSelected="chkvalue" />
                                                </telerik:RadTimePicker>

                                            </td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label7" runat="Server" Text="Return Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td colspan="5">
                                                <telerik:RadDatePicker ID="dtpEndDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small" CssClass="form-controlForResidentAdd"
                                                    Width="150px"  ReadOnly="true" ToolTip="Enter the date upto which the resident will be away.  The billing month and no.of days are automatically calculated." AutoPostBack="true">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>


                                                <asp:Label ID="Label10" runat="server" Text="Return Time"></asp:Label>


                                                <telerik:RadTimePicker ID="dtptoTime" runat="server" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US" CssClass="form-controlForResidentAdd">
                                                    <TimeView ID="TimeView1" runat="server">
                                                    </TimeView>
                                                    <ClientEvents OnDateSelected="chkvalue" />
                                                </telerik:RadTimePicker>

                                            </td>

                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label9" runat="server" Text="Start KM"></asp:Label>

                                            </td>
                                            <td colspan="5">
                                                <asp:TextBox ID="txtStartKM" runat="server" ToolTip="Vehicle starting kilometer" CssClass="form-controlForResidentAdd" Width="150px"></asp:TextBox>
                                                <asp:Label ID="Label11" runat="server" Text="End KM" Width="82px"></asp:Label>


                                                <asp:TextBox ID="txtEndKM" runat="server" ToolTip="Vehicle ending kilometer" CssClass="form-controlForResidentAdd" Width="150px" OnTextChanged="txtEndKM_TextChanged" AutoPostBack="true"></asp:TextBox>


                                                <asp:Label ID="Label4" runat="server" Text="Running KM" ></asp:Label>

                                                <asp:TextBox ID="txtRunningKM" runat="server" ToolTip="This is the no. of days a resident will not be dining." CssClass="form-controlForResidentAdd" Width="150px" ReadOnly="true"></asp:TextBox>
                                                <asp:Label ID="lbllendkm" runat="server" Text="" Font-Names="verdana" ForeColor="Maroon" Font-Bold="true"></asp:Label>
                                                <asp:Label ID="lblwarning" runat="server" Text="" Font-Names="verdana" ForeColor="Maroon" Font-Bold="true"></asp:Label>

                                            </td>

                                        </tr>


                                        <tr>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text="Driver"></asp:Label>

                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUsedby" runat="server" CssClass="form-controlForResidentAdd" ToolTip="This is the no. of days a resident will not be dining." Width="150px"></asp:TextBox>
                                                <%-- <asp:Label ID="Label8" runat="server" Text="days."></asp:Label>--%>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>


                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="lblcresident" runat="Server" Text="Resident" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td>

                                                <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                    AutoPostBack="true" Font-Names="Arial" Font-Size="Small" Visible="false"
                                                    Width="250px" ToolTip="" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged" CssClass="form-controlForResidentAdd"
                                                    RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                                </telerik:RadComboBox>

                                                <telerik:RadComboBox ID="cmbGeneral" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                    AutoPostBack="true" Font-Names="Arial" Font-Size="Small" Visible="false" CssClass="form-controlForResidentAdd"
                                                    Width="250px" ToolTip=""
                                                    RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Guest Name/House name to search" OnSelectedIndexChanged="cmbGeneral_SelectedIndexChanged">
                                                </telerik:RadComboBox>

                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>


                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUpdateRemarks" runat="server" TextMode="MultiLine" Height="80px" Width="220px" MaxLength="40" CssClass="form-controlForResidentAdd" ToolTip=""></asp:TextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>

                                        </tr>


                                        <tr>
                                            <td>
                                                <asp:Label ID="lblnetamount" runat="server" Text="Gross Amount" CssClass="Font_lbl2" Visible="true"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtNetAmount" runat="server"  CssClass="form-controlForResidentAdd" ToolTip="Net amount billed for this service request." Width="200px" Enabled="true" Visible="false" onkeypress="return isNumberKey(event);" OnTextChanged="txtNetAmount_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbltaxamount" runat="server" Text="CGST Amount" CssClass="Font_lbl2" Visible="false" Enabled="false"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTaxAmount" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Tax amount." Width="200px" Enabled="false" Visible="true"></asp:TextBox>
                                                <asp:Label ID="lbltaxpercentage" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblsgstamount" runat="server" Text="SGST Amount" CssClass="Font_lbl2" Visible="false" Enabled="false"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtSGSTAmouont" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Tax amount." Width="200px" Enabled="false" Visible="true"></asp:TextBox>
                                                <asp:Label ID="lblsgstpercentage" runat="server" Text="" ForeColor="Maroon" Font-Names="Verdana"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblgrossamount" runat="server" Text="Net Amount" CssClass="Font_lbl2" Visible="false" Enabled="false"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtGrossAmount" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Total Amount" Width="200px" Enabled="false" Visible="false"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn btn-success" />
                                                <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn btn-success" Visible="false" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn btn-default" OnClick="btnClear_Click" />
                                                <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" CssClass="btn btn-default" OnClick="btnReturn_Click" />

                                            </td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center">
                                                <asp:Label ID="lblbwarning" runat="server" Text="Caution: Record cannot be altered once the billing is done." ForeColor="Red" Font-Names="Verdana"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>

                            </tr>
                        </table>

                      


                    </div>

                </ContentTemplate>
                <Triggers>

                    <asp:AsyncPostBackTrigger ControlID="ddlType" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="ddlPurpose" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="dtpStartDate" EventName="SelectedDateChanged" />
                    <asp:AsyncPostBackTrigger ControlID="txtEndKM" EventName="TextChanged" />
                    <asp:AsyncPostBackTrigger ControlID="cmbResident" EventName="SelectedIndexChanged" />
                    <asp:PostBackTrigger ControlID="BtnExcelExport" />
                     <asp:PostBackTrigger ControlID="btnUpdate"/>
                     <asp:PostBackTrigger ControlID="btnSave"/>
                    <asp:PostBackTrigger ControlID="btnClear"/>
                     <asp:PostBackTrigger ControlID="btnReturn"/>
                    <asp:AsyncPostBackTrigger ControlID="ddlVehicleName" EventName="SelectedIndexChanged" />
                </Triggers>

            </asp:UpdatePanel>

        </div>
    </div>
</asp:Content>
