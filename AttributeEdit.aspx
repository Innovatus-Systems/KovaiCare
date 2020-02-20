<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="AttributeEdit.aspx.cs" Inherits="AttributeEdit" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
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

            var result = confirm('Are you sure, you want to save?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
            }

        }
          </script>
     <script type="text/javascript">
         function Validate() {
             var summ = "";
             summ += Phno();
             summ += Email();

             if (summ == "") {
                 var msg = "";
                 msg = 'Are you sure, you want to Update?';
                 var result = confirm(msg, "Check");
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

        function Phno() {
            var Name = document.getElementById('<%=RAContactNo.ClientID%>').value;
            var chk = /^[-+]?[0-9]+$/
            if (Name == "") {
                return "";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid Mobile No" + "\n";
            }
        }

        function Email() {
            var Name = document.getElementById('<%=RAEmailId.ClientID%>').value;
            var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
            if (Name == "") {
                return "";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid Email ID" + "\n";
            }
        }

    </script>
    <style type="text/css">

    .RadGrid th.rgHeader
    {
        background-image: none;
        background-color:  #196F3D;
        color:white;
        font-weight:bold;
    }
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
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
<div class="main_cnt">
        <div class="first_cnt">
            <asp:HiddenField ID="CnfResult" runat="server" />
            <table>
                <tr>
                    <td>
                         <asp:Label ID="lblheading" Visible="true" Text="Level J - Profile Plus"
                                Font-Bold="true" ForeColor="Blue" Font-Size="Medium" runat="server" />
                    </td>
                </tr>
                <tr>
                            <td>
                                <asp:Label ID="lblRTRSN" runat="Server" Text="RSN" ForeColor=" Black " Visible="false" Font-Names="Calibri" Font-Size="Small "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtRTRSN" runat="Server" MaxLength="18" ToolTip=" ML18." CssClass="form-controlForResidentAdd" Width="150px" Visible="false" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblRTVILLANO" runat="Server" Text="Villa No" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                <asp:Label ID="Label14" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>

                            <td>
                                <asp:TextBox ID="TxtRTVILLANO" runat="Server" MaxLength="12" ToolTip="*Villa No of the Occupant." Enabled="false" Width="150px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblRTSTATUS" runat="Server" Text="Status" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                <asp:Label ID="Label1" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                 <asp:DropDownList ID="ddlstatus" runat="server" width="200px" CssClass="form-controlForResidentAdd" ToolTip="Resident Status" Font-Names="Calibri" Font-Size="Small" ></asp:DropDownList>
                               <%-- <asp:TextBox ID="TxtRTStatus" runat="Server" MaxLength="12" ToolTip="* Status of Occupant. " Enabled="false" Width="150px" Height="25px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>--%>
                            </td>
                        </tr>
                        <tr>

                            <td>

                                <asp:Label ID="lblRTName" runat="Server" Text="Name" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                <asp:Label ID="Label2" runat="Server" Text="*" Width="10px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                        
                            <td>
                                
                                <asp:TextBox ID="TxtRTName" runat="Server" MaxLength="80" Enabled="false" Width="200px" CssClass="form-controlForResidentAdd" ToolTip="Name of the Occupant." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                       
               <%-- <tr>
                    <td>
                        <asp:Label ID="lblRARSN" runat="Server" Text="RSN" ForeColor=" Black " Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RARSN" runat="Server" MaxLength="18" ToolTip=" ML18." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                    </td>
                </tr>--%>
                <%--<tr>--%>
                    <%--<td>
                        <asp:Label ID="lblRTRSN" runat="Server" Text="Name" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label2" runat="Server" Text="*" Width="10px" ForeColor ="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>--%>
                      <%--<td >
                        <asp:Label ID="Label1" runat="Server" Text="*" Width="10px" ForeColor ="Red" Font-Names="Calibri" Font-Size="Medium "></asp:Label>
                    </td>--%>
                   <%-- <td>
                          <asp:DropDownList ID="ddlRTRSN"  Width="250px" Height="30px" runat="server" ToolTip="Select Name of the Occupant."
                        OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Small">
                    </asp:DropDownList>--%>
                       <%-- <asp:TextBox ID="RTRSN" runat="Server" MaxLength="18" ToolTip=" ML18." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>--%>
                    <%--</td>--%>
                <%--</tr>--%>
                 <tr>
                    <td>
                        <asp:Label ID="lblGroup" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small" ></asp:Label>
                        <asp:Label ID="Label5" runat="Server" Text="*" Width="10px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                        <%--<asp:Label ID="Label3" runat="Server" Text="*" Width="10px" ForeColor ="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>--%>
                    </td>
                    <td>
                          <asp:DropDownList ID="ddlGroup" AutoPostBack="true" Width="200px" CssClass="form-controlForResidentAdd" runat="server" ToolTip="Select Group of the Additional." 

                         OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Small" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged" >
                              <%--OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged"--%>
                               <%--<asp:ListItem Text="--- Select ---" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Incase of emergency" Value="1CE"></asp:ListItem>
                                                <asp:ListItem Text="NextOfKin" Value="NOK"></asp:ListItem>
                                                <asp:ListItem Text="Personal" Value="Personal"></asp:ListItem>
                                                <asp:ListItem Text="Health" Value="Health"></asp:ListItem>
                                                <asp:ListItem Text="Hwatch" Value="Hwatch"></asp:ListItem>
                                                <asp:ListItem Text="Special" Value="Special"></asp:ListItem>--%>
                                            </asp:DropDownList>
                  
                    
                       <%-- <asp:TextBox ID="RTRSN" runat="Server" MaxLength="18" ToolTip=" ML18." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>--%>
                    </td>

                 </tr>
                 <tr>
                    <td>
                        <asp:Label ID="lblpriority" runat="Server" Text="Subgroup Priority" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                          <asp:DropDownList ID="ddlpriority"  Width="200px" CssClass="form-controlForResidentAdd" runat="server" ToolTip="Select the above chosen Subgroup's Priority."
                        OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Small">
                              <asp:listitem Text ="No" Value="N"></asp:listitem>     
                               <asp:listitem Text ="Yes" Value="Y"></asp:listitem>    
                          </asp:DropDownList>
                    </td>
                </tr>

                <%-- <tr>
                    <td>
                        <asp:Label ID="lblpriority" runat="Server" Text="Priority" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                          <asp:DropDownList ID="ddlpriority"  Width="200px" Height="30px" runat="server" ToolTip="Select Priority of the Occupant."
                        OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Small">
                    </asp:DropDownList>
                    </td>
                </tr>--%>
                

                <tr>
                    <td>
                        <asp:Label ID="lblRACode" runat="Server" Text="Code" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                        
                    </td>
                    <td>
                        <%--<asp:TextBox ID="RACode" runat="Server" MaxLength="8" ToolTip=" ML8." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>--%>
                        <asp:DropDownList ID="ddlRACode"  Width="200px" CssClass="form-controlForResidentAdd" runat="server" ToolTip="Profile++ code within a group. All codes having Priority as 'Yes' are automatically added to the profile."
                        OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Small" AutoPostBack="true" >
                           <%-- <asp:ListItem Text ="Family" Value ="Family"></asp:ListItem>
                            <asp:ListItem Text ="Personal" Value ="Personal"></asp:ListItem>
                             <asp:ListItem Text ="Incase of emergency" Value ="ICE"></asp:ListItem>
                            <asp:ListItem Text ="Owner" Value ="Owner"></asp:ListItem>--%>
                    </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRAText" runat="Server" Text="Details" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RAText" runat="Server" MaxLength="40" ToolTip="Details relevant to the Profile++ code. " Width="300px" CssClass="form-controlForResidentAdd" Height="40px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblDOB" runat="Server" Text="Date of Birth" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>

                        <telerik:RadDatePicker ID="FromDate" runat="server" Font-Names="Calibri" Font-Size="Small" ToolTip="This field is used where the Next Of Kin details are filled.Useful for sending Birthday greetings."
                            Culture="English (United Kingdom)" Skin="Default" Width="200px" EnableTyping="False" DateInput-CausesValidation="true" MinDate="01-01-1200" CssClass="form-controlForResidentAdd">
                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                            <DateInput ID="DateInput2" DateFormat="dd-MMM-yyyy ddd" runat="server" Font-Names="Calibri" Font-Size="Small" ReadOnly="True">
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
                    <%--<td>
                        <asp:TextBox ID="FromDate" runat="Server" MaxLength="80" ToolTip=" ML80." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                    </td>--%>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRAValue" runat="Server" Text="Value" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small" Visible="false"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RAValue" runat="Server" MaxLength="10" ToolTip="Enter Value of the Additional." Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" Visible="false"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRADate" runat="Server" Text="Date" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>

                         <telerik:RadDatePicker ID="RADate" runat="server" Font-Names="Calibri" Font-Size="Small" Width="200px" CssClass="form-controlForResidentAdd" ToolTip="This field is with reference to the Profile++ code. Ex. Driving Licence expire date."
                            Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" >
                            <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
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
                                                                        
                       <%-- <asp:TextBox ID="RADate" runat="Server" MaxLength="20" ToolTip=" ML." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>--%>
                </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRAContactNo" runat="Server" Text="ContactNo" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RAContactNo" runat="Server" MaxLength="80" ToolTip="Contact Number if applicable for the Profile++ code." Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRAEmailId" runat="Server" Text="Email ID" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RAEmailId" runat="Server" MaxLength="80" ToolTip="EMail ID if applicable for the Profile++ code." Width="300px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRARemarks" runat="Server" Text="Remarks" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RARemarks" runat="Server" MaxLength="480" ToolTip="Any additional remarks about the Profile++ Code. Ex.Postal address of son." Width="300px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline" Height="60px" CssClass="form-controlForResidentAdd"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                                            <td>
                                                <asp:Label ID="Label3" runat="Server" Text="PopUp" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                                <asp:Label ID="Label4" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPopup" AutoPostBack="true" CssClass="form-controlForResidentAdd" runat="server" ToolTip="Select a 'Group' from the list shown"
                                                    Font-Names="Calibri" Font-Size="Small" >
                                                    <asp:ListItem Text="No" Value="No"></asp:ListItem>
                                                    <asp:ListItem Text="Yes" Value="Yes"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
              
            </table>
            <table>
                <tr>
                     <td>
                        <asp:Button ID="btnUpdate" runat="Server" Width="100px" CssClass="btn" Text="Update" ToolTip="Clik here to save the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" Font-Size="Small" OnClientClick="javascript:return Validate()" OnClick="btnUpdate_Click" />
                    </td>
                    <%-- End of Button Save --%>
                    <%-- Button Clear --%>
                   <td>
                        <asp:Button ID="btnClear" runat="Server" Width="100px" CssClass="btn" Text="Clear" ToolTip=" Clik here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Small" OnClick="btnClear_Click" />
                    </td>
                    <%-- End of Button Clear --%>
                    <%-- Button Exit --%>
                    <td>
                        <asp:Button ID="btnExit" runat="Server" Width="100px" CssClass="btn" Text="Exit" ToolTip="Clik here to exit" ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Small" OnClick="btnExit_Click" />
                    </td>
                </tr>
            </table>
                  </div>
    </div>
    
</asp:Content>

