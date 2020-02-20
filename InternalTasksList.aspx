<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InternalTasksList.aspx.cs" MasterPageFile="~/CovaiSoft.master" Inherits="InternalTasksList"  EnableEventValidation="true" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />

     <style type="text/css">
        
.Loadingdiv {
     position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 0.2;
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
    opacity: 2;
    -moz-opacity: 1;
}
.centerdiv img
{
    height: 128px;
    width: 110px;
}

    </style>
    <style type="text/css">
        .HkLabel {
            display: inline-block;
            font-size: small;
            font-family: Verdana;
            background-color: limegreen;
            border: 2px solid inset;
            font-weight: bold;
        }
    </style>


    <script type="text/javascript">


        function TaskConfirmMsg() {


            var vali = "";

            



            if (vali == "") {

                var result = confirm('Do you want to update the job responsibility?');

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


        function SaveValidate() {


            var vali = "";

            vali += Task();
            vali += Staff();
          
            
          
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


        function Task() {
            var Estimate = document.getElementById('<%= ddlTask.ClientID %>').value;

            if (Estimate == "--Select--") {
                return "Please select the task" + "\n";
            }
            else {
                return "";
            }
        }


        function Staff() {
            var Estimate = document.getElementById('<%= ddlStaff.ClientID %>').value;

            if (Estimate == "--Select--") {
                return "Please select the staff" + "\n";
            }
            else {
                return "";
            }
        }


       
    </script>
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
            <div style="font-family: Verdana; font-size: small;">
                <table style="width: 100%;">
                    <tr>
                        <td align="center">

                            <asp:Label ID="lbltitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:Label>
                            <asp:HiddenField ID="CnfResult" runat="server" />
                            <asp:HiddenField ID="hdnRSN" runat="server" />
                        </td>

         </tr>
                    <tr>
                        <td>
                            <telerik:RadWindow ID="rwEditInternalTaskList" Width="450" Height="425px" VisibleOnPageLoad="false" Visible="false" runat="server"  Title="Update Job Responsibility" Modal="true">
                                        <ContentTemplate>

                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>

                                                    <div>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label4" runat="Server" Text="Staff:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblstaff" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label5" runat="Server" Text="Task:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblTask" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label7" runat="Server" Text="JobDate:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblDate" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label13" runat="Server" Text="Remarks:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtUpdateRemarks" runat="server" TextMode="MultiLine" Height="80px" Width="220px" MaxLength="40" ToolTip=""></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label14" runat="Server" Text="Status:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlStatus" runat="server" ToolTip="Select the status of the task" Height="23px" Width="150px">
                                                                        <asp:ListItem Text="Open" Value="00"></asp:ListItem>
                                                                        <asp:ListItem Text="Done" Value="10"></asp:ListItem>
                                                                        <asp:ListItem Text="Not Done" Value="20"></asp:ListItem>
                                                                        <asp:ListItem Text="Cancelled" Value="90"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:Button ID="btnStatusUpdate" OnClientClick="javascript:return TaskConfirmMsg()" ToolTip="Click here to update the job responsibility status" OnClick="btnStatusUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn" />
                                                                    <asp:Button ID="btnStatusClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn"  OnClick="btnStatusClear_Click" />
                                                                    <asp:Button ID="btnStatusClose" ToolTip="Click here to exit." runat="server" Text="Close" ForeColor="White" BackColor="DarkBlue" Width="90px" CssClass="btn"  OnClick="btnStatusClose_Click" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnStatusUpdate" />
                                                     <asp:PostBackTrigger ControlID="btnStatusClear" />
                                                     <asp:PostBackTrigger ControlID="btnStatusClose" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                            
                                        </ContentTemplate>
                                    </telerik:RadWindow>
                        </td>
                    </tr>
                </table>


                 <table style="width:100%">
                   
                    <tr style="width:100%">
                                <td align="left">
                                    
                                    
                                     <asp:Label ID="lblcrfromdate" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                                     <telerik:RadDatePicker ID="dtpdate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                         ReadOnly="true" ToolTip="Select a date for which you wish to set a Work Schedule.  If you wish to set a schedule for a whole month / week, use the Copy option." 
                                         AutoPostBack="true" OnSelectedDateChanged="dtpdate_SelectedDateChanged" >
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                            CssClass="TextBox" Font-Names="Calibri">
                                                        </Calendar>
                                                        <DatePopupButton></DatePopupButton>
                                                        <DateInput DisplayDateFormat="dd-MM-yyyy" DateFormat="dd-MM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                            ForeColor="Black" ReadOnly="true">
                                                        </DateInput>
                                                    </telerik:RadDatePicker>

                                   
                                     <asp:Label ID="Label12" runat="Server" Text="Staff" ForeColor="Black" Font-Names="verdana"></asp:Label>
                               
                                    <asp:DropDownList ID="ddlRstaff" runat="server" ToolTip="Choose the booking status." Height="25px" AutoPostBack="true" OnSelectedIndexChanged="ddlRstaff_SelectedIndexChanged">
                                        
                                    </asp:DropDownList>

                                    <asp:LinkButton ID="lnkcount" runat="server" Font-Names="Verdana" ForeColor="Maroon" Font-Size="Medium" Font-Bold="true"></asp:LinkButton>
                                   

                                    </td>
                         <td align="right">
                            <asp:Button ID="BtnExcelExport"  CssClass="btn" Font-Bold="true" Text="Export to Excel" BackColor="#7049BA" ForeColor="White" BorderColor="DarkBlue" runat="server" ToolTip="Click here export grid details to excel." OnClick="BtnExcelExport_Click" />
                        </td>
                        </tr>


                    <tr>
                        <td  colspan="2">
                            <telerik:RadGrid ID="rgInternalTaskList" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="300px" Width="100%" AllowFilteringByColumn="true" AllowPaging="false"
                                OnItemCommand="rgInternalTaskList_ItemCommand" OnInit="rgInternalTaskList_Init">
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
                                        <telerik:GridBoundColumn HeaderText="Job Date" HeaderStyle-Width="8%" FilterControlWidth="50%" DataField="Date" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Staff" HeaderStyle-Width="8%" DataField="AssignedTo" ReadOnly="true" AllowFiltering="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Task" HeaderStyle-Width="10%" DataField="ITaskTitle" ReadOnly="true" AllowFiltering="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Remarks" HeaderStyle-Width="10%" FilterControlWidth="50%" DataField="Remarks" ReadOnly="true" AllowFiltering="true" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="8%" DataField="Status" ReadOnly="true" AllowFiltering="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn HeaderText="Job Type" HeaderStyle-Width="8%" DataField="JobType" ReadOnly="true" AllowFiltering="true" FilterControlWidth="50%"></telerik:GridBoundColumn>
                                    
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
                                    <td colspan="2">
                                        <asp:LinkButton ID="lnkassigntitle" runat="server" Text="Assign Job" Font-Underline ="true" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblResident" runat="server" Text="Task"></asp:Label>
                                        <asp:Label ID="Label1" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td>
                                   
                                          <asp:DropDownList ID="ddlTask" runat="server" ToolTip="Select the task" Height="23px" Width="250px"  >
                                        </asp:DropDownList>
                                        <asp:Label ID="lblcjobtype" runat="server" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Medium"></asp:Label>

                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="Staff Name"></asp:Label>
                                        <asp:Label ID="Label3" runat="server" Text="*" ForeColor="Red"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlStaff" runat="server" ToolTip="Select the staff" Height="23px" Width="250px" >
                                        </asp:DropDownList>
                                    </td>
                                   
                                </tr>

                               


                                <tr>
                                    <td>
                                        <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Height="80px" Width="220px" MaxLength="40" ToolTip=""></asp:TextBox>
                                   </td>

                                </tr>

                                <tr>
                                   
                                    <td colspan="2">
                                        <asp:Button ID="btnSave" OnClientClick="javascript:return SaveValidate()" ToolTip="Click here to save the details" OnClick="btnSave_Click" runat="server" Text="Save" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn" />
                                        <asp:Button ID="btnUpdate" OnClientClick="javascript:return UpdateValidate()" ToolTip="Click here to update the details" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" Width="90px" CssClass="btn" Visible="false" />
                                        <asp:Button ID="btnClear" ToolTip="Click here to clear the details you have entered" runat="server" Text="Clear" ForeColor="White" BackColor="DarkOrange" Width="90px" CssClass="btn" OnClick="btnClear_Click" />
                                        <asp:Button ID="btnReturn" ToolTip="Click here to exit." runat="server" Text="Return" ForeColor="White" BackColor="DarkBlue" Width="90px" CssClass="btn" OnClick="btnReturn_Click" />

                                    </td>
                                   
                                </tr>
                            </table>
                        </td>

                    </tr>
                </table>

               


            </div>
        </div>
    </div>
</asp:Content>

