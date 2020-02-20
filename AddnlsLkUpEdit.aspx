<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="AddnlsLkUpEdit.aspx.cs" Inherits="AddnlsLkUpEdit" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="main_cnt">
        <div class="first_cnt">
              <div style="width:82%; min-height:400px" >

            <table>
               <tr>
                    <td>
                        <asp:Label ID="lblRBRSN" runat="Server" Text="RSN" ForeColor=" Black " Visible="false" Font-Names="Calibri" 
                            Font-Size="Medium "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RBRSN" runat="Server" MaxLength="18" Visible="false" ToolTip=" ML18." Width="150px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblGroup" runat="Server" Text="Group" ForeColor=" Black " Font-Names="Calibri" Font-Size="Small"></asp:Label>
                        <%--<asp:Label ID="Label3" runat="Server" Text="*" Width="10px" ForeColor ="Red" Font-Names="Calibri" Font-Size="Small"></asp:Label>--%>
                    </td>
                    <td>
                          <asp:DropDownList ID="ddlGroup"  Width="200px" Height="30px" runat="server" ToolTip="Select a 'Group' from the list shown"
                        OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Small">
                                   <asp:ListItem Text="--- Select ---" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="Incase of emergency" Value="1CE"></asp:ListItem>
                                                <asp:ListItem Text="NextOfKin" Value="NOK"></asp:ListItem>
                                                <asp:ListItem Text="Personal" Value="Personal"></asp:ListItem>
                                                <asp:ListItem Text="Health" Value="Health"></asp:ListItem>
                                                <asp:ListItem Text="Special" Value="Special"></asp:ListItem>
                    </asp:DropDownList>
                       <%-- <asp:TextBox ID="RTRSN" runat="Server" MaxLength="18" ToolTip=" ML18." Width="150px" ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Medium"></asp:TextBox>--%>
                    </td>
                </tr>
               <%-- <tr>
                    <td>
                        <asp:Label ID="lblpriority" runat="Server" Text="Priority" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                          <asp:DropDownList ID="ddlpriority"  Width="200px" Height="30px" runat="server" ToolTip="Select attribute's priority"
                        OnDataBound="Cmb_DataBound" Font-Names="Calibri" Font-Size="Small">
                    </asp:DropDownList>
                    </td>
                </tr>--%>



                <tr>
                    <td>
                        <asp:Label ID="lblRACode" runat="Server" Text="Profile Code" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RACode" runat="Server" MaxLength="8" ToolTip="Enter Code of the Additional." Width="150px" Height="25px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                        <td>
                            <asp:Label ID="lblpriority" runat="Server" Text="High Priority" Width="100px" ForeColor=" Black " Font-Names="Calibri"
                                Font-Size="Small"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlpriority" Width="200px" Height="30px" runat="server" ToolTip="If Yes will  appear at the top of the list. Default is No."
                                Font-Names="Calibri" Font-Size="Small">
                                <asp:ListItem Value="N">No</asp:ListItem>
                                <asp:ListItem Value="Y">Yes</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRADescription" runat="Server" Text="Description" ForeColor=" Black "
                            Font-Names="Calibri" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RADescription" runat="Server" MaxLength="40" ToolTip="Enter clear description about Code." Width="300px" Height="25px"
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRARemarks" runat="Server" Text="Remarks" ForeColor=" Black " Font-Names="Calibri"
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="RARemarks" runat="Server" MaxLength="240" ToolTip="Enter any additional Remarks." Width="400px" 
                            ForeColor=" DarkBlue" Font-Names="Calibri" Font-Size="Small" TextMode="Multiline"
                            Height="70px"></asp:TextBox>
                    </td>
                </tr>
                
            </table>

         

            <table>
                <tr>
                    <td>
                        <asp:Button ID="btnUpDate" runat="Server" Width="100px" Text="Update" ToolTip="Click here to save the details."
                            ForeColor="White" BackColor="DarkGreen" Font-Names=" Calibri" OnClientClick="javascript:return ConfirmMsg()" Font-Size="Small" OnClick="btnUpDate_Click" />
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
                        <asp:Button ID="btnExit" runat="Server" Width="100px" Text="Return" ToolTip="Click here to Return."
                            ForeColor="White" BackColor=" DarkBlue " Font-Names="Calibri" Font-Size="Small" OnClick="btnExit_Click" />
                    </td>
                </tr>
            </table>
             
              
                
                  <asp:HiddenField ID="CnfResult" runat="server" />
                  </div>
            

        </div>
    </div>
</asp:Content>

