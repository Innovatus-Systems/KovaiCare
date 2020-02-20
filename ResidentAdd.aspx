<%@ Page Title="" Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="ResidentAdd.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
        .preference .rwWindowContent {
            background-color: lightgreen !important;
        }

        .availability .rwWindowContent {
            background-color: Yellow !important;
        }
    </style>
    <style type="text/css">
        .modalBackground {
            background-color: Gray;
            filter: alpha(opacity=80);
            opacity: 0.8;
            z-index: 10000;
        }

        .hide {
            display: none;
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


    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>



    <%--<script src="//code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>--%>




    <script type="text/javascript">
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

        function askConfirm() {
            if (confirm("Are you sure, you want to save?"))
                alert(" ")
            else {


                return false;
            }
        }
    </script>


    <script type="text/javascript">

        function Validate() {

            var summ = "";
            summ += Name();
            summ += VillaNo();
            summ += Address();
            summ += City();
            summ += PinCode();
            summ += MobileNo();
            summ += Email();

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


        function Name() {
            var Name = document.getElementById('<%=RTName.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Name" + "\n";
            }
            else {
                return "";
            }
        }


        function VillaNo() {
            var VillaNo = document.getElementById('<%=ddlvillano.ClientID%>').value;
            if (VillaNo == "--Select--") {
                return "Please Select Villa No" + "\n";
            }
            else {
                return "";
            }
        }
        function Address() {
            var Address = document.getElementById('<%=RTAddress1.ClientID%>').value;
            if (Address == "") {
                return "Please Enter Address" + "\n";
            }
            else {
                return "";
            }
        }



        function City() {
            var City = document.getElementById('<%=CityName.ClientID%>').value;
            if (City == "") {
                return "Please Enter City" + "\n";
            }
            else {
                return "";
            }
        }
        function PinCode() {
            var PinCode = document.getElementById('<%=Pincode.ClientID%>').value;
            var chk = /^[0-9]+$/;
            if (PinCode == "") {
                return "Please Enter Pincode" + "\n";
            }
            else if (chk.test(PinCode)) {
                return "";
            }
            else {
                return "Please Enter Valid Pincode" + "\n";
            }
        }

        function MobileNo() {
            var MobileNo = document.getElementById('<%=Contactcellno.ClientID%>').value;
            var chk = /^[-+]?[0-9]+$/;
            if (MobileNo == "") {
                return "Please Enter Mobile No" + "\n";
            }
            else if (chk.test(MobileNo)) {
                return "";
            }
            else {
                return "Please Enter Valid Mobile No" + "\n";
            }
        }

        function Email() {
            var Email = document.getElementById('<%=Contactmail.ClientID%>').value;
            debugger;
            var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
    if (Email == "") {
        return "Please Enter Email ID" + "\n";
    }
    else if (chk.test(Email)) {
        return "";
    }
    else {
        return "Please Enter Valid Email ID" + "\n";
    }
}


function DepdentValidate() {
    var summ = "";
    summ += DependentName();
    summ += DependentStatus();
    summ += DependentGender();
    summ += DependentMobileNo();
    summ += DependentEmailID();
    summ += DependentDOB();

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


function DependentName() {
    var DependentName = document.getElementById('<%= txtDependentName.ClientID %>').value;
    if (DependentName == "") {
        return "Please enter the Dependent Name" + "\n";
    }
    else {
        return "";
    }
}

function DependentStatus() {
    var DependentStatus = document.getElementById('<%= ddlDependentStatus.ClientID %>').value;
    if (DependentStatus == "--Select--") {
        return "Please Select the Dependent Status" + "\n";
    }
    else {
        return "";
    }
}

function DependentGender() {
    var DependentGender = document.getElementById('<%= ddlDependentGender.ClientID %>').value;
            if (DependentGender == "-") {
                return "Please Select the Gender" + "\n";
            }
            else {
                return "";
            }
        }

        function DependentMobileNo() {
            var DependentMobileNo = document.getElementById('<%= txtDependentMobileNo.ClientID %>').value;
            if (DependentMobileNo == "") {
                return "Please enter the Dependent MobileNo" + "\n";
            }
            else {
                return "";
            }
        }

        function DependentEmailID() {
            var DependentEmailID = document.getElementById('<%= txtDependentEmailID.ClientID %>').value;
            if (DependentEmailID == "") {
                return "Please enter the Dependent EmailID" + "\n";
            }
            else {
                return "";
            }
        }

        function DependentDOB() {
            var DependentDOB = document.getElementById('<%= dtpDependentdob.ClientID %>').value;
            if (DependentDOB == "") {
                return "Please Select the dependent date of birth" + "\n";
            }
            else {
                return "";
            }
        }



        function UploadConfirm() {
            var x = confirm('Do you want to import the residents?');
            if (x) {
                return true;
            } else {
                return false;
            }
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode

            if (charCode > 31 && (charCode < 48 || charCode > 57) && evt.keyCode != 188)
                return false;

            return true;


        }

        function isNumberKey2(evt) {
            var theEvent = evt || window.event;
            var key = theEvent.keyCode || theEvent.which;
            key = String.fromCharCode(key);
            var regex = /[0-9]|\,/;
            if (!regex.test(key)) {
                theEvent.returnValue = false;
                if (theEvent.preventDefault) theEvent.preventDefault();
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
             <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="upnlMain">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                             <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="Images/Loader.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="width: 98%;">

                        <table>
                            <tr>

                                <td>
                                    <telerik:RadWindowManager ID="rwImport" runat="server">
                                        <Windows>
                                            <telerik:RadWindow ID="rwImportExcel" Title="Imports Residents Details" BackColor="Beige" runat="server" Modal="true" Height="250px" Width="500px">
                                                <ContentTemplate>
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnUnload="UpdatePanel_Unload">
                                                        <ContentTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <%--<asp:Label ID="lblMainTitle" runat="server" Text="Residents" Font-Bold="true" ForeColor="Blue" Font-Size="Small"></asp:Label>--%>
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:LinkButton ID="lbtnResdownload" OnClick="lbtnResdownload_Click" runat="server" Text="Sample excel file" ToolTip="Click here to download sample for file importing residents details"></asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <b>Select Excel File: </b>

                                                                    </td>
                                                                    <td>

                                                                        <asp:FileUpload ID="fuExcel" runat="server" ToolTip="Select residents excel file for import." ClientIDMode="Static" />
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnexcelimport" ForeColor="White" BackColor="DarkGreen" Width="120px" ToolTip="Click here to import the residents details." OnClientClick="return UploadConfirm();" OnClick="btnexcelimport_Click" runat="server" Text="Import" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:PostBackTrigger ControlID="btnexcelimport" />
                                                            <asp:PostBackTrigger ControlID="lbtnResdownload" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </ContentTemplate>
                                            </telerik:RadWindow>
                                        </Windows>
                                    </telerik:RadWindowManager>


                                    <telerik:RadWindowManager ID="rwmAddDependent" runat="server">
                                        <Windows>
                                            <telerik:RadWindow ID="rwAddDependent" Title="Add Dependent" BackColor="Beige" runat="server" Modal="true" Height="375px" Width="600px">
                                                <ContentTemplate>
                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" OnUnload="UpdatePanel_Unload">
                                                        <ContentTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td colspan="2" align="center">
                                                                        <asp:Label ID="Label35" runat="server" Text="You are adding a dependent for " Font-Names="verdana"></asp:Label>
                                                                        <asp:Label ID="Label38" runat="server" Text="Name:" Font-Names="verdana"></asp:Label>
                                                                        <asp:Label ID="lblName" runat="server" Text="" Font-Names="verdana"></asp:Label>
                                                                        <asp:Label ID="Label39" runat="server" Text="DoorNo:" Font-Names="verdana"></asp:Label>
                                                                        <asp:Label ID="lblDoorNo" runat="server" Text="" Font-Names="verdana"></asp:Label>
                                                                        <asp:Label ID="Label40" runat="server" Text="Status:" Font-Names="verdana"></asp:Label>
                                                                        <asp:Label ID="lblResidentStatus" runat="server" Text="" Font-Names="verdana"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label41" runat="server" Text="Title"></asp:Label>
                                                                    </td>
                                                                    <td>

                                                                        <asp:DropDownList ID="ddldependenttitle" Width="200px" ToolTip="Select Title for the resident dependent." Height="25px" runat="server"
                                                                            Font-Name="Verdana" Font-Size="Small">
                                                                            <asp:ListItem Text="Mr" Value="Mr"></asp:ListItem>
                                                                            <asp:ListItem Text="Ms" Value="Ms"></asp:ListItem>
                                                                            <asp:ListItem Text="Mrs" Value="Mrs"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label42" runat="server" Text="Name"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtDependentName" runat="Server" MaxLength="80" ToolTip="Enter Name of the Occupant." Width="250px" Height="25px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label45" runat="server" Text="Dependent Status"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlDependentStatus" ToolTip="Select Status of the Dependent." Width="200px" Height="25px" runat="server"
                                                                            Font-Names="Verdana" Font-Size="Small">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label46" runat="server" Text="Gender"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlDependentGender" Width="200px" ToolTip="Select Gender of the Occupant." Height="25px" runat="server"
                                                                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                                                                            <asp:ListItem Text="--Select--" Value="-"></asp:ListItem>
                                                                            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                                                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label47" runat="server" Text="Mobile No"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtDependentMobileNo" runat="Server" MaxLength="80" ToolTip="Enter the MobileNo of the dependent." Width="250px" Height="25px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label43" runat="server" Text="EmailID"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtDependentEmailID" runat="Server" MaxLength="80" ToolTip="Enter the emailid of the dependent." Width="250px" Height="25px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label44" runat="server" Text="Date of Birth"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <telerik:RadDatePicker ID="dtpDependentdob" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Pick Date of Birth of the dependent."
                                                                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" MinDate="1900-01-01">
                                                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                                            <DateInput ID="DateInput2" DateFormat="dd-MMM-yyyy ddd" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                                            </DateInput>
                                                                            <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
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
                                                                    <td colspan="2">

                                                                        <asp:Button ID="btndependentSave" runat="Server" Width="100px" Text="Save" ToolTip="Click here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Verdana" Font-Size="Small" OnClick="btndependentSave_Click" OnClientClick="javascript:return DepdentValidate()" />
                                                                        <asp:Button ID="btndependentClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Verdana" Font-Size="Small" OnClick="btndependentClear_Click" />
                                                                        <asp:Button ID="btndependentExit" runat="Server" Width="100px" Text="Exit" ToolTip="Click here to exit" ForeColor="White" BackColor=" DarkBlue " Font-Names="Verdana" Font-Size="Small" OnClick="btndependentExit_Click" />

                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:PostBackTrigger ControlID="btndependentSave" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </ContentTemplate>
                                            </telerik:RadWindow>
                                        </Windows>
                                    </telerik:RadWindowManager>


                                </td>

                                <td>
                                    <telerik:RadWindow ID="rwPopup" Width="600" Height="300" VisibleOnPageLoad="false" runat="server" Title="Sub Menus" Modal="true" CssClass="preference">
                                        <ContentTemplate>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td align="center">
                                                        <asp:Label ID="lblcName" runat="Server" Text="Name:" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblRName" runat="Server" Text=""></asp:Label>
                                                        <asp:Label ID="lblcDoorNo" runat="Server" Text="DoorNo:" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblRDoorNo" runat="Server" Text="" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblCStatus" runat="Server" Text="Status:" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblRStatus" runat="Server" Text="" Font-Names="verdana"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:Label ID="lblCMobileNo" runat="Server" Text="Mobile No:" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblRMobileNo" runat="Server" Text="" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblCEmailID" runat="Server" Text="EmailID:" Font-Names="verdana"></asp:Label>
                                                        <asp:Label ID="lblREmailID" runat="Server" Text="" Font-Names="verdana"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table style="width: 100%;">
                                                <tr>
                                                    <td align="center">
                                                        <asp:DropDownList ID="ddlItems" runat="server" OnSelectedIndexChanged="ddlItems_SelectedIndexChanged" AutoPostBack="true" Width="250px" Font-Names="verdana" Font-Bold="true">
                                                            <asp:ListItem Text="--Select--" Value="--Select--"></asp:ListItem>
                                                            <asp:ListItem Text="Service Request" Value="Service Request"></asp:ListItem>
                                                            <asp:ListItem Text="Add Dependents" Value="Add Dependents"></asp:ListItem>
                                                            <asp:ListItem Text="Profile++" Value="Profile++"></asp:ListItem>
                                                            <asp:ListItem Text="Dining Booking" Value="Dining Booking"></asp:ListItem>
                                                            <asp:ListItem Text="Dining Confirm" Value="Dining Confirm"></asp:ListItem>
                                                            <asp:ListItem Text="A la Carte Billing" Value="A la Carte Billing"></asp:ListItem>
                                                            <asp:ListItem Text="Payments" Value="Payments"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>

                                            </table>
                                        </ContentTemplate>
                                    </telerik:RadWindow>

                                </td>

                            </tr>
                        </table>

                        <table style="width: 100%">

                            <tr>
                                <td>
                                    <asp:Panel ID="pnlgeneral" Visible="true" runat="server">

                                        <table align="Left" style="width: 100%;">
                                            <tr>
                                                <td colspan="2" style="width: 100%" align="center">

                                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>


                                                </td>
                                            </tr>
                                            <tr>

                                                <td style="width: 50%" >

                                                    <%--<asp:Label ID="Label15" Visible="true" Font-Names="verdana" Text="List of all Owners, Tenants and their Dependants "
                                                        Font-Bold="true" ForeColor="Blue" Font-Size="Small" runat="server" />--%>

                                                    <asp:LinkButton ID="lnkAddnewCustomer" Visible="false" ForeColor="#048080" runat="server" AutoPostback="true" Text="" Font-Size="Medium" Font-Bold="true" ToolTip="" OnClick="lnkAddnewCustomer_Click"></asp:LinkButton>
                                                </td>

                                                <td style="width: 50%" align="right">

                                                    <asp:Button ID="btnReportList" Width="125PX" Font-Names="Verdana" CssClass="btn btn-default" Text="Short Report" OnClick="btnReportList_Click" BackColor="#7049BA" ForeColor="White" runat="server" ToolTip="Click here to export grid details to excel." />
                                                    <asp:Button ID="BtnExcelExport" Width="125PX" Font-Names="Verdana" CssClass="btn btn-default" Text="Full Report" OnClick="BtnnExcelExport_Click" BackColor="#7049BA" ForeColor="White" runat="server" ToolTip="Click here to export grid details to excel." />

                                                    <asp:Button ID="btnImport" Font-Names="Verdana" OnClick="btnImport_Click" CssClass="btn btn-default" ToolTip="Click here to import residents details from excel sheet." Width="100px" ForeColor="White" BackColor="DarkGreen" runat="server" Text="Import" />

                                                    <asp:Button ID="btnhelptext" Font-Names="Verdana" runat="server" Text="Help?" CssClass="btn btn-success" Visible="false"
                                                        OnClick="btnhelptext_Click" ToolTip="Click here to view the help about this page." />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>

                        <%--<table style="width:100%">
                            <tr>
                                <td align="right">
                                    <asp:LinkButton ID="lnkcount" runat="server" Font-Names="Verdana" ForeColor="Maroon" Font-Size="Medium" Font-Bold="true" ></asp:LinkButton>
                                </td>
                            </tr>
                        </table>--%>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 50%" colspan="2">
                                    <asp:Button ID="btnOtherStatus" CssClass="btn btn-success" runat="Server" Font-Names="Verdana" Width="110px" Text="Other Status" ToolTip="Click here to show other status (Previous Owner,Previous Owner Dependent,Previous Tenant,Previous Tenant Dependent,Owner Deceased,Tenant Dependent)." ForeColor="White" BackColor="DarkGreen" Font-Size="Small" OnClick="btnOtherStatus_Click" />
                                    <asp:Button ID="btnOSClear" CssClass="btn btn-default" runat="Server" Font-Names="Verdana" Width="100px" Text="Clear" ToolTip="Click here to show default status." ForeColor="White" BackColor="DarkOrange" Font-Size="Small" OnClick="btnOSClear_Click" />
                                    <asp:Button ID="btnClearFilter" CssClass="btn btn-default" runat="Server" Font-Names="Verdana" Width="100px" Text="Refresh" ToolTip="Click here to clear the filters." ForeColor="White" BackColor="DarkOrange" Font-Size="Small" OnClick="btnClearFilter_Click" />
                                </td>
                                <td align="right" style="width: 50%">
                                    <asp:LinkButton ID="lnkcount" runat="server" Font-Names="Verdana" ForeColor="Maroon" Font-Size="Medium" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <asp:Panel ID="PnlLevelS" Visible="false" runat="server" style="width: 100%;">

                                        <table>
                                            <tr>
                                                <td style="width: 100%;">
                                                  
                                                    <telerik:RadGrid ID="rcntgrdView" runat="server" AllowPaging="false" 
                                                        AutoGenerateColumns="False" Skin="WebBlue" AllowSorting="true" OnInit="rcntgrdView_Init"
                                                        OnPageIndexChanged="rdgListView_PageIndexChanged" OnItemDataBound="rcntgrdView_ItemDataBound"
                                                        OnPageSizeChanged="rdgListView_PageSizeChanged" OnSortCommand="rdgListView_SortCommand" OnItemCommand="rcntgrdView_ItemCommand"
                                                        Width="90%" AllowFilteringByColumn="true"
                                                        MasterTableView-HierarchyDefaultExpanded="true" OnItemEvent="rcntgrdView_ItemEvent">
                                                        <ClientSettings>
                                                            <Scrolling AllowScroll="True" UseStaticHeaders="true" />
                                                        </ClientSettings>
                                                        <GroupingSettings CaseSensitive="false" />
                                                        <HeaderContextMenu CssClass="table table-bordered table-hover">
                                                        </HeaderContextMenu>
                                                        <PagerStyle AlwaysVisible="false" Mode="NextPrevAndNumeric" />
                                                        <MasterTableView AllowCustomPaging="false">
                                                            <NoRecordsTemplate>
                                                                No Records Found.
                                                            </NoRecordsTemplate>
                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                            <RowIndicatorColumn>
                                                                <HeaderStyle Width="10px"></HeaderStyle>
                                                            </RowIndicatorColumn>
                                                            <ExpandCollapseColumn>
                                                                <HeaderStyle Width="10px"></HeaderStyle>
                                                            </ExpandCollapseColumn>
                                                            <Columns>

                                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                                    HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Viewresident" SortExpression="View">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="Lnkbtnview" runat="server" ToolTip="Click to View Profile Snapshot" Text="View" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtnview_Click">View</asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                                    HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="Editresident" SortExpression="View">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="Lnkbtnedit" runat="server" ToolTip="Click here to Edit profile" Text="Edit" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtnedit_Click">Edit</asp:LinkButton>

                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                                    HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="AddOn" SortExpression="AddOn" Visible="true">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LnkbtnAddOn" runat="server" Text="++" ToolTip="Click to manage additional particulars such as Emergency Contact Nos.,Health,Next of Kin,Other Personal Info of the profile" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="LnkbtnAddOn_Click" CommandArgument="Profile" CommandName='<%# Eval("RTRSN")%>'>P++</asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="5px"
                                                                    HeaderText="" HeaderStyle-Font-Names="Calibri" AllowFiltering="false" UniqueName="AddOn" SortExpression="AddOn" Visible="true">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="Lnkbtndependant" runat="server" Text="Dpt+" ToolTip="Click here to add a dependent for Owner Resident" Font-Bold="true" Font-Size="XX-Small" ForeColor="Blue" OnClick="Lnkbtndependant_Click" CommandArgument='<%# Eval("RTRSN")%>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridBoundColumn HeaderText="#" DataField="RTRSN" HeaderStyle-Wrap="true"
                                                                    ItemStyle-Wrap="false" AllowFiltering="false" ItemStyle-HorizontalAlign="Left" AllowSorting="false" ItemStyle-ForeColor="Gray" ItemStyle-Width="10px"
                                                                    ItemStyle-CssClass="Row1" Display="false">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>


                                                                <%-- <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="center" ItemStyle-Width="40px" FilterControlWidth="40px"
                                                                    HeaderText="DoorNo." DataField="RTVILLANO" HeaderStyle-Font-Names="Calibri" UniqueName="DoorNo" SortExpression="RTVILLANO">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbtnVillaNo" runat="server" CausesValidation="false" CssClass="CustLbl"
                                                                            Text='<%# Eval("RTVILLANO")%>' Font-Underline="false"
                                                                            ForeColor="#7049BA" Font-Bold="true" OnClick="lbtnVillaNo_Click" ToolTip="">
                                                                        </asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>--%>
                                                                <telerik:GridBoundColumn HeaderText="DoorNo" DataField="RTVILLANO" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                                                    ItemStyle-CssClass="Row1" FilterControlWidth="40px" ItemStyle-Width="40px">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="DoorNo Status" DataField="VillaStatus" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                                                    ItemStyle-CssClass="Row1" FilterControlWidth="50px" ItemStyle-Width="50px">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Status" DataField="SDescription" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                                                    ItemStyle-CssClass="Row1" FilterControlWidth="50px" ItemStyle-Width="50px">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                 <telerik:GridBoundColumn HeaderText="StatusCode" DataField="RTSTATUS" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Display="false" ItemStyle-HorizontalAlign="Left" AllowSorting="true"
                                                                    ItemStyle-CssClass="Row1" FilterControlWidth="50px" ItemStyle-Width="50px">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Name" DataField="RTName" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                                                    ItemStyle-CssClass="Row1">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False" ForeColor="#7049BA" Font-Bold="true"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Mobile No" DataField="Contactcellno" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-CssClass="Row1" FilterControlWidth="50px" ItemStyle-Width="50px">
                                                                    <HeaderStyle Wrap="true"></HeaderStyle>
                                                                    <ItemStyle Wrap="true"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="MailID" DataField="Contactmail" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Left"
                                                                    ItemStyle-CssClass="Row1" ItemStyle-Width="60px">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Age" DataField="Age" HeaderStyle-Wrap="false" DataType="System.String"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center"
                                                                    ItemStyle-CssClass="Row1" FilterControlWidth="30px">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="DOB" HeaderText="DOB" UniqueName="DOB" SortExpression="DOB" DataFormatString="{0:d}" AllowFiltering="true"
                                                                    Visible="true" FilterControlWidth="50px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn HeaderText="Outstanding" DataField="Outstanding" HeaderStyle-Wrap="false"
                                                                    ItemStyle-Wrap="false" AllowFiltering="true" Visible="true" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"
                                                                    ItemStyle-CssClass="Row1" FilterControlWidth="40px">
                                                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                                                    <ItemStyle Wrap="False"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                            <EditFormSettings>
                                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                </EditColumn>
                                                            </EditFormSettings>
                                                            <PagerStyle AlwaysVisible="True"></PagerStyle>
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="True" />
                                                        </ClientSettings>
                                                        <FilterMenu Skin="WebBlue" EnableTheming="True">
                                                            <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                                        </FilterMenu>
                                                    </telerik:RadGrid>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                            </tr>

                            <tr>
                                <td>

                                    <table id="Tbladdcust" visible="false" runat="server" style="width: 100%">

                                        <tr>
                                            <td colspan="2" align="left">
                                                <asp:Label ID="Label33" runat="Server" Text="Add a Record." ForeColor="DarkGreen" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="LblTitle" runat="Server" Text="Title/Name" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label13" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                                            </td>
                                            <td>


                                                <asp:DropDownList ID="ddlTitle" CssClass="form-controlForResidentAdd" ToolTip="Select Title for Occupant." runat="server"
                                                    Font-Names="Verdana" Font-Size="Small">
                                                    <asp:ListItem Text="Mr." Value="Mr."></asp:ListItem>
                                                    <asp:ListItem Text="Ms." Value="Ms."></asp:ListItem>
                                                    <asp:ListItem Text="Mrs." Value="Mrs."></asp:ListItem>
                                                </asp:DropDownList>
                                                &nbsp; &nbsp; &nbsp;
                                                 <asp:TextBox ID="RTName" runat="Server" CssClass="form-controlForResidentAdd" placeholder="Name of the Person." MaxLength="80" ToolTip="Enter Name of the Occupant." Width="250px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                             <td>
                                                <asp:Label ID="lblDOB" runat="Server" Text="Date of Birth" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td>

                                                <telerik:RadDatePicker ID="FromDate" runat="server" Font-Names="Verdana" CssClass="form-controlForResidentAdd" Width="200px" Font-Size="Small" ToolTip="Pick Date of Birth of the Occupant."
                                                    Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" MinDate="1900-01-01">
                                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                    <DateInput ID="DateInput1" DateFormat="dd-MMM-yyyy ddd" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                    </DateInput>
                                                    <Calendar ID="Calendar1" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
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
                                                <asp:Label ID="lblRTVILLANO" runat="Server" Text="Door No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label14" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:DropDownList ID="ddlvillano" ToolTip="Select Villa No of the Occupant." Width="200px" CssClass="form-controlForResidentAdd" runat="server"
                                                    Font-Names="Verdana" Font-Size="Small" AutoPostBack="false">
                                                </asp:DropDownList>
                                                <asp:CheckBox ID="chkShowAll" runat="server" Text="Show all" AutoPostBack="true" Visible="false" OnCheckedChanged="chkShowAll_CheckedChanged" />

                                            </td>
                                            <td>
                                                <asp:Label ID="lblRTSTATUS" runat="Server" Text="Status" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label1" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:DropDownList ID="ddlstatus" ToolTip="Select Status of the Occupant." Width="200px" CssClass="form-controlForResidentAdd" runat="server"
                                                    Font-Names="Verdana" Font-Size="Small">
                                                </asp:DropDownList>
                                                <%--<asp:TextBox ID="RTSTATUS" runat="Server" MaxLength="12" ToolTip=" ML12." Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>--%>
                                            </td>

                                        </tr>                                      
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblGender" runat="Server" Text="Gender" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label2" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td>

                                                <asp:DropDownList ID="ddlgender" Width="200px" ToolTip="Select Gender of the Occupant." CssClass="form-controlForResidentAdd" runat="server"
                                                    OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                                                    <%-- <asp:ListItem Text="--Select--" Value="-"></asp:ListItem>--%>
                                                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                             <td>
                                                <asp:Label ID="Lblmarital" runat="Server" Text="Marital Status" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label19" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlMarital" Width="200px" ToolTip="Select Marital Status of the Occupant." CssClass="form-controlForResidentAdd" runat="server"
                                                    OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                                                    <%--<asp:ListItem Text="--- Select ---" Value="0"></asp:ListItem>--%>
                                                    <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                                                    <asp:ListItem Text="Bachelor" Value="Bachelor"></asp:ListItem>
                                                    <asp:ListItem Text="Widower" Value="Widower"></asp:ListItem>
                                                    <asp:ListItem Text="Widow" Value="Widow"></asp:ListItem>
                                                    <asp:ListItem Text="Spinster" Value="Spinster"></asp:ListItem>
                                                    <asp:ListItem Text="Not Known" Value="NotKnown"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td colspan="2">
                                                <asp:Label ID="Label34" runat="Server" Text=" Communication/Permanant Address" ForeColor="DarkGreen" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblRTAddress1" runat="Server" Text="Line1" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label4" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                            </td>

                                            <td>
                                                <asp:TextBox ID="RTAddress1" runat="Server" MaxLength="80" ToolTip="Enter Occupant address for contact. " Width="350px" CssClass="form-controlForResidentAdd" Height="40px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                             <td>
                                                <asp:Label ID="lblRTAddress2" runat="Server" Text="Line2" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="RTAddress2" runat="Server" MaxLength="80" ToolTip="Enter Occupant address for contact." Width="350px" Height="40px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                           
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblCityName" runat="Server" Text="City" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label5" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="CityName" runat="Server" MaxLength="80" ToolTip="Enter City Name of the Occupant." Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                             <td>
                                                <asp:Label ID="lblPincode" runat="Server" Text="Pin Code" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label6" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="Pincode" runat="Server" MaxLength="80" ToolTip="Enter Pincode of the City" Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblCountry" runat="Server" Text="Country" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label7" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="Country" runat="Server" MaxLength="20" ToolTip="Enter country of the Occupant." Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Text="India" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                             <td>
                                                <asp:Label ID="lblContactno" runat="Server" Text="Contact No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="Contactno" runat="Server" MaxLength="80" ToolTip="Enter Contact Number of the Occupant." Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" AutoPostBack="true" onkeypress="return isNumberKey2(event)"></asp:TextBox>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblContactcellno" runat="Server" Text="Mobile No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label8" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="Contactcellno" runat="Server" MaxLength="13" ToolTip="Enter Occupant Mobile Number for contact." Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                             <td>
                                                <asp:Label ID="Label48" runat="Server" Text="MailID" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label49" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="Contactmail" runat="Server" MaxLength="80" ToolTip="Enter Mail Id of the Occupant. " Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblAlternateEMAILID" runat="Server" Text="Alternate Mail Id" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="AlternateEMAILID" runat="Server" MaxLength="80" ToolTip="Enter Alternate Mail Id of the Occupant." Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                             <td>
                                                <asp:Label ID="lblBloodGroup" runat="Server" Text="BloodGroup" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>

                                                <asp:DropDownList ID="ddlBloodgroup" ToolTip="Select Blood group of the Occupant."  CssClass="form-controlForResidentAdd" runat="server"
                                                    OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                                                    <%-- <asp:ListItem Value="0" Text="-- Select --"></asp:ListItem>--%>
                                                    <asp:ListItem Value="O +ve" Text="O +ve"></asp:ListItem>
                                                    <asp:ListItem Value="O -ve" Text="O -ve"></asp:ListItem>
                                                    <asp:ListItem Value="A +ve" Text="A +ve"></asp:ListItem>
                                                    <asp:ListItem Value="A -ve" Text="A -ve"></asp:ListItem>
                                                    <asp:ListItem Value="A1 +ve" Text="A1 +ve"></asp:ListItem>
                                                    <asp:ListItem Value="A1 -ve" Text="A1 -ve"></asp:ListItem>
                                                    <asp:ListItem Value="A1B +ve" Text="A1B +ve"></asp:ListItem>
                                                    <asp:ListItem Value="A1B -ve" Text="A1B -ve"></asp:ListItem>
                                                    <asp:ListItem Value="A2 +ve" Text="A2 +ve"></asp:ListItem>
                                                    <asp:ListItem Value="A2 -ve" Text="A2 -ve"></asp:ListItem>
                                                    <asp:ListItem Value="A2B +ve" Text="A2B +ve"></asp:ListItem>
                                                    <asp:ListItem Value="A2B -ve" Text="A2B -ve"></asp:ListItem>
                                                    <asp:ListItem Value="AB +ve" Text="AB +ve"></asp:ListItem>
                                                    <asp:ListItem Value="AB -ve" Text="AB -ve"></asp:ListItem>
                                                    <asp:ListItem Value="B +ve" Text="B +ve"></asp:ListItem>
                                                    <asp:ListItem Value="B -ve" Text="B -ve"></asp:ListItem>
                                                    <asp:ListItem Value="B1 +ve" Text="B1 +ve"></asp:ListItem>
                                                </asp:DropDownList>

                                            </td>
                                        </tr>
                                        
                                        <%--<tr >
                    <td>
                        <asp:Label ID="lblSMSAlert" runat="Server" Text="SMS Alert? Yes/No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label9" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:DropDownList ID="ddlsmsalt" ToolTip="Should SMS Alert to be Sent?." Width="200px" Height="25px" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                        </asp:DropDownList>

                    </td>
                </tr>
                   <tr>
                    <td>
                        <asp:Label ID="lblEMAILAlert" runat="Server" Text="EMAIL  Alert? Yes/No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label10" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:DropDownList ID="ddlemailalt" ToolTip="Should EMAIL Alert to be Sent?." Width="200px" Height="25px" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                        </asp:DropDownList>

                      
                    </td>
                </tr>--%>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label36" runat="Server" Text="Monthly kitchen overhead charges" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDiningAutoDebit" runat="Server" CssClass="form-controlForResidentAdd" MaxLength="80" ToolTip="If your community charges a fixed amount per month for dining, enter that amount here. The resident will be debited this stated amount automatically at month end.  If this rule does not apply here, leave the amount as zero." Width="100px"  ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                &nbsp;&nbsp;
                                                 <asp:Label ID="Label9" runat="Server" Text="Regular Diner" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                                &nbsp;
                                                <asp:DropDownList ID="ddlDAutoDebit" ToolTip="If you set 'No', Monthly kitchen overhead charges is not included in the monthend billing." Width="80px" CssClass="form-controlForResidentAdd" runat="server"
                                                    OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">                                                  
                                                    <asp:ListItem Value="N" Text="No"></asp:ListItem>
                                                      <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label37" runat="Server" Text="Monthly Maintenance charges" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtServiceAutoDebit" runat="Server" MaxLength="80" ToolTip="If your community charges a fixed amount per month for house-keeping services, enter that amount here. The resident will be debited this stated amount automatically at month end. If this rule does not apply here, leave the amount as zero." Width="100px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                                &nbsp;&nbsp;
                                                <asp:Label ID="Label10" runat="Server" Text="Auto Debit" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:DropDownList ID="ddlSAutoDebit" ToolTip="If you set 'No', Monthly Maintenance charges is not included in the monthend billing." Width="80px" CssClass="form-controlForResidentAdd" runat="server"
                                                    OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small" Visible="false">
                                                    <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                                                    <asp:ListItem Value="N" Text="No"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblOccupants" runat="Server" Text="Occupants" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                                                <asp:Label ID="Label11" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                                            </td>


                                            <td>
                                                <asp:DropDownList ID="ddloccupants" ToolTip="Select Number of Occupants in Villa." Width="200px" CssClass="form-controlForResidentAdd" runat="server"
                                                    OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small" Visible="false">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblWatsApp" runat="Server" Text="WhatsApp" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="WatsApp" runat="Server" MaxLength="80" ToolTip="Enter WhatsApp Number of Occupant." Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblFacebook" runat="Server" Text="Facebook" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="Facebook" runat="Server" MaxLength="80" ToolTip="Enter FaceBook Id of the Occupant." Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                        </tr>
                                       
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblSkype" runat="Server" Text="Skype" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="Skype" runat="Server" MaxLength="80" ToolTip="Enter Skype Id of the Occupant." Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>


                                             <td>
                                                <asp:Label ID="lblImages" runat="Server" Text="Photo" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>


                                            <td>
                                                <%--<asp:FileUpload ID="FileUpd" runat="server" OnLoad="ShowpImagePreview(this);"/>--%>
                                                <asp:FileUpload ID="FileUpd" runat="server" CssClass="form-controlForResidentAdd" Font-Names="Verdana" Font-Size="Small" ToolTip="Choose resident's photo"></asp:FileUpload>
                                            </td>
                                            <td>

                                                <asp:Image ID="Custimage" runat="server" CssClass="form-controlForResidentAdd" Height="100px" Width="100px" Visible="false" />
                                            </td>



                                        </tr>
                                        <%-- <tr>
                                            <td>
                                                <asp:Label ID="Label12" runat="Server" Text="Legal Will" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="txtlegalwill" runat="Server" MaxLength="2400" ToolTip="A Legal will is a legal document by which a person, the testator, expresses his or her wishes as to how his or her property is to be distributed at death, and names one or more persons, the executor, to manage the estate until its final distribution." Width="300px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Height="70px"></asp:TextBox>
                                            </td>

                                        </tr>--%>
                                      
                                        <tr>
                                           
                                             <td>
                                                <asp:Label ID="lblRemarks" runat="Server" Text="Remarks" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            </td>

                                            <td>
                                                <asp:TextBox ID="Remarks" runat="Server" MaxLength="2400" ToolTip="Enter any additional Remarks." Width="300px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" CssClass="form-controlForResidentAdd" Height="70px"></asp:TextBox>
                                            </td>
                                            
                                        </tr>
                                         <tr>
                                            <td colspan="2">
                                                <asp:Label ID="Label3" runat="Server" Text="For Office Use Only." ForeColor="DarkGreen" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            <asp:CheckBox ID="chkSameDetails" runat="server" Text="Same as Above" ForeColor="DarkBlue" Font-Bold="true" AutoPostBack="true" OnCheckedChanged="chkSameDetails_CheckedChanged" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                        <asp:Label ID="Label15" runat="server" Text="Date of Birth" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    </td>
                                    <td>
                                        <telerik:RadDatePicker ID="RdOffDOB" runat="server" Font-Names="Verdana" Font-Size="Small" Width="200px" ToolTip="Pick Date of Birth of the dependent."
                                            Culture="English (United Kingdom)" CssClass="form-controlForResidentAdd" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" MinDate="1900-01-01">
                                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                            <DateInput ID="DateInput3" DateFormat="dd-MMM-yyyy ddd" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
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

                                            <td>
                                                <asp:Label ID="Label12" runat="Server" Text="Mobile No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                               
                                            </td>

                                            <td>
                                                <asp:TextBox ID="txtOffMobNo" runat="Server" MaxLength="13" ToolTip="Enter Resident Mobile Number to show in Mobile App." Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                           
                                        </tr>
                                        <tr>
            
                                              <td>
                                                <asp:Label ID="Label16" runat="Server" Text="MailID" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                               
                                            </td>

                                            <td>
                                                <asp:TextBox ID="txtOffEmailId" runat="Server" MaxLength="80" ToolTip="Enter Mail Id of the Occupant. " Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                             <td colspan="2">
                                                <asp:Button ID="btnSave" runat="Server" Width="100px" CssClass="btn" Text="Save" ToolTip="Click here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Verdana" Font-Size="Small" OnClick="btnSave_Click1" OnClientClick="javascript:return Validate()" />


                                                <asp:Button ID="btnClear" runat="Server" Width="100px" CssClass="btn" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Verdana" Font-Size="Small" OnClick="btnClear_Click" />


                                                <asp:Button ID="btnExit" runat="Server" Width="100px" CssClass="btn" Text="Exit" ToolTip="Click here to exit" ForeColor="White" BackColor=" DarkBlue " Font-Names="Verdana" Font-Size="Small" OnClick="btnExit_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>



                        </table>

                        <asp:HiddenField ID="CnfResult" runat="server" />

                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="lnkAddnewCustomer" />
                    <asp:PostBackTrigger ControlID="rcntgrdView" />
                     <asp:AsyncPostBackTrigger ControlID="chkSameDetails" EventName="CheckedChanged" />
                    <asp:PostBackTrigger ControlID="btnSave" />
                    <asp:PostBackTrigger ControlID="BtnExcelExport" />
                    <asp:PostBackTrigger ControlID="btnReportList" />
                    <asp:PostBackTrigger ControlID="btnOtherStatus" />
                    <asp:PostBackTrigger ControlID="btnOSClear" />
                </Triggers>

            </asp:UpdatePanel>

           

            <%-- GridView Start --%>
        </div>
        <%-- GridView End --%>
    </div>

</asp:Content>
