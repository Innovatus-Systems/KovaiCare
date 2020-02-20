<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="OutstandingAdding.aspx.cs" Inherits="OutstandingAdding" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
     <style>
        .rightAlign { text-align:right; }
    </style>
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

            var result = confirm('You are about to update the outstanding for the selected resident. Confirm?');

            if (result) {
                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }

        }
        function allowOnlyNumber(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }
        function isNumberKey(evt) {
            debugger;
            var charCode = (evt.which) ? evt.which : event.keyCode

            if (charCode == 45 || charCode == 46) {
                var inputValue = $("#txtOpeningbalance").val()
                if (inputValue.indexOf('.') < 1) {
                    return true;
                }
                if (inputValue.indexOf('-') < 1) {
                    return true;
                }
                return false;
            }
            if (charCode != 45 && charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }            
            return true;
        }
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
            <table align="center" style="width: 100%;">
                <tr>
                    <td style="width: 100%" align="center">
                        <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                    </td>
                </tr>
            </table>
             <asp:HiddenField ID="CnfResult" runat="server" />
              <table align="center" >
                  <tr>
                      <td>
                          <asp:Label ID="lblName" runat="server" Text="For Whom? :" Font-Bold="true"></asp:Label>  &nbsp;&nbsp;&nbsp;&nbsp;
                                 <telerik:RadComboBox ID="drpName" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                AutoPostBack="true" Font-Names="Arial" Font-Size="Small"
                                Width="250px" ToolTip=""  OnSelectedIndexChanged="drpName_SelectedIndexChanged"
                                RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                            </telerik:RadComboBox> 
                      </td>
                  </tr>
                  <tr>
                      <td>
                          <asp:Label ID="lblDetails" runat="server" Text="-" ForeColor="Maroon" Font-Bold="true" Visible="false"></asp:Label> 
                      </td>
                  </tr>
                  <tr>
                      <td>
                          <asp:Label ID="lblOpen" runat="server" Text="Opening Bal.:" Font-Bold="true"></asp:Label>  &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:TextBox ID="txtOpeningbalance" runat="server" CssClass="rightAlign" Width="170px" onkeypress="return isNumberKey(event);"></asp:TextBox>
                      </td>
                  </tr>
                  <tr>
                      <td align="center">
                          <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="btn btn-success" OnClientClick="ConfirmMsg()"/>
                          <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CssClass="btn btn-danger" />
                      </td>
                  </tr>
                  </table>
        </div>
    </div>
</asp:Content>

