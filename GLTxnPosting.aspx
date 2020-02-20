<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="GLTxnPosting.aspx.cs" Inherits="GLTxnPosting" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="CSS/bootstrap.css" rel="stylesheet"/>
   
    <style type="text/css">
        
.Loadingdiv {
     position: fixed;
    z-index: 999;
    height: 100%;
    width: 100%;
    top: 0;
    background-color: Black;
    filter: alpha(opacity=60);
    opacity: 0.6;
    -moz-opacity: 0.8;
}

.centerdiv
{
    z-index: 1000;
    margin: 300px auto;
    padding: 10px;
    width: 130px;
    background-color: White;
    border-radius: 10px;
    filter: alpha(opacity=100);
    opacity: 1;
    -moz-opacity: 1;
}
.centerdiv img
{
    height: 128px;
    width: 128px;
}
 </style>

   
    <script type="text/javascript" language="javascript">
        function HideUpdateProgress() {
            var updateProgress = document.getElementById("<%=UpdateProgress1.ClientID%>");
            updateProgress.style.display = 'none';
            Sys.Application.remove_load(HideUpdateProgress);
        }
         </script>
        <script type="text/javascript" language="javascript">
        function ConfirmMsg() {
            var result = confirm('Are you sure, you want to save it for Posting?');
            if (result) {
                return true;
            }
            else {
                return false;
            }

        }
    </script>
    <script type="text/javascript" language="javascript">
        function ConfirmMsg1() {
            var result = confirm('Are you sure, you want to Post transactions?');
            if (result) {
                return true;
            }
            else {
                return false;
            }

        }
    </script>
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script>
        $(document).ready(function () {           
            $("[id$=txtCAmount]").keypress(function (event) {
                $('#txtCAmount').text(value.toFixed(2));
                return isDecimal(event, this);
                
            });
        });               
    </script>
   <script type="text/javascript">
       function isDecimal(evt, element) {
           var charcode = (evt.which) ? evt.which : evt.keycode
           if ((charcode != 46 || $(element).val().indexOf('.') != -1) && (charcode < 48 || charcode > 57)) {
               return false;
           }
       }  
   </script>
    
    <style>
        .ddlstyle {
            color: rgb(33,33,00);
            Font-Family: Verdana;
            font-size: 12px;
            /*vertical-align: middle;*/
        }
    </style>
     <style type="text/css">
        .RadGrid th.rgHeader
    {
        background-image: none;
        background-color: #196F3D;
        color:white;
        font-weight:bold;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="main_cnt">
        <div class="first_cnt">
         <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upnlMain">
                <ProgressTemplate>
                    <%--<div class="Loadingdiv">
                        <div class="centerdiv">
                             <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label>
                            <img alt="Loading...." src="Images/Loader.gif" />
                        </div>
                    </div>--%>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel ID="upnlMain" runat="server">
                <ContentTemplate>
                    <div>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center">

                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 62%;">
                                    <table style="width: 100%;">
                                       
                                        <tr>
                                            <td colspan="3">

                                                <asp:Label ID="Label59" runat="server" Text="For which GL Account?Search by" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label><br />
                                                <telerik:RadComboBox ID="drpAccCode" runat="server" ForeColor="DarkBlue" AllowCustomText="true" AutoPostBack="true"
                                                    Font-Names="Arial" Font-Size="Small" Width="350px" ToolTip="" CssClass="form-control"
                                                    RenderMode="Lightweight" OnSelectedIndexChanged="drpAccCode_SelectedIndexChanged"  MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type GL Account number to search">
                                                </telerik:RadComboBox>
                                                 <asp:Label ID="lbldescription" runat="server" Font-Bold="false" Font-Names="verdana"  Visible="false" ForeColor="Maroon" Text=" - "></asp:Label> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblDes" runat="server" CssClass="Font_lbl2"  Visible="false" Text="Description : "></asp:Label>
                                                            
                                                             <asp:Label ID="lblAccountcode" runat="server" Font-Bold="false" Font-Names="verdana" Visible="false" ForeColor="Maroon" Text=" - "></asp:Label>                                                                                                                    
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbldrcr" runat="server" CssClass="Font_lbl2" Text=" Debit / Credit"></asp:Label>                                               
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpDRCR" runat="server" CssClass="form-control">
                                                    <asp:ListItem Text="Please Select" Value="0" Selected="True"></asp:ListItem>
                                                    <asp:ListItem Text="Debit" Value="DR"></asp:ListItem>
                                                    <asp:ListItem Text="Credit" Value="CR"></asp:ListItem>
                                              </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px;">
                                                <asp:Label ID="lblCAmount" runat="server" CssClass="Font_lbl2" Text="Amount"></asp:Label>
                                                <asp:Label ID="Label8" runat="server" Text="*" CssClass="TextBox" ForeColor="Red"></asp:Label>
                                            </td>
                                            <td >                                               
                                             <asp:TextBox ID="txtCAmount"  runat="server" CssClass="form-control" Height="25px" ToolTip="Transaction amount to post." Width="200px" ></asp:TextBox>          
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px;">
                                                <asp:Label ID="lblCNarration" runat="server" CssClass="Font_lbl2" Text="Narration"></asp:Label>
                                                <asp:Label ID="Label78" runat="server" CssClass="TextBox" ForeColor="Red" Text="*"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control" Height="50px" TextMode="MultiLine" ToolTip=" A brief description of the transaction" Width="350px"></asp:TextBox>
                                            </td>
                                        </tr>                                        
                                    </table>

                                    <table>
                                        <tr>
                                            <td style="width: 150px;"></td>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server" Text="Save" ForeColor="White" CssClass="btn btn-success" ToolTip="Click to Save Details to Gid for posting."   OnClick="btnSave_Click" OnClientClick="ConfirmMsg()"/>
                                                <asp:Button ID="btnClear" runat="server" OnClick="btnClear_Click" CssClass="btn btn-info" Text="Clear" ToolTip="Click to clear entered details" Visible="true" />
                                                <asp:Button ID="btnPost" runat="server" OnClick="btnPost_Click" AutoPostBack="true" BackColor="OrangeRed" ForeColor="White" CssClass="btn btn-group" Text="Post" ToolTip="Click to post transaction to General Ledger" Visible="true" OnClientClick="ConfirmMsg1()" />
                                           
                                            </td>
                                        </tr>
                                    </table>
                                    <br />                                   
                                </td>
                                <td style="width: 38%; vertical-align: top">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblhelp" Visible="false" runat="server" Text="Help" Font-Names="verdana" Font-Size="Medium" ForeColor="#cc0000" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <b><asp:Label ID="lblnarration" Visible="false" runat="server" CssClass="Font_lbl2" Text="Std. Narration :- "></asp:Label>                                           
                                                <asp:Label ID="lblstdnarr" Visible="false" runat="server" CssClass="Font_lbl2" Text="-"></asp:Label></b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblMsg" runat="server" Text="-" Visible="false"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblhelp1" Visible="false" runat="server" Text="-" Font-Names="verdana" Font-Size="Small"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td colspan="4">
                                    <asp:Label ID="Label1" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Blue" Text="Date: "></asp:Label>
                                    <asp:Label ID="lbldate" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text="-"></asp:Label>&nbsp;&nbsp;
                                    <asp:Label ID="Label2" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Blue" Text="Batch Total"></asp:Label>&nbsp;&nbsp;
                                    <asp:Label ID="Label3" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Blue" Text="Debit Rs: "></asp:Label>
                                    <asp:Label ID="lblTDebit" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text="-"></asp:Label>&nbsp;&nbsp;
                                    <asp:Label ID="Label5" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Blue" Text="Credit Rs: "></asp:Label>
                                    <asp:Label ID="lblTCebit" runat="server" Font-Bold="false" Font-Names="verdana" ForeColor="Maroon" Text="-"></asp:Label>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="glTransactions" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false" Height="350px"
                                        Width="90%" AllowFilteringByColumn="false" AllowPaging="false" AutoPostBack="true">
                                        <ClientSettings>
                                            <%--<Resizing AllowColumnResize="True" AllowResizeToFit="true" AllowRowResize="false" ClipCellContentOnResize="true" EnableRealTimeResize="false" ResizeGridOnColumnResize="false" />--%>
                                            <Scrolling AllowScroll="True" SaveScrollPosition="true" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView>
                                            <NoRecordsTemplate>
                                                No Record Found..
                                            </NoRecordsTemplate>
                                            <Columns>
                                                <telerik:GridTemplateColumn UniqueName="Delete" AllowFiltering="False" 
                                                            HeaderStyle-Width="60px" ItemStyle-Width="30px">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lblDelete" runat="server" CausesValidation="false" CssClass="TextBox"
                                                                    Text="Remove" Font-Underline="true" ForeColor="#00008B" OnClick="lblDelete_Click" ToolTip="Click to Remove transaction from grid.">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridBoundColumn HeaderText="S.No" HeaderStyle-Width="80px" DataField="RSN"  Display="false" AllowFiltering="true" FilterControlWidth="60px"  HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ></telerik:GridBoundColumn>                                               
                                                <telerik:GridBoundColumn HeaderText="Account Code" HeaderStyle-Width="80px" DataField="accountcode" ReadOnly="true" AllowFiltering="true" FilterControlWidth="60px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Title" HeaderStyle-Width="150px" DataField="Title" ReadOnly="true" AllowFiltering="true" FilterControlWidth="180px"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Narration" HeaderStyle-Width="250px" DataField="Narration" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Dr./Cr." HeaderStyle-Width="50px" DataField="DrCr" ReadOnly="true" AllowFiltering="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DR.Amount" HeaderStyle-Width="80px" DataField="AmountDr" ReadOnly="true" AllowFiltering="true"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="CR.Amount" HeaderStyle-Width="80px" DataField="AmountCr" ReadOnly="true" AllowFiltering="true"  HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
                <Triggers>
                   <asp:PostBackTrigger ControlID="btnSave" />
                    <asp:AsyncPostBackTrigger ControlID="btnClear" />
                    <asp:PostBackTrigger ControlID="btnPost" />
                    <asp:AsyncPostBackTrigger ControlID="drpAccCode" />                   
                    <asp:AsyncPostBackTrigger ControlID="drpDRCR" />                   
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

