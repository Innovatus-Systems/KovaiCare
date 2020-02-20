<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MovementRegister.aspx.cs" Inherits="MovementRegister" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        <link href="CSS/bootstrap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function SaveValidate() {

            var result = confirm('Do you want to check out?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }



        function UpdateValidate() {




            var result = confirm('Do you want to check in?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
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

    <script type="text/javascript">
        function chkvalue() {

            var startDt = $find("<%=dtpFromDate.ClientID %>").get_dateInput().get_value();
            var endDT = $find("<%=dtpTillDate.ClientID %>").get_dateInput().get_value();

            var starttime = $find("<%=dtpFromTime.ClientID %>").get_dateInput().get_value();
            var endtime = $find("<%=dtpTillTime.ClientID %>").get_dateInput().get_value();
            if (starttime != null && endtime != null && starttime != "" && endtime != "") {
                var startDate = new Date("1/1/1900 " + starttime);
                var endDate = new Date("1/1/1900 " + endtime);
                var difftime = endDate.getTime() - startDate.getTime();
                difftime /= 1000;
                var hrstomins = difftime / 60;
                var hours = parseFloat(difftime / 3600);
                //var mins = parseInt((difftime % 3600) / 60);
                var mins = parseFloat(hours * 60);

               <%-- document.getElementById('<%=txtestimatedmins.ClientID %>').value = mins;--%>

                if (startDt = endDT) {
                    alert(startDt)
                    alert(endDT);
                    if (startDate >= endDate) {
                        alert("CheckIn time must be greater than CheckOut time");
                        endtime.set_selectedDate("");
                        return false;
                    }
                }
                else {
                    //alert(hours);
                }
            }
            else {
                //alert("No need to Check Any Conditions")
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">

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
                            <tr style="height: 15px">
                            </tr>

                        </table>

                        <table style="width: 100%;">
                            <tr style="width: 100%;">
                                <td style="width: 40%; vertical-align: top"></td>
                                <td style="width: 60%; vertical-align: top">
                                    <asp:Label ID="Label12" runat="server" Text="Status"></asp:Label>
                                    <asp:DropDownList ID="ddlStatus" ToolTip="" CssClass="form-controlForResidentAdd" runat="server" Width="150px" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_OnSelectedIndexChanged"></asp:DropDownList>
                                   
                                    <asp:Label ID="LblOutCount" runat="server" Autopostback="true" ForeColor="Blue" Visible="true" Font-Names="verdana" Font-Bold="true" Font-Size="Small" />
                                </td>
                            </tr>
                            <tr style="width: 100%;">
                                <td style="width: 40%; vertical-align: top">
                                    <table>

                                        <tr>
                                            <td colspan="5">
                                                <asp:Label ID="lblResident" runat="server" Text="Resident"></asp:Label>
                                                <asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td colspan="5">


                                                <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                    AutoPostBack="true" Font-Names="Arial" Font-Size="Small" CssClass="form-controlForResidentAdd"
                                                    Width="250px" ToolTip="Select a resident or dependent from the list."
                                                    RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged">
                                                </telerik:RadComboBox>
                                            </td>


                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <asp:Label ID="Label2" runat="server" Text="Door No."></asp:Label>

                                            </td>
                                            <td colspan="5">
                                                <asp:TextBox ID="txtDoorNo" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Resident Door No." Width="150px" ReadOnly="true"></asp:TextBox>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <asp:Label ID="Label8" runat="server" Text="Mobile No."></asp:Label>

                                            </td>
                                            <td colspan="5">
                                                <asp:TextBox ID="txtMobileNo" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Resident Mobile No. " Width="150px" ReadOnly="true"></asp:TextBox>

                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="5">
                                                <asp:Label ID="lblFromDt" runat="Server" Text="Check Out Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label5" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td colspan="5">
                                                <telerik:RadDatePicker ID="dtpFromDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="145px" CssClass="form-controlForResidentAdd" ReadOnly="true" ToolTip="Check out date" AutoPostBack="true" OnSelectedDateChanged="dtpFromDate_Changed">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                                <asp:Label ID="Label3" runat="Server" Text="Time" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label10" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                <telerik:RadTimePicker ID="dtpFromTime" CssClass="form-controlForResidentAdd" runat="server" ToolTip="Check out time " Width="95px" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                                    <TimeView ID="TimeView6" runat="server">
                                                    </TimeView>
                                                    <ClientEvents OnDateSelected="chkvalue" />
                                                </telerik:RadTimePicker>
                                            </td>
                                        </tr>
                                        <tr id="trCheckIn" runat="server" visible="false">
                                            <td colspan="5">
                                                <asp:Label ID="Label7" runat="Server" Text="Check In Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label9" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td colspan="5">
                                                <telerik:RadDatePicker ID="dtpTillDate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="130px" CssClass="form-controlForResidentAdd" ReadOnly="true" ToolTip="Check in date" AutoPostBack="true" OnSelectedDateChanged="dtpFromDate_Changed">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                        CssClass="TextBox" Font-Names="Calibri">
                                                    </Calendar>
                                                    <DatePopupButton></DatePopupButton>
                                                    <DateInput DisplayDateFormat="dd-MMM-yyyy" DateFormat="ddd dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                        ForeColor="Black" ReadOnly="true">
                                                    </DateInput>
                                                </telerik:RadDatePicker>
                                                <asp:Label ID="Label4" runat="Server" Text="Time" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label11" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                                <telerik:RadTimePicker ID="dtpTillTime" runat="server" ToolTip="Check in time" Width="90px" TimeView-TimeFormat="t" DateInput-DateFormat="h:mm tt" DateInput-DisplayDateFormat="h:mm tt" Culture="en-US">
                                                    <TimeView ID="TimeView1" runat="server">
                                                    </TimeView>
                                                    <%--<ClientEvents OnDateSelected="chkvalue" />--%>
                                                </telerik:RadTimePicker>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="5">
                                                <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                                            </td>
                                            <td colspan="5">
                                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-controlForResidentAdd" ToolTip="Write any descriptive remarks." TextMode="MultiLine" Height="75px" Width="300px" MaxLength="2400"></asp:TextBox>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="5"></td>
                                            <td colspan="5">
                                                <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to check out" OnClick="btnSave_Click" runat="server" Text="Check Out" CssClass="btn btn-Success" ForeColor="White" BackColor="DarkGreen"  />
                                                <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to check in" OnClick="btnUpdate_Click" runat="server" Text="Check In" ForeColor="White" BackColor="DarkGreen" CssClass="btn btn-Success" Visible="false" />
                                                <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" CssClass="btn btn-Success" OnClick="btnClear_Click" />
                                                <%-- <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" Height="25px" OnClick="btnReturn_Click" />--%>
                                       
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5"></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 60%; vertical-align: top">


                                    <telerik:RadGrid ID="grdCheckInOut" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="false" runat="server" AutoGenerateColumns="false" Height="400px" Width="100%" AllowFilteringByColumn="false" AllowPaging="false"
                                        OnItemCommand="grdCheckInOut_ItemCommand" OnItemDataBound="grdCheckInOu_ItemDataBound" OnInit="grdCheckInOut_Init">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView AllowFilteringByColumn="true">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="" AllowFiltering="false" HeaderStyle-Width="60px" ItemStyle-Width="60px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to check in" runat="server" Text="Check In" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RTRSN") %>' OnClick="LnkEditItem_Click"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="RSN" DataField="RSN" HeaderStyle-Width="50px" ItemStyle-Width="50px" ReadOnly="true" AllowFiltering="false" Display="false"></telerik:GridBoundColumn>
                                                <%--<telerik:GridBoundColumn HeaderText="RTRSN"   DataField="RTRSN" HeaderStyle-Width="50px" ItemStyle-Width="50px" ReadOnly="true" AllowFiltering="false" Display="false"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Name" DataField="Name" HeaderStyle-Width="100px" ItemStyle-Width="100px" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Door No." DataField="DoorNo" HeaderStyle-Width="70px" ItemStyle-Width="70px" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Mobile No." DataField="MobileNo" HeaderStyle-Width="70px" ItemStyle-Width="70px" ReadOnly="false" AllowFiltering="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Status" DataField="Status" HeaderStyle-Width="60px" ItemStyle-Width="60px" ReadOnly="true" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="CheckOut Dt." DataField="CheckOutDt" HeaderStyle-Width="70px" ItemStyle-Width="70px" ReadOnly="true" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Time" DataField="CheckOutTime" HeaderTooltip="Check Out Time" HeaderStyle-Width="50px" ItemStyle-Width="50px" ReadOnly="true" AllowFiltering="false" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="CheckIn Dt." DataField="CheckInDt" HeaderStyle-Width="70px" ItemStyle-Width="70px" ReadOnly="true" AllowFiltering="false" Display="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Time" DataField="CheckInTime" HeaderTooltip="Check In Time" HeaderStyle-Width="50px" ItemStyle-Width="50px" ReadOnly="true" AllowFiltering="false" Display="true"></telerik:GridBoundColumn>
                                                 <telerik:GridBoundColumn HeaderText="Remarks" DataField="Remarks" HeaderStyle-Width="100px" ItemStyle-Width="100px" ReadOnly="true" AllowFiltering="false"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>

                        </table>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnSave" />
                    <asp:PostBackTrigger ControlID="btnClear" />
                    <asp:PostBackTrigger ControlID="btnUpdate" />
                    <%-- <asp:PostBackTrigger ControlID="btnReturn" />--%>
                </Triggers>
            </asp:UpdatePanel>



        </div>
    </div>
    </div>
</asp:Content>

