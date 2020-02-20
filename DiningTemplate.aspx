<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="DiningTemplate.aspx.cs" Inherits="DiningTemplate" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function confirm_download() {
            if (!confirm("The template can be downloaded on the first of every month for that month before 12PM."))
                return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="main_cnt">

        <div class="first_cnt" style="height: 300px">

            <%--<span class="h3">Download/Upload Dining Templates for the Month</span>--%>
            <span class="h3"><asp:Label ID="lblHeading" runat="server" ></asp:Label></span><br />
            <span class="h5"><asp:Label ID="lblHeading2" runat="server" ForeColor="Maroon"></asp:Label></span>

            <table>

                

                <tr>
                    <td colspan="4">
                        <br />
                        <br />
                    </td>
                </tr>
                <tr style="border: 1px solid black">
                    <td class="h4">Download &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
                    <td>For the month of </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtMonthYear" ReadOnly="true" Width="80px" ></asp:TextBox>
                        <%--<asp:DropDownList ID="ddlMonthYear" runat="server">
                            <asp:ListItem Selected="True" Value="0"> Select </asp:ListItem>
                            <asp:ListItem Value="1"> Jul2019 </asp:ListItem>
                            <asp:ListItem Value="2"> Aug2019 </asp:ListItem>
                            <asp:ListItem Value="3"> Sep2019 </asp:ListItem>
                            <asp:ListItem Value="4"> Oct2019 </asp:ListItem>
                            <asp:ListItem Value="5"> Nov2019 </asp:ListItem>
                            <asp:ListItem Value="6"> Dec2019 </asp:ListItem>

                        </asp:DropDownList>--%>
                    </td>
                    <%--<td class="h4">Download &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>--%>
                    <td>Choose session <span style="color: red">*</span> </td>
                    <td>
                        <asp:DropDownList ID="ddlsession" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlsession_Change">
                            <asp:ListItem Selected="True" Value="0"> Select </asp:ListItem>
                            <asp:ListItem Value="1"> Breakfast </asp:ListItem>
                            <asp:ListItem Value="2"> Lunch </asp:ListItem>
                            <asp:ListItem Value="3"> Dinner </asp:ListItem>

                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Button runat="server" ID="butDownload" Text="Download Template" OnClick="butDownload_Click"  />

                        <%--OnClientClick="return confirm_download();"--%>
                    </td>
                </tr>

                 <tr>
                    <td>
                        <asp:Label ID="lblCount" runat="server" ForeColor="Black"></asp:Label>
                    </td>
                </tr>



            </table>
            <br />
            <br />
            <%--   <table>

                   <tr  style="border:1px solid black">
                       <td class="h4"> Upload Section &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td> 
                       <td><asp:FileUpload runat="server" ID="fu_Dining"   /> </td><td> <asp:Button runat="server" ID="btnUpload" Text="Upload File" OnClick="btnUpload_Click" /></td> </tr>
              </table>--%>
        </div>
    </div>

</asp:Content>

