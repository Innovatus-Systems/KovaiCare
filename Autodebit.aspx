<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Autodebit.aspx.cs" Inherits="Autodebit" MasterPageFile="~/CovaiSoft.master" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link href="Css/bootstrap.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .RadGrid th.rgHeader {
            background-image: none;
            background-color: #196F3D;
            color: white;
            font-weight: bold;
        }
    </style>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            font-family: Arial;
        }

        .modal {
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

        .center {
            z-index: 1000;
            margin: 300px auto;
            padding: 10px;
            width: 75px;
            background-color: White;
            border-radius: 10px;
            filter: alpha(opacity=100);
            opacity: 1;
            -moz-opacity: 1;
        }

            .center img {
                height: 75px;
                width: 75px;
            }
    </style>

    <script type="text/javascript">
        function Validate() {



            var result = confirm('Do you want to generate the month end bill?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
                return true;
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
                return false;
            }


        }

        function TaskConfirmMsg2() {

            var result = confirm('Do you want to update?');

            if (result) {

                document.getElementById('<%=CnfResult.ClientID%>').value = "true";
            }
            else {
                document.getElementById('<%=CnfResult.ClientID%>').value = "false";
            }

        }



    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="upnlUpdate" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="main_cnt">
                <div class="first_cnt">
                    <div style="width: 100%; min-height: 500px;">
                        <table style="width: 100%;">

                            <tr>
                                <td align="center">
                                    <asp:HiddenField ID="hbtnRSN" runat="server" />
                                    <asp:Button ID="btnHelp" runat="server" Text="Help?" CssClass="Button" Visible="false" ToolTip="" />
                                    <asp:HiddenField ID="CnfResult" runat="server" />
                                    <asp:LinkButton ID="lnktitle" runat="server" Font-Names="verdana" Font-Size="Medium" ForeColor="Green" Font-Bold="true"></asp:LinkButton>
                                </td>
                                <td>
                                    <telerik:RadWindowManager ID="rwImport" runat="server" Width="450" Height="330px">
                                        <Windows>
                                            <telerik:RadWindow ID="rwEditAutoDebits" Width="450" Height="425px" VisibleOnPageLoad="false" runat="server" OpenerElementID="<%# btnHelp.ClientID  %>" Title="Update Resident Details" Modal="true">
                                                <ContentTemplate>

                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" OnUnload="UpdatePanel_Unload">
                                                        <ContentTemplate>

                                                            <div>
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label14" runat="Server" Text="DoorNo:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblDoorNo" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label15" runat="Server" Text="Name:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblName" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label17" runat="Server" Text="DOB:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lbldob" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label18" runat="Server" Text="Account No:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblaccountno" runat="Server" Text="" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                    </tr>


                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label1" runat="Server" Text="Status:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlStatus" runat="server" Width="200px">
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label44" runat="Server" Text="Maintenance Charge:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtMCharge" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label45" runat="Server" Text="Kitchen Overhead Charge:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtkoc" runat="server"></asp:TextBox>
                                                                        </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label19" runat="Server" Text="Diner Type:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlDType" runat="server">
                                                                                <asp:ListItem Text="Regular" Value="Y"></asp:ListItem>
                                                                                <asp:ListItem Text="Casual" Value="N"></asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>


                                                                    <%-- <tr>
                                                                <td>
                                                                    <asp:Label ID="Label20" runat="Server" Text="Start Date:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadDatePicker ID="dtpstartdate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                        Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="" AutoPostBack="true">
                                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                            CssClass="TextBox" Font-Names="Calibri">
                                                                        </Calendar>
                                                                        <DatePopupButton></DatePopupButton>
                                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                            ForeColor="Black" ReadOnly="true">
                                                                        </DateInput>
                                                                    </telerik:RadDatePicker>
                                                                </td>
                                                            </tr>--%>
                                                                    <%--  <tr>
                                                                <td>
                                                                    <asp:Label ID="Label21" runat="Server" Text="End Date:" ForeColor="Black" Font-Names="verdana"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadDatePicker ID="dtpenddate" runat="server" Culture="English (United Kingdom)" Font-Names="Verdana" Font-Size="Small"
                                                                        Width="160px" CssClass="TextBox" ReadOnly="true" ToolTip="" AutoPostBack="true">
                                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                                                                            CssClass="TextBox" Font-Names="Calibri">
                                                                        </Calendar>
                                                                        <DatePopupButton></DatePopupButton>
                                                                        <DateInput DisplayDateFormat="ddd dd-MMM-yyyy" DateFormat="dd-MMM-yyyy" Font-Names="Verdana" Font-Size="Small"
                                                                            ForeColor="Black" ReadOnly="true">
                                                                        </DateInput>
                                                                    </telerik:RadDatePicker>

                                                                </td>
                                                            </tr>--%>
                                                                    <tr>
                                                                        <td colspan="2" align="center">
                                                                            <asp:Button ID="btnUpdate" OnClientClick="javascript:return TaskConfirmMsg2()" CssClass="btn btn-success" ToolTip="Click here to update the house keeping status" OnClick="btnUpdate_Click" runat="server" Text="Update" ForeColor="White" BackColor="DarkGreen" />

                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:PostBackTrigger ControlID="btnUpdate" />

                                                        </Triggers>
                                                    </asp:UpdatePanel>

                                                </ContentTemplate>

                                            </telerik:RadWindow>
                                        </Windows>
                                    </telerik:RadWindowManager>
                                </td>
                            </tr>

                        </table>

                        <table>
                            <tr style="width: 80%">
                                <td>
                                    <asp:Label ID="Label59" runat="server" Text="For which Resident Account?Search by" CssClass="style3" Font-Names="verdana" Font-Size="Small"></asp:Label><br />
                                    <telerik:RadComboBox ID="cmbResident" runat="server" ForeColor="DarkBlue" AllowCustomText="true"
                                        AutoPostBack="true" Font-Names="Arial" Font-Size="Small" MaxHeight="100px"
                                        Width="350px" ToolTip="Residents with Owner,OwnerAway and Tenant statuses are shown by default. Tick 'Show All' to list residents of all statuses."
                                        RenderMode="Lightweight" MarkFirstMatch="true" Filter="Contains" EmptyMessage="Type Resident Name/Door No. to search">
                                    </telerik:RadComboBox>
                                    &nbsp;&nbsp;
                                    <asp:CheckBox ID="chkAll" runat="server" AutoPostBack="true" Text="Show All" OnCheckedChanged="chkAll_CheckedChanged"
                                                    ToolTip="Residents with Owner,OwnerAway and Tenant statuses are shown by default. Tick 'Show All' to list residents of all statuses." />
                                    &nbsp;&nbsp;
                                    <asp:Button ID="btnGO" Font-Names="Verdana" Height="30px" ToolTip="Click here to generate the month end bill." runat="server" Text="GO" ForeColor="White" BackColor="DarkGreen" Font-Bold="true" OnClick="btnGO_Click" />
                                </td>
                                <td align="right" style="vertical-align: bottom; text-align: left;">
                                    <asp:CheckBox ID="chkstatus" runat="server" Text="Dependents" ToolTip="Show dependents of Owners(Residing and Away) and Tenants only." AutoPostBack="true" OnCheckedChanged="chkstatus_CheckedChanged" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="width: 80%">
                                    <telerik:RadGrid ID="rgAutoDebits" GroupingSettings-CaseSensitive="false" Skin="WebBlue" AllowSorting="true" runat="server" AutoGenerateColumns="false"
                                        OnItemCommand="rgAutoDebits_ItemCommand" Width="99%" AllowFilteringByColumn="true"
                                        AllowPaging="false" OnInit="rgAutoDebits_Init">
                                        <ClientSettings>
                                            <Scrolling AllowScroll="True" FrozenColumnsCount="1" SaveScrollPosition="true" UseStaticHeaders="True" />
                                        </ClientSettings>
                                        <MasterTableView>
                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderText="Edit" AllowFiltering="false" ItemStyle-Width="4%">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lbtnUpdate" ToolTip="Click here to edit the resident auto debit details" runat="server" Text="Edit" CommandName="UpdateRow" ForeColor="Blue" CommandArgument='<%# Eval("RTRSN") %>'></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Door No" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkRSN" runat="server" Text='<%# Eval("RTRSN") %>' CommandArgument='<%# Eval("RTRSN") %>' CommandName="ViewDetails"></asp:LinkButton>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridBoundColumn HeaderText="DoorNo" DataField="DoorNo" ReadOnly="true" AllowFiltering="true" HeaderTooltip="" ItemStyle-Width="5%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Name" DataField="Name" ReadOnly="true" AllowFiltering="true" HeaderTooltip="" ItemStyle-Width="7%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Status" DataField="sdescription" ReadOnly="true" HeaderTooltip="" FilterControlWidth="50%" ItemStyle-Width="6%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="AccountNo" DataField="AccountNo" ReadOnly="true" HeaderTooltip="" FilterControlWidth="50%" ItemStyle-Width="7%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="MMC" DataField="MaintenanceCharge" ReadOnly="true" HeaderTooltip="" FilterControlWidth="50%" ItemStyle-Width="5%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="KOC" DataField="KOC" ReadOnly="true" HeaderTooltip="" FilterControlWidth="50%" ItemStyle-Width="5%"></telerik:GridBoundColumn>
                                                <%-- <telerik:GridBoundColumn HeaderText="Start Date" DataField="Startdate" ReadOnly="true" HeaderTooltip="" AllowFiltering="true" FilterControlWidth="50%" ItemStyle-Width="5%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="End Date" DataField="enddate" ReadOnly="true" HeaderTooltip="" AllowFiltering="true" FilterControlWidth="50%" ItemStyle-Width="5%"></telerik:GridBoundColumn>--%>
                                                <telerik:GridBoundColumn HeaderText="Diner Type" DataField="DType" ReadOnly="true" HeaderTooltip="Diner Type(Regular or Casual)." FilterControlWidth="50%" ItemStyle-Width="5%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Nursing" DataField="NursingAD" ReadOnly="true" HeaderTooltip="Caregiver & Nursing charges" FilterControlWidth="50%" ItemStyle-Width="5%"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="Age" DataField="Age" ReadOnly="true" HeaderTooltip="" FilterControlWidth="50%" ItemStyle-Width="5%" Visible="false"></telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn HeaderText="DOB" DataField="dob" ReadOnly="true" HeaderTooltip="" FilterControlWidth="50%" ItemStyle-Width="5%" Visible="false"></telerik:GridBoundColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>

                        </td>
                            </tr>
                        </table>

                       
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnGO" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="updprog" runat="server" AssociatedUpdatePanelID="upnlUpdate">
        <ProgressTemplate>
            <div class="modal">
                <div class="center">
                    <img alt="" src="loader.gif" />
                    <text>Loading...</text>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
