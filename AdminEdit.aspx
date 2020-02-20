<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="AdminEdit.aspx.cs" Inherits="AdminEdit" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });
     function ConfirmMsg() {

    var result = confirm('Are you sure want to Update?');

    if (result) {

        document.getElementById('<%=HRResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=HRResult.ClientID%>').value = "false";
            }

}
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="main_cnt">
        <div class="first_cnt">
     <div style="width:82%; min-height:400px" >
          

            <table>
              
                <tr>
                    <td>
                        <asp:Label ID="lblCName" runat="Server" Text="CommunityName" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                        <%--<asp:Label ID="Label3" runat="Server" Text="*" Width="10px" ForeColor ="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>--%>
                    </td>
                    <td>
                          <asp:TextBox ID="TxtCommunityName" runat="Server" MaxLength="80" ToolTip="Enter the Community Name" Width="250px" Height="30px"
                             Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>        
                                <tr>
                    <td>
                        <asp:Label ID="lblFromID" runat="Server" Text="From ID" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtFromID" runat="Server" MaxLength="80" ToolTip="Enter the Email ID(All of the Mails are goes through this Mail ID)" Width="250px" Height="30px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblFromMobileNo" runat="Server" Text="From Mobile No" ForeColor=" Black "
                            Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtFromMobileNo" runat="Server" MaxLength="80" ToolTip="Enter the Mobile Number(All of the messages are goes through this number)" Width="250px" Height="30px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblContactPName" runat="Server" Text="Contact Person Name" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtContactPName" runat="Server" MaxLength="80" ToolTip="Enter " Width="250px" 
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" 
                            Height="30px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblScrollmessage" runat="Server" Text="Message" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtscrollmessage" runat="Server" MaxLength="80" ToolTip="Enter " Width="250px"  TextMode ="MultiLine"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" 
                            Height="60px"></asp:TextBox>
                    </td>
                </tr>
                <%-- <tr>
                    <td>
                        <asp:Label ID="lblNBD" runat="Server" Text="Next Billing Date" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>

                        <telerik:RadDatePicker ID="NextBDate" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick Next  Billing Date."
                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                            <DatePopupButton ></DatePopupButton>
                            <DateInput ID="DateInput1" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
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
                   
                </tr>--%>
                <asp:HiddenField ID="HRResult" runat="server" />
              
            </table>    

            <table>
                <tr>
                    <td>
                        <asp:Button ID="btnUpdate" runat="Server" Width="100px" Text="Update" ToolTip="Click here to save the details."
                            ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" OnClientClick="ConfirmMsg()" Font-Size="Small" OnClick="btnUpdate_Click" />
                    </td>
                    <%-- End of Button Save --%>
                    <%-- Button Clear --%>
                    <td>
                        <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Click here to clear entered details."
                            ForeColor="White" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Small" OnClick="btnClear_Click" />
                    </td>
                    <%-- End of Button Clear --%>
                    <%-- Button Exit --%>
                    <td>
                        <asp:Button ID="btnExit" runat="Server" Width="100px" Text="Return" ToolTip="Click here to Return Admin page."
                            ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Small" OnClick="btnExit_Click" />
                    </td>
                </tr>
            </table>
         </div>
            </div>
        </div>
</asp:Content>

