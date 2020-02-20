<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="BPEdit.aspx.cs" Inherits="BPEdit" %>
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
                        <asp:Label ID="lblBPFrom" runat="Server" Text="Billing Period From" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                        <%--<asp:Label ID="Label3" runat="Server" Text="*" Width="10px" ForeColor ="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>--%>
                    </td>
                    <td>
                         
                        <telerik:RadDatePicker ID="BPFrom" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick Next  Billing Date."
                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                            <DatePopupButton ></DatePopupButton>
                            <DateInput ID="DateInput2" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
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
                    <td>
                        <asp:Label ID="lblBPTill" runat="Server" Text="Billing Period Till" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                         <telerik:RadDatePicker ID="BPTill" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="Pick Next  Billing Date."
                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true">
                            <DatePopupButton ></DatePopupButton>
                            <DateInput ID="DateInput3" DateFormat="dd-MMM-yy ddd" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
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
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblBStatus" runat="Server" Text="Billing Status" ForeColor=" Black "
                            Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                          <asp:DropDownList ID="ddlBStatus"  Width="200px" ToolTip="*Select Billing Status" Height ="25px" runat="server"
                        Font-Names="Calibri" Font-Size="Small"  >
                              <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                                <asp:ListItem Text="Closed" Value="Closed"></asp:ListItem>
                                <asp:ListItem Text="Not Open" Value="Not Open"></asp:ListItem>
                    </asp:DropDownList>

                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCumulativeOutstanding" runat="Server" Text="Cumulative OutStanding" Visible="false" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="TxtCumulativeOutstanding" runat="Server" MaxLength="10" ToolTip="Enter "  Visible="false" Width="250px" 
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" 
                            Height="30px"></asp:TextBox>
                    </td>
                     <asp:HiddenField ID="HRResult" runat="server" />
                </tr>
                 
              
            </table>

        

            <table>
                <tr>
                    <td>
                        <asp:Button ID="btnUpdate" runat="Server" Width="100px" Text="Update" ToolTip="Clik here to save the details."
                            ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" OnClientClick="ConfirmMsg()" Font-Size="Small" OnClick="btnUpdate_Click" />
                    </td>
                    <%-- End of Button Save --%>
                    <%-- Button Clear --%>
                    <td>
                        <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Clik here to clear entered details."
                            ForeColor="White" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Small" OnClick="btnClear_Click" />
                    </td>
                    <%-- End of Button Clear --%>
                    <%-- Button Exit --%>
                    <td>
                        <asp:Button ID="btnExit" runat="Server" Width="100px" Text="Return" ToolTip="Clik here to Exit."
                            ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Small" OnClick="btnExit_Click" />
                    </td>
                </tr>
            </table>
         </div>
            </div>
        </div>

</asp:Content>

