<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/CovaiSoft.master" CodeFile="DiningBooking.aspx.cs" Inherits="DiningBooking" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />


     <script type="text/javascript">
        function Validate() {

            var summ = "";
            summ += Dates();
            summ += Session();
            summ += DoorNo();
            summ += Count();
            summ += RegularCount();
            

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

         function DoorNo() {
             var DoorNo = document.getElementById('<%=ddlByDoorNo.ClientID%>').value;
             if (DoorNo == "0") {
                 return "Please Select DoorNo (or) Name" + "\n";
             }
             else {
                 return "";
             }
         }

         function Count() {
             var Count = document.getElementById('<%=ddlDiner.ClientID%>').value;
            
             if (Count == "0") {
                 return "Please Select Count of Regular (or) Guests for Booking." + "\n";
             }
             else {
                 return "";
             }
         }

         function RegularCount() {
             var RegularCount = document.getElementById('<%=hfregularcount.ClientID%>').value;
             var Count = document.getElementById('<%=ddlDiner.ClientID%>').value;

             if (Count >RegularCount ) {
                 return "Diners count exceded from regular count." + "\n";
             }
             else {
                 return "";
             }
         }

        

          </script>

     <style type="text/css">

        .ddl{
    font-size:small;
  font-family:Verdana;
  display: block;
  padding: 6px;
  width:214px;
  line-height: 1.42857143;
  color: #000000;
  background-color: #fff;
  border: 1px solid #ccc;
  border-radius: 4px;
  -moz-border-radius: 4px;
  -webkit-border-radius: 4px;
  -ms-border-radius: 4px;
  -o-border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
      -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          -o-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          -ms-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
       -moz-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
       -ms-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="main_cnt">
        <div class="first_cnt" style="background-color:#FDF184">

            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>

                    <asp:HiddenField ID="hfregularcount" runat="server" />

                    <div style="width: 100%">
                         

                        <table style="width:100%">
                            <tr>
                                <td style="text-align:center">
                                <asp:HiddenField ID="CnfResult" runat="server" />
                                       <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true" ></asp:LinkButton>

                                </td>
                            </tr>
                        </table>

                        <table style="width:auto; margin-left:auto; margin-right:auto; border-collapse:separate; border-spacing:0px 20px " >
                            <tr>
                                <td>
                                    <asp:Label ID="Label47" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>

                                <td>
                                     <telerik:RadDatePicker ID="dtpDiners" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                    Width="175px" CssClass="TextBox" ReadOnly="true" ToolTip="You can book only for future sessions." AutoPostBack="true" OnSelectedDateChanged="dtpDiners_SelectedDateChanged">
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
                                    <table>
                                          <tr>
                                            <td>
                                    <asp:Label ID="Label49" runat="Server" Text="Session" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                            </td>
                                            <td>
                                    <asp:DropDownList ID="ddlDinersSession"  ToolTip="Choose the session where you wish to include the Menu Item." CssClass="ddl" runat="server"
                                          AutoPostBack="true" OnSelectedIndexChanged="ddlDinersSession_SelectedIndexChanged">
                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                </td>
                            </tr>

                            <tr>
                                <td >
                                    <asp:Label ID="Label1" runat="Server" Text="For Whom" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>

                                </td>

                                <td colspan="2">
                                    <asp:DropDownList ID="ddlforwhom" ToolTip="Is the booking being done for a resident/tenant/office staff/a walkin. Default: Resident" CssClass="ddl" runat="server"
                                         OnSelectedIndexChanged="ddlforwhom_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem Text="Resident" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Staff " Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Walkin" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>

                                <td>
                                    <asp:Label ID="Label2" runat="Server" Text="DoorNo/Name" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                </td>

                                <td >
                                    <asp:DropDownList ID="ddlByDoorNo" ToolTip="Names of those who are booked for the sessions." CssClass="ddl" runat="server"
                                         OnSelectedIndexChanged="ddlByDoorNo_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>

                                   

                                </td>
                                <td>
                                     <asp:CheckBox ID="chkDoorNo" runat="server" OnCheckedChanged="chkDoorNo_CheckedChanged" AutoPostBack="true" Text="All" ToolTip="Click here to shows both regular and casual residents else shows only regular residents."  />
                                </td>
                            </tr>
                            <tr>
                                <td >
                                      <asp:Label ID="lblDiner" runat="Server" Text="How many regular?" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
           
                                </td>

                                <td colspan="2">

                                     <asp:DropDownList ID="ddlDiner" ToolTip="By default, the original booking count (which could be same as the no.of residents) is displayed.  Change if needed." CssClass="ddl" runat="server"
                                                     OnSelectedIndexChanged="ddlDiner_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                </asp:DropDownList>
                                </td>
                                
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblGuest" runat="Server" Text="How many guests?" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                                </td>

                                <td colspan="2">
                                    
                                                <asp:DropDownList ID="ddlGuest" ToolTip=" Did the resident have a guest today?  If so, enter it here.  By default the booking count is displayed." CssClass="ddl" runat="server"
                                                    Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlGuest_SelectedIndexChanged" AutoPostBack="true">
                                                    <asp:ListItem Text="0" Value="0"></asp:ListItem>
                                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                                </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                               
                                    <td colspan="3" align="center" >
                                     <asp:Label ID="lbldiningmsg" runat="server" Text="" ForeColor="Brown" Font-Bold="true" Font-Size="Medium" Font-Names="Verdana"></asp:Label>
                                     <asp:Label ID="lblamtcharged" runat="server" Text="" ForeColor="Brown" Font-Bold="true" Font-Size="Medium" Font-Names="Verdana"></asp:Label>
                                    </td>
                                
                            </tr>
                           
                            <tr>
                                <td colspan="3" align="center">
                                <asp:Button ID="btnBookNow" runat="Server" Width="100px" Text="Book Now" ToolTip="Click here to update the actual diner count." ForeColor="White" BackColor="DarkGreen" Font-Names="Calibri" Font-Size="Medium" OnClick="btnBookNow_Click" OnClientClick="javascript:return Validate()" />
                                <asp:Button ID="btnNotNow" runat="Server" Width="100px" Text="Not Now" ToolTip=" Click here to close Diners upate." ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Medium" OnClick="btnNotNow_Click" />
                                </td>
                                </tr>
                            
                        </table>

                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnBookNow" />
                    <asp:PostBackTrigger ControlID="btnNotNow" />
                    <asp:PostBackTrigger ControlID="ddlDinersSession" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
