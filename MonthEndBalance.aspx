<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MonthEndBalance.aspx.cs" Inherits="MonthEndBalance" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery-1.8.2.js"></script>

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="Css/sb-admin.css" rel="stylesheet" type="text/css" />
    <link href="CSS/CovaiSoft.css" rel="stylesheet" />
    <%-- <link href="CSS/MenuCSS.css" rel="stylesheet" />--%>
    <style>
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
    <script type="text/javascript">


        function SaveValidate() {
            var vali = "";

            vali += AccountCode();
            vali += AccountName();
            vali += AccountGroup();


            if (vali == "") {
                var result = confirm('Do you want to save?');

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
                alert(vali);
                return false;
            }
        }

        function UpdateValidate() {
            var vali = "";


            vali += AccountCode();
            vali += AccountName();
            vali += AccountGroup();


            if (vali == "") {

                var result = confirm('Do you want to update?');

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
                alert(vali);
                return false;
            }
        }








        <%--    function ShowHide()
        {
           
            if (document.getElementById('ShowHideDiv').style.display == '') {
              
                document.getElementById('ShowHideDiv').style.display = 'none';
                document.getElementById('<%= LnkSH.ClientID %>').innerText = 'Add Account Code';
            }
            else {
               
                document.getElementById('ShowHideDiv').style.display = '';
                document.getElementById('<%= LnkSH.ClientID %>').innerText = 'Hide';
                
            }
            return false;

            button.onclick = function () {
                var div = document.getElementById('ShowHideDiv');
                alert(div);
                if (div.style.display !== 'none') {
                    div.style.display = 'none';
                    document.getElementById('<%= LnkSH.ClientID %>').value = "Add Account Code";
                    
                }
                else {
                    div.style.display = 'block';
                    document.getElementById('<%= LnkSH.ClientID %>').value = "Hide";
                }
            };
        }--%>
        <%-- function Sitevali()
         {
             var Site = document.getElementById('<%= ddlSite.ClientID %>').value;

             console.log(Site);

             if (Site == "0")
             {
                 return "Please select the site" + "\n";
             }
             else {
                 return "";
             }
         }--%>

        
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="main_cnt">
                <div class="first_cnt" style="min-height: 450px">
                    <div style="font-family: Verdana; font-size: small;">
                        <asp:HiddenField ID="hbtnRSN" runat="server" />
                        <asp:HiddenField ID="CnfResult" runat="server" />

                        <table style="width: 100%;">
                            <tr>
                                <td align="center">
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>

                        <table style="width: 85%" align="center">

                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:RadioButtonList ID="rbTxnSel" runat="server" RepeatDirection="Horizontal" AutoPostBack="true" OnSelectedIndexChanged="rbTxnSel_SelectedIndexChanged">
                                                    <asp:ListItem Text="Resident Ledger" Value="Sel1"  />
                                                    <asp:ListItem Text="General Ledger" Value="Sel2"  />
                                                    <asp:ListItem Text="Deposit Ledger" Value="Sel3"   />
                                                </asp:RadioButtonList>
                                            </td>
                                            <td style="width: 50px"></td>
                                            <td>
                                                <asp:Label ID="Label4" runat="Server" Text="For the account : " ForeColor=" Black " Font-Names="Verdana" Font-Size="Small"></asp:Label></td>
                                            <td>
                                                <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                                    Font-Names="Arial" Font-Size="Small" AutoPostBack="true"
                                                    Width="200px" ToolTip="" OnSelectedIndexChanged="cmbResident_SelectedIndexChanged"
                                                    RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label59" runat="server" Text="Month & Year : " CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label></td>
                                            <td>
                                                <asp:DropDownList ID="drpYYMM" AutoPostBack="true" Font-Names="Arial" Font-Size="Small" Height="30px" Width="100px" runat="server" ToolTip="" OnSelectedIndexChanged="drpYYMM_SelectedIndexChanged"></asp:DropDownList>

                                            </td>

                                        </tr>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                <td align="left">
                                    <telerik:RadGrid ID="gvMonthEndBal" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                        AutoGenerateColumns="false" OnItemCommand="ReportList_ItemCommand" AllowFilteringByColumn="true" AllowPaging="false">
                                        <%-- OnInit="gvAccountMaster_Init">--%>
                                        <ClientSettings>
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                        </ClientSettings>
                                        <MasterTableView>
                                            <CommandItemSettings ShowExportToCsvButton="true" />
                                            <Columns>
                                                <telerik:GridBoundColumn HeaderText="Month & Year" HeaderStyle-Width="50px" DataField="MonthYear" ReadOnly="true" FilterControlWidth="60px" AllowFiltering="true" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Account Code" HeaderStyle-Width="120px" DataField="AccountCode" ReadOnly="true" FilterControlWidth="150px" AllowFiltering="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Account Name" HeaderStyle-Width="180px" DataField="AccountName" ReadOnly="true" FilterControlWidth="250px" AllowFiltering="true"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Opening Balance" HeaderStyle-Width="60px" DataField="OpeningBalance" ReadOnly="true" FilterControlWidth="65px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" AllowFiltering="true" ItemStyle-Wrap="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Closing Balance" HeaderStyle-Width="60px" DataField="ClosingBalance" ReadOnly="true" FilterControlWidth="65px" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" AllowFiltering="true"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>

                            <tr>
                                <table style="width: 85%" align="center">
                                    <tr>

                                        <td align="left">
                                            <asp:Button ID="BtnExcelExport" AutoPostBack="true" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                                             &nbsp;&nbsp;
                                            <asp:Label ID="lblNegExist" runat="server" Text="Credit balance exists" ForeColor="Red" Font-Names="Verdana" Font-Size="Small" Font-Bold="true" Visible="false"></asp:Label>
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblLCnt" runat="server" Text="Count :" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true" Visible="true"></asp:Label>
                                            <asp:Label ID="lblCnt" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true" Visible="true"></asp:Label>

                                            &nbsp;&nbsp; &nbsp;&nbsp; 
                                            <asp:Label ID="lblLOBTot" runat="server" Text="Opening Balance (Total) :" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true" Visible="true"></asp:Label>
                                            <asp:Label ID="lblOBTot" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true" Visible="true"></asp:Label>
                                              &nbsp;&nbsp;
                                            <asp:Label ID="lblLCBTot" runat="server" Text="Closing Balance (Total) :" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true" Visible="true"></asp:Label>
                                            <asp:Label ID="lblCBTot" runat="server" Text="-" ForeColor="Maroon" Font-Names="Verdana" Font-Size="Small" Font-Bold="true" Visible="true"></asp:Label>
                                         
                                        </td>

                                    </tr>
                                </table>
                            </tr>
                        </table>
                        <br />
                        <br />
                    </div>
                </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="BtnExcelExport" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upnlMain" runat="server">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <asp:Label ID="lblUpdateprogress" runat="server" Text="Please wait..."></asp:Label><br />
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Loader.gif" />
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>

</asp:Content>

