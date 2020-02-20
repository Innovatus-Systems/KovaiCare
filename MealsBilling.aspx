<%@ Page Title="Billing" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="MealsBilling.aspx.cs" Inherits="MessBilling" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="Scripts/jquery-1.10.2.js"></script>
    <link href="Calendar/jquery-ui-1.8.16.custom.css" rel="stylesheet" />
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script src="Calendar/jquery.validate.js"></script>
    <script src="Calendar/moment.js"></script>
    <script src="Calendar/Auto/jquery-ui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {           
            $("[id*='lbldependent']").hide();
            $("[id*='txDepentname']").hide();
        });
        $(function () {
            $("[id*='txthouseno']").autocomplete({
                source: function (request, response) {
                    var param = { keyword: $("[id*='txthouseno']").val() };
                    $.ajax({
                        url: "MealsBilling.aspx/GetResidents",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify(param),
                        dataType: "json",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('|')[0],
                                    val: item.split('|')[1]
                                }
                            }))
                        },
                        error: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (event, ui) {
                    if (ui.item) {
                        $("[id*='hbtnFor']").val(ui.item.val);
                        $("[id*='hbtnDoorno']").val(ui.item.label);
                        GetDependent();
                    }
                },
                minLength: 2
            });
            $("[id*='btnClear']").click(function () {
                alert('test');
                $("[id*='txDepentname']").val('');
                //$("[id*='txthouseno']").val('');
                $("[id*='txtdetails']").val('');
                $("[id*='hbtnFor']").val('');
                $("[id*='hbtnDoorno']").val('');
            });

            function GetDependent() {
                var doorno = $("[id*='hbtnFor']").val();
                var test = $("[id*='hbtnDoorno']").val();
                var depend = $("[id*='txDepentname']");
                $.ajax({
                    url: "MealsBilling.aspx/GetDependents",
                    type: "POST",
                    data: "{'resvalue':'" + test + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var obj = data.d;
                        alert(obj);
                        depend.val('');
                        $("[id*='hbtnDoorno']").val('');
                        if (obj != "false") {
                            $("[id*='lbldependent']").show();
                            depend.show();
                            depend.val(obj);
                        } else {
                            depend.hide();
                        }
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }

            $("[id*='txtdetails']").change(function () {
                var session = $("[id*='ddlSession']").val();
                var doorno = $("[id*='hbtnFor']").val();
                var pinno = $("[id*='txtdetails']").val();
                var raddate = $("#<%= lbldate.ClientID %>").val();
                var bcount = $("[id*='txtwehadbook']");
                var gcount = $("[id*='txtwehadguest']");
                $.ajax({
                    url: "MealsBilling.aspx/GetDinersCount",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: "{'date':'" + raddate + "','session':'" + session + "','doorno':'" + doorno + "','details':'" + pinno + "'}",
                    dataType: "json",
                    success: function (data) {
                        var result = data.d[0];
                        if(result != "false"){
                            var gres = data.d[1];
                            bcount.val(result);
                            gcount.val(gres);
                        }else{
                            alert('Sorry that was a wrong entry, try again');
                        }
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            });

            $("[id*='btnSearch']").click(function () {
                alert('test');
                var session = $("[id*='ddlSession']").val();
                var doorno = $("[id*='hbtnFor']").val();
                var pinno = $("[id*='txtdetails']").val();
                var raddate;
                $.ajax({
                    url: "MealsBilling.aspx/GetDinersCount",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: "{'date':'" + raddate + "','session':'" + session + "','doorno':'" + doorno + "','details':'" + pinno + "'}",
                    dataType: "json",
                    success: function (data) {

                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div style="width: 100%; min-height: 400px; font-family: Verdana; font-size: small;">
                        <asp:PlaceHolder ID="phMain" runat="server">
                            <asp:HiddenField ID="hbtnFor" runat="server" />
                            <asp:HiddenField ID="hbtnDoorno" runat="server" />
                            <table style="width: 100%;">
                                <tr style="width: 100%;">
                                    <td style="width: 50%;">
                                        <table cellpadding="7" cellspacing="7">
                                            <tr>
                                                <td colspan="1" align="left">
                                                    <text style="color: blue; font-size: small; font-weight: bold;">MEAL CONFIRM</text>
                                                </td>                                                
                                            </tr>
                                            <tr>
                                                <td>
                                                    Date :
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="lbldate" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select the Till date."
                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999">
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput ID="DateInput4" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
                                                </DateInput>
                                                <Calendar ID="Calendar4" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" runat="server">
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
                                                    <text>Session :</text>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlSession" runat="server" Width="250px" Height="25px">
                                                        <asp:ListItem Text="Please Select" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <text>
                                            Enter your house no.
                                        </text>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txthouseno" placeholder="Enter house no" runat="server" Width="250px" Height="25px"></asp:TextBox>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td>
                                                    <asp:Label ID="lbldependent" runat="server" Text="Dependent name :"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txDepentname" ReadOnly="true" runat="server" Width="250px" Height="25px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="background-color: blue;" colspan="1">
                                                    <text style="color: white;">
                                            ENTER ONE OF THE FOLLOWING
                                        </text>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <text>
                                            Enter your PIN/Mobile No/Date of Birth :
                                        </text>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtdetails" placeholder="Enter PIN/Mobile/DOB" runat="server" Width="250px" Height="25px"></asp:TextBox>
                                                </td>
                                            </tr>    
                                             <tr>
                                                <td>
                                                    DOB :
                                                </td>
                                                <td>
                                                    <telerik:RadDatePicker ID="raddatedob" runat="server" Font-Names="Verdana" Font-Size="Small" ToolTip="Select the Till date."
                                                Culture="English (United Kingdom)" Skin="Default" EnableTyping="False" DateInput-CausesValidation="true" ZIndex="99999999">
                                                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                <DateInput ID="DateInput1" DateFormat="dd-MMM-yyyy" runat="server" Font-Names="Verdana" Font-Size="Small" ReadOnly="True">
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
                                                <td></td>
                                                <td>
                                                    <asp:Button ID="btnSearch" runat="server" Text="Search" /> &nbsp;&nbsp;
                                                    <asp:Button ID="btnClear" runat="server" Text="Clear" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 50%;vertical-align:text-top;">
                                        <br /><br /><br />
                                        <table style="width: 100%;border:1px solid blue;border-radius:5px 5px;background-color:transparent;" border="0">
                                            <tr style="width: 100%;background-color:lightblue;">
                                                <td style="width: 40%;">                                                   
                                                </td>
                                                <td style="width: 30%;" align="center">
                                                   <text style="color:black;">Myself / Ourselves</text> 
                                                </td>
                                                <td style="width: 30%;" align="center">
                                                    <text style="color:black;">Guests</text> 
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    We had booked for
                                                </td>
                                                <td align="center">
                                                    <asp:TextBox ID="txtwehadbook" runat="server" Width="30px" Text="0"></asp:TextBox>                                                  
                                                </td>
                                                <td align="center">
                                                    <asp:TextBox ID="txtwehadguest" runat="server" Width="30px" Text="0"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    We confirm for
                                                </td>
                                                 <td align="center">
                                                    <asp:TextBox ID="txtconfirmmyself" runat="server" Width="30px" Text="0"></asp:TextBox>
                                                </td>
                                                <td align="center">
                                                    <asp:TextBox ID="txtconfirmguest" runat="server" Width="30px" Text="0"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <td align="center">
                                                   <asp:LinkButton ID="lbtngo" runat="server" Text="GO"></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:PlaceHolder>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

