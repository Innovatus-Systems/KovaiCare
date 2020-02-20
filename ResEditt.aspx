<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="ResEditt.aspx.cs" Inherits="ResEditt" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
 
    <script type="text/javascript" language="javascript">
        $(window).scroll(function () {
            if ($(window).scrollTop() >= 300) {
                $('nav').addClass('fixed-header');
            }
            else {
                $('nav').removeClass('fixed-header');
            }
        });
        function askConfirm() {
            if (confirm("Are you sure to Update? "))
                alert(" ")
            else {
                //alert(" ")

                return false;
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

    <script type="text/javascript">
        function Validate() {
            var summ = "";
            summ += Phno();
            summ += Email();
            summ += ID();
            summ += Name();
            summ += Designation();
            summ += UserID();
            summ += pwd();
            summ += Country();
            summ += AltEmail();

            if (summ == "") {
                var msg = "";
                msg = 'Are you sure to Update?';
                var result = confirm(msg, "Check");
                if (result) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                alert(summ);
                return false;
            }

        }
        function Country() {
            var Name = document.getElementById('<%=Country.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Country Name" + "\n";
            }
            else {
                return "";
            }
        }
        function ID() {
            var Name = document.getElementById('<%=RTName.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Name" + "\n";
            }
            else {
                return "";
            }
        }
        function Name() {
            var Name = document.getElementById('<%=RTVILLANO.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Villa No" + "\n";
            }
            else {
                return "";
            }
        }
        function Designation() {
            var Name = document.getElementById('<%=RTAddress1.ClientID%>').value;
            if (Name == "") {
                return "Please Enter Address" + "\n";
            }
            else {
                return "";
            }
        }
        function UserID() {
            var Name = document.getElementById('<%=CityName.ClientID%>').value;
            if (Name == "") {
                return "Please Enter City" + "\n";
            }
            else {
                return "";
            }
        }
        function pwd() {
            var Name = document.getElementById('<%=Pincode.ClientID%>').value;
            var chk = /^[0-9]+$/
            if (Name == "") {
                return "Please Enter Pincode" + "\n";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid Pincode" + "\n";
            }
        }

        function Phno() {
            var Name = document.getElementById('<%=Contactcellno.ClientID%>').value;
             var chk = /^[-+]?[0-9]+$/
             if (Name == "") {
                 return "Please Enter Mobile No" + "\n";
             }
             else if (chk.test(Name)) {
                 return "";
             }
             else {
                 return "Please Enter Valid Mobile No" + "\n";
             }
         }

         function Email() {
             var Name = document.getElementById('<%=Contactmail.ClientID%>').value;
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
         function AltEmail() {
             var Name = document.getElementById('<%=AlternateEMAILID.ClientID%>').value;
            var chk = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/
            if (Name == "") {
                return "";
            }
            else if (chk.test(Name)) {
                return "";
            }
            else {
                return "Please Enter Valid Alternate Email ID" + "\n";
            }
        }
    </script>
    <style type="text/css">
        .auto-style1 {
            height: 41px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>

    <div class="main_cnt">
        <div class="first_cnt">
            <table>
                <tr>
                    <td>
                        <telerik:RadWindow ID="rwPopup" Width="350" Height="195" VisibleOnPageLoad="false" runat="server" Title="Billing rules for regular diners" Modal="true"  BackColor="White" VisibleStatusbar="false">
                            <ContentTemplate>
                                <table style="width: 100%; background-color:#ffffcc">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="Label14" runat="Server" Text="Rate per meal:" Font-Names="verdana" ForeColor="Brown" ToolTip="This is the rate applied per meal if a person consumes atleast the minimum no.of meals in the month."></asp:Label>
                                            <asp:Label ID="lblMealRate" runat="Server" Text="" Font-Names="verdana" ForeColor="Brown" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="Label13" runat="Server" Text="No. of meals per day:" Font-Names="verdana" ForeColor="Brown" ToolTip="Sessions with codes 10,20,30 , 40  are termed as main sessions and these are considered to count the no.of meals in a day.  (Typically Breakfast, Lunch, Dinner are considered as main sessions / meals , while sessions for Tea, Evening Tiffin are not so)."></asp:Label>
                                            <asp:Label ID="lblNoMeals" runat="Server" Text="" Font-Names="verdana" ForeColor="Brown" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="Label16" runat="Server" Text="Minimum no. of meals:" Font-Names="verdana" ForeColor="Brown" ToolTip=" These many meals are to be consumed in a month as otherwise the exception rate will be charged."></asp:Label>
                                            <asp:Label ID="lblMinMeals" runat="Server" Text="" Font-Names="verdana" ForeColor="Brown" Font-Bold="true"></asp:Label>
                                        </td>
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="Label18" runat="Server" Text="Rate Exception:" Font-Names="verdana" ForeColor="Brown" ToolTip="This rate is applied per meal if the no.of meals in a month goes below the minimum value."></asp:Label>
                                                <asp:Label ID="lblRateExcep" runat="Server" Text="" Font-Names="verdana" ForeColor="Brown" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                    </tr>
                                </table>
                                <table  style="width: 100%; background-color:#ffffcc">
                                    <tr>
                                        <td align="lef">
                                            <asp:Label ID="Label15" runat="Server" Text="This data is maintained in the Settings." Font-Size="X-Small" Font-Names="verdana"  ForeColor="DarkGray" ></asp:Label><br />
                                            <asp:Label ID="Label17" runat="Server" Text="This popup appears only for regular diners." Font-Size="X-Small" Font-Names="verdana"   ForeColor="DarkGray" ></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            
                        </telerik:RadWindow>

                    </td>
                </tr>
            </table>



            <table>
                <tr>
                    <td>
                        <asp:Label ID="LblRTRSN" runat="Server" Enabled="false" Text="RSN" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                        <%--<asp:Label ID="Label13" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>--%>
                    </td>

                    <td>
                        <asp:TextBox ID="TxtRTRSN" runat="Server" MaxLength="4" Enabled="false" ToolTip="*Enter resident's RSN No" Width="150px" Height="25px" ForeColor=" DarkBlue" Font-Names="Verdana" Visible="false" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRTVILLANO" runat="Server" Text="VillaNo" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label44" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="RTVILLANO" Enabled="false" runat="Server" MaxLength="4" ToolTip="*Enter the Villa / Appartment / House No. of the resident." Width="150px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                        <asp:DropDownList ID="ddlvillano" ToolTip="Select Villa No of the Occupant." Width="200px" Height="25px" runat="server"
                            Font-Names="Verdana" Font-Size="Small" AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                    <td rowspan="3">
                        <asp:Image ID="Cusimage" GenerateEmptyAlternateText="true" AlternateText="No Photo available." runat="server" Height="100px" Width="100px" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRTSTATUS" runat="Server" Text="Status" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label1" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:DropDownList ID="ddlstatus" ToolTip="*Select status of the Occupant." Width="200px" CssClass="form-controlForResidentAdd" runat="server" Font-Names="Verdana" Font-Size="Small" Enabled="true">
                        </asp:DropDownList>
                        <%--OnDataBound="Cmb_DataBound"--%>                        <%--<asp:TextBox ID="RTSTATUS" runat="Server" MaxLength="12" ToolTip=" ML12." Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>--%>
                    </td>
                </tr>
                 <tr>
                    <td>
                        <asp:Label ID="Label22" runat="Server" Text="Door No. Status" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>                        
                    </td>

                    <td>
                        <asp:DropDownList ID="ddlDoorNoStatus" ToolTip="Select if you want to change the Door No. status" Width="200px" CssClass="form-controlForResidentAdd" runat="server" Font-Names="Verdana" Font-Size="Small" Enabled="true">
                        </asp:DropDownList>
                        <%--OnDataBound="Cmb_DataBound"--%>                        <%--<asp:TextBox ID="RTSTATUS" runat="Server" MaxLength="12" ToolTip=" ML12." Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>--%>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRTName" runat="Server" Text="Resident Name / ID" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label3" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                    </td>


                    <td>
                        <asp:TextBox ID="RTName" runat="Server" MaxLength="80" ToolTip="*Enter Resident name" Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                        <asp:TextBox ID="txtresidnetid" runat="Server" MaxLength="80" ToolTip="Unique auto assigned number per resident. This does not change even if the resident changes houses. One ID per each resident in a house. " Width="60px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>
                    </td>

                </tr>




                <tr>
                    <td>
                        <asp:Label ID="lblGender" runat="Server" Text="Gender" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label2" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>
                    <td>

                        <asp:DropDownList ID="ddlgender" Width="150px" ToolTip="*Select Male or Female" CssClass="form-controlForResidentAdd" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                            <%--  <asp:ListItem Text="--Select--" Value="-"></asp:ListItem>
                             <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                             <asp:ListItem Text="Female" Value="Female"></asp:ListItem>--%>
                        </asp:DropDownList>                        
                    </td>
                   <td>
                        <asp:Label ID="Lblmarital" runat="Server" Text="Marital Status" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label19" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>
                    <td>

                        <asp:DropDownList ID="ddlMarital" Width="200px" ToolTip="*Select Marital Status of the Occupant." CssClass="form-controlForResidentAdd" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                            <%--<asp:ListItem Text="--- Select ---" Value="0"></asp:ListItem>--%>
                            <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                            <asp:ListItem Text="Bachelor" Value="Bachelor"></asp:ListItem>
                            <asp:ListItem Text="Widower" Value="Widower"></asp:ListItem>
                            <asp:ListItem Text="Not Known" Value="NotKnown"></asp:ListItem>
                        </asp:DropDownList>
                        <%--<td>
                        <asp:TextBox ID="Gender" runat="Server" MaxLength="8" ToolTip=" ML8." Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>

                    </td>--%>
                        
                    </td>
                </tr>
               <tr>
                <td colspan="2">
                    <asp:Label ID="Label34" runat="Server" Text=" Communication/Permanant Address" ForeColor="DarkGreen" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                </td>
            </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRTAddress1" runat="Server" Text="Address" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label4" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>

                    </td>

                    <td>
                        <asp:TextBox ID="RTAddress1" runat="Server" MaxLength="80" ToolTip="Sometimes, the communication address of the resident may be different and which may be the one present in the identity documents. If so, enter the communication address here and in these five fields (Address, Address1, City, Pin Code, Country)." Width="350px" Height="40px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                     <td>
                        <asp:Label ID="lblRTAddress2" runat="Server" Text="Address1" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="RTAddress2" runat="Server" MaxLength="80" ToolTip="Enter resident's address for contact" Width="350px" Height="40px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
              
                <tr>
                    <td>
                        <asp:Label ID="lblCityName" runat="Server" Text="City" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label5" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="CityName" runat="Server" MaxLength="80" ToolTip="*Enter City" Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblPincode" runat="Server" Text="Pin Code" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label6" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="Pincode" runat="Server" MaxLength="80" ToolTip="*Enter the Pincode" Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
              
                <tr>
                    <td>
                        <asp:Label ID="lblCountry" runat="Server" Text="Country" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label7" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="Country" runat="Server" MaxLength="20" ToolTip="*Enter Country" Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Text="India" Font-Names="Verdana" Font-Size="Small">India</asp:TextBox>
                    </td>
                     <td>
                        <asp:Label ID="lblContactno" runat="Server" Text="Contact No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="Contactno" runat="Server" MaxLength="80" ToolTip="Enter resident's contact number" Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
             
                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="lblContactcellno" runat="Server" Text="Mobile No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label8" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td class="auto-style1">
                        <asp:TextBox ID="Contactcellno" runat="Server" MaxLength="13" ToolTip="*Enter resident's mobile number" Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblContactmail" runat="Server" Text="Mail Id" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="Contactmail" runat="Server" MaxLength="80" ToolTip="Enter resident's Mail ID " Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
              
                <tr>
                     <td>
                        <asp:Label ID="lblDOB" runat="Server" Text="Date of Birth" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>
                    <td>

                        <telerik:RadDatePicker ID="FromDate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Pick resident's date of birth"
                            Culture="English (United Kingdom)" Skin="Default" CssClass="form-controlForResidentAdd" EnableTyping="true" DateInput-CausesValidation="true">
                            <DatePopupButton ImageUrl="" HoverImageUrl="" ></DatePopupButton>
                            <DateInput ID="DateInput1" DateFormat="ddd dd-MMM-yy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="false">
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
                    <td>
                        <asp:Label ID="lblAlternateEMAILID" runat="Server" Text="Alternate Mail Id" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="AlternateEMAILID" runat="Server" MaxLength="80" ToolTip="Enter resident's alternate Mail Id" Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <asp:Label ID="lblBloodGroup" runat="Server" Text="BloodGroup" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>

                        <asp:DropDownList ID="ddlBloodgroup" ToolTip="Knowing the Blood Group of a resident could prove important at times." Width="200px" CssClass="form-controlForResidentAdd" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                        </asp:DropDownList>

                    </td>
                </tr>
                <%--<tr>
                    <td>
                        <asp:Label ID="lblSMSAlert" runat="Server" Text="SMS Alert? Yes/No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        <asp:Label ID="Label9" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:DropDownList ID="ddlsmsalt" ToolTip="Select Yes or No for SMS alert" Width="200px" Height="25px" runat="server"
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
                        <asp:DropDownList ID="ddlemailalt" ToolTip="Select Yes or No for Email alert" Width="200px" Height="25px" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small">
                        </asp:DropDownList>

                        </td>
                </tr>--%>
                <tr>
                    <td>
                        <asp:Label ID="lblOccupants" runat="Server" Text="Occupants" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                        <asp:Label ID="Label11" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small" Visible="false"></asp:Label>
                    </td>

                    <td>
                        <asp:DropDownList ID="ddloccupants" ToolTip="Select Occupants count" Width="200px" Height="25px" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Font-Size="Small" Visible="false">
                        </asp:DropDownList>
                    </td>
                </tr>
                <%--***--%>
                 <tr>
                    <td>
                        <asp:Label ID="Label20" runat="Server" Text="Deposit account number" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="txtDepositAccNo" runat="Server" MaxLength="80" ToolTip="Auto generated number" Width="100px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>
                    </td>
                     <td>
                        <asp:Label ID="Label21" runat="Server" Text="General account number" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="txtGeneralAccNo" runat="Server" MaxLength="80" ToolTip="Auto generated number" Width="100px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
                 
                <%--***--%>
                <tr>
                    <td>
                        <asp:Label ID="Label36" runat="Server" Text="Monthly Kitchen Overhead charges" ForeColor="Brown" Font-Names="Verdana" Font-Size="Small"></asp:Label>

                    </td>

                    <td>
                        <asp:TextBox ID="txtDiningAutoDebit" runat="Server" MaxLength="80" ToolTip="Monthly auto debit amount for regular diners." Width="100px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:Label ID="Label9" runat="Server" Text="Regular Diner" Enabled="false"  ForeColor=" Brown " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                        &nbsp;
                        <asp:DropDownList ID="ddlDAutoDebit" ToolTip="Resident Dining Type (Regular or Casual)." Width="80px" CssClass="form-controlForResidentAdd" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Enabled="true" Font-Size="Small">
                            <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                            <asp:ListItem Value="N" Text="No"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                   
                   <%-- <td>
                        <asp:ImageButton runat="server" ID="ImgBtnHelp" ImageUrl="~/Images/Help.png" ToolTip="Click here to view the billing rules for regular diners." OnClick="ImgBtnHelp_Click" />
                    </td>--%>
                </tr>
               <tr>
                    <td>
                        <asp:Label ID="Label37" runat="Server" Text="Monthly Maintenance charges" ForeColor="Brown" Font-Names="Verdana" Font-Size="Small"></asp:Label>

                    </td>

                    <td>
                        <asp:TextBox ID="txtServiceAutoDebit" runat="Server" MaxLength="80" ToolTip="Monthly auto debit amount for housekeeping services." Width="100px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:Label ID="Label10" runat="Server" Text="Auto Debit" Visible="false" ForeColor=" Brown " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlSAutoDebit" ToolTip="If you set 'No', Monthly housekeeping charges is not included in the monthend billing." Width="80px" CssClass="form-controlForResidentAdd" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Visible="false" Font-Size="Small">
                            <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                            <asp:ListItem Value="N" Text="No"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
               </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label26" runat="Server" Text="Caregiver & Nursing charges" ForeColor="Brown" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtNC" runat="Server" MaxLength="80" ToolTip="Monthly auto debit amount for Caregiver & Nursing sevices." Width="100px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" Enabled="false"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:Label ID="Label27" runat="Server" Text="Auto Debit" Visible="false" ForeColor=" Brown " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlNCAutoDebit" ToolTip="If you set 'No', Monthly Caregiver & Nursing charges is not included in the monthend billing." Width="80px" CssClass="form-controlForResidentAdd" runat="server"
                            OnDataBound="Cmb_DataBound" Font-Names="Verdana" Visible="false" Font-Size="Small">
                            <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                            <asp:ListItem Value="N" Text="No"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblWatsApp" runat="Server" Text="WhatsApp" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="WatsApp" runat="Server" MaxLength="80" ToolTip="Enter resident's WhatsApp number" Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                     <td>
                        <asp:Label ID="lblFacebook" runat="Server" Text="Facebook" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="Facebook" runat="Server" MaxLength="80" ToolTip="Enter resident's FaceBook Id" Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
              
                <tr>
                    <td>
                        <asp:Label ID="lblSkype" runat="Server" Text="Skype" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="Skype" runat="Server" MaxLength="80" ToolTip="Enter resident's Skype Id" Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                     <td>
                        <asp:Label ID="lblImages" runat="Server" Text="Image" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>

                    </td>

                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                        <asp:TextBox ID="TxtImge" Enabled="false" runat="Server" MaxLength="80" ToolTip="" Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Visible="false" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <asp:Label ID="lblRemarks" runat="Server" Text="Remarks" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="Remarks" runat="Server" MaxLength="2400" ToolTip="Enter any additional information" Width="300px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small" TextMode="Multiline" Height="70px"></asp:TextBox>

                    </td>
                </tr>
               
       <tr>
                                            <td colspan="2">
                                                <asp:Label ID="Label12" runat="Server" Text="For Office Use Only." ForeColor="DarkGreen" Font-Bold="true" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                            <asp:CheckBox ID="chkSameDetails" runat="server" Text="Same as Above" ForeColor="DarkBlue" Font-Bold="true" AutoPostBack="true" OnCheckedChanged="chkSameDetails_CheckedChanged" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                        <asp:Label ID="Label23" runat="server" Text="Date of Birth" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
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
                                        <asp:LinkButton ID="lnkClear" runat="server" ForeColor="Green" Text="Clear DOB" OnClick="lnkClear_Click" ></asp:LinkButton>
                                    </td>

                                            <td>
                                                <asp:Label ID="Label24" runat="Server" Text="Mobile No" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                               
                                            </td>

                                            <td>
                                                <asp:TextBox ID="txtOffMobNo" runat="Server" MaxLength="13" ToolTip="Enter Resident Mobile Number to show in Mobile App." Width="200px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                           
                                        </tr>
                                        <tr>
            
                                              <td>
                                                <asp:Label ID="Label25" runat="Server" Text="MailID" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                               
                                            </td>

                                            <td>
                                                <asp:TextBox ID="txtOffEmailId" runat="Server" MaxLength="80" ToolTip="Enter Mail Id of the Occupant. " Width="250px" CssClass="form-controlForResidentAdd" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                                            </td>
                                             <td colspan="2">
                                                <asp:Button ID="btnnUpdateRsnt" runat="Server" Width="100px" CssClass="btn" Text="Update" ToolTip="Click here to Update the details" ForeColor="White" BackColor="DarkGreen" Font-Names=" Verdana" Font-Size="Small" OnClick="btnnUpdateRsnt_Click" OnClientClick="javascript:return Validate()" />
                                                <asp:Button ID="btnnClear" runat="Server" Width="100px" CssClass="btn" Text="Clear" ToolTip=" Click here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Verdana" Font-Size="Small" OnClick="btnnClear_Click" />
                                                <asp:Button ID="btnnExit" runat="Server" Width="100px" CssClass="btn" Text="Return" ToolTip="Click here to return to the level S" ForeColor="White" BackColor=" DarkBlue " Font-Names="Verdana" Font-Size="Small" OnClick="btnnExit_Click" />
                                            </td>
                                        </tr>

            </table>



            <%--<asp:TextBox ID="Occupants" runat="Server" MaxLength="2" ToolTip=" ML2." Width="150px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Medium"></asp:TextBox>--%>
            <table>

                <tr>
                    <td></td>
                    <%-- Button Save --%>                    <%-- End of Button Save --%>
                    <td></td>
                    <%-- Button Clear --%>                    <%-- End of Button Clear --%>
                    <td></td>
                </tr>
            </table>
            <%-- Button Exit --%>
            <asp:HiddenField ID="CnfResult" runat="server" Visible="false" />
            <%-- GridView Start --%>
        </div>
    </div>





</asp:Content>

