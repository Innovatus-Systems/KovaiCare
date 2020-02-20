<%@ Page Title="" Language="C#" MasterPageFile="~/CovaiSoft.master" AutoEventWireup="true" CodeFile="SendSmsView.aspx.cs" Inherits="SendSmsView" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="upnlMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>

            <div class="main_cnt">
                <div class="first_cnt" style="min-height: 450px">
                    <table style="width: 100%;">
                        <tr>

                            <td align="center">
                                <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                            </td>

                        </tr>

                    </table>
                    <table style="width: 80%" align="center">

                        <tr>

                            <td align="center" style="width: 80%">
                                <telerik:RadGrid ID="gvSendSMS" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server"
                                    AutoGenerateColumns="false" OnItemCommand="gvSendSMS_ItemCommand"
                                    AllowFilteringByColumn="true" AllowPaging="false" OnInit="gvSendSMS_Init">
                                    <ClientSettings>
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />


                                    </ClientSettings>
                                    <MasterTableView>

                                        <CommandItemSettings ShowExportToCsvButton="true" />
                                        <Columns>
                                            <telerik:GridBoundColumn HeaderText="RSN" HeaderStyle-Width="70px" DataField="RSN" ReadOnly="true" FilterControlWidth="50px" Display="false"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Door No." HeaderStyle-Width="100px" DataField="DoorNo" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Name" HeaderStyle-Width="120px" DataField="Name" ReadOnly="true" FilterControlWidth="120px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Sent To" HeaderStyle-Width="100px" DataField="MobileNo" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="SMS Text" DataField="SMSText" ReadOnly="true" FilterControlWidth="120px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Status" HeaderStyle-Width="70px" DataField="Status" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="Date & Time" HeaderStyle-Width="120px" DataField="CreatedOn" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderText="By" HeaderStyle-Width="70px" DataField="CreatedBy" ReadOnly="true" FilterControlWidth="50px"></telerik:GridBoundColumn>

                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>


                        </tr>
                        <tr>
                            <td align="right" style="width: 90%;">

                                <asp:Button ID="BtnExcelExport" AutoPostBack="true" runat="server" CssClass="btn btn-success" Font-Bold="true" Text="Export to Excel" OnClick="BtnExcelExport_Click" ForeColor="White" ToolTip="Click here to export grid details in excel." />
                            </td>
                        </tr>

                    </table>
                    <br />
                    <br />
                    <table align="center">
                        <tr>
                            <td>
                                <asp:Label ID="Label1" runat="server" Text="Send New SMS" Font-Size="Medium" ForeColor="#3333ff" Font-Bold="true"></asp:Label>
                            </td>
                            <%-- <td align="Left">
                                
                            </td>--%>
                        </tr>

                        <tr>
                            <td>
                                <asp:Label ID="lblMobilNo" runat="server" Text="Sent To" Font-Bold="true"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMobilNo" runat="server" CssClass="form-controlForResidentAdd rightAlign" Width="170px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <asp:Label ID="lblText" runat="server" Text="Text:" Font-Bold="true"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtText" runat="server" CssClass="form-controlForResidentAdd" TextMode="MultiLine" Width="300px"></asp:TextBox>
                            </td>
                            <%--<td style="vertical-align: top;">--%>

                            <%-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>

                            <%--</td>--%>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" Text="Send" OnClick="btnSave_Click" CssClass="btn btn-success" />
                                <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CssClass="btn btn-danger" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

