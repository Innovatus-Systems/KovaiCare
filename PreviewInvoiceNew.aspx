<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="PreviewInvoiceNew.aspx.cs" Inherits="PreviewInvoiceNew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style type="text/css">
        .auto-style1 {
            margin-left: 161px;
        }
        .auto-style2 {
            width: 464px;
        }
        .auto-style3 {
            width: 693px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script type="text/javascript" language="javascript">
            //You can set the speed of flashing here
            var speed = 500;
            //Below method will create flashing effect with the help of Fade in and fade out effect
            function effectFadeIn(classname) {
                $("." + classname).fadeOut(speed).fadeIn(speed, effectFadeOut(classname))
            }
            function effectFadeOut(classname) {
                $("." + classname).fadeIn(speed).fadeOut(speed, effectFadeIn(classname))
            }
            //Calling function on pageload
            $(document).ready(function () {
                effectFadeIn('flashingTextcss');
            });
    </script>

    <div align="center">
        <table class="auto-style2">
             <tr><td height="15" class="auto-style3"></td></tr>
            <tr><td height="15" class="auto-style3"></td></tr>
            <tr><td height="15" class="auto-style3"></td></tr>
            <tr><td class="auto-style3"> <asp:Button ID="btnReturn" runat="Server" Width="121px" 
          Text="Return" ToolTip="Click here to return" ForeColor="White" BackColor="DarkBlue" 
          Font-Names="Calibri" Font-Size="Medium" OnClick="btnReturn_Click" CssClass="auto-style1" /></td></tr>
            <tr><td height="15" class="auto-style3"></td></tr>
            <tr><td height="15" class="auto-style3"></td></tr>
            <tr><td height="15" class="auto-style3"></td></tr>
            <tr><td class="auto-style3">&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp<asp:Label ID="lblPrompt" class="flashingTextcss" Visible="False" runat="server" 
           Text="No data exists for the selected Resident" ForeColor="Red"
          Font-Names="verdana" Font-Size="Large" Font-Bold="True"></asp:Label></td></tr>
        </table>
    </div>
</asp:Content>

