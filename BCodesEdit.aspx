<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="BCodesEdit.aspx.cs" Inherits="BCodesEdit" %>

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

            var result = confirm('Are you sure, you want to save?');

            if (result) {

                document.getElementById('<%=HResult.ClientID%>').value = "true";
    }
    else {
        document.getElementById('<%=HResult.ClientID%>').value = "false";
    }

}

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="main_cnt">
                <div class="first_cnt">

                     <table>
                         <tr>
                            <td>
                                <asp:Label ID="lblBCC" runat="Server" Text="Category" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                 <asp:Label ID="Label2" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                 <asp:DropDownList ID="ddlCategory"  Width="150px" Height="30px" runat="server" ToolTip="Select Category for Billing."
                                     Font-Names="Calibri" Font-Size="Small" >
                                     <asp:ListItem Text ="--- Select ---" Value ="0"></asp:ListItem>
                                <asp:ListItem Text ="Adhoc" Value ="Adhoc"></asp:ListItem>
                            <asp:ListItem Text ="Food" Value ="FOOD"></asp:ListItem>
                              <asp:ListItem Text ="Services" Value ="Services"></asp:ListItem>      
                                                           </asp:DropDownList>
                            </td>
                            </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBCode" runat="Server" Text="Billing Code" ForeColor=" Black " Visible="true" Font-Names="Calibri" Font-Size="Small "></asp:Label>
                                 <asp:Label ID="Label3" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtBCode" runat="Server" MaxLength="8" ToolTip="*Enter the Billing Code" Width="150px" Height="25px" Visible="true" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblBDescription" runat="Server" Text="Billing Code Description" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                <asp:Label ID="Label14" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>

                            <td>
                                <asp:TextBox ID="TxtBCD" runat="Server" MaxLength="40" ToolTip="*Enter the Description about Billing Code."  Width="250px" Height="40px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMPD" runat="Server" Text="Max Per Day" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                               
                            </td>
                             <td>
                             <asp:DropDownList ID="ddlMPD" AutoPostBack="true" Width="100px" Height="25px" runat="server" ToolTip="Select Maximum allowable.(If it is 9,No Limit.If it is 0,Linked to No.Of Occupants."
                                     Font-Names="Calibri" Font-Size="Small" >
                                     <asp:ListItem Text ="- Select -" Value ="00"></asp:ListItem>
                                <asp:ListItem Text ="0" Value ="0"></asp:ListItem>
                            <asp:ListItem Text ="1" Value ="1"></asp:ListItem>
                              <asp:ListItem Text ="2" Value ="2"></asp:ListItem>      
                            <asp:ListItem Text ="3" Value ="3"></asp:ListItem>
                                  <asp:ListItem Text ="4" Value ="4"></asp:ListItem>
                            <asp:ListItem Text ="5" Value ="5"></asp:ListItem>
                              <asp:ListItem Text ="6" Value ="6"></asp:ListItem>      
                            <asp:ListItem Text ="7" Value ="7"></asp:ListItem>
                                  <asp:ListItem Text ="8" Value ="8"></asp:ListItem>
                            <asp:ListItem Text ="9" Value ="9"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                           <%-- <td>
                                <asp:TextBox ID="TxtMPD" runat="Server" MaxLength="1" ToolTip=" Enter the Maximum Allowable per day."  Width="100px" Height="20px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>--%>
                        <tr>

                            <td>

                                <asp:Label ID="lblBCR" runat="Server" Text="Rate" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                                
                            </td>
                          
                            <td>
                             
                                <asp:TextBox ID="TxtBCR" runat="Server" MaxLength="7"  Width="150px" Height="25px" ToolTip="Enter the Rate for Billing." ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <asp:Label ID="lblBCH" runat="Server" Text="Help" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtBCH" runat="Server" MaxLength="2400" ToolTip="Enter the help text about Billing." Width="300px" Height="50px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>                   
                                                                      
                        <%--<tr>
                            <td>
                                <asp:Label ID="lblBCC" runat="Server" Text="Category" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtBCC" runat="Server" MaxLength="8" ToolTip="Enter the Category of Billing. " Width="150px" Height="25px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>--%>
                        
                       
                       
                       
                       
                    </table>

                    <asp:HiddenField ID="HResult" runat ="server" />


                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnUpdate" runat="Server" Width="100px" Text="Update" ToolTip="Clik here to save the details" ForeColor="White"  OnClientClick ="ConfirmMsg()" BackColor="DarkGreen" Font-Names=" Calibri" Font-Size="Small" OnClick="btnUpdate_Click"  />
                            </td>
                            <%-- End of Button Save --%>
                            <%-- Button Clear --%>
                            <td>
                                <asp:Button ID="btnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Clik here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Calibri" Font-Size="Small" OnClick="btnClear_Click" />
                            </td>
                            <%-- End of Button Clear --%>
                            <%-- Button Exit --%>
                            <td>
                                <asp:Button ID="btnExit" runat="Server" Width="100px" Text="Exit" ToolTip="Clik here to exit" ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Small" OnClick="btnExit_Click" />
                            </td>
                        </tr>
                    </table>

                    </div>
         </div>
</asp:Content>

