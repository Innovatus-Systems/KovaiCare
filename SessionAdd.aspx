<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="SessionAdd.aspx.cs" Inherits="SessionAdd" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="main_cnt">
                <div class="first_cnt">

                    
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblSCode" runat="Server" Text="Session Code" ForeColor=" Black " Visible="true" Font-Names="Verdana" Font-Size="Small "></asp:Label>
                                 <asp:Label ID="Label3" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtSCode" runat="Server" MaxLength="12" ToolTip="*Enter the Session Code" Width="150px" Visible="true" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSName" runat="Server" Text="Session Name" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                <asp:Label ID="Label14" runat="Server" Text="*" Width="5px" ForeColor="Red" Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            </td>

                            <td>
                                <asp:TextBox ID="TxtSName" runat="Server" MaxLength="40" ToolTip="*Enter the Session Name"  Width="200px" Height="25px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSHelp" runat="Server" Text="SessionHelp" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                               
                            </td>
                            <td>
                                <asp:TextBox ID="TxtSHelp" runat="Server" MaxLength="2400" ToolTip="* Enter the Session Help "  Width="300px" Height="50px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>

                            <td>

                                <asp:Label ID="lblRRate" runat="Server" Text="Resident Rate" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                                
                            </td>
                          
                            <td>
                             
                                <asp:TextBox ID="TxtRRate" runat="Server" MaxLength="8"  Width="100px" Height="25px" ToolTip="Enter the Resident Rate" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                       


                      
                        <tr>
                            <td>
                                <asp:Label ID="lblGRate" runat="Server" Text="Guest Rate" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtGRate" runat="Server" MaxLength="8" ToolTip="Enter the Guest Rate " Width="100px" Height="25px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <asp:Label ID="lblFUTo" runat="Server" Text="Free Up To" ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="TxtFUTo" runat="Server" MaxLength="2" ToolTip="Enter Value of the Additional." Width="100px" Height="25px" ForeColor=" DarkBlue" Font-Names="Verdana" Font-Size="Small"></asp:TextBox>
                            </td>
                        </tr>
                       
                       
                       
                    </table>




                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnnSave" runat="Server" Width="100px" Text="Save" ToolTip="Clik here to save the details" ForeColor="White" OnClientClick="return AskConfirm()" BackColor="DarkGreen" Font-Names=" Verdana" Font-Size="Small" OnClick="btnnSave_Click"  />
                            </td>
                            <%-- End of Button Save --%>
                            <%-- Button Clear --%>
                            <td>
                                <asp:Button ID="btnnClear" runat="Server" Width="100px" Text="Clear" ToolTip=" Clik here to clear entered details" ForeColor="Black" BackColor="DarkOrange" Font-Names="Verdana" Font-Size="Small" OnClick="btnnClear_Click" />
                            </td>
                            <%-- End of Button Clear --%>
                            <%-- Button Exit --%>
                            <td>
                                <asp:Button ID="btnnExit" runat="Server" Width="100px" Text="Exit" ToolTip="Clik here to exit" ForeColor="White" BackColor=" DarkBlue " Font-Names="Verdana" Font-Size="Small" OnClick="btnnExit_Click" />
                            </td>
                        </tr>
                    </table>
         </div>
        </div>

</asp:Content>

