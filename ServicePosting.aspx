<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ServicePosting.aspx.cs" Inherits="ServicePosting" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/bootstrap.css" rel="stylesheet" type="text/css" />
     <script src="Calendar/jquery-1.10.2.js"></script>
    <script src="Calendar/jquery.validate.js" type="text/javascript"></script>
    <script src="Calendar/moment.js" type="text/javascript"></script>

    <%--<link href="Calendar/jquery-ui-1.8.16.custom.css" rel="stylesheet" />--%>

    <script src="Calendar/jquery.timepicker.js" type="text/javascript"></script>
    <link href="Calendar/jquery.timepicker.css" rel="Stylesheet" />

    <script src="Calendar/lib/site.js" type="text/javascript"></script>
    <link href="Calendar/lib/site.css" rel="stylesheet" />
    <%-- <script src="Calendar/Auto/jquery-ui.min.js" type="text/javascript"></script>--%>

    <script type="text/javascript">
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function () {
            //$(document).ready(function () {
            $("[id*='txtCompTime']").timepicker({});
        });
    </script>
    <script type="text/javascript" language="javascript">

        function ConfirmMsg() {
            var result = confirm('The Service will be marked as Done and necessary financial transactions will be posted. Are you sure? If Not, press Cancel  else press OK to go ahead.');
            if (result) {
                return true;
            }
            else {
                return false;
            }
        }
    </script>
    <script type="text/javascript" language="javascript">

        function alertMsg() {
            var result = confirm('Please ensure ,Service is done?');
            if (result) {
                return true;
            }
            else {
                return false; 
            }
        }
    </script>
    <script type="text/javascript" language="javascript">

        function ReturnMsg() {
            var result = confirm('Do you want to return to view request page?');
            if (result) {
                return true;
            }
            else {
                return false; 
            }
        }
    </script>
   <%-- <script>
        $(function () {
            $("#txtCompTime").timepicker({
                showInputs: true
            });
        })
</script>--%>
    <%--<script type="text/javascript">
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function () {
            //$(document).ready(function () {
            $("[id*='txtCompTime']").timepicker({});
        });
    </script>--%>
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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt" style="background-color:khaki;">
            <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpPanel">
                <ProgressTemplate>
                    <div class="Loadingdiv">
                        <div class="centerdiv">
                              <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="Images/Loader.gif" />
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
            <asp:UpdatePanel ID="UpPanel" runat="server">
                <ContentTemplate>
                   <br />
                         <table style="width: 100%;background-color:khaki;">
                    <tr>
                        <td style="text-align: center">
                            <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Text="Service Request / Status Update" Font-Bold="true"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                    <br />
                    <table style="width:100%;background-color:khaki;">
                    <tr>
                                <td style="width: 62%;">
                        <table >
                                                <tr>
                                <td>
                                    <asp:Label ID="lblRTSTATUS" runat="Server" Text="Resident Name" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    <asp:Label ID="Label1" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small" CssClass="form-control"
                                        Width="350px" ToolTip="" Enabled="false"
                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                    </telerik:RadComboBox>                                                                
                                </td>
                            </tr>

                            <tr>
                                <td style="vertical-align: top">
                                    <asp:Label ID="Label3" runat="Server" Text="Service Type" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                   
                                    <text style="color: red;">*</text>

                                </td>
                                <td>
                                   <%-- <table>
                                        <tr>
                                            <td>--%>
                                                <asp:DropDownList ID="ddlSerType" CssClass="form-control" ToolTip="A Service may fall under a predefined Service Type, set by the system administrator." Width="415px" Font-Size="Small" Font-Names="verdana" AutoPostBack="true" OnSelectedIndexChanged="ddlSerType_SelectedIndexChanged" runat="server"></asp:DropDownList>
                                           <%-- </td>
                                        </tr>
                                        
                                    </table>--%>
                                </td>
                            </tr>                           
                           
                            <tr>
                                <td>
                                    <asp:Label ID="Label6" runat="Server" Text="Description" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                    <asp:Label ID="Label7" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTask" runat="Server" MaxLength="2400" CssClass="form-control" ToolTip="Write in detail what is to be done.  Ex: Plumbing work, Ticket Booking for travel on 29th July , etc." Width="415px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Height="60px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbltasksts" Visible="false" runat="Server" Text="Status" ForeColor="Black" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlStatus" Visible="false" Width="200px" CssClass="form-control"  runat="server" ToolTip=" If Open, it means the service is yet to be completed.  If Done it means the service is Completed and resident may have been debited."
                                        Font-Names="Verdana" Font-Size="Small">
                                        <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                                        <asp:ListItem Text="Cancelled" Value="Cncld"></asp:ListItem>
                                        <asp:listitem Text="Done" value="Done"></asp:listitem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblMDate" Visible="true" runat="server" Font-Names="verdana" Font-Size="Small" ForeColor=" Black " Text="Report Date & Time :"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="txtMDate" Visible="true" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="The date and time of reporting a service request."
                                        Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" CssClass="form-control">
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput ID="DateInput4" DateFormat="dd/MMM/yy" DisplayDateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                        </DateInput>
                                        <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                            <SpecialDays>
                                                <telerik:RadCalendarDay Repeatable="Today">
                                                    <ItemStyle BackColor="Pink" />
                                                </telerik:RadCalendarDay>
                                            </SpecialDays>
                                        </Calendar>
                                    </telerik:RadDatePicker>
                                     <asp:TextBox ID="txtMTime" Width="80" Visible="true" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label15" runat="Server" Text="Target Date:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="dtpTargetDt" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Approximate end date by which the service may be completed."
                                        Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" CssClass="form-control">
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput ID="DateInput1" DateFormat="dd/MMM/yy" runat="server" DisplayDateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
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
                                    <asp:Label ID="Label2" runat="Server" Text="Completed Date & Time:" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <telerik:RadDatePicker ID="radDateComp" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip=" When was the service completed. Cannot be in future or earlier than the reported date."
                                        Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" Enabled="true" CssClass="form-control">
                                        <DatePopupButton></DatePopupButton>
                                        <DateInput ID="DateInput2" DateFormat="dd/MMM/yy" runat="server" DisplayDateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                        </DateInput>
                                        <Calendar ID="Calendar2" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
                                            <SpecialDays>
                                                <telerik:RadCalendarDay Repeatable="Today">
                                                    <ItemStyle BackColor="Pink" />
                                                </telerik:RadCalendarDay>
                                            </SpecialDays>
                                        </Calendar>
                                    </telerik:RadDatePicker>
                                    <asp:TextBox ID="txtCompTime" Width="80" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="Server" Text="Remarks" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtStatusRemarks" runat="Server" MaxLength="2400" CssClass="form-control" ToolTip=" Write here any remarks after completion of a task. It can also be some additional information that will help." Width="300px" ForeColor="Black" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Height="60px"></asp:TextBox>
                                </td>
                            </tr>
                             <tr>
                                <td>
                                    <asp:Label ID="lblGrossamount" runat="server" Text="Gross Amount" Font-Names="Verdana"  ForeColor="Black" CssClass="Font_lbl2" Visible="false"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtNetAmount" runat="server" Visible="false" CssClass="form-control" Font-Names="Verdana"  Height="25px" ToolTip=" Enter the amount charged. Taxes will be calculated based on the % set.  Note that the customer will be debited the amount indicated in the Amount To Pay field.   If the service is free, no amount need be entered and hence no financial transactions will be generated." Width="200px" Enabled="true" onkeypress="return isNumberKey(event);" OnTextChanged="txtNetAmount_TextChanged" AutoPostBack="true"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td colspan="3">
                                     <asp:Label ID="lblAccount" runat="server" Text="Acc.Code - " CssClass="Font_lbl2" Font-Names="Verdana" ForeColor="Black" Font-Size="X-Small" Visible="false" Enabled="false"></asp:Label>
                                    <asp:Label ID="lblAccountcd" runat="server" Text=" - " ForeColor="Maroon" Font-Names="Verdana" Font-Bold="true" Font-Size="X-Small" Visible="false"></asp:Label>
                                    <asp:Label ID="lbltaxamount" runat="server" Text="CGST -Rs. "  Font-Names="Verdana" ForeColor="Black" Font-Size="X-Small" CssClass="Font_lbl2" Visible="false" Enabled="false"></asp:Label>
                                    <asp:Label ID="lblCGST" runat="server" Text=" - " ForeColor="Maroon" Font-Names="Verdana"  Font-Bold="true" Font-Size="X-Small" Visible="false"></asp:Label>
                                    <asp:Label ID="lbltaxpercentage" runat="server" Text=" - " ForeColor="Maroon" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="true" Visible="false"></asp:Label>
                                    <asp:Label ID="lblsgstamount" runat="server" Text="SGST -Rs. " Font-Names="Verdana" CssClass="Font_lbl2" Font-Size="X-Small" ForeColor="Black" Visible="false" Enabled="false"></asp:Label>
                                    <asp:Label ID="lblSGST" runat="server" Text=" - " ForeColor="Maroon" Font-Names="Verdana" Font-Bold="true" Font-Size="X-Small" Visible="false"></asp:Label>
                                    <asp:Label ID="lblsgstpercentage" runat="server" Text=" - " ForeColor="Maroon" Font-Names="Verdana" Font-Bold="true" Font-Size="X-Small" Visible="false"></asp:Label>
                                    <asp:Label ID="lblnet" runat="server" Text="Amount To Pay - Rs. " CssClass="Font_lbl2" Font-Names="Verdana" ForeColor="Black" Font-Size="X-Small"  Visible="false" Enabled="false"></asp:Label>
                                    <asp:Label ID="lblNetAmount" runat="server" Text=" - " ForeColor="Maroon" Font-Names="Verdana" Font-Bold="true" Font-Size="X-Small" Visible="false"></asp:Label>
                                </td>
                            </tr>         
                            <tr>
                                <td>

                                </td>
                                <td>
                                     <asp:Button ID="btnUpdate" runat="server" CssClass="btn" BackColor="BlueViolet" Font-Bold="true" Text="Update" ForeColor="White" Visible="true" OnClick="btnUpdate_Click" OnClientClick="javascript:return TaskConfirmMsg2()" ToolTip="Click here to modify all details except status.  If the request is completed, press Done button." />
                                      <asp:Button ID="btnDone" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Completed" ForeColor="White" Visible="true" OnClick="btnDone_Click" OnClientClick="javascript:return alertMsg()" ToolTip=" If the request is completed, make sure you have entered the Completed date and time. By pressing Done, the status is marked as Done and the resident may be debited a certain amount. The amount is entered only after the ‘Done’ button is pressed. The Taxes and the net amount are automatically calculated and posted to the respective accounts." />
                                     <asp:Button ID="btnSave" runat="server" CssClass="btn" BackColor="Orange" Font-Bold="true" Text="Done" ForeColor="White"  OnClick="btnSave_Click" Visible="false"  OnClientClick="javascript:return ConfirmMsg()" ToolTip="Please click here to Save data,Update Status of service and Post transactions" />
                                     <asp:Button ID="btnReturn" runat="server" CssClass="btn btn-danger"  Font-Bold="true" Text="Return" ForeColor="White" OnClick="btnReturn_Click" Visible="true"  OnClientClick="javascript:return ReturnMsg()" ToolTip="Click here to Abort the transactions" />
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
                                                <asp:Label ID="lblhelp1" Visible="false" runat="server" Text="-"  Font-Names="verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                        </tr>
                                        </table>
                             </td>
                        </tr>
</table>
                
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="txtNetAmount" />
                    <asp:AsyncPostBackTrigger ControlID="ddlSerType" /> 
                    <asp:AsyncPostBackTrigger ControlID="btnDone" />  
                    <asp:PostBackTrigger ControlID="btnSave" />  
                    <asp:PostBackTrigger ControlID="btnUpdate" />   
                    <asp:AsyncPostBackTrigger ControlID="btnReturn" />                   

                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>



</asp:Content>

